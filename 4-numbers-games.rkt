#lang racket
(require "utils.rkt")
(provide (all-defined-out))

;;
;; note:
;;
;;   tuple :== null | (num . tuple)
;;
;;   =n    : for numbers
;;   eq?   : for atoms
;;   eqan? : for numbers or atoms

;;  zero? :: { 0, 1, 2, ... } -> Boolean
;;  add1  :: { 0, 1, 2, ... } -> { 0, 1, 2, ... }
;;  sub1  :: { 1, 2, 3, ... } -> { 0, 1, 2, ... }
(define (zero? n) (= n 0))
(define (add1 n) (+ n 1))
(define (sub1 n) (- n 1))

;;  plus  :: N -> N -> N
;;  minus :: N -> N -> N
;;  times :: N -> N -> N
;;  gt    :: N -> N -> Boolean
;;  lt    :: N -> N -> Boolean
;;  =n    :: N -> N -> Boolean
;;  pow   :: N -> N -> N
;;  div   :: N -> N -> N

(define (plus n m)
  (cond [(zero? m) n]
        [else (add1 (plus n (sub1 m)))]))

(define (minus n m)
  (cond [(zero? m) n]
        [else (sub1 (minus n (sub1 m)))]))

(define (times n m)
  (cond [(zero? m) 0]
        [else (plus n
                    (times n (sub1 m)))]))

(define (gt n m)
  (cond [(and (zero? n) (zero? m)) #f]
        [(zero? m) #t]
        [(zero? n) #f]
        [else (gt (sub1 n) (sub1 m))]))

(define (lt n m)
  (cond [(and (zero? n) (zero? m)) #f]
        [(zero? m) #f]
        [(zero? n) #t]
        [else (lt (sub1 n) (sub1 m))]))

(define (=n n m)
  (cond [(and (zero? n) (zero? m)) #t]
        [(zero? m) #f]
        [(zero? n) #f]
        [else (=n (sub1 n) (sub1 m))]))

(define (pow n m)
  (cond [(zero? m) 1]
        [else (times n
                     (pow n (sub1 m)))]))

(define (div n m)
  (cond [(and (zero? n) (zero? m)) #f]
        [(zero? m) #f]
        [(zero? n) 0]
        [else (if (lt n m)
                  0
                  (add1 (div (minus n m) m)))]))

;; tup?  :: List -> Boolean
(define (tup? l)
  (cond [(null? l) #t]
        [else (and (number? (car l))
                   (tup? (cdr l)))]))

;; addtup :: Tuple -> N
(define (addtup tup)
  (cond [(null? tup) 0]
        [else (plus (car tup)
                    (addtup (cdr tup)))]))

;; tup+ :: Tuple -> Tuple -> Tuple
(define (tup+ tup1 tup2)
  (cond [(and (null? tup1) (null? tup2)) '()]
        [(null? tup2) tup1]
        [(null? tup1) tup2]
        [else (cons (plus (car tup1)
                          (car tup2))
                    (tup+ (cdr tup1) (cdr tup2)))]))

;; length :: LAT -> N
(define (length lat)
  (cond [(null? lat) 0]
        [else (add1 (length (cdr lat)))]))

;; pick :: N -> LAT -> Atom
(define (pick0 n lat)
  (cond [(and (zero? n) (null? lat)) #f]
        [(null? lat) #f]
        [(zero? n) (car lat)]
        [else (pick0 (sub1 n) (cdr lat))]))

(define (pick n lat) (pick0 (sub1 n) lat))

;; rempick :: N -> LAT -> Atom
(define (rempick0 n lat)
  (cond [(and (zero? n) (null? lat)) #f]
        [(null? lat) #f]
        [(zero? n) (cdr lat)]
        [else (cons (car lat)
                    (rempick0 (sub1 n) (cdr lat)))]))

(define (rempick n lat) (rempick0 (sub1 n) lat))

;; no-nums  :: LAT -> LAT
;; all-nums :: LAT -> LAT
(define (no-nums lat)
  (filter (lambda (x) (not (number? x)))
          lat))
(define (all-nums lat)
  (filter number?
          lat))

;; eqan? :: Atom -> Boolean
(define (eqan? x y)
  (cond [(and (number? x) (number? y)) (=n x y)]
        [(or (number? x) (number? y)) #f]
        [else (eq? x y)]))

;; occur :: Atom -> LAT -> N
(define (occur a lat)
  (cond [(null? lat) 0]
        [else (if (eqan? (car lat) a)
                  (add1 (occur a (cdr lat)))
                  (occur a (cdr lat)))]))

;; one? :: N -> Boolean
(define one? (lambda (x) (=n x 1)))
