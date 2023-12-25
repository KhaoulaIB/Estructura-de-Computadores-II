*-----------------------------------------------------------
* Title      : PRÁCTICA 1
* Written by : KHAOULA IKKENE & ADRIÁN RUIZ VIDAL
* Date       : STARTED IT THE FIRST WEEK 
* Description: SPACE INVADERS GAME
*-----------------------------------------------------------
   
            ORG     $1000
        
            INCLUDE "SYSCONST.X68"
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "MACROS.X68"		    ;EL ORDEN IMPORTA
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "TANK.X68"
            INCLUDE "ALIEN.X68"
            INCLUDE "SHOT.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "FILE.X68"
            INCLUDE "STATES.X68"
            INCLUDE "INTRO.X68" 
            INCLUDE "DEMO.X68"  
            INCLUDE "GAME.X68"
            INCLUDE "WIN.X68"
            INCLUDE "GOVER.X68"            
            
START
            ORI.W   #$0700,SR
            
            ;INITS
            JSR     SYSINIT
            JSR     UTLINIT
            JSR     STAINIT
              
.LOOP
            TRAP    #1
            
            ;UPDATE CURRENT STATE         
            JSR     STAUPD
            
            ;SYNC
.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
            ;PLOT CURRENT STATE
            JSR 	STAPLOT
             
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


















































































