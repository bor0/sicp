; Exercise 1.12. The following pattern of numbers is called Pascal’s triangle.
#|
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
|#

; The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it. Write a procedure that computes elements of Pascal’s triangle by means of a recursive process.

(define (factorial n)
  (cond
    ((< n 0) (error "Negative number in factorial!"))
    ((= n 0) 1)
    (else (* n (factorial (- n 1))))))

(define (choose n k)
  (/ (factorial n) (* (factorial k) (factorial (- n k)))))

(define (pascal row col)
  (choose row col))

;#|
;Widely used answer:
(define (pascal-triangle row col)
    (if (or (= col 0) (= col row))
        1
        (+ (pascal-triangle (- row 1) (- col 1))
           (pascal-triangle (- row 1) col))))
;|#
