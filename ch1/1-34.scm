; Exercise 1.34. Suppose we define the procedure
(define (f g)
  (g 2))

(define (square n) (* n n))
; Then we have
(f square)
; 4
(f (lambda (z) (* z (+ z 1))))
; 6
  
; Q: What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
; Initially I thought (f f) = (f (f (f (f ... never reaches 2 ... ))))
; But then when I tried it
#|
> (f f)
. . application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments.:
> 
|#
; It evaluates to (f f) = (f 2) but 2 is expected to be procedure
; Modifying it to:
(define (f-2 g)
  (if (number? g)
      (error "No numbers!")
      (g 2)))

; Works fine.
