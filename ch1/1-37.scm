; Exercise 1.37.
; a. An infinite continued fraction is an expression of the form f = N_1/(D_1 + N_2/(D_2 + N_3/(D_3 + ...))).
; As an example, one can show that the infinite continued fraction expansion with the N_i and the D_i all equal to 1 produces 1/Phi, where Phi is the golden ratio (described in section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation -- a so-called k-term finite continued fraction -- has the form N_1/(D_1 + N_2/(... + N_k/D_k)).
(define (cont-frac n d k)
  (define (cf-i i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (cf-i (+ i 1))))))
  (cf-i 1))

; Suppose that n and d are procedures of one argument (the term index i) that return the N_i and D_i of the terms of the continued fraction. Define a procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k-term finite continued fraction. Check your procedure by approximating 1/Phi using
(define (one-over-phi k)
  (cont-frac
   (lambda (i) 1.0)
   (lambda (i) 1.0)
   k))
; for successive values of k.
; Q: How large must you make k in order to get an approximation that is accurate to 4 decimal places?
; 1/Phi = 0.61803398875
(one-over-phi 10) ; 0.6179775280898876
(one-over-phi 11) ; 0.6180555555555556
; The answer is k = 11.

; b. If your cont-frac procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.
(define (cont-frac-iter n d k)
  (define (cf-iter n d k t)
    (if (= k 0)
        t
        (cf-iter n d (- k 1) (/ (n k) (+ (d k) t)))))
  (cf-iter n d k 0))

(define (one-over-phi-iter k)
  (cont-frac-iter
   (lambda (i) 1.0)
   (lambda (i) 1.0)
   k))

(and
 (=
  (one-over-phi 10)
  (one-over-phi-iter 10))
 (=
  (one-over-phi 11)
  (one-over-phi-iter 11)))
