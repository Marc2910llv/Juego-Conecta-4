; ==============================================================================
; BALL MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
BALINIT
; INITIALIZE BALL.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(BALPOSX)
            MOVE.W  #SCRHEIGH/2,(BALPOSY)
            MOVE.W  #BALSPEED,(BALVELX)
            MOVE.W  #BALSPEED,(BALVELY)
            RTS
            
; ------------------------------------------------------------------------------
BALUPD
; UPDATES THE BALL.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.W D0-D2,-(A7)

            ; UPDATE BALL COORDINATES
            MOVE.W  (BALPOSX),D0
            MOVE.W  (BALPOSY),D1
            ADD.W   (BALVELX),D0
            ADD.W   (BALVELY),D1
            
            ; CHECK HORIZONTAL COLLISIONS
            CMP.W   #SCRWIDTH-BALRAD,D0
            BGT     .COLRGT
            CMP.W   #BALRAD,D0
            BLT     .COLLFT
            
            ; CHECK VERTICAL COLLISIONS
.CHKVERT    CMP.W   #SCRHEIGH-BALRAD,D1
            BGT     .COLBOT
            CMP.W   #BALRAD,D1
            BLT     .COLTOP
            BRA     .CHKPAD
            
            ; RIGHT SIDE COLLISION
.COLRGT     NEG.W   (BALVELX)
            MOVE.W  #SCRWIDTH-BALRAD,D0
            BRA     .CHKVERT
            
            ; LEFT SIDE COLLISION
.COLLFT     ADDQ.W  #1,(SCOOUT)
            MOVE.W  #SCRWIDTH/2,D0
            MOVE.W  #SCRHEIGH/2,D1
            BRA     .DONE

            ; BOTTOM COLLISION
.COLBOT     NEG.W   (BALVELY)
            MOVE.W  #SCRHEIGH-BALRAD,D1
            BRA     .CHKPAD
            
            ; TOP COLLISION
.COLTOP     NEG.W   (BALVELY)
            MOVE.W  #BALRAD,D1
            
            ; CHECK PAD COLLISIONS
.CHKPAD     MOVE.W  #PADPOSX,D2
            SUB.W   D0,D2
            BPL     .ISPOS
            NEG.W   D2
.ISPOS      CMP.W   #PADWIDTH/2+BALRAD,D2
            BGT     .DONE
            MOVE.W  (PADPOSY),D2
            SUB.W   D1,D2
            BPL     .ISPOS2
            NEG.W   D2
.ISPOS2     CMP.W   #PADHEIGH/2+BALRAD,D2
            BGT     .DONE
            
            ; PAD COLLISION
            NEG.W   (BALVELX)
            MOVE.W  #PADPOSX+PADWIDTH/2+BALRAD,D0
            ADDQ.W  #1,(SCOIN)

            ; STORE POSITION
.DONE       MOVE.W  D0,(BALPOSX)
            MOVE.W  D1,(BALPOSY)

            MOVEM.W (A7)+,D0-D2

            RTS
            
; ------------------------------------------------------------------------------
BALPLOT
; PLOT THE BALL.
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
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
