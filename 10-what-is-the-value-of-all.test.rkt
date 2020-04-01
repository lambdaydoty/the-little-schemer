#lang racket
(require "utils.rkt")
(require rackunit "10-what-is-the-value-of-all.rkt")


#| lookup-in-entry |#
(let ([entry '((appetizer entree beverate)
               (food tastes good))]
      [name 'entree]
      [not-found (λ (x) x)])
  (check-equal? (lookup-in-entry name entry not-found) 'tastes))
(let ([entry '((appetizer entree beverate)
               (food tastes good))]
      [name 'dessert]
      [not-found (λ (x) x)])
  (check-equal? (lookup-in-entry name entry not-found) 'dessert))

#| lookup-in-table |#
(let ([table '(((entree dessert)
                (spaghetti spumoni))
               ((appetizer entree beverate)
                (food tastes good)))]
      [name 'entree]
      [not-found (λ (x) x)])
  (check-equal? (lookup-in-table name table not-found) 'spaghetti))
