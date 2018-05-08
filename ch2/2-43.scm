#lang racket
; Exercise 2.43: Louis Reasoner is having a terrible time doing Exercise 2.42. His queens procedure seems to work, but it runs extremely slowly. (Louis never does manage to wait long enough for it to solve even the 6 × 6 case.) When Louis asks Eva Lu Ator for help, she points out that he has interchanged the order of the nested mappings in the flatmap.

(define empty-board '())
(define safe? '())
(define adjoin-position '())
(define flatmap '())
(define enumerate-interval '())

; Old:
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens) (map (lambda (new-row)
                                          (adjoin-position new-row k rest-of-queens))
                                        (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; Interchanged:
(define (queens-2 board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (new-row) (map (lambda (rest-of-queens)
                                   (adjoin-position new-row k rest-of-queens))
                                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

; Explain why this interchange makes the program run slowly.
; The first implementation recurses adjoin-position on every interval, and then on queen-cols.
; The second implementation recurses queen-cols on every adjoin-position, and then on interval.
;
; In queens, rest-of-queens is calculated once and re-used for every new adjoined position.
; The optimal way then is to only recurse on the main function whenever the calculation for adjoin-position and enumerate-interval is already done.

; Estimate how long it will take Louis’s program to solve the eight-queens puzzle, assuming that the program in Exercise 2.42 solves the puzzle in time T.
; O(queens)   = T
; O(queens-2) = board-size^2 * T, since on every recursion there are board-size * board-size sub-recursions
