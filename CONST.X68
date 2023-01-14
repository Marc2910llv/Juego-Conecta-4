; ==============================================================================
; GAME CONSTANTS
; ==============================================================================

; --- BOX RELATED CONTANTS ----------------------------------------------------

BOXNCOL     EQU     7                       ; NUMBER OF BOXES IN A COLUMN
BOXNROW     EQU     6                       ; NUMBER OF BOXES IN A ROW
BOXPCOL     EQU     $00AA0000               ; BOXCONTOUR COLOR
BOXFCOL     EQU     $00000000               ; BOX FILL COLOR
BOXRAD      EQU     45                      ; BOX RADIUS

; --- PIECE RELATED CONTANTS ----------------------------------------------------

PIEPCOL1    EQU     $000000AA               ; PIECE CONTOUR COLOR TURN 1
PIEFCOL1    EQU     $000000FF               ; PIECE FILL COLOR TURN 1
PIEPCOL2    EQU     $0000AAAA               ; PIECE CONTOUR COLOR TURN 2
PIEFCOL2    EQU     $0000FFFF               ; PIECE FILL COLOR TURN 2               
PIEPCOL3    EQU     $00000000               ; PIECE CONTOUR COLOR WIN
PIEFCOL3    EQU     $003FEB1D               ; PIECE FILL COLOR WIN
PIESPEED    EQU     3                       ; MAGNITUDE OF THE FALL VEL.
PIERAD      EQU     35                      ; PIECE RADIUS

; --- TABLE RELATED CONSTANTS ----------------------------------------------------

TABPCOL     EQU     $00FF0000               ; TAB CONTOUR COLOR
TABFCOL     EQU     $00AA0000               ; TAB FILL COLOR

; --- BOARD RELATED CONSTANTS ---------------------------------------------

BOAFCOL     EQU     $00000000               ; TEXT BACKGROUND COLOR
BOALINE1    EQU     $0000                   ; FIRST TEXT LINE COORDINATES

; --- STATE RELATED CONSTANTS ---------------------------------------------------

STANONE     EQU     -1                      ;NON-EXISTENT STATE NUMBER







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
