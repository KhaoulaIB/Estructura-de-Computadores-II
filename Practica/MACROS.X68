*-----------------------------------------------------------
* Title      :MACROS
* Written by :
* Date       :
* Description:PERFORMS SMALL TASKS 
*-----------------------------------------------------------


	
;..............................................................................
SET_PEN_COLOR	MACRO
; SETS THE PEN COLOR FOR DRAWING
; INPUT    : \1 COLOR IN $00BBGGRR FORMAT 
; OUTPUT   : NONE
; MODIFIES : D0,D1
;..............................................................................
    MOVEM.L	D0-D1,-(A7)
    
    MOVE.B  #80,D0
    MOVE.L  \1,D1
    TRAP    #15
            
    MOVEM.L (A7)+,D0-D1
    ENDM

;..............................................................................
SET_FILL_COLOR	MACRO
; SETS THE FILL COLOR FOR DRAWING
; INPUT    : \1 COLOR IN $00BBGGRR FORMAT 
; OUTPUT   : NONE
; MODIFIES : D0,D1
;..............................................................................
    MOVEM.L	D0-D1,-(A7)
    
    MOVE.B  #81,D0
    MOVE.L  \1,D1
    TRAP    #15
            
    MOVEM.L (A7)+,D0-D1
    ENDM

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
