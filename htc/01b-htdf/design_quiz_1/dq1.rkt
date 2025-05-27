;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dq1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; PROBLEM:

;; Design a function that consumes two images and produces
;; true if the first is larger than the second.

(require 2htdp/image)


;; Image Image -> Boolean
;; Given two images, return true if the width
;; and the height of the first image is greater
;; than the second image.
(check-expect (larger? (rectangle 4 4 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 4 5 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 4 6 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 5 4 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 5 5 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 5 6 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 6 4 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 6 5 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              false)
(check-expect (larger? (rectangle 6 6 "solid" "Indigo")
                       (rectangle 5 5 "solid" "Violet"))
              true)

;(define (larger? img1 img2) false)
#;
(define (larger? img1 img2)
  (... img1 img2))

(define (larger? img1 img2)
  (and (> (image-width img1) (image-width img2))
       (> (image-height img1) (image-height img2))))


;; Image Image -> Boolean
;; DEFINE: area = width x height
;; Given two images, return true if the area of the first image
;; is greater than area of the second image.
(check-expect (larger?-2 (square 4 "solid" "Indigo")
                         (square 5 "solid" "Violet"))
              false)
(check-expect (larger?-2 (square 5 "solid" "Indigo")
                         (square 5 "solid" "Violet"))
              false)
(check-expect (larger?-2 (square 6 "solid" "Indigo")
                         (square 5 "solid" "Violet"))
              true)

;(define (larger?-2 img1 img2) false)
#;
(define (larger?-2 img1 img2)
  (... img1 img2))

(define (larger?-2 img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))