#lang racket
(require "utils.rkt")
(require rackunit "5-oh-my-gawd-its-full-of-stars.rkt")

#| rember* |#
(check-equal? (rember* 'cup
                       '((coffee) cup ((tea) cup)
                                  (and (hick)) cup))
              '((coffee) ((tea)) (and (hick))))

#| inserR* |#
(check-equal? (insertR* 'roast 'chuck '((how much (wood))
                                       could
                                       ((a (wood) chuck))
                                       (((chuck)))
                                       (if (a) ((wood chuck)))
                                       could chuck wood))
              '((how much (wood))
                could
                ((a (wood) chuck roast))
                (((chuck roast)))
                (if (a) ((wood chuck roast)))
                could chuck roast wood))

#| occur* |#
(check-equal? (occur* 'banana
                      '((banana)
                        (split ((((banana ice)))
                                (cream (banana))
                                sherbet))
                        (banana)
                        (bread)
                        (banana brandy)))
              5)

#| subst* |#
(check-equal? (subst* 'orange 'banana
                      '((banana)
                        (split ((((banana ice)))
                                (cream (banana))
                                sherbet))
                        (banana)
                        (bread)
                        (banana brandy)))
              '((orange)
                (split ((((orange ice)))
                        (cream (orange))
                        sherbet))
                (orange)
                (bread)
                (orange brandy)))

#| insertL* |#
(check-equal? (insertL* 'pecker 'chuck
                        '((how much (wood))
                          could
                          ((a (wood) chuck))
                          (((chuck)))
                          (if (a) ((wood chuck)))
                          could chuck wood))
              '((how much (wood))
                could
                ((a (wood) pecker chuck))
                (((pecker chuck)))
                (if (a) ((wood pecker chuck)))
                could pecker chuck wood))

#| member* |#
(check-equal? (member* 'chips
                       '((potato)
                         (chips ((with) fish) (chips))))
              #t)

#| leftmost |#
(check-equal? (leftmost '((potato) (chips ((with) fish) (chips))))
              'potato)
(check-equal? (leftmost '(((hot) (tuna (and))) cheese))
              'hot)

#| and |#
(let ([l '(mozzarella pizza)]
      [x 'pizza])
  (check-equal? (and (atom? (car l))
                     (eq? (car l) x))
                #f))
(let ([l '((mozzarella mushroom) pizza)]
      [x 'pizza])
  (check-equal? (and (atom? (car l))
                     (eq? (car l) x))
                #f))
(let ([l '(pizza (tastes good))]
      [x 'pizza])
  (check-equal? (and (atom? (car l))
                     (eq? (car l) x))
                #t))

#| eqlist? |#
(check-equal? (eqlist? '(strawberry ice cream)
                       '(strawberry ice cream))
              #t)
