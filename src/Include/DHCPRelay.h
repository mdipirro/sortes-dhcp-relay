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
    static void DHCPRelayInit();
    static void DHCPRelaytask();
    static void GetServerPacket();
    static void GetClientPacket();
    static void SendToServer();
    static void SendToClient();
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
