; Exercise 1.7. The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?
(define (square n) (* n n))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (calc-impr guess x)
  (abs (- (square guess) x)))

(define (calc-impr2 guess x)
  (/ (abs (- (improve guess x) guess)) guess))

(define (good-enough? guess x)
  (< (calc-impr guess x) 0.001))

(define (good-enough2? guess x)
  (< (calc-impr2 guess x) 0.001))

(define (sqrt-iter guess x f)
  (if (f guess x)
      guess
      (sqrt-iter (improve guess x) x f)))

(sqrt-iter 1 0.00001 good-enough?) ; result is 0.03134...
(sqrt-iter 1 0.00001 good-enough2?) ; result is 0.003162... which is closer

(sqrt-iter 1 1234567 good-enough?) ; evaluates fast
(sqrt-iter 1 1234567 good-enough2?) ; evaluates fast

; (sqrt-iter 1 12345678 good-enough?) ; very slow
(sqrt-iter 1 12345678 good-enough2?) ; evaluates okay-ish

; For good-enough?, the result is less accurate for small numbers, and takes long time for large numbers
; For good-enough2?, the result is more accurate for small numbers, and takes long (but not longer than good-enough?) for large numbers
