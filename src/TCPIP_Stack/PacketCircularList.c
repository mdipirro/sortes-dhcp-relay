#define __PACKETCIRCULARLIST_C

#define __18F97J60
#define __SDCC__
#include "../Include/HardwareProfile.h"
#include "../Include/TCPIP_Stack/TCPIP.h" //ML

#ifdef STACK_USE_DHCP_RELAY

int PacketListInit(PacketList* list)
{
	list -> head = 0;
	list -> tail = 0;
	// Set list creation flag
	list -> ready = TRUE;
	return 0;
}

int PacketListIsEmpty(PacketList* list)
{
	// Check for wrong usage
	if (!list -> ready)
		return -1;
	return (list -> head == list -> tail);
}

int PacketListIsFull(PacketList* list)
{
	// Check for wrong usage
	if (!list -> ready)
		return -1;
	return (list -> tail == ((list -> head + 1) % PACKET_LIST_SIZE));
}

int PacketListPush(PacketList* list, PACKET_DATA* packet)
{
	// Check for wrong usage
	if (!list -> ready)
		return -1;
	if (PacketListIsFull(list))
		return -2;
	memcpy(&(list -> op[list -> head]), packet, sizeof(BOOTP_HEADER));
	// Increment the head pointer
	list -> head = (list -> head + 1) % PACKET_LIST_SIZE;
	return 0;
}

int PacketListPop(PACKET_DATA* packet, PacketList* list)
{
	// Check for wrong usage
	if (!list -> ready)
		return -1;
	if (PacketListIsEmpty(list))
		return -2;
	memcpy(packet, &(list -> op[list -> head]), sizeof(PACKET_DATA));
	// Increment the tail pointer
	list -> tail = (list -> tail + 1) % PACKET_LIST_SIZE;
	return 0;
}

#endif
