;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex083) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 83. Design the function render, which consumes an Editor and produces an image.
;
;The purpose of the function is to render the text within an empty scene of image pixels. For the cursor, use a image red rectangle and for the strings, black text of size 16.
;
;Develop the image for a sample string in DrRacket’s interactions area. We started with this expression:
;
;    (overlay/align "left" "center"
;                   (text "hello world" 11 "black")
;                   (empty-scene 200 20))
;
;You may wish to read up on beside, above, and such functions. When you are happy with the looks of the image, use the expression as a test and as a guide to the design of render.


(require 2htdp/image)

;; Constant and Data Definitions

(define background (empty-scene 200 20))

(define cursor (rectangle 1 20 "solid" "red"))

(define text-size 11)
(define text-color "black")


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t
#;
(define (fn-for-editor e)
  (... (editor-pre e) ...
       ... (editor-post e) ...))



;; Function Definitions

;; Editor -> Image
;; Render the text in the given one-line editor
;; structure definition as an image.
(check-expect (render (make-editor "hello" " world"))
              (overlay/align "left" "center"
                             (beside (text "hello" text-size text-color)
                                     cursor
                                     (text " world" text-size text-color))
                             background))

;(define (render e) background)

;; Template from Editor

(define (render e)
  (overlay/align "left" "center"
                 (beside (text (editor-pre e) text-size text-color)
                         cursor
                         (text (editor-post e) text-size text-color))
                 background))