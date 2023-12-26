; ==============================================================================
; CLASE MARCADOR
; ==============================================================================

; ------------------------------------------------------------------------------
SCOINIT
; INICIALIZA LOS MARCADORES
; ------------------------------------------------------------------------------
            CLR.W   (SCOPOINT)
            CLR.W   (SCOSHOOT)
            CLR.W   (SCOLEVEL)
            RTS
 
; ------------------------------------------------------------------------------
SCOPLOT
; MUESTRA LOS MARCADORES
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)
            
            ;ESTABLECER COLOR RELLENO
			SET_FILL_COLOR	#SCOFLCLR
            
            ;ESTABLECE POSICIÓN 1 IZQUIERDA
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE,D1
            TRAP    #15
            
            ;MUESTRA PUNTUACIÓN
            MOVE.B  #17,D0
            LEA     .TXT,A1
            MOVE.W  (SCOPOINT),D1
            TRAP    #15
            
            ;ESTABLECE POSICIÓN 1 DERECHA 
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15
            
            ;MUESTRA NÚMERO DE DISPAROS
            SET_PEN_COLOR	#DISPCLR
            MOVE.B  #17,D0
            LEA     .TXT1,A1
            MOVE.W  (SCOSHOOT),D1
            TRAP    #15    
            
            ;ESTABLECER POSICIÓN 2 DERECHA 
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15
            
            ;MUESTRA NIVEL DE DIFICULTAD
            SET_PEN_COLOR	#NIVELCR
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









*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
