#lang racket
(require "utils.rkt")
(require "2-do-it-again.rkt")
(require "3-cons-the-magnificent.rkt")
(provide (all-defined-out))

;;
;;      set ::= ( atom* )
;;
;; Note: For function over two sets like
;;       (f set1 set2)
;;       we could simply recur over set1
;;

;; set? :: LAT -> Boolean
(define (set? lat)
  (cond [(null? lat) #t]
        [else (and (not (member? (car lat) (cdr lat)))
                   (set? (cdr lat)))]))

;; makeset :: LAT -> Set
(define (makeset lat)
  (cond [(null? lat) '()]
        [else (cons (car lat)
                    (makeset (multirember (car lat) (cdr lat))))]))

;; subset? :: Set -> Set -> Boolean
(define (subset? set1 set2)
  (cond [(and (null? set1)) #t]
        [else (and (member? (car set1) set2)
                   (subset? (cdr set1) set2))]))

;; eqset? :: Set -> Set -> Boolean
(define (eqset? set1 set2)
  (and (subset? set1 set2)
       (subset? set2 set1)))

;; intersect? :: Set -> Set -> Boolean
(define (intersect? set1 set2)
  (cond [(null? set1) #f]
        [else (or (member? (car set1) set2)
                  (intersect? (cdr set1) set2))]))

;; intersect :: Set -> Set -> Set
(define (intersect set1 set2)
  (cond [(null? set1) '()]
        [else (if (member? (car set1) set2)
                  (cons (car set1) (intersect (cdr set1) set2))
                  (intersect (cdr set1) set2))]))

;; union :: Set -> Set -> Set
(define (union set1 set2)
  (cond [(null? set1) set2]
        [else (if (member? (car set1) set2)
                  (union (cdr set1) set2)
                  (cons (car set1) (union (cdr set1) set2)))]))

;; diff :: Set -> Set -> Set
(define (diff set1 set2)
  (cond [(null? set1) '()]
        [else (if (member? (car set1) set2)
                  (diff (cdr set1) set2)
                  (cons (car set1) (diff (cdr set1) set2)))]))

;; intersectall :: ( Set* ) -> Set
(define (intersectall l-set)
  (define (reduce op l)
    (cond [(null? (cdr l)) (car l)] ; only one left
          [else (op (car l)
                    (reduce op (cdr l)))]))
  (reduce intersect l-set))

;; a-pair? :: S-exp -> Boolean
(define (a-pair? x)
  (cond [(atom? x) #t]
        [(null? x) #f]
        [(null? (cdr x)) #f]
        [(null? (cddr x) )#t]
        [else #f]))

;; first  :: Pair -> S-exp
;; second :: Pair -> S-exp
;; third  :: Pair -> S-exp
;; build  :: S-exp -> S-exp -> Pair
(define (build s1 s2) (cons s1 (cons s2 '())))
(define (first p) (car p))
(define (second p) (cadr p))
(define (third p) (caddr p))

;; fun?  :: Relation -> Boolean
(define (fun? rel) (set? (firsts rel)))

;; revrel :: Relation -> Relation
(define (reverse-pair pair)
  (build (second pair)
         (first pair)))
(define (revrel rel)
  (cond [(null? rel) '()]
        [else (cons (reverse-pair (car rel))
                    (revrel (cdr rel)))]))

;; fullfun? :: Function -> Boolean
;; one-to-one? :: Function -> Boolean
(define (fullfun? fun) (set? (seconds fun)))
(define (one-to-one? fun) (fun? (revrel fun)))

