; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "BOX.X68"
            INCLUDE "TABLE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "PIECE.X68"
            INCLUDE "GAME.X68"
            
           
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     UTLINIT
            JSR     GAMINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC

            JSR     GAMUPD
            JSR     PIEUPD
            ;JSR     BOXUPD            

; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------

            JSR     TABPLOT
            TRAP    #SCRUPTN                ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"

            END     START











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
