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
            MOVEM.L D0-D2/A0-A4,-(A7)
            
            ;ESTABLECER COLOR RELLENO Y DE TEXTO
			SET_FILL_COLOR	#NEGRO
            TEXT_COLOR	#NARANJA
             
            ;DIBUJAR LOS MARCADORES
            LEA     .TXTLST,A0
            LEA     .POSLST,A1
            LEA     .VALUES,A2
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE           ;SI ES 0 ACABA BUCLE
            MOVE.L  (A1)+,D1
            MOVE.L  (A2)+,D2
            MOVE.L  D0,A3
            MOVE.L  D2,A4
            SET_POS     D1          ;POSICIONAR MARCADORES
            PRINT_TEXT  (A3),(A4)   ;IMPRIMIR TEXTOS CON RESULTADOS ACTUALES
            BRA     .LOOP
          
.DONE       MOVEM.L (A7)+,D0-D2/A0-A4
            RTS
            
.TXT        DC.B    'SCORE:',0    
.TXT1       DC.B    'SHOTS:',0  
.TXT2       DC.B    'LEVEL:',0   
            DS.W    0 
.TXTLST	    DC.L	.TXT,.TXT1,.TXT2,0
.POSLST	    DC.L	SCOLINE,SCOLINE1,SCOLINE2,0
.VALUES	    DC.L	SCOPOINT,SCOSHOOT,SCOLEVEL,0

















