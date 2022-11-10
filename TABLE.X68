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
            MOVE.W  #SCRWIDTH/2,(TABPOSX)
            MOVE.W  #SCRHEIGH/2,(TABPOSY)
            MOVE.W  #SCRWIDTH-25,(TABWIDTH)
            MOVE.W  #SCRHEIGH-25,(TABHEIGH)
            RTS
            
; ------------------------------------------------------------------------------
TABUPD
; UPDATES THE TABLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
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
            MOVE.W  #25,D1
            MOVE.W  #50,D2
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
