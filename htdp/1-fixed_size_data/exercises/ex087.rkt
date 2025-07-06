;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex087) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 87. Develop a data representation for an editor based on our first idea, using a string and an index. Then solve the preceding exercises again. Retrace the design recipe. Hint if you haven’t done so, solve the exercises in Functions.

(require 2htdp/image)
(require 2htdp/universe)

;; Constant and Data Definitions

(define background (empty-scene 200 20))

(define cursor (rectangle 1 20 "solid" "red"))

(define text-size 11)
(define text-color "black")

(define char-limit 42)


(define-struct editor [text index])
; An Editor is a structure:
;   (make-editor String NonNegativeInteger)
; interpretation (make-editor t i) describes an editor
; whose visible text is the string s with the index i
; specifying the location of the cursor.
#;
(define (fn-for-editor e)
  (... (editor-text e) ...
       ... (editor-index e) ...))



;; Function Definitions

;; Editor -> Editor
;; start the world with (run (make-editor "" 0))
;; 
(define (run e)
  (big-bang e            ; Editor
    (to-draw   render)   ; Editor -> Image
    (on-key    edit)))   ; Editor KeyEvent -> WS

;; Editor -> Image
;; Render the text in the given one-line editor
;; structure definition as an image.
(check-expect (render (make-editor "hello world" 5))
              (overlay/align "left" "center"
                             (beside (text (substring "hello world" 0 5) text-size text-color)
                                     cursor
                                     (text (substring "hello world" 5) text-size text-color))
                             background))

;(define (render e) background)

;; Template from Editor

(define (render e)
  (overlay/align "left" "center"
                 (beside (text (substring (editor-text e) 0 (editor-index e)) text-size text-color)
                         cursor
                         (text (substring (editor-text e) (editor-index e)) text-size text-color))
                 background))


;; Editor KeyEvent -> Editor
;; Let the user input into the editor.
;;   - "left" moves the cursor one character to the left,
;;   - "right" moves the cursor one character to the right,
;;   - "\b" erases the character to the left of cursor,
;;   - 1-string such as letters, numbers, and punctuations are entered, and
;;   - the rest are ignored.
(check-expect (edit (make-editor "abcdefgh     ijklmnopqr   stuvwxyzabcdefghijk" 14) " ")
              (make-editor "abcdefgh     ijklmnopqr   stuvwxyzabcdefghijk" 14))
(check-expect (edit (make-editor "hello world" 5) "\b")
              (make-editor "hell world" 4))
(check-expect (edit (make-editor " world" 0) "\b")
              (make-editor " world" 0))
(check-expect (edit (make-editor "hello world" 5) "left")
              (make-editor "hello world" 4))
(check-expect (edit (make-editor " world" 0) "left")
              (make-editor " world" 0))
(check-expect (edit (make-editor "hello world" 5) "right")
              (make-editor "hello world" 6))
(check-expect (edit (make-editor "hello" 5) "right")
              (make-editor "hello" 5))
(check-expect (edit (make-editor "hello world" 5) "\t")
              (make-editor "hello world" 5))
(check-expect (edit (make-editor "hello world" 5) "\r")
              (make-editor "hello world" 5))
(check-expect (edit (make-editor "hello world" 5) "x")
              (make-editor "hellox world" 6))
(check-expect (edit (make-editor "hello world" 5) "shift")
              (make-editor "hello world" 5))

;(define (edit e ke) e)

#;
(define (edit e ke)
  (cond [(string=? ke "\b")
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [(string=? ke "left")
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [(string=? ke "right")
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [(>= (string-length (editor-text e))
             char-limit)
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [(or (string=? ke "\t") (string=? ke "\r"))
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [(= (string-length ke) 1)
         (... (editor-text e) ...
              ... (editor-index e) ...)]
        [else
         (... (editor-text e) ...
              ... (editor-index e) ...)]))

(define (edit e ke)
  (cond [(string=? ke "\b")
         (if (zero? (editor-index e))
             e
             (make-editor (string-append (substring (editor-text e) 0 (sub1 (editor-index e)))
                                         (substring (editor-text e) (editor-index e)))
                          (sub1 (editor-index e))))]
        [(string=? ke "left")
         (if (zero? (editor-index e))
             e
             (make-editor (editor-text e)
                          (sub1 (editor-index e))))]
        [(string=? ke "right")
         (if (>= (editor-index e) (string-length (editor-text e)))
             e
             (make-editor (editor-text e)
                          (add1 (editor-index e))))]
        [(>= (string-length (editor-text e))
             char-limit)
         e]
        [(or (string=? ke "\t") (string=? ke "\r"))
         e]
        [(= (string-length ke) 1)
         (make-editor (string-append (substring (editor-text e) 0 (editor-index e))
                                     ke
                                     (substring (editor-text e) (editor-index e)))
                      (add1 (editor-index e)))]
        [else
         e]))