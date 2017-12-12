#ifndef __MYUART_H
#define __MYUART_H

#ifdef STACK_USE_UART
void UARTConfig(void);
void UARTPutc(char c);
void UARTPuts(char *udata);
void UARTPutblk(char *udata, size_t size, int sz);
#endif

#endif
