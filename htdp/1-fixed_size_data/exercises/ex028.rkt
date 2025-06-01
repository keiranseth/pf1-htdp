;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex028) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 28. Determine the potential profit for these ticket prices: $1, $2, $3, $4, and $5. Which price maximizes the profit of the movie theater? Determine the best ticket price to a dime. 

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

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))



(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)

(profit2 1)
(profit2 2)
(profit2 3)
(profit2 4)
(profit2 5)

; A 3$ ticket price produces the most profit to the movie theater.