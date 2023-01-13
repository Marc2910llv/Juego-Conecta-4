; ==============================================================================
; PLAYERS MANAGEMENT
; ==============================================================================
           
; ------------------------------------------------------------------------------
PLAINIT
; INITIALIZE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVE.B  #1,(TURN)               ; STARTS THE PLAYER 1
            CLR.B   (WINNER)
            
            RTS
            
; ------------------------------------------------------------------------------
PLAUPD
; UPDATES THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            CMP.B   #1,(TURN)               
            BEQ     .PLAYER2                ; SWAPS TURN
            MOVE.B  #1,(TURN)               ; PLAYER 1 TURN   
            
            RTS
            
.PLAYER2    MOVE.B  #5,(TURN)               ; PLAYER 2 TURN
            
            RTS
            






*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
