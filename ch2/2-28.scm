; Exercise 2.28. Write a procedure fringe that takes as argument a tree (represented as a list) and returns a list whose elements are all the leaves of the tree arranged in left-to-right order. For example,
(define x (list (list 1 2) (list 3 4)))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (fringe x)
  (cond ((null? x) x)
        ((pair? x) (append (fringe (car x)) (fringe (cdr x))))
        (else (list x))))

(fringe x) ; (1 2 3 4)
(fringe (list x x)) ; (1 2 3 4 1 2 3 4)
