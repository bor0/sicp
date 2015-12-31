#lang planet neil/sicp

; Exercise 1.23. The smallest-divisor procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for test-divisor should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ....
(define (square n) (* n n))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

; To implement this change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns its input plus 2.
(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

; Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1).
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (even? a) (= 0 (remainder a 2)))

(define (search-for-primes a b)
  (cond ((even? a) (search-for-primes (+ a 1) b))
        ((>= a b) (begin (newline) (display "done")))
        (else (begin (timed-prime-test a) (search-for-primes (+ a 2) b)))))

; With timed-prime-test incorporating this modified version of smallest-divisor, run the test for each of the 12 primes found in exercise 1.22.

(search-for-primes 1020 1035)
#|
1021 *** 6
1031 *** 3
1033 *** 4
|#
(search-for-primes 11000 11048)
#|
11003 *** 10
11027 *** 10
11047 *** 9
|#
(search-for-primes 100000 100045)
#|
100003 *** 29
100019 *** 29
100043 *** 29
|#
(search-for-primes 1000000 1000038)
#|
1000003 *** 86
1000033 *** 85
1000037 *** 86
|#

; Q: Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed?
; Values for previous test: (5, 12, 34.33, 107.33)
; Values for current test:  (4.33, 9.66, 29, 85.66)
; It runs faster, but not twice as.

; Q: If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?
; Ratios previous/current: (1.15, 1.24, 1.18, 1.25).
; The previous algorithm had order of growth O(sqrt(n)). This one has O(sqrt(n/2)) = O(sqrt(n)/sqrt(2)).
; [sqrt(n)] / [sqrt(n)/sqrt(2)] = sqrt(2) = ~1.41, and seems to be close to our previously calculated ratios.
