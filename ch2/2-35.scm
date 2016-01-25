; Exercise 2.35. Redefine count-leaves from section 2.2.2 as an accumulation:
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (count-leaves-accumulate t)
  (accumulate f-accumulate 0 (map identity t)))

(define (f-accumulate current rest)
  (if (pair? current)
      (count-leaves-accumulate current)
      (+ 1 rest)))

; Another way:
(define (count-leaves-accumulate-2 t)
  (accumulate (lambda (current rest) (+ current rest)) 0 (map f-map t)))

(define (f-map x)
  (if (pair? x)
      (count-leaves-accumulate-2 x)
      1))

(count-leaves (list 1 (list 2 (list 3 4))))
(count-leaves-accumulate (list 1 (list 2 (list 3 4))))
(count-leaves-accumulate-2 (list 1 (list 2 (list 3 4))))
