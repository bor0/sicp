#lang planet neil/sicp

; Exercise 1.24. Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime? (the Fermat method), and test each of the 12 primes you found in that exercise. 
(define (square n) (* n n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

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
1021 *** 34
1031 *** 26
1033 *** 25
|#
;(search-for-primes 11000 11048)
#|
11003 *** 40
11027 *** 34
11047 *** 35
|#
;(search-for-primes 100000 100045)
#|
100003 *** 43
100019 *** 43
100043 *** 45
|#
;(search-for-primes 1000000 1000038)
#|
1000003 *** 51
1000033 *** 48
1000037 *** 53
|#

; Q: Since the Fermat test has O(log n) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?
; In this test since I'm doing the try 10 times, we can divide the values by 10:
; Values for previous test: (5, 12, 34.33, 107.33)
; Values for current test:  (2.833, 3.633, 4.366, 5.066)
; Seems to match the logarithmic value of 10^n.
