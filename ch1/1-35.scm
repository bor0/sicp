; Exercise 1.35. Show that the golden ratio Phi (section 1.2.2) is a fixed point of the transformation x -> 1 + 1/x, and use this fact to compute Phi by means of the fixed-point procedure.
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

(define phi (fixed-point (lambda (x) (+ 1 (/ 1 x))) 2))

#|
Let T_n = 1 + 1/T_n
Multiply both sides by T_n:
T_n^2 = T_n + 1
T_n^2 - T_n - 1 = 0

This equation has solutions -Phi and Phi.
|#
