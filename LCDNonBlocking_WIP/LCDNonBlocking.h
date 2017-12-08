#ifndef __LCDNONBLOCKING_H
#define __LCDNONBLOCKING_H

// Do not include this source file if there is no LCD on the 
// target board
#ifdef USE_LCD


extern BYTE LCDText[16*2+1];
void LCDTaskInit(void);
void LCDTask(void);
void LCDInit(void);
void LCDUpdate(void);
void LCDErase(void);

#endif
#endif
