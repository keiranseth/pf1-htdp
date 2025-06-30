;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex076) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 76. Formulate data definitions for the following structure type definitions:
;
;    (define-struct movie [title producer year])
;
;    (define-struct person [name hair eyes phone])
;
;    (define-struct pet [name number])
;
;    (define-struct CD [artist title price])
;
;    (define-struct sweater [material size producer])
;
;Make sensible assumptions as to what kind of values go into each field.


(define-struct movie [title producer year])
; Movie is a structure:
;    (make-movie String String Integer)
; Interpretation. (make-movie title producer year) is a movie, where
;                 - title is the movie's title,
;                 - producer is the movie's main producer, and
;                 - year is the movie's release year.


(define-struct person [name hair eyes phone])
; Person is a structure:
;    (make-person String String String NonNegativeInteger)
; Interpretation. (make-person name hair eyes phone) is a person, where
;                  - name is the person's full name,
;                  - hair is the person's hair color,
;                  - eyes is the person's eye color, and
;                  - phone is the person's phone number.


(define-struct pet [name number])
; Pet is a structure:
;    (make-pet String NonNegativeInteger)
; Interpretation. (make-pet name number) is a pet, where
;                   - name is the pet's name, and
;                   - number is the pet's number, written on the their tag.


(define-struct CD [artist title price])
; CD is a structure:
;    (make-CD String String Number)
; Interpretation. (make-CD artist title price) is a CD album, where
;                   - artist is the album artist,
;                   - title is the album name, and
;                   - price is the CD album's retail price.



; Size is one of:
;  - "Extra Small"
;  - "Small"
;  - "Medium"
;  - "Large"
;  - "Extra Large"

(define-struct sweater [material size producer])
; Sweater is a structure:
;    (make-sweater String Size String)
; Interpretation. (make-sweater material size producer) is a sweater, where
;                   - material is the name of the sweater fabric's material,
;                   - size is the sweater's size, and
;                   - producer is the name of the sweater's manufacturer or brand.