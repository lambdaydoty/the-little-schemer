#lang racket
(require "utils.rkt")
(require "4-numbers-games.rkt")
(require "7-friends-and-relations.rkt")
(provide (all-defined-out))

;;
;; Note:
;;       PARTIAL FUNCTIONS
;;       TOTAL FUNCTIONS
;;

;; looking :: Atom -> LAT -> Boolean
;; looking is a partial function
(define looking
  (λ (a lat)
    (define keep-looking
      (λ (a symbol-or-number lat)
        (cond [(symbol? symbol-or-number) (eq? symbol-or-number a)]
              [else (keep-looking a (pick symbol-or-number lat) lat)])))
    (keep-looking a (pick 1 lat) lat)))

;; eternity :: f -> ?
;; eternity is a (or the most) partial function
(define eternity
  (λ (x)
    (eternity x)))

;; shift :: Pair -> List
;; shift only rearranges the pair, both the result and the argument of shift have
;;   the same number of atoms.
(define shift
  (λ (pair)
    (define first-of-first caar)
    (define second-of-first cadar)
    (define second cadr)
    (list (first-of-first pair)
          (list (second-of-first pair)
                (second pair)))))

;; align :: Pair|Atom -> List
(define align
  (λ (pair-or-atom)
    (define first car)
    (define second cadr)
    (define build list)
    (define a-pair? pair?)
    (cond [(atom? pair-or-atom) pair-or-atom]
          [(a-pair? (first pair-or-atom)) (align (shift pair-or-atom))]
          [else (build (first pair-or-atom)
                       (align (second pair-or-atom)))])))

;; length*
(define length*
  (λ (pair-or-atom)
    (cond [(atom? pair-or-atom) 1]
          [else (+ (length* (first pair-or-atom))
                   (length* (second pair-or-atom)))])))

;; weight*
(define weight*
  (λ (pair-or-atom)
    (cond [(atom? pair-or-atom) 1]
          [else (+ (* 2 (weight* (first pair-or-atom)))
                   (weight* (second pair-or-atom)))])))

;; shuffle
;; shuffle is a partial function
(define shuffle
  (λ (pair-or-atom)
    (define first car)
    (define second cadr)
    (define build list)
    (define a-pair? pair?)
    (cond [(atom? pair-or-atom) pair-or-atom]
          [(a-pair? (first pair-or-atom)) (shuffle (reverse-pair pair-or-atom))]
          [else (build (first pair-or-atom)
                       (shuffle (second pair-or-atom)))])))

;; the 3n+1
;; totality unknown function
(define C
  (λ (n)
    (cond [(one? n) 1]
          [else (cond [(even? n) (C (/ n 2))]
                      [else (C (add1 (* n 3)))])])))

;; the Ackermann
;; the extremely slow growing function
;; total not primitive recursive
(define A
  (λ (n m)
    (cond [(zero? n) (add1 m)]
          [(zero? m) (A (sub1 n) 1)]
          [else (A (sub1 n)
                   (A n (sub1 m)))])))

;; Y
(define Y
  (λ (f)
    (λ (g)
      (((λ (x) (f (λ (y) ((x x) y))))
        (λ (x) (f (λ (y) ((x x) y))))) g))))

(define Y
  (λ (f)
    ((λ (x) (f (x x)))
     (λ (x) (f (x x))))))

(define length0
  (λ (g)
    (λ (l)
      (cond [(null? l) 0]
            [else (add1 (g (cdr l)))]))))


