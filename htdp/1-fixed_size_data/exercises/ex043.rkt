;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex043) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 43. Let’s work through the same problem statement with a time-based data definition:
;
;    ; An AnimationState is a Number.
;    ; interpretation the number of clock ticks 
;    ; since the animation started
;
;Like the original data definition, this one also equates the states of the world with the class of numbers. Its interpretation, however, explains that the number means something entirely different.
;
;Design the functions tock and render. Then develop a big-bang expression so that once again you get an animation of a car traveling from left to right across the world’s canvas.
;
;How do you think this program relates to animate from Prologue: How to Program?
;
;Use the data definition to design a program that moves the car according to a sine wave. (Don’t try to drive like that.)


(require 2htdp/image)
(require 2htdp/universe)

;; CONSTANT DEFINITIONS
 
(define WHEEL-RADIUS 8)
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
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image TREE
                                (* WIDTH-OF-WORLD 4/5)
                                (- HEIGHT-OF-WORLD (/ (image-height TREE) 2))
                                (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define Y-CAR (+ (- HEIGHT-OF-WORLD (image-height CAR))
                 (/ (image-height CAR) 2)
                 -1))

(define VELOCITY 3)



;; DATA DEFINITIONS

; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started

; Distance is a Number.
; interpretation. the number of pixels between
; the left border of the scene and the car



;; FUNCTION DEFINITIONS

;; velocity = distance / time
;; distance = velocity * time

; AnimationState -> Distance
; transform the number of ticks into the number
; of pixels between the left border and the car
(check-expect (ticks->distance 0) 0)
(check-expect (ticks->distance 1) 3)
(check-expect (ticks->distance 24) (* 3 24))

(define (ticks->distance as)
  (* VELOCITY as))

; AnimationState -> AnimationState
; launches the program from some initial state 
(define (main as)
  (big-bang as
    [stop-when car-gone?]
    [on-tick tock]
    [to-draw render]))

; AnimationState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render as)
  (place-image CAR (ticks->distance as) Y-CAR BACKGROUND))


; AnimationState -> AnimationState
; adds 1 to given tick, and as a result, must
; move the car by 3 pixels for every clock tick
(check-expect (tock 20) (+ 20 1))
(check-expect (tock 78) (+ 78 1))

(define (tock as)
  (+ as 1))


; WorldState -> WorldState
; ends program once car fully disappears from screen
(check-expect (car-gone? 0) false)
(check-expect (car-gone? 20) false)
(check-expect (car-gone? (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))) true)

(define (car-gone? as)
  (>= (ticks->distance as) (+ WIDTH-OF-WORLD (/ (image-width CAR) 2))))

;; PROGRAM START
(main 13)

; Okay what in the world does the author mean by "according to the sine wave"?!!!
; Do you mean move it back and forth? lmao girl, be more specific!!!