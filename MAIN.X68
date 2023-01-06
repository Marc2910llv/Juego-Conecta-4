; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            ;INCLUDE "LIB/DMMCONST.X68"
            ;INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            ;INCLUDE "LIB/AGLCODE.X68"
            ;INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "BOX.X68"
            INCLUDE "TABLE.X68"
            INCLUDE "PIECE.X68"
            INCLUDE "GAME.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            JSR     SYSINIT
            JSR     GAMINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

; UPDATE GAME LOGIC

            JSR     GAMUPD           

; --- SYNC ---------------------------------------------------------------------

            

; --- PLOT ---------------------------------------------------------------------

            JSR     GAMPLOT

            TRAP    #0                      ; ENABLE DOBLE BUFFER
            
            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            ;INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            ;INCLUDE "LIB/DMMVARS.X68"

            END     START








*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
