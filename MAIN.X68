; ==============================================================================
; TITLE : CUATRO EN RAYA
; AUTHOR: MARC LLOBERA VILLALONGA
;         PERE ROIG VERDERA
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYS/SYSCONST.X68"
            INCLUDE "SYS/SYSTEM.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "BOX.X68"
            INCLUDE "TABLE.X68"
            INCLUDE "PIECE.X68"
            INCLUDE "PLAYER.X68"
            INCLUDE "BOARD.X68"
            INCLUDE "GAME.X68"
            INCLUDE "SCREENS/INTRO.X68"
            INCLUDE "SCREENS/ENDGAME.X68"
            INCLUDE "ATTRACTMODE/FILE.X68"
            INCLUDE "ATTRACTMODE/AUTOGAME.X68"
            INCLUDE "STATES.X68"
           
START

; --- INITIALIZATION -----------------------------------------------------------
            
            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     STAINIT
            
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC

            JSR     STAUPD   
                    
; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------

            JSR    STAPLOT

            TRAP    #SCRUPTN                ; UPDATE DOBLE BUFFER
            
            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "SYS/SYSVARS.X68"

            END     START


























*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
