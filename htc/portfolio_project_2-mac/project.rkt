;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname project) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Missionaries and Cannibals Solver

(require 2htdp/image)
(require 2htdp/universe)

;; Data Definitions

;; Missionary is a NonNegativeInteger
;; The number of missionaries.
;; Cannibal is a NonNegativeInteger
;; The number of cannibals
;; Capacity is a NonNegativeInteger
;; The maximum number of passengers in a river boat.

(define-struct riverbank (missionary cannibal))
;; RiverBank is a structure:
;;  (make-riverbank Missionary Cannibal)
;; A river bank consisting of missionaries and cannibals.
#;
(define (fn-for-riverbank rb)
  (... (riverbank-missionary rb)
       (riverbank-cannibal rb)))

;; Embarking is Boolean
;; The boat's embarking/disembarking status, where
;;  - #f means the boat is disembarking, and
;;  - #t means the boat is embarking.

;; Side is one of:
;;  - "l", and
;;  - "r".
;; The location the boat is currently on, where
;;  - "l" means the boat is on the left river bank, and
;;  - "r" means the boat is on the right river bank.

(define-struct boat (capacity missionary cannibal embarking? side))
;; Boat is a structure:
;;  (make-boat Capacity Missionary Cannibal Embarking Side)
;; A boat which will help the missionaries and cannibals
;; cross the river.
#;
(define (fn-for-boat b)
  (... (boat-capacity b)
       (boat-missionary b)
       (boat-cannibal b)
       (boat-embarking? b)
       (boat-side b)))

(define-struct game (left boat right))
;; Game is a structure:
;;  (make-game RiverBank Boat RiverBank)
;; A state in a missionaries-and-cannibals puzzle.
#;
(define (fn-for-game g)
  (... (fn-for-riverbank (game-left g))
       (fn-for-boat (game-boat g))
       (fn-for-riverbank (game-right g))))

;; Solution is (listof Game)
;; A list of game states, serving as a solution
;; to a missionaries and cannibals puzzle.


;; Constant Definitions

(define G0
  (make-game (make-riverbank 0 0)
             (make-boat 2 0 0 #f "r")
             (make-riverbank 1 1)))

(define S0
  (list G0
        (make-game (make-riverbank 0 0)
             (make-boat 2 0 0 #t "r")
             (make-riverbank 1 1))
        (make-game (make-riverbank 0 0)
             (make-boat 2 1 1 #f "r")
             (make-riverbank 0 0))
        (make-game (make-riverbank 0 0)
             (make-boat 2 1 1 #f "l")
             (make-riverbank 0 0))
        (make-game (make-riverbank 1 1)
             (make-boat 2 0 0 #f "l")
             (make-riverbank 0 0))))

(define G1
  (make-game (make-riverbank 0 0)
             (make-boat 2 0 0)
             (make-riverbank 3 3)))


;; 0M 0C | 0M 0C | 3M 3C
;; 0M 0C | 0M 2C | 3M 1C
;; 0M 1C | 0M 1C | 3M 1C
;; 0M 1C | 0M 2C | 3M 0C
;; 0M 2C | 0M 1C | 3M 0C
;; 0M 2C | 2M 0C | 1M 1C
;; 1M 1C | 1M 1C | 1M 1C
;; 1M 1C | 2M 0C | 0M 2C
;; 3M 0C | 0M 1C | 0M 2C
;; 3M 0C | 0M 2C | 0M 1C
;; 3M 1C | 0M 1C | 0M 1C
;; 3M 1C | 0M 2C | 0M 0C
;; 3M 3C | 0M 0C | 0M 0C

;; change solution after the boat definition update
(define S1
  (list G1
        (make-game (make-riverbank 0 0)
                   (make-boat 2 0 2)
                   (make-riverbank 3 1))
        (make-game (make-riverbank 0 1)
                   (make-boat 2 0 1)
                   (make-riverbank 3 1))
        (make-game (make-riverbank 0 1)
                   (make-boat 2 0 2)
                   (make-riverbank 3 0))
        (make-game (make-riverbank 0 2)
                   (make-boat 2 0 1)
                   (make-riverbank 3 0))
        (make-game (make-riverbank 0 2)
                   (make-boat 2 2 0)
                   (make-riverbank 1 1))
        (make-game (make-riverbank 1 1)
                   (make-boat 2 1 1)
                   (make-riverbank 1 1))
        (make-game (make-riverbank 1 1)
                   (make-boat 2 2 0)
                   (make-riverbank 0 2))
        (make-game (make-riverbank 3 0)
                   (make-boat 2 0 1)
                   (make-riverbank 0 2))
        (make-game (make-riverbank 3 0)
                   (make-boat 2 0 2)
                   (make-riverbank 0 1))
        (make-game (make-riverbank 3 1)
                   (make-boat 2 0 1)
                   (make-riverbank 0 1))
        (make-game (make-riverbank 3 1)
                   (make-boat 2 0 2)
                   (make-riverbank 0 0))
        (make-game (make-riverbank 3 3)
                   (make-boat 2 0 0)
                   (make-riverbank 0 0))))

; Immediate loss. Return #f.
(define G2
  (make-game (make-riverbank 0 0)
             (make-boat 2 0 0 #f "r")
             (make-riverbank 2 3)))
; Boat is broken. Return #f.
(define G3
  (make-game (make-riverbank 0 0)
             (make-boat 0 0 0 #f "r")
             (make-riverbank 3 3)))
; Boat capacity is too small. Return #f.
(define G4
  (make-game (make-riverbank 0 0)
             (make-boat 1 0 0 #f "r")
             (make-riverbank 3 3)))
(define G5
  (make-game (make-riverbank 0 0)
             (make-boat 2 0 0 #f "r")
             (make-riverbank 4 4)))



;; Function Definitions

;; Game -> (listof Game) of #false
;; Return a valid solution to the given missionaries and cannibals
;; puzzle. Return #false if there are no solutions.
(check-expect (solve G2) #f)
(check-expect (solve G3) #f)
(check-expect (solve G4) #f)
(check-expect (solve G5) #f)
(check-expect (solve G0) S0)
(check-expect (solve G1) S1)

;(define (solve g) #f)

(define (solve g)
  (local [(define (fn-for-s s g)
            (if (solved? s)
                s
                (fn-for-los (next-game-states s g))))
          (define (fn-for-los los)
            (cond [(empty? los) #f]
                  [else
                   (local [(define try (fn-for-s (first los)
                                                 (get-last-lox (first los))))]
                     (if (not (false? try))
                         try
                         (fn-for-los (rest los))))]))]
    (fn-for-s '() g)))


#;
(define (solve g)
  (local [(define (fn-for-g g sol)
            (if (solved? sol)
                sol
                (fn-for-los (next-games g sol))))
          (define (fn-for-los los)
            (cond [(empty? log) #f]
                  [else
                   (local [(define try (fn-for-g (first log) sol))]
                     (if (not (false? try))
                         try
                         (fn-for-los (rest log))))]))]
    (fn-for-g g '())))


;; Solution -> Boolean
;; Return #t if the given solution is valid. That is,
;;  - All the missionaries and cannibals are in
;;  - the left side of the river.
; change tests after the boat definition update
(check-expect (solved? (list G1)) #f)
(check-expect (solved? (list G1
                             (make-game (make-riverbank 0 0)
                                        (make-boat 2 0 2)
                                        (make-riverbank 3 1))
                             (make-game (make-riverbank 0 1)
                                        (make-boat 2 0 1)
                                        (make-riverbank 3 1))
                             (make-game (make-riverbank 0 1)
                                        (make-boat 2 0 2)
                                        (make-riverbank 3 0))
                             (make-game (make-riverbank 0 2)
                                        (make-boat 2 0 1)
                                        (make-riverbank 3 0))
                             (make-game (make-riverbank 0 2)
                                        (make-boat 2 2 0)
                                        (make-riverbank 1 1)))) #f)
(check-expect (solved? S1) #t)

(define (solved? s) #f)


;; Solution Game -> (listof Solution)
;; Given the current state of a missionaries-and-cannibals puzzle,
;; return all possible, but strictly valid, game states.
#;
(check-expect (next-game-states '()
                                (make-game (make-riverbank 0 0)
                                           (make-boat 2 0 0)
                                           (make-riverbank 3 3)))
              (list))

(define (next-game-states s g) '())


;; (listof X) -> X or #f
;; Return the last element in the given list lox,
;; or return #f if empty.
(check-expect (get-last-lox '()) #f)
(check-expect (get-last-lox (list 1)) 1)
(check-expect (get-last-lox (list "A" "B" "C" "D")) "D")

;(define (get-last-lox lox) #f)
#;
(define (get-last-lox lox)
  (cond [(empty? lox) (...)]
        [else
         (... (first lox)
              (fn-for-lox (rest lox)))]))

(define (get-last-lox lox)
  (local [(define (fn-for-lox lox last)
            (cond [(empty? lox) last]
                  [else
                   (fn-for-lox (rest lox) (first lox))]))]
    (fn-for-lox lox #f)))