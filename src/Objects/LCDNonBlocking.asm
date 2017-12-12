;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 15 2017) (UNIX)
; This file was generated Tue Dec 12 15:19:41 2017
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _LCDTaskInit
	global _LCDTask
	global _LCDInit
	global _LCDErase
	global _LCDUpdate
	global _LCDText

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _EBSTCONbits
	extern _MISTATbits
	extern _EFLOCONbits
	extern _MACON1bits
	extern _MACON2bits
	extern _MACON3bits
	extern _MACON4bits
	extern _MACLCON1bits
	extern _MACLCON2bits
	extern _MICONbits
	extern _MICMDbits
	extern _EWOLIEbits
	extern _EWOLIRbits
	extern _ERXFCONbits
	extern _EIEbits
	extern _ESTATbits
	extern _ECON2bits
	extern _EIRbits
	extern _EDATAbits
	extern _SSP2CON2bits
	extern _SSP2CON1bits
	extern _SSP2STATbits
	extern _ECCP2DELbits
	extern _ECCP2ASbits
	extern _ECCP3DELbits
	extern _ECCP3ASbits
	extern _RCSTA2bits
	extern _TXSTA2bits
	extern _CCP5CONbits
	extern _CCP4CONbits
	extern _T4CONbits
	extern _ECCP1DELbits
	extern _BAUDCON2bits
	extern _BAUDCTL2bits
	extern _BAUDCONbits
	extern _BAUDCON1bits
	extern _BAUDCTLbits
	extern _BAUDCTL1bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _PORTFbits
	extern _PORTGbits
	extern _PORTHbits
	extern _PORTJbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _LATFbits
	extern _LATGbits
	extern _LATHbits
	extern _LATJbits
	extern _DDRAbits
	extern _TRISAbits
	extern _DDRBbits
	extern _TRISBbits
	extern _DDRCbits
	extern _TRISCbits
	extern _DDRDbits
	extern _TRISDbits
	extern _DDREbits
	extern _TRISEbits
	extern _DDRFbits
	extern _TRISFbits
	extern _DDRGbits
	extern _TRISGbits
	extern _DDRHbits
	extern _TRISHbits
	extern _DDRJbits
	extern _TRISJbits
	extern _OSCTUNEbits
	extern _MEMCONbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _PIE3bits
	extern _PIR3bits
	extern _IPR3bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _RCSTA1bits
	extern _TXSTAbits
	extern _TXSTA1bits
	extern _PSPCONbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _CCP3CONbits
	extern _ECCP3CONbits
	extern _CCP2CONbits
	extern _ECCP2CONbits
	extern _CCP1CONbits
	extern _ECCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSP1CON2bits
	extern _SSPCON2bits
	extern _SSP1CON1bits
	extern _SSPCON1bits
	extern _SSP1STATbits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _ECON1bits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _stdin
	extern _stdout
	extern _AN0String
	extern _AppConfig
	extern _activeUDPSocket
	extern _UDPSocketInfo
	extern _UDPTxCount
	extern _UDPRxCount
	extern _MAADR5
	extern _MAADR6
	extern _MAADR3
	extern _MAADR4
	extern _MAADR1
	extern _MAADR2
	extern _EBSTSD
	extern _EBSTCON
	extern _EBSTCS
	extern _EBSTCSL
	extern _EBSTCSH
	extern _MISTAT
	extern _EFLOCON
	extern _EPAUS
	extern _EPAUSL
	extern _EPAUSH
	extern _MACON1
	extern _MACON2
	extern _MACON3
	extern _MACON4
	extern _MABBIPG
	extern _MAIPG
	extern _MAIPGL
	extern _MAIPGH
	extern _MACLCON1
	extern _MACLCON2
	extern _MAMXFL
	extern _MAMXFLL
	extern _MAMXFLH
	extern _MICON
	extern _MICMD
	extern _MIREGADR
	extern _MIWR
	extern _MIWRL
	extern _MIWRH
	extern _MIRD
	extern _MIRDL
	extern _MIRDH
	extern _EHT0
	extern _EHT1
	extern _EHT2
	extern _EHT3
	extern _EHT4
	extern _EHT5
	extern _EHT6
	extern _EHT7
	extern _EPMM0
	extern _EPMM1
	extern _EPMM2
	extern _EPMM3
	extern _EPMM4
	extern _EPMM5
	extern _EPMM6
	extern _EPMM7
	extern _EPMCS
	extern _EPMCSL
	extern _EPMCSH
	extern _EPMO
	extern _EPMOL
	extern _EPMOH
	extern _EWOLIE
	extern _EWOLIR
	extern _ERXFCON
	extern _EPKTCNT
	extern _EWRPT
	extern _EWRPTL
	extern _EWRPTH
	extern _ETXST
	extern _ETXSTL
	extern _ETXSTH
	extern _ETXND
	extern _ETXNDL
	extern _ETXNDH
	extern _ERXST
	extern _ERXSTL
	extern _ERXSTH
	extern _ERXND
	extern _ERXNDL
	extern _ERXNDH
	extern _ERXRDPT
	extern _ERXRDPTL
	extern _ERXRDPTH
	extern _ERXWRPT
	extern _ERXWRPTL
	extern _ERXWRPTH
	extern _EDMAST
	extern _EDMASTL
	extern _EDMASTH
	extern _EDMAND
	extern _EDMANDL
	extern _EDMANDH
	extern _EDMADST
	extern _EDMADSTL
	extern _EDMADSTH
	extern _EDMACS
	extern _EDMACSL
	extern _EDMACSH
	extern _EIE
	extern _ESTAT
	extern _ECON2
	extern _EIR
	extern _EDATA
	extern _SSP2CON2
	extern _SSP2CON1
	extern _SSP2STAT
	extern _SSP2ADD
	extern _SSP2BUF
	extern _ECCP2DEL
	extern _ECCP2AS
	extern _ECCP3DEL
	extern _ECCP3AS
	extern _RCSTA2
	extern _TXSTA2
	extern _TXREG2
	extern _RCREG2
	extern _SPBRG2
	extern _CCP5CON
	extern _CCPR5
	extern _CCPR5L
	extern _CCPR5H
	extern _CCP4CON
	extern _CCPR4
	extern _CCPR4L
	extern _CCPR4H
	extern _T4CON
	extern _PR4
	extern _TMR4
	extern _ECCP1DEL
	extern _ERDPT
	extern _ERDPTL
	extern _ERDPTH
	extern _BAUDCON2
	extern _BAUDCTL2
	extern _SPBRGH2
	extern _BAUDCON
	extern _BAUDCON1
	extern _BAUDCTL
	extern _BAUDCTL1
	extern _SPBRGH
	extern _SPBRGH1
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _PORTF
	extern _PORTG
	extern _PORTH
	extern _PORTJ
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _LATF
	extern _LATG
	extern _LATH
	extern _LATJ
	extern _DDRA
	extern _TRISA
	extern _DDRB
	extern _TRISB
	extern _DDRC
	extern _TRISC
	extern _DDRD
	extern _TRISD
	extern _DDRE
	extern _TRISE
	extern _DDRF
	extern _TRISF
	extern _DDRG
	extern _TRISG
	extern _DDRH
	extern _TRISH
	extern _DDRJ
	extern _TRISJ
	extern _OSCTUNE
	extern _MEMCON
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _PIE3
	extern _PIR3
	extern _IPR3
	extern _EECON1
	extern _EECON2
	extern _RCSTA
	extern _RCSTA1
	extern _TXSTA
	extern _TXSTA1
	extern _TXREG
	extern _TXREG1
	extern _RCREG
	extern _RCREG1
	extern _SPBRG
	extern _SPBRG1
	extern _PSPCON
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _CCP3CON
	extern _ECCP3CON
	extern _CCPR3
	extern _CCPR3L
	extern _CCPR3H
	extern _CCP2CON
	extern _ECCP2CON
	extern _CCPR2
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _ECCP1CON
	extern _CCPR1
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRES
	extern _ADRESL
	extern _ADRESH
	extern _SSP1CON2
	extern _SSPCON2
	extern _SSP1CON1
	extern _SSPCON1
	extern _SSP1STAT
	extern _SSPSTAT
	extern _SSP1ADD
	extern _SSPADD
	extern _SSP1BUF
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _ECON1
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PROD
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTR
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PC
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOS
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _ultoa
	extern _memset
	extern _LCDListInit
	extern _LCDListIsEmpty
	extern _LCDListPush
	extern _LCDListPop
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1

udata_LCDNonBlocking_0	udata
_LCDi	res	1

udata_LCDNonBlocking_1	udata
_LCDj	res	1

udata_LCDNonBlocking_2	udata
_st_init	res	1

udata_LCDNonBlocking_3	udata
_st_update	res	1

udata_LCDNonBlocking_4	udata
_st_erase	res	1

udata_LCDNonBlocking_5	udata
_LCDWaiting	res	1

udata_LCDNonBlocking_6	udata
_LCDOpInProgress	res	1

udata_LCDNonBlocking_7	udata
_LCDCurrentOrder	res	1

udata_LCDNonBlocking_8	udata
_LCDCurrentText	res	33

udata_LCDNonBlocking_9	udata
_LCDText	res	33

udata_LCDNonBlocking_10	udata
_tmpBuf	res	33

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_LCDNonBlocking__LCDUpdate	code
_LCDUpdate:
;	.line	609; TCPIP_Stack/LCDNonBlocking.c	void LCDUpdate(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	611; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(3, LCDText);
	MOVLW	HIGH(_LCDText)
	MOVWF	r0x01
	MOVLW	LOW(_LCDText)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_LCDListPush
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDErase	code
_LCDErase:
;	.line	584; TCPIP_Stack/LCDNonBlocking.c	void LCDErase(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	586; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(2, "");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_LCDListPush
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	588; TCPIP_Stack/LCDNonBlocking.c	memset(LCDText, ' ', 32);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	HIGH(_LCDText)
	MOVWF	POSTDEC1
	MOVLW	LOW(_LCDText)
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDInit	code
_LCDInit:
;	.line	563; TCPIP_Stack/LCDNonBlocking.c	void LCDInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	565; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(1, "");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDListPush
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDTask	code
_LCDTask:
;	.line	503; TCPIP_Stack/LCDNonBlocking.c	void LCDTask(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	505; TCPIP_Stack/LCDNonBlocking.c	if (PIR1bits.TMR1IF && LCDWaiting)		// Time expired
	BTFSS	_PIR1bits, 0
	BRA	_00243_DS_
	BANKSEL	_LCDWaiting
	MOVF	_LCDWaiting, W, B
	BZ	_00243_DS_
	BANKSEL	_LCDWaiting
;	.line	507; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 0;
	CLRF	_LCDWaiting, B
;	.line	508; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON = 0;
	BCF	_T1CONbits, 0
;	.line	509; TCPIP_Stack/LCDNonBlocking.c	PIR1bits.TMR1IF = 0;
	BCF	_PIR1bits, 0
_00243_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	511; TCPIP_Stack/LCDNonBlocking.c	if (!LCDOpInProgress)				// No operations being executed
	MOVF	_LCDOpInProgress, W, B
	BTFSS	STATUS, 2
	BRA	_00248_DS_
;	.line	513; TCPIP_Stack/LCDNonBlocking.c	if (!LCDListIsEmpty())				// The list contains at least one operation
	CALL	_LCDListIsEmpty
	MOVWF	r0x00
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	BRA	_00248_DS_
;	.line	515; TCPIP_Stack/LCDNonBlocking.c	LCDListPop(&LCDCurrentOrder, LCDCurrentText);			// Retrieve the operation to execute
	MOVLW	HIGH(_LCDCurrentOrder)
	MOVWF	r0x01
	MOVLW	LOW(_LCDCurrentOrder)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	HIGH(_LCDCurrentText)
	MOVWF	r0x04
	MOVLW	LOW(_LCDCurrentText)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_LCDListPop
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	516; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 1;		// Set the execution flag
	MOVLW	0x01
	BANKSEL	_LCDOpInProgress
	MOVWF	_LCDOpInProgress, B
;	.line	518; TCPIP_Stack/LCDNonBlocking.c	ultoa(LCDCurrentOrder, tmpBuf,10);
	MOVFF	_LCDCurrentOrder, r0x00
	CLRF	WREG
	BANKSEL	_LCDCurrentOrder
	BTFSC	_LCDCurrentOrder, 7, B
	MOVLW	0xff
	MOVWF	r0x01
	MOVWF	r0x02
	MOVWF	r0x03
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_tmpBuf)
	MOVWF	POSTDEC1
	MOVLW	LOW(_tmpBuf)
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_ultoa
	MOVLW	0x07
	ADDWF	FSR1L, F
_00248_DS_:
	BANKSEL	_LCDWaiting
;	.line	523; TCPIP_Stack/LCDNonBlocking.c	if (!LCDWaiting && LCDOpInProgress)				// Not waiting for timers
	MOVF	_LCDWaiting, W, B
	BTFSS	STATUS, 2
	BRA	_00257_DS_
	BANKSEL	_LCDOpInProgress
	MOVF	_LCDOpInProgress, W, B
	BZ	_00257_DS_
	BANKSEL	_LCDCurrentOrder
;	.line	525; TCPIP_Stack/LCDNonBlocking.c	switch (LCDCurrentOrder)
	MOVF	_LCDCurrentOrder, W, B
	ADDLW	0x80
	ADDLW	0x7f
	BNC	_00257_DS_
	BANKSEL	_LCDCurrentOrder
	MOVF	_LCDCurrentOrder, W, B
	ADDLW	0x80
	ADDLW	0x7c
	BC	_00257_DS_
	BANKSEL	_LCDCurrentOrder
	DECF	_LCDCurrentOrder, W, B
	MOVWF	r0x00
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
	RLCF	r0x00, W
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00269_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00269_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00269_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00269_DS_:
	GOTO	_00249_DS_
	GOTO	_00250_DS_
	GOTO	_00251_DS_
_00249_DS_:
;	.line	528; TCPIP_Stack/LCDNonBlocking.c	LCDInitExec();
	CALL	_LCDInitExec
;	.line	529; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00257_DS_
_00250_DS_:
;	.line	532; TCPIP_Stack/LCDNonBlocking.c	LCDEraseExec();
	CALL	_LCDEraseExec
;	.line	533; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00257_DS_
_00251_DS_:
;	.line	536; TCPIP_Stack/LCDNonBlocking.c	LCDUpdateExec();
	CALL	_LCDUpdateExec
_00257_DS_:
;	.line	542; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDTaskInit	code
_LCDTaskInit:
;	.line	476; TCPIP_Stack/LCDNonBlocking.c	void LCDTaskInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_st_init
;	.line	479; TCPIP_Stack/LCDNonBlocking.c	st_init   = LCD_RESET;
	CLRF	_st_init, B
	BANKSEL	_st_update
;	.line	480; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOFIRSTLINE;
	CLRF	_st_update, B
	BANKSEL	_st_erase
;	.line	481; TCPIP_Stack/LCDNonBlocking.c	st_erase  = LCD_CLEARDISPLAY;
	CLRF	_st_erase, B
	BANKSEL	_LCDWaiting
;	.line	483; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 0;
	CLRF	_LCDWaiting, B
	BANKSEL	_LCDOpInProgress
;	.line	484; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_LCDi
;	.line	485; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
	BANKSEL	_LCDj
;	.line	486; TCPIP_Stack/LCDNonBlocking.c	LCDj = 0;
	CLRF	_LCDj, B
;	.line	488; TCPIP_Stack/LCDNonBlocking.c	LCDListInit();
	CALL	_LCDListInit
;	.line	490; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	0;		// disable timer1
	BCF	_T1CONbits, 0
;	.line	491; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.RD16		=	1;		// use timer1 16-bit counter
	BSF	_T1CONbits, 7
;	.line	492; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1CKPS0	=	0;		// prescaler set to 1:1
	BCF	_T1CONbits, 4
;	.line	493; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1CKPS1	=	0;
	BCF	_T1CONbits, 5
;	.line	494; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1OSCEN	=	1;		// timer1 oscillator enable
	BSF	_T1CONbits, 3
;	.line	495; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1CS	=	1;		// external clock selected
	BSF	_T1CONbits, 1
;	.line	496; TCPIP_Stack/LCDNonBlocking.c	PIR1bits.TMR1IF		=	0;		// clear timer1 overflow bit
	BCF	_PIR1bits, 0
;	.line	498; TCPIP_Stack/LCDNonBlocking.c	memset(LCDText, ' ', sizeof(LCDText)-1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	HIGH(_LCDText)
	MOVWF	POSTDEC1
	MOVLW	LOW(_LCDText)
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_LCDText + 32)
;	.line	499; TCPIP_Stack/LCDNonBlocking.c	LCDText[sizeof(LCDText)-1] = 0;
	CLRF	(_LCDText + 32), B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDUpdateExec	code
_LCDUpdateExec:
;	.line	369; TCPIP_Stack/LCDNonBlocking.c	static void LCDUpdateExec(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	371; TCPIP_Stack/LCDNonBlocking.c	switch(st_update)
	MOVLW	0x05
	BANKSEL	_st_update
	SUBWF	_st_update, W, B
	BTFSC	STATUS, 0
	BRA	_00216_DS_
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	CLRF	r0x04
	BANKSEL	_st_update
	RLCF	_st_update, W, B
	RLCF	r0x04, F
	RLCF	WREG, W
	RLCF	r0x04, F
	ANDLW	0xfc
	MOVWF	r0x03
	MOVLW	UPPER(_00228_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00228_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00228_DS_)
	ADDWF	r0x03, F
	MOVF	r0x04, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVWF	PCL
_00228_DS_:
	GOTO	_00191_DS_
	GOTO	_00192_DS_
	GOTO	_00198_DS_
	GOTO	_00199_DS_
	GOTO	_00205_DS_
_00191_DS_:
;	.line	378; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	380; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	381; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	382; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	383; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	384; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_OUTFIRSTLINE;
	MOVLW	0x01
	BANKSEL	_st_update
	MOVWF	_st_update, B
	BANKSEL	_LCDi
;	.line	385; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
;	.line	386; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00216_DS_
_00192_DS_:
;	.line	391; TCPIP_Stack/LCDNonBlocking.c	if(LCDCurrentText[LCDi] == 0u)
	MOVLW	LOW(_LCDCurrentText)
	BANKSEL	_LCDi
	ADDWF	_LCDi, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_LCDCurrentText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BNZ	_00194_DS_
;	.line	393; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, ' ');
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	394; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 16u; LCDj++)
	MOVFF	_LCDi, _LCDj
_00208_DS_:
	MOVFF	_LCDj, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00229_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00229_DS_:
	BC	_00195_DS_
;	.line	396; TCPIP_Stack/LCDNonBlocking.c	LCDCurrentText[LCDj] = ' ';
	MOVLW	LOW(_LCDCurrentText)
	BANKSEL	_LCDj
	ADDWF	_LCDj, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDCurrentText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
	BANKSEL	_LCDj
;	.line	394; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 16u; LCDj++)
	INCF	_LCDj, F, B
	BRA	_00208_DS_
_00194_DS_:
;	.line	399; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, LCDCurrentText[LCDi]);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
_00195_DS_:
	BANKSEL	_LCDi
;	.line	401; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	402; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 16u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00230_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
_00230_DS_:
	BNC	_00197_DS_
;	.line	403; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOSECONDLINE;
	MOVLW	0x02
	BANKSEL	_st_update
	MOVWF	_st_update, B
_00197_DS_:
;	.line	405; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	406; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	407; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	408; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	409; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00216_DS_
_00198_DS_:
;	.line	413; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	415; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	416; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	417; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	418; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	419; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_OUTSECONDLINE;
	MOVLW	0x03
	BANKSEL	_st_update
	MOVWF	_st_update, B
;	.line	420; TCPIP_Stack/LCDNonBlocking.c	LCDi = 16;
	MOVLW	0x10
	BANKSEL	_LCDi
	MOVWF	_LCDi, B
;	.line	421; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00216_DS_
_00199_DS_:
;	.line	426; TCPIP_Stack/LCDNonBlocking.c	if(LCDCurrentText[LCDi] == 0u)
	MOVLW	LOW(_LCDCurrentText)
	BANKSEL	_LCDi
	ADDWF	_LCDi, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_LCDCurrentText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BNZ	_00201_DS_
;	.line	428; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, ' ');
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	429; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 32u; LCDj++)
	MOVFF	_LCDi, _LCDj
_00212_DS_:
	MOVFF	_LCDj, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00231_DS_
	MOVLW	0x20
	SUBWF	r0x01, W
_00231_DS_:
	BC	_00202_DS_
;	.line	431; TCPIP_Stack/LCDNonBlocking.c	LCDCurrentText[LCDj] = ' ';
	MOVLW	LOW(_LCDCurrentText)
	BANKSEL	_LCDj
	ADDWF	_LCDj, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDCurrentText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
	BANKSEL	_LCDj
;	.line	429; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 32u; LCDj++)
	INCF	_LCDj, F, B
	BRA	_00212_DS_
_00201_DS_:
;	.line	434; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, LCDCurrentText[LCDi]);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
_00202_DS_:
	BANKSEL	_LCDi
;	.line	436; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	437; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 32u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00232_DS_
	MOVLW	0x20
	SUBWF	r0x00, W
_00232_DS_:
	BNC	_00204_DS_
;	.line	438; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_ENDUPDATE;
	MOVLW	0x04
	BANKSEL	_st_update
	MOVWF	_st_update, B
_00204_DS_:
;	.line	440; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	441; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	442; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	443; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	444; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00216_DS_
_00205_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	450; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_update
;	.line	451; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOFIRSTLINE;
	CLRF	_st_update, B
_00216_DS_:
;	.line	457; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDEraseExec	code
_LCDEraseExec:
;	.line	336; TCPIP_Stack/LCDNonBlocking.c	static void LCDEraseExec(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	338; TCPIP_Stack/LCDNonBlocking.c	switch(st_erase)
	MOVFF	_st_erase, r0x00
	MOVF	r0x00, W
	BZ	_00175_DS_
_00184_DS_:
	BANKSEL	_st_erase
	MOVF	_st_erase, W, B
	XORLW	0x01
	BZ	_00176_DS_
	BRA	_00179_DS_
_00175_DS_:
;	.line	342; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	344; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	345; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	346; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	347; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	349; TCPIP_Stack/LCDNonBlocking.c	st_erase = LCD_CLEARLOCAL;
	MOVLW	0x01
	BANKSEL	_st_erase
	MOVWF	_st_erase, B
;	.line	350; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00179_DS_
_00176_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	357; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_erase
;	.line	359; TCPIP_Stack/LCDNonBlocking.c	st_erase = LCD_CLEARDISPLAY;
	CLRF	_st_erase, B
_00179_DS_:
;	.line	365; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDInitExec	code
_LCDInitExec:
;	.line	174; TCPIP_Stack/LCDNonBlocking.c	static void LCDInitExec(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
;	.line	176; TCPIP_Stack/LCDNonBlocking.c	switch (st_init)
	MOVLW	0x08
	BANKSEL	_st_init
	SUBWF	_st_init, W, B
	BTFSC	STATUS, 0
	BRA	_00161_DS_
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	CLRF	r0x09
	BANKSEL	_st_init
	RLCF	_st_init, W, B
	RLCF	r0x09, F
	RLCF	WREG, W
	RLCF	r0x09, F
	ANDLW	0xfc
	MOVWF	r0x08
	MOVLW	UPPER(_00169_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00169_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00169_DS_)
	ADDWF	r0x08, F
	MOVF	r0x09, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x08, W
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVWF	PCL
_00169_DS_:
	GOTO	_00143_DS_
	GOTO	_00144_DS_
	GOTO	_00145_DS_
	GOTO	_00154_DS_
	GOTO	_00155_DS_
	GOTO	_00156_DS_
	GOTO	_00157_DS_
	GOTO	_00158_DS_
_00143_DS_:
;	.line	183; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
;	.line	184; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	186; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	199; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	200; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	201; TCPIP_Stack/LCDNonBlocking.c	LCD_E_TRIS = 0;
	BCF	_TRISHbits, 0
;	.line	203; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	204; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 1311)	& 0xff;
	MOVLW	0xe1
	MOVWF	_TMR1L
;	.line	205; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 1311)	>> 8;
	MOVLW	0xfa
	MOVWF	_TMR1H
;	.line	206; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	208; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DEFAULTFUNC1;
	MOVLW	0x01
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	209; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00144_DS_:
;	.line	218; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_IO = 0;
	BCF	_LATHbits, 2
;	.line	220; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_IO = 0x03;
	MOVLW	0x03
	MOVWF	_LATE
;	.line	236; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_EPULSETIME;
	MOVLW	0x02
	BANKSEL	_st_init
	MOVWF	_st_init, B
	BANKSEL	_LCDi
;	.line	237; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
;	.line	238; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00145_DS_:
;	.line	241; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 1;
	BSF	_LATHbits, 0
;	.line	242; TCPIP_Stack/LCDNonBlocking.c	Delay10us(1);			// Wait E Pulse width time (min 230ns)
	MOVLW	0x11
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00146_DS_:
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVLW	0xff
	ADDWF	r0x00, F
	MOVLW	0xff
	ADDWFC	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVF	r0x04, W
	IORWF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	BNZ	_00146_DS_
;	.line	243; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
	BANKSEL	_LCDi
;	.line	245; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	246; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 3u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00170_DS_
	MOVLW	0x03
	SUBWF	r0x00, W
_00170_DS_:
	BNC	_00153_DS_
;	.line	247; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DEFAULTFUNC2;
	MOVLW	0x03
	BANKSEL	_st_init
	MOVWF	_st_init, B
_00153_DS_:
;	.line	249; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	250; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	251; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	252; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	253; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00154_DS_:
;	.line	278; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x38);
	MOVLW	0x38
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	281; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	282; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	283; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	284; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	286; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_ENTRYMODE;
	MOVLW	0x04
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	287; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00155_DS_:
;	.line	290; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x06);	// Increment after each write, do not shift
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	292; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	293; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	294; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	295; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	297; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DISPLAYCONTROL;
	MOVLW	0x05
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	298; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00156_DS_:
;	.line	301; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x0C);		// Turn display on, no cusor, no cursor blink
	MOVLW	0x0c
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	303; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	304; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	305; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	306; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	308; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_CLEAR;
	MOVLW	0x06
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	309; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00157_DS_:
;	.line	312; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x01);	
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	314; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	315; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	316; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	317; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	319; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_ENDINIT;
	MOVLW	0x07
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	320; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00158_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	324; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_init
;	.line	326; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_RESET;
	CLRF	_st_init, B
_00161_DS_:
;	.line	332; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDWrite	code
_LCDWrite:
;	.line	78; TCPIP_Stack/LCDNonBlocking.c	static void LCDWrite(BYTE RS, BYTE Data)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	81; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	94; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	95; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	96; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	97; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_IO = RS;
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVF	_LATHbits, W
	ANDLW	0xfb
	IORWF	PRODH, W
	MOVWF	_LATHbits
;	.line	124; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_IO = Data;
	MOVFF	r0x01, _LATE
	nop 
	nop 
;	.line	139; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 1;
	BSF	_LATHbits, 0
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
;	.line	149; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x00


; Statistics:
; code size:	 1842 (0x0732) bytes ( 1.41%)
;           	  921 (0x0399) words
; udata size:	  107 (0x006b) bytes ( 2.79%)
; access size:	   10 (0x000a) bytes


	end
