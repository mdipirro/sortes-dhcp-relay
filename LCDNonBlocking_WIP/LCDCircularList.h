 #ifndef LCDCIRCULARLIST_H
 #define LCDCIRCULARLIST_H

#ifdef USE_LCD
// LCD operation type
typedef struct
{
	char order;										// 0: free, 1: init, 2: erase, 3: update
	char text[ROWCHARS*2+1];		// Text to write, if any
} LCDOperation;

// Number of characters of a single line of the LCD display
#define ROWCHARS 16

char LCDListInit(size_t numOfElements);
char LCDListIsEmpty(void);
char LCDListIsFull(void);
char LCDListPush(LCDOperation op);
char LCDListPop(*LCDOperation op);
char LCDListDelete(void);
#endif

#endif