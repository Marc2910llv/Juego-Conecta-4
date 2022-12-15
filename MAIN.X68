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
<<<<<<< HEAD
<<<<<<< HEAD
            JSR     UTLINIT
            JSR     GAMINIT
=======
            JSR     BOXINIT
            ;JSR     SCOINIT
            JSR     PIEINIT
>>>>>>> parent of ef41bd7 (Update dibuix)
=======
            JSR     TABINIT
            ;JSR     BOXINIT
            ;JSR     SCOINIT
            JSR     PIEINIT
>>>>>>> parent of 92241fa (UPDATE)
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

            JSR     PIEUPD
            JSR     BOXUPD            

; --- SYNC ---------------------------------------------------------------------

; --- PLOT ---------------------------------------------------------------------

            JSR     TABPLOT
<<<<<<< HEAD
<<<<<<< HEAD
            TRAP    #SCRUPTN                ; UPDATE DOUBLE BUFFER
=======
            JSR     BOXPLOT
            ;JSR     SCOPLOT
            JSR     PIEPLOT
>>>>>>> parent of ef41bd7 (Update dibuix)
=======
            ;JSR     BOXPLOT
            ;JSR     SCOPLOT
            JSR     PIEPLOT
>>>>>>> parent of 92241fa (UPDATE)

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END     START







<<<<<<< HEAD


<<<<<<< HEAD


=======
>>>>>>> parent of ef41bd7 (Update dibuix)
=======
>>>>>>> parent of 92241fa (UPDATE)
*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
