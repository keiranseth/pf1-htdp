;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex062) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 62. During a door simulation the “open” state is barely visible. Modify door-simulation so that the clock ticks once every three seconds. Rerun the simulation.

(require 2htdp/image)
(require 2htdp/universe)

;Sample Problem Design a world program that simulates the working of a door with an automatic door closer. If this kind of door is locked, you can unlock it with a key. An unlocked door is closed, but someone pushing at the door opens it. Once the person has passed through the door and lets go, the automatic door takes over and closes the door again. When a door is closed, it can be locked again.

;; Constant and Data Definitions

(define WIDTH 256)
(define HEIGHT (/ WIDTH 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define X-POSITION (/ WIDTH 2))
(define Y-POSITION (/ HEIGHT 2))
(define TEXT-SIZE (round (/ HEIGHT 2)))


; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN
;; Interpretation. The current state of a door in an automatic door closer.
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")


;; Function Definitions

; Start with this: (door-simulation OPEN)

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))


;; DoorState -> DoorState
;; Closes an "open" door during one tick.
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)

;(define (door-closer ds) ds)

#;
(define (door-closer ds)
  (cond
    [(string=? LOCKED ds) ...]
    [(string=? CLOSED ds) ...]
    [(string=? OPEN ds) ...]))

(define (door-closer ds)
  (cond
    [(string=? LOCKED ds) LOCKED]
    [(string=? CLOSED ds) CLOSED]
    [(string=? OPEN ds) CLOSED]))


;; DoorState KeyEvent -> DoorState
;; Changes the state of the door, depending on which key is pressed.
;;     - Opens a "closed" door when " " is pressed.
;;     - Unlocks a "locked" door when "u" is pressed.
;;     - Locks an "unlocked" door when "l" is pressed.
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

;(define (door-action ds ke) ds)

(define (door-action ds ke)
  (cond
    [(and (string=? LOCKED ds) (string=? "u" ke))
     CLOSED]
    [(and (string=? CLOSED ds) (string=? "l" ke))
     LOCKED]
    [(and (string=? CLOSED ds) (string=? " " ke))
     OPEN]
    [else ds]))


; DoorState -> Image
; translates the state ds into a large text image
(check-expect (door-render LOCKED)
              (place-image (text LOCKED TEXT-SIZE "red")
                           X-POSITION Y-POSITION
                           MTS))
(check-expect (door-render CLOSED)
              (place-image (text CLOSED TEXT-SIZE "red")
                           X-POSITION Y-POSITION
                           MTS))
(check-expect (door-render OPEN)
              (place-image (text OPEN TEXT-SIZE "red")
                           X-POSITION Y-POSITION
                           MTS))

#;
(define (door-render ds)
  (text ds 40 "red"))

(define (door-render ds)
  (place-image (text ds TEXT-SIZE "red")
               X-POSITION Y-POSITION
               MTS))