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
            
            MOVE.W  #BOXRAD*2+41,(BOXPOSX)
            MOVE.W  #BOXRAD*2+10,(BOXPOSY)
            
            RTS
            
; ------------------------------------------------------------------------------
BOXPLOT
; PLOT THE BOX.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A1,-(A7)

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
            MOVE.W  (BOXCOL),D2
            MULS.W  D2,D1
            SUB.W   #BOXRAD*2,D1
            
            MOVE.W  (BOXPOSY),D2
            MOVE.W  (BOXROW),D3
            MULS.W  D3,D2
            ADD.W   #PIERAD*2+20,D2
            SUB.W   #BOXRAD*2-5,D2
            
            MOVE.W  D1,D3
            ADD.W   #BOXRAD*2,D3
            
            MOVE.W  D2,D4
            ADD.W   #BOXRAD*2,D4
            
            ; DRAW CIRCLE
            MOVE.B  #88,D0
            TRAP    #15
            
            ; CHECK IF THERE IS A PIECE INSIDE
            LEA     ROW1,A1
            MOVE.W  (BOXCOL),D3
            MOVE.W  (BOXROW),D4
            SUBQ.W  #1,D3
            SUBQ.W  #1,D4
            ADD.W   D3,A1   
            MULS.W  #7,D4
            ADD.W   D4,A1 
            CMP.B   #0,(A1)
            BEQ     .EMPTY
            
            ; PLOT THE PIECE WITH THE RIGHT COLOR
            MOVE.W  D1,D5
            ADD.W   #BOXRAD,D5
            MOVE.W  D2,D6
            ADD.W   #BOXRAD,D6
            MOVE.B  (A1),D0
            JSR     PIEPLOT
            
.EMPTY      MOVEM.L (A7)+,D0-D6/A1

            RTS











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
