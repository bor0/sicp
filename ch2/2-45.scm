#lang racket
(require sicp-pict)

; Exercise 2.45: right-split and up-split can be expressed as instances of a general spliting operation. Define a procedure split
(define (split what where)
  (define (splitter painter n)
    (if (= n 0)
        painter
        (let ((smaller (splitter painter (- n 1))))
          (what painter (where smaller smaller)))))
  splitter)

; with the property that evaluating
(define right-split (split beside below))
(define up-split (split below beside))

; produces procedures right-split and up-split with the same behaviors as the ones already defined.
