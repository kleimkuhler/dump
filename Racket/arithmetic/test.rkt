#lang arith

1
(+ 1 1)
(+ (+ 1 2) (+ 3 4))

(- 1 1)
(- 10 5)
(* 2 3)
(/ 10 2)

"foo"

#t
#f
#true
#false

(if #t then 0 else 1)

(define-function (f x) (+ x 1))
(function-app f 2)