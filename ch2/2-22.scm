; Exercise 2.22. Louis Reasoner tries to rewrite the first square-list procedure of exercise 2.21 so that it evolves an iterative process:
(define (square n) (* n n))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

; Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?
; It is so because we're iteratively doing (cons X answer).
; First iteration, we have answer = '() and we do (cons X answer), so answer = '(X)
; Next iteration, we have answer = '(X), and we do (cons Y answer), so answer = '(Y X)

; Louis then tries to fix his bug by interchanging the arguments to cons:
(define (square-list-iter items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items null))

; This doesn’t work either. Explain.
; It is so because we're iteratively doing (cons answer X).
; First iteration, we have answer = '() and we do (cons answer X), so answer = pair of '() and X, i.e. (car answer) = '(), (cdr answer) = X
; Next iteration, we have answer = '(() . X), and we do (cons answer Y), so answer = '((() . X) . Y), i.e. (car answer) is pair from first iteration, (cdr answer) is Y.
