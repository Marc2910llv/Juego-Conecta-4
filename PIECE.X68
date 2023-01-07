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
            
            ; CHECK COLISIONS
.CONT       MOVE.W  (PIEVELX),D1
            SUB.W   #BOXRAD-1,D1
            CMP.W   D1,D0
            BGE     .CONT2
            MOVE.W  D1,D0
            MOVE.W  #0,(POSX)
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
; ------------------------------------------------------------------------------
PIEPLOT
; PLOT THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)

            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIEPCOL2,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIEFCOL2,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  (PIEPOSX),D1
            SUB.W   #PIERAD,D1
            
            MOVE.W  (PIEPOSY),D2
            SUB.W   #PIERAD,D2
            
            MOVE.W  (PIEPOSX),D3
            ADD.W   #PIERAD,D3
            
            MOVE.W  (PIEPOSY),D4
            ADD.W   #PIERAD,D4
            
            ; DRAW PIECE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

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
            MOVE.W  #50,D1
            
.FALLAGAIN  LEA.L   ROW1,A1
            ADDQ.W  #1,(POSY)
            MOVE.W  (POSY),D4
            MULS.W  #7,D4
            ADD.W   D4,A1
            MOVE.W  (POSX),D4
            ADD.W   D4,A1
            SUBQ.W  #1,(POSY)
            CMP.B   #0,(A1)
            BNE     .OTHERPIE
            
            MOVE.W  #23,D0
            TRAP    #15
            ADD.W   D3,(PIEPOSY)
            CMP.W   #-1,(POSY)
            BNE     .PASS
            ADDQ.W  #5,(PIEPOSY)
.PASS       ADDQ.W  #1,(POSY)
            JSR     GAMPLOT
            TRAP    #0
            DBRA    D2,.FALLAGAIN
            
.END        MOVE.B  #1,(A1)
            MOVEM.L (A7)+,D0-D4/A1

            RTS

.OTHERPIE   SUB.W   #7,A1
            BRA     .END










*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
