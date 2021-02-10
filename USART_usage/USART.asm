


;Transmisión asíncrona, 8-bits, sin paridad, 
;un bit de parada y un baud rate de 9600. 
;Transmite una cuenta con un retardo de un segundo.

		RJMP 	INICIO
.ORG 	0X28
		RJMP 	RSI_TX
INICIO:	LDI 	R16,0X00
		LDI 	R17,0XFF
		LDI 	R18,0X08
		LDI 	R19,0X06
		LDI 	R20,0X48
		LDI		R21,0X0C
		LDI		R22,0X22
		SEI		
		OUT		SPL,R17
		OUT 	SPH,R18
		SBI		DDRD,1	//Puerto D como salida
		OUT		DDRB,R16	//PB como entrada con Pull-Up
		OUT		PORTB,R17	//PB como entrada con Pull-Up
		STS 	UBRR0L,R21
		STS		UBRR0H,R16
		STS		UCSR0A,R22
		STS 	UCSR0C,R19
		STS		UCSR0B,R20
		//STS		UDR0,R16	//Transmitiendo ox00
		IN		R29,PINB
		STS		UDR0,R29	//Transmitiendo puerto B
ESPERA:	RJMP 	ESPERA

;INICIO DE RUTINA DE INTERRUPCIÓN DE TX
RSI_TX:	RCALL	RETARDO
		//INC		R16
		IN		R29,PINB
		STS 	UDR0,R29  //Transmitiendo puerto B
		RETI

;INICIO DE SUBRUTINA DE RETARDO
RETARDO:LDI  R23,0X06
    	LDI  R24,0X13
    	LDI  R25,0XAE
CICLO:	DEC  R25
    	BRNE CICLO
    	DEC  R24
    	BRNE CICLO
    	DEC  R23
    	BRNE CICLO
		RET