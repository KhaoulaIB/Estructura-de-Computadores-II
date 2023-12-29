; ==============================================================================
; PANTALLA DE DERROTA
; ============================================================================== 

; ------------------------------------------------------------------------------
GOVINIT
; INICIALIZA PANTALLA DE DERROTA. REPRODUCE SONIDO DE DERROTA.
; ------------------------------------------------------------------------------
            ;ESPERAR 0,2 SEG
			WAIT_TIME   #20 
			
            JSR     SNDQUIT	            ;QUITA SONIDO ANTERIOR
			
            ;REPRODUCE SONIDO DE DERROTA
            REPRODUCE_SND #SNDGOV		              

			RTS
			
; ------------------------------------------------------------------------------
GOVUPD
; ACTUALIZA PANTALLA DE DERROTA. PASA SIGUIENTE ESTADO CON TECLA HACIA ABAJO.
; ------------------------------------------------------------------------------
            BTST.B  #0,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)           ;VUELVE A INTRO
.CONT       RTS

; ------------------------------------------------------------------------------
GOVPLOT
; MUESTRA PANTALLA DE DERROTA CON LÍNEAS DE TEXTO
; ------------------------------------------------------------------------------
            PLOT_FINAL_SCREEN    #ROJOFLJ
            RTS
            
.TXT1       DC.B    'GAME OVER',0
.TXT2       DC.B    'FINAL SCORE:',0
.TXT3       DC.B    'PRESS KEY DOWN TO CONTINUE',0
            DS.W    0
.TXTLIST    DC.L    .TXT1,.TXT2,.TXT3,0
























