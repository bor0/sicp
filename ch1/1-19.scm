#lang racket
; Exercise 1.19. There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps. Recall the transformation of the state variables a and b in the fib-iter process of section 1.2.2: a <- a + b and b <- a. Call this transformation T, and observe that applying T over and over again n times, starting with 1 and 0, produces the pair Fib(n + 1) and Fib(n). In other words, the Fibonacci numbers are produced by applying T^n, the nth power of the transformation T, starting with the pair (1,0). Now consider T to be the special case of p = 0 and q = 1 in a family of transformations T_pq, where T_pq transforms the pair (a,b) according to a <- bq + aq + ap and b <- bp + aq. Show that if we apply such a transformation T_pq twice, the effect is the same as using a single transformation T_p’q’ of the same form, and compute p’ and q’ in terms of p and q. This gives us an explicit way to square these transformations, and thus we can compute T^n using successive squaring, as in the fast-expt procedure. Put this all together to complete the following procedure, which runs in a logarithmic number of steps:
#|
T_pq :=
  a_new <- q(a + b) + p(a)
  b_new <- q(a) + p(b)

(T_pq)^2 :=
  a_new' <- q(a_new + b_new) + p(a_new)
  b_new' <- q(a_new) + p(b_new)
->
  a_new' <- q(q(a + b) + p(a) + q(a) + p(b)) + p(q(a + b) + p(a))
  b_new' <- q(q(a + b) + p(a)) + p(q(a) + p(b))
->
  a_new' <- qqa + qqb + qpa + qqa + qpb + pqa + pqb + ppa
  b_new' <- qqa + qqb + qpa + pqa + ppb
->
  a_new' <- 2(aqq + apq + bpq) + bqq + app
  b_new' <- 2apq + aqq + bqq + bpp

So the trick is to get (a_new', b_new') = T_p'q' in the form of (a_new, b_new) = T_pq
i.e. b_new = bp + aq so b_new' = bp' + aq', and we find p' and q' from the given equations a_new' and b_new'

So,
a_new' = q'(a + b) + p'(a)
b_new' = q'(a) + p'(b)

b_new' is shorter for manipulation, so we go with it:
q'(a) + p'(b) = 2apq + aq^2 + bq^2 + bp^2
q'(a) + p'(b) = a(2pq + q^2) + b(q^2 + p^2)

So from this we get:
q' = 2pq + q^2
p' = q^2 + p^2

|#

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
;                   <??> ; compute p’
;                   <??> ; compute q’
                   (+ (* q q) (* p p)) ; compute p'
                   (+ (* 2 p q) (* q q)) ; compute q’
                   (/ count 2)))
                   (else (fib-iter (+ (* b q) (* a q) (* a p))
                                   (+ (* b p) (* a q))
                                   p
                                   q
                                   (- count 1)))))
