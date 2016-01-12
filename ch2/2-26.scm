; Exercise 2.26. Suppose we define x and y to be two lists:
(define x (list 1 2 3)) ; x = (cons 1 (cons 2 (cons 3 nil)))
(define y (list 4 5 6)) ; y = (cons 4 (cons 5 (cons 6 nil)))

; What result is printed by the interpreter in response to evaluating each of the following expressions:
(append x y) ; (1 2 3 4 5 6)
(cons x y) ; ((1 2 3) (4 5 6)) wrong. it's ((1 2 3) 4 5 6)
(list x y) ; (cons (1 2 3) (cons (4 5 6) nil)) = ((1 2 3) ((4 5 6))) wrong. it's ((1 2 3) (4 5 6))

; Try again by substitution model:

; append x y = (1 2 3 4 5 6)

; cons x y   = (cons (cons 1 (cons 2 (cons 3 nil)))
;                    (cons 4 (cons 5 (cons 6 nil))))
; (car (cons x y)) = (1 2 3)
; (cdr (cons x y)) = (4 5 6). So it's ((1 2 3) 4 5 6)

; list x y   = (cons x (cons y nil)) =
; = (cons (cons 1 (cons 2 (cons 3 nil)))
;         (cons (cons 4 (cons 5 (cons 6 nil))) nil))
; (car (list x y)) = (cons 1 (cons 2 (cons 3 nil))) = '(1 2 3)
; (cdr (list x y)) = (cons (cons 4 (cons 5 (cons 6 nil))) nil) = '((4 5 6))
; So it's '((1 2 3) (4 5 6))
