#lang racket
; Exercise 2.51: Define the below operation for painters. below takes two painters as arguments. The resulting painter, given a frame, draws with the first painter in the bottom of the frame and with the second painter in the top.
(require sicp-pict)

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

; Define below in two different ways—first by writing a procedure that is analogous to the beside procedure given above,
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-down
           (transform-painter
            painter1
            (make-vect 0.0 0.0)
            split-point
            (make-vect 0.0 1.0)))
          (paint-up
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.0)
            (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-down frame)
        (paint-up frame)))))

; and again in terms of beside and suitable rotation operations (from Exercise 2.50).
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate180 painter) (rotate90 (rotate90 painter)))

(define (rotate270 painter) (rotate180 (rotate90 painter)))

(define (below-2 painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))