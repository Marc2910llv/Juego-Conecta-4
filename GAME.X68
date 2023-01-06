; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     TABINIT
            JSR     BOXINIT
            JSR     PIEINIT
            JSR     COLUINIT
            RTS

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
;            MOVEM.L D0/A1-A3,-(A7)
;            MOVE.B  (SCRCYCCT),D0
;            AND.B   #%00011111,D0
;            BNE     .GOUPD
;            LEA     BALINIT,A1
;            LEA     BALUPD,A2
;            LEA     BALPLOT,A3
;            MOVE.W  #1,D0
;            JSR     AGLADD
;.GOUPD      JSR     AGLUPD
;            JSR     PADUPD        
;            MOVEM.L (A7)+,D0/A1-A3
             RTS

;-------------------------------------------------------------------------------             
COLUINIT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)
            ;BUCLE PER INICIAR A 0 COLUVAL
            MOVEQ.L #0,A0
            MOVEQ.L #6,D1
            
            
COLU:
            CLR.B   COLUVAL(A0)
            ADDQ.W  #1,A1            
            DBRA    D1,CHECK2
            
            MOVEM.L (A7)+,D0-D3
            
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            ;JSR     AGLPLOT
            JSR     TABPLOT
            
            MOVE.W  #BOXNCOL-1,D0
.PLOT_NEXT_COL
            MOVE.W  #BOXNCOL,D2
            SUB.W   D0,D2
            MOVE.W  D2,(BOXCOL)
            
            MOVE.W  #BOXNROW-1,D1
.PLOT_NEXT_ROW
            MOVE.W  #BOXNROW,D2
            SUB.W   D1,D2
            MOVE.W  D2,(BOXROW)
            
            JSR     BOXPLOT
            
            DBRA    D1,.PLOT_NEXT_ROW
            DBRA    D0,.PLOT_NEXT_COL
            
            JSR     PIEPLOT
            
            MOVEM.L (A7)+,D0-D2
            
            RTS
; ------------------------------------------------------------------------------
PLACEPIE
; PLACES A PIECE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)
            ;SI ON SE VOL COLOCAR SA FITXA ESTA PLE:
            MOVE.B  (POSX),A0
            SUB.B   #1,A0
            CMP.B   #6,COLVAL(A0)
            ;SALT A ERROR
            BEQ     .MAXERR    
            
<<<<<<< HEAD
            ;FORMULA PER FICAR SA FITXA ON TOCA, ES UNA FUMADA SI VOLS T'HO EXPLIC AMB UN DIBUIXET O ALGO xd
            MOVE    (POSX),A0
            SUBQ.W  #1,A0
            MOVE.W  COLUVAL(A0),D0
            MOVE.W  #5,A1
            SUB.W   D0,A1
            MULS.W  #7,A1
            ADDQ.W  #1,A1
            ADDQ.W  (POSX),A1
            ;PER ARA FIC 'A' PERO S'HA DE IMPLEMENTAR ES TEMA DE QUE SE VAIG CAMBIANT AMB B SEGONS ES TORN
            MOVE.B  #$A,ROW1(A1)
=======
            MOVE.L  #(COLU1),D1
            LSL.L   #1,D1
            ROXL.B  #1,D2
            CMP.L   #7,D2
            BEQ     .MAXPIE                 ; ja no se poden colocar mes peces
            ;OR.L #(PIEVAL1)<<D2,(COLU1)
>>>>>>> 503e21dfa9b7b37e9c064c8041e36b9a99ccc48a
            
            ;SUBRUTINA PER FER SES COMPROBACIONS
            JSR     CHECKTAB
                        
            MOVEM.L (A7)+,D0-D3
            
            RTS
.MAXERR
            ;SUBRUTINA ERROR
            
            RTS

; ------------------------------------------------------------------------------
CHECKTAB
; CHECKS A POSSIBLE WINNER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)
            ;OBTENCIO DE QUINA FILA ES
            MOVE    (POSX),A0
            SUBQ.W  #1,A0
            MOVE.W  COLUVAL(A0),D0
            MOVE.W  #5,A1
            SUB.W   D0,A1
            MULS.W  #7,A1
            
            MOVE    #3,D1
            
CHECK1:
            MOVE    #3,D2
CHECK2:
            ADD.B   ROW1(A1),D3
            ADDQ.W  #1,A1            
            ;FALTA FER ES CMP AMB D3 I ES NUMERO DE TORN CORRESPONENT NO SE SI FER LO DE A I B O UNA ALTRE COSA
            DBRA    D2,CHECK2
            SUBQ.W  #3,A1
            
            
            DBRA    D1,CHECK1

            MOVEM.L (A7)+,D0-D3
            
            RTS


















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
