; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- BOX RELATED VARIABLES ----------------------------------------------------

BOXCOL      DS.W    1                       ; COLUMN WHERE THE BOX IS PAINTED  
BOXROW      DS.W    1                       ; ROW WHERE THE BOX IS PAINTED
BOXPOSX     DS.W    1                       ; BOX X COORDINATE
BOXPOSY     DS.W    1                       ; BOX Y COORDINATE

; --- PIECE RELATED VARIABLES --------------------------------------------------

PIEPOSX     DS.W    1                       ; PIECE X COORDINATE
PIEPOSY     DS.W    1                       ; PIECE Y COORDINATE
PIEVELX     DS.W    1                       ; X MOVEMENT
PIEVELY     DS.W    1                       ; Y MOVEMENT
POSX        DS.W    1                       ; POS. X IN THE MATRIX 
POSY        DS.W    1                       ; POS. Y IN THE MATRIX
FALLING     DS.B    1                       ; 1 A PIECE IS FALLING, 0 NOT
            DS.W    0

; --- COLUMN RELATED VARIABLES -------------------------------------------------

ROW1        DS.B    7
ROW2        DS.B    7
ROW3        DS.B    7
ROW4        DS.B    7
ROW5        DS.B    7
ROW6        DS.B    7
            DS.W    0

; --- PLAYER VARIABLES ---------------------------------------------------------

TURN        DS.B    1                       ; PLAYER WHO PLAY IN THAT TURN
WINNER      DS.B    1                       ; 0 NONE, 1 OR 5 (PLAYER WHO WIN)
            DS.W    0

; --- INTRO STATE RELATED VARAIBLES --------------------------------------------

TIMER       DS.W    1                       ; INTRO TIMER 

; --- STATE RELATED VARAIBLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- FILE VARAIBLES -----------------------------------------------------------

FILEID      DS.L    1                       ; ID OF THE OPENED FILE
READED      DS.B    126                     ; MOVEMENTS READ (42 BOXES * 3)    
            DS.W    0 


















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
