; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- BALL RELATED VARIABLES ---------------------------------------------------

BALPOSX     DS.W    1                       ; BALL X COORDINATE
BALPOSY     DS.W    1                       ; BALL Y COORDINATE
BALVELX     DS.W    1                       ; BALL X VELOCITY
BALVELY     DS.W    1                       ; BALL Y VELOCITY

; --- PIECE RELATED VARIABLES ---------------------------------------------------

PIEPOSX     DS.W    1                       ; PIECE X COORDINATE
PIEPOSY     DS.W    1                       ; PIECE Y COORDINATE
PIEVELY     DS.W    1                       ; PIECE Y VELOCITY



; --- TAB RELATED VARIABLES ----------------------------------------------------

TABPOSX     DS.W    1                       ; TAB x COORDINATE
TABPOSY     DS.W    1                       ; TAB Y COORDINATE
TABWIDTH    DS.W    1                       ; TAB WIDTH
TABHEIGH    DS.W    1                       ; TAB HEIGH

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOIN       DS.W    1                       ; NUMBER OF CAPTURED BALLS
SCOOUT      DS.W    1                       ; NUMBER OF MISSED BALLS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
