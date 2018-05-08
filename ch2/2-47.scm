#lang racket
; Exercise 2.47: Here are two possible constructors for frames:
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

; For each constructor supply the appropriate selectors to produce an implementation for frames.
(define (frame-origin f) (car f))
(define (frame-edge1 f) (cadr f))
(define (frame-edge2 f) (caddr f))

(define (frame-2-origin f) (car f))
(define (frame-2-edge1 f) (cadr f))
(define (frame-2-edge2 f) (cddr f))

(define test-frame (make-frame 'origin 'edge1 'edge2))
(define test-frame-2 (make-frame-2 'origin 'edge1 'edge2))

(frame-origin test-frame)
(frame-edge1 test-frame)
(frame-edge2 test-frame)

(frame-2-origin test-frame-2)
(frame-2-edge1 test-frame-2)
(frame-2-edge2 test-frame-2)