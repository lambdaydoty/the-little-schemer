#lang racket
(require "utils.rkt")
(provide (all-defined-out))

;;
;;   list  ::= ( s-exp* )
;;   s-exp ::= atom | list
;;
;; note) We have 2 ways to ask questions toward a list:
;;

;; numbered? :: Arithmetic-exp -> Boolean
(define (numbered? aexp)
  (cond [(atom? aexp) (number? aexp)]
        [else (let ([left (car aexp)]
                    [op (cadr aexp)]
                    [right (caddr aexp)])
                (and (numbered? left)
                     (numbered? right)))]))

;; value :: Numbered-arithmetic-exp -> N
(define (value nexp)
  (define 1-sub-exp car)
  (define 2-sub-exp caddr)
  (define operator cadr)
  (cond [(atom? nexp) nexp]
        [else (let ([left (1-sub-exp nexp)]
                    [op (operator nexp)]
                    [right (2-sub-exp nexp)])
                (cond [(eq? op '+) (+ (value left)
                                      (value right))]
                      [(eq? op '×) (* (value left)
                                      (value right))]
                      [(eq? op '↑) (expt (value left)
                                         (value right))]
                      [else #f]))]))

(define (sero? n) (null? n))
(define (edd1 n) (cons '() n))
(define (zub1 n) (cdr n))
(define (plus n m)
  (cond [(sero? m) n]
        [else (edd1 (plus n (zub1 m)))]))
