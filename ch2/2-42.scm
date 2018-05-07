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