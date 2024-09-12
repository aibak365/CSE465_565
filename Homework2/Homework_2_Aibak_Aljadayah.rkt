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

(define (struct lst1 lst2)
  (cond
    ((and (null? lst1) (null? lst2)) #t) ; Both lists are empty
    ((or (null? lst1) (null? lst2)) #f) ; One list is empty, the other is not
    ((and (pair? (car lst1)) (pair? (car lst2))) ; Both elements are lists
     (and (struct (car lst1) (car lst2)) (struct (cdr lst1) (cdr lst2))))
    ((or (pair? (car lst1)) (pair? (car lst2))) #f) ; One element is a list, the other is not
    (else (struct (cdr lst1) (cdr lst2))) ; Both elements are not lists
  )
)

;An example of line function
(line "struct")
(mydisplay (struct '(a b c (c a b)) '(1 2 3 (a b c)))) ; -> #t
(mydisplay (struct '(a b c d (c a b)) '(1 2 3 (a b c)))) ; -> #f
(mydisplay (struct '(a b c (c a b)) '(1 2 3 (a b c) 0))) ; -> #f
(line "struct")
;End of example