;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex055) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 55. Take another look at show. It contains three instances of an expression with the approximate shape:
;
;    (place-image ROCKET 10 (- ... CENTER) BACKG)
;
;This expression appears three times in the function: twice to draw a resting rocket and once to draw a flying rocket. Define an auxiliary function that performs this work and thus shorten show. Why is this a good idea? You may wish to reread Prologue: How to Program.

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
; top of the canvas and the rocket (its height)


;; FUNCTIONS

;; LRCD -> Image
;; Given the current countdown, place the rocket image
;; in the right place in BACKG.
(check-expect (place-rocket "resting") (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect (place-rocket -2) (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect (place-rocket HEIGHT) (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect (place-rocket 53) (place-image ROCKET 10 (- 53 CENTER) BACKG))

;(define (place-rocket x) empty-image)

(define (place-rocket x)
  (cond [(string? x) (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
        [(<= -3 x -1) (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
        [(> x 0) (place-image ROCKET 10 (- x CENTER) BACKG)]))


; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKG)))
(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

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

; Why is this a good idea?
; Answer. Ideally, functions should only perform one atomic task.
;         If there are auxillary tasks, it should delegate it to auxillary
;         functions, and not perform that auxillary function itself. This
;         helps us follow the DRY principle in programming.

 
; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  x)
 
; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)
  x)