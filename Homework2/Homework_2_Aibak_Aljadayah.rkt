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
  ((and (null? lst1) (null? lst2))#t)
  ((or (null? lst1)(null? lst2))#f)
  (
   (and (list? (car lst1)) (list? (car lst2))) 
   (and (struct (car lst1) (car lst2)) (struct (cdr lst1) (cdr lst2)))
   )
  ((or (list? (car lst1)) (list? (car lst2)))#f)
  (else (struct (cdr lst1) (cdr lst2)))
  )
)

;An example of line function
(line "struct")
(mydisplay (struct '() '())) ; -> #t
(mydisplay (struct '(12) '())) ; -> #f
(mydisplay (struct '(a b c (c a b) (1 2 a)) '(1 2 3 (a b c) (1 2 c)))) ; -> #t
(mydisplay (struct '(a b c d (c a b)) '(1 2 3 (a b c)))) ; -> #f
(mydisplay (struct '(a b c (c a b)) '(1 2 3 (a b c) 0))) ; -> #f
(line "struct")
;End of example

(define (minAndMax lst)
  (define (helper lst min max)
    (cond
      ((null? lst) (list min max))
      ((< (car lst) min) (helper (cdr lst) (car lst) max))
      ((> (car lst) max) (helper (cdr lst) min (car lst)))
      (else (helper (cdr lst) min max))
    )
  )
  (helper (cdr lst) (car lst) (car lst))
)

;An example of line function
(line "minAndMax")
(mydisplay (minAndMax '(1 2 -3 4 2))) ; -> (-3 4)
(mydisplay (minAndMax '(1))) ; -> (1 1)
(mydisplay (minAndMax '(1 2 3 4 0))) ; -> (0 4)
(line "minAndMax")
;End of example

(define (flatten lst)
  (cond
    ((null? lst)'())
    ((list? (car lst)) (append (flatten (car lst)) (flatten (cdr lst))))
    ((cons (car lst) (flatten(cdr lst))))
  )
)

(line "flatten")
(mydisplay (flatten '(a b c)))  ; -> (a b c)
(mydisplay (flatten '(a (a a) a)))  ; -> (a a a a)
(mydisplay (flatten '((a b) (c (d) e) f)))  ; -> (a b c d e f)
(line "flatten")
; ---------------------------------------------
;End of example

(require "zipcodes.scm")

;; Now you can use the zipcodes list
(display (cadadr zipcodes))
(newline)

; Returns the first latitude and longitude of a particular zip code.
; if there are multiple latitude and longitude pairs for the same zip code,
; the function should only return the first pair. e.g. (53.3628 -167.5107)
; zipcode -- 5 digit integer
; zips -- the zipcode DB- You MUST pass the 'zipcodes' function
; from the 'zipcodes.scm' file for this. You can just call 'zipcodes' directly
; as shown in the sample example
(define (getLatLon zipcode zips)
        
        (cond
        
         ((= zipcode (caar (cdr zips))) (list zipcode (cddr(cddadr zips))))
         ((getLatLon zipcode (cdr zips)))
         )
	
)

(line "getLatLon")
(mydisplay (getLatLon 45056 zipcodes))
(line "getLatLon")
; ---------------------------------------------


; Returns a list of all the place names common to two states.
; state1 -- the first state to look for
; state2 -- the second state to look for
; zips -- the zipcode DB
; helper functions 
(car (cddadr zipcodes))
(cons '1 '(1 2 3))
(display "just to check how to car and cdr the zips ...............")
(newline)

(define (getPlaces state zips)
  (cond
    ((null? zips) '())
    ((and (pair? (car zips)) (equal? state (caddr (car zips))))
     (cons (cadr (car zips)) (getPlaces state (cdr zips))))
    (else (getPlaces state (cdr zips)))))
(define (remove-duplicates lst)
  (cond
    ((null? lst) '())
    ((member (car lst) (cdr lst)) (remove-duplicates (cdr lst)))
    (else (cons (car lst) (remove-duplicates (cdr lst))))))
; I got the remove-duplicates using ChatGpt
(define (duplicate list1 list2)
  (remove-duplicates
   (cond
     ((null? list1) '())
     ((member (car list1) list2) (cons (car list1) (duplicate (cdr list1) list2)))
     (else (duplicate (cdr list1) list2)))))


(define (getCommonPlaces state1 state2 zips)
	(duplicate (getPlaces "OH" zipcodes) (getPlaces "MI" zipcodes))
)

(line "getCommonPlaces")
(mydisplay (getCommonPlaces "OH" "MI" zipcodes))
(line "getCommonPlaces")









