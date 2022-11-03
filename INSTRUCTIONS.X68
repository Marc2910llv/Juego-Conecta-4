; ==============================================================================
; INSTRUCTIONS SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
INSINIT
; INSTRUCTIONS SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (INSTIMER)
            RTS

; ------------------------------------------------------------------------------
INSUPD
; INSTRUCTIONS SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #4,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       ADDQ.W  #1,(INSTIMER)
            CMP.W   #INSMAXTM,(INSTIMER)
            BLT     .DONE
            CLR.W   (STANEXT)
.DONE       RTS

; ------------------------------------------------------------------------------
INSPLOT
; INSTRUCTIONS SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A0-A1,-(A7)
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            MOVE.B  #11,D0
            LEA     .TXTLST,A1
.LOOP       MOVE.L  (A1)+,D1
            BEQ     .DONE
            MOVE.L  D1,A0
            JSR     UTLPRINT
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
.TXT1       DC.B    'WELCOME TO THE WORLD OF MULTI-PONG 68000!',0
.TXT2       DC.B    'YOUR GOAL IN THIS GAME IS TO AVOID MISSING THE BALLS',0
.TXT3       DC.B    'TO THIS END, MOVE THE PAD USING THE KEYBOARD',0
.TXT4       DC.B    'HOW TO DO IT? YOU MAY ASK.',0
.TXT5       DC.B    'IT IS EASY: JUST USE THE UP KEY TO MOVE THE PAD...',0
.TXT6       DC.B    'UP!',0
.TXT7       DC.B    'AND USE THE DOWN KEY TO MOVE THE PAD DOWN.',0
.TXT8       DC.B    'WHAT ABOUT LEFT AND RIGHT?',0
.TXT9       DC.B    'NO. THESE ARE FORBIDDEN DIRECTIONS',0
            DS.W    0
.TXTLST     DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,.TXT6,.TXT7,.TXT8,.TXT9,0



*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
