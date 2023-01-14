; ---------------------------------------------------------------------
; INSTRUCTIONS SCREEN
; ---------------------------------------------------------------------

; ------------------------------------------------------------------------------
INSINIT
; INSTRUCTIONS SCREEN INIT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            RTS
            
; ------------------------------------------------------------------------------
INSUPD
; INTRO SCREEN UPTDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            RTS
            
; ------------------------------------------------------------------------------
INSPLOT
; INSTRUCTIONS SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L  D0-D1/A0-A1,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.B  #8,D0
            LEA     .TXTLST,A1
.LOOP       MOVE.L  (A1)+,D1
            BEQ     .DONE
            MOVE.L  D1,A0
            JSR     UTLPRINT
            BRA     .LOOP
            
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1


            RTS

.TXT1       DC.B    'TRY TO CONNECT 4 PIECES IN A LINE',0
.TXT2       DC.B    'USE LEFT AND RIGHT ARROWS TO SELECT PIECE POSITION',0
.TXT3       DC.B    'PRESS SPACE TO PLACE A PIECE',0
.TXT4       DC.B    'AFTER PLACING A PIECE THE TURN WILL SWAP',0
            DS.W    0
.TXTLST     DC.L    .TXT1,.TXT2,.TXT3,.TXT4,0

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
