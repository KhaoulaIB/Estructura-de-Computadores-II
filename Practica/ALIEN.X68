*-----------------------------------------------------------
* Title     : ALIEN CLASS
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
ALNINIT
; INITIALIZE ALIEN
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  #ALNIPOSX,(ALNPOSX)
            MOVE.W  #ALNIPOSY,(ALNPOSY) 
            MOVE.W  #ALNSPEED,(ALNVELX)
            MOVE.W  #ALNSPEED,(ALNVELY) 
                    
            RTS

; ------------------------------------------------------------------------------
ALNUPD
; UPDATES THE ALIEN
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ;MOVIMIENTO ALIENS
            MOVEM.L D0-D7/A3,-(A7)
            
            ; UPDATE BALL COORDINATES
            MOVE.W  (ALNPOSX),D0
            MOVE.W  (ALNPOSY),D1
            SUB.W   (ALNVELX),D0
            
            ; CHECK HORIZONTAL COLLISIONS
            CMP.W   #SCRWIDTH-440,D0
            BGT     .COLRGT
            CMP.W   #40,D0
            BLT     .COLLFT
            BRA     .DONE
            
            ; RIGHT SIDE COLLISION
.COLRGT     ADD.W   (ALNVELY),D1
            NEG.W   (ALNVELX)
            MOVE.W  #SCRWIDTH-440,D0
            BRA     .DONE
            
            ; LEFT SIDE COLLISION
.COLLFT     ADD.W   (ALNVELY),D1
            NEG.W   (ALNVELX)
            MOVE.W  #40,D0
            
*			MULU.W	#ALNMPCOL,D6	    ;NUMERO DE ALIENS POR COLUMNA
*			ADD.W   D6,D4	            ;D4 CONTIENE EL INDICE DEL ALIEN
*			AND.L	#$0000FFFF,D4
*			;LEA	    MAPDATA, A3
*			;AND.B	#0,(A3,D4.W)
            
            ; STORE POSITION
.DONE       MOVE.W  D0,(ALNPOSX)
            MOVE.W  D1,(ALNPOSY)

            MOVEM.L (A7)+,D0-D7/A3
            RTS


;-----------------------DIBUJO ALIENS--------------------------------------------

ALNPLOT
;--------------------------------------------------------------------------------
;DIBUJA UNA CUADRICULA 3*10 PARA QUE HAYA UN ALIEN EN CADA UNA DE ELLAS.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
;--------------------------------------------------------------------------------
    
            MOVEM.L D0-D6/A2,-(A7)
            
            ;DEFINE COLORES
            SET_PEN_COLOR	#ALNPNCLR
            SET_FILL_COLOR	#ALNFLCLR
            
            LEA     MAPDATA,A2      
            
            ;CALCULAR COORDENADAS
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
            JSR     ALNPLOT1            ;DIBUJA ALIEN
.NEXT       MOVE.W  D3,D1
            ADD.W   #ALNDIM,D3
            DBRA.W  D5,.RLOOP
            MOVE.W  D4,D2
            ADD.W   #ALNDIM,D4
            DBRA.W  D6,.CLOOP

            MOVEM.L (A7)+,D0-D6/A2
            RTS   
 
MAPDATA     DC.B    1,1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1,1
            DC.B    1,1,1,1,1,1,1,1,1,1
            DS.W    0

; ------------------------------------------------------------------------------
ALNPLOT1
; DIBUJA EL ALIEN 
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D7/A1,-(A7)
            
            MOVE.W  D1,D7           ;GUARDA REGISTRO                       
            
            LEA     ALNDATA,A1
            MOVE.B  #87,D0
             
            MOVE.W  D2,D4
            ADD.W   #4,D4           ;POSICIÓN Y
            MOVE.W  #ALNROW-1,D6    ;FILAS ALIEN             

.CLOOP1     MOVE.W  D7,D1           ;RESTAURA REGISTRO
            MOVE.W  D1,D3
            ADD.W   #4,D3           ;POSICIÓN X    
            MOVE.W  #ALNCOL-1,D5    ;COLUMNAS ALIEN                   
.RLOOP1     TST.B   (A1)+
            BEQ     .NEXT1
            TRAP    #15
.NEXT1      MOVE.W  D3,D1
            ADD.W   #4,D3
            DBRA.W  D5,.RLOOP1
            MOVE.W  D4,D2
            ADD.W   #4,D4
            DBRA.W  D6,.CLOOP1

            MOVEM.L (A7)+,D0-D7/A1
            RTS

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











     







































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
