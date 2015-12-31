; Exercise 1.18. Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.
(define (double n) (+ n n))
(define (halve n) (/ n 2))

; Design c such that the product a * b remains unchanged from state to state 
(define (iter-mult a b c)
  (cond ((= b 0) c)
        ((even? a) (iter-mult (halve a) (double b) c))
        (else (iter-mult a (- b 1) (+ c a)))))
