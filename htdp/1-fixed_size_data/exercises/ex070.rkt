;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex070) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 70. Spell out the laws for these structure type definitions:
;
;    (define-struct centry [name home office cell])
;    (define-struct phone [area number])
;
;Use DrRacket’s stepper to confirm 101 as the value of this expression:
;
;    (phone-area
;     (centry-office
;      (make-centry "Shriram Fisler"
;        (make-phone 207 "363-2421")
;        (make-phone 101 "776-1099")
;        (make-phone 208 "112-9981"))))


(define-struct centry [name home office cell])
;; DrRacket introduces four laws for the structure centry.
;;  - the centry's name: (centry-name ...)
;;  - the centry's home (centry-home ...)
;;  - the centry's office (centry-office ...)
;;  - the centry's cell (centry-cell ...)

(define-struct phone [area number])
;; DrRacket introduces two laws for the structure phone.
;;  - the phone's area: (phone-area ...)
;;  - the phone's number (phone-number ...)



(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
               (make-phone 207 "363-2421")
               (make-phone 101 "776-1099")
               (make-phone 208 "112-9981"))))

(phone-area
 (make-phone 101 "776-1099"))

101