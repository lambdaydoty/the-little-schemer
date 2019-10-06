#lang racket
(require "utils.rkt")
(require rackunit "4-numbers-games.rkt")

#| atom? |#
(check-equal? (atom? 14) #t)

#| add1, sub1, zero? |#
(check-equal? (add1 67) 68)
(check-equal? (sub1 5) 4)
(check-equal? (zero? 0) #t)
(check-equal? (zero? 1492) #f)

#| plus, minus |#
(check-equal? (plus 46 12) 58)
(check-equal? (minus 14 3) 11)
(check-equal? (minus 17 9) 8)

#| tup? |#
(check-equal? (tup? '(2 11 3 79 47 6)) #t)
(check-equal? (tup? '(8 55 5 555)) #t)
(check-equal? (tup? '(1 2 8 apple 4 3)) #f)
(check-equal? (tup? '(3 (7 4) 13 9)) #f)
(check-equal? (tup? '()) #t)

#| addtup |#
(check-equal? (addtup '(3 5 2 8)) 18)
(check-equal? (addtup '(15 6 7 12 3)) 43)

#| times |#
(check-equal? (times 5 3) 15)
(check-equal? (times 13 4) 52)
(check-equal? (times 12 3) 36)

#| tup+ |#
(check-equal? (tup+ '(3 6 9 11 4)
                    '(8 5 2 0 7))
              '(11 11 11 11 11))
(check-equal? (tup+ '(2 3)
                    '(4 6))
              '(6 9))
(check-equal? (tup+ '(3 7)
                    '(4 6))
              '(7 13))
(check-equal? (tup+ '(3 7 8 1)
                    '(4 6))
              '(7 13 8 1))

#| gt, lt, =n |#
(check-equal? (gt 12 133) #f)
(check-equal? (gt 120 11) #t)
(check-equal? (gt 3 3) #f)
(check-equal? (=n 3 3) #t)

#| pow |#
(check-equal? (pow 1 1) 1)
(check-equal? (pow 2 3) 8)
(check-equal? (pow 5 3) 125)

#| div |#
(check-equal? (div 15 4) 3)

#| length |#
(check-equal? (length '(hotdogs with mustard sauerkraut and pickles)) 6)
(check-equal? (length '(ham and cheese on rye)) 5)

#| pick, rempick |#
(check-equal? (pick 4 '(lasagna spaghetti ravioli macaroni meatball))
              'macaroni)
(check-equal? (rempick 3 '(hotdogs with hot mustard))
              '(hotdogs with mustard))

#| number? |#
(check-equal? (number? 'tomato) #f)
(check-equal? (number? 76) #t)

#| no-nums, all-nums |#
(check-equal? (no-nums '(5 pears 6 prunes 9 dates))
              '(pears prunes dates))
(check-equal? (all-nums '(5 pears 6 prunes 9 dates))
              '(5 6 9))
