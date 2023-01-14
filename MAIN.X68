; ==============================================================================
; TITLE       : CUATRO EN RAYA
; AUTHOR      :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "BOX.X68"
            INCLUDE "TABLE.X68"
            INCLUDE "PIECE.X68"
            INCLUDE "PLAYER.X68"
            INCLUDE "BOARD.X68"
            INCLUDE "FILE.X68"
            INCLUDE "GAME.X68"
            INCLUDE "INTRO.X68"
            INCLUDE "INSTRUCT.X68"
            INCLUDE "STATES.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT
            JSR     GAMINIT
            ;JSR     UTLINIT
            ;JSR     STAINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #1

; UPDATE GAME LOGIC
       
            ;JSR     STAUPD
            JSR     GAMUPD    

; --- PLOT ---------------------------------------------------------------------

            ;JSR     STAPLOT
            JSR GAMPLOT

            TRAP    #0                      ; ENABLE DOBLE BUFFER
            
            CMP.B   #0,(WINNER)
            BEQ     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYSVARS.X68"

            END     START























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
