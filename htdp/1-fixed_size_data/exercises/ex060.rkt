;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex060) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 60. An alternative data representation for a traffic light program may use numbers instead of strings:
;
;    ; An N-TrafficLight is one of:
;    ; – 0 interpretation the traffic light shows red
;    ; – 1 interpretation the traffic light shows green
;    ; – 2 interpretation the traffic light shows yellow
;
;It greatly simplifies the definition of tl-next:
;
;    ; N-TrafficLight -> N-TrafficLight
;    ; yields the next state, given current state cs
;    (define (tl-next-numeric cs) (modulo (+ cs 1) 3))
;
;Reformulate tl-next’s tests for tl-next-numeric.
;
;Does the tl-next function convey its intention more clearly than the tl-next-numeric function? If so, why? If not, why not?


(require 2htdp/image)
(require 2htdp/universe)

;; Constant Definitions

(define WIDTH 512)
(define HEIGHT (/ WIDTH 2))
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "Black"))

(define GAP (square (/ WIDTH 16) "solid" "Black"))

(define RADIUS (/ HEIGHT 4))


;; Data Definitions

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow


;; Function Definitions

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation-numeric initial-state)
  (big-bang initial-state
    [to-draw tl-render-numeric]
    [on-tick tl-next-numeric 1]))


; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

;(define (tl-next-numeric cs) cs)

(define (tl-next-numeric cs)
  (modulo (add1 cs) 3))



; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render-numeric 0) (place-image (beside (circle RADIUS "solid" "Red")
                                                         GAP
                                                         (circle RADIUS "outline" "Yellow")
                                                         GAP
                                                         (circle RADIUS "outline" "Green"))
                                                 (/ WIDTH 2) (/ HEIGHT 2)
                                                 BACKGROUND))
(check-expect (tl-render-numeric 2) (place-image (beside (circle RADIUS "outline" "Red")
                                                         GAP
                                                         (circle RADIUS "solid" "Yellow")
                                                         GAP
                                                         (circle RADIUS "outline" "Green"))
                                                 (/ WIDTH 2) (/ HEIGHT 2)
                                                 BACKGROUND))
(check-expect (tl-render-numeric 1) (place-image (beside (circle RADIUS "outline" "Red")
                                                         GAP
                                                         (circle RADIUS "outline" "Yellow")
                                                         GAP
                                                         (circle RADIUS "solid" "Green"))
                                                 (/ WIDTH 2) (/ HEIGHT 2)
                                                 BACKGROUND))

#;
(define (tl-render-numeric current-state)
  (empty-scene 90 30))

(define (tl-render-numeric current-state)
  (place-image (beside (circle RADIUS (tl-turn-on-color-numeric 0 current-state) "Red")
                       GAP
                       (circle RADIUS (tl-turn-on-color-numeric 2 current-state) "Yellow")
                       GAP
                       (circle RADIUS (tl-turn-on-color-numeric 1 current-state) "Green"))
               (/ WIDTH 2) (/ HEIGHT 2)
               BACKGROUND))


;; TrafficLight TrafficLight -> String
;; Given the bulb color and the bulb you wish to turn on,
;;   return "solid" if they're equal, and
;;   return "outline" if they do not.
(check-expect (tl-turn-on-color-numeric 0 0) "solid")
(check-expect (tl-turn-on-color-numeric 0 2) "outline")
(check-expect (tl-turn-on-color-numeric 0 1) "outline")
#;
(define (tl-turn-on-color-numeric tl-bulb tl-on) "outline")

(define (tl-turn-on-color-numeric tl-bulb tl-on)
  (cond [(= tl-bulb tl-on) "solid"]
        [else "outline"]))



;; Program Start
; (traffic-light-simulation-numeric 0)


;; Does the tl-next function convey its intention more clearly than the tl-next-numeric function? If so, why? If not, why not?
;; Answer. To me, not really, no. Using the string version of the program is clearer to the readers of the program, since
;;         it's natural how the string description and the color immediately connect. Notice how the interpretation
;;         has to clarify which integers represent which color.