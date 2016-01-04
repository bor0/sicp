; Exercise 1.32.
; a. Show that sum and product (exercise 1.31) are both special cases of a still more general notion called accumulate that combines a collection of terms, using some general accumulation function: (accumulate combiner null-value term a next b). Accumulate takes as arguments the same term and range specifications as sum and product, together with a combiner procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a null-value that specifies what base value to use when the terms run out. Write accumulate and show how sum and product can both be defined as simple calls to accumulate.
(define (inc x) (+ x 1))
(define (identity x) x)

(define (product f a next b)
  (if (> a b)
      1
      (* (f a)
         (product f (next a) next b))))

(define (sum f a next b)
  (if (> a b)
      0
      (+ (f a)
         (sum f (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
          (accumulate combiner null-value term (next a) next b))))

(define (sum-accumulate f a next b) (accumulate + 0 f a next b))
(define (product-accumulate f a next b) (accumulate * 1 f a next b))

(define (compare-sum-product a b)
  (and
   (=
    (sum-accumulate identity a inc b)
    (sum identity a inc b))
   (=
    (product-accumulate identity a inc b)
    (product identity a inc b))))

(and
 (compare-sum-product 1 10)
 (compare-sum-product 2 20)
 (compare-sum-product 50 100))

; b. If your accumulate procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.
(define (accumulate-iter combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate-iter combiner (combiner a null-value) term (next a) next b)))

(define (sum-accumulate-iter f a next b) (accumulate-iter + 0 f a next b))
(define (product-accumulate-iter f a next b) (accumulate-iter * 1 f a next b))

(define (compare-sum-product-iter a b)
  (and
   (=
    (sum-accumulate-iter identity a inc b)
    (sum identity a inc b))
   (=
    (product-accumulate-iter identity a inc b)
    (product identity a inc b))))

(and
 (compare-sum-product-iter 1 10)
 (compare-sum-product-iter 2 20)
 (compare-sum-product-iter 50 100))
