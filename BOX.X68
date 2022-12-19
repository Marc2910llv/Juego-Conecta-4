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
            MOVEM.L D0-D1,-(A7)
            
            MOVE.W  #(SCRHEIGH/14)-5,(BOXRAD)
            
            MOVEM.L (A7)+,D0-D1
            
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
            MOVE.L  #BOXPCOL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #BOXFCOL,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  #15,D1
            MOVE.W  (PIEPOSY),D2
            ADD.W   (PIERAD),D2
            ADD.W   D1,D2
            MOVE.W  (BOXRAD),D3
            ADD.W   D3,D3
            ADD.W   D1,D3
            MOVE.W  (BOXRAD),D4
            ADD.W   D4,D4
            ADD.W   D2,D4
            
            ; DRAW CIRCLE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
