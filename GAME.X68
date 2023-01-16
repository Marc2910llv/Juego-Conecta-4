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
            CLR.W   (TIMER)                 ; RESET TIMER
            RTS

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            ; IF THERE IS NO WINNER DON'T CHANGE THE STATE            
            CMP.B   #0,(WINNER)
            BEQ     .CONTINUE
            
            ; CHANGE STATE WITH FIRE1 OR IN 3 SECONDS
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)
            BRA     .DONE
.CONT       ADDQ.W  #1,(TIMER)
            CMP.W   #SCRFPS*3,(TIMER)
            BLT     .DONE
            MOVE.W  #2,(STANEXT)                      
.CONTINUE   JSR     PIEUPD
.DONE
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A1,-(A7)
            
            ; PLOT TABLE
            JSR     TABPLOT
            
            ; PLOT EVERY BOX OF THE TABLE, REPRESENTS POSITIONS OF THE MATRIX
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
            
            ; PRINT THE PIECE IN HIS RIGHT POSITION AND THE BOARD INFORMATION
            MOVE.W  (PIEPOSX),D5
            MOVE.W  (PIEPOSY),D6
            MOVE.B  (TURN),D0
            JSR     PIEPLOT
            LEA     .TXT,A1
            JSR     BOAPLOT                 
            
            MOVEM.L (A7)+,D0-D6/A1
            
            RTS

.TXT        DC.B    'PLAYER TURN: ',0            
            DS.W    0






*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
