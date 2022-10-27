; ==============================================================================
; PADDLE MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PADINIT
; INITIALIZE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRHEIGH/2,(PADPOSY)
            RTS
            
; ------------------------------------------------------------------------------
PADUPD
; UPDATES THE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVE.W  D0,-(A7)
            
            ; UPDATE COORDINATE
            MOVE.W  (PADPOSY),D0
            BTST.B  #1,(KBDVAL)
            BEQ     .CHKDWN
            SUB.W   #PADSPEED,D0
.CHKDWN     BTST.B  #3,(KBDVAL)
            BEQ     .CONT
            ADD.W   #PADSPEED,D0
            
            ; CHECK COLLISIONS
.CONT       CMP.W   #PADHEIGH/2,D0
            BGE     .CONT2
            MOVE.W  #PADHEIGH/2,D0
            BRA     .DONE
.CONT2      CMP.W   #SCRHEIGH-PADHEIGH/2,D0
            BLE     .DONE
            MOVE.W  #SCRHEIGH-PADHEIGH/2,D0

            ; UPDATE VARIABLE
.DONE       MOVE.W  D0,(PADPOSY)

            MOVE.W  (A7)+,D0

            RTS
            
; ------------------------------------------------------------------------------
PADPLOT
; PLOT THE PADDLE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)

            ; SET CONTOUR COLOR
            MOVE.B  #80,D0
            MOVE.L  #PADPCOL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PADFCOL,D1
            TRAP    #15
            
            ; DEFINE COORDINATES
            MOVE.W  #PADPOSX-PADWIDTH/2,D1
            MOVE.W  #PADPOSX+PADWIDTH/2,D3
            MOVE.W  (PADPOSY),D2
            SUB.W   #PADHEIGH/2,D2
            MOVE.W  D2,D4
            ADD.W   #PADHEIGH,D4
            
            ; DRAW RECTANGLE
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4

            RTS


*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
