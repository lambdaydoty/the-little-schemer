#lang racket
(require "utils.rkt")
(provide (all-defined-out))
(require racket/trace)

;;
;; Note:
;;

(define first car)
(define second cadr)
(define third caddr)
(define build list)

;; new-entry :: List -> List -> Entry
(define new-entry build)

;; lookup-in-entry :: Atom -> Entry -> Atom
(define lookup-in-entry
  (λ (name entry not-found)
    (let ([names (first entry)]
          [values (second entry)])
      (cond [(null? names) (not-found name)]
            [else (if (eq? (car names) name)
                      (car values)
                      (lookup-in-entry name
                                       (build (cdr names)
                                              (cdr values))
                                      not-found))]))))

;; extend-table :: Entry -> Table -> Table (a list of Entry)
(define extend-table cons)

;; lookup-in-table :: Atom -> Table -> Atom
(define lookup-in-table
  (λ (name table not-found)
    (cond [(null? table) (not-found name)]
          [else (lookup-in-entry
                  name
                  (car table)
                  (λ (name) (lookup-in-table name (cdr table) not-found)))])))

#| INTERPRETER |#

(define expression-to-action
  (λ (e)
    (cond
      [(atom? e) (atom-to-action e)]
      [else (list-to-action e)])))

(define atom-to-action
  (λ (e)
    (match e
      [(? number?) *const]
      [#t *const]
      [#f *const]
      ['cons *const]
      ['car *const]
      ['cdr *const]
      ['null? *const]
      ['eq? *const]
      ['atom? *const]
      ['zero? *const]
      ['add1 *const]
      ['sub1 *const]
      ['number? *const]
      [else *identifier])))

(define list-to-action
  (λ (e)
    (match e
      [`(quote) *quote]
      [`(lambda) *lambda]
      [`(cond) *cond]
      [else *application])))

(define value
  (λ (e)
    (meaning e '())))

(define meaning
  (λ (e table)
    ((expression-to-action e) e table)))

(define *const
  (λ (e table)
    (match e
      [(? number? e) e]
      ['#t #t]
      ['#f #f]
      [else (build 'primitive e)])))

(define *quote
  (λ (e table)
    (define text-of second)
    (text-of e)))

(define *identifier
  (λ (e table)
    (define initial-table
      (λ (name)
        (car '())))
    (lookup-in-table e table initial-table)))

(define *lambda
  (λ (e table)
    (build 'non-primitive
           (cons table (cdr e)))))

(define table-of first)
(define formals-of second)
(define body-of third)

#| (meaning '(lambda (x) (cons x y)) |#
#|          '(((y z) ((8) 9)))) |#
#| '(non-primitive |#
#|    ((((y z) ((8) 9))) (x) (cons x y))) |#

(define question-of first)
(define answer-of second)

(define eval-cond
  (λ (lines table)
    (define meaning?
      (λ (x) (meaning x table)))
    (match (question-of (car lines))
      ['else        (meaning (answer-of (car lines)) table)]
      [(? meaning?) (meaning (answer-of (car lines)) table)]
      [else (eval-cond (cdr lines) table)])))

(define cond-lines-of cdr)

(define *cond
  (λ (e table)
    (eval-cond (cond-lines-of e) table)))

#| (*cond '(cond (coffee klatsch) |#
#|               (else party)) |#
#|        '(((coffee) (#t)) |#
#|          ((klatsch party) (5 (6))))) |#

(define eval-list-of-arguments
  (λ (args table)
    (cond [(null? args) '()]
          [else (cons (meaning (car args) table)
                      (eval-list-of-arguments (cdr args) table))])))

(define function-of car)
(define arguments-of cdr)

(define *application
  (λ (e table)
    (apply
      (meaning (function-of e) table)
      (eval-list-of-arguments (arguments-of e) table))))

;; closure: (non-primitive (table formals body))

(define primitive?
  (λ (l)
    (eq? (first l) 'primitive)))

(define non-primitive?
  (λ (l)
    (eq? (first l) 'non-primitive)))

(define apply
  (λ (fn vals)
    (cond [(primitive? fn) (apply-primitive (second fn) vals)]
          [(non-primitive? fn) (apply-closure (second fn) vals)])))

(define :atom?
  (λ (x)
    (match x
      [(? atom?) #t]
      [(? null?) #f]
      [`(primitive) #t]
      [`(non-primitive) #t]
      [else #f])))

(define apply-primitive
  (λ (name vals)
    (let ([x (first vals)]
          [y (second vals)])
      (match name
        ['cons (cons x y)]
        ['car (car x)]
        ['cdr (cdr x)]
        ['null? (null? x)]
        ['eq? (eq? x y)]
        ['atom? (:atom? x)]
        ['zero? (zero? x)]
        ['add1 (add1 x)]
        ['sub1 (sub1 x)]
        ['number? (number? x)]))))

(define apply-closure
  (λ (closure vals)
    (let ([body (body-of closure)]
          [formals (formals-of closure)]
          [table (table-of closure)])
      (println body)
      (println formals)
      (println table)
      (meaning body
               (extend-table
                 (new-entry formals vals)
                 table)))))

(trace apply-closure)
(trace meaning)

; eval ((λ (x y) (cons z x)) '(a b c) '(d e f))
(define closure '((((u v w)
                    (1 2 3))
                   ((x y z)
                    (4 5 6)))
                  (x y)
                  (cons z x)))
(define vals '((a b c)
               (d e f)))

(apply-closure  closure vals)
