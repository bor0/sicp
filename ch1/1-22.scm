#lang planet neil/sicp

; Exercise 1.22. Most Lisp implementations include a primitive called runtime that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and checks to see if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.
(define (square n) (* n n))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

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

;Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of O(sqrt(n)), you should expect that testing for primes around 10,000 should take about sqrt(10) times as long as testing for primes around 1000. 

(search-for-primes 1020 1035)
#|
1021 *** 7
1031 *** 4
1033 *** 4
|#
(search-for-primes 11000 11048)
#|
11003 *** 12
11027 *** 12
11047 *** 12
|#
(search-for-primes 100000 100045)
#|
100003 *** 34
100019 *** 35
100043 *** 34
|#
(search-for-primes 1000000 1000038)
#|
1000003 *** 108
1000033 *** 107
1000037 *** 107
|#

; Q: Do your timing data bear this out?
; (7+4+4)/3 = 5. Multiply this by sqrt(10) (3.16) = 15.8. (12+12+12)/3 = 12. The delta is 3.8.

; Q: How well do the data for 100,000 and 1,000,000 support the n prediction?
; (34+35+34)/3 = 34.33. Multiply this by sqrt(10) (3.16) = 108.48. (108+107+107)/3 = 107.33. The delta is 1.15.

; Q: Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?
; Yes.
