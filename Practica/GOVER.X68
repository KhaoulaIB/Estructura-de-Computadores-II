; ==============================================================================
; GAME OVER SCREEN
; ==============================================================================
   

; ------------------------------------------------------------------------------
GOVINIT
; GAME OVER SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
			MOVE.B	#SNDGOV,D7
			TRAP	#SNDPLTN
			RTS
; ------------------------------------------------------------------------------
GOVUPD
; GAME OVER SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #0,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       RTS

; ------------------------------------------------------------------------------
GOVPLOT
; GAME OVER SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT   
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
              
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'GAME OVER',0
.TXT2       DC.B    'PRESS KEY DOWN TO CONTINUE',0
            DS.W    0









*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
