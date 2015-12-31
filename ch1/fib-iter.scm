#| Bonus fib-iter proof

Given:
f(0) = 0
f(1) = 1
f(n) = f(n-1) + f(n-2)

The iterative version is:
a_new <- a + b
b_new <- a

To show that applying this transformation n times gives a = Fib(n+1) and b = Fib(n),
we proceed as follows:

Assume we start with (0, 1) and apply T_pq once: (1, 0)
Applying it twice: (1, 1)
Applying it thrice: (2, 1)

To show that (T_pq)^n is (Fib(n+1), Fib(n)), we use induction on n.

Assume (T_pq)^n is (Fib(n+1), Fib(n)), i.e. (f(n+1), f(n)).
We need to show that (T_pq)^(n+1) is (Fib(n+2), Fib(n+1)), using the iterative definitions:
(f(n+1) + f(n), f(n+1)) = (f(n+2), f(n+1))
|#
