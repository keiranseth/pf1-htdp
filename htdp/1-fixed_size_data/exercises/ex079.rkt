;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex079) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 79. Create examples for the following data definitions:
;
;        ; A Color is one of: 
;        ; — "white"
;        ; — "yellow"
;        ; — "orange"
;        ; — "green"
;        ; — "red"
;        ; — "blue"
;        ; — "black"
;
;    Note DrRacket recognizes many more strings as colors. End
;
;        ; H is a Number between 0 and 100.
;        ; interpretation represents a happiness value
;
;        (define-struct person [fstname lstname male?])
;        ; A Person is a structure:
;        ;   (make-person String String Boolean)
;
;    Is it a good idea to use a field name that looks like the name of a predicate?
;
;        (define-struct dog [owner name age happiness])
;        ; A Dog is a structure:
;        ;   (make-dog Person String PositiveInteger H)
;
;    Add an interpretation to this data definition, too.
;
;        ; A Weapon is one of: 
;        ; — #false
;        ; — Posn
;        ; interpretation #false means the missile hasn't 
;        ; been fired yet; a Posn means it is in flight
;
;The last definition is an unusual itemization, combining built-in data with a structure type. The next chapter deals with such definitions in depth.



; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
; ...
(define C1 "orange")
(define C2 "blue")
(define C3 "cerulean")


; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define H1 0)    ; depression lmao
(define H2 100)  ; being high on anti-depressants lmao
(define H3 50)   ; the recognition that happiness is not always bliss, and that lucidity and peace in suffering and bliss can be found.


(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
; Interpretation. (make-person fstname lstname male?) is a person, where
;                   - fstname is the person's first name,
;                   - lstname is the person's surname, and
;                   - male? indicates whether the person is male or not male.
(define RANDON (make-person "Randon" "Neuring" #true))
(define P2 (make-person "Skurry" "Speedrunner" #false))


(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; Interpretation. (make-dog owner name age happiness) is a pet, where
;                   - owner is the pet's owner, which is a Person,
;                   - name is the pet's name,
;                   - age is the pet's age in years, and
;                   - happiness is the pet's happiness level (from 0 to 100).
(define D1 (make-dog RANDON "Orbie" 2 11))
(define D2 (make-dog (make-person "Caspurr" "Catacini" #true)
                     "Boba"
                     10
                     97))


; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight
(define W1 #false)
(define W2 (make-posn 100 120))