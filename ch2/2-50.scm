#lang racket
; Exercise 2.50: Define the transformation flip-horiz, which flips painters horizontally, and transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

(define (draw-line) '())

(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2) (make-vect (+ (xcor-vect v1) (xcor-vect v2))
                                    (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2) (make-vect (- (xcor-vect v1) (xcor-vect v2))
                                    (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v) (make-vect (* (xcor-vect v) s)
                                    (* (ycor-vect v) s)))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f) (car f))
(define (edge1-frame f) (cadr f))
(define (edge2-frame f) (caddr f))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (segments->painter segment-list)   
  (lambda (frame)     
    (for-each     
     (lambda (segment)        
       (draw-line         
        ((frame-coord-map frame) (start-segment segment))         
        ((frame-coord-map frame) (end-segment segment))))      
     segment-list)))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                  new-origin
                  (sub-vect (m corner1) new-origin)
                  (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0) ; new origin
                     (make-vect 0.0 0.0) ; new end of edge1
                     (make-vect 1.0 1.0))) ; new end of edge2

(define (rotate180 painter) (rotate90 (rotate90 painter)))

(define (rotate270 painter) (rotate180 (rotate90 painter)))