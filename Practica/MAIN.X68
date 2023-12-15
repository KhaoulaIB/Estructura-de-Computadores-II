*-----------------------------------------------------------
* Title      : PRÁCTICA 1
* Written by :KhAOULA IKKENE & ADRIAN RUIZ VIDAÑ
* Date       :STARTED IT THE FIRST WEEK 
* Description: SPACE INVADERS GAME
*-----------------------------------------------------------
   
            ORG     $1000
        
            INCLUDE "SYSCONST.X68"
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "MACROS.X68"		    ;EL ORDEN IMPORTA
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "TANK.X68"
            INCLUDE "ALIEN.X68"
            INCLUDE "SHOT.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "FPS.X68"          
            
START
            ORI.W   #$0700,SR
            
            ;INITS
            JSR     SYSINIT
            JSR     UTLINIT
            JSR     TNKINIT
            JSR     ALNINIT
            JSR     DMMINIT 
            JSR     SCOINIT
            JSR     FPSINIT
            JSR 	MAPPLOT
              
.LOOP
            TRAP    #1
            
            
			;AÑADIR DISPARO SI TECLADO = "UP" 
			BTST.B	#2,(KBDEDGE)
			BEQ		.GOUPD
			LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #1,D0
           	JSR     AGLADD

.GOUPD      ;UPDATES
            JSR     AGLUPD
            JSR     TNKUPD
            JSR     ALNUPD
            
            ;SYNC
.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
            ;PLOTS
            JSR 	AGLPLOT
            JSR     TNKPLOT
            JSR     ALNPLOT
       		JSR     SCOPLOT
            JSR     FPSPLOT
             
            ;UPDATE DOUBLE BUFFER
            TRAP    #0  
            
            BRA     .LOOP
.DONE    
           SIMHALT
      
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
 
            END    START      






























































