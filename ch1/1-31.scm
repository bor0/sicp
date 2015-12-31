; Exercise 1.31.
; a. The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures. Write an analogous procedure called product that returns the product of the values of a function at points over a given range. Show how to define factorial in terms of product. Also use product to compute approximations to Pi using the formula:
; Pi/4 = 2*4*4*6*6**.../(3*3*5*5*7*7*...)
(define (identity x) x)
(define (inc x) (+ x 1))
(define (inc-two x) (+ x 2))
(define (square x) (* x x))

(define (product f a next b)
  (if (> a b)
      1
      (* (f a)
         (product f (next a) next b))))

(define (factorial n) (product identity 1 inc n))

(define (pi-approx n)
  (/
   (* 2 (square (product identity 4.0 inc-two n)))
   (square (product identity 3.0 inc-two (+ n 1)))))

; b. If your product procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.
(define (product-iter f a next b) 
  (define (iter a result)
    (if (> a b)
        result
        (iter (+ a 1) (* result (f a)))))
(iter a 1))
