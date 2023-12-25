*-----------------------------------------------------------
* Title      :TANK
*-----------------------------------------------------------
  
; ------------------------------------------------------------------------------
TNKINIT
; INITIALIZE TANK
; INPUT    :  
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVE.W  #SCRWIDTH/2-TNKWIDHA,(TNKPOSX)  ;MITAD PANTALLA - MITAD ANCHO DEL TANQUE

            RTS
            
; ------------------------------------------------------------------------------
TNKUPD
; UPDATES THE TANK
; INPUT    : 
; OUTPUT   : NONE
; MODIFIES : NONE
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
            CLR.W   D0                          ;LO COLOCA A LA IZQUIERDA DE LA PANTALLA
            BRA     .DONE

            ;COMPROBAR COLISIÓN DERECHA
.CHKRIGHT   CMP.W   #SCRWIDTH-TNKWIDTH,D0     
            BLE     .DONE
            ;RESTA ANCHO DEL TANQUE
            MOVE.W  #SCRWIDTH-TNKWIDTH,D0       ;LO COLOCA A LA DERECHA DE LA PANTALLA     
            
            ;ACTUALIZAR VARIABLE
.DONE       MOVE.W  D0,(TNKPOSX)

            MOVE.W (A7)+,D0
            RTS

; ------------------------------------------------------------------------------
TNKPLOT
; PLOT THE TANK.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D6/A0,-(A7)
            
            ;ESTABLECER COLOR CONTORNO
			SET_PEN_COLOR #TNKPNCLR

            ;ESTABLECER COLOR RELLENO
            SET_FILL_COLOR	#TNKFLCLR
            
            ;DIBUJAR TANQUE
            LEA     TNKMAP,A1
            MOVE.B  #87,D0
            MOVE.W  #TNKPOSY,D2
            MOVE.W  #TNKPOSY+TNKSQUWI,D4                ;DEFINIR POSICIÓN Y
            MOVE.W  #TNKROW-1,D6                        ;FILAS

.CLOOP      MOVE.W  (TNKPOSX),D1
            MOVE.W  D1,D3
            ADD.W   #TNKSQUWI,D3                        ;DEFINIR POSICIÓN X
            MOVE.W  #TNKCOL-1,D5                        ;COLUMNAS
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
            
TNKMAP      DC.B    0,0,0,0,1,0,0,0,0    
            DC.B    0,0,0,1,1,1,0,0,0
            DC.B    0,0,0,1,1,1,0,0,0
            DC.B    1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1
            DS.W    0
























