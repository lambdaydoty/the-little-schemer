#lang racket
(require "utils.rkt")
(provide (all-defined-out))

;;
;; Note:
;;   A Style between:
;;
;;   A)
;;     (define (rember a lat)
;;        (cond [(null? lat) ...]
;;              [else (cond ...)]))
;;
;;   B)
;;     (define (rember a lat)
;;        (cond [(null? lat) ...]
;;              [(eq ...)]
;;              [else ...]))
;;
;;   The benefit of A) is that `the function's structure
;;   coincide with its arguemnt's structure`!
;;
;;      lat ::= null
;;          |   (a . lat)
;;

;;   rember  :: Atom -> LAT -> LAT  # remove the first occurrence of the atom
;;   insertR :: Atom -> Atom -> LAT -> LAT
;;   insertL :: Atom -> Atom -> LAT -> LAT
;;   subst   :: Atom -> Atom -> LAT -> LAT
;;   subst2  :: Atom -> Atom -> Atom -> LAT -> LAT
;;
;;   firsts   :: List -> List
;;   seconds  :: List -> List

(define (rember a lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) a) (cdr lat)]
        [else (cons (car lat)
                    (rember a (cdr lat)))]))

(define (firsts l)
  (cond [(null? l) '()]
        [else (cons (car (car l))
                    (firsts (cdr l)))]))

(define (seconds l) (map cadr l))

(define (insertR new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons old
                                     (cons new (cdr lat)))]
        [else (cons (car lat) (insertR new old (cdr lat)))]))

(define (insertL new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                     (cons old (cdr lat)))]
        [else (cons (car lat) (insertL new old (cdr lat)))]))

(define (subst new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new (cdr lat))]
        [else (cons (car lat) (subst new old (cdr lat)))]))

(define (subst2 new o1 o2 lat)
  (cond [(null? lat) '()]
        [(or (eq? (car lat) o1)
             (eq? (car lat) o2)) (cons new (cdr lat))]
        [else (cons (car lat) (subst2 new o1 o2 (cdr lat)))]))

;;   multirember  :: Atom -> LAT -> LAT
;;   multiinsertR :: Atom -> Atom -> LAT -> LAT
;;   multiinsertL :: Atom -> Atom -> LAT -> LAT
;;   multisubst   :: Atom -> Atom -> LAT -> LAT
;;   subst2  :: Atom -> Atom -> Atom -> LAT -> LAT

(define (multirember a lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) a) (multirember a (cdr lat))]
        [else (cons (car lat)
                    (multirember a (cdr lat)))]))

(define (multiinsertR new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons (car lat)
                                   (cons new (multiinsertR new old (cdr lat))))]
        [else (cons (car lat) (multiinsertR new old (cdr lat)))]))

(define (multiinsertL new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                   (cons (car lat) (multiinsertL new old (cdr lat))))]
        [else (cons (car lat) (multiinsertL new old (cdr lat)))]))

(define (multisubst new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                   (multisubst new old (cdr lat)))]
        [else (cons (car lat) (multisubst new old (cdr lat)))]))
