; Exercise 1.29. Simpson’s Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson’s Rule, the integral of a function f between a and b is approximated as
; h/3 [ y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_(n-2) + 4y_(n-1) + y_n ]
; where h = (b - a)/n, for some even integer n, and y k = f(a + kh). (Increasing n increases the accuracy of the approximation.) Define a procedure that takes as arguments f, a, b, and n and returns the value of the integral, computed using Simpson’s Rule. Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000), and compare the results to those of the integral procedure shown above.
(define (cube x) (* x x x))

(define (simpson f a b n)
  (define h (/ (- b a) n))

  (define (y_k k) (f (+ a (* k h))))
  (define (coef-y_k k) (* (y_k k) (if (even? k) 2 4))) 

  (define (calc-coef f n s)
   (if (= n 1)
       s
       (calc-coef f (- n 1) (+ s (coef-y_k n)))))

  (define ys (+ (y_k 0) (calc-coef f (- n 1) 0) (y_k n)))

  (* ys (/ h 3)))

#|
> (simpson cube 0 1 100.0)
0.24999998666666656
> (simpson cube 0 1 1000.0)
0.24999999999866693
>
|#
