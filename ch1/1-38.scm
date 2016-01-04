; Exercise 1.38. In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus Continuis, which included a continued fraction expansion for e - 2, where e is the base of the natural logarithms. In this fraction, the N i are all 1, and the D i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... Write a program that uses your cont-frac procedure from exercise 1.37 to approximate e, based on Euler’s expansion.
(define (cont-frac-iter n d k)
  (define (cf-iter n d k t)
    (if (= k 0)
        t
        (cf-iter n d (- k 1) (/ (n k) (+ (d k) t)))))
  (cf-iter n d k 1))

(define (cont-frac n d k)
  (define (cf-i i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (cf-i (+ i 1))))))
  (cf-i 1))

(define (deuler i)
  (let ((n (- i 1)))
  (if (= 0 (remainder (- n 1) 3))
      (/ (* 2 (+ n 2)) 3)
      1)))

(define (one a) 1.0)

(define (find-e k)
  (+ 2 (cont-frac-iter one deuler k)))

#|
> (find-e 1)
2.5
> (find-e 2)
2.75
> (find-e 3)
2.7142857142857144
> (find-e 7)
2.7181818181818183
> (find-e 10)
2.718282368249837
|#
