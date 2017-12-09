#ifndef __LCDCIRCULARLIST_H
#define __LCDCIRCULARLIST_H

#ifdef USE_LCD
#define OP_LIST_MAX 10
// Number of characters of a single line of the LCD display
#define ROWCHARS 16

char LCDListInit();
char LCDListIsEmpty(void);
char LCDListIsFull(void);
char LCDListPush(char order, char text[]);
char LCDListPop(char *order, char text[]);
#endif

#endif