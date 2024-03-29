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
PIERAD      EQU     35                      ; PIECE RADIUS

; --- TABLE RELATED CONSTANTS ----------------------------------------------------

TABPCOL     EQU     $00FF0000               ; TAB CONTOUR COLOR
TABFCOL     EQU     $00AA0000               ; TAB FILL COLOR

; --- STATE RELATED CONSTANTS ----------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER

; --- FILE CONSTANTS -------------------------------------------------------------

FILE        DC.B    'automaticgame.txt',0   ; FILE NAME
            DS.W    0











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
