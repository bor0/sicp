; Exercise 1.33. You can obtain an even more general version of accumulate (exercise 1.32) by introducing the notion of a filter on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting filtered-accumulate abstraction takes the same arguments as accumulate, together with an additional predicate of one argument that specifies the filter. Write filtered-accumulate as a procedure.

(define (square n) (* n n))
(define (inc x) (+ x 1))
(define (identity x) x)

(define (accumulate combiner null-value term a next b predicate)
  (if (> a b)
      null-value
      (if (predicate a)
           (combiner (term a) (accumulate combiner null-value term (next a) next b predicate))
           (accumulate combiner null-value term (next a) next b predicate))))

; Show how to express the following using filtered-accumulate:
; a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)
(define (prime? x)
  (cond ((= x 1) #t)
        ((= x 2) #t)
        ((= x 3) #t)
        ((= x 5) #t)
        ((= x 7) #t)
        (else #f)))

(=
 (accumulate + 0 square 1 inc 10 prime?)
 (+ (square 1) (square 2) (square 3) (square 5) (square 7)))

; b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1)
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-relative-primes n)
  (define (coprime? i) (= 1 (gcd i n)))
  (accumulate * 1 identity 1 inc (- n 1) coprime?))

(=
 (product-relative-primes 5)
 (* 1 2 3 4))
