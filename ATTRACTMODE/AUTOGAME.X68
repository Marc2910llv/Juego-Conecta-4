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
            CLR.B   (INDEXREAD)
            RTS

; ------------------------------------------------------------------------------
AUTOUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
                    
            MOVEM.L  D0-D3/A1,-(A7)
            
            CLR.L   D0
            CLR.L   D3
    
            BTST.B  #4,(KBDEDGE)
            BEQ     .PASS
            MOVE.W  #0,(STANEXT)
            BRA     .DONE
.PASS
            CMP.B   #0,(WINNER)
            BEQ     .CONTINUE
            ADDQ.W  #1,(TIMER)
            CMP.W   #180,(TIMER)
            BLT     .DONE
            MOVE.W  #0,(STANEXT)                      
.CONTINUE   
            MOVE.B  (SCRCYCCT),D3
            AND.B   #$F0,D3
            CMP.B   (SCRCYCCT),D3
            BNE     .DONE
            CMP.B   #0,(FALLING)
            BEQ     .PASS1
            JSR     PIEFALL
            BRA     .DONE
.PASS1            
            CMP.B   #125,(INDEXREAD)
            BLS     .PASS2
            MOVE.W  #0,(STANEXT)
            BRA     .DONE
.PASS2      
            MOVE.W  (PIEPOSX),D0      
            LEA     READED,A1
            MOVE.B  (INDEXREAD),D3
            ADD.L   D3,A1
            ; 2 EQUALS PRESS LEFT ARROW
            CMP.B   #2,(A1)
            BEQ     .AUTOLEFT
            ; 3 EQUALS PRESS RIGHT ARROW
            CMP.B   #3,(A1)
            BEQ     .AUTORIGHT
            ; 1 EQUALS PRESS FIRE 1
            MOVE.B  #1,(FALLING)
            JSR     PIEFALL
            BRA     .JUMP            
.AUTOLEFT   JSR     PRESSLEFT
            BRA     .JUMP
.AUTORIGHT  JSR     PRESSRIGHT
            
.JUMP       MOVE.W  D0,(PIEPOSX)
            ADDQ.B  #1,(INDEXREAD)
            
.DONE       MOVEM.L  (A7)+,D0-D3/A1
            RTS

; ------------------------------------------------------------------------------
AUTOPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A1,-(A7)
            
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
            LEA     .TXT,A1
            JSR     BOAPLOT                 
            
            MOVEM.L (A7)+,D0-D6/A1
            
            RTS

.TXT        DC.B    'AUTOMATIC GAME /// PLAYER TURN: ',0            
            DS.W    0


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
