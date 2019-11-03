/* ###################################################################
**     Filename    : main.c
**     Project     : prueba3
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2019-10-16, 11:34, # CodeGen: 0
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.12
** @brief
**         Main module.
**         This module contains user's application code.
*/         
/*!
**  @addtogroup main_module main module documentation
**  @{
*/         
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "AS1.h"
#include "TI1.h"
#include "Bit1.h"
#include "Bit2.h"
#include "AD1.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */


void empaquetado(unsigned char valor_1[], unsigned char valor_2[], unsigned char m[]){
	
	m[0] = 0b11111111 | m[0]; //Establezco en el primer byte[0] del entramado = 1111 1111 
	
	m[2] = m[2] | valor_1[0];  // Asigno en byte[2] los 8 LSB del  valor_1 de la señal ADC    
	m [1] = m[1] | valor_1[1]; //Asigno en byte[1] los 4 MSB del valor_1 de la señal ADC
	
	//m[0] = 0b11111111 | m[0]; //Establezco en el primer byte[0] del entramado = 1111 1111 
		
		m[4] = m[4] | valor_2[0];  // Asigno en byte[2] los 8 LSB del  valor_1 de la señal ADC    
		m [3] = m[3] | valor_2[1]; //Asigno en byte[1] los 4 MSB del valor_1 de la señal ADC
		
	/*if(Bit1_GetVal()== TRUE){  // identificar el canal digital 1
		m[1] = 0b00010000;  // m[1] = 0001XXXX
	
	}*/

}
int flag;
unsigned char quien;
void main(void)
{
  /* Write your local variable definition here */
	//int *quien;
	unsigned char contador; //inicializacion del contador
	unsigned char m[5];  //bytes correspondientes al empaquetado

	unsigned char valor_1[2]; //8 bits provenientes del ADC del canal 1
	unsigned char valor_2[2]; //ADC del canal 2
	
	
  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  /*** End of Processor Expert internal initialization.                    ***/

  /* Write your code here */
  /* For example: for(;;) { } */

  	  while(1){
  		  
  		  valor_1[0] = 0b00000001;
  		 
  		  valor_2[0] = 0b00000110;
  		  valor_1[1] = 0b00110001;
  		 
  		  valor_2[1] = 0b00110110;
  		  m[0]= 0;
  		  m[1]= 0;
  		  m[2]= 0;
  		  m[3]= 0;
  		  m[4]= 0;
  		  if (flag==1){
  			 /* AD1_Measure(TRUE);
  			  AD1_GetChanValue(0,valor_1);
  			  AD1_GetChanValue(1,valor_2);
	  */
  			  empaquetado(valor_1,valor_2,m);
  			  AS1_SendBlock(m,5,&quien);
  			  flag = 0;
	 }
  		  //flag = 0;
}
  /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.3 [05.09]
**     for the Freescale HCS08 series of microcontrollers.
**
** ###################################################################
*/
