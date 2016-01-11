; Exercise 2.4. Here is an alternative procedural representation of pairs. For this representation, verify that (car (cons x y)) yields x for any objects x and y.
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; What is the corresponding definition of cdr? (Hint: To verify that this works, make use of the substitution model of section 1.1.5.)
(define test (cons 123 456))
(car test)
(cdr test)