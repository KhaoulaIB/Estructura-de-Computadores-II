; ==============================================================================
; GESTIÓN DE LA DEMO
; ==============================================================================

; ------------------------------------------------------------------------------
DEMINIT
; INICIALIZA LA DEMO
; ------------------------------------------------------------------------------
            JSR     DMMINIT
            JSR     FILINIT
            JSR     TNKINIT
            JSR     ALNINIT  
            BRA     SCOINIT

; ------------------------------------------------------------------------------
DEMUPD
; ACTUALIZA LA DEMO. PERMITE PASAR A OTRO ESTADO.
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
; MUESTRA LA DEMO. MUESTRA TEXTO PARA PASAR A SIGUIENTE ESTADO.
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            JSR 	AGLPLOT
            JSR     TNKPLOT
            JSR     ALNPLOT
       		JSR     SCOPLOT

            ;ESTABLECE COLOR RELLENO
            SET_FILL_COLOR	#STAFLCLR
            
            ;IMPRIME LINEAS DE TEXTO PARA PASAR A SIGUIENTE ESTADO
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







            


            






*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
