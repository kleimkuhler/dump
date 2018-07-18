(define-syntax let*
  (syntax-rules ()
    [(_ () b1 b2 ...) (let () b1 b2 ...)]
    [(_ ((i1 e1) (i2 e2) ...) b1 b2 ...)
     (let ([i1 e1])
       (let* ([i2 e2] ...) b1 b2 ...))]))

;; `cond`: `syntax-rules` & auxiliary keywords
(define-syntax cond
  (syntax-rules (else)
    [(_ (else e1 e2 ...)) (begin e1 e2 ...)]
    [(_ (e0 e1 e2 ...)) (if e0 (begin e1 e2 ...))]
    [(_ (e0 e1 e2 ...) c1 c2 ...)
     (if e0 (begin e1 e2 ...) (cond c1 c2 ...))]))

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

(define-syntax with-syntax
  (lambda (x)
    (syntax-case x ()
      [(_ ((p e) ...) b1 b2 ...)
       #'(syntax-case (list e ...) ()
	   [(p ...) (let () b1 b2 ...)])])))

(define-syntax loop
  (lambda (x)
    (syntax-case x ()
      [(k e ...)
       (with-syntax ([break (datum->syntax #'k 'break)])
		    #'(call/cc
		       (lambda (break)
			 (let f () e ... (f)))))])))

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
                      (map (lambda (x) (gen-id x #'name "-" x))
                           #'(field ...))]
                     [(assign ...)
                      (map (lambda (x)
                             (gen-id x "set-" #'name "-" x "!"))
                           #'(field ...))]
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
