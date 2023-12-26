; ==============================================================================
; MACROS
; ==============================================================================
	
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
; INPUT    : \1 COLOR EN FORMATO $00BBGGRR
; MODIFICA : D0,D1
;------------------------------------------------------------------------------
    MOVEM.L	D0-D1,-(A7)
    
    MOVE.B  #81,D0
    MOVE.L  \1,D1
    TRAP    #15
            
    MOVEM.L (A7)+,D0-D1
    ENDM



*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
