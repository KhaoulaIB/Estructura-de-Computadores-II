*-----------------------------------------------------------
* Title    : SCORE CLASS
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
SCOINIT
; INITIALIZE THE SCORE
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            CLR.W   (SCOPOINT)
        
            RTS
 
; ------------------------------------------------------------------------------
SCOPLOT
; PLOT THE SCORE.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : D0-D1/A1
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D1/A1,-(A7)
            
	     SET_FILL_COLOR #SCOFLCLR
            
            ;ESTABLECER POSICIÓN
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE,D1
            TRAP    #15
            
            ;MOSTRAR SCORE
            MOVE.B  #17,D0
            LEA     .TXT,A1
            MOVE.W  (SCOPOINT),D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS

.TXT        DC.B    'PUNTUACION:',0        





*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
