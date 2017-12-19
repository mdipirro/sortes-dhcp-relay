#ifndef __PACKETCIRCULARLIST_H
#define __PACKETCIRCULARLIST_H

#ifdef STACK_USE_DHCP_RELAY
// Number of list items (maximum allowed: 7)
#define PACKET_LIST_ITEMS 5
// One more element is needed for correct handling of "full" state
#define PACKET_LIST_SIZE (PACKET_LIST_ITEMS+1)

// struct storing a DHCP packet and some other useful information
typedef struct {
	BOOTP_HEADER 	Header; // DHCP header
	BYTE 			MessageType; // MessageType
	BOOL 			IPAddressNotNull; // An Ip address has been required
	IP_ADDR			RequiredAddress; // Meaningful iff `IPAddressNotNull` == TRUE
} PACKET_DATA;

// actual circular list of PACKET_DATA, stored as an array
typedef struct {
	PACKET_DATA op[PACKET_LIST_SIZE]; // the list
	size_t head; // head pointer
	size_t tail; // tail pointer
	BOOL ready; // the list has been init
} PacketList;

// functions
int PacketListInit(PacketList*);
int PacketListIsEmpty(PacketList*);
int PacketListIsFull(PacketList*);
int PacketListPush(PacketList*, PACKET_DATA*);
int PacketListPop(PACKET_DATA*, PacketList*);

#endif

#endif
