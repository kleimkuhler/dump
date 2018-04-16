(define-syntax let*
  (syntax-rules ()
    [(_ () b1 b2 ...) (let () b1 b2 ...)]
    [(_ ((i1 e1) (i2 e2) ...) b1 b2 ...)
     (let ([i1 e1])
       (let* ([i2 e2] ...) b1 b2 ...))]))

;; (let ([f (lambda (x) (+ x 1))])
;;   (let-syntax ([f (syntax-rules ()
;; 		    [(_ x) x])]
;; 	       [g (syntax-rules ()
;; 		    [(_ x) (f x)])])
;;     (list (f 1) (g 1)))) => (1 2)

;; If the above used `letrec-syntax`, it would evaluate to (1 1)

(define-syntax or
  (syntax-rules ()
    [(_) #f]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (let ([t e1]) (if t t (or e2 e3 ...)))]))
