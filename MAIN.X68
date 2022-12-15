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
            INCLUDE "BOX.X68"
            INCLUDE "TABLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "PIECE.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT

            JSR     BOXINIT
            ;JSR     SCOINIT
            JSR     PIEINIT

            JSR     TABINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

            JSR     PIEUPD
            JSR     BOXUPD            

; --- SYNC ---------------------------------------------------------------------

; --- PLOT ---------------------------------------------------------------------

            JSR     TABPLOT
            
 ;           TRAP    #SCRUPTN                ; UPDATE DOUBLE BUFFER

            JSR     BOXPLOT
            ;JSR     SCOPLOT
            JSR     PIEPLOT

            ;JSR     BOXPLOT
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
