; Exercise 1.8. Newton’s method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value: (x/y^2 + 2y)/3. Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In section 1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root and cube-root procedures.)
(define (square n) (* n n))
(define (cube n) (* n n n))

(define (improve guess x)
  (average (* 2 guess) (/ x (square guess)) 0))

(define (average x y z)
  (/ (+ x y z) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (cbrt-iter (improve guess x)
                     x))) 
