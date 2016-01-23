; Exercise 2.32. We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists. For example, if the set is (1 2 3), then the set of all subsets is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following definition of a procedure that generates the set of subsets of a set and give a clear explanation of why it works:
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (f s) rest)))))

; The solution is (lambda (x) (cons (car s) x)). To give a clear explanation, I used a function similar to this:
(define (f s)
  (lambda (x)
    (display s)
    (newline)
    (display x)
    (newline)
    (newline)
    (cons (car s) x)))

#|
If we run it for '(1 2), we can see what's going on:
> (subsets '(1 2))
(2)
()

(1 2)
()

(1 2)
(2)

'(() (2) (1) (1 2))
=======
I had to rewrite the function in Haskell to get a better picture:
f [] = [[]]
f (x:xs) = (f xs) ++ map (x :) (f xs)

E.g: f [1, 2] = f [2] ++ [1 consed onto every f [2]]
First calculate f[2] = ((f []) ++ [2]) = [[]] ++ [2]
Then:
f [1, 2] = [[]] ++ [2] ++ [1:[]] ++ [1:[2]]

The function works because it recursively adds the first element of a list L
to each of the subsets of the rest of that list L, which is the definition of powerset itself.

This exercise clearly showed me that Haskell is much more readable than Lisp is.
|#
