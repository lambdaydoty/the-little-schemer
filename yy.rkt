#lang lazy

(define Y
  (λ (f)
    ((λ (x) (f (x x)))
     (λ (x) (f (x x))))))

(define fact0
  (λ (g)
    (λ (n)
      (cond [(zero? n) 1]
            [else (* n (g (- n 1)))]))))

(println ((Y fact0) 5))
(println ((Y fact0) 4))
(println ((Y fact0) 3))

#lang racket

1
