#lang racket
; Exercise 2.49: Use segments->painter to define the following primitive painters:

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

; a. The painter that draws the outline of the designated frame.
(define (frame-edges-painter frame)
  (segments->painter (frame-edges frame) frame))

(define (frame-edges frame)
  (define origin-point (make-vect 0 0))
  (let ((left-edge (make-segment origin-point (edge2-frame frame)))
        (bottom-edge (make-segment origin-point (edge1-frame frame)))
        (right-edge (make-segment (edge2-frame frame)
                                  (add-vect (edge2-frame frame) (edge1-frame frame))))
        (top-edge (make-segment (edge1-frame frame)
                                (add-vect (edge1-frame frame) (edge2-frame frame)))))
    (list left-edge right-edge bottom-edge top-edge)))

; b. The painter that draws an "X" by connecting opposite corners of the frame.
(define (frame-cross-painter frame)
  (segments->painter (frame-cross frame) frame))

(define (frame-cross frame)
  (define origin-point (make-vect 0 0))
  (let ((tl-br (make-segment (edge2-frame frame) (edge1-frame frame)))
        (bl-tr (make-segment origin-point
                             (add-vect (edge2-frame frame) (edge1-frame frame)))))
    (list tl-br bl-tr)))

; c. The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.
(define (frame-edges-middle-painter frame)
  (segments->painter (frame-edges-middle frame) frame))

(define (middle-point v-0 v-1)
  (scale-vect 0.5 (add-vect v-0 v-1)))

(define (frame-edges-middle frame)
  (define origin-point (make-vect 0 0))
  (define left-middle (middle-point origin-point
                                    (add-vect origin-point (edge2-frame frame))))
  (define bottom-middle (middle-point origin-point
                                      (add-vect origin-point (edge1-frame frame))))
  (define right-middle (middle-point (add-vect origin-point (edge1-frame frame))
                                     (add-vect origin-point (add-vect (edge1-frame frame)
                                                                      (edge2-frame frame)))))
  (define top-middle (middle-point (add-vect origin-point (edge2-frame frame))
                                   (add-vect origin-point (add-vect (edge1-frame frame) (edge2-frame frame)))))
  (let ((left-top (make-segment left-middle top-middle))
        (top-right (make-segment top-middle right-middle))
        (right-bottom (make-segment right-middle bottom-middle))
        (bottom-left (make-segment bottom-middle left-middle)))
    (list left-top top-right right-bottom bottom-left)))

; d. The wave painter.
(define wave
  (segments->painter
   (list
    (make-segment (make-vect 0.20 0.00) (make-vect 0.35 0.50))
    (make-segment (make-vect 0.35 0.50) (make-vect 0.30 0.60))
    (make-segment (make-vect 0.30 0.60) (make-vect 0.15 0.45))
    (make-segment (make-vect 0.15 0.45) (make-vect 0.00 0.60))
    (make-segment (make-vect 0.00 0.80) (make-vect 0.15 0.65))
    (make-segment (make-vect 0.15 0.65) (make-vect 0.30 0.70))
    (make-segment (make-vect 0.30 0.70) (make-vect 0.40 0.70))
    (make-segment (make-vect 0.40 0.70) (make-vect 0.35 0.85))
    (make-segment (make-vect 0.35 0.85) (make-vect 0.40 1.00))
    (make-segment (make-vect 0.60 1.00) (make-vect 0.65 0.85))
    (make-segment (make-vect 0.65 0.85) (make-vect 0.60 0.70))
    (make-segment (make-vect 0.60 0.70) (make-vect 0.75 0.70))
    (make-segment (make-vect 0.75 0.70) (make-vect 1.00 0.40))
    (make-segment (make-vect 1.00 0.20) (make-vect 0.60 0.48))
    (make-segment (make-vect 0.60 0.48) (make-vect 0.80 0.00))
    (make-segment (make-vect 0.40 0.00) (make-vect 0.50 0.30))
    (make-segment (make-vect 0.50 0.30) (make-vect 0.60 0.00)))))