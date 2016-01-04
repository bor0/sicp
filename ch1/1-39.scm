; Exercise 1.39. A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert: tan(x) = x/(1 - x^2/(3 - x^3/(5 - ...))), where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the tangent function based on Lambert’s formula. K specifies the number of terms to compute, as in exercise 1.37.
(define (cont-frac-iter n d k)
  (define (cf-iter n d k t)
    (if (= k 0)
        t
        (cf-iter n d (- k 1) (/ (n k) (+ (d k) t)))))
  (cf-iter n d k 1))

(define (square n) (* n n))

(define (n x)
  (define (helper y)
    (if (= y 1)
        x
        (- (square x))))
  helper)

(define (d x) (- (* 2 x) 1))

(define (tan-cf x k)
  (cont-frac-iter (n x) d k))
