; ==============================================================================
; GAME CONSTANTS
; ==============================================================================

; --- BALL RELATED CONTANTS ----------------------------------------------------

BALRAD      EQU     8                       ; BALL RADIUS
BALPCOL     EQU     $00AA0000               ; BALL CONTOUR COLOR
BALFCOL     EQU     $00FF0000               ; BALL FILL COLOR
BALSPEED    EQU     3                       ; MAGNITUDE OF THE X AND Y VEL.

; --- PAD RELATED CONSTANTS ----------------------------------------------------

PADWIDTH    EQU     16                      ; PAD WIDTH
PADHEIGH    EQU     64                      ; PAD HEIGHT
PADPOSX     EQU     48                      ; PAD X POSITION
PADSPEED    EQU     7                       ; MAGNITUDE OF THE Y DISPLACEMENT
PADPCOL     EQU     $0000FF00               ; PAD CONTOUR COLOR
PADFCOL     EQU     $0000AA00               ; PAD FILL COLOR

; --- SCOREBOARD RELATED CONSTANTS ---------------------------------------------

SCOFCOL     EQU     $00000000               ; TEXT BACKGROUND COLOR
SCOLINE1    EQU     $0101                   ; FIRST TEXT LINE COORDINATES
SCOLINE2    EQU     $0102                   ; SECOND TEXT LINE COORDINATES

; --- STATE RELATED CONSTANTS --------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER
ISCMAXTM    EQU     500                     ; INTRO SCREEN WATING CYCLES
INSMAXTM    EQU     500                     ; INSTRUCTIONS SCREEN WAITING CYCLES

; --- VICTORY/DEFEAT CONSTANTS -------------------------------------------------

SCOINMX     EQU     10                      ; NUMBER OF BALLS TO VICTORY
SCOOUTMX    EQU     10                      ; NUMBER OF BALLS TO DEFEAT






*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
