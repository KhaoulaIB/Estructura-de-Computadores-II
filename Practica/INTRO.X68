; ==============================================================================
; PANTALLA DE INTRODUCCIÓN
; ==============================================================================

; ------------------------------------------------------------------------------
INTINIT	
; INICIALIZA INTRO. REPRODUCE EL SONIDO.
; ------------------------------------------------------------------------------		
            MOVEM.L D0-D2,-(A7)
            
            ;QUITA SONIDO ANTERIOR
            MOVE.B  #76,D0
            MOVE.B  D7,D1 
            MOVE.L  #2,D2
            TRAP    #15			

            ;REALIZA SONIDO INTRO
            MOVE.B	#SNDDEM,D7	
            TRAP	#SNDPLTN  
            
            MOVEM.L (A7)+,D0-D2
            RTS
; ------------------------------------------------------------------------------
INTUPD
; ACTUALIZA PANTALLA DE INTRODUCCIÓN
; ------------------------------------------------------------------------------
            ;PASA SIGUIENTE ESTADO 
            BTST.B  #0,(KBDEDGE)    ;SI SE PULSA TECLA HACIA ABAJO
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)    ;PASA A JUEGO
            BRA     .DONE
.CONT       BTST.B  #4,(KBDEDGE)    ;SI SE PULSA ESPACIO
            BEQ     .DONE
            MOVE.W  #1,(STANEXT)    ;VUELVE A INTRO
.DONE       RTS

; ------------------------------------------------------------------------------
INTPLOT
; DIBUJA PANTALLA DE INTRODUCCIÓN. SE INTRODUCE EL JUEGO AL USUARIO MEDIANTE 
; TEXTO INFORMATIVO.
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)

            ;ESTABLECE COLOR RELLENO
            SET_FILL_COLOR	#STAFLCLR
            
            ;DIBUJA LAS LINEAS DE TEXTO EN PANTALLA
            LEA     .TXT1,A0
            MOVE.B  #5,D0
            JSR     UTLPRINT
            
            LEA     .TXT2,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            LEA     .TXT3,A0
            JSR     UTLPRINT
            
            LEA     .TXT4,A0
            JSR     UTLPRINT
            
            LEA     .TXT5,A0
            JSR     UTLPRINT
                     
            LEA     .TXT6,A0
            MOVE.B  #16,D0
            JSR     UTLPRINT
            
            LEA     .TXT7,A0
            JSR     UTLPRINT
            
            LEA     .TXT8,A0
            JSR     UTLPRINT     
            
            ;LOS SIGUIENTES TEXTOS PARPADEAN
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT9,A0
            MOVE.B  #22,D0
            JSR     UTLPRINT
            
            LEA     .TXT10,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0
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
















*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
