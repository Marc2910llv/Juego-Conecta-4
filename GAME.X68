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
            JSR     DMMINIT
            JSR     PADINIT
            BRA     SCOINIT

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
            LEA     BALINIT,A1
            LEA     BALUPD,A2
            LEA     BALPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD
.GOUPD      JSR     AGLUPD
            JSR     PADUPD
            CMP.W   #SCOINMX,(SCOIN)
            BLT     .CHKLOSS
            MOVE.W  #3,(STANEXT)
            BRA     .DONE
.CHKLOSS    CMP.W   #SCOOUTMX,(SCOOUT)
            BLT     .DONE
            MOVE.W  #4,(STANEXT)
.DONE       MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     AGLPLOT
            JSR     SCOPLOT
            BRA     PADPLOT





*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
