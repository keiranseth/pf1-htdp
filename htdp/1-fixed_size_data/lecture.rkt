;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define (letter first-name last-name signature-name)
  (string-append
    (opening first-name)
    "\n\n"
    (body first-name last-name)
    "\n\n"
    (closing signature-name)))
 
(define (opening first-name)
  (string-append "Dear " first-name ","))
 
(define (body first-name last-name)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " last-name " have won our lottery. So, " "\n"
   first-name ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))


(write-file 'stdout (letter "Matt" "Fiss" "Fell"))

(write-file "sample.dat" "Hello,\nworld.")
(write-file 'stdout (read-file "sample.dat"))