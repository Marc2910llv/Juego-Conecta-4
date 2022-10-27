; ==============================================================================
; SCOREBOARD MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (SCOIN)
            CLR.W   (SCOOUT)
            RTS
            
; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (SCOIN),D1
            MOVE.B  #17,D0
            TRAP    #15

            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15

            ; PRINT SECOND LINE
            LEA     .TXT2,A1
            CLR.L   D1
            MOVE.W  (SCOOUT),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
.TXT1       DC.B    'CAPTURED :',0
.TXT2       DC.B    'MISSED   :',0


*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
