#lang racket
(require "utils.rkt")
(require rackunit "7-friends-and-relations.rkt")

#| set? |#
(check-equal? (set? '(apple peaches apple plum))
              #f)
(check-equal? (set? '(apple peaches pears plums))
              #t)
(check-equal? (set? '())
              #t)

#| makeset |#
(check-equal? (makeset '(apple peach pear peach
                               plum apple lemon peach))
              '(apple peach pear plum lemon))

#| subset? |#
(check-equal? (subset? '(5 chicken wings)
                       '(5 hamburgers
                         2 pieces fried chicken and
                         light duckling wings))
              #t)
(check-equal? (subset? '(4 pounds of horseradish)
                       '(four pounds chicken and
                              5 ounces horseradish))
              #f)

#| eqset? |#
(check-equal? (eqset? '(6 large chickens with wings)
                      '(6 chickens with large wings))
              #t)

#| intersect? |#
(check-equal? (intersect? '(stewed tomatoes and macaroni)
                          '(macaroni and cheese))
              #t)

#| intersect |#
(check-equal? (intersect '(stewed tomatoes and macaroni)
                         '(macaroni and cheese))
              '(and macaroni))

#| union |#
(check-equal? (union '(stewed tomatoes and macaroni casserole)
                     '(macaroni and cheese))
              '(stewed tomatoes casserole macaroni and cheese))

#| intersectall |#
(check-equal? (intersectall '((6 pears and)
                              (3 peaches and 6 peppers)
                              (8 pears and 6 plums)
                              (and 6 prunes with some apples)))
              '(6 and))

#| a-pair? |#
(check-equal? (a-pair? '(pear pear)) #t)
(check-equal? (a-pair? '(3 7)) #t)
(check-equal? (a-pair? '((2) (pair))) #t)
(check-equal? (a-pair? '(full (house))) #t)

#| fun? |#
(check-equal? (fun? '((4 3) (4 2) (7 6) (6 2) (3 4))) #f)
(check-equal? (fun? '((8 3) (4 2) (7 6) (6 2) (3 4))) #t)
(check-equal? (fun? '((d 4) (b 0) (b 9) (e 5) (g 4))) #f)

#| revrel |#
(check-equal? (revrel '((8 a) (pumpkin pie) (got sick)))
              '((a 8) (pie pumpkin) (sick got)))

#| fullfun?, one-to-one? |#
(check-equal? (fullfun? '((8 3) (4 2) (7 6) (6 2) (3 4))) #f)
(check-equal? (fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4))) #t)
(check-equal? (fullfun? '((grape raisin)
                          (plum prune)
                          (stewed prune))) #f)
(check-equal? (fullfun? '((grape raisin)
                          (plum prune)
                          (stewed grape))) #t)
(check-equal? (one-to-one? '((8 3) (4 2) (7 6) (6 2) (3 4))) #f)
(check-equal? (one-to-one? '((8 3) (4 8) (7 6) (6 2) (3 4))) #t)
(check-equal? (one-to-one? '((grape raisin)
                             (plum prune)
                             (stewed prune))) #f)
(check-equal? (one-to-one? '((grape raisin)
                             (plum prune)
                             (stewed grape))) #t)
(check-equal? (one-to-one? '((chocolate chip)
                             (doughy cookie))) #t)
