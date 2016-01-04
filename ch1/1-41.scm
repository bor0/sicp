; Exercise 1.41. Define a procedure double that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if inc is a procedure that adds 1 to its argument, then (double inc) should be a procedure that adds 2.
(define (inc n) (+ n 1))

(define (double proc)
  (lambda (n) (proc (proc n))))

; Q: What value is returned by
(((double (double double)) inc) 5)
; 21
