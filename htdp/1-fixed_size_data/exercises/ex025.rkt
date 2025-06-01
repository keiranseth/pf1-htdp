;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex025) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 25. Take a look at this attempt to solve exercise 17:
;
;    (define (image-classify img)
;      (cond
;        [(>= (image-height img) (image-width img)) "tall"]
;        [(= (image-height img) (image-width img)) "square"]
;        [(<= (image-height img) (image-width img)) "wide"]))
;
;Does stepping through an application suggest a fix?

; I think there would be a semantic error and thus the stepper is not capable of suggesting a fix.
; The problem would be that all images with equal height and width will register as "square" to the function.

(require 2htdp/image)

(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

(image-classify (rectangle 10 11 "solid" "Blue"))
(image-classify (rectangle 10 10 "solid" "Blue"))
(image-classify (rectangle 10 9 "solid" "Blue"))