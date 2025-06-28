;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5-adding_structure_lec) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define one-posn (make-posn 8 6))

(define p (make-posn 31 26))

(posn-x p)
(posn-y p)
(posn? p)
(posn? 1)

;; Posn -> Number
; computes the distance of ap to the origin 
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

;(define (distance-to-0 ap) 0)

#;
(define (distance-to-0 ap)
  (... (posn-x ap) ...
       ... (posn-y ap) ...))

(define (distance-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))

;; Structure Type Definitions
;; -> (define-struct StructureName [FieldName ...])
(define-struct posn [x y])



(define-struct entry [name phone email])