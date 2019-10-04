#lang racket
(require "utils.rkt")
;;
;; keywords:
;;
;;   RECUR: refer to the same function with new arguments
;;
;;   (cond ...) asks questions
;;   (lambda ...) creates a function
;;   (define ...) give it a name
;;
;;   lat?    List -> Boolean
;;   member? LAT -> Boolean   (LAT: List-of-Atoms)
;;

(define (lat? l)
  (cond [(null? l) #t]
        [else (and (atom? (car l))
                   (lat? (cdr l)))])
  )

(define (member? a lat)
  (cond [(null? lat) #f]
        [(eq? (car lat) a) #t]
        [else (member? a (cdr lat))]))

#| LIST OF ATOMS |#
(listing
  (lat? '(Jack Sprat could eat no chicken fat))
  (lat? '((Jack) Sprat could eat no chicken fat))
  (lat? '())
  (lat? '(bacon and eggs))
  (lat? '(bacon (and eggs)))
  )

(listing
  (or (null? '()) (atom? '(d e f g)))
  (or (null? '(a b c)) (null? '()))
  (or (null? '(a b c)) (null? '(atom)))
  )

#| MEMBER? |#
(listing
  (member? 'tea '(coffee tea or milk))
  (member? 'poached '(fried eggs and scrambled eggs))
  )

(listing
  (member? 'meat '(meat gravy))
  (member? 'meat '(and meat gravy))
  (member? 'meat '(potatoes and meat gravy))
  (member? 'meat '(mashed potatoes and meat gravy))
  (member? 'liver '(bagels and lox))
  )
