;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex040) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 40. Formulate the examples as BSL tests, that is, using the check-expect form. Introduce a mistake. Re-run the tests.

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
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render cw)
  BACKGROUND)
 
; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) (+ 20 3))
(check-expect (tock 78) (+ 78 3))

(define (tock cw)
  (+ cw 3))


;; PROGRAM START
(main 13)