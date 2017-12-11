 #ifndef __DEBUG_H
 #define __DEBUG_H

#ifdef UART_DEBUG_ON
    #define STACK_USE_UART
    #define DEBUGMSG(x) UARTPuts(x)
#else
    #define DEBUGMSG(x)
#endif

#endif
