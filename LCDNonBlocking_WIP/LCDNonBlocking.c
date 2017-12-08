#define __LCDNONBLOCKING_C

#include "Include/TCPIP_Stack/TCPIP.h"
#include "LCDCircularList.h"

#define USE_LCD
#if defined(USE_LCD)


//#define FOUR_BIT_MODE
#define SAMSUNG_S6A0032		// This LCD driver chip has a different means of entering 4-bit mode.  
#define OP_LIST_MAX 10

// LCDText is a 32 byte shadow of the LCD text.  Write to it and 
// then call LCDUpdate() to copy the string into the LCD module.
BYTE LCDText[16*2+1];


// States of the initialization function
static enum LCDInit_states
{
    LCD_RESET,
    LCD_DEFAULTFUNC1,
    LCD_DEFAULTFUNC2,
    LCD_ENTRYMODE,
    LCD_DISPLAYCONTROL,
    LCD_CLEAR
} st_init;

// States of the erase function
static enum LCDErase_states
{
    LCD_CLEARDISPLAY,
    LCD_CLEARLOCAL
} st_update;

// States of the update function
static enum LCDUpdate_states
{
    LCD_GOTOFIRSTLINE,
    LCD_OUTFIRSTLINE,
    LCD_GOTOSECONDLINE,
    LCD_OUTSECONDLINE
} st_erase;


// Control flags
static char LCDWaiting;
static char LCDOpInProgress;

// Structure for LCD operation storage
static LCDOperation opLCD;


static void LCDInitExec(void)
{
	switch (st_init)
	{
		case LCD_RESET:
			st_init = LCD_DEFAULTFUNC1;
		break;

		case LCD_DEFAULTFUNC1:
			st_init = LCD_DEFAULTFUNC2;
		break;

		case LCD_DEFAULTFUNC2:
			st_init = LCD_ENTRYMODE;
		break;

		case LCD_ENTRYMODE:
			st_init = LCD_DISPLAYCONTROL;
		break;

		case LCD_DISPLAYCONTROL:
			st_init = LCD_CLEAR;
		break;

		case LCD_CLEAR:
			st_init = LCD_RESET;
			LCDOpInProgress = 0;
		break;

		default:
		// Do nothing
		break;
	}
}


static void LCDEraseExec(void)
{
	switch(st_erase)
	{
		case LCD_CLEARDISPLAY:
			st_erase = LCD_CLEARLOCAL;
		break;

    	case LCD_CLEARLOCAL:
			st_erase = LCD_CLEARDISPLAY;
			LCDOpInProgress = 0;
		break;

		default:
		// Do nothing
		break;
	}
}


static void LCDUpdateExec(void)
{
	switch(st_update)
	{
		case LCD_GOTOFIRSTLINE:
			st_update = LCD_OUTFIRSTLINE;
		break;

    	case LCD_OUTFIRSTLINE:
			st_update = LCD_GOTOSECONDLINE;
		break;

    	case LCD_GOTOSECONDLINE:
			st_update = LCD_OUTSECONDLINE;
		break;

    	case LCD_OUTSECONDLINE:
			st_update = LCD_GOTOFIRSTLINE;
			LCDOpInProgress = 0;
		break;

		default:
		// Do nothing
		break;
	}
}


/******************************************************************************
 * Function:        static void LCDWrite(BYTE RS, BYTE Data)
 *
 * PreCondition:    None
 *
 * Input:           RS - Register Select - 1:RAM, 0:Config registers
 *					Data - 8 bits of data to write
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Controls the Port I/O pins to cause an LCD write
 *
 * Note:            None
 *****************************************************************************/
static void LCDWrite(BYTE RS, BYTE Data)
{
	#if defined(LCD_DATA_TRIS)
		LCD_DATA_TRIS = 0x00;
	#else
		LCD_DATA0_TRIS = 0;
		LCD_DATA1_TRIS = 0;
		LCD_DATA2_TRIS = 0;
		LCD_DATA3_TRIS = 0;
		#if !defined(FOUR_BIT_MODE)
		LCD_DATA4_TRIS = 0;
		LCD_DATA5_TRIS = 0;
		LCD_DATA6_TRIS = 0;
		LCD_DATA7_TRIS = 0;
		#endif
	#endif
	LCD_RS_TRIS = 0;
	LCD_RD_WR_TRIS = 0;
	LCD_RD_WR_IO = 0;
	LCD_RS_IO = RS;

#if defined(FOUR_BIT_MODE)
	#if defined(LCD_DATA_IO)
		LCD_DATA_IO = Data>>4;
	#else
		LCD_DATA0_IO = Data & 0x10;
		LCD_DATA1_IO = Data & 0x20;
		LCD_DATA2_IO = Data & 0x40;
		LCD_DATA3_IO = Data & 0x80;
	#endif
	Nop();					// Wait Data setup time (min 40ns)
	Nop();
	LCD_E_IO = 1;
	Nop();					// Wait E Pulse width time (min 230ns)
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	LCD_E_IO = 0;
#endif

	#if defined(LCD_DATA_IO)
		LCD_DATA_IO = Data;
	#else
		LCD_DATA0_IO = ((Data & 0x01) == 0x01);
		LCD_DATA1_IO = ((Data & 0x02) == 0x02);
		LCD_DATA2_IO = ((Data & 0x04) == 0x04);
		LCD_DATA3_IO = ((Data & 0x08) == 0x08);
		#if !defined(FOUR_BIT_MODE)
		LCD_DATA4_IO = ((Data & 0x10) == 0x10);
		LCD_DATA5_IO = ((Data & 0x20) == 0x20);
		LCD_DATA6_IO = ((Data & 0x40) == 0x40);
		LCD_DATA7_IO = ((Data & 0x80) == 0x80);
		#endif
	#endif
	Nop();					// Wait Data setup time (min 40ns)
	Nop();
	LCD_E_IO = 1;
	Nop();					// Wait E Pulse width time (min 230ns)
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	Nop();
	LCD_E_IO = 0;

//	// Uncomment if you want the data bus to go High-Z when idle
//	// Note that this may make analog functions work poorly when using 
//	// Explorer 16 revision 5 boards with a 5V LCD on it.  The 5V LCDs have 
//  // internal weak pull ups to 5V on each of the I/O pins, which will 
//  // backfeed 5V weekly onto non-5V tolerant PIC I/O pins.
//	#if defined(LCD_DATA_TRIS)
//		LCD_DATA_TRIS = 0xFF;
//	#else
//		LCD_DATA0_TRIS = 1;
//		LCD_DATA1_TRIS = 1;
//		LCD_DATA2_TRIS = 1;
//		LCD_DATA3_TRIS = 1;
//		#if !defined(FOUR_BIT_MODE)
//		LCD_DATA4_TRIS = 1;
//		LCD_DATA5_TRIS = 1;
//		LCD_DATA6_TRIS = 1;
//		LCD_DATA7_TRIS = 1;
//		#endif
//	#endif
//	LCD_RS_TRIS = 1;
//	LCD_RD_WR_TRIS = 1;
}


/******************************************************************************
 * Function:        void LCDTaskInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Initialization of the entities used in the LCD task
 *
 * Note:            None
 *****************************************************************************/
void LCDTaskInit(void)
{
	// Initial states
    st_init   = LCD_RESET;
    st_update = LCD_GOTOFIRSTLINE;
    st_erase  = LCD_CLEARDISPLAY;
	// Initial values
	LCDWaiting = 0;
	LCDOpInProgress = 0;
	opLCD.order = 0;
	opLCD.text[0] = '\0';
	// Circular list initialization
	LCDListInit(10);
}


void LCDTask(void)
{
    if (!LCDOpInProgress)				// No operations being executed
    {
		if (!LCDListIsEmpty())				// The list contains at least one operation
		{
			LCDListPop(&opLCD);			// Retrieve the operation to execute
			switch (opLCD.order)
			{
				case 1:								// Init operation
					LCDInitExec();
				break;

				case 2:								// Erase operation
					LCDEraseExec();
				break;

				case 3:								// Update operation
					LCDUpdateExec();
				break;

				default:
				// Do nothing
				break;
			}
		}
    }
	else if (!LCDWaiting)				// Not waiting for timers
	{

	}
}


/******************************************************************************
 * Function:        void LCDInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        LCDText[] is blanked, port I/O pin TRIS registers are 
 *					configured, and the LCD is placed in the default state
 *
 * Note:            None
 *****************************************************************************/
void LCDInit(void)
{
	BYTE i;

	memset(LCDText, ' ', sizeof(LCDText)-1);
	LCDText[sizeof(LCDText)-1] = 0;

	// Setup the I/O pins
	LCD_E_IO = 0;
	LCD_RD_WR_IO = 0;


	#if defined(LCD_DATA_TRIS)
		LCD_DATA_TRIS = 0x00;
	#else
		LCD_DATA0_TRIS = 0;
		LCD_DATA1_TRIS = 0;
		LCD_DATA2_TRIS = 0;
		LCD_DATA3_TRIS = 0;
		#if !defined(FOUR_BIT_MODE)
		LCD_DATA4_TRIS = 0;
		LCD_DATA5_TRIS = 0;
		LCD_DATA6_TRIS = 0;
		LCD_DATA7_TRIS = 0;
		#endif
	#endif
	LCD_RD_WR_TRIS = 0;
	LCD_RS_TRIS = 0;
	LCD_E_TRIS = 0;


	// Wait the required time for the LCD to reset
	DelayMs(40);  //#################################################################################THIS

	// Set the default function
	// Go to 8-bit mode first to reset the instruction state machine
	// This is done in a loop 3 times to absolutely ensure that we get 
	// to 8-bit mode in case if the device was previously booted into 
	// 4-bit mode and our PIC got reset in the middle of the LCD 
	// receiving half (4-bits) of an 8-bit instruction
	LCD_RS_IO = 0;
	#if defined(LCD_DATA_IO)
		LCD_DATA_IO = 0x03;
	#else
		LCD_DATA0_IO = 1;
		LCD_DATA1_IO = 1;
		LCD_DATA2_IO = 0;
		LCD_DATA3_IO = 0;
		#if !defined(FOUR_BIT_MODE)
		LCD_DATA4_IO = 0;
		LCD_DATA5_IO = 0;
		LCD_DATA6_IO = 0;
		LCD_DATA7_IO = 0;
		#endif
	#endif
	Nop();					// Wait Data setup time (min 40ns)
	Nop();
	for(i = 0; i < 3u; i++)
	{
		LCD_E_IO = 1;
		Delay10us(1);			// Wait E Pulse width time (min 230ns)
		LCD_E_IO = 0;
		DelayMs(2);   //#################################################################################THIS
	}
	
#if defined(FOUR_BIT_MODE)
	#if defined(SAMSUNG_S6A0032)
		// Enter 4-bit mode (requires only 4-bits on the S6A0032)
		#if defined(LCD_DATA_IO)
			LCD_DATA_IO = 0x02;
		#else
			LCD_DATA0_IO = 0;
			LCD_DATA1_IO = 1;
			LCD_DATA2_IO = 0;
			LCD_DATA3_IO = 0;
		#endif
		Nop();					// Wait Data setup time (min 40ns)
		Nop();
		LCD_E_IO = 1;
		Delay10us(1);			// Wait E Pulse width time (min 230ns)
		LCD_E_IO = 0;
	#else
		// Enter 4-bit mode with two lines (requires 8-bits on most LCD controllers)
		LCDWrite(0, 0x28);
	#endif
#else
	// Use 8-bit mode with two lines
	LCDWrite(0, 0x38);
#endif
	Delay10us(5);     //#################################################################################THIS
	
	// Set the entry mode
	LCDWrite(0, 0x06);	// Increment after each write, do not shift
	Delay10us(5);     //#################################################################################THIS

	// Set the display control
	LCDWrite(0, 0x0C);		// Turn display on, no cusor, no cursor blink
	Delay10us(5);     //#################################################################################THIS

	// Clear the display
	LCDWrite(0, 0x01);	
	DelayMs(2);       //#################################################################################THIS
	
}


/******************************************************************************
 * Function:        void LCDUpdate(void)
 *
 * PreCondition:    LCDInit() must have been called once
 *
 * Input:           LCDText[]
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Copies the contents of the local LCDText[] array into the 
 *					LCD's internal display buffer.  Null terminators in 
 *					LCDText[] terminate the current line, so strings may be 
 *					printed directly to LCDText[].
 *
 * Note:            None
 *****************************************************************************/
void LCDUpdate(void)
{
	BYTE i, j;

	// Go home
	LCDWrite(0, 0x02);
	DelayMs(2);       //#################################################################################THIS

	// Output first line
	for(i = 0; i < 16u; i++)
	{
		// Erase the rest of the line if a null char is 
		// encountered (good for printing strings directly)
		if(LCDText[i] == 0u)
		{
			for(j=i; j < 16u; j++)
			{
				LCDText[j] = ' ';
			}
		}
		LCDWrite(1, LCDText[i]);
		Delay10us(5); //#################################################################################THIS
	}
	
	// Set the address to the second line
	LCDWrite(0, 0xC0);
	Delay10us(5);     //#################################################################################THIS

	// Output second line
	for(i = 16; i < 32u; i++)
	{
		// Erase the rest of the line if a null char is 
		// encountered (good for printing strings directly)
		if(LCDText[i] == 0u)
		{
			for(j=i; j < 32u; j++)
			{
				LCDText[j] = ' ';
			}
		}
		LCDWrite(1, LCDText[i]);
		Delay10us(5);  //#################################################################################THIS
	}
}

/******************************************************************************
 * Function:        void LCDErase(void)
 *
 * PreCondition:    LCDInit() must have been called once
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Clears LCDText[] and the LCD's internal display buffer
 *
 * Note:            None
 *****************************************************************************/
void LCDErase(void)
{
	// Clear display
	LCDWrite(0, 0x01);
	DelayMs(2);        //#################################################################################THIS

	// Clear local copy
	memset(LCDText, ' ', 32);
}

#endif	//#if defined(USE_LCD)
