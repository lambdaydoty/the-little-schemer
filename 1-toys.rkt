#lang racket
(require "utils.rkt")
(provide (all-defined-out))
;;
;; keywords:
;;
;;   atom?  :: S-exp -> Boolean
;;   list?  :: S-exp -> Boolean
;;   s-exp? :: S-exp -> Boolean
;;
;;   null?  :: List -> Boolean
;;   car    :: Nonempty-list -> S-exp
;;   cdr    :: Nonempty-list -> List
;;   cons   :: S-exp -> List -> List
;;
;;   eq?    :: NNA -> NNA -> Boolean (NNA: Non-numeric atom)
;;
;;
;;   S-exp                          x                       y                         z
;;
;;                                  ^                       ^                         ^
;;                                  |                       |        (car ...)        |
;;                                  |                       |                         |
;;                                  |                       |                         |
;;                 (cdr ...)              (cdr ...)
;;   List    ()  <---------------  (x)  <---------------  (y x)  <---------------  (z y x)  <---------------  ...
;;               --------------->       --------------->         --------------->           --------------->
;;           |     (cons x ...)     |     (cons y ...)      |                         |
;;           |                      |                       |                         |
;;           |                      |                       |        (null? ...)      |
;;           v                      v                       v                         v
;;
;;   Boolean #t                     #f                      #f                        #f
;;
;;
;;
;;
;;  list  ::= () | (s-exp . list)
;;  s-exp ::= a  | list
;;
;;  lat   ::= () | (a . lat)
;;
;;  n     ::= 0  | (add1 n)
