*-----------------------------------------------------------
* Title    : SHOOT CLASS (AGENTE)
* SHTPOSX : (A0)
* SHTPOSY : 2(A0)
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
SHTINIT
; INITIALIZE THE SHOOT 
; INPUT    :  A0 POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            ;POSICIONAR DISPARO
            ;POSICIONAR X
            MOVE.W  (TNKPOSX),(A0)
            ADD.W   #TNKWIDHA,(A0)
            
            ;POSICIONAR Y
            MOVE.W  #TNKPOSY,2(A0)
            SUB.W   #SHTGAP+SHTHEIGH/2,2(A0)

            RTS
 
; ------------------------------------------------------------------------------
SHTUPD
; UPDATES THE SHOOT
; INPUT    : 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.W  D0-D3,-(A7)
				
            ;ACTUALIZAR MOVIMIENTO DISPARO
			MOVE.W  2(A0),D0
            SUB.W   #SHTSPEED,D0
           	MOVE.W  D0,2(A0)
           	
           	;ELIMINAR DISPARO SI TOCA TECHO
           	ADD.W   #SHTHEIGH,D1
           	LSR.W   #1,D1
           	ADD.W   D1,D0
           	CMP.W   #0,D0
           	BGT     .NEXT
           	JSR     AGLKILL
           	
           	;COMPOBAR COLISIONES CON DISPARO (DESAPARECER)
           	
			
			
           	; 
            ;COMPROBAR COLISIÓN DISPARO X IZQUIERDA  
.NEXT       MOVE.W  (ALNPOSX),D0        ;D0 = ALNPOSX 
.CONT       MOVE.W  #SHTWIDTH,D2
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
            BGT     .DONE
             
           	
           	
           	MOVE.W	(A0),D0	; DO = SHTPOSX
			SUB.W	#SHTWIDTH/2,D0	; D0 = SHTPOSX- SHTWIDTH/2	; (PARTE ARRIBA IZQUIERDA)
            MOVE.W	(ALNPOSX),D1	;D1 = ALNPOSX
			SUB.W	D1,D0	;D0 = 	SHTPOSX- SHTWIDTH/2-ALNPOSX

			;MOVE.W	#60,D0
			DIVU.W	#ALNDIM,D0	; COLUMNA DE LA MATRIZ
									
			
			MOVE.W	2(A0),D2	; DO = SHTPOSY
			SUB.W	#SHTHEIGH/2,D2	; D0 = SHTPOSY- SHTHEIGH/2	; (PARTE ARRIBA IZQUIERDA)
            MOVE.W	(ALNPOSY),D3	;D1 = ALNPOSY
			SUB.W	D3,D2	;D0 = 	SHTPOSY- SHTHEIGH/2-ALNPOSY
			;MOVE.W	#60,D2
			DIVU.W	#ALNDIM,D2	; FILA DE LA MATRIZ
			
			MULU.W	#10,D2
			ADD.W D2,D0
			ADDQ.W #1,D0
			;MOVE.W	#12,D1
			LEA	MAPDATA, A3
			MOVE.L	(A3),D5
			OR.B	#1,	(A3,D0.W)	;
			BEQ	.DONE
			AND.B #0, (A3,D0.W)
			ADDQ.W	#1,(SCOPOINT)	    ;INCREMENTAMOS LOS PUNTOS ACUMULADOS

			
			


*
*           	;HAY COLISIÓN
*           	;MIRAMOS QUE ALIEN TIENE COLISIÓN
* 
*           	MOVE.W   (A0),D0		;D0 = SHTPOSX
*           	;SUB.W   (ALNPOX),D0      ;D0 = SHTPOSX-ALNPOSX
*           	MOVE.W	(ALNPOSX),D2
*           	SUB.W	D2,D0
*			DIVU.W	#ALNDIM,D0		;D0.W =(SHTPOSX-ALNPOSX)/ALNDIM 
*           	           	
*           	;CALCULAR DIFERENCIA SHOT/ALIEN (Y)
*           	MOVE.W   2(A0),D1		;D0 = SHTPOSY
*           	MOVE.W	(ALNPOSY),D3
*           	SUB.W	D3,D1			;D1 = SHTPOSY-ALNPOSY
*           	;SUB.W   (ALNPOX),D1      
*			DIVU.W	#ALNDIM,D1		;D1.W =(SHTPOSY-ALNPOSY)/ALNDIM 
*      
*            ;ALIEN QUE COLISIONA
*            MULU.W  #ALNMPCOL,D1
*            ADD.W   D0,D1               ;D0 = COCIENTE(Y)*10+COCIENTE(X) 
*            LEA MAPDATA, A3
*            AND.B	#0,(A3,D1.W)

           	;ELIMINAR DISPARO SI TOCA ALIEN
                 
.DONE       MOVEM.W  (A7)+,D0-D3
            RTS

; ------------------------------------------------------------------------------
SHTPLOT
; PLOT THE SHOOT.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D4,-(A7)
            ;ESTABLECER COLOR CONTORNO
            SET_PEN_COLOR	#SHTPNCLR            
            ;ESTABLECER COLOR RELLENO
            SET_FILL_COLOR	#SHTFLCLR
          
		  ;DIBUJAR DISPARO (RECTANGULO)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            SUB.W   #SHTWIDTH/2,D1
            MOVE.W  D1,D3
            ADD.W   #SHTWIDTH,D3
            ADD.W   #SHTHEIGH/2,D2   
            MOVE.W  D2,D4
            SUB.W   #SHTHEIGH,D4
            MOVE.B  #87,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS        











































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
