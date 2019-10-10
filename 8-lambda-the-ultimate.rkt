#lang racket
(require "utils.rkt")
(require "2-do-it-again.rkt")
(require "3-cons-the-magnificent.rkt")
(require "6-shadows.rkt")
(provide (all-defined-out))

(require racket/trace)

;;
;; Note:
;;   =     : Numbers
;;  equal? : S-expressions
;;  eq?    : Symbols
;;
;; Note:
;;        CONTINUTATION / COLLECTOR
;;

;; rember-f :: (Atom -> Atom -> Boolean) -> Atom -> List -> List
(define (rember-f test? a l)
  (cond [(null? l) '()]
        [else (if (test? (car l) a)
                  (cdr l)
                  (cons (car l) (rember-f test? a (cdr l))))]))

;; eq?-c :: Symbol -> Symbol -> Boolean
(define eq?-c
  (λ (a)
    (λ (x)
      (eq? x a))))


;; insertL-f, insert-R :: (S -> S -> Boolean) -> S -> S -> List -> List
(define insertL-f
  (λ (test?)
    (λ (new old l)
      (cond [(null? l) '()]
            [else (if (test? (car l) old)
                      (cons new (cons old (cdr l)))
                      (cons (car l) ((insertL-f test?) new old (cdr l))))]))))
(define insertR-f
  (λ (test?)
    (λ (new old l)
      (cond [(null? l) '()]
            [else (if (test? (car l) old)
                      (cons old (cons new (cdr l)))
                      (cons (car l) ((insertR-f test?) new old (cdr l))))]))))

;; insert-g :: (S -> S -> List -> List) -> (S -> S -> List -> List)
(define insert-g
  (λ (g)
    (λ (new old l)
      (cond [(null? l) '()]
            [else (if (eq? (car l) old)
                      (g new old (cdr l))
                      (cons (car l) ((insert-g g) new old (cdr l))))]))))

(define insertL-insertR-subst-rember
  (λ ()
    (define insertL (insert-g (λ (new old l) (cons new (cons old l)))))
    (define insertR (insert-g (λ (new old l) (cons old (cons new l)))))
    (define subst (insert-g (λ (new old l) (cons new l))))
    (define rember (λ (a l) ((insert-g (λ (new old l) l)) #f a l)))
    (list insertL insertR subst rember)))

;; atom-to-function :: Atom -> (Number -> Number -> Number)
(define atom-to-function
  (λ (x)
    (cond [(eq? x '+) +]
          [(eq? x '×) *]
          [(eq? x '↑) expt]
          [else #f])))
(define value
  (λ (nexp)
    (cond [(atom? nexp) nexp]
          [else ((atom-to-function (operator nexp))
                 (value (1st-sub-exp nexp))
                 (value (2nd-sub-exp nexp)))])))

;; multiremberT :: (S-exp -> Boolean) -> LAT -> LAT
(define multiremberT
  (λ (test? lat)
    (cond [(null? lat) '()]
          [else (if (test? (car lat))
                    (multiremberT test? (cdr lat))
                    (cons (car lat)
                          (multiremberT test? (cdr lat))))])))

;; multirember&co :: Atom -> LAT -> (LAT -> LAT -> ?)
;;                                  ^^^^^^^^^^^^^^^^^ the CONTINUATION!
(define multirember&co
  (λ (a lat col)
    (cond [(null? lat) (col '() '())]
          [else (if (eq? (car lat) a)
                    (multirember&co a
                                    (cdr lat)
                                    (λ (newlat seen)
                                      (col newlat
                                           (cons (car lat) seen))))
                    (multirember&co a
                                    (cdr lat)
                                    (λ (newlat seen)
                                      (col (cons (car lat) newlat)
                                           seen))))])))

;; multiinsertLR&co :: Atom -> Atom -> Atom -> LAT -> (LAT -> LAT -> ?)
;; hint: replace the verbose
;;         (cons x (cons y rest))
;;       by
;;         (list* x y rest)
(define multiinsertLR&co
  (λ (new oldL oldR lat col)
    #| (trace col) |#
    (cond [(null? lat) (col '() 0 0)]
          [else (cond [(eq? (car lat) oldL) (multiinsertLR&co new oldL oldR (cdr lat)
                                                              (λ (newlat L R) (col (list* new (car lat) newlat)
                                                                                   (add1 L)
                                                                                   R)))]
                      [(eq? (car lat) oldR) (multiinsertLR&co new oldL oldR (cdr lat)
                                                              (λ (newlat L R) (col (list* (car lat) new newlat)
                                                                                   L
                                                                                   (add1 R))))]
                      [else (multiinsertLR&co new oldL oldR (cdr lat)
                                              (λ (newlat L R) (col (list* (car lat) newlat)
                                                                        L
                                                                        R)))])])))
#| (trace multiinsertLR&co) |#

;; evens-only*&co :: List ->
(define evens-only*&co
  (λ (l col)
    (cond [(null? l) (col '() 1 0)]
          [(atom? (car l)) (if (even? (car l))
                               (evens-only*&co (cdr l) (λ (evens p s) (col (list* (car l) evens)
                                                                           (* (car l) p)
                                                                           s)))
                               (evens-only*&co (cdr l) (λ (evens p s) (col evens
                                                                           p
                                                                           (+ (car l) s)))))]
          [else (evens-only*&co (car l) (λ (evens p s) ;; <--------------------------------- Amazing!
                                          (evens-only*&co (cdr l)
                                                          (λ (evens2 p2 s2)
                                                            (col (list* evens evens2)
                                                                 (* p p2)
                                                                 (+ s s2))))))])))
