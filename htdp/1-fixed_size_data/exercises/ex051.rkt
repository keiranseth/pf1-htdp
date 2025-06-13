;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex051) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 51. Design a big-bang program that simulates a traffic light for a given duration. The program renders the state of a traffic light as a solid circle of the appropriate color, and it changes state on every clock tick. Hint Read the documentation for big-bang; there is a reason all these “words” are linked to their documentation. What is the most appropriate initial state? Ask your engineering friends.

(require 2htdp/universe)
(require 2htdp/image)

;; Constant Definitions

(define RADIUS 64)


;; Data Definitions

; A TrafficLight is one of the following Strings:
; – "Red"
; – "Green"
; – "Yellow"
; Interpretation. The three strings represent the three 
;                 possible states that a traffic light may assume.


;; Function Definitions


;; TrafficLight -> TrafficLight
;; Simulate the changing states of a traffic light.
(define (simulate-traffic-light tl)
  (big-bang tl
    (on-tick next-traffic-light 1)
    (to-draw render-traffic-light)))

;; TrafficLight -> TrafficLight
;; Given a traffic light color, return the next color.
(check-expect (next-traffic-light "Red") "Green")
(check-expect (next-traffic-light "Green") "Yellow")
(check-expect (next-traffic-light "Yellow") "Red")

;(define (next-traffic-light tl) "Red")

(define (next-traffic-light tl)
  (cond [(string=? tl "Red") "Green"]
        [(string=? tl "Green") "Yellow"]
        [(string=? tl "Yellow") "Red"]))



;; TrafficLight -> Image
;; Given a traffic light color, return an image
;; representing the traffic light's current state.
(check-expect (render-traffic-light "Red")
              (circle RADIUS "solid" "Red"))
(check-expect (render-traffic-light "Green")
              (circle RADIUS "solid" "Green"))
(check-expect (render-traffic-light "Yellow")
              (circle RADIUS "solid" "Yellow"))

;(define (render-traffic-light tl) empty-image)

(define (render-traffic-light tl)
  (circle RADIUS "solid" tl))




;; Program Start
(simulate-traffic-light "Red")