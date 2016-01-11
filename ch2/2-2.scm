; Exercise 2.2. Consider the problem of representing line segments in a plane.

; Each segment is represented as a pair of points: a starting point and an ending point. Define a constructor make-segment and selectors start-segment and end-segment that define the representation of segments in terms of points.
(define (make-segment sp ep) (cons sp ep))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

; Furthermore, a point can be represented as a pair of numbers: the x coordinate and the y coordinate. Accordingly, specify a constructor make-point and selectors x-point and y-point that define this representation.
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

; Finally, using your selectors and constructors, define a procedure midpoint-segment that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints).
(define (average x y) (/ (+ x y) 2))

(define (midpoint-segment s)
  (make-point
   (average (x-point (start-segment s))
            (x-point (end-segment s)))
   (average (y-point (start-segment s))
            (y-point (end-segment s)))))

; To try your procedures, you’ll need a way to print points:
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define p1 (make-point 0 0))
(define p2 (make-point 0 1))
(define p3 (make-point 1 0))
(define p4 (make-point 1 1))

(define s1 (make-segment p1 p2))
(define s2 (make-segment p2 p3))
(define s3 (make-segment p3 p4))

(print-point (midpoint-segment s1)) ; line (0, 0) (0, 1)
(print-point (midpoint-segment s2)) ; line (0, 1) (1, 0)
(print-point (midpoint-segment s3)) ; line (1, 0) (1, 1)
