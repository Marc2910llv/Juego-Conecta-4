; ==============================================================================
; SYSTEM CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU     640                     ; SCREEN WIDTH
SCRHEIGH    EQU     480                     ; SCREEN HEIGHT
SCRFPS      EQU     50                      ; SCREEN FRAMES PER SECOND

; --- KEYCODES -----------------------------------------------------------------

KBDLEFT     EQU     $25
KBDUP       EQU     $26
KBDRIGHT    EQU     $27
KBDDOWN     EQU     $28
KBDFIRE1    EQU     ' '
KBDFIRE2    EQU     'M'
KBDFIRE3    EQU     $10
KBDPAUSE    EQU     'P'

MOUEVTMV    EQU     4
MOUEVTBU    EQU     2
MOUEVTBD    EQU     1

; --- TRAP NUMBERS -------------------------------------------------------------

SCRUPTN     EQU     0                       ; SCREEN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER
*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
