;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex086) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 86. Notice that if you type a lot, your editor program does not display all of the text. Instead the text is cut off at the right margin. Modify your function edit from exercise 84 so that it ignores a keystroke if adding it to the end of the pre field would mean the rendered text is too wide for your canvas.


(require 2htdp/image)
(require 2htdp/universe)

;; Constant and Data Definitions

(define background (empty-scene 200 20))

(define cursor (rectangle 1 20 "solid" "red"))

(define text-size 11)
(define text-color "black")

(define char-limit 42)


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

;; Editor -> Editor
;; start the world with (run (make-editor "" ""))
;; 
(define (run e)
  (big-bang e            ; Editor
    (to-draw   render)   ; Editor -> Image
    (on-key    edit)))   ; Editor KeyEvent -> WS


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


;; Editor KeyEvent -> Editor
;; Let the user input into the editor.
;;   - "left" moves the cursor one character to the left,
;;   - "right" moves the cursor one character to the right,
;;   - "\b" erases the character to the left of cursor,
;;   - 1-string such as letters, numbers, and punctuations are entered, and
;;   - the rest are ignored.
(check-expect (edit (make-editor "abcdefgh     ijklmno" "pqr   stuvwxyzabcdefghijk") " ")
              (make-editor "abcdefgh     ijklmno" "pqr   stuvwxyzabcdefghijk"))
(check-expect (edit (make-editor "hello" " world") "\b")
              (make-editor "hell" " world"))
(check-expect (edit (make-editor "" " world") "\b")
              (make-editor "" " world"))
(check-expect (edit (make-editor "hello" " world") "left")
              (make-editor "hell" "o world"))
(check-expect (edit (make-editor "" " world") "left")
              (make-editor "" " world"))
(check-expect (edit (make-editor "hello" " world") "right")
              (make-editor "hello " "world"))
(check-expect (edit (make-editor "hello" "") "right")
              (make-editor "hello" ""))
(check-expect (edit (make-editor "hello" " world") "\t")
              (make-editor "hello" " world"))
(check-expect (edit (make-editor "hello" " world") "\r")
              (make-editor "hello" " world"))
(check-expect (edit (make-editor "hello" " world") "x")
              (make-editor "hellox" " world"))
(check-expect (edit (make-editor "hello" " world") "shift")
              (make-editor "hello" " world"))

;(define (edit e ke) e)

#;
(define (edit e ke)
  (cond [(string=? ke "\b")
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [(string=? ke "left")
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [(string=? ke "right")
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [(>= (+ (string-length (editor-pre e))
                (string-length (editor-post e)))
             char-limit)
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [(or (string=? ke "\t") (string=? ke "\r"))
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [(= (string-length ke) 1)
         (... (editor-pre e) ...
              ... (editor-post e) ...)]
        [else
         (... (editor-pre e) ...
              ... (editor-post e) ...)]))

(define (edit e ke)
  (cond [(string=? ke "\b")
         (if (string=? (editor-pre e) "")
             e
             (make-editor (substring (editor-pre e) 0 (sub1 (string-length (editor-pre e))))
                          (editor-post e)))]
        [(string=? ke "left")
         (if (string=? (editor-pre e) "")
             e
             (make-editor (substring (editor-pre e) 0 (sub1 (string-length (editor-pre e))))
                          (string-append (substring (editor-pre e) (sub1 (string-length (editor-pre e))))
                                         (editor-post e))))]
        [(string=? ke "right")
         (if (string=? (editor-post e) "")
             e
             (make-editor (string-append (editor-pre e)
                                         (substring (editor-post e) 0 1))
                          (substring (editor-post e) 1)))]
        [(>= (+ (string-length (editor-pre e))
                (string-length (editor-post e)))
             char-limit)
         e]
        [(or (string=? ke "\t") (string=? ke "\r")) e]
        [(= (string-length ke) 1)
         (make-editor (string-append (editor-pre e) ke)
                      (editor-post e))]
        [else
         e]))