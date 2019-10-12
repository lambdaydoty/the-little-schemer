#lang racket
(require "utils.rkt")
(require rackunit "9-and-again-and-agian.rkt")

#| keep-looking |#
(check-equal? (looking 'caviar '(6 2 4 caviar 5 7 3)) #t)
(check-equal? (looking 'caviar '(6 2 grits caviar 5 7 3)) #f)

#| shift |#
(check-equal? (shift '((a b) c))
              '(a (b c)))
(check-equal? (shift '((a b) (c d)))
              '(a (b (c d))))
(check-equal? (shift '((a b) ()))
              '(a (b ())))

#| length* |#
(check-equal? (length* '((a b) c)) 3)
(check-equal? (length* '((a b) (c d))) 4)

#| weight* |#
(check-equal? (weight* '((a b) c)) 7)
(check-equal? (weight* '(a (b c))) 5) ; after (shift)
(check-equal? (weight* '((a b) (c d))) 9)
(check-equal? (weight* '(a (b (c d)))) 7) ; after (shift)

#| shuffle |#
(check-equal? (shuffle '(a (b c))) '(a (b c)))
(check-equal? (shuffle '(a b)) '(a b))
(check-equal? (shuffle '((a b) c)) '(c (a b)))

#| C |#
(check-equal? (C 1) 1)
(check-equal? (C 2) 1)
(check-equal? (C 3) 1)
(check-equal? (C 4) 1)
(check-equal? (C 5) 1)

#| A |#
(check-equal? (A 0 0) 1)
(check-equal? (A 1 0) 2)
(check-equal? (A 2 0) 3)
(check-equal? (A 0 1) 2)
(check-equal? (A 1 1) 3)
(check-equal? (A 2 1) 5)
(check-equal? (A 3 1) 13)

#| Y |#
(check-equal? ((Y length0) '()) 0)
(check-equal? ((Y length0) '(x)) 1)
(check-equal? ((Y length0) '(x y)) 2)
(check-equal? ((Y length0) '(x y z)) 3)
(check-equal? ((Y length0) '(x y z u)) 4)
