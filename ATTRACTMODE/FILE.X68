; ==============================================================================
; FILE MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
FILEINIT
; INITIALIZE FILE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D1/A1,-(A7)
            
            ; CLEAR THE STORADGE OF THE THING WE GONA READ
            LEA.L   READED,A1
            MOVE.L  #(126/2)-1,D0
.LOOP1      CLR.W   (A1)+
            DBRA    D0,.LOOP1
                 
            LEA.L   FILE,A1
            MOVE.L  #51,D0
            TRAP    #15
            
            MOVE.L  D1,(FILEID)             ; KEEP THE ID OF THE FILE
            
            MOVEM.L  (A7)+,D0-D1/A1
            RTS    

; ------------------------------------------------------------------------------
READFILE
; READ THE FILE THAT CONTAINS THE MOVES
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L  D0-D2/A1,-(A7)
            ; READ MANY BITES AS MOVES CAN BE DONE
            LEA.L   READED,A1
            MOVE.L  #53,D0
            MOVE.L  (FILEID),D1
            MOVE.L  #126,D2                 
            TRAP    #15
            
            ; CEAN WHAT WE READED (PUTS A $3 IN THE HIGH 4 BITS ON EVERY POS.)
            LEA.L   READED,A1
            SUBQ.B  #1,D2                   ;D2 = BYTES READED
.LOOP2      SUB.B   #$30,(A1)+
            DBRA    D2,.LOOP2                
            
            MOVEM.L  (A7)+,D0-D2/A1
            RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
