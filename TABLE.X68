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

            ;INITIALICE ROWS VALUES
            MOVE.W  #6*7-1,D0
            LEA.L   ROW1,A1
.LOOP       
            MOVE.B  #0,(A1)
            ADDA.L  #2,A0
            DBRA    D0,.LOOP

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
            MOVE.W  #5,D1
            MOVE.W  #PIERAD*2+20,D2
            MOVE.W  #SCRWIDTH-5,D3
            MOVE.W  #SCRHEIGH-5,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS














*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
