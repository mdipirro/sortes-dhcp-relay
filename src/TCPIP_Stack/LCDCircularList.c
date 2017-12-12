#define __LCDCIRCULARLIST_C

#define __18F97J60
#define __SDCC__
#include "../Include/HardwareProfile.h"
#include "../Include/TCPIP_Stack/TCPIP.h" //ML

// One more element is needed for correct handling of "full" state
#define OP_LIST_SIZE (OP_LIST_ITEMS+1)

#ifdef USE_LCD

// LCD operation type
typedef struct
{
	char order;										// 0: free, 1: init, 2: erase, 3: update
	char text[ROWCHARS*2+1];		// Text to write, if any
} LCDOperation;

// LCD circular list type
typedef struct
{
	LCDOperation op[OP_LIST_SIZE];
	size_t head;
	size_t tail;
} LCDOperationList;

// LCD circular list
#pragma udata lcd_scn listLCD
static LCDOperationList listLCD;
// Ready flag
static char LCDListReady = 0;

char LCDListInit()
{
	size_t i;
	listLCD.head = 0;
	listLCD.tail = 0;
	// Set initial values
	for (i=0; i<OP_LIST_SIZE; i++)
	{
		listLCD.op[i].order = 0;
		listLCD.op[i].text[0] = '\0';
	}
	// Set list creation flag
	LCDListReady = 1;
	return 0;
}

char LCDListIsEmpty(void)
{
	// Check for wrong usage
	if (!LCDListReady)
		return -1;
	return (listLCD.head == listLCD.tail);
}

char LCDListIsFull(void)
{
	// Check for wrong usage
	if (!LCDListReady)
		return -1;
	return (listLCD.tail == ((listLCD.head + 1) % OP_LIST_SIZE));
}

char LCDListPush(char order, char text[])
{
	size_t i;
	// Check for wrong usage
	if (!LCDListReady)
		return -1;
	if (LCDListIsFull())
		return -2;
	// Update the list with the new value
	listLCD.op[listLCD.head].order = order;
	//strlcpy(listLCD.op[listLCD.head].text, text, ROWCHARS*2+1);
	for (i=0; i<ROWCHARS*2+1; i++)
		listLCD.op[listLCD.head].text[i] = text[i];
	// Increment the head pointer
	listLCD.head = (listLCD.head + 1) % OP_LIST_SIZE;
	return 0;
}

char LCDListPop(char *order, char text[])
{
	size_t i;
	// Check for wrong usage
	if (!LCDListReady)
		return -1;
	if (LCDListIsEmpty())
		return -2;
	// Copy values into the passed variables
	*order = listLCD.op[listLCD.tail].order;
	//strlcpy(text, listLCD.op[listLCD.tail].text, ROWCHARS*2+1);
	for (i=0; i<ROWCHARS*2+1; i++)
		text[i] = listLCD.op[listLCD.tail].text[i];
	// Reset fields to default values
 	listLCD.op[listLCD.tail].order = 0;
	listLCD.op[listLCD.tail].text[0] = '\0';
	// Increment the tail pointer
	listLCD.tail = (listLCD.tail + 1) % OP_LIST_SIZE;
	return 0;
}

#endif
