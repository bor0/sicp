; Exercise 2.40: Define a procedure unique-pairs that, given an integer n, generates the sequence of pairs (i, j) with 1 <= j < i <= n. Use unique-pairs to simplify the definition of prime-sum-pairs given above.
(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
	   (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
