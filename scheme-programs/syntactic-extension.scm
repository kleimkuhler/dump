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

;; (let ([if #f])
;;   (let ([t 'okay])
;;     (or if t))) => okay

;; `cond`: `syntax-rules` & auxiliary keywords
(define-syntax cond
  (syntax-rules (else)
    [(_ (else e1 e2 ...)) (begin e1 e2 ...)]
    [(_ (e0 e1 e2 ...)) (if e0 (begin e1 e2 ...))]
    [(_ (e0 e1 e2 ...) c1 c2 ...)
     (if e0 (begin e1 e2 ...) (cond c1 c2 ...))]))

;; (let ([ls (list 0)])
;;   (define-syntax a
;;     (identifier-syntax
;;      [id (car ls)]
;;      [(set! id e) (set-car! ls e)]))
;;   (let ([before a])
;;     (set! a 1)
;;     (list before a ls))) => (0 1 (1))

(define-syntax or
  (lambda (x)
    (syntax-case x ()
      [(_) #'#f]
      [(_ e) #'e]
      [(_ e1 e2 e3 ...)
       #'(let ([t e1]) (if t t (or e2 e3 ...)))])))

(define-syntax syntax-rules
  (lambda (x)
    (syntax-case x ()
      [(_ (i ...) ((keyword . pattern) template) ...)
       #'(lambda (x)
	   (syntax-case x (i ...)
	     [(_ . pattern) #'template] ...))])))

;; syntax-case with fender
(define-syntax let
  (lambda (x)
    (define ids?
      (lambda (ls)
	(or (null? ls)
	    (and (identifier? (car ls))
		 (ids? (cdr ls))))))
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (ids? #'(i ...))
       #'((lambda (i ...) b1 b2 ...) e ...)])))

;; syntax-case with free-identifier=? fender check for `else`
(define-syntax cond
  (lambda (x)
    (syntax-case x ()
      [(_ (e0 e1 e2 ...))
       (and (identifier #'e0) (free-identifier=? #'e0 #'else))
       #'(begin e1 e2 ...)]
      [(_ (e0 e1 e2 ...)) #'(if e0 (begin e1 e2 ...))]
      [(_ (e0 e1 e2 ...) c1 c2 ...)
       #'(if e0 (begin e1 e2 ...) (cond c1 c2 ...))])))

;; (let ([else #f])
;;   (cond-free [else (write "oops")]))

;; `else` is bound lexically so `cond-free` so `else` is not the same else that
;; appears in the definition of `cond-free`

(define-syntax with-syntax
  (lambda (x)
    (syntax-case x ()
      [(_ ((p e) ...) b1 b2 ...)
       #'(syntax-case (list e ...) ()
	   [(p ...) (let () b1 b2 ...)])])))

;; cond-with
;; (define-syntax cond-with
;;   (lambda (x)
;;     (syntax-case x ()
;;       [(_ c1 c2 ...)
;;        (let f ([c1 #'c1] [cmore #'(c2 ...)])
;;          (if (null? cmore)
;;              (syntax-case c1 (else =>)
;;                [(else e1 e2 ...) #'(begin e1 e2 ...)]
;;                [(e0) #'(let ([t e0]) (if t t))]
;;                [(e0 => e1) #'(let ([t e0]) (if t (e1 t)))]
;;                [(e0 e1 e2 ...) #'(if e0 (begin e1 e2 ...))])
;;              (with-syntax ([rest (f (car cmore) (cdr cmore))])
;; 			  (syntax-case c1 (=>)
;; 			    [(e0) #'(let ([t e0]) (if t t rest))]
;; 			    [(e0 => e1) #'(let ([t e0]) (if t (e1 t) rest))]
;; 			    [(e0 e1 e2 ...)
;; 			     #'(if e0 (begin e1 e2 ...) rest)]))))])))

;; `quasisyntax` can be used in place of `with-syntax` in many cases

;; (syntax->datum obj) returns obj stripped of syntactic information could be
;; used for `symbolic-identifier=?`

;; (datum->syntax template-identifier obj) lets transformer "bend" scoping by
;; creating implicit identifiers
;; ... thus permitting definition of syntactic extensions that introduce
;; visible bindings or references that do not appear explicitly

(define-syntax loop
  (lambda (x)
    (syntax-case x ()
      [(k e ...)
       (with-syntax ([break (datum->syntax #'k 'break)])
		    #'(call/cc
		       (lambda (break)
			 (let f () e ... (f)))))])))

;; Examples
;; (map (letrec ((sum (lambda (x) (if (= x 0) 0 (+ x (sum (- x 1)))))))
;;        sum)
;;      '(0 1 2 3))

(define-syntax rec
  (syntax-rules ()
    [(_ x e) (letrec ([x e]) x)]))

(define-syntax let
  (syntax-rules ()
    [(_ ((i e) ...) b1 b2 ...)
     ((lambda (i ...) b1 b2 ...) e ...)]
    [(_ f ((i e) ...) b1 b2 ...)
     ((rec f (lambda (i ...) b1 b2 ...)) e ...)]))

(define-syntax let
  (lambda (x)
    (syntax-case x ()
      [(_ f ((i e) ...) b1 b2 ...)
       (identifier? #'f)
       #'((rec f (lambda (i ...) b1 b2 ...)) e ...)]
      [(_ ((i e) ...) b1 b2 ...)
       #'((lambda (i ...) b1 b2 ...) e ...)])))

(define-syntax define-structure
  (lambda (x)
    (define gen-id
      (lambda (template-id . args)
	(datum->syntax template-id
		       (string->symbol
			(apply string-append
			       (map (lambda (x)
				      (if (string? x)
					  x
					  (symbol->string (syntax->datum x))))
				    args))))))
    (syntax-case x ()
      [(_ name field ...)
       (with-syntax ([constructor (gen-id #'name "make-" #'name)]
		     [predicate (gen-id #'name #'name "?")]
		     [(access ...)
		      (map (lambda (x) (gen-id #'name "-" x))
			   #'(field ...))]
		     [(assign ...)
		      (map (lambda (x)
			     (gen-id x "set-" #'name "-" x "!")))]
		     [structure-length (+ (length #'(field ...)) 1)]
		     [(index ...)
		      (let f ([i 1] [ids #'(field ...)])
			(if (null? ids)
			    '()
			    (cons i (f (+ i 1) (cdr ids)))))])
		    #'(begin
			(define constructor
			  (lambda (field ...)
			    (vector 'name field ...)))
			(define predicate
			  (lambda (x)
			    (and (vector? x)
				 (= (vector-length x) structure-length)
				 (eq? (vector-ref x 0) 'name))))
			(define access
			  (lambda (x)
			    (vector-ref x index)))
			...
			(define assign
			  (lambda (x update)
			    (vector-set! x index update)))
			...))])))
