; ==============================================================================
; GESTIÓN DEL JUEGO
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INICIALIZA JUEGO
; ------------------------------------------------------------------------------
            JSR     DMMINIT
            JSR     TNKINIT
            JSR     ALNINIT 
            BRA     SCOINIT

; ------------------------------------------------------------------------------
GAMUPD
; ACTUALIZA EL JUEGO. COMPRUEBA EL TECLADO. COMPRUEBA VICTORIA/DERROTA Y PASA 
; AL SIGUIENTE ESTADO
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A1-A3,-(A7)

            ;AÑADIR DISPARO SI TECLADO = "UP" 
		    BTST.B	#2,(KBDEDGE)
			BEQ		.GOUPD
			LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #1,D0
           	JSR     AGLADD
           	ADDQ.W  #1,(SCOSHOOT)

.GOUPD      ;UPDATES
            JSR     AGLUPD 
            JSR     TNKUPD
            JSR     ALNUPD
            
            ;COMPROBAR SI HA GANADO
            CMP.W   #SCOWIN,(SCOPOINT)
            BLT     .NEXT
            MOVE.W  #3,(STANEXT)                ;PASAR A ESTADO VICTORIA
            BRA     .DONE
            
            ;COMPROBAR SI HA PERDIDO
.NEXT       MOVE.W  (ALNPOSY),D1
            ADD.W   #ALNDIM*ALNMPROW,D1         ;D1 = ALNPOSY+ALNDIM*ALNMPROW
            CMP.W   #TNKPOSY,D1                 ;COMPARAR CON POS(Y) TANQUE
            BLT     .DONE
            MOVE.W  #4,(STANEXT)                ;PASAR A ESTADO DERROTA

.DONE       MOVEM.L (A7)+,D0-D1/A1-A3    
            RTS  

; ------------------------------------------------------------------------------
GAMPLOT
; MUESTRA EL JUEGO EN PANTALLA
; ------------------------------------------------------------------------------
            JSR     AGLPLOT
            JSR     TNKPLOT
            JSR     ALNPLOT
       		BRA     SCOPLOT











*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
