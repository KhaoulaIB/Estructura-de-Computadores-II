; ==============================================================================
; PANTALLA DE VICTORIA
; ==============================================================================

; ------------------------------------------------------------------------------
WININIT
; INICIALIZA PANTALLA DE VICTORIA. REPRODUCE SONIDO DE VICTORIA.
; ------------------------------------------------------------------------------      
            ;ESPERAR 0,2 SEG
			WAIT_TIME   #20
			
			JSR     SNDQUIT	        ;QUITA SONIDO ANTERIOR
            
            REPRODUCE_SND	#SNDWIN
			
			RTS
; ------------------------------------------------------------------------------
WINUPD
; ACTUALIZA PANTALLA DE VICTORIA. PASA SIGUIENTE ESTADO CON TECLA HACIA ABAJO.
; ------------------------------------------------------------------------------
            BTST.B  #0,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)       ;VUELVE A INTRO
.CONT       RTS

; ------------------------------------------------------------------------------
WINPLOT
; MUESTRA PANTALLA DE VICTORIA CON TEXTO.
; ------------------------------------------------------------------------------
            PLOT_FINAL_SCREEN    #VERDFLJ
            RTS
            
.TXT1       DC.B    'YOU WON!',0
.TXT2       DC.B    'FINAL SCORE:',0
.TXT3       DC.B    'PRESS KEY DOWN TO CONTINUE',0
            DS.W    0
.TXTLIST    DC.L    .TXT1,.TXT2,.TXT3,0


























