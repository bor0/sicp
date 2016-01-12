; Exercise 2.27. Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well.
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse l)
  (define (rev-list list1 tmp)
    (if (null? list1)
        tmp
        (rev-list (cdr list1) (append (list (car list1)) tmp))))
  (rev-list l (list)))

(define (identity x) x)

(define (deep-reverse l)
  (define (rev-list list1 tmp)
    (if (null? list1)
        tmp
        (let ((f (if (pair? (car list1)) ; is it a sublist?
                     deep-reverse ; if it is, reverse it too
                     identity))) ; if it isn't, just pass it along
          (rev-list (cdr list1) (append (list (f (car list1))) tmp)))))
  (rev-list l (list)))

; For example,

(define x (list (list 1 2) (list 3 4)))

(reverse x) ; ((3 4) (1 2))
(deep-reverse x) ; ((4 3) (2 1))
