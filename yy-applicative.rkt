#lang racket

;; The eta-transform :
;;
;;   (λ (x) (M x)) ~ M
;;
;; Try to recognize 3 occurences of the `OMEGA` form (x x)
;; , and do a inverse eta-transform to each of them (3 times)
;;

(define Y
  (λ (f)
    (λ (g)
      (((λ (x) (f (λ (y) ((x x) y))))
        (λ (x) (f (λ (y) ((x x) y)))))
       g))))

(define fact0
  (λ (g)
    (λ (n)
      (cond [(zero? n) 1]
            [else (* n (g (- n 1)))]))))

(println ((Y fact0) 5))
