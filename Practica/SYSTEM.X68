*-----------------------------------------------------------
* Title    : SYSTEM 
*-----------------------------------------------------------
; ------------------------------------------------------------------------------
SYSINIT
; INIT SYSTEM: SET SCREEN RESOLUTION AND WINDOWED MODE.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            JSR SCRINIT
            JSR KBDINIT

            ;INSTALAR TRAPS Y INTERRUPCIONES
            MOVE.L  #SCRPLOT,($80)
            MOVE.L  #KBDUPD,($84)
            MOVE.L  #SCRTIM,($64)
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)
            
            RTE
            
; ------------------------------------------------------------------------------
SCRINIT
; INIT SYSTEM: SET SCREEN RESOLUTION AND WINDOWED MODE.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)

            ;SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15

            ;SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ;CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ;ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ; ENABLE TIMED INTERRUPT
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$81,D2
            MOVE.L  #1000/SCRFPS,D3
            TRAP    #15
            
            ; CLEAR INTERRUPT COUNTER
            CLR.B   (SCRINTCT)
            
            MOVEM.L (A7)+,D0-D1
            RTS

; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.W D0-D1,-(A7)
            
            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15

            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)
            RTE

 
 ; ------------------------------------------------------------------------------
KBDINIT
; INIT THE KEYBOARD 
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            CLR.B (KBDVAL)
            CLR.B (KBDEDGE)
            
            RTS

 ; ------------------------------------------------------------------------------
KBDUPD
; UPDATE THE KEYBOARD IN THIS ORDER:
; KBDPAUSE  : BIT 7   
; KBDFIRE3    : BIT 6   
; KBDFIRE2 : BIT 5
; KBDFIRE1  : BIT 4
; KBDLEFT  : BIT 3   
; KBDUP    : BIT 2   
; KBDRIGHT : BIT 1
; KBDDOWN  : BIT 0
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D3,-(A7)
            
            ;BITS 4-7
            ; READ FIRST PART
            MOVE.B  #19,D0
            MOVE.L  #KBDPAUSE<<24|KBDFIRE3<<16|KBDFIRE2<<8|KBDFIRE1,D1
            TRAP    #15
            
            JSR     .PACK
            
            ;BITS 0-3
            ; READ SECOND PART
            MOVE.L  #KBDLEFT<<24|KBDUP<<16|KBDRIGHT<<8|KBDDOWN,D1
            TRAP    #15

            ; CONVERT TO DESIRED FORMAT
            JSR     .PACK
            
            ;COMPUTE KBDEDGE
            MOVE.B  (KBDVAL),D0
            NOT.B   D0
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            
            MOVE.B  D2,(KBDVAL)
            
            MOVEM.L (A7)+,D0-D3
            RTE
            
.PACK       MOVE.W  #3,D3
.LOOP       LSL.L   #8,D1
            ROXL.B  #1,D2
            DBRA.W  D3,.LOOP
            RTS

; ------------------------------------------------------------------------------
SYSUPD
; UPDATES THE SYSTEM 
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            RTS

; ------------------------------------------------------------------------------
SYSPLOT
; PLOT THE SYSTEM.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    
            RTS











