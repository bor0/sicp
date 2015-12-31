; Exercise 1.20. The process that a procedure generates is of course dependent on the rules used by the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in section 1.1.5. (The normal-order-evaluation rule for if is described in exercise 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the remainder operations that are actually performed. How many remainder operations are actually performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

#| Normal order evaluation:
Fully expand then evaluate:
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40))) =
(if (= (remainder 206 40) 0) 206 (gcd (remainder 206 40) (remainder 206 (remainder 206 40)))) =
...

My initial guess was that it goes into an infinite loop, but it doesn't. It eventually evaluates (= (remainder x y) = 0).
My guess was wrong because if works the same in normal and applicative order, and this is hinted in the exercise.
Detailed explanation at http://www.billthelizard.com/2010/01/sicp-exercise-120-gcd.html
|#

#| Applicative order evaluation:
Evaluate then apply:
(gcd 206 40) =
(gcd (40 (remainder 206 40))) =
(gcd (40 6)) =
(gcd (6 (remainder 40 6))) =
(gcd (6 4)) =
(gcd (4 (remainder 6 4))) =
(gcd (4 2)) =
(gcd (2 (remainder 4 2))) =
(gcd (2 0)) = 2
|#
