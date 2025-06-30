;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex067) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 67. Here is another way to represent bouncing balls:
;
;    (define SPEED 3)
;    (define-struct balld [location direction])
;    (make-balld 10 "up")
;
;Interpret this code fragment and create other instances of balld.


(define SPEED 3)


;; Direction is one of these Strings:
;;  - "up"
;;  - "down"
;; Interpretation. The direction of a moving object.


(define-struct balld [location direction])
;; Ball is (make-balld NonNegativeInteger Direction)
;; Interpretation. (make-balld location direction) is a ball, where:
;;                 - location is the number of pixels from the top of the screen, and
;;                 - direction is the direction of the ball's movement.
(define BD1 (make-balld 10 "up"))
(define BD2 (make-balld 44 "down"))
(define BD3 (make-balld 100 "up"))
(define BD4 (make-balld 11 "down"))

