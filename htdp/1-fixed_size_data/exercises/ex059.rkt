;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex059) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 59. Finish the design of a world program that simulates the traffic light FSA. Here is the main function:
;
;    ; TrafficLight -> TrafficLight
;    ; simulates a clock-based American traffic light
;    (define (traffic-light-simulation initial-state)
;      (big-bang initial-state
;        [to-draw tl-render]
;        [on-tick tl-next 1]))
;
;The function’s argument is the initial state for the big-bang expression, which tells DrRacket to redraw the state of the world with tl-render and to handle clock ticks with tl-next. Also note that it informs the computer that the clock should tick once per second.
;
;Complete the design of tl-render and tl-next. Start with copying TrafficLight, tl-next, and tl-render into DrRacket’s definitions area.
;
;Here are some test cases for the design of the latter:
;
;    (check-expect (tl-render "red") image)
;    (check-expect (tl-render "yellow") image)
;
;Your function may use these images directly. If you decide to create images with the functions from the 2htdp/image teachpack, design an auxiliary function for creating the image of a one-color bulb. Then read up on the place-image function, which can place bulbs into a background scene. 

(require 2htdp/image)
(require 2htdp/universe)

;; Constant Definitions

(define WIDTH 512)
(define HEIGHT (/ WIDTH 2))
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "Black"))

(define GAP (square (/ WIDTH 16) "solid" "Black"))

(define RADIUS (/ HEIGHT 4))


;; Data Definitions

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume


;; Function Definitions

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))


; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")

;(define (tl-next cs) cs)

(define (tl-next cs)
  (cond [(string=? cs "red") "green"]
        [(string=? cs "green") "yellow"]
        [(string=? cs "yellow") "red"]))



; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") (place-image (beside (circle RADIUS "solid" "Red")
                                                     GAP
                                                     (circle RADIUS "outline" "Yellow")
                                                     GAP
                                                     (circle RADIUS "outline" "Green"))
                                             (/ WIDTH 2) (/ HEIGHT 2)
                                             BACKGROUND))
(check-expect (tl-render "yellow") (place-image (beside (circle RADIUS "outline" "Red")
                                                        GAP
                                                        (circle RADIUS "solid" "Yellow")
                                                        GAP
                                                        (circle RADIUS "outline" "Green"))
                                                (/ WIDTH 2) (/ HEIGHT 2)
                                                BACKGROUND))
(check-expect (tl-render "green") (place-image (beside (circle RADIUS "outline" "Red")
                                                       GAP
                                                       (circle RADIUS "outline" "Yellow")
                                                       GAP
                                                       (circle RADIUS "solid" "Green"))
                                               (/ WIDTH 2) (/ HEIGHT 2)
                                               BACKGROUND))

#;
(define (tl-render current-state)
  (empty-scene 90 30))

(define (tl-render current-state)
  (place-image (beside (circle RADIUS (tl-turn-on-color "red" current-state) "Red")
                       GAP
                       (circle RADIUS (tl-turn-on-color "yellow" current-state) "Yellow")
                       GAP
                       (circle RADIUS (tl-turn-on-color "green" current-state) "Green"))
               (/ WIDTH 2) (/ HEIGHT 2)
               BACKGROUND))


;; TrafficLight TrafficLight -> String
;; Given the bulb color and the bulb you wish to turn on,
;;   return "solid" if they're equal, and
;;   return "outline" if they do not.
(check-expect (tl-turn-on-color "red" "red") "solid")
(check-expect (tl-turn-on-color "red" "yellow") "outline")
(check-expect (tl-turn-on-color "red" "green") "outline")

;(define (tl-turn-on-color tl-bulb tl-on) "outline")

(define (tl-turn-on-color tl-bulb tl-on)
  (cond [(string=? tl-bulb tl-on) "solid"]
        [else "outline"]))



;; Program Start
; (traffic-light-simulation "red")