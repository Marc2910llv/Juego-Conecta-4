; ---------------------------------------------------------------------
; END GAME SCREEN
; ---------------------------------------------------------------------

; ------------------------------------------------------------------------------
ENDINIT
; INTRO SCREEN INIT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            CLR.W   (TIMER)                 ; RESET TIMER
            ; PUT THE PIECE OF THE WINNER IN THE MIDDLE OF THE SCREEN
            MOVE.W  #SCRWIDTH/2,(PIEPOSX)
            MOVE.W  #SCRHEIGH/2,(PIEPOSY)
            
            RTS
            
; ------------------------------------------------------------------------------
ENDUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            ; JUMP TO THE INTRO IF WE PRESS FIRE1
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #0,(STANEXT)
            BRA     .DONE
            
            ; STAY IN THIS STATE FOR 10 SECONDS, THEN GO TO INTRO
.CONT       MOVE.B  #SNDMUSIC,D7
            TRAP    #SNDPLTN
            ADDQ.W  #1,(TIMER)
            CMP.W   #SCRFPS*10,(TIMER)
            BLT     .DONE
            MOVE.W  #0,(STANEXT)
.DONE     
            RTS
            
; ------------------------------------------------------------------------------
ENDPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D6/A0,-(A7)
            
            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #00000000,D1
            TRAP    #15
            
            MOVE.B  #15,D0
            
            CMP.B   #5,(WINNER)
            BEQ     .PLAYER2_WIN
            LEA     .TXT1,A0
            BRA     .DONE
.PLAYER2_WIN            
            LEA     .TXT2,A0
            
.DONE       JSR     UTLPRINT
            
            CLR.L   D5
            CLR.L   D6
            MOVE.W  (PIEPOSX),D5
            MOVE.W  (PIEPOSY),D6
            MOVE.B  (WINNER),D0
            JSR     PIEPLOT
            
            MOVEM.L (A7)+,D0-D6/A0
            
            RTS

.TXT1       DC.B    '¡¡¡¡¡ PLAYER 1 WINS !!!!!',0
.TXT2       DC.B    '¡¡¡¡¡ PLAYER 2 WINS !!!!!',0
            DS.W    0







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
