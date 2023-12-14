*-----------------------------------------------------------
* Title    : FPS CLASS
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
FPSINIT
; INITIALIZE THE FPS.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            CLR.W   (REALFPS)
        
            RTS
 
; ------------------------------------------------------------------------------
FPSPLOT
; PLOT THE FPS SCOREBOARD.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            MOVEM.L D0-D1/A1,-(A7)
            
            ;ESTABLECER COLOR RELLENO
            SET_FILL_COLOR	#FPSFLCLR
            
            ;ESTABLECER POSICIÓN 1
            MOVE.B  #11,D0
            MOVE.W  #FPSLINE1,D1
            TRAP    #15
            
            ;MOSTRAR SCORE 1
            MOVE.B  #17,D0
            LEA     .TXT1,A1
            MOVE.W  #SCRFPS,D1
            TRAP    #15
            
            ;ESTABLECER POSICIÓN 2 
            MOVE.B  #11,D0
            MOVE.W  #FPSLINE2,D1
            TRAP    #15
            
            ;MOSTRAR SCORE 2
            MOVE.B  #17,D0
            LEA     .TXT2,A1
            MOVE.W  (REALFPS),D1
            TRAP    #15
            
            ;ESTABLECER POSICIÓN 3 
            MOVE.B  #11,D0
            MOVE.W  #FPSLINE3,D1
            TRAP    #15
            
            ;MOSTRAR SCORE 3
            MOVE.B  #14,D0
            LEA     .TXT3,A1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS

.TXT1       DC.B    'GOAL:',0
.TXT2       DC.B    'FPS - ACTUAL:',0
.TXT3       DC.B    'FPS',0



*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
