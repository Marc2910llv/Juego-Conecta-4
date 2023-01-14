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
            CLR.W   (ISCTIMER)
            RTS
            
; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPTDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)       
.CONT
            ADDQ.W  #1,(ISCTIMER)
            CMP.W   #500,(ISCTIMER)
            BLT     .DONE
.DONE            MOVE.W  #1,(STANEXT)
            RTS
            
; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L  D0-D1/A0,-(A7)
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TXT1,A0
            MOVE.B  #8,D0
            JSR     UTLPRINT
            LEA     .TXT2,A0
            MOVE.B  #32,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0


            RTS

.TXT1       DC.B    'CONNECT-4',0
.TXT2       DC.B    'PRESS SPACE TO START',0
            DS.W    0




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
