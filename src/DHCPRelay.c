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

#if !defined(STACK_CLIENT_MODE)
    #define STACK_CLIENT_MODE
#endif

#define BROADCAST               0xFFFFFFFF
#define SERVER_IP_ADDR_BYTE1    (192ul)
#define SERVER_IP_ADDR_BYTE2    (168ul)
#define SERVER_IP_ADDR_BYTE3    (97ul)
#define SERVER_IP_ADDR_BYTE4    (16ul)

// Declare AppConfig structure and some other supporting stack variables
APP_CONFIG AppConfig;
BYTE AN0String[8];

UDP_SOCKET serverToClient;
UDP_SOCKET clientToServer;

CURRENT_COMPONENT currentComponent;
COMPONENT1 comp1;
COMPONENT2 comp2;
COMPONENT3 comp3;
GET_SERVER_IP_ADDRESS_COMP comp2_2;

PacketList ServerMessages;
PacketList ClientMessages;

PACKET_DATA serverPacket;
PACKET_DATA clientPacket;

IP_ADDR RequiredAddress;

BOOL serverTurn; // used to alternate server and client listening
BOOL IPAddressNotNull;
BOOL N; // network resource
BOOL serverKnown;

NODE_INFO ServerInfo;

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

    comp1                       = WAITING_FOR_MESSAGE;
    comp2                       = SERVER_QUEUE_WAITING;
    comp3                       = CLIENT_QUEUE_WAITING;
    comp2_2                     = SEND_ARP_REQUEST;

    clientToServer              = UDPOpen(DHCP_SERVER_PORT, NULL, DHCP_CLIENT_PORT);
    serverToClient              = UDPOpen(DHCP_CLIENT_PORT, NULL, DHCP_SERVER_PORT);

    if (serverToClient == INVALID_UDP_SOCKET) {
        DisplayString(0, "Invalid Server");
        DEBUGMSG("INVALID SERVER SOCKET\r\n");
    } 
    if (clientToServer == INVALID_UDP_SOCKET) {
        DisplayString(16, "Invalid Client");
        DEBUGMSG("INVALID CLIENT SOCKET\r\n");
    }

    PacketListInit(&ServerMessages);
    PacketListInit(&ClientMessages);

    serverTurn                  = FALSE;

    IPAddressNotNull            = FALSE;

    N                           = FALSE;

    serverKnown                 = FALSE;

    ServerInfo.IPAddr.Val = SERVER_IP_ADDR_BYTE1 | 
            SERVER_IP_ADDR_BYTE2<<8ul | SERVER_IP_ADDR_BYTE3<<16ul | 
            SERVER_IP_ADDR_BYTE4<<24ul;

    DEBUGMSG("Init\r\n");
}

static int GetPacket(PACKET_DATA* pkt, UDP_SOCKET socket) {
    if(UDPIsGetReady(socket) < 241u) {
        //DisplayString(16, "NO");
        return 0;
    }
    if (pkt != NULL && socket != INVALID_UDP_SOCKET) {
        BYTE            toBeDiscarded; // used to throw away unused fields
        DWORD           magicCookie;
        BOOTP_HEADER    Header;
        BYTE            Type = 0u;
        BYTE            Option;
        BYTE            Len;
        BOOL            over = FALSE;

        DisplayString(0, "IN IF");

        //UDPIsGetReady(socket); // set the current socket
        UDPGetArray((BYTE*)&Header, sizeof(Header)); // get the header

        // validate hardware interface and message type FIXME
        if(Header.HardwareType != 1u)
            return 0;
        if(Header.HardwareLen != 6u)
            return 0;

        if (1/*Header.HardwareType == 1u && 
            Header.HardwareLen == 6u &&
            (Header.MessageType == 1u || Header.MessageType == 2u)*/) {
            /* 
            * read and discard the following unused fields:
            * - client hardware address
            * - server host name
            * - boot filename
            */ 
            BYTE i;
            DisplayString(0, "AFTER CHECK");
            for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++) {
                UDPGet(&toBeDiscarded);
            }
            
            // obtain magic cookie
            UDPGetArray((BYTE*)&magicCookie, sizeof(DWORD));
            // process options
            while (1) {
                DisplayString(0, "While");
                if(!UDPGet(&Option)) {
                    break;
                }
                if(Option == DHCP_END_OPTION) {
                    UDPDiscard();
                    break;
                }
                UDPGet(&Len); // get the length
                switch (Option) {
                    case DHCP_MESSAGE_TYPE:
                        UDPGet(&Type); // get the message type
                        switch (Type) {
                            case DHCP_DISCOVER_MESSAGE:
                                DisplayString(16, "DHCP Discover   ");
                                DEBUGMSG("DHCP Discover\r\n");
                                break;
                            case DHCP_REQUEST_MESSAGE:
                                DisplayString(16, "DHCP Request   ");
                                //DisplayIPValue(Header.ClientIP.Val);
                                DEBUGMSG("DHCP Request\r\n");
                                break;
                            case DHCP_OFFER_MESSAGE:
                                DisplayString(16, "DHCP Offer      ");
                                //DisplayIPValue(ServerInfo.IPAddr.Val);
                                DEBUGMSG("DHCP Offer\r\n");
                                break;
                            case DHCP_ACK_MESSAGE:
                                DisplayString(16, "DHCP ACK       ");
                                //DisplayIPValue(ServerInfo.IPAddr.Val);
                                DEBUGMSG("DHCP ACK\r\n");
                                break;
                        }
                        break;
                    case DHCP_PARAM_REQUEST_IP_ADDRESS:
                        if (Len == 4u) {
                            UDPGetArray((BYTE*)&RequiredAddress, Len);
                            IPAddressNotNull = TRUE;
                            DisplayIPValue(RequiredAddress.Val);
                        }
                        break;
                    /*case DHCP_END_OPTION:
                        UDPDiscard();
                        over == TRUE;
                        break;*/
                }
                // remove any unprocessed bytes
                while(Len) {
                    UDPGet(&i);
                    Len--;
                }
            }

            // prepare the packet to be pushed
            memcpy(&(pkt -> Header), &Header, sizeof(BOOTP_HEADER));
            memcpy(&(pkt -> RequiredAddress), &RequiredAddress, sizeof(IP_ADDR));
            memcpy(&(pkt -> MessageType), &Type, sizeof(BYTE));
            memcpy(&(pkt -> IPAddressNotNull), &IPAddressNotNull, sizeof(IP_ADDR));
            return 1;
        }
    } else {
        return 0;
    }
}

static int GetServerPacket() {
    DEBUGMSG("GET SERVER\r\n");
    return GetPacket(&serverPacket, serverToClient);
}

static int GetClientPacket() {
    DEBUGMSG("GET CLIENT\r\n");
    return GetPacket(&clientPacket, clientToServer);
}

static void SendToServer() {
    DisplayString(16, "SENDSV");
    if (UDPIsPutReady(clientToServer) >= 300u) {
        BYTE                i;
        UDP_SOCKET_INFO     *socket = &UDPSocketInfo[activeUDPSocket];
        PACKET_DATA         pkt;
        PacketListPop(&pkt, &ServerMessages);

        // set socket info
        socket -> remoteNode.IPAddr.Val = ServerInfo.IPAddr.Val;
        for(i = 0; i < 6; i++) {
            socket -> remoteNode.MACAddr.v[i] = ServerInfo.MACAddr.v[i];
        }

        //DEBUGMSG("Send Server\r\n");
       
        // copy header DHCP
        UDPPutArray((BYTE*)&(pkt.Header.MessageType), sizeof(pkt.Header.MessageType));
        UDPPutArray((BYTE*)&(pkt.Header.HardwareType), sizeof(pkt.Header.HardwareType));
        UDPPutArray((BYTE*)&(pkt.Header.HardwareLen), sizeof(pkt.Header.HardwareLen));
        UDPPutArray((BYTE*)&(pkt.Header.Hops), sizeof(pkt.Header.Hops));
        UDPPutArray((BYTE*)&(pkt.Header.TransactionID), sizeof(pkt.Header.TransactionID));
        UDPPutArray((BYTE*)&(pkt.Header.SecondsElapsed), sizeof(pkt.Header.SecondsElapsed));
        UDPPutArray((BYTE*)&(pkt.Header.BootpFlags), sizeof(pkt.Header.BootpFlags));
        UDPPutArray((BYTE*)&(pkt.Header.ClientIP), sizeof(pkt.Header.ClientIP));
        UDPPutArray((BYTE*)&(pkt.Header.YourIP), sizeof(pkt.Header.YourIP));
        UDPPutArray((BYTE*)&(pkt.Header.NextServerIP), sizeof(pkt.Header.NextServerIP));
        UDPPutArray((BYTE*)&(AppConfig.MyIPAddr), sizeof(AppConfig.MyIPAddr)); // giaddr
        UDPPutArray((BYTE*)&(pkt.Header.ClientMAC), sizeof(pkt.Header.ClientMAC));

        // the other fields are set to zero
        for (i = 0; i < 202u; i++) {
            UDPPut(0);
        }

        // put magic cookie as per RFC 1533.
        UDPPut(99);
        UDPPut(130);
        UDPPut(83);
        UDPPut(99);

        // put message type
        UDPPut(DHCP_MESSAGE_TYPE);
	    UDPPut(DHCP_MESSAGE_TYPE_LEN);
	    UDPPut(pkt.MessageType);

        // Option: Subnet Mask
	    UDPPut(DHCP_SUBNET_MASK);
	    UDPPut(sizeof(IP_ADDR));
	    UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

        // Option: Server identifier
        UDPPut(DHCP_SERVER_IDENTIFIER);	
        UDPPut(sizeof(IP_ADDR));
        UDPPutArray((BYTE*)&ServerInfo.IPAddr.Val, sizeof(IP_ADDR));

        // Option: Router/Gateway address
        UDPPut(DHCP_ROUTER);		
        UDPPut(sizeof(IP_ADDR));
        UDPPutArray((BYTE*)&ServerInfo.IPAddr.Val, sizeof(IP_ADDR));

        // if there is an IP address, add it
        if (pkt.IPAddressNotNull == TRUE) {
            UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS);
            UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
            UDPPutArray((BYTE*)&pkt.RequiredAddress, sizeof(IP_ADDR));
            IPAddressNotNull = FALSE; // reset the global variable used as a flag
        }

        UDPPut(DHCP_END_OPTION); // end the packet

        // add zero padding to ensure compatibility with old BOOTP relays that discard
        // packets smaller that 300 octets
        while(UDPTxCount < 300u) {
            UDPPut(0);
        }

        UDPFlush(); // transmit
        //DisplayString(0, "CL to SERV");
    }
}

static void SendToClient() {
    DisplayString(16, "SENDCL");
    if (UDPIsPutReady(serverToClient) >= 300u) {
        BYTE                i;
        UDP_SOCKET_INFO     *socket = &UDPSocketInfo[activeUDPSocket];
        PACKET_DATA         pkt;
        PacketListPop(&pkt, &ClientMessages);

        // set socket info
        socket -> remoteNode.IPAddr.Val = BROADCAST;
        socket -> remotePort = DHCP_CLIENT_PORT;
        for(i = 0; i < 6u; i++){ // copy client's MAC address (and take it from CHADDR)
            socket -> remoteNode.MACAddr.v[i] = pkt.Header.ClientMAC.v[i];
        }

        DEBUGMSG("Send Client\r\n");

        // copy header DHCP
        UDPPutArray((BYTE*)&(pkt.Header.MessageType), sizeof(pkt.Header.MessageType));
        UDPPutArray((BYTE*)&(pkt.Header.HardwareType), sizeof(pkt.Header.HardwareType));
        UDPPutArray((BYTE*)&(pkt.Header.HardwareLen), sizeof(pkt.Header.HardwareLen));
        UDPPutArray((BYTE*)&(pkt.Header.Hops), sizeof(pkt.Header.Hops));
        UDPPutArray((BYTE*)&(pkt.Header.TransactionID), sizeof(pkt.Header.TransactionID));
        UDPPutArray((BYTE*)&(pkt.Header.SecondsElapsed), sizeof(pkt.Header.SecondsElapsed));
        UDPPutArray((BYTE*)&(pkt.Header.BootpFlags), sizeof(pkt.Header.BootpFlags));
        UDPPutArray((BYTE*)&(pkt.Header.ClientIP), sizeof(pkt.Header.ClientIP));
        UDPPutArray((BYTE*)&(pkt.Header.YourIP), sizeof(pkt.Header.YourIP));
        UDPPutArray((BYTE*)&(pkt.Header.NextServerIP), sizeof(pkt.Header.NextServerIP));
        UDPPutArray((BYTE*)&(AppConfig.MyIPAddr), sizeof(AppConfig.MyIPAddr)); // giaddr
        UDPPutArray((BYTE*)&(pkt.Header.ClientMAC), sizeof(pkt.Header.ClientMAC));

        // the other fields are set to zero
        for (i = 0; i < 202u; i++) {
            UDPPut(0);
        }

        // put magic cookie 0x63538263, little endian
        UDPPut(0x63);
	    UDPPut(0x82);
	    UDPPut(0x53);
	    UDPPut(0x63);

        // put message type
        UDPPut(DHCP_MESSAGE_TYPE);
	    UDPPut(DHCP_MESSAGE_TYPE_LEN);
	    UDPPut(pkt.MessageType);

        UDPPut(DHCP_END_OPTION); // end packet

        // add zero padding to ensure compatibility with old BOOTP relays that discard
        // packets smaller that 300 octets
        while (UDPTxCount < 300u) {
            UDPPut(0);
        }

        UDPFlush(); // transmit
        //DisplayString(0, "SERV to CL");
    }
}

static void Component1() {
    //int res;
    switch(comp1) {
        // root
        case WAITING_FOR_MESSAGE:
            if (serverTurn == TRUE && UDPIsGetReady(serverToClient) > 240u) {
                if (N == FALSE) {
                    comp1 = FROM_SERVER;
                    N = TRUE;
                }
            } 
            if (serverTurn == FALSE && UDPIsGetReady(clientToServer) > 240u) {
                comp1 = CLIENT_MESSAGE_T;
                if (N == FALSE) {
                    comp1 = FROM_CLIENT;
                    N = TRUE;
                }
            }
            serverTurn = (serverTurn == TRUE) ? FALSE : TRUE;
            break;
        // server branch
        case FROM_SERVER:
            GetPacket(&serverPacket, serverToClient);
            comp1 = FROM_SERVER_T;
        case FROM_SERVER_T:
            N = FALSE;
            comp1 = PUSH_CLIENT_QUEUE;
            break;
        case PUSH_CLIENT_QUEUE:
            if (PacketListPush(&ClientMessages, &serverPacket) == 0) {
                // cross the transiction iff the push succeeded
                //DisplayString(16, "PUSH");
                comp1 = PUSH_CLIENT_QUEUE_T;
            } else {
                break;
            }
        case PUSH_CLIENT_QUEUE_T:
            comp1 = WAITING_FOR_MESSAGE;
            break;
        // client branch
        case FROM_CLIENT:
            GetPacket(&clientPacket, clientToServer);
            comp1 = FROM_CLIENT_T;
        case FROM_CLIENT_T:
            N = FALSE;
            comp1 = PUSH_SERVER_QUEUE;
            break;
        case PUSH_SERVER_QUEUE:
            if (PacketListPush(&ServerMessages, &clientPacket) == 0) {
                // cross the transiction iff the push succeeded
                comp1 = PUSH_SERVER_QUEUE_T;
            } else {
                break;
            }
        case PUSH_SERVER_QUEUE_T:
            comp1 = WAITING_FOR_MESSAGE;
            break;
    }
}

static void Component2() {
    switch (comp2) {
        case SERVER_QUEUE_WAITING:
            if (!PacketListIsEmpty(&ServerMessages)) {
                comp2 = SERVER_QUEUE_WAITING_T;
            } else {
                break;
            }
        case SERVER_QUEUE_WAITING_T:
            if (N == FALSE) {
                if (serverKnown == FALSE) {
                    comp2 = GET_SERVER_IP_ADDRESS;
                } else {
                    comp2 = TX_TO_SERVER;
                }
                N = TRUE;
            }
            //comp2 = TX_TO_SERVER;
            break;
        case GET_SERVER_IP_ADDRESS:
            switch (comp2_2) {
                case SEND_ARP_REQUEST:
                    ARPResolve(&ServerInfo.IPAddr);
                    //DisplayString(0, "Send ARP Request");
                    DEBUGMSG("ARP REQ\r\n");
                    comp2_2 = SEND_ARP_REQUEST_T;
                case SEND_ARP_REQUEST_T:
                    comp2_2 = PROCESS_ARP_ANSWER;
                    N = FALSE;
                    break;
                case PROCESS_ARP_ANSWER:
                    if (ARPIsResolved(&ServerInfo.IPAddr, &ServerInfo.MACAddr) == TRUE) {
                        DisplayString(0, "MACAddr Resolved");
                        serverKnown = TRUE;
                        comp2_2 = PROCESS_ARP_ANSWER_T;
                    } else {
                        comp2_2 = SEND_ARP_REQUEST;
                        break;
                    }
                case PROCESS_ARP_ANSWER_T:
                    if (N == FALSE) {
                        comp2_2 = SEND_ARP_REQUEST;
                        comp2 = TX_TO_SERVER;
                    }
                    break;
            }
            break;
        case TX_TO_SERVER:
            //DEBUGMSG("IN COMP2\r\n");
            SendToServer();
            comp2 = TX_TO_SERVER_T;
        case TX_TO_SERVER_T:
            N = FALSE;
            comp2 = SERVER_QUEUE_WAITING;
            break;
    }
}

static void Component3() {
    switch (comp3) {
        case CLIENT_QUEUE_WAITING:
            if (!PacketListIsEmpty(&ClientMessages)) {
                comp3 = CLIENT_QUEUE_WAITING_T;
            } else {
                break;
            }
        case CLIENT_QUEUE_WAITING_T:
            if (N == FALSE) {
                comp3 = TX_TO_CLIENT;
                N = TRUE;   
            }
            break;
        case TX_TO_CLIENT:
            SendToClient();
            comp3 = TX_TO_CLIENT_T;
        case TX_TO_CLIENT_T:
            N = FALSE;
            comp3 = CLIENT_QUEUE_WAITING;
            break;
    }
}

static void DHCPRelayTask() {
	/*ARPResolve(&ServerInfo.IPAddr);
	if (ARPIsResolved(&ServerInfo.IPAddr,&ServerInfo.MACAddr) == TRUE) {
        DisplayString(0, "Nothing");
    } else {
        DisplayString(0, "Done");
    }
}*/
    if (AppConfig.Flags.bIsDHCPEnabled) {
        switch(currentComponent) {
            case INIT:
                DHCPRelayInit();
                break;
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
                currentComponent = COMP1;
                break;
        }
        /*if (currentComponent == INIT) {
            DHCPRelayInit();
        }
        //Component1();
        GetClientPacket();*/
    } else {
        DEBUGMSG("DHCP NOT ENABLED\r\n");
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

    // Initialize and display message on the LCD
    LCDInit();
    DelayMs(100);
    DisplayString (0,"Olimex1"); //first arg is start position on 32 pos LCD

    /*#ifdef STACK_USE_DHCP_RELAY
        DHCPRelayInit();
    #endif*/
    currentComponent = INIT;

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
            DHCPRelayTask();
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
