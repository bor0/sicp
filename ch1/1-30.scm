; Exercise 1.30. The sum procedure above generates a linear recursion.
(define (cube n) (* n n n))
(define (inc x) (+ x 1))

(define (sum f a next b) 
  (if (> a b)
      0
      (+ (f a) 
         (sum f (next a) next b))))

; The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition:
(define (sum-iter f a next b) 
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (+ result (f a)))))
(iter a 0))

(=
 (sum cube 1 inc 10)
 (sum-iter cube 1 inc 10))
