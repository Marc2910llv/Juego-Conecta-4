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
            MOVE.W  #10,D1
            ADD.W   #BOXRAD,D1
            ADDQ.W  #5,D1
            MOVE.W  D1,(BOXPOSX)
            MOVE.W  (PIEPOSY),D2
            ADD.W   #PIERAD+10,D2
            ADD.W   #BOXRAD,D2
            MOVE.W  D2,(BOXPOSY)
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
            MOVE.W  (BOXPOSX),D1
            SUB.W   #BOXRAD,D1
            MOVE.W  (BOXPOSY),D2
            SUB.W   #BOXRAD,D2
            MOVE.W  D1,D3
            ADD.W   #2*BOXRAD,D3
            MOVE.W  D2,D4
            ADD.W   #2*BOXRAD,D4
            
            ; DRAW CIRCLE
            MOVE.B  #88,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS



*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
