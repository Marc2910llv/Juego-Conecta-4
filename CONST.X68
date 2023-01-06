; ==============================================================================
; GAME CONSTANTS
; ==============================================================================

; --- BOX RELATED CONTANTS ----------------------------------------------------

BOXNCOL     EQU     7                       ; NUMBER OF BOXES IN A COLUMN
BOXNROW     EQU     6                       ; NUMBER OF BOXES IN A ROW
BOXPCOL     EQU     $00AA0000               ; BOXCONTOUR COLOR
BOXFCOL     EQU     $00AAAAAA               ; BOX FILL COLOR
BOXRAD      EQU     45                      ; BOX RADIUS

; --- PIECE RELATED CONTANTS ----------------------------------------------------

PIEPCOL1    EQU     $000000AA               ; PIECE CONTOUR COLOR TURN 1
PIEFCOL1    EQU     $000000FF               ; PIECE FILL COLOR TURN 1
PIEPCOL2    EQU     $0000AAAA               ; PIECE CONTOUR COLOR TURN 2
PIEFCOL2    EQU     $0000FFFF               ; PIECE FILL COLOR TURN 2
PIESPEED    EQU     3                       ; MAGNITUDE OF THE FALL VEL.
PIERAD      EQU     35                      ; PIECE RADIUS

; --- TAB RELATED CONSTANTS ----------------------------------------------------

TABPCOL     EQU     $00FF0000               ; TAB CONTOUR COLOR
TABFCOL     EQU     $00AA0000               ; TAB FILL COLOR

; --- COLUMN RELATED CONSTANTS -------------------------------------------------

PIEVAL1     EQU     $0000000A               ; LOGIC VALUE OF PIECE 1
PIEVAL2     EQU     $0000000B               ; LOGIC VALUE OF PIECE 2




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
