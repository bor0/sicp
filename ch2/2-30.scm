; Exercise 2.30. Define a procedure square-tree analogous to the square-list procedure of exercise 2.21. Define square-tree both directly (i.e., without using any higher-order procedures) and also by using map and recursion.
(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (* sub-tree sub-tree)))
       tree))

; That is, square-list should behave as follows:
(equal? '(1 (4 (9 16) 25) (36 49))
   (square-tree
    (list 1
          (list 2 (list 3 4) 5)
          (list 6 7))))

(equal? '(1 (4 (9 16) 25) (36 49))
   (square-tree-map
    (list 1
          (list 2 (list 3 4) 5)
          (list 6 7))))
