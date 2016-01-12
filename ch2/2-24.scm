; Exercise 2.24. Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give the result printed by the interpreter, the corresponding box-and-pointer structure, and the interpretation of this as a tree (as in figure 2.6).

#| Result: (1 (2 (3 4)))

Box-pointer notation:
My initial thought was:
☐☐
| \
1 ☐☐
  | \
  2 ☐☐
    | \
    3 4
but then I tested it:
> (cons 1 (cons 2 (cons 3 4)))
'(1 2 3 . 4)
> (equal? (cons 1 (cons 2 (cons 3 4))) (list 1 (list 2 (list 3 4))))
#f
This is the left-associative list by default. We need to go with right-associative.
> (car (list 1 (list 2 (list 3 4))))
1
> (cdr (list 1 (list 2 (list 3 4))))
'((2 (3 4)))
> (car (cdr (list 1 (list 2 (list 3 4)))))
'(2 (3 4))
> (cdr (cdr (list 1 (list 2 (list 3 4)))))
'()

So the box-pointer notation is different. It is:

☐☐
| \
1 ☐☐ - nil
  |
  ☐☐
  | \
  2 ☐☐ - nil
    |
    ☐☐
    | \
    3 ☐☐ - nil
      |
      4

Tree:
(1 (2 (3 4)))
    /  \
    1  (2 (3 4))
          /  \
          2  (3 4)
              /  \
              3  4

|#
