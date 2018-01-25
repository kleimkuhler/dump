#lang racket

;; The MU puzzle is a puzzle stated by Douglas Hofstadter and found in Gödel,
;; Escher, Bach. As stated, it is an example of a Post canonical system and can
;; be reformulated as a string rewriting system.

;; This puzzle caught my attention as a good way to think about this formal
;; system outside of the book and incorporate it into a program.

(define MU-puzzle
  ;; Initialize a string to '(M I) and dispatch string manipulation procedures
  (let ((str '(M I)))
    (define (xI->xIU)
      (if (eq? 'I (last str))
          (begin (set! str (reverse (cons 'U (reverse str))))
                 str)
          "Puzzle must end in I"))
    ;; (define Mx->Mxx
    ;;   ())
    ;; (define (xIIIy->xUy pos)
    ;;   ())
    ;; (define (xUUy->xy pos)
    ;;   ())
    (define (print) str)
    (define (dispatch f)
      (cond ((eq? f 'xI->xIU) xI->xIU)
            ;; ((eq? f 'Mx->Mxx) Mx->Mxx)
            ;; ((eq? f 'xIIIy->xUy) xIIIy->xUy)
            ;; ((eq? f 'xUUy->xy) xUUy->xy)
            ((eq? f 'print) print)
            (else (error "Unkown request: MU-PUZZLE"
                         f))))
    dispatch))
