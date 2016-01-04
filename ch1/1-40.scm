; Exercise 1.40. Define a procedure cubic that can be used together with the newtons-method procedure in expressions of the form (newtons-method (cubic a b c) 1) to approximate zeros of the cubic x^3 + ax^2 + bx + c.
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

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

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (n) (+ (* n n n) (* a n n) (* b n) c)))

(newtons-method (cubic 1 1 1) 1)
