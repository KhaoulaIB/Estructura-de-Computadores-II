; ==============================================================================
; CLASE SISTEMA
; ==============================================================================
; ------------------------------------------------------------------------------
SYSINIT
; INICIALIZA EL SISTEMA
; ------------------------------------------------------------------------------
            ;INSTALAR TRAPS E INTERRUPCIONES
            MOVE.L  #SCRPLOT,($80+4*SCRUPTN)
            MOVE.L  #KBDUPD,($80+4*KBDUPTN)
            MOVE.L	#SNDPLAY,($80+4*SNDPLTN)
            MOVE.L  #SCRTIM,($60+4*SCRINTN)
	
            JSR SCRINIT
            JSR KBDINIT
            JSR	SNDINIT
	
	        ;PASAR A MODO USUARIO Y HABILITAR INTERRUPCIONES
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)
            
            RTE      

; ------------------------------------------------------------------------------
SNDINIT
; INICIALIZA SISTEMA DE SONIDO
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A1,-(A7)
            
            CLR.B   D1
            LEA     .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1
            BRA     .LOOP
            
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
            
.SNDCOL    	DC.B    'SND/collision.wav',0
.SNDINT     DC.B    'SND/intro.wav',0
.SNDWIN		DC.B	'SND/win.wav',0
.SNDGOV		DC.B	'SND/gover.wav',0	
.SNDLIST    DC.L    .SNDCOL,.SNDINT,.SNDWIN,.SNDGOV,0

; ------------------------------------------------------------------------------
SNDPLAY
; REPRODUCE EL SONIDO QUE SE LE PASA AL REGISTRO D7.
; ENTRADA  : ID SONIDO (D7)
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            ;REPRODUCE EL SONIDO
            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTE   
; ------------------------------------------------------------------------------
SCRINIT
; INICIALIZA LA PANTALLA. DEFINE LA RESOLUCIÓN DE PANTALLA. MUESTRA PANTALLA EN
; MODO VENTANA. HABILITA DOBLE BUFFER.
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)

            ;DEFINE LA RESOLUCIÓN
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15

            ;MUESTRA EN MODO VENTANA
            MOVE.L  #1,D1
            TRAP    #15
            
            ;VACÍA PANTALLA
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ;HABILITA DOBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ;HABILITA INTERRUPCIÓN TEMPORIZADA
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$81,D2
            MOVE.L  #1000/SCRFPS,D3
            TRAP    #15
            
            ;INICIALIZA CONTADOR DE INTERRUPCIONES
            CLR.B   (SCRINTCT)
            
            MOVEM.L (A7)+,D0-D1
            RTS

; ------------------------------------------------------------------------------
SCRPLOT
; ACTUALIZA DOBLE BUFFER
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            ;CAMBIA BUFFERS
            MOVE.B  #94,D0
            TRAP    #15

            ;VACÍA BUFFER OCULTO
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM
; ACTUALIZA CONTADORES
; ------------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)
            RTE

 
 ; ------------------------------------------------------------------------------
KBDINIT
; INICIALIZA LAS VARIABLES DE TECLADO
; ------------------------------------------------------------------------------           
            CLR.B (KBDVAL)
            CLR.B (KBDEDGE)
            RTS

 ; ------------------------------------------------------------------------------
KBDUPD
; ACTUALIZA EL TECLADO EN ESTE ORDEN:
; KBDFIRE3 : BIT 7   
; KBDFIRE2 : BIT 6   
; KBDFIRE1 : BIT 5
; KBDSPACE : BIT 4
; KBDLEFT  : BIT 3   
; KBDUP    : BIT 2   
; KBDRIGHT : BIT 1
; KBDDOWN  : BIT 0
; ------------------------------------------------------------------------------   
            MOVEM.L D0-D3,-(A7)
            
            ;LEE PRIMERA PARTE (BITS 4-7)
            MOVE.B  #19,D0
            MOVE.L  #KBDFIRE3<<24|KBDFIRE2<<16|KBDFIRE1<<8|KBDPAUSE,D1
            TRAP    #15
            
            JSR     .PACK
            
            ;LEE SEGUNDA PARTE (BITS 0-3)
            MOVE.L  #KBDLEFT<<24|KBDUP<<16|KBDRIGHT<<8|KBDDOWN,D1
            TRAP    #15

            JSR     .PACK
            
            ;DEFINIR VARIABLES DE TECLADO
            MOVE.B  (KBDVAL),D0
            NOT.B   D0
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            MOVE.B  D2,(KBDVAL)
            
            MOVEM.L (A7)+,D0-D3
            RTE
            
            ;CONVIERTE A FORMATO DESEADO
.PACK       MOVE.W  #3,D3
.LOOP       LSL.L   #8,D1
            ROXL.B  #1,D2
            DBRA.W  D3,.LOOP
            RTS




















