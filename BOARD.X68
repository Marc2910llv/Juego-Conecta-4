; ==============================================================================
; BOARD MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BOAPLOT
; PLOT THE BOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #BOAFCOL,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION (SCREEN ARRAY COLUMNS = 120 ROWS = 47)
            MOVE.B  #11,D0
            MOVE.W  #$0000,D1
            TRAP    #15
            
            CMP.B   #0,(WINNER)
            BNE     .WINNER_LINE

            ; PRINT LINE
            LEA.L   .TXT1,A1
            CLR.L   D1
            CMP.B   #1,(TURN)
            BEQ     .PLAYER1
            MOVE.L  #2,D1
            MOVE.B  #17,D0
            TRAP    #15
            BRA     .PASS
            
.PLAYER1            
            MOVE.L  #1,D1
            MOVE.B  #17,D0
            TRAP    #15            
            BRA     .PASS
            
.WINNER_LINE
            ; PRINT LINE
            LEA.L   .TXT2,A1
            CLR.L   D1
            CMP.B   #1,(WINNER)
            BEQ     .PLAYER1_WIN
            MOVE.L  #2,D1
            MOVE.B  #17,D0
            TRAP    #15
            BRA     .PASS
            
.PLAYER1_WIN
            MOVE.L  #1,D1
            MOVE.B  #17,D0
            TRAP    #15

.PASS      
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
            
.TXT1       DC.B    'PLAYER TURN: ',0
            DC.B    0            
.TXT2       DC.B    'WINS PLAYER ',0







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
