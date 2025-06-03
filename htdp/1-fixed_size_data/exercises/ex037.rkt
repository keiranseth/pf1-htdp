;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex037) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 37. Design the function string-rest, which produces a string like the given one with the first character removed.

;; String -> String
;; Given a string, return the given with the first character removed.
(check-expect (string-rest "") "")
(check-expect (string-rest "A") "")
(check-expect (string-rest "Hi") "i")
(check-expect (string-rest "Sayonara") "ayonara")

;(define (string-rest str) "")
#;
(define (string-rest str)
  (... str))

(define (string-rest str)
  (if (> (string-length str) 1)
      (substring str 1)
      ""))