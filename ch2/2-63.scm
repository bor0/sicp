#lang racket
; Exercise 2.63: Each of the following two procedures converts a binary tree to a list:

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set) (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define tr-1 (foldl (lambda (x y) (adjoin-set x y)) '() '(7 3 1 5 9 11)))
(define tr-2 (foldl (lambda (x y) (adjoin-set x y)) '() '(3 1 7 5 9 11)))
(define tr-3 (foldl (lambda (x y) (adjoin-set x y)) '() '(5 3 1 9 7 11)))

; A balance of a tree depends on the initial order items are constructed
(define unbalanced-tree (foldl (lambda (x y) (adjoin-set x y)) '() (range 1 8)))
(define balanced-tree (foldl (lambda (x y) (adjoin-set x y)) '() '(4 2 1 3 6 5 7)))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
                     (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))

unbalanced-tree
balanced-tree

(tree->list-1 unbalanced-tree)
(tree->list-1 balanced-tree)

(tree->list-2 unbalanced-tree)
(tree->list-2 balanced-tree)

(and
 (equal? (tree->list-1 tr-1) (tree->list-2 tr-1))
 (equal? (tree->list-1 tr-2) (tree->list-2 tr-2))
 (equal? (tree->list-1 tr-3) (tree->list-2 tr-3)))

; a. Do the two procedures produce the same result for every tree? If not, how do the results differ? What lists do the two procedures produce for the trees in Figure 2.16?
; Both procedures produce the same list for all trees: '(1 3 5 7 9 11)

; b. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with n elements to a list? If not, which one grows more slowly?
; tree->list-1 uses recursion together with append. Recursive calls cost log n, and append at worst appends n elements, so it's O(n logn)
; tree->list-2 uses iterative approach O(n).
