;; Archivo:	ProyectoFinal1_Reloj.s
; Dispositivo:	PIC16F887
; Autor:	Saby Andrade
; Compilador:	pic-as (v2.30), MPLABX V5.40
;
; Programa:	Reloj Digital que posee 4 modos:
		;Hora
		;Fecha
		;Alarma
		;Timer
 
    
; Hardware:	Los componentes se encontrarán:
		;Puerto D Transistores 2N222
		
		;Puerto B Botones
		; Puerto A Leds
		; Puerto C Display Cátodo de 7 Segmentos

; Creado:	20 De Marzo 2022
; Última Modificación: 21 febrero 2022

;Processador
PROCESSOR 16F887
		
;Librería
#include <xc.inc>
    
; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT ; Oscillator Selection bits (INTOSCIO oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
  CONFIG  PWRTE = ON            ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  MCLRE = OFF           ; RE3/MCLR pin function select bit (RE3/MCLR pin function is digital input, MCLR internally tied to VDD)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
  CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
  CONFIG  LVP = ON              ; Low Voltage Programming Enable bit (RB3/PGM pin has PGM function, low voltage programming enabled)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)
    
; ------- VARIABLES EN MEMORIA --------
PSECT udata_shr			; Memoria compartida
    Temp_W:		DS  1	;1Byte
    Temp_Status:	DS  1	;1Byte
    
PSECT udata_bank0		; Variables almacenadas en el banco 0
   //Ciclos
    Ciclo_Unidades_De_Segundos_:	DS  1	;1Byte
    Ciclo_Decenas_De_Segundos_:		DS  1	;1Byte
    Ciclo_Unidades_De_Minutos_:		DS  1	;1Byte
    Ciclo_Decenas_De_Minutos_:		DS  1	;1Byte
    Ciclo_Unidades_De_Horas_:		DS  1	;1Byte
    Ciclo_Decenas_De_Horas_:		DS  1	;1Byte
    Ciclo_Unidades_De_Dias_:		DS  1	;1Byte
    Ciclo_Decenas_De_Dias_:		DS  1	;1Byte
    Ciclo_Unidades_De_Meses_:		DS  1	;1Byte
    Ciclo_Decenas_De_Meses_:		DS  1	;1Byte
    Ciclo_Unidades_De_Segundos_Timer_:	DS  1	;1Byte
    Ciclo_Decenas_De_Segundos_Timer_:	DS  1	;1Byte
    Ciclo_Unidades_De_Minutos_Timer_:	DS  1	;1Byte
    Ciclo_Decenas_De_Minutos_Timer_:	DS  1	;1Byte
    Ciclo_Unidades_De_Minutos_Alarma_:	DS  1	;1Byte
    Ciclo_Decenas_De_Minutos_Alarma_:	DS  1	;1Byte
    Ciclo_Unidades_De_Horas_Alarma_:	DS  1	;1Byte
    Ciclo_Decenas_De_Horas_Alarma_:	DS  1	;1Byte
    
    //Cantidad
    Cantidad_De_Segundos_:		DS  1	;1Byte
    Cantidad_De_Segundos_Timer_:	DS  1	;1Byte
    Cantidad_De_Minutos_:		DS  1	;1Byte
    Cantidad_De_Minutos_Timer_:		DS  1	;1Byte
    Cantidad_De_Horas_:			DS  1	;1Byte
    Cantidad_De_Dias_:			DS  1	;1Byte
    Cantidad_De_Meses_:			DS  1	;1Byte
    Cantidad_De_Horas_Alarma_:		DS  1	;1Byte
    Cantidad_De_Minutos_Alarma_:	DS  1	;1Byte
    
    
    //Sistemas
    Sistema_Unidades_Segundos_:		DS  1	;1Byte
    Sistema_Decenas_Segundos_:		DS  1	;1Byte
    Sistema_Unidades_Minutos_:		DS  1	;1Byte
    Sistema_Decenas_Minutos_:		DS  1	;1Byte
    Sistema_Unidades_Horas_:		DS  1	;1Byte
    Sistema_Decenas_Horas_:		DS  1	;1Byte
    Sistema_Unidades_Dias_:		DS  1	;1Byte
    Sistema_Decenas_Dias_:		DS  1	;1Byte
    Sistema_Unidades_Meses_:		DS  1	;1Byte
    Sistema_Decenas_Meses_:		DS  1	;1Byte
    Sistema_Unidades_Segundos_Timer_:	DS  1	;1Byte
    Sistema_Decenas_Segundos_Timer_:	DS  1	;1Byte
    Sistema_Unidades_Minutos_Timer_:	DS  1	;1Byte
    Sistema_Decenas_Minutos_Timer_:	DS  1	;1Byte
    Sistema_Unidades_Minutos_Alarma_:	DS  1	;1Byte
    Sistema_Decenas_Minutos_Alarma_:	DS  1	;1Byte
    Sistema_Unidades_Horas_Alarma_:	DS  1	;1Byte
    Sistema_Decenas_Horas_Alarma_:	DS  1	;1Byte
    
    //Tiempo
    
    Tiempo_Segundos_:			DS  1	;1Byte
    Tiempo_Segundos_Timer_:		DS  1	;1Byte
    Tiempo_Minutos_:			DS  1	;1Byte
    Tiempo_Minutos_Timer_:		DS  1	;1Byte
    Tiempo_Minutos_Alarma_:		DS  1	;1Byte
    Tiempo_Horas_:			DS  1	;1Byte
    Tiempo_Horas_Alarma_:		DS  1	;1Byte
    Tiempo_Dias_:			DS  1	;1Byte
    Tiempo_Meses_:			DS  1	;1Byte

    //Contadores
    Conta_Dor_0_:			DS  1	;1Byte
    Conta_Dor_1_:			DS  1	;1Byte
    Conta_Dor_2_:			DS  1	;1Byte
    
    //Configuracion
    Bandera_Config:			DS  1	;1Byte
    Numero_Config:			DS  1	;1Byte
    Estado_Config:			DS  1	;1Byte
    
    Banderas:				DS  1	;1Byte
    Valor_De_Diez_:			DS  1	;1Byte
    Valor_De_Uno_:			DS  1	;1Byte

    Medio_0:				DS  1	;1Byte
    Estados_0:				DS  1	;1Byte

    Bandera_Alarma_0:			DS  1	;1Byte
    Bandera_Alarma_1:			DS  1	;1Byte
    Display_:				DS  1	;1Byte

PSECT resVect, class = CODE, abs, delta = 2
 ;-------------- vector reset ---------------
 ORG 00h			; Posicion 00h para el reset
 resVect:
    goto MAIN	;Va a MAIN

PSECT intVect, class = CODE, abs, delta = 2
ORG 004h				; posicion 0004h para interrupciones
;------- VECTOR INTERRUPCIONES ----------
 
PUSH:				; Se mueve la instruccion de la PC a pila
    MOVWF   Temp_W		; del registro W a la variable "Temp_W"	
    SWAPF   STATUS, W		; Swap de nibbles del STATUS y se almacena en el registro W
    MOVWF   Temp_Status    	; Rutina de interrupción
    
ISR:
    banksel INTCON
    BTFSC   T0IF		;Cambio de bandera en el timer0 No=0 Si=1. Salta al estar apagada
    CALL    Timer0_Interrup	;Se llama la subrutina de interrupcion del Timer0
    BTFSC   TMR1IF		;Se encuentra apagada la bandera de cambio en el Timer 1 se salta la línea, si está encendida lo analiza
    
    call    Timer1_Interrup	;Se llama la subrutina de interrupcion del Timer1
    BTFSC   TMR2IF		;Se encuentra apagada la bandera de cambio en el Timer 2 se salta la línea, si está encendida lo analiza
    
    call    Timer2_Interrup	;Se llama la subrutina de interrupcion del Timer2
    btfsc   RBIF		;Cambio de bandera en el Puerto B No=0 Si=1. Salta al estar apagada
    
    call    Interrup_PuertoB	;Se llama la subrutina de interrupcion del puerto B
    
POP:				; Se mueve la instrucción de la pila a la PC
    SWAPF   Temp_W, W		;Swap de nibbles de la variable "Temp_W" y se almacena en el registro W
    MOVWF   STATUS		;Se mueve el registro W a STATUS	
    SWAPF   Temp_W, F		;Swap de nibbles de la variable "Temp_W" y se almacena en la variable "Temp_W"
    SWAPF   Temp_W, W		;Swap de nibbles de la variable "Temp_W" y se almacena en el registro W
    RETFIE
 
    
;----------------------------------Tabla----------------------------------------
org 100h			//Posición de la tabla
Tabla: 
    clrf    PCLATH
    bsf	    PCLATH,0 ; PCLATH = 01
    andlw   0x0f
    addwf   PCL 
    retlw   00111111B ;0
    retlw   00000110B ;1
    retlw   01011011B ;2
    retlw   01001111B ;3
    retlw   01100110B ;4
    retlw   01101101B ;5
    retlw   01111101B ;6
    retlw   00000111B ;7
    retlw   01111111B ;8
    retlw   01101111B ;9
    retlw   01110111B ;A
    retlw   01111100B ;B
    retlw   00111001B ;C
    retlw   01011110B ;D
    retlw   01111001B ;E
    retlw   01110001B ;F
    
    
PSECT code,  delta = 2, abs
ORG 200h			;Posición 200h para configuración
    
;---------------------------Configuración---------------------------------------
MAIN:
    CALL    IO_Config		;Se llama la subrutina de configuración de entradas /salidas	
    CALL    Reloj_Config	;Se llama la subrutina de configuración del reloj
    CALL    Timer0_Config	;Se llama la subrutina de configuración del TMR0
    CALL    Timer1_Config	;Se llama la subrutina de configuración del TMR1
    CALL    Timer2_Config	;Se llama la subrutina de configuración del TMR2
    CALL    Interrup_Config	;Se llama la subrutina de configuración de interrupciones
 

;-----------------------Loop Principal------------------------------------------
Loop:
    btfsc   Conta_Dor_0_,	1	;Comprueba que es 2 el contador0 
    
    call    Completado_1		;Se llama la subrutina completado1
    movf    Tiempo_Segundos_,	0				;El valor se mueve al registro W
    sublw   0x3C;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2	;Comprueba que los segundos sean 60 en total
    
    call    Tiempo_Completado_Minutos_ ;Se llama la subrutina
    btfsc   Tiempo_Segundos_Timer_,	7    ;Si está apagada se salta esta línea, encendida se verifica la línea 
    decf    Tiempo_Minutos_Timer_,	1	;Decrece
    movlw   0x3B				;El valor se mueve al registro W
    btfsc   Tiempo_Segundos_Timer_,	7  ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Segundos_Timer_		;Verifica si los segundos del timer en total es cero
    btfsc   Bandera_Config,0  ;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    $+7 ;Se pasa 7 instrucciones al no estar apagada
    
    movf    Tiempo_Segundos_Timer_,	1				;El valor se mueve al registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfss   STATUS,	2
    goto    $+4;Se pasa 4 instrucciones al no estar apagada
    
    movf    Tiempo_Minutos_Timer_,	1				;El valor se mueve al registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Tiempo_Completado_Timer_	;Se llama la subrutina que verifica que el timer se completo
    btfss   PORTA,	6
    
    goto    $+7 ;Se pasa 7 instrucciones al estar apagada
    btfsc   Bandera_Alarma_0,   0  ;Si está apagada se salta esta línea, encendida se verifica la línea 
    
    call    Apagar_Alarma_	;Se llama la subrutina que apaga la alarma del timer
    btfss   PORTA,	6
    goto    $+3;Se pasa 3 instrucciones al  estar apagada
    btfss   Bandera_Alarma_1, 0  ;Si está apagada se salta esta línea, encendida se verifica la línea 
    
    call    Estado_De_Alarma_Off_		;Se llama la subrutina que apaga la alarma
    movf    Tiempo_Minutos_,	0   				;El valor se mueve al registro W
    sublw   0x3C;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    btfsc   STATUS,	2	; Verificar si minutos = 60
    
    call    Tiempo_Completado_Horas_ ;Se llama la subrutina
    movf    Tiempo_Minutos_Alarma_,	0				;El valor se mueve al registro W
    sublw   0x3C;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    clrf    Tiempo_Minutos_Alarma_		; Verificar si minutos alarma = 60
    
    movf    Tiempo_Horas_Alarma_,	0				;El valor se mueve al registro W
    sublw   0x17;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfss   STATUS,	0
    clrf    Tiempo_Horas_Alarma_	;Comprueba que las horas de la alarma en total son 24
    
    movf    Tiempo_Horas_Alarma_,	0				;El valor se mueve al registro W
    sublw   0x18;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Tiempo_Completado_Dias_	; Verificar si horas = 24
    movf    Tiempo_Minutos_Timer_,	0				;El valor se mueve al registro W
    sublw   0x64;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
        
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Tiempo_Minutos_Maximos_Timer_	;Comprueba que los minutos del timer es de 99
    btfsc   Tiempo_Minutos_Timer_,  7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    clrf    Tiempo_Minutos_Timer_		; Comprueba si en el timer se encuentra en estado "negativo"
    movf    Tiempo_Segundos_Timer_,	0				;El valor se mueve al registro W
    sublw   0x3C;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
        
    ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Tiempo_Segundos_Maximos_Timer_	; Verificar si segundos timer = 60 
    btfsc   Tiempo_Segundos_Timer_,	7   ;Si está apagada se salta esta línea, encendida se verifica la línea 
    clrf    Tiempo_Segundos_Timer_		; Verificar si segundos timer es "negativo"
    
    movlw   0x3B				;El valor se mueve al registro W
    btfsc   Tiempo_Minutos_,	7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Minutos_		; Verificar si minutos es "negativo"
    movlw   0x3B				;El valor se mueve al registro W
    
    btfsc   Tiempo_Minutos_Alarma_,	7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Minutos_Alarma_		; Verificar si minutos alarma es "negativo"
    movlw   0x17				;El valor se mueve al registro W
    
    btfsc   Tiempo_Horas_,	7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Horas_		; Verificar si horas es "negativo"
    movlw   0x17
    
    btfsc   Tiempo_Horas_Alarma_,	7
    movwf   Tiempo_Horas_Alarma_		; Verificar si horas alarma es "negativo"
    movf    Tiempo_Meses_,	0				;El valor se mueve al registro W
    sublw   0x0D;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    
        ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Tiempo_Completado_Ano_	; Comprueba que la cantidad de meses sea 12
    movlw   0x1F				;El valor se mueve al registro W
    btfsc   Tiempo_Dias_,	7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Dias_		; Verificar si dias es "negativo"
    movlw   0x0C				;El valor se mueve al registro W
    btfsc   Tiempo_Meses_,	7 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    movwf   Tiempo_Dias_		; Verificar si meses es "negativo"
    btfss   Bandera_Config, 0 ;Si no está apagada se salta esta línea, apagada se verifica la línea 
    goto    $+8
    
    movf    Tiempo_Minutos_Timer_,	    1				;El valor se mueve al registro W
    
        ;Se comprueba que la bandera de BORRON no este apagada
    btfss   STATUS,	    2
    goto    $+5
    
    movf    Tiempo_Segundos_Timer_,	    1				;El valor se mueve al registro W
    movlw   0x01
    btfsc   STATUS,	    2
    movwf   Tiempo_Segundos_Timer_		; Timer minimo 1 seg
    movf    Tiempo_Minutos_Timer_,	    0
    sublw   0x64;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    btfsc   STATUS,	    0
    goto    $+3
    
    movlw   0x63;El valor se mueve al registro W
    movwf   Tiempo_Minutos_Timer_		; Minutos timer max
    btfsc   Bandera_Config, 0
    goto    $+11
    
    btfss   Bandera_Alarma_1,0
    goto    $+9
    movf    Tiempo_Horas_Alarma_,	0;El valor se mueve al registro W
    xorwf   Tiempo_Horas_,	0
    
        ;Se comprueba que la bandera de BORRON esté apagada
    btfss   STATUS,	2
    goto    $+5
    movf    Tiempo_Minutos_Alarma_,	0;El valor se mueve al registro W
    xorwf   Tiempo_Minutos_,	0
    
        ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2 
    
    call    Tiempo_Completado_Alarma_	;Se comprueba que la alarma es igual a la hora
    btfsc   Bandera_Alarma_1, 0
    goto    $+3   
    bcf	    PORTA,	4
    goto    $+2
    bsf	    PORTA,	4	;Al tener la alarma encendida se enciende el led
    btfsc   Bandera_Config, 0
    goto    $+3
    
    bcf	    PORTA,	5
    goto    $+2
    bsf	    PORTA,	5	; Encender LED de modo configuracion
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x01
    
        ;Se comprueba que la bandera de BORRON esté apagada
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es enero
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x02
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_28_		; Verificar si es febrero 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x03
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es marzo 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x04
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_30_		; Verificar si es abril
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x05
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es mayo 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x06
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_30_		; Verificar si es junio 
    movf    Tiempo_Meses_,	0
    xorlw   0x07
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es julio 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x08
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es agosto 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x09
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_30_		; Verificar si es septiembre
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x0A
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es octubre 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x0B
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_30_		; Verificar si es noviembre 
    movf    Tiempo_Meses_,	0;El valor se mueve al registro W
    xorlw   0x0C
    btfsc   STATUS,	2
    
    call    Cantidad_Meses_De_31_		; Verificar si es diciembre
    movf    Medio_0,	0;El valor se mueve al registro W
    movwf   PORTE
    
    btfsc   Estados_0,	0	
    goto    Fecha_Loop
    
    btfsc   Estados_0,	1	
    goto    Alarma_Loop
    
  
    btfsc   Estados_0,	2
    goto    Timer_Loop
    
    
    ; Estados = 000 (Hora/reloj)
    goto    Reloj_Loop		
    
Reloj_Loop:
    //Led que indica en que estado está
    bsf	    PORTA,	0	; LED indicador de modo hora/reloj
    bcf	    PORTA,	1	;Led indica la fecha
    bcf	    PORTA,	2	;Led indica la alarma
    bcf	    PORTA,	3	;Led indica el timer
    
    movf    Tiempo_Segundos_,	0;El valor se mueve al registro W
    movwf   Cantidad_De_Segundos_		; Almacenar el valor de segundos en valor
    movf    Tiempo_Minutos_,	0;El valor se mueve al registro W
    movwf   Cantidad_De_Minutos_		; Almacenar el valor de minutos en valor
    movf    Tiempo_Horas_,	0;El valor se mueve al registro W
    movwf   Cantidad_De_Horas_		; Almacenar el valor de horas en valor
    
  
    //Se convierten los valores a decimales
    clrf    Ciclo_Unidades_De_Segundos_
    clrf    Ciclo_Decenas_De_Segundos_
    clrf    Ciclo_Unidades_De_Minutos_
    clrf    Ciclo_Decenas_De_Minutos_
    clrf    Ciclo_Unidades_De_Horas_
    clrf    Ciclo_Decenas_De_Horas_
    
    movf    Valor_De_Diez_,   0;El valor se mueve al registro W
    subwf   Cantidad_De_Minutos_,  1 ;Se resta por lo que se tiene en el registro W
    incf    Ciclo_Decenas_De_Minutos_,	1   ;Incrementa
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Decenas_Minutos_	; Obtener decenas de minutos
    movf    Valor_De_Uno_,    0;El valor se mueve al registro W
    subwf   Cantidad_De_Minutos_,  1;Se resta por lo que se tiene en el registro W
    incf    Ciclo_Unidades_De_Minutos_,	1   ;incrementa
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Unidades_Minutos_	; Obtener unidades de minutos 
    movf    Valor_De_Diez_,   0		;Se mueve al registro W
    subwf   Cantidad_De_Horas_,  1;Se resta por lo que se tiene en el registro W
    incf    Ciclo_Decenas_De_Horas_,	1	;Incremente
    btfsc   STATUS, 0
    goto    $-3			;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Decenas_Horas_	; Obtener decenas de horas
    movf    Valor_De_Uno_,    0		;Se mueve al registro W
    subwf   Cantidad_De_Horas_,  1;Se resta por lo que se tiene en el registro W
    incf    Ciclo_Unidades_De_Horas_,	1   ;Incremente
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Unidades_Horas_	; Se llama la subrutina que se obtiene las unidades de horas
    
    call    Set_Display_Estado_S0_	; Se llama la subrutina que se setea display para mostrar horas y minutos
    goto    Loop		; Se vuelve al Loop principal
    
Fecha_Loop:
    bsf	    PORTE,	2	; LEDs que cuentan segundos siempre encendidos para ser diagonal
    bcf	    PORTA,	0	;Led indicador de hora
    bsf	    PORTA,	1	; LED indicador de modo fecha
    bcf	    PORTA,	2	;Led indicador de alarma
    bcf	    PORTA,	3	;Led indicador de timer
    
    movf    Tiempo_Dias_,	0	; Almacenar el valor de dias en valor
    movwf   Cantidad_De_Dias_		;Se mueve al registro W
    movf    Tiempo_Meses_,	0	; Almacenar el valor de meses en valor
    movwf   Cantidad_De_Meses_		;Se mueve al registro W
	
//Se convierte estos valores a decimales
    clrf    Ciclo_Unidades_De_Dias_
    clrf    Ciclo_Decenas_De_Dias_
    clrf    Ciclo_Unidades_De_Meses_
    clrf    Ciclo_Decenas_De_Meses_
    
    movf    Valor_De_Diez_,   0; Almacenar el valor de meses en valor en el registro W
    subwf   Cantidad_De_Dias_,  1	;Se resta el valor por lo que se tiene en el registro W
    incf    Ciclo_Decenas_De_Dias_,	1   ;Incrementa la variable+1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Decenas_Dias_	; Se llama la subrutina que obtiene las decenas de dias
    movf    Valor_De_Uno_,    0		;Se mueve al registro W
    subwf   Cantidad_De_Dias_,  1	    ;Se resta con el valor del registro W
    incf    Ciclo_Unidades_De_Dias_,	1	;Incrementa la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Unidades_Dias_	; Se llama la subrutina de las unidades de día
    movf    Valor_De_Diez_,   0		    ;Se mueve al registro W
    subwf   Cantidad_De_Meses_,  1	    ;Se resta con el valor del registro W
    incf    Ciclo_Decenas_De_Meses_,	1   ;Se incrementa la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Decenas_Meses_	;Se llama la subrutina que se obtienen las decenas de los meses
    movf    Valor_De_Uno_,    0		    ;Se mueve al registro W
    subwf   Cantidad_De_Meses_,  1	    ;Se resta con el valor del registro W
    incf    Ciclo_Unidades_De_Meses_,	1	;Se incrementa la variable ´1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    
    call    Obtener_Unidades_Meses_	; Obtener unidades de mes
    call    Set_Display_Estado_S1_	; Configurar display para mostrar mes y dia
    goto    Loop		; Volver a loop principal
    
Alarma_Loop:
    bcf	    PORTA,	0
    bcf	    PORTA,	1
    
    //Este led estará en funcionamiento ya que es el indicador del modo alarma
    bsf	    PORTA,	2
    bcf	    PORTA,	3
    
    
    //Se convierte los valores a decimales
    clrf    Ciclo_Unidades_De_Minutos_Alarma_
    clrf    Ciclo_Decenas_De_Minutos_Alarma_
    clrf    Ciclo_Unidades_De_Horas_Alarma_
    clrf    Ciclo_Decenas_De_Horas_Alarma_
    
    movf    Tiempo_Minutos_Alarma_,	0	;Almacena el valor en el registro W
    movwf   Cantidad_De_Minutos_Alarma_		;Se mueve a la variable
    movf    Tiempo_Horas_Alarma_,	0	; Almacenar el valor en el registro W
    movwf   Cantidad_De_Horas_Alarma_		;Se mueve a la variable
    
    movf    Valor_De_Diez_,   0			;Almacena el valor en el registro W
    subwf   Cantidad_De_Minutos_Alarma_,  1	    ;Se resta el valor con el del registro W
    incf    Ciclo_Decenas_De_Minutos_Alarma_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3		;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Decenas_Minutos_Alarma_	; Obtener decenas de minutos

    movf    Valor_De_Uno_,    0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Minutos_Alarma_,  1  ;Se resta el valor con el del registro W
    incf    Ciclo_Unidades_De_Minutos_Alarma_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Unidades_Minutos_Alarma_	; OBtener unidades de minutos
    
    movf    Valor_De_Diez_,   0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Horas_Alarma_,  1  ;Se resta el valor con el del registro W
    incf    Ciclo_Decenas_De_Horas_Alarma_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Decenas_Horas_Alarma_	; Obtener deceas de horas

    movf    Valor_De_Uno_,    0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Horas_Alarma_,  1  ;Se resta el valor con el del registro W
    incf    Ciclo_Unidades_De_Horas_Alarma_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Unidades_Horas_Alarma_	; Obtener unidades de horas
	
    call    Set_Display_Estado_S3_	; Se llama la subrutina que se configura el display que muestra lashoras y minutos de alarma
    goto    Loop		; Volver a loop principal 
    
Timer_Loop:
    bcf	    PORTA,	0
    bcf	    PORTA,	1
    bcf	    PORTA,	2
    
    //Este led se encenderá porque es el que indica el modo timer
    bsf	    PORTA,	3	
    
    //Los valores se convierten a decimales
    clrf    Ciclo_Unidades_De_Segundos_Timer_
    clrf    Ciclo_Decenas_De_Segundos_Timer_
    clrf    Ciclo_Unidades_De_Minutos_Timer_
    clrf    Ciclo_Decenas_De_Minutos_Timer_
    
    movf    Tiempo_Segundos_Timer_,	0		;Almacena el valor en el registro W
    movwf   Cantidad_De_Segundos_Timer_;Se mueve a la variable
    movf    Tiempo_Minutos_Timer_,	0		;Almacena el valor en el registro W
    movwf   Cantidad_De_Minutos_Timer_;Se mueve a la variable
    
    movf    Valor_De_Diez_,   0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Segundos_Timer_,  1
    incf    Ciclo_Decenas_De_Segundos_Timer_,	1
    btfsc   STATUS, 0   ;Se incrementa en la variable +1
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Decenas_Segundos_Timer_	; Obtener decenas de segundos

    movf    Valor_De_Uno_,    0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Segundos_Timer_,  1 ;Se resta el valor con el del registro W
    incf    Ciclo_Unidades_De_Segundos_Timer_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Unidades_Segundos_Timer_	; Obtener unidades de segundos
    
    movf    Valor_De_Diez_,   0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Minutos_Timer_,  1 ;Se resta el valor con el del registro W
    incf    Ciclo_Decenas_De_Minutos_Timer_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Decenas_Minutos_Timer_	 ; Obtener decenas de minutos 

    movf    Valor_De_Uno_,    0		;Almacena el valor en el registro W
    subwf   Cantidad_De_Minutos_Timer_,  1 ;Se resta el valor con el del registro W
    incf    Ciclo_Unidades_De_Minutos_Timer_,	1   ;Se incrementa en la variable +1
    btfsc   STATUS, 0
    goto    $-3;Se regresa 3 instrucciones previas al no estar apagada
    call    Obtener_Unidades_Minutos_Timer_	; Obtener unidades de minutos 
    
    call    Set_Display_Estado_S4_	; Configurar display para mostrar minutos y segundos de timer
    goto    Loop		; Volver a loop principal 
    
;--------------- Subrutinas ------------------
IO_Config:
    BANKSEL ANSEL		;Direcciona al banco 11
    CLRF    ANSEL		;Entradas o salidas digitales
    CLRF    ANSELH		;Entradas o salidas digitales
    
    banksel TRISA		;Se direcciona al banco 01
    movlw   0xFF		;Se mueve el valor al registro W
    movwf   TRISB		; Puerto B como entrada
    
    //Puertos A,C,D y E como salidas
    clrf    TRISA		
    clrf    TRISC		
    clrf    TRISD		
    clrf    TRISE	   
    
    
    BANKSEL OPTION_REG    ; Se configuran los pull up del puerto B
    BCF OPTION_REG, 7
    BANKSEL WPUB	    
    BSF WPUB0		   ;Puerto RB0
    BSF WPUB1		   ;Puerto RB1
    BSF WPUB2		   ;Puerto RB2
    BSF WPUB3		   ;Puerto RB3
    BSF WPUB4		   ;Puerto RB4
    
    
    banksel PORTA	    ;Se direcciona al banco 00
    clrf    PORTA	    ;Limpia el Puerto A
    clrf    PORTC	    ;Limpia el Puerto C
    clrf    PORTD	    ;limpia el Puerto D
    clrf    PORTB	    ;Limpia el Puerto B
    clrf    PORTE	    ;Limpia el Puerto E
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Tiempo_Segundos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x10	    ;El valor se mueve al registro W
    movwf   Tiempo_Minutos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x05	    ;El valor se mueve al registro W
    movwf   Tiempo_Horas_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Unidades_Segundos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Decenas_Segundos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Unidades_Minutos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Decenas_Minutos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Unidades_Horas_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Sistema_Decenas_Horas_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Unidades_De_Segundos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Decenas_De_Segundos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Unidades_De_Minutos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Decenas_De_Minutos_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Unidades_De_Horas_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Ciclo_Decenas_De_Horas_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x0A	    ;El valor se mueve al registro W
    movwf   Valor_De_Diez_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x01	    ;El valor se mueve al registro W
    movwf   Valor_De_Uno_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Banderas	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Conta_Dor_0_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Conta_Dor_1_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Conta_Dor_2_	;El valor se mueve del Registro W a la variable dicha
    movlw   0xFF	    ;El valor se mueve al registro W
    movwf   Medio_0	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Estados_0	;El valor se mueve del Registro W a la variable dicha
    movlw   0x0F	    ;El valor se mueve al registro W
    movwf   Tiempo_Dias_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x06	    ;El valor se mueve al registro W
    movwf   Tiempo_Meses_	;El valor se mueve del Registro W a la variable dicha
    movlw   0xFE	    ;El valor se mueve al registro W
    movwf   Bandera_Config	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Numero_Config	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Estado_Config	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Tiempo_Segundos_Timer_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x01	    ;El valor se mueve al registro W
    movwf   Tiempo_Minutos_Timer_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x11	    ;El valor se mueve al registro W
    movwf   Tiempo_Minutos_Alarma_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x05	    ;El valor se mueve al registro W
    movwf   Tiempo_Horas_Alarma_	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Bandera_Alarma_0	;El valor se mueve del Registro W a la variable dicha
    movlw   0x00	    ;El valor se mueve al registro W
    movwf   Bandera_Alarma_1	;El valor se mueve del Registro W a la variable dicha
    return		    ;Se regresa
    
Reloj_Config:
    BANKSEL OSCCON		;Direcciona al banco 01 (OSCCON)
    
    //S= 1, C=0
    BSF	    OSCCON, 0		;SCS en 1, se configura a reloj interno
    BSF	    OSCCON, 6		;Bit 6 en 1
    BSF	    OSCCON, 5		;Bit 5 en 1
    BCF	    OSCCON, 4		;Bit 4 en 0
    ; Con una frecuencia interna del oscilador  a 4MHZ (IRCF<2:0> -> 110 4MHz)
    RETURN			;Se regresa
    
Timer0_Config:
    banksel OPTION_REG	    ; Cambiamos a banco de OPTION_REG
    bcf	    OPTION_REG, 5   ; T0CS = 0 --> TIMER0 como temporizador 
    bcf	    OPTION_REG, 3   ; Prescaler a TIMER0
    bcf	    OPTION_REG, 2   ; PS2
    bcf	    OPTION_REG, 1   ; PS1
    bcf	    OPTION_REG, 0   ; PS0 Prescaler de 1 : 2
    banksel TMR0	    ; Cambiamos a banco 0 de TIMER0
    movlw   6		    ; Cargamos el valor 6 a W
    movwf   TMR0	    ; Cargamos el valor de W a TIMER0 para 2mS de delay
    bcf	    T0IF	    ; Borramos la bandera de interrupcion
    return  
    
Timer1_Config:
    banksel T1CON	    ; Cambiamos a banco de tmr1
    bcf	    TMR1CS		;El reloj interno se habilita
    bcf	    T1OSCEN		;LP se apaga
    bsf	    T1CKPS1	
    bsf	    T1CKPS0
    
    ;Se encuentra en un prescaler de 1:8
    bcf	    TMR1GE		;Estará contando siempre en el timer1	
    bsf	    TMR1ON		;El timer1 se enciende
    call    Timer1_Reset	;Se llama la subrutina
    return			;Se regresa
  
Timer2_Config:
    banksel PR2		    ;Se direcciona al banco PR2
    movlw   243		    ; El valor se mueve al registro W y para el delay con un valor de 62.5 mS
    movwf   PR2		    ;En el Timer 2 la configuración del tiempo es de 62.5 milisegundos
    banksel T2CON	    ;Se direcciona al banco de T2CON
    bsf	    T2CKPS1	    ; Prescaler de 1:16
    bsf	    T2CKPS0
    bsf	    TOUTPS3	    ; Postscaler de 1:16
    bsf	    TOUTPS2
    bsf	    TOUTPS1
    bsf	    TOUTPS0
    bsf	    TMR2ON	    ; El timer 2 se enciende
    return		    ;Se regresa
    
Interrup_Config:
    banksel IOCB	    ;Se direcciona al banco de IOCB
    
    //Se habilitan interrupciones en RB0,RB1,RB2,RB3 y RB4
    bsf	    IOCB,   0	  
    bsf	    IOCB,   1	   
    bsf	    IOCB,   2	  
    bsf	    IOCB,   3	   
    bsf	    IOCB,   4	  
    banksel PIE1	;Se direcciona al banco de PIE1
    
    //Se habilitan las interripcion del timer1 y timer2
    bsf	    TMR1IE	  
    bsf	    TMR2IE	 
    
    
    banksel INTCON	    ;Se direcciona al banco INTCON
    bsf	    PEIE
    bsf	    GIE		    ; Se habilitan las interrupciones globales
    bsf	    T0IE	    ;Se habilitan las interrupciones del Timer 0
    
    //Se limpia bandera en el timer0, timer 1 y timer2
    bcf	    T0IF
    bcf	    TMR1IF	   
    bcf	    TMR2IF	    
    BSF	    RBIE		;El cambio de estado en el puerto B se habilita
    BCF	    RBIF		; El cambio de bandera se habilita en el puerto	B
    return		    ;Se regresa
    
Timer0_Reset:
    banksel TMR0	    ;Se direciona al banco del timer0
    movlw   6		    ;Se mueve el valor al registro W
    movwf   TMR0	    ;Se mueve el valor al timer0  delay 4.44mS
    bcf	    T0IF	    ;Se limpia la bandera del Timer0
    return		    ;Se regresa

Timer1_Reset:
    banksel TMR1H	    ;Se direcciona al banco del Timer1
    movlw   0x0B	  ; valor inicial/ delay suficiente se mueve al registro W
    movwf   TMR1H	    ; Valor inicial se mueve al TMR1H
    movlw   0xDC	     ; Valor inicial se mueve al registro W
    movwf   TMR1L	     ; Valor inicial se mueve en TMR1L. Configurando que tenga 500ms de retardo
    bcf	    TMR1IF	    ; Se limpia la vandera del Timer1
    
Timer0_Interrup:		 ;Interrupciones en el timer0
    call    Timer0_Reset	;Se llama a la subrutina que reinicia el timer 0
    call    Mostrar_Valor	;Se llama la subrutina
    return			;Se regresa
    
Timer1_Interrup:		;Interrupciones en el timer1
    call    Timer1_Reset	;Se llama a la subrutina que reinicia el timer1
    incf    Conta_Dor_0_	;Incrementamos en el contador
    comf    Medio_0
    return			;Se regresa
    
Timer2_Interrup:		;Interrupciones en el Puerto B
    bcf	    TMR2IF		;Se limpia la bandera del Timer 2
    return			;Se regresa
    
Interrup_PuertoB:			    ; Interrupciones de puerto B
    btfss   PORTB,	0	;Salta una linea si se presiona en el puerto B  (RB0)
    call    Cambio_De_Estado  ;Se llama la subrutina 
    btfss   PORTB,	1   ;Salta una linea si se presiona en el puerto B  (RB1)
    call    Edicion_Configurar   ;Se llama la subrutina
    btfss   PORTB,	2   ;Salta una linea si se presiona en el puerto B  (RB2)
    call    Valor_Incrementar	; Se llama la subrutina
    btfss   PORTB,	3	;Salta una linea si se presiona en el puerto B  (RB3)
    call    Valor_Decrementar	  ;Se llama la subrutina
    btfss   PORTB,	4	    ;Salta una linea si se presiona en el puerto B  (RB4)
    call    Modo_De_Configuracion	    ; Se llama la subrutina
    bcf	    RBIF	    ; Se limpia la bandera del Puerto B
    return		    ;Se regresa
    
Cambio_De_Estado:	    ;Se cambia de estado
    btfsc   Estados_0,	0   ;Comprueba en que estado estamos
    goto    Estado_S2	    ;Comprueba el estado que sigue
    btfsc   Estados_0,	1   ;Comprueba en que estado estamos
    goto    Estado_S3	    ;Comprueba el estado que sigue
    btfsc   Estados_0,	2   ;Comprueba en que estado estamos
    goto    Estado_S0	    ;Comprueba el estado que sigue
    goto    Estado_S1	    ;Comprueba el estado que sigue
	    
    Estado_S0:
	bcf	    Estados_0,	0	;Pasar de estado
	bcf	    Estados_0,	1	;Pasar de estado
	bcf	    Estados_0,	2	;Pasar de estado
	return				    ;Se regresa
    
    Estado_S1:
	bsf	    Estados_0,	0	;Pasar de estado
	bcf	    Estados_0,	1	;Pasar de estado
	bcf	    Estados_0,	2	;Pasar de estado
	return				;Se regresa

    Estado_S2:
	bcf	    Estados_0,	0	;Pasar de estado
	bsf	    Estados_0,	1	;Pasar de estado
	bcf	    Estados_0,	2	;Pasar de estado
	return				;Se regresa

    Estado_S3:
	bcf	    Estados_0,	0	;Pasar de estado
	bcf	    Estados_0,	1	;Pasar de estado
	bsf	    Estados_0,	2	;Pasar de estado
	return				;Se regresa
    
Edicion_Configurar:
    
    //Habilita o puede deshabilitar la bandera de la interrpución
    comf    Bandera_Config	   
    return		    ;Se regresa
    
Set_Display_Estado_S0_:			  ;Se observa en el display los minutos y las horas del reloj digital  
    movf    Sistema_Unidades_Minutos_,	w  ;La variable se mueve al registro W
    call    Tabla			    ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+1			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Minutos_,	w  ;La variable se mueve al registro W
    call    Tabla  ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+2			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Unidades_Horas_,	w  ;La variable se mueve al registro W
    call    Tabla  ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+3			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Horas_,	w  ;La variable se mueve al registro W
    call    Tabla  ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_			;En una nueva variable se mueve y se guarda
    return				 ;Se regresa
    
Set_Display_Estado_S1_:			 ;Se observa en el display el mes y día de la fecha  
    movf    Sistema_Unidades_Meses_,	w   ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+1			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Meses_,	w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+2			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Unidades_Dias_,   w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+3			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Dias_,    w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_			;En una nueva variable se mueve y se guarda
    return				;Se regresa
    
Set_Display_Estado_S3_:			;Se observa los minutos y horas de la alarma en el display  
    movf    Sistema_Unidades_Minutos_Alarma_,	w   ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+1			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Minutos_Alarma_,	w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+2			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Unidades_Horas_Alarma_,   w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+3			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Horas_Alarma_,    w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_			;En una nueva variable se mueve y se guarda
    return				;Se regresa
    
Set_Display_Estado_S4_:			    ;Se observa los segundos y minutos del timer en el display
    movf    Sistema_Unidades_Segundos_Timer_,	w   ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+1			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Decenas_Segundos_Timer_,	w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+2			;En una nueva variable se mueve y se guarda
    
    movf    Sistema_Unidades_Minutos_Timer_,   w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_+3
    
    movf    Sistema_Decenas_Minutos_Timer_,    w  ;La variable se mueve al registro W
    call    Tabla			 ;Se llama la tabla(para buscar el valor a cargar que se encuentra en el puerto C)
    movwf   Display_			;En una nueva variable se mueve y se guarda
    return				;Se regresa
    
Mostrar_Valor:		;El multiplexeado para displays que tienen siete segmentos
    clrf    PORTD		;Se limpia el puerto D
    btfsc   Banderas,	0	 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    Display_1		  ;Se mueve al display 
    btfsc   Banderas,	1	;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    Display_2		  ;Se mueve al display 
    btfsc   Banderas,	2	;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    Display_3		  ;Se mueve al display 
    goto    Display_0		      ;Se mueve al display 
    
    Display_0:			    
	movf    Display_+3,    W	    ;La variable se mueve al registro W
	movwf   PORTC			;El valor de tabla se mueve al puerto C 
	bsf	PORTD,	    0		;Este display se enciende
	bsf	Banderas,   0	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   1	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   2		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
return				    ;Se regresa

    Display_1:			    
	movf    Display_+2,  W	    ;La variable se mueve al registro W
	movwf   PORTC			;El valor de tabla se mueve al puerto C 
	bsf	PORTD,	    1		;Este display se enciende
	bcf	Banderas,   0		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bsf	Banderas,   1		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   2		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
return				    ;Se regresa
	
    Display_2:			    
	movf	Display_+1,   W	    ;La variable se mueve al registro W
	movwf	PORTC		    ;El valor de tabla se mueve al puerto C 
	bsf	PORTD,	    2		;Este display se enciende
	bcf	Banderas,   0	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   1		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bsf	Banderas,   2	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
return				    ;Se regresa
	
    Display_3:
	movf	Display_,    w	    ;La variable se mueve al registro W
	movwf	PORTC		    ;El valor de tabla se mueve al puerto C 
	bsf	PORTD,	    3	    ;Este display se enciende
	bcf	Banderas,   0		;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   1	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
	bcf	Banderas,   2	    ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
return				    ;Se regresa
	
Obtener_Decenas_Segundos_:
    decf    Ciclo_Decenas_De_Segundos_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0			;El valor se mueve al registro W
    addwf   Cantidad_De_Segundos_,  1
    movf    Ciclo_Decenas_De_Segundos_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Segundos_;Del Registro W el valor se mueve a la variable
    return
    
Obtener_Unidades_Segundos_:
    decf    Ciclo_Unidades_De_Segundos_,	1    ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0			;El valor se mueve al registro W
    addwf   Cantidad_De_Segundos_,  1		
    movf    Ciclo_Unidades_De_Segundos_,	0   ;El valor se mueve al registro W
    movwf   Sistema_Unidades_Segundos_		;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Decenas_Minutos_:
    decf    Ciclo_Decenas_De_Minutos_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_,  1
    movf    Ciclo_Decenas_De_Minutos_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Minutos_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Minutos_:
    decf    Ciclo_Unidades_De_Minutos_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_,  1
    movf    Ciclo_Unidades_De_Minutos_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Minutos_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Decenas_Horas_:
    decf    Ciclo_Decenas_De_Horas_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Horas_,  1
    movf    Ciclo_Decenas_De_Horas_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Horas_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Horas_:
    decf    Ciclo_Unidades_De_Horas_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Horas_,  1
    movf    Ciclo_Unidades_De_Horas_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Horas_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Decenas_Dias_:
    decf    Ciclo_Decenas_De_Dias_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Dias_,  1
    movf    Ciclo_Decenas_De_Dias_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Dias_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Dias_:
    decf    Ciclo_Unidades_De_Dias_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Dias_,  1
    movf    Ciclo_Unidades_De_Dias_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Dias_;Del Registro W el valor se mueve a la variable
    return    				;Se regresa
    
Obtener_Decenas_Meses_:
    decf    Ciclo_Decenas_De_Meses_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Meses_,  1
    movf    Ciclo_Decenas_De_Meses_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Meses_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Meses_:
    decf    Ciclo_Unidades_De_Meses_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Meses_,  1
    movf    Ciclo_Unidades_De_Meses_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Meses_;Del Registro W el valor se mueve a la variable
    return 				;Se regresa 
    
Obtener_Decenas_Segundos_Timer_:
    decf    Ciclo_Decenas_De_Segundos_Timer_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Segundos_Timer_,  1
    movf    Ciclo_Decenas_De_Segundos_Timer_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Segundos_Timer_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Segundos_Timer_:
    decf    Ciclo_Unidades_De_Segundos_Timer_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Segundos_Timer_,  1
    movf    Ciclo_Unidades_De_Segundos_Timer_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Segundos_Timer_;Del Registro W el valor se mueve a la variable
    return 				;Se regresa
    
Obtener_Decenas_Minutos_Timer_:
    decf    Ciclo_Decenas_De_Minutos_Timer_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_Timer_,  1
    movf    Ciclo_Decenas_De_Minutos_Timer_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Minutos_Timer_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Minutos_Timer_:
    decf    Ciclo_Unidades_De_Minutos_Timer_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_Timer_,  1
    movf    Ciclo_Unidades_De_Minutos_Timer_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Minutos_Timer_;Del Registro W el valor se mueve a la variable
    return 				;Se regresa
    
Obtener_Decenas_Minutos_Alarma_:
    decf    Ciclo_Decenas_De_Minutos_Alarma_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_Alarma_,  1
    movf    Ciclo_Decenas_De_Minutos_Alarma_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Minutos_Alarma_;Del Registro W el valor se mueve a la variable
    return					;Se regresa
    
Obtener_Unidades_Minutos_Alarma_:
    decf    Ciclo_Unidades_De_Minutos_Alarma_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Minutos_Alarma_,  1
    movf    Ciclo_Unidades_De_Minutos_Alarma_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Minutos_Alarma_;Del Registro W el valor se mueve a la variable
    return 				;Se regresa
    
Obtener_Decenas_Horas_Alarma_:
    decf    Ciclo_Decenas_De_Horas_Alarma_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Diez_,   0		;El valor se mueve al registro W
    addwf   Cantidad_De_Horas_Alarma_,  1
    movf    Ciclo_Decenas_De_Horas_Alarma_,	0;El valor se mueve al registro W
    movwf   Sistema_Decenas_Horas_Alarma_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Obtener_Unidades_Horas_Alarma_:
    decf    Ciclo_Unidades_De_Horas_Alarma_,	1 ;Se decrece 1 a la variable  al estar apagada
    movf    Valor_De_Uno_,    0		;El valor se mueve al registro W
    addwf   Cantidad_De_Horas_Alarma_,  1
    movf    Ciclo_Unidades_De_Horas_Alarma_,	0;El valor se mueve al registro W
    movwf   Sistema_Unidades_Horas_Alarma_;Del Registro W el valor se mueve a la variable
    return				;Se regresa
    
Completado_1:			;Es el contador del Timer 1
    clrf    Conta_Dor_0_		;Limpia la variable
    incf    Tiempo_Segundos_,	1	;Se incrementa en la variable +1
    btfss   Bandera_Alarma_0,   0   ;Si está encendida se salta esta línea, apagada se verifica la línea 
    return			    ;Se regresa
    
    decf    Tiempo_Segundos_Timer_,	1;Se decrece 1 a la variable  al estar apagada
    return				;Se regresa
    
Tiempo_Completado_Minutos_:		;El tiempo ha completado un minuto
    clrf    Tiempo_Segundos_		    ;Se limpia la variable
    incf    Tiempo_Minutos_,	1;Se incrementa en la variable +1
    btfsc   PORTA, 6
    
    //Se observa que la alarma se encuentra encendida durante un minuto, al momento que pase el tiempo apagarla
    call    Estado_De_Alarma_Off_		;Se llama la subrutina
    return				    ;Se regresa
    
Tiempo_Completado_Horas_:		;El tiempo ha completado una hora
    clrf    Tiempo_Minutos_		    ;Se limpia
    incf    Tiempo_Horas_,	1	    ;Se incrementa en la variable +1
    return				    ;Se regresa
    
Tiempo_Completado_Dias_:		;El tiempo ha completado un día
    clrf    Tiempo_Horas_		    ;Se limpia
    incf    Tiempo_Dias_,	1	    ;Se incrementa en la variabla +1
    return					;Se regresa
    
Tiempo_Completado_Ano_:			;El tiempo ha completado un año
    movlw   0x01		    ;El valor se guarda en el registro W
    movwf   Tiempo_Meses_		;Del registro W a la variable se mueve el valor
    return				    ;Se regresa
    
Tiempo_Minutos_Maximos_Alarma_:			
    movlw   0x03B		    ;El valor se guarda en el registro W
    movwf   Tiempo_Minutos_Alarma_	;Del registro W a la variable se mueve el valor
    return				;Se regresa
    
Tiempo_Horas_Maximos_Alarma_: 
    movlw   0x17		    ;El valor se guarda en el registro W
    movwf   Tiempo_Horas_Alarma_	;Del registro W a la variable se mueve el valor
    return				    ;Se registro
    
Tiempo_Completado_Timer_:		;El tiempo ha completado el timer
    
    //Se vuelve a cargar al timer (temporizador) un minuto
    movlw   0x01			    ;El valor se guarda en el registro W	
    movwf   Tiempo_Minutos_Timer_;Del registro W a la variable se mueve el valor
    movlw   0x00		    ;El valor se guarda en el registro W
    movwf   Tiempo_Segundos_Timer_	    ;Del registro W a la variable se mueve el valor
    bsf	    PORTA,	6	;Se enciende la alarma
    bcf	    Bandera_Alarma_0,   0  ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
    return			    ;Se regresa
    
Tiempo_Completado_Alarma_:	//Se ha completado la alarma que se determina
    bsf	    PORTA,	6	; Se enciende la alarma
    return			   ;Se regresa
    
Apagar_Alarma_:
    
    //Se apaga la alarma del timer con el boton que está en RB5
    bcf	    PORTA,	6	
    movlw   0x01		; Volver a cargar un minuto al timer
    movwf   Tiempo_Minutos_Timer_   ;Del registro W a la variable se mueve el valor
    movlw   0x00		    ;El valor se guarda en el registro W
    movwf   Tiempo_Segundos_Timer_  ;Del registro W a la variable se mueve el valor
    bcf	    Bandera_Alarma_0,	0  ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
    return			    ;Se regresa
    
Estado_De_Alarma_Off_:		
        //Se apaga la alarma del timer con el boton que está en RB5
    bcf	    PORTA,	6	
    bcf	    Bandera_Alarma_1, 0   ;En la siguiente interrupcion se tiene un cambio de bandera al intercambiar con el segundo display
    return			;e regresa
    
Tiempo_Minutos_Maximos_Timer_:
    movlw   0x63		    ;El valor se guarda en el registro W
    movwf   Tiempo_Minutos_Timer_   ;Del registro W a la variable se mueve el valor
    return			    ;Se regresa
    
Tiempo_Segundos_Maximos_Timer_:
    movlw   0x00    ;El valor se guarda en el registro W
    movwf   Tiempo_Segundos_Timer_;Del registro W a la variable se mueve el valor
    return				;Se regresa
    
Cantidad_Meses_De_31_:				;Se limita los 31 días para cada determinado mes
    movf    Tiempo_Dias_,   0		;El valor se mueve al registro W
    sublw   0x1F	;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    btfsc   STATUS, 0		    ;Se comprueba que la bandera de BORRON esté apagada
    goto    $+4			    ;Se pasa 4 instrucciones  al no estar apagada	
    movlw   0x01  ;El valor se guarda en el registro W
    movwf   Tiempo_Dias_  ;Del registro W a la variable se mueve el valor
    incf    Tiempo_Meses_,  1    ;Se incrementa en la variabla +1
    return			;Se regresa
    
    
    //Se limita los 28 días para Febrero
Cantidad_Meses_De_28_:				
    movf    Tiempo_Dias_,   0;El valor se mueve al registro W
    sublw   0x1C	;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    btfsc   STATUS, 0	    ;Se comprueba que la bandera de BORRON esté apagada
    goto    $+4			    ;Se pasa 4 instrucciones  al no estar apagada	
    movlw   0x01		    ;El valor se guarda en el registro W
    movwf   Tiempo_Dias_  ;Del registro W a la variable se mueve el valor
    incf    Tiempo_Meses_,  1    ;Se incrementa en la variable +1
    return		    ;Se regresa
    
Cantidad_Meses_De_30_:				; Subrutina para limitar meses de 30 d?as
    movf    Tiempo_Dias_,   0;El valor se mueve al registro W
    sublw   0x1E	;Se guarda en la variable  después de restar el valor menos lo que hay en el registro W
    btfsc   STATUS, 0	    ;Se comprueba que la bandera de BORRON esté apagada
    goto    $+4			    ;Se pasa 4 instrucciones  al no estar apagada	
    movlw   0x01		    ;El valor se guarda en el registro W
    movwf   Tiempo_Dias_;Del registro W a la variable se mueve el valor
    incf    Tiempo_Meses_,  1    ;Se incrementa en la variable +1
    return			    ;Se regresa
    
Modo_De_Configuracion:				; Cambiar de modo configuraci?n
    btfsc   Bandera_Config,	0   ;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    Estado_2		    ;Se mueve a ese estado
    goto    Estado_1		    ;Se mueve a ese estado
    
    Estado_1:
	btfsc   Estados_0,	0   ;Si está apagada se salta esta línea, encendida se verifica la línea 
	goto	Alarma_0	    ;Se mueve a la variable
	btfsc   Estados_0,	1  ;Si está apagada se salta esta línea, encendida se verifica la línea 
	goto	Alarma_0	    ;Se mueve a la variable
	btfsc   Estados_0,	2  ;Si está apagada se salta esta línea, encendida se verifica la línea 
	goto	Alarma_Timer_		;Se mueve a la variable
	goto    Alarma_0	    ;Se mueve a la variable
	
	Alarma_Timer_:
	    comf    Bandera_Alarma_0, 1
	    return		    ;Se regresa
	    
	Alarma_0:
	    comf    Bandera_Alarma_1, 1
	    return		;Se regresa
    
    Estado_2:
    comf    Estado_Config,   1
    return			;Se regresa
    
Valor_Incrementar:			;Incrementa en el modo de configuración
    btfss   Bandera_Config,	0    ;Si está encendida se salta esta línea, apagada se verifica la línea 
    return				;Se regresa
    
    btfsc   Estado_Config,	0 ;Si está apagada se salta esta línea, encendida se verifica la línea 
    goto    Incrementar2_Config	    ;Se mueve a la varaible
    goto    Incrementar1_Config  ;Se mueve a la variable
    
    Incrementar1_Config:
	btfsc   Estados_0,	0	;Comprueba en que estado esta
	goto	Incremento_De_Dias_	;Se mueve a la variable
	btfsc   Estados_0,	1	;Comprueba en que estado esta
	goto	Incremento_De_Minutos_Alarma_	    ;Se mueve a la variable
	btfsc   Estados_0,	2	;Comprueba en que estado esta
	goto	Incremento_De_Segundos_Timer_	    ;Se mueve a la variable
	goto    Incremento_De_Minutos_		    ;Se mueve a la variable
	
	Incremento_De_Minutos_:
	    incf    Tiempo_Minutos_	    ;Se incrementa en la variable +1
	    return			    ;Se regresa
	    
	Incremento_De_Dias_:	    
	    incf    Tiempo_Dias_	    ;Se incrementa en la variable+1
	    return			    ;Se regresa
	    
	Incremento_De_Minutos_Alarma_:
	    incf    Tiempo_Minutos_Alarma_  ;Se incrementa en la variable+1
	    return			    ;Se regresa
	    
	Incremento_De_Segundos_Timer_:
	    incf    Tiempo_Segundos_Timer_	;Se incrementa en la variable+1
	    return			    ;Se regresa
	    
    Incrementar2_Config:
	btfsc   Estados_0,	0	;Comprueba en que estado esta
	goto	Incremento_De_Meses_      ;Se mueve a la variable
	btfsc   Estados_0,	1	;Comprueba en que estado esta
	goto	Incremento_De_Horas_Alarma_  ;Se mueve a la variable
	btfsc   Estados_0,	2	;Comprueba en que estado esta
	goto	Incremento_De_Minutos_Timer_  ;Se mueve a la variable
	goto    Incremento_De_Horas_  ;Se mueve a la variable
	
	Incremento_De_Horas_:
	    incf    Tiempo_Horas_	    ;Se incrementa en la variable+1
	    return			    ;Se regresa
	    
	Incremento_De_Meses_:
	    incf    Tiempo_Meses_	    ;Se incrementa en la variable+1
	    return			    ;Se regresa
	    
	Incremento_De_Horas_Alarma_:
	    incf    Tiempo_Horas_Alarma_	;Se incrementa en la variable+1
	    return			;Se regresa
	    
	Incremento_De_Minutos_Timer_:
	    incf    Tiempo_Minutos_Timer_	;Se incrementa en al variable+1
	    return			;Se regresa
    
Valor_Decrementar:					; Subrutina para decrementar en modo configuraci?n 
    btfss   Bandera_Config, 0 ;Si está encendida se salta esta línea, apagada se verifica la línea 
    return			;Se regresa
    
    btfsc   Estado_Config,	0	;Comprueba en que estado esta
    goto    Decrementar2_Config  ;Se mueve a la variable
    goto    Decrementar1_Config  ;Se mueve a la variable
    
    Decrementar1_Config:
	btfsc   Estados_0,	0	;Comprueba en que estado esta
	goto	Decremento_De_Dias_      ;Se mueve a la variable
	btfsc   Estados_0,	1	;Comprueba en que estado esta
	goto	Decremento_De_Minutos_Alarma_  ;Se mueve a la variable
	btfsc   Estados_0,	2	;Comprueba en que estado esta
	goto	Decremento_De_Segundos_Timer_  ;Se mueve a la variable
	goto    Decremento_De_Minutos_  ;Se mueve a la variable
	
	Decremento_De_Minutos_:
	    decf    Tiempo_Minutos_ ;Decrece en la variable
	    return		    ;Se regresa
	    
	Decremento_De_Dias_:
	    decf    Tiempo_Dias_	;Decrece en la variable
	    return		    ;Se regresa
	    
	Decremento_De_Minutos_Alarma_:
	    decf    Tiempo_Minutos_Alarma_	;Decrece en la variable
	    return			;Se regresa
	    
	Decremento_De_Segundos_Timer_:
	    decf    Tiempo_Segundos_Timer_	    ;Decrece en la variable
	    return			;Se regresa
	    
    Decrementar2_Config:
	btfsc   Estados_0,	0	;Comprueba en que estado esta
	goto	Decremento_De_Meses_     ;Se mueve a la variable
	btfsc   Estados_0,	1	;Comprueba en que estado esta
	goto	Decremento_De_Horas_Alarma_  ;Se mueve a la variable
	btfsc   Estados_0,	2	;Comprueba en que estado esta
	goto	Decremento_De_Minutos_Timer_  ;Se mueve a la variable
	goto    Decremento_De_Horas_  ;Se mueve a la variable
	
	Decremento_De_Horas_:
	    decf    Tiempo_Horas_	;Decrece en la variable
	    return			;Se regresa
	    
	Decremento_De_Meses_:
	    decf    Tiempo_Meses_	;Decrece en la variable
	    return			;Se regresa
	    
	Decremento_De_Horas_Alarma_:
	    decf    Tiempo_Horas_Alarma_	;Decrece en la variable
	    return			;Se regresa
	    
	Decremento_De_Minutos_Timer_:
	    decf    Tiempo_Minutos_Timer_	;Decrece en la variable
	    return			    ;Se regresa

    
END  
    
    //Finaliza el código y ya se obtiene un reloj digital :D
