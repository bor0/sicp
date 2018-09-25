#lang racket
; Exercise 2.61: Give an implementation of adjoin-set using the ordered representation.
; By analogy with element-of-set? show how to take advantage of the ordering to produce
; a procedure that requires on the average about half as many steps as with the unordered representation.

(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        (else (let ((x1 (car set)))
                (cond ((= x x1) set)
                      ((< x x1) (cons x set))
                      ((> x x1) (cons x1 (adjoin-set x (cdr set)))))))))

(adjoin-set 0 '(1 2 4 5))
(adjoin-set 1 '(1 2 4 5))
(adjoin-set 3 '(1 2 4 5))
(adjoin-set 6 '(1 2 4 5))