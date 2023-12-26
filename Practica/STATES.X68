; =============================================================================
; GESTIÓN DE ESTADOS
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INICIALIZA LAS VARIABLES DE GESTIÓN DE ESTADOS
; -----------------------------------------------------------------------------
            MOVE.W  #STANONE,(STACUR)
            CLR.W   (STANEXT)
            RTS

; -----------------------------------------------------------------------------
STAUPD
; ACTUALIZA LA GESTIÓN DE ESTADOS
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ;REALIZA EL INIT 
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ;SI NO, REALIZA EL UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            
            MOVEM.L (A7)+,D0/A0
            RTS
            
.INITBL     DC.L    INTINIT,DEMINIT,GAMINIT,WININIT,GOVINIT
.UPDTBL     DC.L    INTUPD,DEMUPD,GAMUPD,WINUPD,GOVUPD

; -----------------------------------------------------------------------------
STAPLOT
; DIBUJA EL ESTADO ACTUAL
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            
            MOVEM.L (A7)+,D0/A0
            RTS
            
.PLTTBL     DC.L    INTPLOT,DEMPLOT,GAMPLOT,WINPLOT,GOVPLOT

; -----------------------------------------------------------------------------
STAEMPTY
; SUBRUTINA QUE FUNCIONA COMO ESTADO VACÍO. NO HACE NADA.
; -----------------------------------------------------------------------------
            RTS














*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
