#include "LCDCircularList.h"

#ifdef USE_LCD
// LCD circular list type
typedef struct
{
	LCDOperation *element;
	size_t head;
	size_t tail;
	size_t size;
} LCDOperationList;

// LCD circular list
static LCDOperationList listLCD;
static char LCDListCreated = 0;

char LCDListInit(size_t numOfElements)
{
	int i;
	// Allocate the elements
	listLCD.element = (LCDOperation *)malloc(sizeof(LCDOperation) * (numOfElements + 1));
	if (listLCD.element == NULL)
		return -1;
	listLCD.size = numOfElements + 1;		// One more element is needed for correct handling of "full" state
	listLCD.head = 0;
	listLCD.tail = 0;
	// Set initial values
	for (i=0; i<numOfElements; i++)
	{
		listLCD.element[i].order = 0;
		listLCD.element[i].text[0] = '\0';
	}
	// Set list creation flag
	LCDListCreated = 1;
}

char LCDListIsEmpty(void)
{
	// Check for wrong usage
	if (!LCDListCreated)
		return -1;
	return (listLCD.head == listLCD.tail);
}

char LCDListIsFull(void)
{
	// Check for wrong usage
	if (!LCDListCreated)
		return -1;
	return (listLCD.tail == ((listLCD.head + 1) % listLCD.size));
}

char LCDListPush(LCDOperation opLCD)
{
	// Check for wrong usage
	if (!LCDListCreated)
		return -1;
	if (LCDListIsFull())
		return -2;
	// Update the list with the new value
	listLCD.element[head].order = opLCD.order;
	strlcpy(listLCD.element[head].text, opLCD.text, ROWCHARS*2);
	// Increment the head pointer
	listLCD.head = (listLCD.head + 1) % listLCD.size;
	return 0;
}

char LCDListPop(*LCDOperation opLCD)
{
	// Check for wrong usage
	if (!LCDListCreated)
		return -1;
	if (LCDListIsEmpty())
		return -2;
	// Copy values into the passed variables
	opLCD->order = listLCD.element[tail].order;
	strlcpy(opLCD->text, listLCD.element[tail].text, ROWCHARS*2);
	// Reset fields to default values
 	listLCD.element[tail].order = 0;
	listLCD.element[tail].text[0] = '\0';
	// Increment the tail pointer
	listLCD.tail = (listLCD.tail + 1) % listLCD.size;
}

char LCDListDelete(void)
{
	// Check for wrong usage
	if (!LCDListCreated)
		return -1;
	// Free the element array
	free(listLCD.element);
	// Reset head, tail and size
	listLCD.head = 0;
	listLCD.tail =0;
	listLCD.size = 0:
	// Reset creation flag
	LCDListCreated = 0;
	return 0;
}
#endif