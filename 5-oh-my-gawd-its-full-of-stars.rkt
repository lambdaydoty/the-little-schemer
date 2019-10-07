#lang racket
(require "utils.rkt")
(require "3-cons-the-magnificent.rkt")
(require "4-numbers-games.rkt")
(provide (all-defined-out))

;;
;;   list  ::= ( s-exp* )
;;   s-exp ::= atom | list
;;
;; note) We have 2 ways to ask questions toward a list:
;;
;;       A) By  list  ::= null | (s-exp . list)
;;              s-exp ::= atom | list
;;
;;          We can ask 1) (null? l)
;;                     2) (atom? (car l))
;;                     3) else... a `carable` list
;;
;;       B) By  list  ::= ( s-exp* )
;;              s-exp ::= atom | list
;;
;;          We can define two sub-functions:
;;
;;             for-list... use map over its s-exp element
;;             for-s-exp.. ask two questions: 1) (atom? s)
;;                                            2) else... a list
;;
;; note) equalities:
;;
;;       A) eq?     : Symbol -> Symbol -> Boolean
;;       B) =       : N      -> N      -> Boolean
;;       C) eqan?   : Atom   -> Atom   -> Boolean
;;       D) eqlist? : List   -> List   -> Boolean
;;       E) equal?  : S-exp  -> S-exp  -> Boolean
;;

;; rember* :: Atom -> List -> List
(define (rember* a lst)
  (define (not-a? x) (not (eq? a x)))
  (define (for-list l) (map for-s-exp
                            (filter not-a? l)))
  (define (for-s-exp s)
    (cond [(atom? s) s]
          [else (for-list s)]))
  (for-list lst))

;; insertR* :: Atom -> Atom -> List -> List
(define (insertR* new old lst)
  (define (for-list l) (map for-s-exp (multiinsertR new old l)))
  (define (for-s-exp s)
    (cond [(atom? s) s]
          [else (for-list s)]))
  (for-list lst))

;; occur* :: Atom -> List -> N
(define (occur* a lst)
  (define (for-list l) (+ (occur a l)
                          (addtup (map for-s-exp l))))
  (define (for-s-exp s)
    (cond [(atom? s) 0]
          [else (for-list s)]))
  (for-list lst))

;; subst* :: Atom -> Atom -> List -> List
(define (subst* new old lst)
  (define (for-list l) (subst new old (map for-s-exp l)))
  (define (for-s-exp s)
    (cond [(atom? s) s]
          [else (for-list s)]))
  (for-list lst))

;; insertL* :: Atom -> Atom -> List -> List
(define (insertL* new old lst)
  (define (for-list l) (map for-s-exp (multiinsertL new old l)))
  (define (for-s-exp s)
    (cond [(atom? s) s]
          [else (for-list s)]))
  (for-list lst))

;; member* :: Atom -> List -> Boolean
(define (member* a lst)
  (cond [(null? lst) #f]
        [(atom? (car lst)) (or (eq? (car lst) a)
                               (member* a (cdr lst)))]
        [else (or (member* a (car lst))
                  (member* a (cdr lst)))]))

;; leftmost :: List -> Atom
(define (leftmost lst)
  (define (for-list l) (for-s-exp (car l)))
  (define (for-s-exp s)
    (cond [(atom? s) s]
          [else (leftmost s)]))
  (for-list lst))

;; eqlist? :: List -> List -> Boolean
(define (eqlist? l1 l2)
  (cond [(and (null? l1) (null? l2)) #t]
        [(or (null? l1) (null? l2)) #f]
        [else (let ([x1 (car l1)]
                    [y1 (cdr l1)]
                    [x2 (car l2)]
                    [y2 (cdr l2)])
                (and (equal? x1 x2)
                     (eqlist? y1 y2)))]))

;; equal? :: S-exp -> S-exp -> Boolean
(define (equal? s1 s2)
  (cond [(and (atom? s1) (atom? s2)) (eq? s1 s2)]
        [(or (atom? s1) (atom? s2)) #f]
        [else (eqlist? s1 s2)]))
