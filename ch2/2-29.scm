; Exercise 2.29. A binary mobile consists of two branches, a left branch and a right branch. Each branch is a rod of a certain length, from which hangs either a weight or another binary mobile. We can represent a binary mobile using compound data by constructing it from two branches (for example, using list):
(define (make-mobile left right)
  (list left right))
;  (cons left right))

; A branch is constructed from a length (which must be a number) together with a structure, which may be either a number (representing a simple weight) or another mobile:
(define (make-branch length structure)
  (list length structure))
;  (cons length structure))

(define test
  (make-mobile (make-branch 1 3)
               (make-branch (make-mobile (make-branch 3 4)
                                         (make-branch 5 6))
                            (make-mobile (make-branch 6 7)
                                         (make-branch 7 8)))))

; a. Write the corresponding selectors left-branch and right-branch, which return the branches of a mobile, and branch-length and branch-structure, which return the components of a branch.
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (car (cdr mobile)))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (car (cdr branch)))

; b. Using your selectors, define a procedure total-weight that returns the total weight of a mobile.
(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((pair? mobile) (+ (total-weight (left-branch mobile))
                           (total-weight (right-branch mobile))))
        (else mobile)))

; c. A mobile is said to be balanced if the torque applied by its top-left branch is equal to that applied by its top-right branch (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off its branches is balanced. Design a predicate that tests whether a binary mobile is balanced.
(define (branch-balanced? b1 b2)
  (=
   (* ((if (pair? (branch-structure b1)) total-weight identity) (branch-structure b1)) (branch-length b1))
   (* ((if (pair? (branch-structure b2)) total-weight identity) (branch-structure b2)) (branch-length b2))))

; d. Suppose we change the representation of mobiles so that the constructors are
(define (make-mobile-2 left right)
  (cons left right))

(define (make-branch-2 length structure)
  (cons length structure))
; How much do you need to change your programs to convert to the new representation?
; Only need to change the selectors right-branch and branch-structure to not be car of cdr, only cdr.
