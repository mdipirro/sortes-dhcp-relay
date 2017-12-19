#define __PACKETCIRCULARLIST_C

#define __18F97J60
#define __SDCC__
#include "../Include/HardwareProfile.h"
#include "../Include/TCPIP_Stack/TCPIP.h" //ML

#ifdef STACK_USE_DHCP_RELAY

/** 
 * Init the circular list by setting both `head` and `tail` to 0.
 * The `ready` flag is then set to TRUE.
 * @param list The list to init
 * @return 0
 */ 
int PacketListInit(PacketList* list) {
	list -> head = 0;
	list -> tail = 0;
	// Set list creation flag
	list -> ready = TRUE;
	return 0;
}

/**
 * Check if the list is empty or not.
 * @param list The list.
 * @return 	1 iff the list is ready and empty;
 * 			0 iff the list is ready and not empty;
 * 			-1 otherwise
 */ 
int PacketListIsEmpty(PacketList* list) {
	// Check for wrong usage
	if (list -> ready == FALSE)
		return -1;
	return (list -> head == list -> tail);
}

/**
 * Check if the list is full or not.
 * @param list The list
 * @return 	1 iff the list is ready and full;
 * 			0 iff the list is ready and not full;
 * 			-1 otherwise
 */ 
int PacketListIsFull(PacketList* list)
{
	// Check for wrong usage
	if (list -> ready == FALSE)
		return -1;
	return (list -> tail == ((list -> head + 1) % PACKET_LIST_SIZE));
}

/**
 * Push a packet in the list. If the list is full, the last (meaning the oldest)
 * packet is dropped.
 * @param list The list
 * @param packet The packet to be pushed
 * @return 	0 iff the push succeeded, -1 otherwise
 */ 
int PacketListPush(PacketList* list, PACKET_DATA* packet) {
	// Check for wrong usage
	if (list -> ready == FALSE)
		return -1;
	memcpy(&(list -> op[list -> head]), packet, sizeof(PACKET_DATA));
	// Increment the head pointer
	list -> head = (list -> head + 1) % PACKET_LIST_SIZE;
	return 0;
}

/**
 * Pop a packet from the list, meaning the oldest in it. The list then follows
 * a FIFO policy.
 * @param packet A pointer to the variable which will store the popped packet
 * @param list The list
 * @return 	0 iff the pop succeeded
 * 			-1 if the list is not ready
 * 			-2 if the list is empty
 */ 
int PacketListPop(PACKET_DATA* packet, PacketList* list) {
	// Check for wrong usage
	if (list -> ready == FALSE)
		return -1;
	if (PacketListIsEmpty(list))
		return -2;
	memcpy(packet, &(list -> op[list -> head]), sizeof(PACKET_DATA));
	// Increment the tail pointer
	list -> tail = (list -> tail + 1) % PACKET_LIST_SIZE;
	return 0;
}

#endif
