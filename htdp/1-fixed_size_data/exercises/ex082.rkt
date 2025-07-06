;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex082) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 82. Design the function compare-word. The function consumes two three-letter words (see exercise 78). It produces a word that indicates where the given ones agree and disagree. The function retains the content of the structure fields if the two agree; otherwise it places #false in the field of the resulting word. Hint The exercises mentions two tasks: the comparison of words and the comparison of “letters.”

; Okay, my understanding is, for example, if I have (make-word "e" "v" "e") and (make-word "e" "v" "a"),
; then the function should produce (make-word "e" "v" #false). That's where I'm at. I don't know if
; I'm interpreting the instructions correctly, but the example I gave is where my mind's at.


; 1StringGuess is one of:
;   - 1String["a", "b", ..., "y", "z"]
;   - #false
; Interpretation. A one-character guess, or pre-cursor to the guess, in a Hangman game.

(define-struct word (f s t))
; Word is a structure:
;     (make-word 1StringGuess 1StringGuess 1StringGuess)
; Interpretation. A Word is a secret word in a game of Hangman, where
;                  - f is the first secret letter,
;                  - s is the second secret letter, and
;                  - t is the third secret letter.
#;
(define (fn-for-word w)
  (... (word-f w) ...
       ... (word-s w) ...
       ... (word-t w) ...))


;; Word Word -> Word
;; Given two words, compare each letter in their corresponding positions,
;; and produce a where corresponding words agree or disagree.
;; If each corresponding letter matches, produce the letter.
;; Else, produce #false.
(check-expect (compare-word (make-word "g" "a" "y")
                            (make-word "l" "e" "z"))
              (make-word #false #false #false))
(check-expect (compare-word (make-word "b" "a" "t")
                            (make-word "c" "a" "r"))
              (make-word #false "a" #false))
(check-expect (compare-word (make-word "e" "v" "e")
                            (make-word "e" "v" "a"))
              (make-word "e" "v" #false))
(check-expect (compare-word (make-word "s" "l" "y")
                            (make-word "s" "l" "y"))
              (make-word "s" "l" "y"))
(check-expect (compare-word (make-word #false "b" "c")
                            (make-word #false "c" "c"))
              (make-word #false #false "c"))

;(define (compare-word w1 w2) (make-word #false #false #false))
#;
(define (compare-word w1 w2)
  (... (word-f w1) ...
       ... (word-s w1) ...
       ... (word-t w1) ...
       ... (word-f w2) ...
       ... (word-s w2) ...
       ... (word-t w2) ...))

(define (compare-word w1 w2)
  (make-word (compare-1string (word-f w1) (word-f w2))
             (compare-1string (word-s w1) (word-s w2))
             (compare-1string (word-t w1) (word-t w2))))

;; 1StringGuess 1StringGuess -> 1StringGuess
;; Given two 1-string guesses:
;;     return the 1-string if they match.
;;     Else, return #false.
(check-expect (compare-1string #false #false) #false)
(check-expect (compare-1string "a" #false) #false)
(check-expect (compare-1string #false "b") #false)
(check-expect (compare-1string "a" "b") #false)
(check-expect (compare-1string "x" "x") "x")

;(define (compare-1string x y) #false)
#;
(define (compare-1string x y)
  (... x ...
       ... y ...))

(define (compare-1string x y)
  (if (equal? x y)
      x
      #false))
