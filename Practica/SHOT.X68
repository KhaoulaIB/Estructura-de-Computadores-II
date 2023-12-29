; ==============================================================================
; CLASE DISPARO (AGENTE)
; SHTPOSX (W) : (A0)
; SHTPOSY (W) : 2(A0)
; ==============================================================================

; ------------------------------------------------------------------------------
SHTINIT
; POSICIONA LAS COORDENADAS DEL DISPARO.
; ENTRADA  : PUNTERO A LAS VARIABLES INSTANCIADAS (A0)
; ------------------------------------------------------------------------------
            ;POSICIONAR X RESPECTO AL TANQUE
            MOVE.W  (TNKPOSX),(A0)
            ADD.W   #TNKWIDHA,(A0)
            
            ;POSICIONAR Y RESPECTO AL TANQUE
            MOVE.W  #TNKPOSY,2(A0)
            SUB.W   #SHTGAP+SHTHEIGH/2,2(A0)  
            RTS
 
; ------------------------------------------------------------------------------
SHTUPD
; ACTUALIZA EL DISPARO. ELIMINA DISPAROS. COMPRUEBA COLISIONES CON ALIEN.
; ELIMINA LOS ALIENS COLISIONADOS.
; ENTRADA  : PUNTERO A LAS VARIABLES INSTANCIADAS (A0)
; ------------------------------------------------------------------------------
            MOVEM.L  D0-D1,-(A7)
            MOVEM.W  D2-D4,-(A7)			
	
            ;ACTUALIZA MOVIMIENTO DISPARO
         	MOVE.W  2(A0),D0
            SUB.W   #SHTSPEED,D0        ;RESTAMOS VELOCIDAD (VA HACIA ARRIBA)
           	MOVE.W  D0,2(A0)
           	
           	;ELIMINA DISPARO SI TOCA TECHO
           	ADD.W   #SHTHEIGH,D1
           	LSR.W   #1,D1               ;SHTHEIGH/2
           	ADD.W   D1,D0               
           	CMP.W   #LIMIT,D0           ;MIRAMOS SI HA LLEGADO A TECHO
           	BGT     .NEXT
           	JSR     AGLKILL
           	
           	;COMPOBAR COLISIONES CON ALIENS
            ;COMPROBAR COLISIÓN DISPARO X IZQUIERDA  
.NEXT       MOVE.W  (ALNPOSX),D0        ;D0 = ALNPOSX 
            MOVE.W  #SHTWIDTH,D2
            LSR.W   #1,D2
            ADD.W   (A0),D2             ;SHTPOSX + SHTWIDTH/2
            CMP.W   D0,D2             
            BLT     .DONE
            
            ;COMPROBAR COLISIÓN DISPARO X DERECHA
            MOVE.W  #SHTWIDTH,D2
            LSR.W   #1,D2
            SUB.W   (A0),D2            
            NEG.W   D2                  ;SHTPOSX - SHTWIDTH/2
            MOVE.W  D0,D3               ;COPIAR ALNPOSX
            ADD.W   #ALNDIM*ALNMPCOL,D3 ;ALNPOSX + ALNDIM * ALNMPCOL
            CMP.W   D3,D2
            BGT     .DONE
            
            ;COMPROBAR COLISIÓN DISPARO Y ARRIBA
            MOVE.W  (ALNPOSY),D1        ;D1 = ALNPOSY
            MOVE.W  #SHTHEIGH,D2
            LSR.W   #1,D2
            ADD.W   2(A0),D2            ;SHTPOSY + SHTHEIGH/2 
            CMP.W   D1,D2              
            BLT     .DONE
            
            ;COMPROBAR COLISIÓN DISPARO Y ABAJO
            MOVE.W  #SHTHEIGH,D2
            LSR.W   #1,D2
            SUB.W   2(A0),D2         
            NEG.W   D2                  ;SHTPOSY - SHTHEIGH/2
            MOVE.W  D1,D3               ;COPIAR ALNPOSY
            ADD.W   #ALNDIM*ALNMPROW,D3 ;ALNPOSY + ALNDIM * ALNMPROW
            CMP.W   D3,D2
            BGE     .DONE
            
			
           	;HAY COLISIÓN, COMPROBAMOS QUÉ ALIEN ES
           	;DETERMINAMOS LA COLUMNA
           	MOVE.W  #SHTWIDTH,D0
           	LSR.W   #1,D0
           	SUB.W	(A0),D0	
			NEG.W   D0                  ;D0 = SHTPOSX-SHTWIDTH/2 (PARTE IZQUIERDA DISPARO)
            MOVE.W	(ALNPOSX),D1	    ;D1 = ALNPOSX
			SUB.W	D1,D0	            ;D0 = (SHTPOSX-SHTWIDTH/2)-ALNPOSX
			DIVU.W	#ALNDIM,D0	        ;COLUMNA DE LA MATRIZ
			MOVE.W  D0,D4
			CLR.L   D0                  ;EL RESTO DE DIVU NO NOS INTERESA
			MOVE.W  D4,D0
									
			;DETERMINAMOS LA FILA
			MOVE.W  #SHTHEIGH,D1
           	LSR.W   #1,D1
           	SUB.W	2(A0),D1	
			NEG.W   D1                  ;D1 = SHTPOSY-SHTHEIGH/2 (PARTE ARRIBA DISPARO)
            MOVE.W	(ALNPOSY),D3	    ;D3 = ALNPOSY
			SUB.W	D3,D1	            ;D1 = (SHTPOSY-SHTHEIGH/2)-ALNPOSY
			DIVU.W	#ALNDIM,D1	        ;FILA DE LA MATRIZ
			MOVE.W  D1,D2
			CLR.L   D1                  ;EL RESTO DE DIVU NO NOS INTERESA
			
			;DETERMINAMOS LA POSICIÓN EN LA MATRIZ
			MULU.W	#10,D2              ;D2 = ÍNDICE FILA * 10
			ADD.W   D2,D0               ;D0 = D2 + ÍNDICE COLUMNA                
			
			;MIRAMOS SI ESTÁ VIVO EL ALIEN
			LEA	    MAPDATA,A3          ;CARGAMOS EL MAPA 
			CMP.B	#1,(A3,D0.W)        ;1 = VIVO
			BNE     .DONE
			
			;ALIEN VIVO
			AND.B   #0,(A3,D0.W)        ;DESAPARECE EL ALIEN
			ADDQ.W	#SCOPNT,(SCOPOINT)	;INCREMENTAMOS LOS PUNTOS ACUMULADOS           
            JSR     AGLKILL             ;ELIMINA DISPARO
            
            REPRODUCE_SND	#SNDSHT ;REPRODUCE SONIDO DE COLISIÓN
			
.DONE       MOVEM.W  (A7)+,D2-D4
            MOVEM.L  (A7)+,D0-D1
            RTS

; ------------------------------------------------------------------------------
SHTPLOT
; ACTUALIZA EL DISPARO
; ENTRADA  : PUNTERO A LAS VARIABLES INSTANCIADAS (A0)
; ------------------------------------------------------------------------------
            MOVEM.W D0-D4,-(A7)
            
            ;ESTABLECER COLOR CONTORNO Y RELLENO
            SET_PEN_COLOR	#ROJOFRT
            SET_FILL_COLOR	#ROJOFLJ
          
		    ;DIBUJAR DISPARO (RECTANGULO)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2                ;D1,D2 ESTÁN EN EL CENTRO DEL RECTÁNGULO
            SUB.W   #SHTWIDTH/2,D1          ;RESTAMOS MITAD ANCHO
            MOVE.W  D1,D3
            ADD.W   #SHTWIDTH,D3            ;SUMAMOS TODO EL ANCHO
            ADD.W   #SHTHEIGH/2,D2          ;SUMAMOS MITAD ALTURA
            MOVE.W  D2,D4
            SUB.W   #SHTHEIGH,D4            ;RESTAMOS TODA LA ALTURA
            MOVE.B  #87,D0                  
            TRAP    #15                     ;DIBUJAMOS RECTÁNGULO (CUADRADO)
            
            MOVEM.W (A7)+,D0-D4
            RTS        
































































