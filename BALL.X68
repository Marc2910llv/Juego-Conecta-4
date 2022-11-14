; ==============================================================================
; BOX MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BOXINIT
; INITIALIZE BOX.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #PIERAD+10,BOXRAD
            RTS
            
; ------------------------------------------------------------------------------
BOXUPD
; UPDATES THE BOX.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS
            
; ------------------------------------------------------------------------------
BOXPLOT
; PLOT THE BOX.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)

            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #BALPCOL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #BALFCOL,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  (BALPOSX),D1
            SUB.W   #BALRAD,D1
            MOVE.W  (BALPOSY),D2
            SUB.W   #BALRAD,D2
            MOVE.W  D1,D3
            ADD.W   #2*BALRAD,D3
            MOVE.W  D2,D4
            ADD.W   #2*BALRAD,D4
            
            ; DRAW CIRCLE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
