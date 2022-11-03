; ==============================================================================
; BALL MANAGEMENT (AGENT)
; BALPOSX (W)  (A0)
; BALPOSY (W) 2(A0)
; BALVELX (W) 4(A0)
; BALVELY (W) 6(A0)
; ==============================================================================
            
; ------------------------------------------------------------------------------
BALINIT
; INITIALIZE BALL.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)
            MOVE.W  #SCRWIDTH/2,(A0)
            MOVE.W  #SCRHEIGH/2,2(A0)
            JSR     UTLRAND
            AND.L   #$0000000C,D0
            LEA     .VELVEC,A1
            MOVE.L  (A1,D0),4(A0)
            MOVEM.L (A7)+,D0/A1
            RTS

.VELVEC     DC.W    -BALSPEED,-BALSPEED     ;0
            DC.W    -BALSPEED,BALSPEED      ;4
            DC.W    BALSPEED,-BALSPEED      ;8
            DC.W    BALSPEED,BALSPEED       ;12


            
; ------------------------------------------------------------------------------
BALUPD
; UPDATES THE BALL.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES  
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.W D0-D2,-(A7)

            ; UPDATE BALL COORDINATES
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            ADD.W   4(A0),D0
            ADD.W   6(A0),D1
            
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
.COLRGT     NEG.W   4(A0)
            MOVE.W  #SCRWIDTH-BALRAD,D0
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            BRA     .CHKVERT
            
            ; LEFT SIDE COLLISION
.COLLFT     ADDQ.W  #1,(SCOOUT)
            MOVE.B  #SNDMISS,D7
            TRAP    #SNDPLTN
            JSR     AGLKILL
            BRA     .DONE

            ; BOTTOM COLLISION
.COLBOT     NEG.W   6(A0)
            MOVE.W  #SCRHEIGH-BALRAD,D1
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            BRA     .CHKPAD
            
            ; TOP COLLISION
.COLTOP     NEG.W   6(A0)
            MOVE.W  #BALRAD,D1
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            
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
            NEG.W   4(A0)
            MOVE.W  #PADPOSX+PADWIDTH/2+BALRAD,D0
            ADDQ.W  #1,(SCOIN)
            MOVE.B  #SNDHIT,D7
            TRAP    #SNDPLTN

            ; STORE POSITION
.DONE       MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)

            MOVEM.W (A7)+,D0-D2

            RTS
            
; ------------------------------------------------------------------------------
BALPLOT
; PLOT THE BALL.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
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
            MOVE.W  (A0),D1
            SUB.W   #BALRAD,D1
            MOVE.W  2(A0),D2
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
