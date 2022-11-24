; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     TABINIT
            ;JSR     BOXINIT
            JSR     PIEINIT
            ;BRA     SCOINIT
            RTS

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%00011111,D0
            BNE     .GOUPD
            LEA     PIEINIT,A1
            LEA     PIEUPD,A2
            LEA     PIEPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD
.GOUPD      JSR     AGLUPD
            JSR     BOXUPD        
            MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     AGLPLOT
            ;JSR     SCOPLOT
            BRA     BOXPLOT
            JSR     PIEPLOT
*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
