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
            MOVEM.L D0,-(A7)

            MOVE.W  #SCRWIDTH/2,(PIEPOSX)
            MOVE.W  #PIERAD+10,(PIEPOSY)
            
            MOVE.W  (BOXPOSX),(PIEVELX)
            
            MOVEM.L (A7)+,D0
            
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
            
            ;CHECK  RIGHT ARROW KEY
.CHKRIGHT   BTST.B  #2,(KBDEDGE)
            BEQ     .CHKSPACE
            ADD.W   (PIEVELX),D0
            
            ; CHECK SPACE KEY
.CHKSPACE   BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            ; (LET THE PIECE GO DOWN)
            
            ; CHECK COLISIONS
.CONT       MOVE.W  (PIEVELX),D1
            SUB.W   #BOXRAD-5,D1
            CMP.W   D1,D0
            BGE     .CONT2
            MOVE.W  D1,D0
            BRA     .DONE
            
.CONT2      MOVE.W  #SCRWIDTH,D2
            SUB.W   D1,D2
            CMP.W   D2,D0
            BLE     .DONE
            MOVE.W  D2,D0

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









*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
