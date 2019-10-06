#lang racket
(require "utils.rkt")
(provide (all-defined-out))
;;
;; keywords:
;;
;;   RECUR: refer to the same function with new arguments
;;   LAT: list of atoms
;;
;;   (cond ...) asks questions
;;   (lambda ...) creates a function
;;   (define ...) give it a name
;;
;;   lat?    :: List -> Boolean
;;   member? :: Atom -> LAT -> Boolean
;;
;;   lat  ::= null
;;        |   (a . lat)
;;
(define (lat? l)
  (cond [(null? l) #t]
        [else (and (atom? (car l))
                   (lat? (cdr l)))])
  )

(define (member? a lat)
  (cond [(null? lat) #f]
        [else (if (eq? (car lat) a)
                  #t
                  (member? a (cdr lat)))]))
