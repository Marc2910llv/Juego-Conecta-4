; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "BALL.X68"
            INCLUDE "PAD.X68"
            INCLUDE "SCORE.X68"
           
START

; --- DISABLE INTERRUPTS

            ; SR: XXXXXIII XXXXXXXX
            ORI.W   #$0700,SR

; --- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT
            JSR     BALINIT
            JSR     PADINIT
            JSR     SCOINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC

            JSR     BALUPD
            JSR     PADUPD            

; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
            ; THE FOLLOWING SYNC STRATEGY IS ****WRONG****
            ;MOVE.B  #23,D0
            ;MOVE.L  #1,D1
            ;TRAP    #15

; --- PLOT ---------------------------------------------------------------------

            JSR     SCOPLOT
            JSR     BALPLOT
            JSR     PADPLOT
            
            MOVE.B  #80,D0
            MOVE.L  #$00000020,D1
            TRAP    #15
            ADDQ.B  #1,D0
            MOVE.L  #$000000ff,D1
            TRAP    #15
            MOVE.B  #88,D0
            MOVE.W  (MOUPOSX),D1
            MOVE.W  (MOUPOSY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #16,D1
            SUB.W   #16,D2
            ADD.W   #16,D3
            ADD.W   #16,D4
            TRAP    #15
            
            TRAP    #SCRUPTN                ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END     START





*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
