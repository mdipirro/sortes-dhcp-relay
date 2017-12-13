#ifndef __PACKETCIRCULARLIST_H
#define __PACKETCIRCULARLIST_H

#ifdef STACK_USE_DHCP_RELAY
// Number of list items (maximum allowed: 7)
#define PACKET_LIST_ITEMS 5
// One more element is needed for correct handling of "full" state
#define PACKET_LIST_SIZE (PACKET_LIST_ITEMS+1)

typedef struct
{
	BOOTP_HEADER op[PACKET_LIST_SIZE];
	size_t head;
	size_t tail;
	BOOL ready;
} PacketList;

// functions
int PacketListInit(PacketList*);
int PacketListIsEmpty(PacketList*);
int PacketListIsFull(PacketList*);
int PacketListPush(PacketList*, BOOTP_HEADER*);
int PacketListPop(BOOTP_HEADER*, PacketList*);

#endif

#endif
