; ==============================================================================
; CLASE ALIEN
; ==============================================================================
; ------------------------------------------------------------------------------
ALNINIT
; INICIALIZA COORDENADAS ALIEN. RELLENA EL MAPA DE ALIENS.
; ------------------------------------------------------------------------------
            MOVE.W  #ALNIPOSX,(ALNPOSX)
            MOVE.W  #ALNIPOSY,(ALNPOSY)
            MOVE.W  #ALNSPD1,(ALNVELX)      ;VELOCIDAD NIVEL 1
            MOVE.W  #ALNSPD2,(ALNVELX2)     ;VELOCIDAD NIVEL 2
            MOVE.W  #ALNPIXEL,(ALNVELY)
           	JSR     MAPPLOT       
            RTS

; ------------------------------------------------------------------------------
ALNUPD
; ACTUALIZA EL MOVIMIENTO DE LOS ALIENS.
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            
            ;GUARDA COORDENADAS
            MOVE.W  (ALNPOSX),D0
            MOVE.W  (ALNPOSY),D1
            
            ;MIRAR EN QUÉ RANGO ESTÁ POS(Y)
            ;PARA DETERMINAR EL NIVEL DE DIFICULTAD
            CMP.W   #144,D1             ;SIGUIENTE NIVEL SI ES MÁS GRANDE
            BLT     .LVL1
            CMP.W   #208,D1             ;SIGUIENTE NIVEL SI ES MÁS GRANDE
            BLT     .LVL2
            BRA     .LVL3   
            
            ;NIVEL 1
.LVL1      	MOVE.W  #NIVEL1,(SCOLEVEL)
            ADD.W   (ALNVELX),D0        ;VELOCIDAD ESTÁNDAR
            BRA     .CHKCOL
           	
           	;NIVEL 2
.LVL2      	MOVE.W  #NIVEL2,(SCOLEVEL)
            ADD.W   (ALNVELX2),D0       ;1,5 VECES MÁS RÁPIDO
            BRA     .CHKCOL

            ;NIVEL 3
.LVL3      	MOVE.W  #NIVEL3,(SCOLEVEL)
            ADD.W   (ALNVELX),D0
            ADD.W   (ALNVELX),D0        ;DOBLE MÁS RÁPIDO        
                
            ;COMPRUEBA COLISIONES HORIZONTALES
.CHKCOL     CMP.W   #SCRWIDTH-440,D0    ;EXTREMO DERECHO (DEJAMOS UN MARGÉN)
            BGT     .COLRGT
            CMP.W   #ALNDIM,D0          ;EXTREMO IZQUIERDO
            BLT     .COLLFT
            BRA     .DONE
            
            ;COMPRUEBA COLISIONES LATERALES DERECHA
.COLRGT     ADD.W   (ALNVELY),D1        ;BAJAR N PIXELES HACIA ABAJO
            NEG.W   (ALNVELX)           ;MOVER HACIA LA OTRA DIRECCIÓN
            NEG.W   (ALNVELX2)
            MOVE.W  #SCRWIDTH-440,D0    ;VOLVER A ESA POSICIÓN SI SE HA PASADO
            BRA     .DONE
            
            ;COMPRUEBA COLISIONES LATERALES IZQUIERDA
.COLLFT     ADD.W   (ALNVELY),D1        ;BAJAR N PIXELES HACIA ABAJO
            NEG.W   (ALNVELX)           ;MOVER HACIA LA OTRA DIRECCIÓN
            NEG.W   (ALNVELX2)
            MOVE.W  #ALNDIM,D0          ;VOLVER A ESA POSICIÓN SI SE HA PASADO
      
            ;ESTABLECE COORDENADAS
.DONE       MOVE.W  D0,(ALNPOSX)
            MOVE.W  D1,(ALNPOSY)

            MOVEM.L (A7)+,D0-D1 
            RTS

;--------------------------------------------------------------------------------
ALNPLOT
; DIBUJA UNA CUADRICULA 3*10 PARA QUE HAYA UN ALIEN EN CADA UNA DE ELLAS.
;--------------------------------------------------------------------------------
            MOVEM.L D1-D6/A2,-(A7)
	            
            ;DEFINE COLORES
            SET_PEN_COLOR	#ALNPNCLR
            SET_FILL_COLOR	#ALNFLCLR
            
            ;CARGA MAPA
            LEA     MAPDATA,A2      
            
            ;DIBUJA CUADRÍCULA 3*10 CON ALIEN INCLUIDO
            MOVE.W  (ALNPOSY),D2
            MOVE.W  D2,D4
            ADD.W   #ALNDIM,D4          ;POSICIÓN Y
            MOVE.W  #ALNMPROW-1,D6      ;FILAS MAPA
.CLOOP      MOVE.W  (ALNPOSX),D1
            MOVE.W  D1,D3
            ADD.W   #ALNDIM,D3          ;POSICIÓN X
            MOVE.W  #ALNMPCOL-1,D5      ;COLUMNAS MAPA
.RLOOP      TST.B   (A2)+
            BEQ     .NEXT
            JSR     ALNMPLOT            ;DIBUJA ALIEN
.NEXT       MOVE.W  D3,D1
            ADD.W   #ALNDIM,D3
            DBRA.W  D5,.RLOOP
            MOVE.W  D4,D2
            ADD.W   #ALNDIM,D4
            DBRA.W  D6,.CLOOP

            MOVEM.L (A7)+,D1-D6/A2
            RTS   
 
            ;MATRIZ 3*10
MAPDATA     DC.B    1,1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1,1
            DS.W    0

; ------------------------------------------------------------------------------
ALNMPLOT
; DIBUJA EL ALIEN EN FORMATO MATRIZ (MAPA DE BITS)
; ------------------------------------------------------------------------------
            MOVEM.L D0-D7/A1,-(A7)
            
            ;GUARDA REGISTRO
            MOVE.W  D1,D7                                     
            
            ;CARGA MAPA
            LEA     ALNDATA,A1
            
            ;DIBUJA ALIEN EN FORMATO MATRIZ
            MOVE.B  #87,D0
            MOVE.W  D2,D4
            ADD.W   #ALNDIM/ALNROW,D4           ;POSICIÓN Y
            MOVE.W  #ALNROW-1,D6                ;FILAS ALIEN             
.CLOOP1     MOVE.W  D7,D1                       ;RESTAURA REGISTRO
            MOVE.W  D1,D3
            ADD.W   #ALNDIM/ALNROW,D3           ;POSICIÓN X    
            MOVE.W  #ALNCOL-1,D5                ;COLUMNAS ALIEN                   
.RLOOP1     TST.B   (A1)+
            BEQ     .NEXT1
            TRAP    #15
.NEXT1      MOVE.W  D3,D1
            ADD.W   #ALNDIM/ALNROW,D3
            DBRA.W  D5,.RLOOP1
            MOVE.W  D4,D2
            ADD.W   #ALNDIM/ALNROW,D4
            DBRA.W  D6,.CLOOP1

            MOVEM.L (A7)+,D0-D7/A1
            RTS

            ;FIGURA DE ALIEN ('0's REPRESENTAN ESPACIOS ENTRE ALIENS)
ALNDATA     DC.B    0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,1,1,1,1,0,0,0
            DC.B    0,0,1,1,1,1,1,1,0,0
            DC.B    0,0,1,0,1,1,0,1,0,0
            DC.B    0,0,1,1,0,0,1,1,0,0
            DC.B    0,0,0,1,1,1,1,0,0,0
            DC.B    0,0,1,0,0,0,0,1,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0
            DS.W    0


; ------------------------------------------------------------------------------
MAPPLOT
; RELLENA EL MAPDATA 
; ------------------------------------------------------------------------------
	        MOVEM.L	D1-D2/A1,-(A7)
	        
	        LEA     MAPDATA,A1         
            MOVEQ   #1,D1              
            MOVEQ   #ALNMPROW*ALNMPCOL-1,D2             

RESET_LOOP
            ;ESTABLECER EL VALOR EN LA UBICACIÓN ACTUAL Y AVANZAR
            MOVE.B  D1,(A1)+  

            ;DECREMENTAR D2 Y SALTAR SI NO HA ALCANZADO LA LONGITUD TOTAL        
            DBRA    D2,RESET_LOOP 

            MOVEM.L	(A7)+,D1-D2/A1
	        RTS  





     






















































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
