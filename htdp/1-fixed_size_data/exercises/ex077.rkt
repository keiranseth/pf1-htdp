;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex077) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 77. Provide a structure type definition and a data definition for representing points in time since midnight. A point in time consists of three numbers: hours, minutes, and seconds.

; Hour is Integer[0, 23]
; Interpretation. The number of hours in a time of day.

; Minute is Integer[0, 59]
; Interpretation. The number of minutes within a specific hour.

; Second is Integer[0, 59]
; Interpretation. The number of seconds within a specific minute.

(define-struct time (h m s))
; Time is a structure:
;    (make-time Hour Minute Second)
; Interpretation. (make-time h m s) is a specific time within a day, where
;                   - h is the current hour,
;                   - m is the number of minutes in the current hour, and
;                   - s is the number of seconds in the current minute.