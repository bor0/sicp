; Bonus Tower of Hanoi
(define (display-move from to)
  (begin
    (display "Moving from ")
    (display from)
    (display " to ")
    (display to)
    (newline)))

; 1. Implement recursive procedure for solving the Tower of Hanoi
(define (hanoi from to spare count)
  (if (= count 1)
      (display-move from to)
      (begin
        (hanoi from spare to (- count 1))
        (display-move from to)
        (hanoi spare to from (- count 1)))))

; 2. Implement iterative procedure for solving the Tower of Hanoi
#|
Alternating between the smallest and the next-smallest disks, follow the steps for the appropriate case:

For an even number of disks:
1. make the legal move between pegs A and B
2. make the legal move between pegs A and C
3. make the legal move between pegs B and C
4. repeat until complete

For an odd number of disks:
1. make the legal move between pegs A and C
2. make the legal move between pegs A and B
3. make the legal move between pegs C and B
4. repeat until complete
|#
