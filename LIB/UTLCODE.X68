; =============================================================================
; UTILITY CODE
; =============================================================================

; -----------------------------------------------------------------------------
UTLINIT
; INITIALIZES UTILITY CODE
*; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            MOVE.B  #8,D0
            TRAP    #15
            MOVE.B  D1,(UTLRNDIX)
            MOVEM.L (A7)+,D0-D1
            RTS
; -----------------------------------------------------------------------------
UTLPRINT
; PRINT SCREEN CENTERED TEXT
; INPUT    : A0 POINTER TO ZERO-TERMINATED STRING
;            D0.B SCREEN ROW TO PRINT TEXT
; OUTPUT   : D0.B NEXT ROW
; MODIFIES : NONE (ASIDE OF OUTPUT)
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A1,-(A7)
            
            CLR.B   D1
            MOVE.L  A0,A1
.LOOP1      TST.B   (A0)+
            BEQ     .ENDLOOP1
            ADDQ.B  #1,D1
            BRA     .LOOP1
            
.ENDLOOP1   LSR.B   #1,D1
            SUB.B   #(SCRWIDTH/UTLCHRWD)/2,D1
            NEG.B   D1
            ASL.W   #8,D1
            OR.W    D0,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A0-A1
            ADDQ.B  #1,D0
            RTS

; -----------------------------------------------------------------------------
UTLSTRLEN
; GET THE LENGTH OF A STRING
; INPUT    : A0 POINTER TO ZERO-TERMINATED STRING
; OUTPUT   : D0.B STRING LEN
; MODIFIES : NONE (ASIDE OF OUTPUT)
; -----------------------------------------------------------------------------

            MOVEM.L A0,-(A7)
            
            CLR.L   D0
.LOOP       TST.B   (A0)+
            BEQ     .ENDLOOP
            ADDQ.B  #1,D0
            BRA     .LOOP
.ENDLOOP            
            MOVEM.L (A7)+,A0
            RTS










*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
