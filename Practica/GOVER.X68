; ==============================================================================
; PANTALLA DE DERROTA
; ============================================================================== 

; ------------------------------------------------------------------------------
GOVINIT
; INICIALIZA PANTALLA DE DERROTA. REPRODUCE SONIDO DE DERROTA.
; ------------------------------------------------------------------------------
			MOVEM.L D0-D2,-(A7)
            
            ;QUITA SONIDO ANTERIOR
            MOVE.B  #76,D0
            MOVE.B  D7,D1 
            MOVE.L  #2,D2
            TRAP    #15
            
            ;REPRODUCE SONIDO DE DERROTA
            MOVE.B	#SNDGOV,D7
			TRAP	#SNDPLTN
			
			MOVEM.L (A7)+,D0-D2
			RTS
			
; ------------------------------------------------------------------------------
GOVUPD
; ACTUALIZA PANTALLA DE DERROTA. PASA SIGUIENTE ESTADO CON TECLA HACIA ABAJO.
; ------------------------------------------------------------------------------
            BTST.B  #0,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       RTS

; ------------------------------------------------------------------------------
GOVPLOT
; MUESTRA PANTALLA DE DERROTA CON LÍNEAS DE TEXTO
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            ;ESTABLECE COLOR RELLENO
            SET_FILL_COLOR	#STAFLCLR
            
            ;LÍNEAS DE TEXTO
            LEA     .TXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT   
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
              
.DONE       MOVEM.L (A7)+,D0-D1/A0
            RTS
            
.TXT1       DC.B    'GAME OVER',0
.TXT2       DC.B    'PRESS KEY DOWN TO CONTINUE',0
            DS.W    0











*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
