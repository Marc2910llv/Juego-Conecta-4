; ==============================================================================
; AUTOMATIC GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
AUTOINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     TABINIT
            JSR     BOXINIT
            JSR     PIEINIT
            JSR     PLAINIT
            JSR     FILEINIT
            JSR     READFILE
            RTS

; ------------------------------------------------------------------------------
AUTOUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
                                    
            BTST.B  #4,(KBDEDGE)
            BEQ     .PASS
            MOVE.W  #0,(STANEXT)
            BRA     .DONE
.PASS
            CMP.B   #0,(WINNER)
            BEQ     .CONTINUE
            ADDQ.W  #1,(TIMER)
            CMP.W   #120,(TIMER)
            BLT     .DONE
            MOVE.W  #0,(STANEXT)                      
.CONTINUE   JSR     PIEUPD
.DONE
            RTS

; ------------------------------------------------------------------------------
AUTOPLOT
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
