#lang racket
(require rackunit "1-toys.rkt")
(require "utils.rkt")

#| atom? |#
(check-equal? (atom? 'atom) #t)
(check-equal? (atom? 'turkey) #t)
(check-equal? (atom? 1492) #t)
(check-equal? (atom? 'u) #t)
(check-equal? (atom? '*abc$) #t)

#| list? |#
(check-equal? (list? '(atom turkey or)) #t)
(check-equal? (list? '((atom turkey) or)) #t)

#| s-exp? |#
(check-equal? (s-exp? 'xyz) #t)
(check-equal? (s-exp? '(x y z)) #t)
(check-equal? (s-exp? '((x y) z)) #t)
(check-equal? (list?  '(how are you doing so far)) #t)
(check-equal? (length '(how are you doing so far)) 6)
(check-equal? (list?  '(((how) are) ((you) (doing so)) far)) #t)
(check-equal? (length '(((how) are) ((you) (doing so)) far)) 3)

#| empty list |#
(check-equal? (list? '()) #t)
(check-equal? (atom? '()) #f)
(check-equal? (list? '(() () () ())) #t)

#| car, cdr |#
(check-equal? (car '(a b c)) 'a)
(check-equal? (car '((a b c) x y z)) '(a b c))
(check-equal? (car '(((hotdogs)) (and) (pickle) relisth))
              '((hotdogs)))
(check-equal? (car (car '(((hotdogs)) (and) (pickle) relisth)))
              '(hotdogs))
(check-equal? (cdr '(a b c)) '(b c))
(check-equal? (cdr '((a b c) x y z)) '(x y z))
(check-equal? (cdr '(hamburger)) '())
(check-equal? (cdr '((x) t r)) '(t r))
(check-equal? (car (cdr '((b) (x y) ((c)))))
              '(x y))
(check-equal? (cdr (cdr '((b) (x y) ((c)))))
              '(((c))))

#| cons |#
(check-equal? (cons 'peanut '(butter and jelly))
              '(peanut butter and jelly))
(check-equal? (cons '(banana and) '(peanut butter and jelly))
              '((banana and) peanut butter and jelly))
(check-equal? (cons '((help) this) '(is very ((hard) to learn)))
              '(((help) this) is very ((hard) to learn)))
(check-equal? (cons '(a b (c)) '())
              '((a b (c))))
(check-equal? (cons 'a '()) '(a))
(check-equal? (cons 'a (car '((b) c d))) '(a b))
(check-equal? (cons 'a (cdr '((b) c d))) '(a c d))

#| null? |#
(check-equal? (null? '()) #t)
(check-equal? (null? (quote ())) #t)
(check-equal? (null? '(a b c)) #f)

#| atom? |#
(check-equal? (atom? 'Harry) #t)
(check-equal? (atom? '(Harry had a heap of apples)) #f)
(check-equal? (atom? (car '(Harry had a heap of apples))) #t)
(check-equal? (atom? (cdr '(Harry had a heap of apples))) #f)
(check-equal? (atom? (cdr '(Harry))) #f)
(check-equal? (atom? (car (cdr '(swing low sweet cherry oat)))) #t)
(check-equal? (atom? (car (cdr '(swing (low sweet) cherry oat)))) #f)

#| eq? |#
(check-equal? (eq? 'Harry 'Harry) #t)
(check-equal? (eq? 'margarine 'butter) #f)
(check-equal? (eq? (car '(Mary had a little lamb chop))
                   'Mary) #t)
(check-equal? (eq? (car '(beans beans we need jelly beans))
                   (cadr '(beans beans we need jelly beans))) #t)
