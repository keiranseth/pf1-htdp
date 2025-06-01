;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex027) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 27. Our solution to the sample problem contains several constants in the middle of functions. As One Program, Many Definitions already points out, it is best to give names to such constants so that future readers understand where these numbers come from. Collect all definitions in DrRacket’s definitions area and change them so that all magic numbers are refactored into constant definitions.

;; CONSTANT DEFINITIONS

(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5.0)
(define AVG-ATT-CHANGE 15)
(define PRICE-CHANGE 0.1)
(define FIXED-OPERATIONAL-COST 180)
(define VARIABLE-OPERATIONAL-COST 0.04)


;; FUNCTION DEFINITIONS

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE)
                        (/ AVG-ATT-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-OPERATIONAL-COST
     (* VARIABLE-OPERATIONAL-COST
        (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))