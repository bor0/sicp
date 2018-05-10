#lang racket
; Exercise 2.52: Make changes to the square limit of wave shown in Figure 2.9 by working at each of the levels de- scribed above. In particular:
; Copied from http://www.billthelizard.com/2012/02/sicp-252-levels-of-language-for-robust.html
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

; Add some segments to form a smile (2.52a)
(define wave-segments
  (list
   (make-segment
    (make-vect 0.006 0.840)
    (make-vect 0.155 0.591))
   (make-segment
    (make-vect 0.006 0.635)
    (make-vect 0.155 0.392))
   (make-segment
    (make-vect 0.304 0.646)
    (make-vect 0.155 0.591))
   (make-segment
    (make-vect 0.298 0.591)
    (make-vect 0.155 0.392))
   (make-segment
    (make-vect 0.304 0.646)
    (make-vect 0.403 0.646))
   (make-segment
    (make-vect 0.298 0.591)
    (make-vect 0.354 0.492))
   (make-segment ; left face
    (make-vect 0.403 0.646)
    (make-vect 0.348 0.845))
   (make-segment
    (make-vect 0.354 0.492)
    (make-vect 0.249 0.000))
   (make-segment
    (make-vect 0.403 0.000)
    (make-vect 0.502 0.293))
   (make-segment
    (make-vect 0.502 0.293)
    (make-vect 0.602 0.000))
   (make-segment
    (make-vect 0.348 0.845)
    (make-vect 0.403 0.999))
   (make-segment
    (make-vect 0.602 0.999)
    (make-vect 0.652 0.845))
   (make-segment
    (make-vect 0.652 0.845)
    (make-vect 0.602 0.646))
   (make-segment
    (make-vect 0.602 0.646)
    (make-vect 0.751 0.646))
   (make-segment
    (make-vect 0.751 0.646)
    (make-vect 0.999 0.343))
   (make-segment
    (make-vect 0.751 0.000)
    (make-vect 0.597 0.442))
   (make-segment
    (make-vect 0.597 0.442)
    (make-vect 0.999 0.144))
   (make-segment ; eye
    (make-vect 0.395 0.916)
    (make-vect 0.410 0.916))
   (make-segment ; smile
    (make-vect 0.376 0.746)
    (make-vect 0.460 0.790))))

; The wave painter (2.49d).
(define wave
  (segments->painter wave-segments))

(define (split what where)
  (define (splitter painter n)
    (if (= n 0)
        painter
        (let ((smaller (splitter painter (- n 1))))
          (what painter (where smaller smaller)))))
  splitter)

(define right-split (split beside below))
(define up-split (split below beside))

; Change the pattern constructed by corner-split (for example, by using only one copy of the up-split and right-split images instead of two)
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
        (beside (below painter up)
                (below right corner)))))

; Modify the version of square-limit that uses square-of-four so as to assemble the corners in a different pattern. (For example, you might make the big Mr. Rogers look outward from each corner of the square.)
(define (square-limit painter n)
  (let ((quarter (rotate180 (corner-split painter n))))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(paint wave)
(paint (corner-split wave 2))
(paint (square-limit wave 2))
