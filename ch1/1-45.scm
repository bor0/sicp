; Exercise 1.45. We saw in section 1.3.3 that attempting to compute square roots by naively finding a fixed point of y -> x/y does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped y -> x/y^2. Unfortunately, the process does not work for fourth roots -- a single average damp is not enough to make a fixed-point search for y -> x/y^3 converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of y -> x/y^3) the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of y -> x/y^(n-1). Use this to implement a simple procedure for computing nth roots using fixed-point, average-damp, and the repeated procedure of exercise 1.43. Assume that any arithmetic operations you need are available as primitives.
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (n) (f (g n))))

(define (repeated proc n)
  (if (= 1 n)
      proc
      (compose proc (repeated proc (- n 1)))))

(define (to-damp x n)
  (lambda (y) (/ x (expt y n))))

(define (sqrt x)
  (fixed-point (average-damp (to-damp x 1))
               1.0))

(define (cbrt x)
  (fixed-point (average-damp (to-damp x 2))
               1.0))

(define (root n x)
  (fixed-point ((repeated average-damp n) (to-damp x (- n 1)))
               1.0))

(root 2 4) ; sqrt(4)   = 2
(root 3 27) ; cbrt(27) = 3
(root 4 16) ; x^4 = 16 = 2
; n average-dampings seem to be enough
(root 5 243) ; x^5 = 243 = 3
