; Exercise 2.6. In case representing pairs as procedures wasn’t mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as
(define (inc-1 x) (+ x 1))

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician who invented the lambda calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to evaluate (add-1 zero)).
#|
(add-1 zero)
((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) x)))
((lambda (x) ((lambda (f) (lambda (x) x)) ((n (lambda (f) (lambda (x) x))) x))))
((lambda (x) ((lambda (f) (lambda (x) x)) ((n (lambda (f) (lambda (x) x))) x))))

... doesn't look like something we can easily calculate :) let's try lambda calculus notation instead:

zero := λfx.x
add-1 := λnfx.f ((n f) x) = left associative by default = λnfx.f (n f x)

(add-1 zero) = (λnfx.f (n f x)) λfx.x = λfx.f ((λfx.x) f x) = λfx.f x = one
Similarly, two can be calculated to get λfx.f (f x)

which is equal to:
|#
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; From here we can see the closeness between Lisp and Lambda calculus. Now we can do something like:
((one inc-1) 1) ; increase one once
((two inc-1) 1) ; increase one twice

; Give a direct definition of the addition procedure + (not in terms of repeated application of add-1).
; As defined on Wikipedia, plus := λmn.m add-1 n
(define plus (lambda (m) (lambda (n) ((m add-1) n))))

((((plus two) two) inc-1) 10) ; increase 10 (two plus two) times, i.e. 4 times.
