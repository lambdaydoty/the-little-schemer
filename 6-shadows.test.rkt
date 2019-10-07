#lang racket
(require "utils.rkt")
(require rackunit "6-shadows.rkt")

#| numbered? |#
(check-equal? (numbered? '1) #t)
(check-equal? (numbered? '(3 + (4 ↑ 5))) #t)
(check-equal? (numbered? '(2 × sausage)) #f)

#| value |#
(check-equal? (value '13) 13)
(check-equal? (value '(1 + 3)) 4)
(check-equal? (value '(1 + (3 ↑ 4))) 82)

#| 1 + 3 = 2 + 2 |#
(check-equal? (plus (edd1 '())
                    (edd1 (edd1 (edd1 '()))))
              (plus (edd1 (edd1 '()))
                    (edd1 (edd1 '()))))
