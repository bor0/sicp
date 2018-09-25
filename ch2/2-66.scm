#lang racket
; Exercise 2.66: Implement the lookup procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (person key name) (cons key name))
(define (key p) (car p))
(define (name p) (cdr p))

(define tr-1 (make-tree (person 3 'Name3)
                        (make-tree (person 2 'Name2) '() '())
                        (make-tree (person 4 'Name4) '() '())))

(define (lookup given-key tree)
  (cond ((null? tree) false)
        ((equal? given-key (key (entry tree))) (entry tree))
        (else (let ([left (lookup given-key (left-branch tree))])
                (if (pair? left)
                    left
                    (lookup given-key (right-branch tree)))))))