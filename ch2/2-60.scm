#lang racket
; Exercise 2.59: Implement the union-set operation for the unordered-list representation of sets.
(define test-set '(2 3 2 1 3 2 2))

; Efficiency is same as previous implementation, O(n)
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

; Efficiency is O(1), much faster than previous implementation which was O(n)
(define (adjoin-set x set)
  (cons x set))

; Efficiency is O(n), much faster than previous implementation which was O(n^2)
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        (union-set (cdr set1) (cons (car set1) set2))))

; Efficiency is same as previous implementation, O(n^2), since we have to check that an element is contained in both lists
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; Are there applications for which you would use this representation in preference to the non-duplicate one?
; We could have defined a procedure 'list-to-set' which would convert a representation of duplicates to a non-duplicate one.
; If a program relies heavily on union-set/adjoin-set, this representation would be preferable.