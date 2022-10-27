; ==============================================================================
; SYSTEM VARIABLES
; ==============================================================================
            
; --- KEYBOARD RELATED VARIABLES -----------------------------------------------

KBDVAL      DS.B    1                       ; KEY STATE
KBDEDGE     DS.B    1                       ; KEY EDGE

; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
            DS.W    0
            
; --- MOUSE RELATED VARIABLES

MOUPOSY     DS.W    1
MOUPOSX     DS.W    1


*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
