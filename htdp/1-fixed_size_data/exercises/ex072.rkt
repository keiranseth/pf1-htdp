;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex072) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 72. Formulate a data definition for the above phone structure type definition that accommodates the given examples.
;
;Next formulate a data definition for phone numbers using this structure type definition:
;
;    (define-struct phone# [area switch num])
;
;Historically, the first three digits make up the area code, the next three the code for the phone switch (exchange) of your neighborhood, and the last four the phone with respect to the neighborhood. Describe the content of the three fields as precisely as possible with intervals. 



(define-struct phone [area number])
;; A Phone is a structure:
;;   (make-phone NonNegativeInteger String) 
;; Interpretation. A person's contact information, where
;;                 - area is the 3-digit area code (###), and
;;                 - number is the person's 7-digit number (###-####).
(define P1 (make-phone 207 "363-2421"))
(define P2 (make-phone 101 "776-1099"))
(define P3 (make-phone 208 "112-9981"))


(define-struct phone# [area switch num])
;; A Phone# is a structure:
;;   (make-phone# NonNegativeInteger NonNegativeInteger NonNegativeInteger)
;; Interpretation. A person's contact information, where
;;                 - area is the person's 3-digit area code (###),
;;                 - switch is the person's 3-digit phone switch (or exchange) (###), and
;;                 - num is the person's 4-digit number wrt the neighborhood (####).

(define P#1 (make-phone# 207 363 2421))