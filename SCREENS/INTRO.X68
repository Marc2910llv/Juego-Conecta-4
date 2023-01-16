; ---------------------------------------------------------------------
; INTRO SCREEN
; ---------------------------------------------------------------------

; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INIT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            CLR.W   (TIMER)
            RTS
            
; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #1,(STANEXT)

.CONT       MOVE.B  #SNDMUSIC,D7
            TRAP    #SNDPLTN
            ADDQ.W  #1,(TIMER)
            CMP.W   #600,(TIMER)
            BLT     .DONE
            MOVE.W  #3,(STANEXT)
.DONE       
            RTS
            
; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A0-A1,-(A7)
            
            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #00000000,D1
            TRAP    #15
            
            MOVE.B  #11,D0
            
            LEA     .TXT1,A0
            JSR     UTLPRINT
            
            ADDQ.B  #4,D0
            LEA     .TXTLST,A1
.LOOP       MOVE.L  (A1)+,D1
            BEQ     .DONE1
            MOVE.L  D1,A0
            JSR     UTLPRINT
            BRA    .LOOP
.DONE1            
            BTST.B   #4,(SCRCYCCT)
            BEQ     .DONE2
            
            LEA     .TXT7,A0
            ADD.B   #6,D0
            JSR     UTLPRINT
            
.DONE2      MOVEM.L (A7)+,D0-D1/A0-A1
            
            RTS

.TXT1       DC.B    'CONNECT-4',0
.TXT2       DC.B    'TRY TO CONNECT 4 PIECES IN A LINE',0
.TXT3       DC.B    'USE LEFT AND RIGHT ARROWS TO SELECT PIECE POSITION',0
.TXT4       DC.B    'PRESS SPACE TO PLACE A PIECE',0
.TXT5       DC.B    'AFTER PLACING A PIECE THE TURN WILL SWAP',0
.TXT6       DC.B    'PLAYER 1 HAS RED PIECES AND PLAYER 2 HAS YELLOW PIECES',0
.TXT7       DC.B    'PRESS SPACE TO START',0
            DS.W    0
.TXTLST     DC.L    .TXT2,.TXT3,.TXT4,.TXT5,.TXT6,0














*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
