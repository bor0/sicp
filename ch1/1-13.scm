; Exercise 1.13. Prove that Fib(n) is the closest integer to Phi^n/sqrt(5), where Phi = (1 + sqrt(5))/2. Hint: Let Psi = (1 - sqrt(5))/2. Use induction and the definition of the Fibonacci numbers (see section 1.2.2) to prove that Fib(n) = (Phi^n - Psi^n)/sqrt(5).
#|
Definition:

Fib(n) = 0, if n = 0
Fib(n) = 1, if n = 1
Fib(n) = Fib(n - 1) + Fib(n - 2), otherwise

Using induction:
Case n = 0:
Fib(0) = 0 = (Phi^0 - Psi^0)/sqrt(5) = 0

Assume it holds for n = k, and n = k + 1:
Fib(k) = Fib(k - 1) + Fib(k - 2) = (Phi^(k - 1) - Psi^(k - 1))/sqrt(5) + (Phi^(k - 2) - Psi^(k - 2))/sqrt(5)
Fib(k + 1) = Fib(k) + Fib(k - 1) = (Phi^k - Psi^k)/sqrt(5) + (Phi^(k - 1) - Psi^(k - 1))/sqrt(5)

Given the above assumptions, prove that it holds for n = k + 2.

Fib(n + 2) = Fib(n + 1) + Fib(n) ; according to the definitions of Fib(n)
It can be shown that this equals to
(Phi^(n + 2) - Psi^(n + 2))/sqrt(5), by rewriting Fib(n + 1) and Fib(n) to what we assumed above.
That will complete the proof that Fib(n) = (Phi^n - Psi^n)/sqrt(5).

To prove that Fib(n) is the closest integer to Phi^n/sqrt(5), we will find the delta
s.t. Fib(n) = delta Phi^n/sqrt(5)
Phi^n - Psi^n = delta Phi^n

and conclude that it is small:
delta = 1 - (Psi/Phi)^n
|#
