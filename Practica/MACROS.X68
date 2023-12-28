; ==============================================================================
; MACROS
; ==============================================================================

;------------------------------------------------------------------------------
QUIT_SOUND    MACRO
; DESHABILITA EL SONIDO ANTERIOR
; MODIFICA : D0,D1,D2
;------------------------------------------------------------------------------
            MOVEM.L    D0-D2,-(A7)

            MOVE.B  #76,D0
            MOVE.B  D7,D1 
            MOVE.L  #2,D2
            TRAP    #15

            MOVEM.L    (A7)+,D0-D2
            ENDM

;------------------------------------------------------------------------------
PRINT		MACRO
; DEFINE EL COLOR DE TEXTO USANDO TASCA 21
;INPUT:	\1	CADENA DE TEXTO
;		\2	LINEA DONDE ESCRIBIR	
;MODIFICA D0, D1
; -----------------------------------------------------------------------------
            MOVEM.L  D0/A0,-(A7)
            
            LEA     \1,A0
            MOVE.B  \2,D0
            JSR     UTLPRINT
            MOVEM.L (A7)+,D0/A0
            ENDM

;------------------------------------------------------------------------------
TEXT_COLOR     MACRO
; DEFINE EL COLOR DE TEXTO USANDO TASCA 21
; INPUT    - \1 COLOR EN FORMATO $00BBGGRR
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D2,-(A7)
            
            MOVE.B  #21,D0
            MOVE.L  \1,D1
            MOVE.L  #$01090000,D2	;FIXEDSYS, SIZE =9
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D2
            ENDM
;------------------------------------------------------------------------------
PRINT_TEXT		MACRO
; MUESTRA POR PANTALLA UN CADENA Y UNA VARIABLE
; INPUT    : \1 CADENA DE TEXTO
;			 \2	VARIABLE
;OUTPUT		: NONE				
; ;MODIFICA : D0,D1
;------------------------------------------------------------------------------	
		MOVEM.L	D0-D1/A1,-(A7)
		
		 MOVE.B  #17,D0
         LEA     \1,A1
         MOVE.W  \2,D1
         TRAP    #15

		MOVEM.L (A7)+,D0-D1/A1
    	ENDM


;------------------------------------------------------------------------------
SET_POS		MACRO
; SITUA EL CURSOR PARA ESCRIBIR
; INPUT    : \1 NUMERO DE LINEA
; ;MODIFICA : D0,D1
;------------------------------------------------------------------------------	
		
		MOVEM.L	D0-D1,-(A7)
		MOVE.B	#11,D0	;NUMERO DE LA TASCA
		MOVE.W	\1,D1
		TRAP	#15
		MOVEM.L (A7)+,D0-D1
    	ENDM

;------------------------------------------------------------------------------
SET_PEN_COLOR	MACRO
; ACTIVA EL COLOR DE CONTORNO PARA DIBUJADO.
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR
; MODIFICA : D0,D1
;------------------------------------------------------------------------------
    MOVEM.L	D0-D1,-(A7)
    
    MOVE.B  #80,D0
    MOVE.L  \1,D1
    TRAP    #15
            
    MOVEM.L (A7)+,D0-D1
    ENDM

;------------------------------------------------------------------------------
SET_FILL_COLOR	MACRO
; ACTIVA EL COLOR DE RELLENO PARA DIBUJADO.
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR EN D1
; MODIFICA : D0,D1
;------------------------------------------------------------------------------
    MOVEM.L	D0-D1,-(A7)
    
    MOVE.B  #81,D0
    MOVE.L  \1,D1
    TRAP    #15
            
    MOVEM.L (A7)+,D0-D1
    ENDM





