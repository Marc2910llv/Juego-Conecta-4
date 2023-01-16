; ==============================================================================
; SYSTEM
; ==============================================================================
            
; ------------------------------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVE.L  #SCRPLOT,($80+SCRUPTN*4)
            MOVE.L  #KBDUPD,($80+KBDUPTN*4)
            MOVE.L  #SNDPLAY,($80+SNDPLTN*4)
            MOVE.L  #SCRTIM,($60+SCRINTN*4)
            
            JSR     SCRINIT
            JSR     KBDINIT
            JSR     SNDINIT
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)
            RTE
   
; ------------------------------------------------------------------------------
SNDINIT
; SOUND SYSTEM INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A0-A1,-(A7)            
            CLR.B   D1
            LEA     .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1      
            RTS
.SNDMOVE    DC.B    'SND/MOVEPIECE.wav',0
.SNDFALL    DC.B    'SND/PIECEFALL.wav',0
.SNDWIN     DC.B    'SND/WIN.wav',0
.SNDMUSIC   DC.B    'SND/MUSIC.wav',0
            DS.W    0
.SNDLIST    DC.L    .SNDMOVE,.SNDFALL,.SNDWIN,.SNDMUSIC,0
            
; ------------------------------------------------------------------------------
SNDPLAY
; PLAY SOUND
; INPUT    : D7 SOUND ID
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1,-(A7)             
            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP    #15
            MOVEM.L (A7)+,D0-D1
            RTE
         
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN,
; ENABLE DOBLE BUFFER, ENABLE TIMED INTERRUPT.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D3,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER
            MOVE.B #92,D0
            MOVE.B #17,D1
            TRAP #15
            
            ; ENABLE TIMED INTERRUPT
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$80|SCRINTN,D2
            MOVE.L  #1000/SCRFPS,D3
            TRAP    #15
            
            ; CLEAR INTERRUPT COUNTER
            CLR.W   (SCRINTCT)
            
            MOVEM.L (A7)+,D0-D3
            
            RTS
            
; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.W D0-D1,-(A7)

            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            
            RTE 

; ------------------------------------------------------------------------------
SCRTIM
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)
            RTE
            
; ------------------------------------------------------------------------------
KBDINIT
; INIT KEYBOOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            CLR.B   (KBDVAL)
            CLR.B   (KBDEDGE)
            RTS
            
; ------------------------------------------------------------------------------
KBDUPD
; UPDATE KEYBOARD INFO.  
; 7 -> PAUSE
; 6 -> FIRE 3
; 5 -> FIRE 2
; 4 -> FIRE 1
; 3 -> DOWN
; 2 -> RIGHT
; 1 -> UP
; 0 -> LEFT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D3,-(A7)

            ; READ FIRST PART
            MOVE.B  #19,D0
            MOVE.L  #KBDPAUSE<<24|KBDFIRE3<<16|KBDFIRE2<<8|KBDFIRE1,D1
            TRAP    #15
            
            ; CONVERT TO DESIRED FORMAT
            JSR     .PACK

            ; READ SECOND PART
            MOVE.L  #KBDDOWN<<24|KBDRIGHT<<16|KBDUP<<8|KBDLEFT,D1
            TRAP    #15

            ; CONVERT TO DESIRED FORMAT
            JSR     .PACK
            
            ; COMPUTE KBDEDGE
            MOVE.B  (KBDVAL),D0
            NOT.B   D0
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            
            ; STORE KBDVAL
            MOVE.B  D2,(KBDVAL)
            
            MOVEM.L (A7)+,D0-D3

            RTE
            
.PACK       MOVE.W  #3,D3
.LOOP       LSL.L   #8,D1
            ROXL.B  #1,D2
            DBRA.W  D3,.LOOP
            RTS

            
            





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
