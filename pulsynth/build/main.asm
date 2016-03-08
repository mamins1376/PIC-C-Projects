;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.5 #9514 (Linux)
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
	extern	__divslong
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
	extern	___sdcc_saved_fsr
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_isr
	global	_setup
	global	_calc_skips
	global	_main
	global	_skips
	global	_skips_buffer

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
_skips	res	2

UD_main_1	udata
_skips_buffer	res	2

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x100B	res	1
r0x1006	res	1
r0x1005	res	1
r0x1007	res	1
r0x1008	res	1
r0x100A	res	1
r0x1009	res	1
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
; interrupt and initialization code
;--------------------------------------------------------
c_interrupt	code	0x0004
__sdcc_interrupt:
;***
;  pBlock Stats: dbName = I
;***
;1 compiler assigned register :
;   r0x100B
;; Starting pCode block
_isr:
; 0 exit points
;	.line	50; "../src/main.c"	void isr(void) __interrupt 0 {
	MOVWF	WSAVE
	SWAPF	STATUS,W
	CLRF	STATUS
	MOVWF	SSAVE
	MOVF	PCLATH,W
	CLRF	PCLATH
	MOVWF	PSAVE
	MOVF	FSR,W
	BANKSEL	___sdcc_saved_fsr
	MOVWF	___sdcc_saved_fsr
;	.line	51; "../src/main.c"	INTCON = 0x00;
	BANKSEL	_INTCON
	CLRF	_INTCON
;	.line	53; "../src/main.c"	if (--skips) RB0++;
	MOVLW	0xff
	BANKSEL	_skips
	ADDWF	_skips,F
	BTFSS	STATUS,0
	DECF	(_skips + 1),F
	MOVF	_skips,W
	IORWF	(_skips + 1),W
	BTFSC	STATUS,2
	GOTO	_00003_DS_
	BANKSEL	r0x100B
	CLRF	r0x100B
	BANKSEL	_PORTBbits
	BTFSS	_PORTBbits,0
	GOTO	_00001_DS_
	BANKSEL	r0x100B
	INCF	r0x100B,F
_00001_DS_:
	BANKSEL	r0x100B
	INCF	r0x100B,F
	RRF	r0x100B,W
	BTFSC	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
_00002_DS_:
	BTFSS	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,0
_00003_DS_:
;	.line	55; "../src/main.c"	TMR0 = TMR_PRELOAD;
	MOVLW	0xe2
	BANKSEL	_TMR0
	MOVWF	_TMR0
;	.line	56; "../src/main.c"	INTCON = INTCON_CONFIG;
	MOVLW	0xa0
	MOVWF	_INTCON
	BANKSEL	___sdcc_saved_fsr
	MOVF	___sdcc_saved_fsr,W
	BANKSEL	FSR
	MOVWF	FSR
	MOVF	PSAVE,W
	MOVWF	PCLATH
	CLRF	STATUS
	SWAPF	SSAVE,W
	MOVWF	STATUS
	SWAPF	WSAVE,F
	SWAPF	WSAVE,W
END_OF_INTERRUPT:
	RETFIE	

;--------------------------------------------------------
; code
;--------------------------------------------------------
code_main	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _setup
;   _calc_skips
;   _setup
;   _calc_skips
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_main__main	code
_main:
; 2 exit points
;	.line	83; "../src/main.c"	setup();
	CALL	_setup
_00124_DS_:
;	.line	88; "../src/main.c"	if (skips_buffer == 0)
	BANKSEL	_skips_buffer
	MOVF	_skips_buffer,W
	IORWF	(_skips_buffer + 1),W
	BTFSS	STATUS,2
	GOTO	_00120_DS_
;	.line	89; "../src/main.c"	calc_skips(440);
	MOVLW	0xb8
	MOVWF	STK00
	MOVLW	0x01
	CALL	_calc_skips
_00120_DS_:
;	.line	92; "../src/main.c"	if (skips == 0) {
	BANKSEL	_skips
	MOVF	_skips,W
	IORWF	(_skips + 1),W
	BTFSS	STATUS,2
	GOTO	_00124_DS_
;	.line	93; "../src/main.c"	skips = skips_buffer;
	BANKSEL	_skips_buffer
	MOVF	_skips_buffer,W
	BANKSEL	_skips
	MOVWF	_skips
	BANKSEL	_skips_buffer
	MOVF	(_skips_buffer + 1),W
	BANKSEL	_skips
	MOVWF	(_skips + 1)
;	.line	94; "../src/main.c"	skips_buffer = 0;
	BANKSEL	_skips_buffer
	CLRF	_skips_buffer
	CLRF	(_skips_buffer + 1)
	GOTO	_00124_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __divslong
;   __divslong
;13 compiler assigned registers:
;   r0x1005
;   STK00
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;   r0x100A
;   STK06
;   STK05
;   STK04
;   STK03
;   STK02
;   STK01
;; Starting pCode block
S_main__calc_skips	code
_calc_skips:
; 2 exit points
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	71; "../src/main.c"	void calc_skips(int freq) {
	MOVWF	r0x1005
	MOVF	STK00,W
;	.line	75; "../src/main.c"	skips_buffer = INT_FREQ_HALF / freq;
	MOVWF	r0x1006
	MOVWF	r0x1007
;;99	MOVF	r0x1005,W
	MOVLW	0x00
	BTFSC	r0x1008,7
	MOVLW	0xff
	MOVWF	r0x1009
	MOVWF	r0x100A
	MOVF	r0x1007,W
	MOVWF	STK06
	MOVF	r0x1008,W
	MOVWF	STK05
	MOVF	r0x100A,W
	MOVWF	STK04
	MOVF	r0x1009,W
	MOVWF	STK03
	MOVLW	0x5f
	MOVWF	STK02
	MOVLW	0xa8
	MOVWF	STK01
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__divslong
	CALL	__divslong
	PAGESEL	$
	BANKSEL	r0x1008
	MOVWF	r0x1008
	MOVF	STK00,W
	MOVWF	r0x1007
	MOVF	STK01,W
	MOVWF	r0x1005
	MOVF	STK02,W
	MOVWF	r0x1006
	BANKSEL	_skips_buffer
	MOVWF	_skips_buffer
	BANKSEL	r0x1005
	MOVF	r0x1005,W
	BANKSEL	_skips_buffer
	MOVWF	(_skips_buffer + 1)
	RETURN	
; exit point of _calc_skips

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_main__setup	code
_setup:
; 2 exit points
;	.line	61; "../src/main.c"	CMCON = 0x07;
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	62; "../src/main.c"	PORTB = 0x00;
	CLRF	_PORTB
;	.line	63; "../src/main.c"	TRISB = 0xFE;
	MOVLW	0xfe
	BANKSEL	_TRISB
	MOVWF	_TRISB
;	.line	65; "../src/main.c"	OPTION_REG = 0x80;
	MOVLW	0x80
	MOVWF	_OPTION_REG
;	.line	66; "../src/main.c"	TMR0 = TMR_PRELOAD;
	MOVLW	0xe2
	BANKSEL	_TMR0
	MOVWF	_TMR0
;	.line	67; "../src/main.c"	INTCON = INTCON_CONFIG;
	MOVLW	0xa0
	MOVWF	_INTCON
	RETURN	
; exit point of _setup


;	code size estimation:
;	  114+   29 =   143 instructions (  344 byte)

	end
