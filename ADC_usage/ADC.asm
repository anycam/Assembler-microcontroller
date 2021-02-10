	//Camarena Garcia Andre
	RJMP INICIO			//Salto a inicio
        .ORG 0x2A	
        RJMP RSI_ADC	//Salto RSI_ADC

INICIO: SEI				//Interrupciones globales
        LDI R16, 0x08
        LDI R17, 0xFF	//Puntero de pila
        OUT SPH, R16
        OUT SPL, R17

		OUT DDRB,R17	//Puerto B como salida

		CBI DDRD, 5
		SBI PORTD, 5 //Entrada pullup activo puerto D
        
		LDI R20,0X20
		LDI R21,0XE8 
        STS ADMUX,R20	//Config ADC
        STS ADCSRA, R21

OP:     IN R19,PIND	//Leer pin D
        SBRC R19, 5		//Si pin 5 puerto D es 0
        RJMP CL		
        RJMP UNO			//Si no es cero se queda en el estado actual

UNO:	LDI R20,0X20	//Lectura pot
    	LDI R21,0XE8 
        STS ADMUX,R20	
        STS ADCSRA, R21
		RJMP OP				//salto a lectura

CL:     LDI R22,0X21	//Salto a nueva lectura pot
		LDI R21,0XE8 
        STS ADMUX, R22 
        STS ADCSRA, R21
        RJMP OP			//salto a lectura

RSI_ADC:
		LDS R25,ADCH
        OUT PORTB, R25
        RETI		//FIN de la interrupcion