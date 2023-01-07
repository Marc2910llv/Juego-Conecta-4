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
            JSR     BOXINIT
            JSR     PIEINIT
            RTS

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
;            MOVEM.L D0/A1-A3,-(A7)
;            MOVE.B  (SCRCYCCT),D0
;            AND.B   #%00011111,D0
;            BNE     .GOUPD
;            LEA     BALINIT,A1
;            LEA     BALUPD,A2
;            LEA     BALPLOT,A3
;            MOVE.W  #1,D0
;            JSR     AGLADD
;.GOUPD      JSR     AGLUPD
;            JSR     PADUPD        
;            MOVEM.L (A7)+,D0/A1-A3

            JSR     PIEUPD

            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            ;JSR     AGLPLOT
            JSR     TABPLOT
            
            MOVE.W  #BOXNCOL-1,D0
.PLOT_NEXT_COL
            MOVE.W  #BOXNCOL,D2
            SUB.W   D0,D2
            MOVE.W  D2,(BOXCOL)
            
            MOVE.W  #BOXNROW-1,D1
.PLOT_NEXT_ROW
            MOVE.W  #BOXNROW,D2
            SUB.W   D1,D2
            MOVE.W  D2,(BOXROW)
            
            JSR     BOXPLOT
            
            DBRA    D1,.PLOT_NEXT_ROW
            DBRA    D0,.PLOT_NEXT_COL
            
            JSR     PIEPLOT
            
            MOVEM.L (A7)+,D0-D2
            
            RTS
; ------------------------------------------------------------------------------
PLACEPIE
; PLACES A PIECE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)
            
            MOVE.L  #(COLU1),D1
            LSL.L   #1,D1
            ROXL.B  #1,D2
            CMP.L   #7,D2
            BEQ     .MAXPIE                 ; ja no se poden colocar mes peces
            ;OR.L #(PIEVAL1)<<D2,(COLU1)
            
            MOVEM.L (A7)+,D0-D3
            
            RTS
.MAXPIE     ;SUBRUTINA RENOU ERROR
            RTS



















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
