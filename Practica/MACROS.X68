; ==============================================================================
; MACROS
; ==============================================================================


; ------------------------------------------------------------------------------
REPRODUCE_SND		MACRO
; REPRODUCE EL SONIDO PASA COMO ARGUEMNTO 1 
;MODIFICA: D7
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: REPRODUCE_SND REQUIRES 1 ARGUMENT(SOUND IDENTIFIER)
            MEXIT
            ENDC
            
		    MOVE.B	\1,D7
			TRAP	#SNDPLTN 
			ENDM	
			
; ------------------------------------------------------------------------------
PRINT		MACRO
; IMPRIME UNA CADENA DE TEXTO USANDO LA SUBRUTINA UTLPRINT
; ------------------------------------------------------------------------------
            
            IFNE    NARG-2
            FAIL    ERROR: PRINT REQUIRES 2 ARGUMENTS(TEXT & LINE)
            MEXIT
            ENDC
			MOVEM.L  D0/A0,-(A7)
            LEA     \1,A0
            MOVE.B  \2,D0
            JSR     UTLPRINT
            
            MOVEM.L (A7)+,D0/A0
            ENDM

; ------------------------------------------------------------------------------
TEXT_COLOR     MACRO
; DEFINE EL COLOR DE TEXTO USANDO TASCA 21
; INPUT    - \1 COLOR EN FORMATO $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2
; ------------------------------------------------------------------------------
           	IFNE    NARG-1
            FAIL    ERROR: TEXT_COLOR REQUIRES 1 ARGUMENT(COLOR)
            MEXIT
            ENDC

			MOVEM.L  D0-D2,-(A7)
            
            MOVE.B  #21,D0
            MOVE.L  \1,D1
            MOVE.L  #$01090000,D2	;FIXEDSYS, SIZE =9
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D2
            ENDM
            
; ------------------------------------------------------------------------------
PRINT_TEXT		MACRO
; MUESTRA POR PANTALLA UN CADENA Y UNA VARIABLE
; INPUT    : \1 CADENA DE TEXTO
;			 \2	VARIABLE				
; ------------------------------------------------------------------------------
			IFNE    NARG-2
            FAIL    ERROR: PRINT_TEXT REQUIRES 2 ARGUMENTS(TEXT & NUMERIC VALUE)
            MEXIT
            ENDC
	
		    MOVEM.L	D0-D1/A1,-(A7)
		
		    MOVE.B  #17,D0
            LEA     \1,A1
            MOVE.W  \2,D1
            TRAP    #15

		    MOVEM.L (A7)+,D0-D1/A1
    	    ENDM

; ------------------------------------------------------------------------------
SET_POS		MACRO
; SITUA EL CURSOR PARA ESCRIBIR
; INPUT    : \1 NUMERO DE LINEA
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: SET_POS REQUIRES 1 ARGUMENT(POSITION)
            MEXIT
            ENDC
	
		    MOVEM.L	D0-D1,-(A7)
		    
		    MOVE.B	#11,D0	
		    MOVE.W	\1,D1
		    TRAP	#15
		    
		    MOVEM.L (A7)+,D0-D1
    	    ENDM

; ------------------------------------------------------------------------------
SET_PEN_COLOR	MACRO
; ACTIVA EL COLOR DE CONTORNO PARA DIBUJADO.
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: SET_PEN_COLOR REQUIRES 1 ARGUMENT(COLOR)
            MEXIT
            ENDC
            MOVEM.L	D0-D1,-(A7)
    
            MOVE.B  #80,D0
            MOVE.L  \1,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            ENDM

; ------------------------------------------------------------------------------
SET_FILL_COLOR	MACRO
; ACTIVA EL COLOR DE RELLENO PARA DIBUJADO.
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR EN D1
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: SET_FILL_COLOR REQUIRES 1 ARGUMENT(COLOR)
            MEXIT
            ENDC
            MOVEM.L	D0-D1,-(A7)
    
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            ENDM
            
; ------------------------------------------------------------------------------
WAIT_TIME	MACRO
; ESPERAR HASTA 1 SEGUNDO DEPENDIENDO DEL VALOR QUE PASAS A D1
; INPUT    : \1 TIEMPO EN CENTISEGUNDOS (100 ES UN SEGUNDO)
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: WAIT_TIME REQUIRES 1 ARGUMENT(TIME)
            MEXIT
            ENDC
            MOVEM.L D0-D1,-(A7)
            
            MOVE.B  #23,D0
            MOVE.L  \1,D1                         
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            ENDM

; ------------------------------------------------------------------------------
PLOT_FINAL_SCREEN	MACRO
; MUESTRA LA PANTALLA FINAL (VICTORIA O DERROTA)
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR EN D1
; ------------------------------------------------------------------------------
			IFNE    NARG-1
            FAIL    ERROR: PLOT_FINAL_SCREEN REQUIRES 1 ARGUMENT(COLOR)
            MEXIT
            ENDC
            MOVEM.L D0-D4/A0-A2,-(A7)
            
            ;ESTABLECE COLOR TEXTO
            TEXT_COLOR   \1
            
            ;CARGAR LISTA DE TEXTOS
            CLR.B   D3                  ;CONTADOR
            LEA     .TXTLIST,A2         ;CARGAR LISTA
.LOOP       MOVE.L  (A2)+,D2            ;GUARDAR REGISTRO Y PASAR SIGUIENTE
            BEQ     .DONE               ;MIRAR SI ES 0
            
            ;MIRAR EN QUÉ MARCADOR ESTAMOS
            CMP.B   #0,D3
            BEQ     .POS1               ;SALTA MARCADOR 1
            CMP.B   #1,D3
            BEQ     .POS2               ;SALTA MARCADOR 2
            CMP.B   #2,D3
            BEQ     .POS3               ;SALTA MARCADOR 3
            
            ;MOVER A DICHO MARCADOR
.POS1       MOVE.B  #12,D0
            BRA     .SINNUM        
.POS2       MOVE.W  #FINALSCO,D1    
            MOVE.W  (SCOPOINT),D4       ;PUNTUACIÓN   
            BRA     .CONNUM     
.POS3       TEXT_COLOR  #BLANCO         ;CAMBIA COLOR
            MOVE.B  #25,D0
            BTST.B  #4,(SCRCYCCT)       ;PARPADEA EL TEXTO
            BEQ     .DONE
            
            ;IMPRIMIR TEXTO
.SINNUM     MOVE.L  D2,A0
            JSR     UTLPRINT
            BRA     .CONT
            
            ;ESTABLECER RESULTADO JUNTO A NÚMERO
.CONNUM     MOVE.B  #11,D0
            TRAP    #15                 ;ESTABLECE POSICIÓN DE TEXTO EN PANTALLA
            MOVE.L  D2,A1               ;.TXT EN A1
            MOVE.W  D4,D1               ;RESTAURAR REGISTROS PARA HACER TRAP
            MOVE.B  #17,D0
            TRAP    #15                 ;MOSTRAR RESULTADO
            
            ;SEGUIR BUCLE
.CONT       ADDQ.B  #1,D3               ;ACTUALIZO CONTADOR
            BRA     .LOOP
              
.DONE       MOVEM.L (A7)+,D0-D4/A0-A2
            ENDM










