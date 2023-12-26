; =============================================================================
; TÍTULO     : PRÁCTICA 1
; CREADO POR : KHAOULA IKKENE & ADRIÁN RUIZ VIDAL
; FECHA      : EMPEZADO DESDE PRIMERA SEMANA 
; DESCRIPCIÓN: JUEGO SPACE INVADERS
; =============================================================================
   
            ORG     $1000
        
            INCLUDE "SYSCONST.X68"
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "MACROS.X68"		    
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
            
            ;INICIALIZACIONES
            JSR     SYSINIT
            JSR     UTLINIT
            JSR     STAINIT
              
.LOOP
            TRAP    #1
            
            ;ACTUALIZA ESTADO ACTUAL         
            JSR     STAUPD
            
            ;SINCRONIZA
.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
            ;DIBUJA ESTADO ACTUAL
            JSR 	STAPLOT
             
            ;ACTUALIZA DOUBLE BUFFER
            TRAP    #0  
            
            BRA     .LOOP
.DONE    
            SIMHALT
      
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
 
            END    START      


























































































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
