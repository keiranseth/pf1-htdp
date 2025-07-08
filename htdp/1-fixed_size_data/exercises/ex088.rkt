;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex088) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 88. Define a structure type that keeps track of the cat’s x-coordinate and its happiness. Then formulate a data definition for cats, dubbed VCat, including an interpretation.



(require 2htdp/image)
(require 2htdp/universe)

;; CONSTANT DEFINITIONS

(define HEIGHT 240)
(define WIDTH (* HEIGHT 16/9))
(define BACKGROUND (empty-scene WIDTH HEIGHT "Cornsilk"))



;; DATA DEFINITIONS

;; HappinessLevel is Number
;; interpretation. hl is the level of hapiness between 0 and 100 (inclusive).
(define HL1 0)   ; Cat is depressed.
(define HL2 100) ; Cat is maniacally ecstatic.
(define Hl3 64)  ; Cat is mildly happy.

#;
(define (fn-for-happinesslevel hl)
  (... hl))


(define-struct vcat (xp hl))
;; VCat is a structure
;;    (make-vcat Integer[0, WIDTH] HappinessLevel)
;; Interpretation. (make-vcat xp hl) describes a cat
;;                 that can only move horizontally (xp)
;;                 and also has a happiness measure (hl).

#;
(define (fn-for-vcat vc)
  (... (vcat-xp vc) ...
       ... (fn-for-happinesslevel (vcat-hl vc)) ...))