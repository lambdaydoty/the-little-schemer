#lang racket

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
;;                           x                       y                         z
;;
;;                           ^                       ^                         ^
;;                           |     (car ...)         |                         |
;;                           |                       |                         |
;;                           |                       |                         |
;;          (cdr ...)              (cdr ...)
;;   ()   --------------->  (x)  --------------->  (y x)  --------------->  (z y x)  --------------->  ...
;;        ---------------+       ---------------+         ---------------+           ---------------+
;;    |     (cons x ...)     |     (cons y ...)      |                         |
;;    |                      |                       |                         |
;;    |                      |     (null? ...)       |                         |
;;    v                      v                       v                         v
;;
;;    #t                     #f                      #f                        #f
;;

(define (atom? x)
  (and (not (pair? x))
       (not (null? x))))

(define (s-exp? x)
  (or (atom? x)
      (list? x)))

(define (listing . l)
  (begin
    (for-each (lambda (x) (printf "~a " x)) l)
    (newline)
    ))

#| ATOM |#
(listing
  (atom? 'atom)
  (atom? 'turkey)
  (atom? 1492)
  (atom? 'u)
  (atom? '*abc$)
  )


#| LIST |#
(listing
  (list? '(atom turkey or))
  (list? '((atom turkey) or))
  ;(list? '(atom turkey) or)
  )


#| S-EXPRESSION |#
(listing
  (s-exp? 'xyz)
  (s-exp? '(x y z))
  (s-exp? '((x y) z))
  (list?  '(how are you doing so far))
  (length '(how are you doing so far))
  (list?  '(((how) are) ((you) (doing so)) far))
  (length '(((how) are) ((you) (doing so)) far))
  )

#| EMPTY LIST |#
(listing
  (list? '())
  (atom? '())
  (list? '(() () () ()))
  )

#| CAR CDR |#
(listing
  (car '(a b c))
  (car '((a b c) x y z))
  ;(car 'hotdog)
  ;(car '())
  (car '(((hotdogs)) (and) (pickle) relisth))
  (car '(((hotdogs)) (and) (pickle) relisth))
  (car (car '(((hotdogs)) (and) (pickle) relisth)))
  (cdr '(a b c))
  (cdr '((a b c) x y z))
  (cdr '(hamburger))
  (cdr '((x) t r))
  ;(cdr 'hotdog)
  ;(cdr '())
  (car (cdr '((b) (x y) ((c))))) ;(cadr '((b) (x y) ((c))))
  (cdr (cdr '((b) (x y) ((c))))) ;(cddr '((b) (x y) ((c))))
  ;(cdr (car '(a (b (c)) d)))
  )

#| CONS |#
(listing
  (cons 'peanut '(butter and jelly))
  (cons '(banana and) '(peanut butter and jelly))
  (cons '((help) this) '(is very ((hard) to learn)))
  (cons '(a b (c)) '())
  (cons 'a '())
  ;(cons '((a b c)) 'b)
  ;(cons 'a 'b)
  (cons 'a (car '((b) c d)))
  (cons 'a (cdr '((b) c d)))
  )

#| NULL-LIST |#
(listing
  (null? '())
  (null? (quote ()))
  (null? '(a b c))
  ;(null? 'spaghetti)
  )

#| ATOM? |#
(listing
  (atom? 'Harry)
  (atom? '(Harry had a heap of apples))
  (atom? (car '(Harry had a heap of apples)))
  (atom? (cdr '(Harry had a heap of apples)))
  (atom? (cdr '(Harry)))
  (atom? (car (cdr '(swing low sweet cherry oat))))
  (atom? (car (cdr '(swing (low sweet) cherry oat))))
  )

#| EQ? |#
(listing
  (eq? 'Harry 'Harry)
  (eq? 'margarine 'butter)
  ;(eq? '() '(strawberry))
  ;(eq? 6 7)
  (eq? (car '(Mary had a little lamb chop))
       'Mary)
  ;(eq? (cdr '(soured milk))
  ;     'milk)
  (eq? (car '(beans beans we need jelly beans))
       (cadr '(beans beans we need jelly beans)))
  )
