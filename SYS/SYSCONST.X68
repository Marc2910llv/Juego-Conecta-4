; ==============================================================================
; SYSTEM CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU     960                     ; SCREEN WIDTH
SCRHEIGH    EQU     720                     ; SCREEN HEIGHT
SCRFPS      EQU     60                      ; SCREEN FRAMES PER SECOND

; --- KEYCODES -----------------------------------------------------------------

KBDLEFT     EQU     $25
KBDUP       EQU     $26
KBDRIGHT    EQU     $27
KBDDOWN     EQU     $28
KBDFIRE1    EQU     ' '
KBDFIRE2    EQU     'M'
KBDFIRE3    EQU     $10
KBDPAUSE    EQU     'P'

; --- SOUND IDENTIFIERS --------------------------------------------------------

SNDMOVE     EQU     0
SNDFALL     EQU     1
SNDWIN      EQU     2
SNDMUSIC    EQU     3

; --- TRAP NUMBERS -------------------------------------------------------------

SCRUPTN     EQU     0                       ; SCREEN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

; --- INTERRUPT NUMBERS  -------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
