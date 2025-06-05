;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex039) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 39. Good programmers ensure that an image such as CAR can be enlarged or reduced via a single change to a constant definition.  We started the development of our car image with a single plain definition:
;
;    (define WHEEL-RADIUS 5)
;
;The definition of WHEEL-DISTANCE is based on the wheel’s radius. Hence, changing WHEEL-RADIUS from 5 to 10 doubles the size of the car image. This kind of program organization is dubbed single point of control, and good design employs this idea as much as possible.
;
;Develop your favorite image of an automobile so that WHEEL-RADIUS remains the single point of control.

(require 2htdp/image)
(require 2htdp/universe)

;; CONSTANT DEFINITIONS
 
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (rectangle (* WHEEL-RADIUS 2) 1 "solid" "White"))
(define WHEEL (circle WHEEL-RADIUS "solid" "Black"))
(define WHEEL-PAIR (beside WHEEL WHEEL-DISTANCE WHEEL))

(define FRONT (square (* WHEEL-RADIUS 2) "solid" "Sky Blue"))
(define MIDDLE (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 3) "solid" "Sky Blue"))
(define BACK FRONT)
(define BOTTOM-UNSEEN (square WHEEL-RADIUS "solid" "White"))
(define CAR-FRAME (above (beside/align "bottom"
                                       FRONT MIDDLE BACK)
                         BOTTOM-UNSEEN))

(define CAR (overlay/align "center" "bottom" WHEEL-PAIR CAR-FRAME))

(define WIDTH-OF-WORLD (* (image-width CAR) 5))
(define HEIGHT-OF-WORLD (+ (image-height CAR) 24))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

CAR


;; DATA DEFINITIONS

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car


;; FUNCTION DEFINITIONS

; WorldState -> WorldState
; launches the program from some initial state 
(define (main cw)
  (big-bang cw
    [on-tick tock]
    [to-draw render]))


; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render cw)
  BACKGROUND)
 
; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock cw)
  (+ cw 3))


;; PROGRAM START
(main 13)