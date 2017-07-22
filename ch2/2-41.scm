; Exercise 2.41: Write a procedure to find all ordered triples of distinct positive integersi, j, and k less than or equal to a given integer n that sum to a given integer s.
(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

(define (all-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
	   (enumerate-interval 1 n)))
    (enumerate-interval 1 n)))

(define (all-triples n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (cons j i))
	   (enumerate-interval 1 n)))
    (all-pairs n)))

(define (distinct-to-sum n s)
  (filter
    (lambda (t)
      (let ((fst (car t))
	    (snd (cadr t))
	    (trd (caddr t)))
	(and (<> fst snd)
	     (<> fst trd)
	     (<> snd trd)
	     (= s (+ fst snd trd)))))
    (all-triples n)))
