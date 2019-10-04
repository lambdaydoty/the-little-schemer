#lang racket
(provide (all-defined-out))

(define (atom? x)
  (and (not (pair? x))
       (not (null? x))))

(define (s-exp? x)
  (or (atom? x)
      (list? x)))

(define (listing . l)
  (begin
    (for-each (lambda (x) (printf "~a " x)) l)
    (newline)
    ))

