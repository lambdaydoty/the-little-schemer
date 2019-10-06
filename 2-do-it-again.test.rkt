#lang racket
(require rackunit "2-do-it-again.rkt")
(require "utils.rkt")

#| lat? :: List -> Boolean |#
(check-equal? (lat? '(Jack Sprat could eat no chicken fat)) #t)
(check-equal? (lat? '((Jack) Sprat could eat no chicken fat)) #f)
(check-equal? (lat? '()) #t)
(check-equal? (lat? '(bacon and eggs)) #t)
(check-equal? (lat? '(bacon (and eggs))) #f)

#| member? :: Atom -> LAT -> Boolean |#
(check-equal? (member? 'tea '(coffee tea or milk)) #t)
(check-equal? (member? 'poached '(fried eggs and scrambled eggs)) #f)
(check-equal? (member? 'meat '(meat gravy)) #t)
(check-equal? (member? 'meat '(and meat gravy)) #t)
(check-equal? (member? 'meat '(potatoes and meat gravy)) #t)
(check-equal? (member? 'meat '(mashed potatoes and meat gravy)) #t)
(check-equal? (member? 'liver '(bagels and lox)) #f)

#| or |#
(check-equal? (or (null? '())
                  (atom? '(d e f g))) #t)
(check-equal? (or (null? '(a b c))
                  (null? '())) #t)
(check-equal? (or (null? '(a b c))
                  (null? '(atom))) #f)

