; ==============================================================================
; CLASE FICHERO (SE USA PARA LA DEMO)
; ==============================================================================

; ------------------------------------------------------------------------------
FILINIT
; INICIALIZA EL FICHERO (DEMO)
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)
            
            ;ABRIR EL FICHERO
            MOVE.B  #51,D0
            LEA     .FILE,A1
            TRAP    #15  
            
.DONE       MOVEM.L (A7)+,D0/A1
            RTS

.FILE       DC.B    'FIC/fichero.txt',0
            DS.W    0    

; ------------------------------------------------------------------------------
FILUPD
; LEE FICHERO ENTERO Y ACTUALIZA MOVIMIENTOS/DISPARO (DEMO)
; ------------------------------------------------------------------------------
            MOVEM.L D2/A1,-(A7)
            MOVEM.W D0-D1,-(A7)
            
            ;PONE FICHERO EN REGISTRO
            MOVE.B  #53,D0
            MOVE.L  #1,D2
            LEA     .BUFFER,A1
            TRAP    #15
            
            ;LEER EL FICHERO BIT A BIT Y PASARLO A NÚMERO REAL
            SUB.B   #$30,(A1)               ;CONVERTIR ASCII A REAL
            MOVE.B  (A1),D1
            TST.B   D1                      ;FICHERO ACABA EN 0
            BEQ     .DONE
            ADDQ.L  #1,A1                   ;PASA A SIGUIENTE BIT
            
            ;ESPERAR 10 ms ENTRE UNA ACCIÓN Y LA SIGUIENTE
            WAIT_TIME   #1
            
            ;MIRAR QUÉ BIT ES
            CMP.B   #1,D1
            BNE     .NEXT1
            JSR     TNKRIGHT                ;MOVER TANQUE DERECHA SI BIT = 1
            BRA     .DONE
         
.NEXT1      CMP.B   #3,D1
            BNE     .NEXT2
            JSR     TNKLEFT                 ;MOVER TANQUE IZQUIERDA SI BIT = 3
            BRA     .DONE
            
.NEXT2      CMP.B   #2,D1
            BNE     .DONE
            JSR     SHTADD                  ;AGREGAR DISPARO SI BIT = 2
            
.DONE       MOVEM.W (A7)+,D0-D1
            MOVEM.L (A7)+,D2/A1
            RTS  
            
.BUFFER     DS.B    1       
            DS.W    0

; ------------------------------------------------------------------------------
SHTADD
; AGREGA EL DISPARO (DEMO)
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            
            ;SHOT ES UNA CLASE DE TIPO AGENTE
            LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #1,D0                   ;NO PUEDE SER 0
            JSR     AGLADD                  ;AÑADIR DISPARO
            ADD.W   #1,(SCOSHOOT)           ;SUMA A LA PUNTUACIÓN
            
            MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
TNKRIGHT
; MUEVE TANQUE A LA DERECHA (DEMO)
; ------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            
            ;GUARDAR VARIABLE EN REGISTRO
            MOVE.W  (TNKPOSX),D0        
            
            ;MOVER TANQUE A LA DERECHA
            ADD.W   #TNKSPEED,D0       

            ;COMPROBAR COLISIÓN DERECHA
            CMP.W   #SCRWIDTH-TNKWIDTH,D0     
            BLE     .DONE
            MOVE.W  #SCRWIDTH-TNKWIDTH,D0     ;RESTA ANCHO DEL TANQUE     
            
            ;ACTUALIZAR VARIABLE
.DONE       MOVE.W  D0,(TNKPOSX)
            
            MOVE.W (A7)+,D0
            RTS
            
; ------------------------------------------------------------------------------
TNKLEFT
; MUEVE TANQUE A LA IZQUIERDA (DEMO)
; ------------------------------------------------------------------------------
            MOVE.W D0,-(A7)
            
            ;GUARDAR VARIABLE EN REGISTRO
            MOVE.W  (TNKPOSX),D0        
                     
            ;MOVER TANQUE A LA IZQUIERDA 
            SUB.W   #TNKSPEED,D0

            ;COMPROBAR COLISIÓN IZQUIERDA
            CMP.W   #0,D0
            BGE     .DONE
            CLR.W   D0       
            
            ;ACTUALIZAR VARIABLE
.DONE       MOVE.W  D0,(TNKPOSX)

            MOVE.W (A7)+,D0
            RTS












