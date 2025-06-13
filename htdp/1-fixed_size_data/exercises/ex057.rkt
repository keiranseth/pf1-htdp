;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex057) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 57. Recall that the word “height” forced us to choose one of two possible interpretations. Now that you have solved the exercises in this section, solve them again using the first interpretation of the word. Compare and contrast the solutions.
;
;    the word “height” could refer to the distance between the ground and the rocket’s point of reference, say, its center.


(require 2htdp/universe)
(require 2htdp/image)

;; CONSTANTS

(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

;; DATA

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; bottom of the canvas and the rocket (its height)


;; FUNCTIONS

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [on-tick fly]
    [to-draw show]
    [on-key launch]
    [stop-when out-of-sight]))

;; LRCD -> Integer
;; Convert the physical distance of the rocket into its
;; rendered relative position inside the program.
(check-expect (transform-distance "resting") (- (- HEIGHT CENTER) 0))
(check-expect (transform-distance -2) (- (- HEIGHT CENTER) 0))
(check-expect (transform-distance 0) (- (- HEIGHT CENTER) 0))
(check-expect (transform-distance 53) (- (- HEIGHT CENTER) 53))
(check-expect (transform-distance HEIGHT) (- (- HEIGHT CENTER) HEIGHT))

;(define (transform-distance x) 0)

(define (transform-distance x)
  (- (- HEIGHT CENTER)
     (cond [(or (string? x)
                (<= -3 x -1)) 0]
           [else x])))


;; LRCD -> Image
;; Given the current countdown, place the rocket image
;; in the right place in BACKG.
(check-expect (place-rocket "resting") (place-image ROCKET 10 (transform-distance "resting") BACKG))
(check-expect (place-rocket -2) (place-image ROCKET 10 (transform-distance -2) BACKG))
(check-expect (place-rocket 0) (place-image ROCKET 10 (transform-distance 0) BACKG))
(check-expect (place-rocket 100) (place-image ROCKET 10 (transform-distance 100) BACKG))
(check-expect (place-rocket HEIGHT) (place-image ROCKET 10 (transform-distance HEIGHT) BACKG))

;(define (place-rocket x) empty-image)

(define (place-rocket x)
  (cond [(string? x) (place-image ROCKET 10 (transform-distance 0) BACKG)]
        [(<= -3 x -1) (place-image ROCKET 10 (transform-distance 0) BACKG)]
        [else (place-image ROCKET 10 (transform-distance x) BACKG)]))


; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET 10 (transform-distance 0) BACKG))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET
                           10 (- HEIGHT CENTER)
                           BACKG)))
(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (transform-distance HEIGHT) BACKG))
(check-expect
 (show 53)
 (place-image ROCKET 10 (transform-distance 53) BACKG))

#;
(define (show x)
  BACKG)

(define (show x)
  (cond
    [(string? x)
     (place-rocket x)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket x))]
    [(>= x 0)
     (place-rocket x)]))

 
; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

#;
(define (launch x ke)
  x)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))


; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))

#;
(define (fly x)
  x)

(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) 0 (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))


;; LRCD -> Boolean
;; Return true once the rocket disappears in the upper
;; part of the screen.
(check-expect (out-of-sight "resting") #false)
(check-expect (out-of-sight -2) #false)
(check-expect (out-of-sight 0) #false)
(check-expect (out-of-sight 100) #false)
(check-expect (out-of-sight HEIGHT) #true)
(check-expect (out-of-sight (+ HEIGHT 1)) #true)


;(define (out-of-sight x) #false)

(define (out-of-sight x)
  (and (number? x) (>= x HEIGHT)))


;; Program

;(main2 "resting")


;; What did I do differently from the first program?
;;     - Reinterpret the data definition, as stated by the problem statement.
;;     - Add transform-distance, which will convert the literal distance of the rocket from the ground
;;       into its relative position on the screen.
;;     - Change the test cases to reflect this change in the data definition across the rest of the helper functions.