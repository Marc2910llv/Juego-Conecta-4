; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- BOX RELATED VARIABLES ----------------------------------------------------

BOXCOL      DS.W    1                       ; COLUMN WHERE THE BOX IS PAINTED  
BOXROW      DS.W    1                       ; ROW WHERE THE BOX IS PAINTED
BOXPOSX     DS.W    1                       ; BOX X COORDINATE
BOXPOSY     DS.W    1                       ; BOX Y COORDINATE

; --- PIECE RELATED VARIABLES --------------------------------------------------

PIEPOSX     DS.W    1                       ; PIECE X COORDINATE
PIEPOSY     DS.W    1                       ; PIECE Y COORDINATE
PIEVELX     DS.W    1                       ; X MOVEMENT
PIEVELY     DS.W    1                       ; Y MOVEMENT

; --- ROW RELATED VARAIBLES ----------------------------------------------------

ROW1       DS.B    1,1,1,1,1,1,1
ROW2       DS.B    1,1,1,1,1,1,1
ROW3       DS.B    1,1,1,1,1,1,1
ROW4       DS.B    1,1,1,1,1,1,1
ROW5       DS.B    1,1,1,1,1,1,1
ROW6       DS.B    1,1,1,1,1,1,1

; --- PIECE VALUE RELATED VARAIBLES --------------------------------------------

COLUVAL      DS.B    1,1,1,1,1,1,1 ;Vector per saber cuntes fitxes s'hi han colocat a cada columna, amb aixo podem determinar sa posició per colocar i comparar sa fitxa

; --- PIECE POSITION VARAIBLES -------------------------------------------------

POSX        DS.B    1 ;aqui se guarden ses posicions x i y de on se vol colocar sa fitxa si miram sa tauler com una matriu de posicions xy
POSY        DS.B    1











*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
