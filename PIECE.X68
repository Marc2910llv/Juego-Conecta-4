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
            
            RTS
            
; ------------------------------------------------------------------------------
PIEUPD
; UPDATE THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.W  D0-D2,-(A7)
            
            ; UPDATE X POSITION
            MOVE.W  (PIEPOSX),D0
            
            ; CHECK LEFT ARROW KEY
            BTST.B  #0,(KBDEDGE)
            BEQ     .CHKRIGHT
            SUB.W   (PIEVELX),D0
            SUBQ.W  #1,(POSX)
            
            ;CHECK  RIGHT ARROW KEY
.CHKRIGHT   BTST.B  #2,(KBDEDGE)
            BEQ     .CHKSPACE
            ADD.W   (PIEVELX),D0
            ADDQ.W  #1,(POSX)
            
            ; CHECK SPACE KEY
.CHKSPACE   BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            JSR     PIEFALL
            JSR     CHKCOL                  ;CHECK 4 CONNECT IN COLUMNS
            JSR     CHKROW                  ;CHECK 4 CONNECT IN ROWS
            JSR     CHKDIA                  ;CHECK 4 CONNECT IN DIAGONALS
            JSR     PLAUPD
            BRA     .DONE2
            
            ; CHECK COLISIONS
.CONT       MOVE.W  (PIEVELX),D1
            SUB.W   #BOXRAD-1,D1
            CMP.W   D1,D0
            BGE     .CONT2
            MOVE.W  D1,D0
            CLR.W   (POSX)
            BRA     .DONE
            
.CONT2      MOVE.W  #SCRWIDTH,D2
            SUB.W   D1,D2
            CMP.W   D2,D0
            BLE     .DONE
            MOVE.W  D2,D0
            MOVE.W  #6,(POSX)

            ; UPDATE VARIABLE
.DONE       MOVE.W  D0,(PIEPOSX) 

            MOVEM.W  (A7)+,D0-D2             

            RTS
            
.DONE2      JSR     PIEINIT

            MOVEM.W  (A7)+,D0-D2          

            RTS
            
; ------------------------------------------------------------------------------
PIEPLOT
; PLOT THE PIECE.
; INPUT    : D5 AS COORDINATE X OF PIECE, D6 AS COORDINATE Y OF PIECE,
;            D0 INDICATES COLOR OF THE PIECE
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
            
            MOVEM.L D0-D4/A1,-(A7)
            
            MOVE.W  (PIEVELY),D3
            MOVE.W  #5,D2
            MOVE.W  #5,D1                  ;WAIT TO SEE THE PIECE FALL (MS)
            
.FALLAGAIN  LEA.L   ROW1,A1
            ADDQ.W  #1,(POSY)
            MOVE.W  (POSY),D4
            MULS.W  #7,D4
            ADD.W   D4,A1
            MOVE.W  (POSX),D4
            ADD.W   D4,A1
            CMP.B   #0,(A1)
            BNE     .OTHERPIE
            
            MOVE.W  #23,D0
            TRAP    #15
            ADD.W   D3,(PIEPOSY)
            CMP.W   #0,(POSY)
            BNE     .PASS
            ADDQ.W  #5,(PIEPOSY)
.PASS       JSR     GAMPLOT
            TRAP    #0
            DBRA    D2,.FALLAGAIN
            
.END        MOVE.B  (TURN),(A1)

            MOVEM.L (A7)+,D0-D4/A1

            RTS

.OTHERPIE   SUB.W   #7,A1
            SUBQ.W  #1,(POSY)
            BRA     .END
            
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
            
            ADD.L   #5,A1
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
