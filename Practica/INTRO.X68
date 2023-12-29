; ==============================================================================
; PANTALLA DE INTRODUCCIÓN
; ==============================================================================

; ------------------------------------------------------------------------------
INTINIT	
; INICIALIZA INTRO. REPRODUCE EL SONIDO.
; ------------------------------------------------------------------------------		
            JSR     SNDQUIT	        ;QUITA SONIDO ANTERIOR

            ;REALIZA SONIDO INTRO
            REPRODUCE_SND	#SNDDEM
            
            RTS
; ------------------------------------------------------------------------------
INTUPD
; ACTUALIZA PANTALLA DE INTRODUCCIÓN
; ------------------------------------------------------------------------------
            ;PASA SIGUIENTE ESTADO 
            BTST.B  #0,(KBDEDGE)        ;SI SE PULSA TECLA HACIA ABAJO
            BEQ     .CONT
            MOVE.W  #STAGAM,(STANEXT)   ;PASA A JUEGO
            BRA     .DONE
.CONT       BTST.B  #4,(KBDEDGE)        ;SI SE PULSA ESPACIO
            BEQ     .DONE
            MOVE.W  #STADEM,(STANEXT)   ;VA A DEMO
.DONE       RTS

; ------------------------------------------------------------------------------
INTPLOT
; DIBUJA PANTALLA DE INTRODUCCIÓN. SE INTRODUCE EL JUEGO AL USUARIO MEDIANTE 
; TEXTO INFORMATIVO.
; ------------------------------------------------------------------------------
            MOVEM.L D2/A0-A1,-(A7)
            MOVEM.W D0-D1,-(A7)
            
            ;ESTABLECER COLOR FONDO Y TEXTO
			SET_FILL_COLOR	#NEGRO
			TEXT_COLOR	#BLANCO   
			
			;DIBUJA LAS LINEAS DE TEXTO EN PANTALLA
            CLR.B   D1              ;CONTADOR
            LEA     .TXTLIST,A1
.LOOP       MOVE.L  (A1)+,D2
            BEQ     .DONE
            
            ;MIRAR QUÉ LINEA DE TEXTO ESTAMOS
            CMP.B   #0,D1
            BEQ     .TEXTO1          
            CMP.B   #1,D1
            BEQ     .TEXTO2
            CMP.B   #5,D1
            BEQ     .TEXTO3
            CMP.B   #8,D1
            BEQ     .TEXTO4
            CMP.B   #9,D1
            BEQ     .TEXTO5
            ;SI NO ESTAMOS EN NINGUNA DE ESTOS D0 SE MANTIENE (CON EL VALOR INCREMENTADO DE UTLPRINT)
            BRA     .NEXT         
            
            ;MOVER A LA LÍNEA QUE TOCA DEPENDIENDO DEL TEXTO
.TEXTO1     MOVE.B  #5,D0
            BRA     .NEXT 
.TEXTO2     MOVE.B  #10,D0
            BRA     .NEXT
.TEXTO3     MOVE.B  #16,D0
            BRA     .NEXT
.TEXTO4     SET_FILL_COLOR	#LILAFRT    ;CAMBIAR COLOR     
            BTST.B  #4,(SCRCYCCT)       ;TEXTO PARPADEA
            BEQ     .DONE
            MOVE.B  #22,D0
            BRA     .NEXT
.TEXTO5     MOVE.B  #25,D0
            
            ;SEGUIMOS CON EL BUCLE
.NEXT       ADDQ.B  #1,D1               ;SUMAR CONTADOR 
            MOVE.L  D2,A0
            JSR     UTLPRINT            ;IMPRIME TEXTO
            BRA     .LOOP
           
.DONE       MOVEM.W (A7)+,D0-D1
            MOVEM.L (A7)+,D2/A0-A1
            RTS   
            
.TXT1       DC.B    'SPACE INVADERS',0
.TXT2       DC.B    'INSTRUCTIONS:',0
.TXT3       DC.B    'PRESS -> TO MOVE TO THE RIGHT',0
.TXT4       DC.B    'PRESS <- TO MOVE TO THE LEFT',0
.TXT5       DC.B    'PRESS KEY UP TO SHOOT',0
.TXT6       DC.B    'GOAL:',0
.TXT7       DC.B    'KILL ALL THE ALIENS BEFORE THEY REACH THE TANK',0
.TXT8       DC.B    'WITH AS FEW SHOTS AS POSSIBLE',0 
.TXT9       DC.B    'PRESS SPACE TO SEE THE DEMO',0
.TXT10      DC.B    'PRESS KEY DOWN TO START THE GAME',0
            DS.W    0
.TXTLIST    DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,.TXT6,.TXT7,.TXT8,.TXT9,.TXT10,0


























