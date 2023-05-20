#include<p16f84a.inc>   
LIST P=16F84A
    
    
    
org 0x0				;Directive for the memory
    
    
    
	bsf STATUS, RP0 			       ;select bank 1 
	movlw b'00000000' 				
	movwf TRISB				       ;set all portb as output pins
	movlw b'00011111' 	
	movwf TRISA 				       ;set 0-4 pin as input in portA
	bcf STATUS, RP0 			       ;select bank 0
	goto setup



setup:							

	clrf PORTB					;Turn all LEDs connected to PORTB OFF
	bcf STATUS, C				        ;clear the carry bit in the status register (make it a zero)
	

check_on:						;Checking the IR sensor and control LED
	btfss PORTA, RA0				;check to see if we have pushed the left button,
	goto check_on					;if not go to main prograamme else continue
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00000001' 			        
	movwf PORTB					;if yes turn on led in RB0
	goto check_on1 						


check_on1:						;Checking the IR sensor and control LED
	btfss PORTA, RA1				;check to see if we have pushed the left button,
	goto check_on1					;if not go to main prograamme else continue
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00000010' 			        
	movwf PORTB					;if yes turn on led in RB1
	goto check_on2						
	
check_on2:						;Checking the IR sensor and control LED
	btfss PORTA,RA2				        ;check to see if we have pushed the left button,
	goto check_on2						;if not go to main prograamme else continue
	bcf STATUS, RP0 			;	select bank 0
	movlw b'00000100' 			        ;
	movwf PORTB					;if yes turn on led in RB2
	goto check_on3 						;and now return


check_on3:						;Checking the IR sensor and control LED
	btfss PORTA,RA3				        ;check to see if we have pushed the left button,
	goto check_on3					;if not go to main prograamme else continue
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00001000' 			        
	movwf PORTB					;if yes turn on led in RB3
	goto check_on4						

check_on4:						;Checking the IR sensor and control LED
	btfss PORTA,RA4				        ;check to see if we have pushed the left button,
	goto check_on4					;if not go to main prograamme else continue
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00010000' 			        
	movwf PORTB					;if yes turn on led in RB4
	goto check_on
end