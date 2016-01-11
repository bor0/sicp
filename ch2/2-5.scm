; Exercise 2.5. Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair a and b as the integer that is the product 2^a 3^b. Give the corresponding definitions of the procedures cons, car, and cdr.
(define (cons a b) (* (expt 2 a) (expt 3 b)))

(define (car a)
  (if (= 0 (remainder a 3)) (car (/ a 3)) (/ (log a) (log 2))))

(define (cdr a)
  (if (= 0 (remainder a 2)) (cdr (/ a 2)) (/ (log a) (log 3))))

(define test (cons 1 2))
(car test)
(cdr test)
