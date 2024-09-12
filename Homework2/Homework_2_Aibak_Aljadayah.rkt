#lang racket
(define (mydisplay value)
  (display value)
  (newline)
  )

;An example of mydisplay function
(mydisplay 3)
;End of example

(define (line func)
  (display "----------")
  (display func)
  (display "----------")
  (newline)
  )

;An example of line function
(line (+ 3 5))
;End of example

(define (negatives lst)
  (cond
    ((null? lst) '())
    (else
     (if (< (car lst) 0)
         (cons (car lst) (negatives (cdr lst)))
         (negatives (cdr lst))
     )
    )
  )
 )

;An example of line function
(mydisplay (negatives '())) ; -> ()
(mydisplay (negatives '(-1))) ; -> (-1)
(mydisplay (negatives '(1 -1 2 3 4 -4 5))) ; -> (-1 -4)
(mydisplay (negatives '(1 1 2 3 4 4 5))) ; -> ()
;End of example