*-----------------------------------------------------------
* Title      : GAME CONSTANTS
*-----------------------------------------------------------
*-----ALIEN RELATED CONSTANTS--------------------------------------------------------      
ALNFLCLR    EQU     $0000FF00   ;COLOR RELLENO ALIEN
ALNPNCLR    EQU     $0000AA00   ;COLOR CONTORNO ALIEN
ALNDIM      EQU     40          ;DIMENSIÓN CUADRADO MAPA ALIEN
ALNROW      EQU     10          ;FILAS DIBUJO ALIEN
ALNCOL      EQU     10          ;COLUMNAS DIBUJO ALIEN
ALNMPROW    EQU     3           ;FILAS MAPA ALIEN   
ALNMPCOL    EQU     10          ;COLUMNAS MAPA ALIEN
ALNIPOSX    EQU     120         ;INICIO POS X ALIENS
ALNIPOSY    EQU     80          ;INICIO POS Y ALIENS
ALNSPD1     EQU     8           ;VELOCIDAD ALIENS NIVEL 1 (NIVEL 3 ES EL DOBLE DE ESTE)
ALNSPD2     EQU     12          ;VELOCIDAD ALIENS NIVEL 2 (NIVEL 1 * 1,5 PARA QUE EL NIVEL SEA CRECIENTE LINEALMENTE)
ALNPIXEL    EQU     12           ;PIXELES BAJADA ALIENS (POSY)



*------TANK RELATED CONSTANTS--------------------------------------------------------
TNKFLCLR    EQU     $00FF0000   ;COLOR RELLENO TANQUE
TNKPNCLR    EQU     $00AA0000   ;COLOR CONTORNO TANQUE
TNKWIDTH    EQU     72          ;ANCHO TANQUE (DIMENSIÓN * COLUMNAS)
TNKWIDHA    EQU     36          ;MITAD ANCHO TANQUE (DIMENSIÓN * COLUMNAS)/2
TNKSQUWI    EQU     8           ;DIMENSIÓN CUADRADO TANQUE 
TNKPOSY     EQU     416         ;POSICIÓN Y TANQUE (480-64)
TNKROW      EQU     6           ;FILAS MAPA TANQUE
TNKCOL      EQU     9           ;COLUMNAS MAPA TANQUE
TNKSPEED    EQU     8           ;VELOCIDAD TANQUE


*-----SHOOOT RELATED CONSTANTS-------------------------------------------------------
SHTFLCLR    EQU     $000000FF   ;COLOR RELLENO DISPARO
SHTPNCLR    EQU     $000000AA   ;COLOR CONTORNO DISPARO
SHTWIDTH    EQU     4           ;ANCHO DISPARO
SHTHEIGH    EQU     16          ;ALTURA DISPARO
SHTGAP      EQU     10          ;ESPACIO TANQUE Y DISPARO
SHTSPEED    EQU     10          ;VELOCIDAD DISPARO


*-----SCOREBOARD RELATED CONSTANTS---------------------------------------------------
SCOFLCLR    EQU     0           ;COLOR RELLENO MARCADOR
SCOLINE     EQU     $0101       ;COORDENADAS LINEA 1 IZQUIERDA
SCOLINE1    EQU     $4101       ;COORDENADAS LINEA 1 DERECHA
SCOLINE2    EQU     $4102       ;COORDENADAS LINEA 2 DERECHA

; --- STATE RELATED CONSTANTS --------------------------------------------------
STANONE     EQU     -1          ; NUMERO ESTADO NO EXISTENTE
STAFLCLR    EQU     $00000000   ; COLOR RELLENO ESTADOS        

; --- VICTORY/DEFEAT CONSTANTS -------------------------------------------------
SCOWIN      EQU     30          ; NUMBER OF SCOREBOARD TO VICTORY
;-----LEVELS---------------------------
;LEVELS NUMBER
NIVEL1	EQU	1
NIVEL2	EQU	2
NIVEL3	EQU	3	
NIVELCR	EQU	$00FFA500
DISPCLR	EQU	$0000FF66



















































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
