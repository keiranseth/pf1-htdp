;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex065) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 65. Take a look at the following structure type definitions:
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
;Write down the names of the functions (constructors, selectors, and predicates) that each introduces.


;; 1. (define-struct movie [title producer year])

(define-struct movie [title producer year])

(define TAMAKO (make-movie "Tamako Love Story" "Naoko Yamada" 2014))

TAMAKO
(movie-title TAMAKO)
(movie-producer TAMAKO)
(movie-year TAMAKO)
(movie? TAMAKO)


;; 2. (define-struct person [name hair eyes phone])

(define-struct person [name hair eyes phone])

(define ADAM (make-person "Adam" "Black" "Brown" "Tin Can with String"))
ADAM
(person-name ADAM)
(person-hair ADAM)
(person-eyes ADAM)
(person-phone ADAM)
(person? ADAM)


;; 3. (define-struct pet [name number])

(define-struct pet [name number])

(define BOBA (make-pet "Boba" 5058))
BOBA
(pet-name BOBA)
(pet-number BOBA)
(pet? BOBA)


;; 4. (define-struct CD [artist title price])

(define-struct CD [artist title price])

(define ABBA (make-CD "Abba" "ABBA Gold: Greatest Hits" 12.64))
ABBA
(CD-artist ABBA)
(CD-title ABBA)
(CD-price ABBA)
(CD? ABBA)


;; 5. (define-struct sweater [material size producer])

(define-struct sweater [material size producer])

(define SOFT-SWEATER (make-sweater "Poly-cotton Blend" "Small" "Sanrio"))
SOFT-SWEATER
(sweater-material SOFT-SWEATER)
(sweater-size SOFT-SWEATER)
(sweater-producer SOFT-SWEATER)
(sweater? SOFT-SWEATER)