#lang racket

;; The MU puzzle is a puzzle stated by Douglas Hofstadter and found in Gödel,
;; Escher, Bach. As stated, it is an example of a Post canonical system and can
;; be reformulated as a string rewriting system.
;; (https://en.wikipedia.org/wiki/MU_puzzle)

;; This puzzle caught my attention as a good way to think about this formal
;; system outside of the book and incorporate it into a program.

(define (MU-puzzle)
  ;; MU puzzle with axiomatic string MI
  (let ((str '(M I)))
    (define (xI->xIU)
      ;; If `str` ends in I then append a U to `str`
      (if (eq? 'I (last str))
          (begin (set! str (reverse (cons 'U (reverse str))))
                 str)
          "Puzzle must end in I"))
    (define (Mx->Mxx)
      ;; Replicate the string after M and append it to `str`
      (let ((x (cdr str)))
        (set! str (append str x))
        str))
    (define (xIIIy->xUy start result)
      ;; Find the `count` occurrence of III and replace it with U
      (lambda (count)
        (cond ((and (= count 0) (null? result)) "Occurence must be greater than 0")
              ((< (length start) 3) "Occurrence not found")
              ((equal? '(I I I) (list (car start) (cadr start) (caddr start)))
               (if (= (- count 1) 0)
                   (let ((remain (cdddr start)))
                     (begin (set! str (append (reverse result) '(U) remain))
                            str))
                   ((xIIIy->xUy (cdr start) (cons (car start) result)) (- count 1))))
              (else
               ((xIIIy->xUy (cdr start) (cons (car start) result)) count)))))
    (define (xUUy->xy start result)
      ;; Find the `count` occurrence of UU and replace it with ''
      (lambda (count)
        (cond ((and (= count 0) (null? result)) "Occurence must be greater than 0")
              ((< (length start) 2) "Occurrence not found")
              ((equal? '(U U) (list (car start) (cadr start)))
               (if (= (- count 1) 0)
                   (let ((remain (cddr start)))
                     (begin (set! str (append (reverse result) remain))
                            str))
                   ((xUUy->xy (cdr start) (cons (car start) result)) (- count 1))))
              (else
               ((xUUy->xy (cdr start) (cons (car start) result)) count)))))
    (define (print) str)
    (define (dispatch f)
      ;; Dispatch transformation procedures on `str`
      (cond ((eq? f 'xI->xIU) xI->xIU)
            ((eq? f 'Mx->Mxx) Mx->Mxx)
            ((eq? f 'xIIIy->xUy) (xIIIy->xUy str '()))
            ((eq? f 'xUUy->xy) (xUUy->xy str '()))
            ((eq? f 'print) print)
            (else (error "Unkown request: MU-PUZZLE"
                         f))))
    dispatch))
