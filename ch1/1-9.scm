; Each of the following two procedures defines a method for adding two positive integers in terms of the procedures inc, which increments its argument by 1, and dec, which decrements its argument by 1.
(define (plus1 a b)
  (if (= a 0)
      b
      (inc (plus1 (dec a) b))))

(define (plus2 a b)
  (if (= a 0)
      b
      (plus2 (dec a) (inc b))))

; Q: Using the substitution model, illustrate the process generated by each procedure in evaluating (+ 4 5).
; (plus1 4 5) = (inc (plus1 3 5)) = (inc (inc (plus1 2 5))) = (inc (inc (inc (plus1 1 5)))) = (inc (inc (inc (inc (plus1 0 5)))))
; = (inc (inc (inc (inc 5)))) = (inc (inc (inc 6))) = (inc (inc 7)) = (inc 8) = 9

; (plus2 4 5) = (plus2 3 6) = (plus2 2 7) = (plus2 1 8) = (plus2 0 9)

; Q: Are these processes iterative or recursive?
; plus1 is recursive, because it defers the inc computation until evaluation is finished.
; plus2 is iterative, because it uses tail-call, i.e. it doesn't defer any computation.
