;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list_mechanisms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define L0 '())

(define L1 (cons "Hey" '()))

(define L2 (cons "Hey"
                 (cons "Hi" '())))

(define L4 (cons 1
                 (cons 2
                       (cons 4
                             (cons 8 '())))))

(define L3 (cons (square 64 "solid" "red")
                 (cons (square 64 "solid" "orange")
                       (cons (square 64 "solid" "yellow")
                             '()))))

(first L4)
(rest L4)

(empty? L1)
(empty? L0)

(cons? (first L4))
(cons? (rest L4))

(first (rest L3))  ; second element of L3