; ==============================================================================
; TABLE MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
TABINIT
; INITIALIZE TABLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH-10,(TABWIDTH)
            MOVE.W  #SCRHEIGH-10,(TABHEIGH)
            RTS
            
; ------------------------------------------------------------------------------
TABPLOT
; PLOT THE TABLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)

            ; SET CONTOUR COLOR
            MOVE.B  #80,D0
            MOVE.L  #TABPCOL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #TABFCOL,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  #10,D1
            MOVE.W  (PIEPOSY),D2
            ADD.W   #PIERAD+10,D2
            MOVE.W  (TABWIDTH),D3
            MOVE.W  (TABHEIGH),D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
