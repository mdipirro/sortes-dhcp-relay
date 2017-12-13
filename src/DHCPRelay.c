/*********************************************************************
 *
 *  Main Application Entry Point and TCP/IP Stack Demo
 *  Module for Microchip TCP/IP Stack
 *   -Demonstrates how to call and use the Microchip TCP/IP stack
 *	 -Reference: AN833
 *
 *********************************************************************/

/*
 * This symbol uniquely defines this file as the main entry point.
 * There should only be one such definition in the entire project,
 * and this file must define the AppConfig variable as described below.
 * The processor configuration will be included in HardwareProfile.h
 * if this symbol is defined.
 */
#define THIS_INCLUDES_THE_MAIN_FUNCTION
#define THIS_IS_STACK_APPLICATION

// define the processor we use
#define __18F97J60
// define the compiler we use
#define __SDCC__

// inlude all hardware and compiler dependent definitions
#include "Include/HardwareProfile.h"
// Include all headers for any enabled TCPIP Stack functions
#include "Include/TCPIP_Stack/TCPIP.h"
// Include functions specific to this stack application
#include "Include/DHCPRelay.h"

//#ifdef __PACKETCIRCULARLIST_C
// Declare AppConfig structure and some other supporting stack variables
APP_CONFIG AppConfig;
BYTE AN0String[8];

UDP_SOCKET serverToClient;
UDP_SOCKET clientToServer;

typedef enum {
    COMP1,
    COMP2,
    COMP3,
    COMP4
} CURRENT_COMPONENT;

typedef enum {
    WAITING_SERVER_MESSAGE,
    WAITING_SERVER_MESSAGE_T,
    SERVER_MSG_PROC,
    SERVER_MSG_PROC_T,
    CLIENT_QUEUE_PUSH,
    CLIENT_QUEUE_PUSH_T
} COMPONENT1;

typedef enum {
    CLIENT_QUEUE_WAITING,
    CLIENT_QUEUE_WAITING_T,
    TX_TO_CLIENT,
    TX_TO_CLIENT_T
} COMPONENT2;

typedef enum {
    WAITING_CLIENT_MESSAGE,
    WAITING_CLIENT_MESSAGE_T,
    CLIENT_MSG_PROC,
    CLIENT_MSG_PROC_T,
    SERVER_QUEUE_PUSH,
    SERVER_QUEUE_PUSH_T
} COMPONENT3;

typedef enum {
    SERVER_QUEUE_WAITING,
    SERVER_QUEUE_WAITING_T,
    TX_TO_SERVER,
    TX_TO_SERVER_T
} COMPONENT4;

CURRENT_COMPONENT currentComponent;
COMPONENT1 comp1;
COMPONENT2 comp2;
COMPONENT3 comp3;
COMPONENT4 comp4;

PacketList ServerMessages;
PacketList ClientMessages;

BOOTP_HEADER serverMessage;
BOOTP_HEADER clientMessage;

BOOL stopGettingFromServer;
BOOL stopGettingFromClient;

// Private helper functions.
// These may or may not be present in all applications.
static void InitAppConfig(void);
static void InitializeBoard(void);
void DisplayWORD(BYTE pos, WORD w); //write WORDs on LCD for debugging

//
// PIC18 Interrupt Service Routines
// 
// NOTE: Several PICs, including the PIC18F4620 revision A3 have a RETFIE 
// FAST/MOVFF bug
// The interruptlow keyword is used to work around the bug when using C18

//LowISR
#if defined(__18CXX)
    #if defined(HI_TECH_C)
        void interrupt low_priority LowISR(void)
    #elif defined(__SDCC__)
        void LowISR(void) __interrupt (2) //ML for sdcc
    #else
        #pragma interruptlow LowISR
        void LowISR(void)
    #endif
    {
	TickUpdate();
    }
    #if !defined(__SDCC__) && !defined(HI_TECH_C)
           //automatic with these compilers
        #pragma code lowVector=0x18
	void LowVector(void){_asm goto LowISR _endasm}
	#pragma code // Return to default code section
    #endif


//HighISR	
    #if defined(HI_TECH_C)
        void interrupt HighISR(void)
    #elif defined(__SDCC__)
        void HighISR(void) __interrupt(1) //ML for sdcc        
    #else
        #pragma interruptlow HighISR
        void HighISR(void)
    #endif
    {
      //insert here code for high level interrupt, if any
    }
    #if !defined(__SDCC__) && !defined(HI_TECH_C)
           //automatic with these compilers
	#pragma code highVector=0x8
	void HighVector(void){_asm goto HighISR _endasm}
	#pragma code // Return to default code section
    #endif

#endif

const char* message;  //pointer to message to display on LCD

void DHCPRelayInit() {
    currentComponent    = COMP1;

    comp1                   = WAITING_SERVER_MESSAGE;
    comp2                   = CLIENT_QUEUE_WAITING;
    comp3                   = WAITING_CLIENT_MESSAGE;
    comp4                  = SERVER_QUEUE_WAITING;

    serverToClient          = UDPOpen(DHCP_SERVER_PORT, NULL, DHCP_CLIENT_PORT);
    clientToServer          = UDPOpen(DHCP_CLIENT_PORT, NULL, DHCP_SERVER_PORT);

    PacketListInit(&ServerMessages);
    PacketListInit(&ClientMessages);

    stopGettingFromServer   = FALSE;
    stopGettingFromClient   = FALSE;
}

void DHCPRelaytask() {
    switch(currentComponent) {
        case COMP1:
            Component1();
            currentComponent = COMP2;
            break;
        case COMP2:
            Component2();
            currentComponent = COMP3;
            break;
        case COMP3:
            Component3();
            currentComponent = COMP4;
            break;
        case COMP4:
            Component4();
            currentComponent = COMP1;
            break;
    }
}

void Component1() {
    switch(comp1) {
        case WAITING_SERVER_MESSAGE:
            // a packet is ready in the server's socket and there is at least a free spot in the queue
            if (stopGettingFromServer == FALSE && UDPIsGetReady(serverToClient) > 250u) {
                comp1 = WAITING_SERVER_MESSAGE_T;
            }
        case WAITING_SERVER_MESSAGE_T:
            comp1 = SERVER_MSG_PROC;
            break;
        case SERVER_MSG_PROC:
            // TODO get message and manipulate fields
            comp1 = SERVER_MSG_PROC_T;
        case SERVER_MSG_PROC_T:
            comp1 = CLIENT_QUEUE_PUSH;
            break;
        case CLIENT_QUEUE_PUSH:
            if (PacketListPush(&ClientMessages, &clientMessage) == 0) {
                // cross the transiction iff the push succeeded
                comp1 = CLIENT_QUEUE_PUSH_T;
            } else {
                // otherwise wait until there is a free spot in the queue
                stopGettingFromServer = TRUE; 
            }
        case CLIENT_QUEUE_PUSH_T:
            comp1 = WAITING_SERVER_MESSAGE;
            break;
    }
}

void Component2() {
    switch (comp2) {
        case CLIENT_QUEUE_WAITING:
            if (!PacketListIsEmpty(&ClientMessages)) {
                comp2 = CLIENT_QUEUE_WAITING_T;
            }
        case CLIENT_QUEUE_WAITING_T:
            comp2 = TX_TO_CLIENT;
            break;
        case TX_TO_CLIENT:
            // TODO get packet from the queue and transmit to the client
            stopGettingFromServer = FALSE;
            comp2 = TX_TO_CLIENT_T;
        case TX_TO_CLIENT_T:
            comp2 = CLIENT_QUEUE_WAITING;
            break;
    }
}

void Component3() {
    switch(comp3) {
        case WAITING_CLIENT_MESSAGE:
            // a packet is ready in the client's socket and there is at least a free spot in the queue
            if (stopGettingFromClient == FALSE && UDPIsGetReady(clientToServer) > 250u) {
                comp3 = WAITING_CLIENT_MESSAGE_T;
            }
        case WAITING_CLIENT_MESSAGE_T:
            comp3 = CLIENT_MSG_PROC;
            break;
        case CLIENT_MSG_PROC:
            // TODO get message and manipulate fields
            comp3 = CLIENT_MSG_PROC_T;
        case CLIENT_MSG_PROC_T:
            comp3 = SERVER_QUEUE_PUSH;
            break;
        case SERVER_QUEUE_PUSH:
            if (PacketListPush(&ServerMessages, &serverMessage) == 0) {
                // cross the transiction iff the push succeeded
                comp3 = SERVER_QUEUE_PUSH_T;
            } else {
                // otherwise wait until there is a free spot in the queue
                stopGettingFromClient = TRUE; 
            }
        case SERVER_QUEUE_PUSH_T:
            comp3 = WAITING_CLIENT_MESSAGE;
            break;
    }
}

void Component4() {
    switch (comp4) {
        case SERVER_QUEUE_WAITING:
            if (!PacketListIsEmpty(&ServerMessages)) {
                comp4 = SERVER_QUEUE_WAITING_T;
            }
        case SERVER_QUEUE_WAITING_T:
            comp4 = TX_TO_SERVER;
            break;
        case TX_TO_SERVER:
            // TODO get packet from the queue and transmit to the server
            stopGettingFromClient = FALSE;
            comp4 = TX_TO_SERVER_T;
        case TX_TO_SERVER_T:
            comp4 = SERVER_QUEUE_WAITING;
            break;
    }
}

//
// Main application entry point.
//


#if defined(__18CXX) || defined(__SDCC__)
void main(void)
#else
int main(void)
#endif
{
static TICK t = 0; 
TICK nt = 0;  //TICK is DWORD, thus 32 bits
BYTE loopctr = 0;  //ML Debugging
WORD lloopctr = 14; //ML Debugging

static DWORD dwLastIP = 0;
	
    // Initialize interrupts and application specific hardware
    InitializeBoard();

    // Initialize Timer0, and low priority interrupts, used as clock.
    TickInit();

    // Initialize Stack and application related variables in AppConfig.
    InitAppConfig();

    // Initialize core stack layers (MAC, ARP, TCP, UDP) and
    // application modules (HTTP, SNMP, etc.)
    StackInit();

    #ifdef UART_DEBUG_ON
        UARTConfig();
    #endif

    #ifdef USE_LCD
        LCDTaskInit();
    #endif

    #ifdef STACK_USE_DHCP_RELAY
        DHCPRelayInit();
    #endif

    // Initialize and display message on the LCD
    LCDInit();
    DelayMs(100);
    DisplayString (0,"Olimex"); //first arg is start position on 32 pos LCD

    // Now that all items are initialized, begin the co-operative
    // multitasking loop.  This infinite loop will continuously 
    // execute all stack-related tasks, as well as your own
    // application's functions.  Custom functions should be added
    // at the end of this loop.

    // Note that this is a "co-operative multi-tasking" mechanism
    // where every task performs its tasks (whether all in one shot
    // or part of it) and returns so that other tasks can do their
    // job.
    // If a task needs very long time to do its job, it must be broken
    // down into smaller pieces so that other tasks can have CPU time.


    while(1)
    {

         // Blink LED0 (right most one) every second.
        nt =  TickGetDiv256();
        if((nt - t) >= (DWORD)(TICK_SECOND/1024ul))
        {
            t = nt;
            LED0_IO ^= 1;
            ClrWdt();  //Clear the watchdog
        }

        // This task performs normal stack task including checking
        // for incoming packet, type of packet and calling
        // appropriate stack entity to process it.
        StackTask();
        
        // This tasks invokes each of the core stack application tasks
        //        StackApplications(); //all except dhcp, ping and arp

        // LCD task
        #ifdef USE_LCD
            LCDTask();
        #endif

        // Process application specific tasks here.
        #ifdef STACK_USE_DHCP_RELAY
            DHCPRelaytask();
        #endif
        
        // If the local IP address has changed (ex: due to DHCP lease change)
        // write the new IP address to the LCD display, UART, and Announce 
        // service
        if(dwLastIP != AppConfig.MyIPAddr.Val)
        {
            dwLastIP = AppConfig.MyIPAddr.Val;
                #if defined(__SDCC__)
                    DisplayIPValue(dwLastIP); // must be a WORD: sdcc does not
                                            // pass aggregates
                #else
                    DisplayIPValue(AppConfig.MyIPAddr);
                #endif
        }
    }//end of while(1)
}//end of main()

/*************************************************
 Function DisplayWORD:
 writes a WORD in hexa on the position indicated by
 pos. 
 - pos=0 -> 1st line of the LCD
 - pos=16 -> 2nd line of the LCD

 __SDCC__ only: for debugging
*************************************************/
#if defined(__SDCC__)
void DisplayWORD(BYTE pos, WORD w) //WORD is a 16 bits unsigned
{
    BYTE WDigit[6]; //enough for a  number < 65636: 5 digits + \0
    BYTE j;
    BYTE LCDPos=0;  //write on first line of LCD
    unsigned radix=10; //type expected by sdcc's ultoa()

    LCDPos=pos;
    ultoa(w, WDigit, radix);      
    for(j = 0; j < strlen((char*)WDigit); j++)
    {
       LCDText[LCDPos++] = WDigit[j];
    }
    if(LCDPos < 32u)
       LCDText[LCDPos] = 0;
    LCDUpdate();
}
/*************************************************
 Function DisplayString: 
 Writes an IP address to string to the LCD display
 starting at pos
*************************************************/
void DisplayString(BYTE pos, char* text)
{
   BYTE l= strlen(text)+1;
   BYTE max= 32-pos;
   strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
   LCDUpdate();
}
#endif

/*************************************************
 Function DisplayIPValue: 
 Writes an IP address to the LCD display
*************************************************/

#if defined(__SDCC__)
void DisplayIPValue(DWORD IPdw) // 32 bits
#else
void DisplayIPValue(IP_ADDR IPVal) 
#endif
{
    BYTE IPDigit[4]; //enough for a number <256: 3 digits + \0
    BYTE i;
    BYTE j;
    BYTE LCDPos=16;  //write on second line of LCD
#if defined(__SDCC__)
    unsigned int IP_field, radix=10; //type expected by sdcc's uitoa()
#endif

    for(i = 0; i < sizeof(IP_ADDR); i++) //sizeof(IP_ADDR) is 4
    {
#if defined(__SDCC__)
       IP_field =(WORD)(IPdw>>(i*8))&0xff;      //ML
       uitoa(IP_field, IPDigit, radix);      //ML
#else
       uitoa((WORD)IPVal.v[i], IPDigit);
#endif

       for(j = 0; j < strlen((char*)IPDigit); j++)
       {
	   LCDText[LCDPos++] = IPDigit[j];
       }
       if(i == sizeof(IP_ADDR)-1)
	    break;
       LCDText[LCDPos++] = '.';

    }
    if(LCDPos < 32u)
       LCDText[LCDPos] = 0;
    LCDUpdate();
}


/****************************************************************************
  Function:
    static void InitializeBoard(void)

  Description:
    This routine initializes the hardware.  It is a generic initialization
    routine for many of the Microchip development boards, using definitions
    in HardwareProfile.h to determine specific initialization.

  Precondition:
    None

  Parameters:
    None - None

  Returns:
    None

  Remarks:
    None
  ***************************************************************************/
static void InitializeBoard(void)
{	
	// LEDs
    LED0_TRIS = 0;  //LED0
	LED1_TRIS = 0;  //LED1
	LED2_TRIS = 0;  //LED2
	LED3_TRIS = 0;  //LED_LCD1
	LED4_TRIS = 0;  //LED_LCD2
	LED5_TRIS = 0;  //LED5=RELAY1
	LED6_TRIS = 0;  //LED7=RELAY2
#if (!defined(EXPLORER_16) &&!defined(OLIMEX_MAXI))    // Pin multiplexed with 
	// a button on EXPLORER_16 and not used on OLIMEX_MAXI
	LED7_TRIS = 0;
#endif
        LED_PUT(0x00);  //turn off LED0 - LED2
	RELAY_PUT(0x00); //turn relays off to save power

	// Set clock to 25 MHz
	// The primary oscillator runs at the speed of the 25MHz external quartz
    OSCTUNE = 0x00;

	// Switch to primary oscillator mode, 
        // regardless of if the config fuses tell us to start operating using 
        // the the internal RC
	// The external clock must be running and must be 25MHz for the 
	// Ethernet module and thus this Ethernet bootloader to operate.
    if(OSCCONbits.IDLEN) //IDLEN = 0x80; 0x02 selects the primary clock
		OSCCON = 0x82;
	else
		OSCCON = 0x02;

	// Enable Interrupts
	RCONbits.IPEN = 1;		// Enable interrupt priorities
        INTCONbits.GIEH = 1;
        INTCONbits.GIEL = 1;

}

/*********************************************************************
 * Function:        void InitAppConfig(void)
 *
 * PreCondition:    MPFSInit() is already called.
 *
 * Input:           None
 *
 * Output:          Write/Read non-volatile config variables.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/

static void InitAppConfig(void)
{
	AppConfig.Flags.bIsDHCPEnabled = TRUE;
	AppConfig.Flags.bInConfigMode = TRUE;

//ML using sdcc (MPLAB has a trick to generate serial numbers)
// first 3 bytes indicate manufacturer; last 3 bytes are serial number
	AppConfig.MyMACAddr.v[0] = 0;
	AppConfig.MyMACAddr.v[1] = 0x04;
	AppConfig.MyMACAddr.v[2] = 0xA3;
	AppConfig.MyMACAddr.v[3] = 0x01;
	AppConfig.MyMACAddr.v[4] = 0x02;
	AppConfig.MyMACAddr.v[5] = 0x03;

//ML if you want to change, see TCPIPConfig.h
	AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 | 
            MY_DEFAULT_IP_ADDR_BYTE2<<8ul | MY_DEFAULT_IP_ADDR_BYTE3<<16ul | 
            MY_DEFAULT_IP_ADDR_BYTE4<<24ul;
	AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
	AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 | 
            MY_DEFAULT_MASK_BYTE2<<8ul | MY_DEFAULT_MASK_BYTE3<<16ul | 
            MY_DEFAULT_MASK_BYTE4<<24ul;
	AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
	AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 | 
            MY_DEFAULT_GATE_BYTE2<<8ul | MY_DEFAULT_GATE_BYTE3<<16ul | 
            MY_DEFAULT_GATE_BYTE4<<24ul;
	AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 | 
            MY_DEFAULT_PRIMARY_DNS_BYTE2<<8ul  | 
            MY_DEFAULT_PRIMARY_DNS_BYTE3<<16ul  | 
            MY_DEFAULT_PRIMARY_DNS_BYTE4<<24ul;
	AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 | 
            MY_DEFAULT_SECONDARY_DNS_BYTE2<<8ul  | 
            MY_DEFAULT_SECONDARY_DNS_BYTE3<<16ul  | 
            MY_DEFAULT_SECONDARY_DNS_BYTE4<<24ul;
}