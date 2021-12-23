#lang racket
; Exercise 2.58: Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, in which + and * are infix rather than prefix operators.
; Since the differentiation program is defined in terms of abstract data, we can modify it to work with different representations of expressions solely by changing the predicates,
; selectors, and constructors that define the representation of the algebraic expressions on which the differentiator is to operate.

; The problem becomes substantially harder if we allow standard algebraic notation, such as (x + 3 * (x + y + 2)), which drops unnecessary parentheses and assumes that multiplication is done before addition. Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?

; Approaching this as follows:
; 1. Modify the original expression `add-precedence-expr` to add parenthesis for *
; 2. Use `transform-expr` on this modified expression to convert infix to prefix
; Probably inefficient, but it should work

(define foo1 '(a + b + c + b * c + d))
(define foo2 '(a * b))
(define foo3 '(x + 3 * (x + y + 2)))

(define (precedence op)
  (cond ((member op '(+ -)) 1)
        ((member op '(*)) 2)
        ((member op '(^)) 3)
        (else -1)))

(define (operator? op)
  (not (false? (member op '(+ - * ^)))))

(define (transform-expr e)
  (cond ((or (null? e) (symbol? e) (number? e)) e)
        ((eq? (length e) 1) (transform-expr (car e)))
        (else
         (let ([op (cadr e)]
               [fstel (car e)]
               [remaining (cddr e)])
           (list op (transform-expr fstel) (transform-expr remaining))))))

(define (add-precedence-expr e)
  (cond ((null? e) e)
        ((< (length e) 3) e)
        (else
         (let ([op (cadr e)]
               [fstel (car e)]
               [sndel (caddr e)]
               [remaining (cddr e)]
               [remainingg (cdddr e)]
               )
           (if (eq? op '*)
               (cons (list fstel op sndel) (add-precedence-expr remainingg))
               (cons fstel (cons op (add-precedence-expr remaining))))))))

(define (process e) (transform-expr (add-precedence-expr e)))

(process foo1)
(process foo2)
(process foo3)
