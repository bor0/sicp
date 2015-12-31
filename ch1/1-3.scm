; Exercise 1.3. Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-squares-larger x y z)
  (cond
    ((and (>= x z) (>= y z)) (sum-of-squares x y))
    ((and (>= x y) (>= z y)) (sum-of-squares x z))
    ((and (>= y x) (>= z x)) (sum-of-squares y z))))
