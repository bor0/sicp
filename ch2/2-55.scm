#lang racket
; Exercise 2.55: Eva Lu Ator types to the interpreter the expression
(car ''abracadabra)

; To her surprise, the interpreter prints back quote. Explain.

; This is equivalent to
(car (quote (quote abracadabra)))

; So we are quoting the word quote, thus getting it as a result.