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
            JSR     PLAINIT
            RTS

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            JSR     PIEUPD

            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6,-(A7)
            
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
            
            MOVE.W  (PIEPOSX),D5
            MOVE.W  (PIEPOSY),D6
            MOVE.B  (TURN),D0
            JSR     PIEPLOT
            JSR     BOAPLOT                 
            
            MOVEM.L (A7)+,D0-D6
            
            RTS
*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
