#lang racket

;; The MU puzzle is a puzzle stated by Douglas Hofstadter and found in Gödel,
;; Escher, Bach. As stated, it is an example of a Post canonical system and can
;; be reformulated as a string rewriting system.
;; (https://en.wikipedia.org/wiki/MU_puzzle)

;; This puzzle caught my attention as a good way to think about this formal
;; system outside of the book and incorporate it into a program.

(define (match start result substr count)
  ;; Match the `count` occurence of `substr` in `start` and return two lists
  ;; that equal ``start` - `count` occurence of `substr``
  (cond ((< (length start) (length substr)) (cons '() '()))
        ((equal? substr (take start (length substr)))
         (if (= (- count 1) 0)
             (let ((remain (list-tail start (length substr))))
               (cons result remain))
             (match (cdr start) (cons (car start) result) substr (- count 1))))
        (else
         (match (cdr start) (cons (car start) result) substr count))))

(define (MU-puzzle)
  ;; MU puzzle with axiomatic string MI
  (let ((str '(M I)))
    (define (replace old new count)
      ;; Replace the `count` occurence of `old` with `new` in `str`
      (if (= count 0)
          "Occurence must be greater than 0"
          (let ((matched (match str '() old count)))
            (let ((result (car matched))
                  (remain (cdr matched)))
              (if (null? result)
                  "Occurence not found"
                  (begin (set! str (append (reverse result) new remain))
                         str))))))
    (define (xI->xIU)
      (if (eq? 'I (last str))
          (begin (set! str (reverse (cons 'U (reverse str))))
                 str)
          "Puzzle must end in I"))
    (define (Mx->Mxx)
      (let ((x (cdr str)))
        (set! str (append str x))
        str))
    (define (xIIIy->xUy count) (replace '(I I I) '(U) count))
    (define (xUUy->xy count) (replace '(U U) '() count))
    (define (print) str)
    (define (dispatch f)
      ;; Dispatch transformation procedures on `str`
      (cond ((eq? f 'xI->xIU) xI->xIU)
            ((eq? f 'Mx->Mxx) Mx->Mxx)
            ((eq? f 'xIIIy->xUy) xIIIy->xUy)
            ((eq? f 'xUUy->xy) xUUy->xy)
            ((eq? f 'print) print)
            (else (error "Unkown request: MU-PUZZLE"
                         f))))
    dispatch))
