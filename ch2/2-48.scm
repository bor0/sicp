#lang racket
; Exercise 2.48: A directed line segment in the plane can be represented as a pair of vectors—the vector running from the origin to the start-point of the segment, and the vector running from the origin to the end-point of the segment.

; Use your vector representation from Exercise 2.46 to define a representation for segments with a constructor make-segment and selectors start-segment and end-segment.
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (make-segment x1 y1 x2 y2) (cons (make-vect x1 y1) (make-vect x2 y2)))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
