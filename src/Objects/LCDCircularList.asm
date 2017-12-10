;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Nov 15 2017) (UNIX)
; This file was generated Sun Dec 10 18:22:37 2017
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _LCDListInit
	global _LCDListIsEmpty
	global _LCDListIsFull
	global _LCDListPush
	global _LCDListPop

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput1
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
	extern _LCDText
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
	extern _strlcpy
	extern __moduint
	extern __mulint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_LCDListReady	db	0x00


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


lcd_scn	udata
_listLCD	res	378

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_LCDCircularList__LCDListPop	code
_LCDListPop:
;	.line	81; TCPIP_Stack/LCDCircularList.c	char LCDListPop(char *order, char text[])
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
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
	BANKSEL	_LCDListReady
;	.line	84; TCPIP_Stack/LCDCircularList.c	if (!LCDListReady)
	MOVF	_LCDListReady, W, B
	BNZ	_00151_DS_
;	.line	85; TCPIP_Stack/LCDCircularList.c	return -1;
	SETF	WREG
	BRA	_00154_DS_
_00151_DS_:
;	.line	86; TCPIP_Stack/LCDCircularList.c	if (LCDListIsEmpty())
	CALL	_LCDListIsEmpty
	MOVWF	r0x06
	MOVF	r0x06, W
	BZ	_00153_DS_
;	.line	87; TCPIP_Stack/LCDCircularList.c	return -2;
	MOVLW	0xfe
	BRA	_00154_DS_
_00153_DS_:
	BANKSEL	(_listLCD + 377)
;	.line	89; TCPIP_Stack/LCDCircularList.c	*order = listLCD.op[listLCD.tail].order;
	MOVF	(_listLCD + 377), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_listLCD + 376)
	MOVF	(_listLCD + 376), W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x22
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_listLCD)
	ADDWF	r0x06, W
	MOVWF	r0x08
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x07, W
	MOVWF	r0x09
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x08
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
;	.line	90; TCPIP_Stack/LCDCircularList.c	strlcpy(text, listLCD.op[listLCD.tail].text, ROWCHARS*2);
	MOVLW	LOW(_listLCD)
	ADDWF	r0x06, F
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x07, F
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	MOVF	r0x07, W
	MOVWF	r0x07
	MOVF	r0x06, W
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x00
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_strlcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	92; TCPIP_Stack/LCDCircularList.c	listLCD.op[listLCD.tail].order = 0;
	MOVFF	(_listLCD + 376), r0x00
	MOVFF	(_listLCD + 377), r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x22
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_listLCD)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	93; TCPIP_Stack/LCDCircularList.c	listLCD.op[listLCD.tail].text[0] = '\0';
	MOVLW	LOW(_listLCD)
	ADDWF	r0x02, F
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x03, F
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	95; TCPIP_Stack/LCDCircularList.c	listLCD.tail = (listLCD.tail + 1) % OP_LIST_SIZE;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0b
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_listLCD + 376)
	MOVWF	(_listLCD + 376), B
	MOVF	r0x01, W
	BANKSEL	(_listLCD + 377)
	MOVWF	(_listLCD + 377), B
;	.line	96; TCPIP_Stack/LCDCircularList.c	return 0;
	CLRF	WREG
_00154_DS_:
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
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
S_LCDCircularList__LCDListPush	code
_LCDListPush:
;	.line	66; TCPIP_Stack/LCDCircularList.c	char LCDListPush(char order, char text[])
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	BANKSEL	_LCDListReady
;	.line	69; TCPIP_Stack/LCDCircularList.c	if (!LCDListReady)
	MOVF	_LCDListReady, W, B
	BNZ	_00142_DS_
;	.line	70; TCPIP_Stack/LCDCircularList.c	return -1;
	SETF	WREG
	BRA	_00145_DS_
_00142_DS_:
;	.line	71; TCPIP_Stack/LCDCircularList.c	if (LCDListIsFull())
	CALL	_LCDListIsFull
	MOVWF	r0x04
	MOVF	r0x04, W
	BZ	_00144_DS_
;	.line	72; TCPIP_Stack/LCDCircularList.c	return -2;
	MOVLW	0xfe
	BRA	_00145_DS_
_00144_DS_:
	BANKSEL	(_listLCD + 375)
;	.line	74; TCPIP_Stack/LCDCircularList.c	listLCD.op[listLCD.head].order = order;
	MOVF	(_listLCD + 375), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_listLCD + 374)
	MOVF	(_listLCD + 374), W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x22
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_listLCD)
	ADDWF	r0x04, W
	MOVWF	r0x06
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x05, W
	MOVWF	r0x07
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x00, INDF0
;	.line	75; TCPIP_Stack/LCDCircularList.c	strlcpy(listLCD.op[listLCD.head].text, text, ROWCHARS*2);
	MOVLW	LOW(_listLCD)
	ADDWF	r0x04, F
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x05, F
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	MOVF	r0x05, W
	MOVWF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x00
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_strlcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
	BANKSEL	(_listLCD + 374)
;	.line	77; TCPIP_Stack/LCDCircularList.c	listLCD.head = (listLCD.head + 1) % OP_LIST_SIZE;
	MOVF	(_listLCD + 374), W, B
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
	BANKSEL	(_listLCD + 375)
	ADDWFC	(_listLCD + 375), W, B
	MOVWF	r0x01
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0b
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_listLCD + 374)
	MOVWF	(_listLCD + 374), B
	MOVF	r0x01, W
	BANKSEL	(_listLCD + 375)
	MOVWF	(_listLCD + 375), B
;	.line	78; TCPIP_Stack/LCDCircularList.c	return 0;
	CLRF	WREG
_00145_DS_:
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
S_LCDCircularList__LCDListIsFull	code
_LCDListIsFull:
;	.line	58; TCPIP_Stack/LCDCircularList.c	char LCDListIsFull(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	BANKSEL	_LCDListReady
;	.line	61; TCPIP_Stack/LCDCircularList.c	if (!LCDListReady)
	MOVF	_LCDListReady, W, B
	BNZ	_00131_DS_
;	.line	62; TCPIP_Stack/LCDCircularList.c	return -1;
	SETF	WREG
	BRA	_00132_DS_
_00131_DS_:
;	.line	63; TCPIP_Stack/LCDCircularList.c	return (listLCD.tail == ((listLCD.head + 1) % OP_LIST_SIZE));
	MOVFF	(_listLCD + 376), r0x00
	MOVFF	(_listLCD + 377), r0x01
	BANKSEL	(_listLCD + 374)
	MOVF	(_listLCD + 374), W, B
	ADDLW	0x01
	MOVWF	r0x02
	MOVLW	0x00
	BANKSEL	(_listLCD + 375)
	ADDWFC	(_listLCD + 375), W, B
	MOVWF	r0x03
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0b
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	XORWF	r0x02, W
	BNZ	_00135_DS_
	MOVF	r0x01, W
	XORWF	r0x03, W
	BNZ	_00135_DS_
	CLRF	r0x00
	INCF	r0x00, F
	BRA	_00136_DS_
_00135_DS_:
	CLRF	r0x00
_00136_DS_:
	MOVF	r0x00, W
_00132_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDCircularList__LCDListIsEmpty	code
_LCDListIsEmpty:
;	.line	50; TCPIP_Stack/LCDCircularList.c	char LCDListIsEmpty(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_LCDListReady
;	.line	53; TCPIP_Stack/LCDCircularList.c	if (!LCDListReady)
	MOVF	_LCDListReady, W, B
	BNZ	_00120_DS_
;	.line	54; TCPIP_Stack/LCDCircularList.c	return -1;
	SETF	WREG
	BRA	_00121_DS_
_00120_DS_:
;	.line	55; TCPIP_Stack/LCDCircularList.c	return (listLCD.head == listLCD.tail);
	CLRF	r0x00
	BANKSEL	(_listLCD + 374)
	MOVF	(_listLCD + 374), W, B
	BANKSEL	(_listLCD + 376)
	XORWF	(_listLCD + 376), W, B
	BNZ	_00125_DS_
	BANKSEL	(_listLCD + 375)
	MOVF	(_listLCD + 375), W, B
	BANKSEL	(_listLCD + 377)
	XORWF	(_listLCD + 377), W, B
	BNZ	_00125_DS_
	INCF	r0x00, F
_00125_DS_:
	MOVF	r0x00, W
_00121_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_LCDCircularList__LCDListInit	code
_LCDListInit:
;	.line	34; TCPIP_Stack/LCDCircularList.c	char LCDListInit()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	BANKSEL	(_listLCD + 374)
;	.line	37; TCPIP_Stack/LCDCircularList.c	listLCD.head = 0;
	CLRF	(_listLCD + 374), B
	BANKSEL	(_listLCD + 375)
	CLRF	(_listLCD + 375), B
	BANKSEL	(_listLCD + 376)
;	.line	38; TCPIP_Stack/LCDCircularList.c	listLCD.tail = 0;
	CLRF	(_listLCD + 376), B
	BANKSEL	(_listLCD + 377)
	CLRF	(_listLCD + 377), B
;	.line	40; TCPIP_Stack/LCDCircularList.c	for (i=0; i<OP_LIST_SIZE; i++)
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00105_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00114_DS_
	MOVLW	0x0b
	SUBWF	r0x00, W
_00114_DS_:
	BC	_00108_DS_
;	.line	42; TCPIP_Stack/LCDCircularList.c	listLCD.op[i].order = 0;
	MOVLW	LOW(_listLCD)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	43; TCPIP_Stack/LCDCircularList.c	listLCD.op[i].text[0] = '\0';
	MOVLW	LOW(_listLCD)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_listLCD)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	40; TCPIP_Stack/LCDCircularList.c	for (i=0; i<OP_LIST_SIZE; i++)
	MOVLW	0x22
	ADDWF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00105_DS_
_00108_DS_:
;	.line	46; TCPIP_Stack/LCDCircularList.c	LCDListReady = 1;
	MOVLW	0x01
	BANKSEL	_LCDListReady
	MOVWF	_LCDListReady, B
;	.line	47; TCPIP_Stack/LCDCircularList.c	return 0;
	CLRF	WREG
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1112 (0x0458) bytes ( 0.85%)
;           	  556 (0x022c) words
; udata size:	  378 (0x017a) bytes ( 9.84%)
; access size:	   10 (0x000a) bytes


	end
