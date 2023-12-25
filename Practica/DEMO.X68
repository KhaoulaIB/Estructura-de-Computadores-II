; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
DEMINIT
; DEMO INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     DMMINIT
            JSR     FILINIT
            JSR     TNKINIT
            JSR     ALNINIT 
            BRA     SCOINIT

; ------------------------------------------------------------------------------
DEMUPD
; DEMO UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     FILUPD
            JSR     AGLUPD
            JSR     ALNUPD
            
            ;EN CUALQUIER MOMENTO SE PUEDE PASAR AL SIGUIENTE ESTADO
            BTST.B  #0,(KBDEDGE)        ;SI PULSA KEY DOWN
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)        ;PASA AL JUEGO
            BRA     .DONE
.CONT       BTST.B  #4,(KBDEDGE)        ;SI PULSA EL ESPACIO
            BEQ     .DONE
            CLR.W   (STANEXT)           ;PASA A LA INTRO
.DONE       RTS

; ------------------------------------------------------------------------------
DEMPLOT
; DEMO PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            JSR 	AGLPLOT
            JSR     TNKPLOT
            JSR     ALNPLOT
       		JSR     SCOPLOT

            ;MOSTRAR LAS LÍNEAS PARA PASAR AL SIGUIENTE ESTADO
            SET_FILL_COLOR	#STAFLCLR
            
            LEA     .TXT1,A0
            MOVE.B  #1,D0
            JSR     UTLPRINT
            
            LEA     .TXT2,A0
            JSR     UTLPRINT           
            
.DONE       MOVEM.L (A7)+,D0-D1/A0
            RTS
.TXT1       DC.B    'PRESS SPACE TO RETURN TO THE INTRO',0
.TXT2       DC.B    'PRESS KEY DOWN TO START THE GAME',0
            DS.W    0







            


            



