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
*            MOVE.B	#SNDDEM,D7	
*            TRAP	#SNDPLTN  
            
            MOVEM.L (A7)+,D0-D2
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
            MOVEM.L D0/D2/D3/A0-A1,-(A7)
    
			SET_FILL_COLOR	#NEGRO   
 			CLR.B   D3              ;CONTADOR
            LEA     .TXTLIST,A1
.LOOP       MOVE.L  (A1)+,D2
            BEQ     .PRINT

            ;MIRAR QUÉ LINEA DE TEXTO ESTAMOS
            CMP.B   #0,D3
            BEQ     .TEXTO1

            CMP.B   #1,D3
            BEQ     .TEXTO2

            CMP.B   #5,D3
            BEQ     .TEXTO3

            CMP.B   #8,D3
            BEQ     .TEXTO4

            CMP.B   #9,D3
            BEQ     .TEXTO5
            BRA     .NEXT

.TEXTO1     MOVE.B  #5,D0
            BRA     .NEXT 
.TEXTO2     MOVE.B  #10,D0
            BRA     .NEXT
.TEXTO3     MOVE.B  #16,D0
            BRA     .NEXT
.TEXTO4     MOVE.B  #22,D0
            BRA     .NEXT
.TEXTO5     MOVE.B  #25,D0

.NEXT       ADDQ.B  #1,D3           ;SUMAR CONTADOR 
            MOVE.L  D2,A0
            JSR     UTLPRINT        ;IMPRIME TEXTO
           	BRA     .LOOP
 
 
.PRINT	    BTST.B  #4,(SCRCYCCT)
			BEQ		.DONE
            SET_FILL_COLOR	#LILAFRT
			LEA     .TXT9,A0
            MOVE.B  #24,D0
            JSR     UTLPRINT
          
            LEA     .TXT10,A0
            MOVE.B  #27,D0
            JSR     UTLPRINT
    		 
.DONE       MOVEM.L (A7)+,D0/D2/D3/A0-A1
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
.TXTLIST    DC.L    .TXT1,.TXT2,.TXT3,.TXT4,.TXT5,.TXT6,.TXT7,.TXT8,0













