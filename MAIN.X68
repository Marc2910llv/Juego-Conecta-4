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
            INCLUDE "TABLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "PIECE.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT
            JSR     BALINIT
            JSR     TABINIT
            JSR     TABPLOT
            JSR     SCOINIT
            JSR     PIEINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

            JSR     BALUPD            

; --- SYNC ---------------------------------------------------------------------

; --- PLOT ---------------------------------------------------------------------

            ;JSR     SCOPLOT
            JSR     PIEPLOT

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END     START




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
