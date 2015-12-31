; Exercise 1.4. Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

#|
We will consider the following two cases:
b > 0:
(a-plus-abs-b a b) = ((if (> b 0) + -) a b)) = (+ a b)
b < 0:
(a-plus-abs-b a b) = ((if (> b 0) + -) a b)) = (- a b)
We can conclude that the output is a + |b|

In this example we can see how we can use procedures as a returning value.
|#
