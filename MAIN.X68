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

            TRAP    #1

; UPDATE GAME LOGIC

            JSR     BALUPD
            JSR     PADUPD            

; --- SYNC ---------------------------------------------------------------------

            ; THE FOLLOWING SYNC STRATEGY IS ****WRONG****
            MOVE.B  #23,D0
            MOVE.L  #1,D1
            TRAP    #15

; --- PLOT ---------------------------------------------------------------------

            JSR     SCOPLOT
            JSR     BALPLOT
            JSR     PADPLOT
            
            TRAP    #0                      ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END     START




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
