;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 15 2017) (UNIX)
; This file was generated Sun Dec 10 18:22:05 2017
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
_LCDText	res	33

udata_LCDNonBlocking_9	udata
_LCDCurrentText	res	33

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_LCDNonBlocking__LCDUpdate	code
_LCDUpdate:
;	.line	588; TCPIP_Stack/LCDNonBlocking.c	void LCDUpdate(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	590; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(3, "");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_LCDListPush
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDErase	code
_LCDErase:
;	.line	565; TCPIP_Stack/LCDNonBlocking.c	void LCDErase(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	567; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(2, "");
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
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDInit	code
_LCDInit:
;	.line	545; TCPIP_Stack/LCDNonBlocking.c	void LCDInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	547; TCPIP_Stack/LCDNonBlocking.c	LCDListPush(1, "");
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
;	.line	489; TCPIP_Stack/LCDNonBlocking.c	void LCDTask(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	491; TCPIP_Stack/LCDNonBlocking.c	if (PIR1bits.TMR1IF && LCDWaiting)		// Time expired
	BTFSS	_PIR1bits, 0
	BRA	_00241_DS_
	BANKSEL	_LCDWaiting
	MOVF	_LCDWaiting, W, B
	BZ	_00241_DS_
	BANKSEL	_LCDWaiting
;	.line	493; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 0;
	CLRF	_LCDWaiting, B
;	.line	494; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON = 0;
	BCF	_T1CONbits, 0
;	.line	495; TCPIP_Stack/LCDNonBlocking.c	PIR1bits.TMR1IF = 0;
	BCF	_PIR1bits, 0
_00241_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	497; TCPIP_Stack/LCDNonBlocking.c	if (!LCDOpInProgress)				// No operations being executed
	MOVF	_LCDOpInProgress, W, B
	BNZ	_00246_DS_
;	.line	499; TCPIP_Stack/LCDNonBlocking.c	if (!LCDListIsEmpty())				// The list contains at least one operation
	CALL	_LCDListIsEmpty
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00246_DS_
;	.line	501; TCPIP_Stack/LCDNonBlocking.c	LCDListPop(&LCDCurrentOrder, LCDCurrentText);			// Retrieve the operation to execute
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
;	.line	502; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 1;		// Set the execution flag
	MOVLW	0x01
	BANKSEL	_LCDOpInProgress
	MOVWF	_LCDOpInProgress, B
_00246_DS_:
	BANKSEL	_LCDWaiting
;	.line	505; TCPIP_Stack/LCDNonBlocking.c	if (!LCDWaiting && LCDOpInProgress)				// Not waiting for timers
	MOVF	_LCDWaiting, W, B
	BTFSS	STATUS, 2
	BRA	_00255_DS_
	BANKSEL	_LCDOpInProgress
	MOVF	_LCDOpInProgress, W, B
	BZ	_00255_DS_
	BANKSEL	_LCDCurrentOrder
;	.line	507; TCPIP_Stack/LCDNonBlocking.c	switch (LCDCurrentOrder)
	MOVF	_LCDCurrentOrder, W, B
	ADDLW	0x80
	ADDLW	0x7f
	BNC	_00255_DS_
	BANKSEL	_LCDCurrentOrder
	MOVF	_LCDCurrentOrder, W, B
	ADDLW	0x80
	ADDLW	0x7c
	BC	_00255_DS_
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
	MOVLW	UPPER(_00267_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00267_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00267_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00267_DS_:
	GOTO	_00247_DS_
	GOTO	_00248_DS_
	GOTO	_00249_DS_
_00247_DS_:
;	.line	510; TCPIP_Stack/LCDNonBlocking.c	LCDInitExec();
	CALL	_LCDInitExec
;	.line	511; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00255_DS_
_00248_DS_:
;	.line	514; TCPIP_Stack/LCDNonBlocking.c	LCDEraseExec();
	CALL	_LCDEraseExec
;	.line	515; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00255_DS_
_00249_DS_:
;	.line	518; TCPIP_Stack/LCDNonBlocking.c	LCDUpdateExec();
	CALL	_LCDUpdateExec
_00255_DS_:
;	.line	524; TCPIP_Stack/LCDNonBlocking.c	}
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
;	.line	465; TCPIP_Stack/LCDNonBlocking.c	void LCDTaskInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_st_init
;	.line	468; TCPIP_Stack/LCDNonBlocking.c	st_init   = LCD_RESET;
	CLRF	_st_init, B
	BANKSEL	_st_update
;	.line	469; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOFIRSTLINE;
	CLRF	_st_update, B
	BANKSEL	_st_erase
;	.line	470; TCPIP_Stack/LCDNonBlocking.c	st_erase  = LCD_CLEARDISPLAY;
	CLRF	_st_erase, B
	BANKSEL	_LCDWaiting
;	.line	472; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 0;
	CLRF	_LCDWaiting, B
	BANKSEL	_LCDOpInProgress
;	.line	473; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_LCDi
;	.line	474; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
	BANKSEL	_LCDj
;	.line	475; TCPIP_Stack/LCDNonBlocking.c	LCDj = 0;
	CLRF	_LCDj, B
;	.line	477; TCPIP_Stack/LCDNonBlocking.c	LCDListInit();
	CALL	_LCDListInit
;	.line	479; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	0;		// disable timer1
	BCF	_T1CONbits, 0
;	.line	480; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.RD16		=	1;		// use timer1 16-bit counter
	BSF	_T1CONbits, 7
;	.line	481; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1CKPS0	=	0;		// prescaler set to 1:1
	BCF	_T1CONbits, 4
;	.line	482; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1CKPS1	=	0;
	BCF	_T1CONbits, 5
;	.line	483; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.T1OSCEN	=	1;		// timer1 oscillator enable
	BSF	_T1CONbits, 3
;	.line	484; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1CS	=	1;		// external clock selected
	BSF	_T1CONbits, 1
;	.line	485; TCPIP_Stack/LCDNonBlocking.c	PIR1bits.TMR1IF		=	0;		// clear timer1 overflow bit
	BCF	_PIR1bits, 0
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDUpdateExec	code
_LCDUpdateExec:
;	.line	366; TCPIP_Stack/LCDNonBlocking.c	static void LCDUpdateExec(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	368; TCPIP_Stack/LCDNonBlocking.c	switch(st_update)
	MOVLW	0x05
	BANKSEL	_st_update
	SUBWF	_st_update, W, B
	BTFSC	STATUS, 0
	BRA	_00214_DS_
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
	MOVLW	UPPER(_00226_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00226_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00226_DS_)
	ADDWF	r0x03, F
	MOVF	r0x04, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVWF	PCL
_00226_DS_:
	GOTO	_00191_DS_
	GOTO	_00192_DS_
	GOTO	_00197_DS_
	GOTO	_00198_DS_
	GOTO	_00203_DS_
_00191_DS_:
;	.line	372; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	374; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	375; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	376; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	377; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	378; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_OUTFIRSTLINE;
	MOVLW	0x01
	BANKSEL	_st_update
	MOVWF	_st_update, B
	BANKSEL	_LCDi
;	.line	379; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
;	.line	380; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00214_DS_
_00192_DS_:
;	.line	385; TCPIP_Stack/LCDNonBlocking.c	if(LCDText[LCDi] == 0u)
	MOVLW	LOW(_LCDText)
	BANKSEL	_LCDi
	ADDWF	_LCDi, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BNZ	_00194_DS_
;	.line	387; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 16u; LCDj++)
	MOVFF	_LCDi, _LCDj
_00206_DS_:
	MOVFF	_LCDj, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00227_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00227_DS_:
	BC	_00194_DS_
;	.line	389; TCPIP_Stack/LCDNonBlocking.c	LCDText[LCDj] = ' ';
	MOVLW	LOW(_LCDText)
	BANKSEL	_LCDj
	ADDWF	_LCDj, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
	BANKSEL	_LCDj
;	.line	387; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 16u; LCDj++)
	INCF	_LCDj, F, B
	BRA	_00206_DS_
_00194_DS_:
;	.line	392; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, LCDText[LCDi]);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	394; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 16u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00228_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
_00228_DS_:
	BNC	_00196_DS_
;	.line	395; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOSECONDLINE;
	MOVLW	0x02
	BANKSEL	_st_update
	MOVWF	_st_update, B
_00196_DS_:
	BANKSEL	_LCDi
;	.line	396; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	398; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	399; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	400; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	401; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	402; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00214_DS_
_00197_DS_:
;	.line	406; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	408; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	409; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	410; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	411; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	412; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_OUTSECONDLINE;
	MOVLW	0x03
	BANKSEL	_st_update
	MOVWF	_st_update, B
;	.line	413; TCPIP_Stack/LCDNonBlocking.c	LCDi = 16;
	MOVLW	0x10
	BANKSEL	_LCDi
	MOVWF	_LCDi, B
;	.line	414; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00214_DS_
_00198_DS_:
;	.line	419; TCPIP_Stack/LCDNonBlocking.c	if(LCDText[LCDi] == 0u)
	MOVLW	LOW(_LCDText)
	BANKSEL	_LCDi
	ADDWF	_LCDi, W, B
	MOVWF	r0x00
	CLRF	r0x01
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	BNZ	_00200_DS_
;	.line	421; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 32u; LCDj++)
	MOVFF	_LCDi, _LCDj
_00210_DS_:
	MOVFF	_LCDj, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00229_DS_
	MOVLW	0x20
	SUBWF	r0x01, W
_00229_DS_:
	BC	_00200_DS_
;	.line	423; TCPIP_Stack/LCDNonBlocking.c	LCDText[LCDj] = ' ';
	MOVLW	LOW(_LCDText)
	BANKSEL	_LCDj
	ADDWF	_LCDj, W, B
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
	BANKSEL	_LCDj
;	.line	421; TCPIP_Stack/LCDNonBlocking.c	for(LCDj=LCDi; LCDj < 32u; LCDj++)
	INCF	_LCDj, F, B
	BRA	_00210_DS_
_00200_DS_:
;	.line	426; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(1, LCDText[LCDi]);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	428; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 32u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00230_DS_
	MOVLW	0x20
	SUBWF	r0x00, W
_00230_DS_:
	BNC	_00202_DS_
;	.line	429; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_ENDUPDATE;
	MOVLW	0x04
	BANKSEL	_st_update
	MOVWF	_st_update, B
_00202_DS_:
	BANKSEL	_LCDi
;	.line	430; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	432; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	433; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	434; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	435; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	436; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00214_DS_
_00203_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	439; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_update
;	.line	440; TCPIP_Stack/LCDNonBlocking.c	st_update = LCD_GOTOFIRSTLINE;
	CLRF	_st_update, B
_00214_DS_:
;	.line	446; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDEraseExec	code
_LCDEraseExec:
;	.line	334; TCPIP_Stack/LCDNonBlocking.c	static void LCDEraseExec(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	336; TCPIP_Stack/LCDNonBlocking.c	switch(st_erase)
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
;	.line	340; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	342; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	343; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	344; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	345; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	347; TCPIP_Stack/LCDNonBlocking.c	st_erase = LCD_CLEARLOCAL;
	MOVLW	0x01
	BANKSEL	_st_erase
	MOVWF	_st_erase, B
;	.line	348; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00179_DS_
_00176_DS_:
;	.line	352; TCPIP_Stack/LCDNonBlocking.c	memset(LCDText, ' ', 32);
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
	BANKSEL	_LCDOpInProgress
;	.line	354; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_erase
;	.line	356; TCPIP_Stack/LCDNonBlocking.c	st_erase = LCD_CLEARDISPLAY;
	CLRF	_st_erase, B
_00179_DS_:
;	.line	362; TCPIP_Stack/LCDNonBlocking.c	}
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDNonBlocking__LCDInitExec	code
_LCDInitExec:
;	.line	173; TCPIP_Stack/LCDNonBlocking.c	static void LCDInitExec(void)
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
;	.line	175; TCPIP_Stack/LCDNonBlocking.c	switch (st_init)
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
;	.line	178; TCPIP_Stack/LCDNonBlocking.c	memset(LCDText, ' ', sizeof(LCDText)-1);
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
;	.line	179; TCPIP_Stack/LCDNonBlocking.c	LCDText[sizeof(LCDText)-1] = 0;
	CLRF	(_LCDText + 32), B
;	.line	181; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
;	.line	182; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	184; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	197; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	198; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	199; TCPIP_Stack/LCDNonBlocking.c	LCD_E_TRIS = 0;
	BCF	_TRISHbits, 0
;	.line	201; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	202; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 1311)	& 0xff;
	MOVLW	0xe1
	MOVWF	_TMR1L
;	.line	203; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 1311)	>> 8;
	MOVLW	0xfa
	MOVWF	_TMR1H
;	.line	204; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	206; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DEFAULTFUNC1;
	MOVLW	0x01
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	207; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00144_DS_:
;	.line	216; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_IO = 0;
	BCF	_LATHbits, 2
;	.line	218; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_IO = 0x03;
	MOVLW	0x03
	MOVWF	_LATE
;	.line	234; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_EPULSETIME;
	MOVLW	0x02
	BANKSEL	_st_init
	MOVWF	_st_init, B
	BANKSEL	_LCDi
;	.line	235; TCPIP_Stack/LCDNonBlocking.c	LCDi = 0;
	CLRF	_LCDi, B
;	.line	236; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00145_DS_:
;	.line	239; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 1;
	BSF	_LATHbits, 0
;	.line	240; TCPIP_Stack/LCDNonBlocking.c	Delay10us(1);			// Wait E Pulse width time (min 230ns)
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
;	.line	241; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
;	.line	243; TCPIP_Stack/LCDNonBlocking.c	if (LCDi >= 3u)
	MOVFF	_LCDi, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00170_DS_
	MOVLW	0x03
	SUBWF	r0x00, W
_00170_DS_:
	BNC	_00153_DS_
;	.line	244; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DEFAULTFUNC2;
	MOVLW	0x03
	BANKSEL	_st_init
	MOVWF	_st_init, B
_00153_DS_:
	BANKSEL	_LCDi
;	.line	245; TCPIP_Stack/LCDNonBlocking.c	LCDi++;
	INCF	_LCDi, F, B
;	.line	247; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	248; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	249; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	250; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	251; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00154_DS_:
;	.line	276; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x38);
	MOVLW	0x38
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	279; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	280; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	281; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	282; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	284; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_ENTRYMODE;
	MOVLW	0x04
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	285; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00155_DS_:
;	.line	288; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x06);	// Increment after each write, do not shift
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	290; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	291; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	292; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	293; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	295; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_DISPLAYCONTROL;
	MOVLW	0x05
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	296; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00156_DS_:
;	.line	299; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x0C);		// Turn display on, no cusor, no cursor blink
	MOVLW	0x0c
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	301; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	302; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 2)	& 0xff;
	MOVLW	0xfe
	MOVWF	_TMR1L
;	.line	303; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 2)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	304; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	306; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_CLEAR;
	MOVLW	0x06
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	307; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00157_DS_:
;	.line	310; TCPIP_Stack/LCDNonBlocking.c	LCDWrite(0, 0x01);	
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	312; TCPIP_Stack/LCDNonBlocking.c	LCDWaiting = 1;
	MOVLW	0x01
	BANKSEL	_LCDWaiting
	MOVWF	_LCDWaiting, B
;	.line	313; TCPIP_Stack/LCDNonBlocking.c	TMR1L			=	(0x10000 - 66)	& 0xff;
	MOVLW	0xbe
	MOVWF	_TMR1L
;	.line	314; TCPIP_Stack/LCDNonBlocking.c	TMR1H			=	(0x10000 - 66)	>> 8;
	MOVLW	0xff
	MOVWF	_TMR1H
;	.line	315; TCPIP_Stack/LCDNonBlocking.c	T1CONbits.TMR1ON	=	1;
	BSF	_T1CONbits, 0
;	.line	317; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_ENDINIT;
	MOVLW	0x07
	BANKSEL	_st_init
	MOVWF	_st_init, B
;	.line	318; TCPIP_Stack/LCDNonBlocking.c	break;
	BRA	_00161_DS_
_00158_DS_:
	BANKSEL	_LCDOpInProgress
;	.line	322; TCPIP_Stack/LCDNonBlocking.c	LCDOpInProgress = 0;
	CLRF	_LCDOpInProgress, B
	BANKSEL	_st_init
;	.line	324; TCPIP_Stack/LCDNonBlocking.c	st_init = LCD_RESET;
	CLRF	_st_init, B
_00161_DS_:
;	.line	330; TCPIP_Stack/LCDNonBlocking.c	}
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
;	.line	77; TCPIP_Stack/LCDNonBlocking.c	static void LCDWrite(BYTE RS, BYTE Data)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	80; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	93; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	94; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	95; TCPIP_Stack/LCDNonBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	96; TCPIP_Stack/LCDNonBlocking.c	LCD_RS_IO = RS;
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVF	_LATHbits, W
	ANDLW	0xfb
	IORWF	PRODH, W
	MOVWF	_LATHbits
;	.line	123; TCPIP_Stack/LCDNonBlocking.c	LCD_DATA_IO = Data;
	MOVFF	r0x01, _LATE
	nop 
	nop 
;	.line	138; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 1;
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
;	.line	148; TCPIP_Stack/LCDNonBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x00


; Statistics:
; code size:	 1716 (0x06b4) bytes ( 1.31%)
;           	  858 (0x035a) words
; udata size:	   74 (0x004a) bytes ( 1.93%)
; access size:	   10 (0x000a) bytes


	end
