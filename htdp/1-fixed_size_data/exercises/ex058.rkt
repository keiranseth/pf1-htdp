;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex058) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 58. Introduce constant definitions that separate the intervals for low prices and luxury prices from the others so that the legislators in Tax Land can easily raise the taxes even more.

(define TAX-BOUNDARY-1 1000)   ; price level for the 1th level of tax
(define TAX-BOUNDARY-2 10000)  ; price level for the 2th level of tax
(define TAX-1 0.05)            ; tax for the 1th level of tax
(define TAX-2 0.08)            ; tax for the 2th level of tax




; A Price falls into one of three intervals: 
; — 0 through TAX-BOUNDARY-1
; — TAX-BOUNDARY-1 through TAX-BOUNDARY-2
; — TAX-BOUNDARY-2 and above.
; interpretation the price of an item


; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax TAX-BOUNDARY-1) (* TAX-1 TAX-BOUNDARY-1))
(check-expect (sales-tax (+ TAX-BOUNDARY-1 282)) (* TAX-1 (+ TAX-BOUNDARY-1 282)))
(check-expect (sales-tax TAX-BOUNDARY-2) (* TAX-2 TAX-BOUNDARY-2))
(check-expect (sales-tax (+ TAX-BOUNDARY-2 2017)) (* TAX-2 (+ TAX-BOUNDARY-2 2017)))

;(define (sales-tax p) 0)
#;
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p TAX-BOUNDARY-1)) ...]
    [(and (<= TAX-BOUNDARY-1 p) (< p TAX-BOUNDARY-2)) ...]
    [(>= p TAX-BOUNDARY-2) ...]))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p TAX-BOUNDARY-1)) 0]
    [(and (<= TAX-BOUNDARY-1 p) (< p TAX-BOUNDARY-2)) (* TAX-1 p)]
    [(>= p TAX-BOUNDARY-2) (* TAX-2 p)]))