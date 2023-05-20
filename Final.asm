#include<p16f84a.inc>   
LIST P=16F84A
    
    
    
org 0x0				;Directive for the memory
	
	cblock h'20'				        ;Within this cblock and endc, we can define our variables. More info on this, later.
	delay_1						;set aside 1 byte for a variable called delay_1
	delay_2						;set aside 1 byte for a variable called delay_1	
	endc
    
    
    
	bsf STATUS, RP0 			       ;select bank 1 
	movlw 0x20				
	movwf TRISB				       ;set all portb as output pins except RB5
	movlw b'00011111' 	
	movwf TRISA 				       ;set 0-4 pin as input in portA
	bcf STATUS, RP0 			       ;select bank 0
	goto setup



setup:							

	clrf PORTB					;Turn all LEDs connected to PORTB OFF
	bcf STATUS, C				        ;Clear the carry bit in the status register (make it a zero)
	
check_LDR:						;Checking the IR sensor and control LED
	clrf PORTB					;Turn all LEDs connected to PORTB OFF
	btfss PORTB, RB5				;Check it is day or dark
	goto check_LDR					;If not go to check again 
	goto check_on                                   ;Else continue to switch on led

check_on:						;Checking the IR sensor and control LED
	btfss PORTA, RA0				;Check if any vehicle pass thurough That IR sensor
	goto check_on					;if not go to check again 
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00000001' 			        
	movwf PORTB					;if yes turn on led in RB0
	goto check_on1 						


check_on1:						;Checking the IR sensor and control LED
	btfss PORTA, RA1				;Check if any vehicle pass thurough That IR sensor
	goto check_on1					;if not go to check again 
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00000010' 			        
	movwf PORTB					;if yes turn on led in RB1
	call checkwhileblink
	goto check_on2						
	
check_on2:						;Checking the IR sensor and control LED
	btfss PORTA,RA2				        ;Check if any vehicle pass thurough That IR sensor
	goto check_on2					;if not go to check again 
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00000100' 			        
	movwf PORTB					;if yes turn on led in RB2
	call checkwhileblink
	goto check_on3 						


check_on3:						;Checking the IR sensor and control LED
	btfss PORTA,RA3				        ;Check if any vehicle pass thurough That IR sensor
	goto check_on3					;if not go to check again 
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00001000' 			        
	movwf PORTB					;if yes turn on led in RB3
	call checkwhileblink
	goto check_on4						

check_on4:						;Checking the IR sensor and control LED
	btfss PORTA,RA4				        ;Check if any vehicle pass thurough That IR sensor
	goto check_on4					;if not go to check again 
	bcf STATUS, RP0 			        ;select bank 0
	movlw b'00010000' 			        
	movwf PORTB					;if yes turn on led in RB4
	call checkwhileblink
	call Delay
checkwhileblink:
	btfss PORTB,RB5	
	goto check_LDR
	return

Delay:
delay							;Delay
	movlw d'150'				        ;copy the maximum number to our working register (decimal 255)
	movwf delay_1					;and now copy it from the w register to delay_1 and delay_2
	movwf delay_2				        ;Now the rest of the routine will focus on counting down to zero.
delay_loop						
	decfsz delay_1, f			        ;decrement whatever is in delay_1 by 1 and store the answer back in delay_1
		goto delay_loop			        ;if the answer is not zero, then go back to the delay_loop label
	decfsz delay_2, f			        ;answer is zero then decrement delay_2 by one and store the answer in delay_2
		goto delay_loop			        ;if the answer is not zero, then go back to delay_loop label. but if the answer
	return						;is zero, then we have completed our delay and now we can return to our main program!


end