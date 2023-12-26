; ==============================================================================
; CLASE TANQUE
; ==============================================================================
  
; ------------------------------------------------------------------------------
TNKINIT
; INICIALIZA TANQUE. ELIMINA SONIDO DE PRESENTACIÓN (TANTO PARA DEMO COMO PARA
; JUEGO).
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)           

            ;QUITAR SONIDO PRESENTACIÓN
            MOVE.B  #76,D0
            MOVE.B  D7,D1 
            MOVE.L  #2,D2
            TRAP    #15
            
            ;INICIALIZAR POSICIÓN X TANQUE (MITAD PANTALLA - MITAD ANCHO TANQUE)
            MOVE.W  #SCRWIDTH/2-TNKWIDHA,(TNKPOSX) 
            
            MOVEM.L (A7)+,D0-D2
            RTS
            
; ------------------------------------------------------------------------------
TNKUPD
; ACTUALIZA LAS COORDENADAS DEL TANQUE. COMPRUEBA COLISIONES CON EXTREMOS DE LA
; PANTALLA.
; ------------------------------------------------------------------------------
            MOVE.W D0,-(A7)
            
            ;GUARDAR VARIABLE EN REGISTRO
            MOVE.W  (TNKPOSX),D0        
            
            ;MOVER DERECHA SI TECLA: ->
            BTST.B  #1,(KBDVAL)
            BEQ     .LEFT
            ADD.W   #TNKSPEED,D0
           
            ;MOVER IZQUIERDA SI TECLA: <-
.LEFT       BTST.B  #3,(KBDVAL)
            BEQ     .CHKLEFT
            SUB.W   #TNKSPEED,D0
              
            ;COMPOBAR COLISIONES PANTALLA
            ;COMPROBAR COLISIÓN IZQUIERDA
.CHKLEFT    CMP.W   #0,D0
            BGE     .CHKRIGHT
            CLR.W   D0                          ;LO COLOCA A LA IZQUIERDA
            BRA     .DONE

            ;COMPROBAR COLISIÓN DERECHA
.CHKRIGHT   CMP.W   #SCRWIDTH-TNKWIDTH,D0     
            BLE     .DONE
            MOVE.W  #SCRWIDTH-TNKWIDTH,D0       ;LO COLOCA A LA DERECHA     
            
            ;ACTUALIZAR VARIABLE
.DONE       MOVE.W  D0,(TNKPOSX)

            MOVE.W (A7)+,D0
            RTS

; ------------------------------------------------------------------------------
TNKPLOT
; DIBUJA EL TANQUE EN PANTALLA.
; ------------------------------------------------------------------------------
            MOVEM.L D0-D6/A0,-(A7)
            
            ;ESTABLECER COLOR CONTORNO
			SET_PEN_COLOR #TNKPNCLR

            ;ESTABLECER COLOR RELLENO
            SET_FILL_COLOR	#TNKFLCLR
            
            ;DIBUJAR TANQUE EN FORMATO MATRIZ
            LEA     TNKMAP,A1
            MOVE.B  #87,D0
            MOVE.W  #TNKPOSY,D2
            MOVE.W  #TNKPOSY+TNKSQUWI,D4                ;DEFINIR POSICIÓN Y
            MOVE.W  #TNKROW-1,D6                        ;FILAS MATRIZ
.CLOOP      MOVE.W  (TNKPOSX),D1
            MOVE.W  D1,D3
            ADD.W   #TNKSQUWI,D3                        ;DEFINIR POSICIÓN X
            MOVE.W  #TNKCOL-1,D5                        ;COLUMNAS MATRIZ
.RLOOP      TST.B   (A1)+
            BEQ     .NEXT
            TRAP    #15
.NEXT       MOVE.W  D3,D1
            ADD.W   #TNKSQUWI,D3
            DBRA.W  D5,.RLOOP
            MOVE.W  D4,D2
            ADD.W   #TNKSQUWI,D4
            DBRA.W  D6,.CLOOP

            MOVEM.L (A7)+,D0-D6/A1
            RTS
            
            ;FIGURA TANQUE EN MATRIZ 6x9
TNKMAP      DC.B    0,0,0,0,1,0,0,0,0    
            DC.B    0,0,0,1,1,1,0,0,0
            DC.B    0,0,0,1,1,1,0,0,0
            DC.B    1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1
            DS.W    0

























*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
