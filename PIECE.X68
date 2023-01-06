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
            
            ; UPDATE X POSITION
            MOVE.W  (PIEPOSX),D0
            BTST.B  #0,(KBDEDGE)
            BEQ     .CHKRIGHT
            MOVE.W  (PIERAD),D5
            MOVE.W  (PIEPOSX),D1
            ADD.W   #(SCRWIDTH/7),D1
            ADD.W   #28,D1
            SUB.W   D5,D1
.CHKRIGHT               

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
