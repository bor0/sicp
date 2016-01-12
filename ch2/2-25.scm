; Exercise 2.25. Give combinations of cars and cdrs that will pick 7 from each of the following lists:
; (1 3 (5 7) 9)
(car (cdr (car (cdr (cdr q)))))

; ((7))
(car (car q))

; (1 (2 (3 (4 (5 (6 7))))))
; I thought (cdr (cdr (cdr (cdr (cdr (cdr q))))))
; But cdr gives back a list, so we have a combination of car/cdrs. The answer is:
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr q))))))))))))

; This tells me that I need to think more about how cons is represented.
