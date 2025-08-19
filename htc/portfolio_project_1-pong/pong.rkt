;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname pong) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Simple Pong

(require 2htdp/image)
(require 2htdp/universe)
(require racket/random)

;; Constant Definitions

(define DVDR-COLOR "White")
(define DVDR-WIDTH 1)
(define DVDR-STYLE "solid")
(define DVDR-CAP "butt")
(define DVDR-JOIN "bevel")

(define BG-WIDTH 1080)
(define BG-HEIGHT (* BG-WIDTH 9/16))
(define BG-COLOR "Black")
(define BACKGROUND (add-line (empty-scene BG-WIDTH
                                          BG-HEIGHT
                                          BG-COLOR)
                             (/ BG-WIDTH 2) 0
                             (/ BG-WIDTH 2) BG-HEIGHT
                             (pen DVDR-COLOR
                                  DVDR-WIDTH
                                  DVDR-STYLE
                                  DVDR-CAP
                                  DVDR-JOIN)))

(define PADDLE-WIDTH (/ BG-WIDTH 40))
(define PADDLE-HEIGHT (* PADDLE-WIDTH 4))

(define USER-COLOR "Blue")
(define ENEMY-COLOR "Sea Green")
(define USER-PADDLE (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" USER-COLOR))
(define ENEMY-PADDLE (rectangle PADDLE-WIDTH PADDLE-HEIGHT "solid" ENEMY-COLOR))

(define USER-LINE (+ 4
                     (+ 0 (/ (image-width USER-PADDLE)
                             2))))
(define ENEMY-LINE (- (- BG-WIDTH (/ (image-width ENEMY-PADDLE)
                                     2))
                      4))
#;
(place-image ENEMY-PADDLE
             ENEMY-XP (/ BG-HEIGHT 2)
             (place-image USER-PADDLE
                          USER-XP (/ BG-HEIGHT 2)
                          BACKGROUND))

(define BALL-RADIUS (/ BG-WIDTH 80))
(define BALL-COLOR "Black")
(define BALL (circle BALL-RADIUS "solid" BALL-COLOR))

(define SCORE-SIZE (/ BG-WIDTH 20))
(define SCORE-COLOR "White")
(define SCORE-XP (/ BG-WIDTH 2))
(define SCORE-YP (/ BG-HEIGHT 4))
(define SCORE-DIVIDER "    ")

(define YPOS-S (/ BG-HEIGHT 2))

#;
(place-image (text (string-append "10"
                                  SCORE-DIVIDER
                                  "10")
                   SCORE-SIZE SCORE-COLOR)
             SCORE-XP SCORE-YP
             BACKGROUND)



;; Data Definitions


;; Y-Position is Integer[0, BG-HEIGHT].
;; The position of an object along the y-axis on screen.
(define YP1 0)
(define YP2 10)
(define YP3 BG-HEIGHT)
#;
(define (fn-for-ypos yp)
  (... yp))


;; X-Direction is one of:
;;  - 1, and
;;  - -1.
;; Interpretation. The direction of movement along the x-axis.
;;  - 1 means right-wards movement, and
;;  - -1 means left-wards movement.
#;
(define (fn-for-xdir xd)
  (cond [(= xd 1) (...)]
        [(= xd -1) (...)]))


;; Y-Direction is one of:
;;  - -1,
;;  - 0, and
;;  - 1.
;; Interpretation. The direction of movement along the y-axis.
;;  - -1 means upwards movement,
;;  - 0 means there is no movement, and
;;  - 1 means downwards movement.
#;
(define (fn-for-ydir yd)
  (cond [(= yd -1) (...)]
        [(= yd 0) (...)]
        [(= yd 1) (...)]))


(define-struct ball (xdir ydir))
;; Ball is a structure:
;;   (make-ball X-Direction Y-Direction)
;; Interpretation. A Ball is the ball the paddles hit in a game of Pong.
(define B0 (make-ball -1 0))
(define B1 (make-ball 1 -1))
(define B2 (make-ball -1 1))
#;
(define (fn-for-ball b)
  (... (ball-xdir b)
       (ball-ydir b)))


;; Score is Integer[0, 9].
;; Interpretation. A paddle's score in a game of Pong.
(define S1 0)
(define S2 3)
(define S3 9)
#;
(define (fn-for-score s)
  (... s))


(define-struct paddle (ypos ydir score))
;; Paddle is a structure:
;;   (make-paddle Y-Position Y-Direction Score)
;; Interpretation. A Paddle is a player in a game of Pong, where
;;      - y-pos is the player's current Y-Position,
;;      - ydir is the player's current y-direction of movement, and
;;      - score is the player's current score.
(define USER (make-paddle YPOS-S 0 0))
(define ENEMY (make-paddle YPOS-S 0 0))
#;
(define (fn-for-paddle p)
  (... (fn-for-ypos (paddle-ypos p))
       (fn-for-ydir (paddle-ydir p))
       (fn-for-score (paddle-score p))))


(define-struct game (user enemy ball))
;; Game is a structure:
;;   (make-game Paddle Paddle Ball)
;; Interpretation. The program state of a game of Pong.
;; The attributes include:
;;    - user represents the user's paddle,
;;    - enemy represents the computer opponent's paddle, and
;;    - ball represents the state of the ball.
#;
(define (fn-for-game g)
  (... (fn-for-paddle (game-user g))
       (fn-for-paddle (game-enemy g))
       (fn-for-ball (game-ball g))))



;; Function Definitions

;; Game -> Game
;; Begin the world with:
;;     (make-game USER ENEMY (make-ball (random-ref (list -1 1)) (random-ref (list -1 1))))

(define (simple-pong g)
  (big-bang g                  ; Game
    (on-tick tock)             ; Game -> Game
    (to-draw draw)             ; Game -> Image
    (stop-when end?)           ; Game -> Boolean
    (on-key handle-inputs)))   ; Game KeyEvent -> Game



;; Game -> Game
;; Produce the next game state, where the ball's movement,
;; the enemy paddle's movement, and the scores are handled.
;; !!!
(define (tock g) ...)


;; Game -> Image
;; Render all the game elements on screen.
;; !!!
(define (draw g) ...)


;; Game -> Boolean
;; Signals the win condition and end the game.
;; !!!
(define (end? g) ...)


;; Game KeyEvent -> Game
;; Helps the user control the user paddle and play the game.
;; !!!
(define (handle-inputs g ke) ...)


