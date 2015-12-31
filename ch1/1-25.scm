#lang planet neil/sicp

; Exercise 1.25. Alyssa P. Hacker complains that we went to a lot of extra work in writingexpmod. After all, she says, since we already know how to compute exponentials, we could have simply written
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

#|
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
|#

(define (square n) (* n n))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (even? a) (= 0 (remainder a 2)))

(define (search-for-primes a b)
  (cond ((even? a) (search-for-primes (+ a 1) b))
        ((>= a b) (begin (newline) (display "done")))
        (else (begin (timed-prime-test a) (search-for-primes (+ a 2) b)))))

;(search-for-primes 1020 1035)
#|
1021 *** 199
1031 *** 176
1033 *** 169
|#
;(search-for-primes 11000 11048)
#|
11003 *** 6536
11027 *** 8091
11047 *** 5518
|#

; Q: Is she correct? Would this procedure serve as well for our fast prime tester? Explain.
; The times posted above are much higher than previous tests.
; In the previous version, we are using remainder for smaller and smaller numbers.
; In the current one, we call remainder only once but use it on large numbers.
