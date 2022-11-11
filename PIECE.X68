; ==============================================================================
; PIECE MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PIEINIT
; INITIALIZE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(PIEPOSX)
            MOVE.W  #15,(PIEPOSY)
            RTS
            
; ------------------------------------------------------------------------------
PIEUPD

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
            MOVE.W  D1,D3
            ADD.W   #2*PIERAD,D3
            MOVE.W  D2,D4
            ADD.W   #2*PIERAD,D4
            
            ; DRAW PIECE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS


*~Font name~Fixedsys~
*~Font size~13~
*~Tab type~0~
*~Tab size~4~
