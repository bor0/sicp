; Exercise 2.3. Implement a representation for rectangles in a plane. (Hint: You may want to make use of exercise 2.2.)
(define (make-segment sp ep) (cons sp ep))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

; Looking at https://en.wikipedia.org/wiki/Rectangle#Classification, one can conclude that we can construct a rectangle given one segment (the diagonal) only. So, our make-rectangle constructor will be taking start-point and end-point:
(define (make-rectangle sp ep) (make-segment sp-ep))

; Given our representation that we chose (going with the diagonal segment to construct a rectangle), we can pretty much easily calculate the perimeter and the area given the length and the width of that rectangle. Now in terms of startpoint and endpoing of the diagonal, we can define rect-length and rect-width as follows:

; If we have the diagonal D = ([x1, y1], [x2, y2]), then the length is |x2 - x1|, and width |y2 - y1|
(define (rect-length r)
  (abs (-
    (x-point (start-segment r))
    (x-point (end-segment r)))))

(define (rect-width r)
  (abs (-
    (y-point (start-segment r))
    (y-point (end-segment r)))))

; Then the area is l*w, and perimeter 2(l + w).

; In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle.
(define (rect-area r) (* (rect-length r) (rect-width r))
(define (rect-perimeter r) (* 2 (+ (rect-length r) (rect-width r))

; Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?
; The current representation uses (cons (cons x1 y1) (cons x2 y2)). Our length and width procedures extract the coordinates and do the math on them. I had to google this answer, more details at http://www.billthelizard.com/2010/10/sicp-23-rectangles-in-plane.html
