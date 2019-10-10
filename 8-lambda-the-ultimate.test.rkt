#lang racket
(require "utils.rkt")
(require rackunit "8-lambda-the-ultimate.rkt")

#| rember-f |#
(check-equal? (rember-f = 5 '(6 2 5 3))
              '(6 2 3))
(check-equal? (rember-f eq? 'jelly '(jelly beans are good))
              '(beans are good))
(check-equal? (rember-f equal?
                        '(pop corn)
                        '(lemonade (pop corn) and (cake)))
              '(lemonade and (cake)))

#| eq?-c |#
(check-equal? ((eq?-c 'salad) 'salad) #t)
(check-equal? ((eq?-c 'salad) 'tuna) #f)

#| insertL-f, insertR-f |#
(check-equal? ((insertL-f =) 333 3 '(1 2 3 4 5 6))
              '(1 2 333 3 4 5 6))
(check-equal? ((insertR-f =) 333 3 '(1 2 3 4 5 6))
              '(1 2 3 333 4 5 6))
(check-equal? ((insert-g (lambda (new old l) (cons new (cons old l))))
               333
               3
               '(1 2 3 4 5 6))
              '(1 2 333 3 4 5 6))
(check-equal? ((insert-g (lambda (new old l) (cons old (cons new l))))
               333
               3
               '(1 2 3 4 5 6))
              '(1 2 3 333 4 5 6))

(check-equal? ((cadddr (insertL-insertR-subst-rember)) ; rember
               'c
               '(a b c d e f c))
              '(a b d e f c))

#| value |#
(check-equal? (value '13) 13)
(check-equal? (value '(1 + 3)) 4)
(check-equal? (value '(1 + (3 ↑ 4))) 82)

#| multiremberT |#
(check-equal? (multiremberT (eq?-c 'tuna) '(shrimp salad tuna salad and tuna))
              '(shrimp salad salad and))

#| multirember&co |#
(check-equal?  (multirember&co 'tuna '() (lambda (x y) (null? y))) #t)
(check-equal?  (multirember&co 'tuna '(tuna) (lambda (x y) (null? y))) #f)
(check-equal?  (multirember&co 'tuna '(tuna) (lambda (x y) (null? x))) #t)
(check-equal?  (multirember&co 'tuna '(and tuna) (lambda (x y) (null? y))) #f)
(check-equal?  (multirember&co 'tuna '(strawberriew tuna and swordfish) (lambda (x y) (length x))) 3)

#| multiinsertLR&co |#
(check-equal? (multiinsertLR&co 'salty 'fish 'chips '(chips and fish or fish and chips) list) ; use `list` as the identity function
              '((chips salty and salty fish or salty fish and chips salty) 2 2))

#| evens-only*&co |#
(check-equal? (evens-only*&co '((9 1 2 8)
                                3
                                10
                                ((9 9) 7 6)
                                2)
                              (lambda (newl product sum) (list* sum product newl)))
              '(38 1920 (2 8) 10 (() 6) 2))
