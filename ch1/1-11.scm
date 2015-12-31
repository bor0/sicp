; Exercise 1.11. A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>=3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.
(define (f n)
  (cond ((>= n 3) (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))
        (else n)))

#| Similar to the provided fib-iter proof:

f(0) = 0
f(1) = 1
f(2) = 2
f(3) = f(2) + 2f(1) + 3f(0) = 2 + 2 + 0 = 4
f(4) = f(3) + 2f(2) + 3f(1) = 4 + 4 + 3 = 7

Assume we start with (a, b, c) as initial transformations.

f(5) = f(4) + 2f(3) + 3f(2) = 7 + 8 + 6 = 21
       a      b       c

If we set a = f(3), b = f(2) and c = f(1), then for f(5) (the equation above) we can say that:
f(4) = a_new <- a + 2 b + 3 c
2f(3) = 2 b_new <- a
3f(2) = 3 c_new <- b

(define (f-iter a b c count)
  (if (= count 0)
      c
      (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1))))

Similar to fib-iter, we set 2 1 0 as our starting points, so we call (f-iter 2 1 0 n).
This information also gives us the base cases, so our final definition is:
|#

(define (f-iter-helper a b c count)
  (cond ((= count 2) a)
        ((= count 1) b)
        ((= count 0) c)
        (else (f-iter-helper (+ a (* 2 b) (* 3 c)) a b (- count 1)))))

(define (f-iter n) (f-iter-helper 2 1 0 n))

(and
  (= (f 0) (f-iter 0))
  (= (f 1) (f-iter 1))
  (= (f 2) (f-iter 2))
  (= (f 3) (f-iter 3))
  (= (f 4) (f-iter 4))
  (= (f 5) (f-iter 5))
  (= (f 6) (f-iter 6)))
