; ==============================================================================
; BOARD MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BOAPLOT
; PLOT A BOARD WITH INFORMATION
; INPUT    : A1 POINTER TO A NULL-TERMINATED STRING 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #00000000,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION (SCREEN ARRAY COLUMNS = 120 ROWS = 47)
            MOVE.B  #11,D0
            MOVE.W  #$0000,D1               ; UP LEFT CORNER
            TRAP    #15

            ; PRINT LINE
            CMP.B   #1,(TURN)               ; PRINTS THE TURN OF THE PLAYER
            BEQ     .PLAYER1
            MOVE.L  #2,D1
            BRA     .PASS
            
.PLAYER1    MOVE.L  #1,D1

.PASS       MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS












*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
