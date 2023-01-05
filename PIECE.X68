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

            MOVE.W  (BOXRAD),D0
            SUB.W   #10,D0
            MOVE.W  D0,(PIERAD)
            MOVE.W  #SCRWIDTH/2,(PIEPOSX)
            MOVE.W  (PIERAD),D0
            ADD.W   #10,D0
            MOVE.W  D0,(PIEPOSY)
            
            MOVEM.L (A7)+,D0
            
            RTS
            
; ------------------------------------------------------------------------------
PIEUPD
; UPDATE THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS
; ------------------------------------------------------------------------------
PIEPLOT
; PLOT THE PIECE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)

            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIEPCOL2,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIEFCOL2,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  (PIERAD),D5
            MOVE.W  (PIEPOSX),D1
            SUB.W   D5,D1
            MOVE.W  (PIEPOSY),D2
            SUB.W   D5,D2
            ADD.W   D5,D5
            MOVE.W  D1,D3
            ADD.W   D5,D3
            MOVE.W  D2,D4
            ADD.W   D5,D4
            
            ; DRAW PIECE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D5

            RTS







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
