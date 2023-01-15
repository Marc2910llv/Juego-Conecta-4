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
            
            ;CLR.W   (ISCTIMER)
            MOVE.W  #$003C,(INTROX)         ;SCREEN ARRAY COLUMNS = 120
            MOVE.W  #$0013,(INTROY)         ;SCREEN ARRAY ROWS = 47
            CLR.B   (SHOWINTRO)
            
            RTS
            
; ------------------------------------------------------------------------------
ISCUPDT
; INTRO SCREEN UPDATE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L  D0-D1,-(A7)
            
            MOVE.L  #100,D1
            MOVE.L  #23,D0
            TRAP    #15
            
            CMP.B   #1,(SHOWINTRO)
            BEQ     .NOT1
            MOVE.B  #1,(SHOWINTRO)
            BRA     .DONE
.NOT1       CLR.B   (SHOWINTRO)
.DONE            
            MOVEM.L (A7)+,D0-D1
            RTS
            
; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L  D0-D4/A0-A2,-(A7)
            
            MOVE.L  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
           
            CLR.L   D1
            MOVE.W  (INTROY),D3
            
            LEA.L   .TXTLST,A2
            
            CMP.B   #1,(SHOWINTRO)
            BEQ     .SHOW
            MOVE.L  #4,D4
            BRA     .LOOP
.SHOW       MOVE.L  #5,D4
        
.LOOP       MOVE.W  (INTROX),D2
            MOVE.L  (A2)+,D0
            MOVE.L  D0,A0
            
            JSR     UTLSTRLEN
            DIVU    #2,D0
            SUB.W   D0,D2
            
            MOVE.W  D2,D1
            LSL.W   #8,D1
            ADD.B   D3,D1
            
            MOVE.L  #11,D0
            TRAP    #15
            
            MOVE.L  A0,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            ADD.W   #$0002,D3
            DBRA    D4,.LOOP
            
            MOVEM.L (A7)+,D0-D4/A0-A2

            RTS

.TXT1       DC.B    'CONNECT-4',0
            DC.B    0
.TXT2       DC.B    'TRY TO CONNECT 4 PIECES IN A LINE',0
.TXT3       DC.B    'USE LEFT AND RIGHT ARROWS TO SELECT PIECE POSITION',0
.TXT4       DC.B    'PRESS SPACE TO PLACE A PIECE',0
.TXT5       DC.B    'AFTER PLACING A PIECE THE TURN WILL SWAP',0
.TXT6       DC.B    'PRESS SPACE TO START',0
.TXTLST     DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,.TXT6,0





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
