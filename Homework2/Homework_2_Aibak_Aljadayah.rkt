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

(line "negatives")
(mydisplay (negatives '()))  ; -> ()
(mydisplay (negatives '(-1)))  ; -> (-1)
(mydisplay (negatives '(-1 1 2 3 4 -4 5)))  ; -> (-1 -4)
(mydisplay (negatives '(1 1 2 3 4 4 5)))  ; -> ()
(line "negatives")
; ---------------------------------------------

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
(display "---------test---------\n")
(display "just to figure out how to get the place\n")
(display (cadadr zipcodes))
(newline)
(display "---------test---------\n")

; The paramters are two lists. The result should contain the cross product
; between the two lists: 
; The inputs '(1 2) and '(a b c) should return a single list:
; ((1 a) (1 b) (1 c) (2 a) (2 b) (2 c))
; lst1 & lst2 -- two flat lists.

(define (crossproduct lst1 lst2)
  (if (null? lst1)
      '()
      (append (map (lambda (x) (cons (car lst1) (list x))) lst2)
              (crossproduct (cdr lst1) lst2))))

(line "crossproduct")
(mydisplay (crossproduct '(1 2) '(a b c)))
(line "crossproduct")

; ---------------------------------------------
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
(display "---------test---------\n")
(caadr  zipcodes)
(cons '1 '(1 2 3))
(display "just to check how to car and cdr the zips ...............")
(newline)
(display "---------test---------\n")

(define (getPlaces state zips)
  (cond
    ((null? zips) '())
    ((and (pair? (car zips)) (equal? state (caddr (car zips))))
     (cons (cadr (car zips)) (getPlaces state (cdr zips))))
    (else (getPlaces state (cdr zips)))))
(display "---------test---------\n")
;; Test cases
(define zips '((2 "place51" texas) (1 "place1" ohio) (2 "place2" ohio) (3 "place3" texas) (4 "place4" california) (2 "place2" ohio) (2 "place2" ohio) (5 "place5" california) (2 "place2" ohio)))
(display (getPlaces 'ohio zips)) ; Expected output: _
(newline)
(display (getPlaces 'texas zips)) ; Expected output: _
(newline)
(display (getPlaces 'california zips)) ; Expected output: 
(newline)
(display (getPlaces 'florida zips)) ; Expected output: ()
(display "---------test---------\n")
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
	(duplicate (getPlaces state1 zipcodes) (getPlaces state2 zipcodes))
)
(newline)
(line "getCommonPlaces")
(mydisplay (getCommonPlaces "OH" "MI" zipcodes))
(line "getCommonPlaces")

; Returns the number of zipcode entries for a particular state.
; state -- state
; zips -- zipcode DBz
(define (keepUnique lst)
  (define (helper seen remaining)
    (cond
      ((null? remaining) '())
      ((member (car remaining) seen)
       (helper seen (cdr remaining)))
      (else
       (cons (car remaining) (helper (cons (car remaining) seen) (cdr remaining))))))
  (helper '() lst))
(display "---------test---------\n")
(display (keepUnique (getPlaces 'ohio zips))) ; as i see is working
(newline)
(display "for testing purpose --------------------------------------------\n")
(newline)
(display "---------test---------\n")

(define (getZips state zips)
  (cond
    ((null? zips) '())
    ((and (pair? (car zips)) (string=? state (caddr (car zips))))
     (cons (caar zips) (getZips state (cdr zips))))
    (else (getZips state (cdr zips)))))
(display "---------test---------\n")
;; Example usage:
(keepUnique '(a b a a a a a c a a a b a c a a c a c a))
;; Output: (a b c)
(display "---------test---------\n")


(define (zipCount state zips)
 (length (keepUnique (getZips state zips)))
)

(line "zipCount")
(mydisplay (zipCount "OH" zipcodes))
(line "zipCount")
; ---------------------------------------------

(display "---------test---------\n")
; Some sample predicates
(define (POS? x) (> x 0))
(define (NEG? x) (< x 0))
(define (LARGE? x) (>= (abs x) 10))
(define (SMALL? x) (not (LARGE? x)))

; Returns a list of items that satisfy a set of predicates.
; For example (filterList '(1 2 3 4 100) '(EVEN?)) should return the even numbers (2 4 100)
; (filterList '(1 2 3 4 100) '(EVEN? SMALL?)) should return (2 4)
; lst -- flat list of items
; filters -- list of predicates to apply to the individual elements

(define (filterList lst filters)
  (cond
    ((null? lst) '())
    ((null? filters) lst)
    (else (filterList-helper lst filters))))

(define (filterList-helper lst filters)
  (cond
    ((null? lst) '())
    ((apply-filters (car lst) filters)
     (cons (car lst) (filterList-helper (cdr lst) filters)))
    (else (filterList-helper (cdr lst) filters))))

(define (apply-filters x filters)
  (cond
    ((null? filters) #t)
    ((not ((car filters) x)) #f)
    (else (apply-filters x (cdr filters)))))

; Test cases
(display (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS?)))
(newline)
(display (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS? even?)))
(newline)
(display (filterList '(1 2 3 11 22 33 -1 -2 -3 -11 -22 -33) (list POS? even? LARGE?)))
(newline)
; ---------------------------------------------

; #### Only for Graduate Students ####
; Returns a list of all the place names common to a set of states.
; states -- is list of state names
; zips -- the zipcode DB

(define (placesForAllState states zips)
  (cond
    ((null? states) '())
    (else (append (keepUnique (getPlaces (car states) zips))
                  (placesForAllState (cdr states) zips)))))

;; Example states
(define states '(ohio texas california))
(display "---------test---------\n")
;; Test cases
(display (placesForAllState states zips)) ; Expected output: ("place1" "place2" "place3" "place4" "place5")
(newline)
(display (placesForAllState '(ohio) zips)) ; Expected output: ("place1" "place2")
(newline)
(display (placesForAllState '(texas) zips)) ; Expected output: ("place3")
(newline)
(display (placesForAllState '(california) zips)) ; Expected output: ("place4" "place5")
(newline)
(display (placesForAllState '() zips)) ; Expected output: ()
(newline)
(display "for testing purpose +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n")
;end of the test

;(placesForAllState '("PA" "OH" "MI") zipcodes)
(define (count-occurrences lst states)
  (define (count-item item lst)
    (length (filter (lambda (x) (equal? x item)) lst)))
  (define (filter-occurrences lst states)
    (let ((state-length (length states)))
      (filter (lambda (item)
                (= (count-item item lst) state-length))
              (remove-duplicates lst))))
  (filter-occurrences lst states))
(display "---------test---------\n")
;; Example usage:
(define my-list '(a b c a b a c c d d d))
(count-occurrences my-list states)
(newline)
;end of test
(display "---------test---------\n")
;(placesForAllState '("OH" "MI" "PA") zipcodes); i checked the last few strings of PA it looks working :) finally
(newline)

(define (getCommonPlaces2 states zips)
	(count-occurrences (placesForAllState states zips) states)
)

(line "getCommonPlaces2")
(mydisplay (getCommonPlaces2 '("OH" "MI" "PA") zipcodes))
(line "getCommonPlaces2")
; ---------------------------------------------





; #### Only for Graduate Students ####
; Returns the distance between two zip codes in "meters".
; Use lat/lon. Do some research to compute this.
; You can find some info here: https://www.movable-type.co.uk/scripts/latlong.html
; zip1 & zip2 -- the two zip codes in question.
; zips -- zipcode DB
;I used chatgpt to generate (atan2) this cuz i wasn't sure what is atan2 exactly, i hope it is the right equation
(define (atan2 y x)
  (cond ((and (= x 0) (> y 0)) (/ pi 2))
        ((and (= x 0) (< y 0)) (- (/ pi 2)))
        ((= y 0) (if (>= x 0) 0 pi))
        ((> x 0) (atan (/ y x)))
        ((< x 0) (if (>= y 0) (+ (atan (/ y x)) pi) (- (atan (/ y x)) pi)))))

(define (distance lat1 lon1 lat2 lon2)
  (let* ((pi 3.141592653589793)
         (r 6371000) ; Earth's radius in meters
         (dlat (* pi (- lat2 lat1) (/ 1 180))) ; Convert delta lat to radians
         (dlon (* pi (- lon2 lon1) (/ 1 180))) ; Convert delta lon to radians
         (lat1 (* pi lat1 (/ 1 180))) ; Convert lat1 to radians
         (lat2 (* pi lat2 (/ 1 180))) ; Convert lat2 to radians
         (a (+ (* (sin (/ dlat 2)) (sin (/ dlat 2)))
               (* (cos lat1) (cos lat2)
                  (sin (/ dlon 2)) (sin (/ dlon 2)))))
         (c (* 2 (atan2 (sqrt a) (sqrt (- 1 a))))))
    (* r c)))
(display "---------test---------\n")
(display (distance 40.7128 -74.0060 34.0522 -118.2437)) ; New York to Los Angeles

(newline)
;testing if distance working

(caddr (cdddr '(63441 "Frankford" "MO" "Pike" 39.4892 -91.3031)))
;just to check if i am picking correctly or not
(display "---------test---------\n")
(define (findL zip zips)
  (cond
  ((null? zips) '())
  ((equal? (caadr zips) zip)
   (list (caddr(cddadr zips)) (cadddr(cddadr zips)))
   )
  ((findL zip (cdr zips)))
  )
)

(findL 45056 zipcodes)
(define (getDistanceBetweenZipCodes zip1 zip2 zips)
  (distance (car (findL zip1 zipcodes)) (cadr (findL zip1 zipcodes)) (car (findL zip2 zipcodes)) (cadr (findL zip2 zipcodes)))
)

(line "getDistanceBetweenZipCodes")
(mydisplay (getDistanceBetweenZipCodes 45056 48122 zipcodes))
(line "getDistanceBetweenZipCodes")
; ---------------------------------------------










