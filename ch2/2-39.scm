; Exercise 2.39. Complete the following definitions of reverse (exercise 2.18) in terms of fold-right and fold-left from exercise 2.38:
(define (reverse sequence)
  (foldr (lambda (x y) (append y (list x))) null sequence))
(define (reverse-2 sequence)
  (foldl (lambda (x y) (cons x y)) null sequence))
