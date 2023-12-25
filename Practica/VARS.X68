*-----------------------------------------------------------
* Title      : GAME VARIABLES
*-----------------------------------------------------------

; --- TANK RELATED VARIABLES ---------------------------------------------------

TNKPOSX     DS.W    1   ;POSICIÓN X TANQUE

; --- ALIEN RELATED VARIABLES --------------------------------------------------

ALNPOSX     DS.W    1   ;POSICIÓN X ALIEN
ALNPOSY     DS.W    1   ;POSICIÓN Y ALIEN
ALNVELX     DS.W    1   ;VELOCIDAD ALIENS X
ALNVELY     DS.W    1   ;VELOCIDAD ALIENS Y
ALNVELV1    DS.W    1   ;VELOCIDAD ALIEN NIVEL 1
ALNVELV2    DS.W    1   ;VELOCIDAD ALIEN NIVEL 2
ALNVELV3    DS.W    1   ;VELOCIDAD ALIEN NIVEL 3

; --- SHOT RELATED VARIABLES ---------------------------------------------------

SHTPOSX     DS.W    1   ;POSICIÓN X DISPARO
SHTPOSY     DS.W    1   ;POSICIÓN Y DISPARO

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOPOINT    DS.W    1   ;PUNTUACIÓN JUGADOR
SCOSHOOT    DS.W    1   ;NUMERO DE DISPAROS JUGADOR  
SCOLEVEL    DS.W    1   ;NIVEL DE DIFICULTAD

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1   ;CURRENT STATE
STANEXT     DS.W    1   ;NEXT STATE


















