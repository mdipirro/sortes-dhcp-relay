/*********************************************************************
 * FileName:        DHCPRelay.h
 * Dependencies:    Compiler.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 ********************************************************************/
#ifndef _DHCPRELAY_H
#define _DHCPRELAY_H
#define STACK_USE_DHCP_RELAY
#include "GenericTypeDefs.h"
#include "TCPIP_Stack/TCPIP.h"

//#define BAUD_RATE       (19200)		// bps

#if !defined(THIS_IS_STACK_APPLICATION)
	extern BYTE AN0String[8];
#endif

//MLvoid DoUARTConfig(void);

//ML#if defined(EEPROM_CS_TRIS) || defined(SPIFLASH_CS_TRIS)
//ML	void SaveAppConfig(void);
//ML#else
	#define SaveAppConfig()
//ML#endif

//MLvoid SMTPDemo(void);
void PingDemo(void);
//MLvoid SNMPTrapDemo(void);
//MLvoid GenericTCPClient(void);
//MLvoid GenericTCPServer(void);
//void BerkeleyTCPClientDemo(void);
//void BerkeleyTCPServerDemo(void);
//void BerkeleyUDPClientDemo(void);

#ifdef STACK_USE_DHCP_RELAY
    // enum representing the current relay component on the processor
    typedef enum {
        INIT,   // init the DHCP relay parameters
        COMP1,  // listening for packets
        COMP2,  // sending to server
        COMP3   // sending to client
    } CURRENT_COMPONENT;

    typedef enum {
        WAITING_FOR_MESSAGE,    // Polling for packets
        /*SERVER_MESSAGE_T,
        CLIENT_MESSAGE_T,
        FROM_SERVER,
        FROM_SERVER_T,*/
        PUSH_SERVER_QUEUE,      // push in the server queue
        PUSH_SERVER_QUEUE_T,
        /*FROM_CLIENT,
        FROM_CLIENT_T,*/
        PUSH_CLIENT_QUEUE,      // push in the client queue
        PUSH_CLIENT_QUEUE_T,
    } COMPONENT1;

    typedef enum {
        SERVER_QUEUE_WAITING,   // wait for a packet to be sent
        SERVER_QUEUE_WAITING_T,
        GET_SERVER_IP_ADDRESS,  // issue an ARP request
        GET_SERVER_IP_ADDRESS_T,
        TX_TO_SERVER,           // actually transmit the packet
        TX_TO_SERVER_T
    } COMPONENT2;

    typedef enum {
        CLIENT_QUEUE_WAITING,   //wait for a packet to be sent
        CLIENT_QUEUE_WAITING_T,
        TX_TO_CLIENT,           // transmit the packet
        TX_TO_CLIENT_T
    } COMPONENT3;

    typedef enum {
        SEND_ARP_REQUEST,       // issue the ARP request
        SEND_ARP_REQUEST_T,
        PROCESS_ARP_ANSWER,     // get the answer or reissue the request
        PROCESS_ARP_ANSWER_T
    } GET_SERVER_IP_ADDRESS_COMP;

    static int DHCPRelayInit();
    static void DHCPRelayTask();
    static int GetServerPacket();
    static int GetClientPacket();
    static void SendToServer();
    static void SendToClient();
    static void Component1();
    static void Component2();
    static void Component3();
#endif

// An actual function defined in DHCPRelay.c for displaying the current IP 
// address on the LCD.
#if defined(__SDCC__)
    void DisplayIPValue(DWORD IPVal);
    void DisplayString(BYTE pos, char* text);
    void DisplayWORD(BYTE pos, WORD w);
#else
    void DisplayIPValue(IP_ADDR IPVal);
#endif

#endif // _DHCPRELAY_H
