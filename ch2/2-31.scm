; Exercise 2.31. Abstract your answer to exercise 2.30 to produce a procedure tree-map with the property that square-tree could be defined as
(define (square-tree tree) (tree-map square tree))
(define (square n) (* n n))

(define (tree-map f tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (f tree))
        (else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree))))))

(equal? '(1 (4 (9 16) 25) (36 49))
   (square-tree
    (list 1
          (list 2 (list 3 4) 5)
          (list 6 7))))
