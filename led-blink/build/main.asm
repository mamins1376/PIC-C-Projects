;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9473 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"../src/main.c"
	list	p=16f627a
	radix dec
	include "p16f627a.inc"
;--------------------------------------------------------
; config word(s)
;--------------------------------------------------------
	__config 0x3f4a
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_STATUSbits
	extern	_PORTAbits
	extern	_PORTBbits
	extern	_INTCONbits
	extern	_PIR1bits
	extern	_T1CONbits
	extern	_T2CONbits
	extern	_CCP1CONbits
	extern	_RCSTAbits
	extern	_CMCONbits
	extern	_OPTION_REGbits
	extern	_TRISAbits
	extern	_TRISBbits
	extern	_PIE1bits
	extern	_PCONbits
	extern	_TXSTAbits
	extern	_EECON1bits
	extern	_VRCONbits
	extern	_INDF
	extern	_TMR0
	extern	_PCL
	extern	_STATUS
	extern	_FSR
	extern	_PORTA
	extern	_PORTB
	extern	_PCLATH
	extern	_INTCON
	extern	_PIR1
	extern	_TMR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_T1CON
	extern	_TMR2
	extern	_T2CON
	extern	_CCPR1
	extern	_CCPR1L
	extern	_CCPR1H
	extern	_CCP1CON
	extern	_RCSTA
	extern	_TXREG
	extern	_RCREG
	extern	_CMCON
	extern	_OPTION_REG
	extern	_TRISA
	extern	_TRISB
	extern	_PIE1
	extern	_PCON
	extern	_PR2
	extern	_TXSTA
	extern	_SPBRG
	extern	_EEDATA
	extern	_EEADR
	extern	_EECON1
	extern	_EECON2
	extern	_VRCON
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_wait
	global	_main
	global	_i

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_main_0	udata
_i	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x1001	res	1
r0x1002	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_main	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _wait
;   _wait
;1 compiler assigned register :
;   r0x1002
;; Starting pCode block
S_main__main	code
_main:
; 2 exit points
;	.line	25; "../src/main.c"	TRISB = 0xF7; // just RB3 is output
	MOVLW	0xf7
	BANKSEL	_TRISB
	MOVWF	_TRISB
_00111_DS_:
;	.line	28; "../src/main.c"	RB3++;
	BANKSEL	r0x1002
	CLRF	r0x1002
	BANKSEL	_PORTBbits
	BTFSS	_PORTBbits,3
	GOTO	_00001_DS_
	BANKSEL	r0x1002
	INCF	r0x1002,F
_00001_DS_:
	BANKSEL	r0x1002
	INCF	r0x1002,F
	RRF	r0x1002,W
	BTFSC	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,3
_00002_DS_:
	BTFSS	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,3
_00003_DS_:
;	.line	29; "../src/main.c"	wait();
	CALL	_wait
	GOTO	_00111_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;1 compiler assigned register :
;   r0x1001
;; Starting pCode block
S_main__wait	code
_wait:
; 2 exit points
;	.line	20; "../src/main.c"	i = 0xFF;
	MOVLW	0xff
	BANKSEL	_i
	MOVWF	_i
_00105_DS_:
;	.line	21; "../src/main.c"	while(i--);
	BANKSEL	_i
	MOVF	_i,W
	BANKSEL	r0x1001
	MOVWF	r0x1001
	BANKSEL	_i
	DECF	_i,F
	BANKSEL	r0x1001
	MOVF	r0x1001,W
	BTFSS	STATUS,2
	GOTO	_00105_DS_
	RETURN	
; exit point of _wait


;	code size estimation:
;	   26+   12 =    38 instructions (  100 byte)

	end
