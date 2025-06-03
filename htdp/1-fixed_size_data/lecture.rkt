;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)
(require 2htdp/image)
(require 2htdp/universe)

(define (letter first-name last-name signature-name)
  (string-append
   (opening first-name)
   "\n\n"
   (body first-name last-name)
   "\n\n"
   (closing signature-name)))
 
(define (opening first-name)
  (string-append "Dear " first-name ","))
 
(define (body first-name last-name)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " last-name " have won our lottery. So, " "\n"
   first-name ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))


(write-file 'stdout (letter "Matt" "Fiss" "Fell"))

(write-file "sample.dat" "Hello,\nworld.")
(write-file 'stdout (read-file "sample.dat"))





(define (number->square s)
  (square s "solid" "red"))

(define (reset s ke)
  100)

;(big-bang 100 [to-draw number->square])

(big-bang 100
  [to-draw number->square]
  [on-tick sub1]
  [stop-when zero?]
  [on-key reset])




(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
(define (main y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))
 
(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))
 
(define (stop y ke)
  0)