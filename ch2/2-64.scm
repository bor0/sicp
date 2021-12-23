#lang racket
;Exercise 2.64: The following procedure list->tree converts an ordered list to a balanced binary tree. The helper procedure partial-tree takes as arguments an integer n and list of at least n elements and constructs a balanced tree containing the first n elements of the list. The result returned by partial-tree is a pair (formed with cons) whose car is the constructed tree and whose cdr is the list of elements not included in the tree.
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (letrec
          ((left-size (quotient (- n 1) 2))
           (left-result (partial-tree elts left-size))
           (left-tree (car left-result))
           (non-left-elts (cdr left-result))
           (right-size (- n (+ left-size 1)))
           (this-entry (car non-left-elts))
           (right-result (partial-tree (cdr non-left-elts) right-size))
           (right-tree (car right-result))
           (remaining-elts (cdr right-result)))
        (cons (make-tree this-entry
                         left-tree
                         right-tree)
              remaining-elts))))

; a. Write a short paragraph explaining as clearly as you can how partial-tree works. Draw the tree produced by list->tree for the list (1 3 5 7 9 11).
(list->tree '(1 3 5 7 9 11))
#|
    5
   / \
  3   9
 /   / \
1   7   11
|#

; b. What is the order of growth in the number of steps required by list->tree to convert a list of n elements?
; T(n) = T(n/2)      + T(n/2)       + const
; tree   left-result   right-result
; T(n) = 2T(n/2) + const
; T(n/2) = 2T(n/4) + const
; T(n/4) = 2T(n/8) + const
; ...
; T(n) = 2[2T(n/4) + const] + const
; T(n) = 2[2[2T(n/8) + const] + const] + const
; ...
; T(n) = 2^k T(n/2^k) + (2^k - 1)const
; n/2^k = 1 -> 2^k = n -> k = log_2(n) -> T(n) = nT(1) + n - 1 -> T(n) = n*1 + n - 1 = 2n - 1
;
; The result is O(n)