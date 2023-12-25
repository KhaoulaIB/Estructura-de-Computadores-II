*-----------------------------------------------------------
* Title    : SCORE CLASS
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE THE SCORE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            CLR.W   (SCOPOINT)
            CLR.W   (SCOSHOOT)
            CLR.W   (SCOLEVEL)
            RTS
 
; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCORE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D1/A1,-(A7)
            
            ;ESTABLECER COLOR RELLENO
			SET_FILL_COLOR	#SCOFLCLR
            
            ;ESTABLECER POSICIÓN 1 IZQUIERDA
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE,D1
            TRAP    #15
            
            ;MOSTRAR PUNTUACIÓN
            MOVE.B  #17,D0
            LEA     .TXT,A1
            MOVE.W  (SCOPOINT),D1
            TRAP    #15
            
            ;ESTABLECER POSICIÓN 1 DERECHA 
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15
            
            ;MOSTRAR NÚMERO DE DISPAROS
            MOVE.B  #17,D0
            LEA     .TXT1,A1
            MOVE.W  (SCOSHOOT),D1
            TRAP    #15    
            
            ;ESTABLECER POSICIÓN 2 DERECHA 
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15
            
            ;MOSTRAR NIVEL DE DIFICULTAD
            MOVE.B  #17,D0
            LEA     .TXT2,A1
            MOVE.W  (SCOLEVEL),D1
            TRAP    #15  
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS

.TXT        DC.B    'PUNTUACION:',0    
.TXT1       DC.B    'DISPAROS:',0  
.TXT2       DC.B    'NIVEL:',0   
            DS.W    0 







