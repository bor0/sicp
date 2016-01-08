; Exercise 1.27. Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. That is, write a procedure that takes an integer n and tests whether a^n is congruent to a modulo n for every a<n, and try your procedure on the given Carmichael numbers.

(define (fermat-test n)
  (define (f-test a)
    (cond ((= a 1) #t)
          ((= (remainder (- (expt a n) a) n) 0) (f-test (- a 1)))
          (else #f)))
  (f-test n))

(and
 (fermat-test 561)
 (fermat-test 1105)
 (fermat-test 1729)
 (fermat-test 2465)
 (fermat-test 2821)
 (fermat-test 6601))

(fermat-test 123)
