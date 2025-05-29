;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex003) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 3. Add the following two lines to the definitions area:
;
;    (define str "helloworld")
;    (define i 5)
;
;Then create an expression using string primitives that adds "_" at position i. In general this means the resulting string is longer than the original one; here the expected result is "hello_world".

(define str "helloworld")
(define i 5)


(define prefix (substring str 0 i))
(define suffix (substring str i))

(string-append prefix "_" suffix)