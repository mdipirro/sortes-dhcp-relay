# DHCP Relay - Software for Real-Time and Embedded Systems

This repository contains the second project of the course [Software for Real-Time and Embedded Systems](https://onderwijsaanbod.kuleuven.be/syllabi/e/H04L2AE.htm) taught at KU Leuven as part of the [Master in Computer Science](https://onderwijsaanbod.kuleuven.be/opleidingen/e/SC_52364422.htm) (option Secure Software), during the 1st semester.

The project consists of the design and implementation of a DHCP relay using a 18F97J60 Microchip microcontroller. The board comes with a TCP/IP suite (provided by Microchip). This suite is used to implement the relay, and heavily modified to be compiled by SDCC. The relay activities (receiving and transmitting packets, displaying things, and so on) must be handled in a cooperative way (using a round robin scheduling). 

In this repository you will find the following material:
- An ASG diagram showing the high-level behavior of a (half-duplex) DHCP relay (the definitive version in is diagrams/DHCPRelay3);
- The implementation making use of the TCP/IP suite provided by Microchip. The main files are:
     - `DHCPRelay.c` and its corresponding header file (in Include/);
     - `LCDNonBlocking.c` (in TCPIP_Stack), toghether with the circular list used to schedule LDC operations (`LCDCircularList.c`, and its corresponding header file, in Include/TCPIP_Stack);
     - `PacketCircularList.c`, used to maintain a queue of non-sent packets (and its corresponding header file, in Include/TCPIP_Stack).
     
The `Makefile` compiles the project. Instructions of how to download it on the board can be found in the report. In order to compile the source code, the following software must be installed:
- SDCC (20091215-5595), and
- GPUtils, version 0.13.7.

Please note that the UCLouvain ASG editor must also be installed. Anyways, you may find the diagram in the report.
