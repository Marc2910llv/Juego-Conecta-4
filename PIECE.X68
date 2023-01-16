; ==============================================================================
; PIECE MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PIEINIT
; INITIALIZE THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVE.W  #SCRWIDTH/2-1,(PIEPOSX)
            MOVE.W  #PIERAD+10,(PIEPOSY)
            
            MOVE.W  (BOXPOSX),(PIEVELX)
            MOVE.W  #100,(PIEVELY)
            
            MOVE.W  #3,(POSX)
            MOVE.W  #-1,(POSY)
            
            CLR.B   (FALLING)
            
            RTS
            
; ------------------------------------------------------------------------------
PIEUPD
; UPDATE THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.W  D0-D3,-(A7)
            
            CMP.B   #0,(FALLING)
            BEQ     .PASS1
            MOVE.B  (SCRCYCCT),D3
            AND.B   #$F0,D3
            CMP.B   (SCRCYCCT),D3
            BNE     .DONE2
            JSR     PIEFALL
            BRA     .DONE2
            
.PASS1             
            ; UPDATE X POSITION
            MOVE.W  (PIEPOSX),D0
            
            ; CHECK LEFT ARROW KEY
            BTST.B  #0,(KBDEDGE)
            BEQ     .CHKRIGHT
            JSR     PRESSLEFT
            BRA     .DONE
            
            ;CHECK  RIGHT ARROW KEY
.CHKRIGHT   BTST.B  #2,(KBDEDGE)
            BEQ     .CHKSPACE
            JSR     PRESSRIGHT
            BRA     .DONE
            
            ; CHECK SPACE KEY
.CHKSPACE   BTST.B  #4,(KBDEDGE)
            BEQ     .DONE2
            MOVE.B  #1,(FALLING)
            JSR     PIEFALL
            BRA     .DONE2

            ; UPDATE VARIABLE
.DONE       MOVE.W  D0,(PIEPOSX) 

.DONE2      MOVEM.W  (A7)+,D0-D3             

            RTS

PRESSLEFT
            SUB.W   (PIEVELX),D0
            SUBQ.W  #1,(POSX)
            
            ; CHECK COLISIONS LEFT
            MOVE.W  (PIEVELX),D1
            SUB.W   #BOXRAD-1,D1
            CMP.W   D1,D0
            BGE     .DONELEFT
            MOVE.W  D1,D0
            CLR.W   (POSX)
.DONELEFT   RTS   

PRESSRIGHT
            ADD.W   (PIEVELX),D0
            ADDQ.W  #1,(POSX)
            
            ; CHECK COLISIONS RIGHT
            MOVE.W  #SCRWIDTH,D2
            SUB.W   D1,D2
            CMP.W   D2,D0
            BLE     .DONERIGHT
            MOVE.W  D2,D0
            MOVE.W  #6,(POSX)
.DONERIGHT  RTS            

; ------------------------------------------------------------------------------
PIEPLOT
; PLOT THE PIECE.
; INPUT    : D5.W AS COORDINATE X OF PIECE, D6.W AS COORDINATE Y OF PIECE,
;            D0.B INDICATES COLOR OF THE PIECE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D1-D4,-(A7)

            CMP.B   #1,D0
            BEQ     .COLOR1
            CMP.B   #21,D0
            BEQ     .COLORWINNER
            
            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIEPCOL2,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIEFCOL2,D1
            TRAP    #15
            
            BRA     .JUMP
            
.COLOR1            
            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIEPCOL1,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIEFCOL1,D1
            TRAP    #15
            
            BRA     .JUMP

.COLORWINNER
            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIEPCOL3,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIEFCOL3,D1
            TRAP    #15
            
            BRA     .JUMP

.JUMP            
            ; DEFINE COORDINATES
            MOVE.W  D5,D1
            SUB.W   #PIERAD,D1
            
            MOVE.W  D6,D2
            SUB.W   #PIERAD,D2
            
            MOVE.W  D5,D3
            ADD.W   #PIERAD,D3
            
            MOVE.W  D6,D4
            ADD.W   #PIERAD,D4
            
            ; DRAW PIECE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D1-D4

            RTS
            
; ------------------------------------------------------------------------------
PIEFALL
; LET A PIECE FALL IN A COLUMN
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A1,-(A7)
            
            CLR.L   D0
            LEA.L   ROW1,A1
            ADDQ.W  #1,(POSY)
            MOVE.W  (POSY),D0
            MULS.W  #7,D0
            ADD.W   D0,A1
            MOVE.W  (POSX),D0
            ADD.W   D0,A1
            
            CMP.W   #6,(POSY)
            BEQ     .END 
            
            CMP.B   #0,(A1)
            BNE     .END
            
            MOVE.W  (PIEVELY),D1
            ADD.W   D1,(PIEPOSY)
            CMP.W   #0,(POSY)
            BNE     .PASS
            ADDQ.W  #5,(PIEPOSY) 
.PASS       MOVEM.L (A7)+,D0-D1/A1

            RTS

.END        SUBQ.L  #7,A1
            SUBQ.W  #1,(POSY)
            MOVE.B  (TURN),(A1)
            JSR     CHKCOL                  ;CHECK 4 CONNECT IN COLUMNS
            JSR     CHKROW                  ;CHECK 4 CONNECT IN ROWS
            JSR     CHKDIA                  ;CHECK 4 CONNECT IN DIAGONALS
            JSR     PLAUPD
            JSR     PIEINIT
            
            MOVEM.L (A7)+,D0-D1/A1

            RTS
            
; ------------------------------------------------------------------------------
CHKCOL
; CHECK IF SOME COLUMN HAVE 4 PIECES CONNECTED
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D2/A1-A3,-(A7)
            
            LEA.L   ROW1,A1
            MOVE.L  #BOXNCOL-1,D0
.CHECK_NEXT_COL
            MOVE.L  A1,A2
            ADD.L   #1,A1
            MOVE.L  #BOXNROW-3-1,D1
            
.CHECK_POSITION_COL
            MOVE.L  A2,A3
            ADD.L   #7,A2
            
            CLR.L   D2
            MOVE.B  (A3),D2
            ADD.L   #7,A3
            ADD.B   (A3),D2
            ADD.L   #7,A3
            ADD.B   (A3),D2
            ADD.L   #7,A3
            ADD.B   (A3),D2
            
            CMP.B   #4,D2
            BEQ     .PLAYERWINS_COL
            CMP.B   #20,D2
            BEQ     .PLAYERWINS_COL
            
            DBRA    D1,.CHECK_POSITION_COL
            
            DBRA    D0,.CHECK_NEXT_COL
            
            MOVEM.L (A7)+,D0-D2/A1-A3
            
            RTS
            
.PLAYERWINS_COL
            MOVE.B  (TURN),(WINNER)  

            MOVE.L  #3,D0
.LOOP_COL
            MOVE.B  #21,(A3)
            SUB.L   #7,A3
            DBRA    D0,.LOOP_COL
                    
            MOVEM.L (A7)+,D0-D2/A1-A3
            RTS

; ------------------------------------------------------------------------------
CHKROW
; CHECK IF SOME ROW HAVE 4 PIECES CONNECTED
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D2/A1-A3,-(A7)
            
            LEA.L   ROW1,A1
            MOVE.L  #BOXNROW-1,D0
.CHECK_NEXT_ROW
            MOVE.L  A1,A2
            ADD.L   #7,A1
            MOVE.L  #BOXNCOL-3-1,D1
            
.CHECK_POSITION_ROW
            MOVE.L  A2,A3
            ADD.L   #1,A2
            
            CLR.L   D2
            MOVE.B   (A3)+,D2
            ADD.B   (A3)+,D2
            ADD.B   (A3)+,D2
            ADD.B   (A3),D2
            
            CMP.B   #4,D2
            BEQ     .PLAYERWINS_ROW
            CMP.B   #20,D2
            BEQ     .PLAYERWINS_ROW
            
            DBRA    D1,.CHECK_POSITION_ROW
            
            DBRA    D0,.CHECK_NEXT_ROW
            
            MOVEM.L (A7)+,D0-D2/A1-A3
            
            RTS

.PLAYERWINS_ROW
            MOVE.B  (TURN),(WINNER)
            
            MOVE.L  #3,D0
.LOOP_ROW
            MOVE.B  #21,(A3)
            SUB.L   #1,A3
            DBRA    D0,.LOOP_ROW
            
            MOVEM.L (A7)+,D0-D2/A1-A3
            RTS

; ------------------------------------------------------------------------------
CHKDIA
; CHECK IF SOME DIAGONAL HAVE 4 PIECES CONNECTED
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D6/A1-A3,-(A7)
            
            LEA.L   ROW1,A1
           
            MOVE.L  #8,D6
            MOVE.L  #1,D1
.LOOP_TO_OTHER_SIDE 
           
            MOVE.L  #7,D5
            MOVE.L  #1,D2
.LOOP_DIAGONALS_ROW1

            MOVE.L  A1,A2
            ;DIAGONAL OF (0,0) AND (6,0) / (1,0) AND (5,0)            
            MOVE.L  #2,D3
.LOOP1
            MOVE.L  A2,A3
            ADD.L   D6,A2
            
            JSR     CHECK_DIAGONALS
            CMP.B   #0,(WINNER)
            BNE     .FINISH_DIA
           
            DBRA    D3,.LOOP1
            
            ;DIAGONAL OF (0,1) AND (6,1) / (2,0) AND (4,0)
            MOVE.L  A1,A2
            ADD.L   D5,A2
            
            MOVE.L  #1,D3
.LOOP2
            MOVE.L  A2,A3
            ADD.L   D6,A2
            
            JSR     CHECK_DIAGONALS
            CMP.B   #0,(WINNER)
            BNE     .FINISH_DIA
           
            DBRA    D3,.LOOP2
            
            ;DIAGONAL OF (0,2) AND (6,2) / (3,0)
            MOVE.L  A1,A3
            ADD.L   D5,A3
            ADD.L   D5,A3
            
            JSR     CHECK_DIAGONALS
            CMP.B   #0,(WINNER)
            BNE     .FINISH_DIA          
            
            CMP.L   #0,D1
            BEQ     .MINUS1
            MOVE.L  #1,D5
            BRA     .PASS_DIA
.MINUS1     MOVE.L  #-1,D5
.PASS_DIA   ADD.L   D5,A1
            DBRA    D2,.LOOP_DIAGONALS_ROW1
            
            LEA     ROW1,A1
            ADDQ.L  #6,A1
            MOVE.L  #6,D6
            DBRA    D1,.LOOP_TO_OTHER_SIDE

.FINISH_DIA
            MOVEM.L (A7)+,D0-D6/A1-A3            
            RTS

CHECK_DIAGONALS
            CLR.L   D0
            MOVE.B  (A3),D0
            ADD.L   D6,A3
            ADD.B   (A3),D0
            ADD.L   D6,A3
            ADD.B   (A3),D0
            ADD.L   D6,A3
            ADD.B   (A3),D0
            
            CMP.B   #4,D0
            BEQ     .PLAYERWINS_DIA
            CMP.B   #20,D0
            BEQ     .PLAYERWINS_DIA
            
            RTS
           
.PLAYERWINS_DIA
            MOVE.B  (TURN),(WINNER)  

            MOVE.L  #3,D0
.LOOP_DIA
            MOVE.B  #21,(A3)
            SUB.L   D6,A3
            DBRA    D0,.LOOP_DIA
                   
            RTS












*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
