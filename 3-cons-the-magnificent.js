#lang racket
(require "utils.rkt")
;;
;; keywords:
;;

(define (lat? l)
  (cond [(null? l) #t]
        [else (and (atom? (car l))
                   (lat? (cdr l)))])
  )

;;   member? :: Atom -> LAT -> Boolean
;;   rember  :: Atom -> LAT -> LAT  # remove the first occurrence of the atom
;;   insertR :: Atom -> Atom -> LAT -> LAT
;;   insertL :: Atom -> Atom -> LAT -> LAT
;;   subst   :: Atom -> Atom -> LAT -> LAT
;;   subst2  :: Atom -> Atom -> Atom -> LAT -> LAT
;;
;;   firsts   :: List -> List
;;   seconds  :: List -> List

(define (member? a lat)
  (cond [(null? lat) #f]
        [(eq? (car lat) a) #t]
        [else (member? a (cdr lat))]))

(define (rember a lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) a) (cdr lat)]
        [else (cons (car lat)
                    (rember a (cdr lat)))]))

(define (firsts l)
  (cond [(null? l) '()]
        [else (cons (car (car l))
                    (firsts (cdr l)))]))

(define (seconds l) (map cadr l))

(define (insertR new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons old
                                     (cons new (cdr lat)))]
        [else (cons (car lat) (insertR new old (cdr lat)))]))

(define (insertL new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                     (cons old (cdr lat)))]
        [else (cons (car lat) (insertL new old (cdr lat)))]))

(define (subst new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new (cdr lat))]
        [else (cons (car lat) (subst new old (cdr lat)))]))

(define (subst2 new o1 o2 lat)
  (cond [(null? lat) '()]
        [(or (eq? (car lat) o1)
             (eq? (car lat) o2)) (cons new (cdr lat))]
        [else (cons (car lat) (subst2 new o1 o2 (cdr lat)))]))

;;   multirember  :: Atom -> LAT -> LAT
;;   multiinsertR :: Atom -> Atom -> LAT -> LAT
;;   multiinsertL :: Atom -> Atom -> LAT -> LAT
;;   multisubst   :: Atom -> Atom -> LAT -> LAT
;;   subst2  :: Atom -> Atom -> Atom -> LAT -> LAT

(define (multirember a lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) a) (multirember a (cdr lat))]
        [else (cons (car lat)
                    (multirember a (cdr lat)))]))

(define (multiinsertR new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons (car lat)
                                   (cons new (multiinsertR new old (cdr lat))))]
        [else (cons (car lat) (multiinsertR new old (cdr lat)))]))

(define (multiinsertL new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                   (cons (car lat) (multiinsertL new old (cdr lat))))]
        [else (cons (car lat) (multiinsertL new old (cdr lat)))]))

(define (multisubst new old lat)
  (cond [(null? lat) '()]
        [(eq? (car lat) old) (cons new
                                   (multisubst new old (cdr lat)))]
        [else (cons (car lat) (multisubst new old (cdr lat)))]))

#| REMOVE A MEMBER |#
(listing
  (rember 'mint '(lamb chops and mint jelly))
  (rember 'mint '(lamb chops and mint flavored mint jelly))
  (rember 'toast '(bacon lettuce and tomato))
  (rember 'cup '(coffee cup tea cup and hick cup))
  (rember 'sauce '(soy sauce and tomato sauce))
  )

#| FIRSTS |#
(listing
  (firsts '((apple peach pumpkin)
            (plum pear cherry)
            (grape rasin pea)
            (bean carrot eggplant)))
  (firsts '((a b)
            (c d)
            (d f)))
  (firsts '())
  (firsts '((five plums)
            (four)
            (eleven green oragnes)))
  (firsts '(((five plums) four)
            (eleven green oragnes)
            ((no) more)))
  )

#| SECONDS |#
(listing
  (seconds '((a b)
             (c d)
             (e f)))
  )

#| INSERT-R |#
(listing
  (insertR 'topping 'fudge '(ice cream with fudge for dessert))
  (insertR 'jalapeno 'and '(tacos tamales and salsa))
  (insertR 'e 'd '(a b c d e f g d h))
  (insertL 'e 'd '(a b c d e f g d h))
  )

#| SUBST |#
(listing
  (subst 'topping 'fudge '(ice cream with fudge for dessert))
  )

#| SUBST2 |#
(listing
  (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
  )

#| MULTIREMBER |#
(listing
  (multirember 'cup '(coffee cup tea cup and hick cup))
  )

#| MULTIINSERTL |#
(listing
  (multiinsertL 'fried 'fish '(chips and fish or fish and fried))
  )
