#define __MYUART_C

#define __18F97J60
#define __SDCC__
#include "../Include/HardwareProfile.h"
#include "../Include/TCPIP_Stack/TCPIP.h"

#ifdef STACK_USE_UART

// UART configuration
void UARTConfig(void)
{
	TRISCbits.TRISC7 = 1;
	TRISCbits.TRISC6 = 0;

	BAUDCON1bits.BRG16 = 0; // Divisor at 8 bit
	BAUDCON1bits.TXCKP = 1; // Inverted polarity
	TXSTA1bits.BRGH = 0; // No high-speed baudrate
	SPBRG1 = 40;	// Divisor for baud rate 9600 at 25 Mhz

	TXSTA1bits.SYNC = 0; // Async operation
	TXSTA1bits.TX9 = 0; // No tx of 9th bit
	TXSTA1bits.TXEN = 1; // Enable transmitter

	RCSTA1bits.RX9 = 0; // No rx of 9th bit
	RCSTA1bits.CREN = 1; // Enable receiver
	RCSTA1bits.SPEN = 1; // Enable serial port
}

// UART char printer
void UARTPutc(char c)
{
	// wait the end of transmission
	while (TXSTA1bits.TRMT == 0) {};
	TXREG1 = c; // send the new byte
}

// UART string printer
void UARTPuts(char *udata)
{
	do
    {
		UARTPutc(*udata);
	} while( *udata++ );
}

#endif