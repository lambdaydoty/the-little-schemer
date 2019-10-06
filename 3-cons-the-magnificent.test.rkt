#lang racket
(require rackunit "3-cons-the-magnificent.rkt")

#| rember |#
(check-equal? (rember 'mint '(lamb chops and mint jelly))
              '(lamb chops and jelly))
(check-equal? (rember 'mint '(lamb chops and mint flavored mint jelly))
              '(lamb chops and flavored mint jelly))
(check-equal? (rember 'toast '(bacon lettuce and tomato))
              '(bacon lettuce and tomato))
(check-equal? (rember 'cup '(coffee cup tea cup and hick cup))
              '(coffee tea cup and hick cup))
(check-equal? (rember 'sauce '(soy sauce and tomato sauce))
              '(soy and tomato sauce))

#| first |#
(check-equal? (firsts '((apple peach pumpkin)
                        (plum pear cherry)
                        (grape rasin pea)
                        (bean carrot eggplant)))
              '(apple plum grape bean))
(check-equal? (firsts '((a b)
                        (c d)
                        (d f)))
              '(a c d))
(check-equal? (firsts '())
              '())
(check-equal? (firsts '((five plums)
                        (four)
                        (eleven green oragnes)))
              '(five four eleven))
(check-equal? (firsts '(((five plums) four)
                        (eleven green oragnes)
                        ((no) more)))
              '((five plums) eleven (no)))

#| second |#
(check-equal? (seconds '((a b)
                         (c d)
                         (e f)))
              '(b d f))

#| insertR |#
(check-equal? (insertR 'topping 'fudge '(ice cream with fudge for dessert))
              '(ice cream with fudge topping for dessert))
(check-equal? (insertR 'jalapeno 'and '(tacos tamales and salsa))
              '(tacos tamales and jalapeno salsa))
(check-equal? (insertR 'e 'd '(a b c d e f g d h))
              '(a b c d e e f g d h))
(check-equal? (insertL 'e 'd '(a b c d e f g d h))
              '(a b c e d e f g d h))

#| subst |#
(check-equal? (subst 'topping 'fudge '(ice cream with fudge for dessert))
              '(ice cream with topping for dessert))

#| subst2 |#
(check-equal? (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
              '(vanilla ice cream with chocolate topping))

#| multirember |#
(check-equal? (multirember 'cup '(coffee cup tea cup and hick cup))
              '(coffee tea and hick))

#| multiinsertL |#
(check-equal?  (multiinsertL 'fried 'fish '(chips and fish or fish and fried))
               '(chips and fried fish or fried fish and fried))
