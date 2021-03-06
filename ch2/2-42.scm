; Exercise 2.42: "Eight-queens puzzle" asks how to place eight queens on a chessboard so that no queen is in check from any other (i.e., no two queens are in the same row, column, or diagonal). One way to solve the puzzle is to work across the board, placing a queen in each column. Once we have placed k − 1 queens, we must place the kth queen in a position where it does not check any of the queens already on the board. We can formulate this approach recursively: Assume that we have already generated the sequence of all possible ways to place k − 1 queens in the first k − 1 columns of the board. For each of these ways, generate an extended set of positions by placing a queen in each row of the kth column. Now filter these, keeping only the positions for which the queen in the kth column is safe with respect to the other queens.

#lang racket
(require racket/struct)

(define-struct pair (fst snd)
  #:methods gen:custom-write
    [(define write-proc
       (make-constructor-style-printer
        (lambda (obj) 'point)
        (lambda (obj) (list (pair-fst obj) (pair-snd obj)))))])

(define (queen-row? p1 p2) (not (= (pair-fst p1) (pair-fst p2))))
(define (queen-col? p1 p2) (not (= (pair-snd p1) (pair-snd p2))))

#|
A3 _a_  A4
  |  /|
a | / | a
  |/__|
A1  a   A2

A1 = (x, y)
A2 = (x + a, y)
A3 = (x, y + a)
A4 = (x + a, y + a)

In a square, A1 and A4 are diagonal. The difference between their coordinates is:
(x + a - x, y + a - y) = (a, a). That is, if |x1 - x2| = |y1 - y2| then (x1, y1) is diagonal with (x2, y2)
|#
(define (queen-diagonal? p1 p2) (not (= (abs (- (pair-fst p1) (pair-fst p2))) ; two points are diagonally
                                    (abs (- (pair-snd p1) (pair-snd p2))))))  ; aligned iff |x1-x2|=|y1-y2|

(define empty-board '())
(define (safe? k positions)
  (let ([new-queen-pos (car (filter (lambda (x) (= (pair-snd x) k)) positions))]
        [other-queens (filter (lambda (x) (not (= (pair-snd x) k))) positions)])
    (andmap (lambda (x) (eq? x #t))
            (append (map (lambda (queen) (queen-row? new-queen-pos queen)) other-queens)
                    (map (lambda (queen) (queen-col? new-queen-pos queen)) other-queens)
                    (map (lambda (queen) (queen-diagonal? new-queen-pos queen)) other-queens)))))
  
(define (adjoin-position new-row k rest-of-queens) (cons (make-pair new-row k) rest-of-queens))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens) (map (lambda (new-row)
                                          (adjoin-position
                                           new-row k rest-of-queens))
                                        (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(eq? 92 (length (queens 8)))
