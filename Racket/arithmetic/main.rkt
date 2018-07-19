#lang racket

(require (for-syntax syntax/parse))
 
(provide #%module-begin
         (rename-out [datums #%datum]
                     [unwrap #%top-interaction]
                     [expressions +]
                     [expressions *]
                     [expressions -]
                     [expressions /]
                     [expressions if]
                     [definitions function-app]
                     [definitions define-function]))

(define-syntax (datums stx)
  (syntax-parse stx
    [(_ . (~or l:number l:boolean l:string)) #'(quote l)]
    [(_ . other) (raise-syntax-error 'datums
                                     "literal not allowed in arith"
                                     'other)]))

(define-syntax (expressions stx)
  (syntax-parse stx #:datum-literals (if then else)
    [(op:id n1 n2) #`(#,(syntax->datum #'op) n1 n2)]
    [(if e0:expr then e1:expr else e2:expr) #'(if e0 e1 e2)]))

(define-syntax (definitions stx)
  (syntax-parse stx
    [(define-function (f:id params:id ...) body:expr)
     (define arity (length (syntax->list #'(params ...))))
     #`(define-syntax f (cons #,arity #'(lambda (params ...) body)))]
    [(function-app f:id args:expr ...)
     (define n-args (length (syntax->list #'(args ...))))
     (define-values (arity the-function) (lookup #'f stx))
     (cond
       [(= arity n-args) #`(#,the-function args ...)]
       [else
        (define msg (format "wrong number of arguments for ~a" (syntax-e #'f)))
        (raise-syntax-error #f msg stx)])]))

(define-for-syntax (lookup id stx)
  (define (failure)
    (define msg (format "undefined function: ~a" (syntax-e id)))
    (raise-syntax-error #f msg stx))
  (define result (syntax-local-value id failure))
  (values (car result) (cdr result)))

(define-syntax (unwrap stx)
  (syntax-parse stx
   [(_ . e) #'e]))

(module reader syntax/module-reader
  arith)