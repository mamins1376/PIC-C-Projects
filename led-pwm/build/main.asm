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
	extern	___sdcc_saved_fsr
	extern	__moduchar
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_isr
	global	_wait
	global	_set_duty_cycle
	global	_raise
	global	_fall
	global	_main
	global	_delay
	global	_stat
	global	_delays

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
_delay	res	1

UD_main_1	udata
_stat	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x100D	res	1
r0x100F	res	1
r0x100E	res	1
r0x1010	res	1
r0x1011	res	1
r0x1012	res	1
r0x1013	res	1
r0x1014	res	1
r0x1015	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_main_0	idata
_delays
	db	0x01
	db	0x07
	db	0x10
	db	0x20
	db	0x30
	db	0x60
	db	0x90
	db	0xa0
	db	0xc0
	db	0xe0

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
c_interrupt	code	0x4
__sdcc_interrupt
;***
;  pBlock Stats: dbName = I
;***
;functions called:
;   __moduchar
;   __moduchar
;4 compiler assigned registers:
;   r0x100D
;   STK00
;   r0x100E
;   r0x100F
;; Starting pCode block
S_main__isr	code
_isr:
; 0 exit points
;	.line	19; "../src/main.c"	void isr(void) __interrupt (0) {
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
;	.line	20; "../src/main.c"	INTCON = 0x00;
	BANKSEL	_INTCON
	CLRF	_INTCON
;	.line	22; "../src/main.c"	delay = delays[ stat++ % 10 ];
	BANKSEL	_stat
	MOVF	_stat,W
	BANKSEL	r0x100D
	MOVWF	r0x100D
	BANKSEL	_stat
	INCF	_stat,F
	MOVLW	0x0a
	MOVWF	STK00
	BANKSEL	r0x100D
	MOVF	r0x100D,W
	PAGESEL	__moduchar
	CALL	__moduchar
	PAGESEL	$
;;1	MOVWF	r0x100E
	ADDLW	(_delays + 0)
	BANKSEL	r0x100D
	MOVWF	r0x100D
	MOVLW	high (_delays + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x100F
	MOVF	r0x100D,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x100F
	BTFSC	r0x100F,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
	BANKSEL	_delay
	MOVWF	_delay
;	.line	24; "../src/main.c"	INTCON = 0x90;
	MOVLW	0x90
	BANKSEL	_INTCON
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
END_OF_INTERRUPT
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
;   _isr
;   _raise
;   _fall
;   _isr
;   _raise
;   _fall
;; Starting pCode block
S_main__main	code
_main:
; 2 exit points
;	.line	55; "../src/main.c"	TRISB = 0xF7; // just RB3 is output
	MOVLW	0xf7
	BANKSEL	_TRISB
	MOVWF	_TRISB
;	.line	58; "../src/main.c"	PR2   = 0x33;
	MOVLW	0x33
	MOVWF	_PR2
;	.line	59; "../src/main.c"	T2CON = 0x04;
	MOVLW	0x04
	BANKSEL	_T2CON
	MOVWF	_T2CON
;	.line	60; "../src/main.c"	CCP1CON = 0x0C;
	MOVLW	0x0c
	MOVWF	_CCP1CON
;	.line	62; "../src/main.c"	OPTION_REG = 0x40;
	MOVLW	0x40
	BANKSEL	_OPTION_REG
	MOVWF	_OPTION_REG
;	.line	63; "../src/main.c"	isr();
	CALL	_isr
_00144_DS_:
;	.line	66; "../src/main.c"	raise();
	CALL	_raise
;	.line	67; "../src/main.c"	fall();
	CALL	_fall
	GOTO	_00144_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _set_duty_cycle
;   _wait
;   _set_duty_cycle
;   _wait
;9 compiler assigned registers:
;   r0x1011
;   r0x1012
;   r0x1013
;   r0x1014
;   r0x1015
;   r0x1016
;   r0x1017
;   r0x1018
;   r0x1019
;; Starting pCode block
S_main__fall	code
_fall:
; 2 exit points
;	.line	47; "../src/main.c"	while (duty_cycle != 0) {
	MOVLW	0x64
	BANKSEL	r0x1011
	MOVWF	r0x1011
	CLRF	r0x1012
	CLRF	r0x1013
	CLRF	r0x1014
_00135_DS_:
	BANKSEL	r0x1011
	MOVF	r0x1011,W
	IORWF	r0x1012,W
	IORWF	r0x1013,W
	IORWF	r0x1014,W
	BTFSC	STATUS,2
	GOTO	_00138_DS_
;	.line	48; "../src/main.c"	set_duty_cycle(duty_cycle--);
	MOVF	r0x1011,W
	MOVWF	r0x1015
	MOVF	r0x1012,W
;;1	MOVWF	r0x1016
	MOVF	r0x1013,W
;;1	MOVWF	r0x1017
	MOVF	r0x1014,W
;;1	MOVWF	r0x1018
	MOVLW	0xff
	ADDWF	r0x1011,F
	MOVLW	0xff
	BTFSS	STATUS,0
	ADDWF	r0x1012,F
	MOVLW	0xff
	BTFSS	STATUS,0
	ADDWF	r0x1013,F
	MOVLW	0xff
	BTFSS	STATUS,0
	ADDWF	r0x1014,F
	MOVF	r0x1015,W
;;1	MOVWF	r0x1019
	CALL	_set_duty_cycle
;	.line	49; "../src/main.c"	wait();
	CALL	_wait
	GOTO	_00135_DS_
_00138_DS_:
	RETURN	
; exit point of _fall

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _set_duty_cycle
;   _wait
;   _set_duty_cycle
;   _wait
;9 compiler assigned registers:
;   r0x1011
;   r0x1012
;   r0x1013
;   r0x1014
;   r0x1015
;   r0x1016
;   r0x1017
;   r0x1018
;   r0x1019
;; Starting pCode block
S_main__raise	code
_raise:
; 2 exit points
;	.line	39; "../src/main.c"	while (duty_cycle != 100) {
	BANKSEL	r0x1011
	CLRF	r0x1011
	CLRF	r0x1012
	CLRF	r0x1013
	CLRF	r0x1014
_00118_DS_:
	BANKSEL	r0x1011
	MOVF	r0x1011,W
	XORLW	0x64
	BTFSS	STATUS,2
	GOTO	_00130_DS_
	MOVF	r0x1012,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00130_DS_
	MOVF	r0x1013,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00130_DS_
	MOVF	r0x1014,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00130_DS_
	GOTO	_00121_DS_
_00130_DS_:
;	.line	40; "../src/main.c"	set_duty_cycle(duty_cycle++);
	BANKSEL	r0x1011
	MOVF	r0x1011,W
	MOVWF	r0x1015
	MOVF	r0x1012,W
;;1	MOVWF	r0x1016
	MOVF	r0x1013,W
;;1	MOVWF	r0x1017
	MOVF	r0x1014,W
;;1	MOVWF	r0x1018
	INCF	r0x1011,F
	BTFSC	STATUS,2
	INCF	r0x1012,F
	BTFSC	STATUS,2
	INCF	r0x1013,F
	BTFSC	STATUS,2
	INCF	r0x1014,F
	MOVF	r0x1015,W
;;1	MOVWF	r0x1019
	CALL	_set_duty_cycle
;	.line	41; "../src/main.c"	wait();
	CALL	_wait
	GOTO	_00118_DS_
_00121_DS_:
	RETURN	
; exit point of _raise

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;1 compiler assigned register :
;   r0x100D
;; Starting pCode block
S_main__set_duty_cycle	code
_set_duty_cycle:
; 2 exit points
;;1	MOVWF	r0x100D
;	.line	33; "../src/main.c"	unsigned char duty_cycle = (char)(duty_cycle_percent << 6 / 25); // duty_cycle_percent * 256 / 100
	BANKSEL	_CCPR1L
	MOVWF	_CCPR1L
;	.line	34; "../src/main.c"	CCPR1L = duty_cycle;
	RETURN	
; exit point of _set_duty_cycle

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x100D
;   r0x100E
;   r0x100F
;   r0x1010
;; Starting pCode block
S_main__wait	code
_wait:
; 2 exit points
;	.line	28; "../src/main.c"	unsigned int i = delay << 5;
	BANKSEL	_delay
	MOVF	_delay,W
	BANKSEL	r0x100D
	MOVWF	r0x100D
	CLRF	r0x100E
	SWAPF	r0x100E,W
	ANDLW	0xf0
	MOVWF	r0x100F
	SWAPF	r0x100D,W
	MOVWF	r0x1010
	ANDLW	0x0f
	IORWF	r0x100F,F
	XORWF	r0x1010,F
	BCF	STATUS,0
	RLF	r0x1010,F
	RLF	r0x100F,F
_00109_DS_:
;	.line	29; "../src/main.c"	while(i--);
	BANKSEL	r0x1010
	MOVF	r0x1010,W
	MOVWF	r0x100D
	MOVF	r0x100F,W
	MOVWF	r0x100E
	MOVLW	0xff
	ADDWF	r0x1010,F
	BTFSS	STATUS,0
	DECF	r0x100F,F
	MOVF	r0x100D,W
	IORWF	r0x100E,W
	BTFSS	STATUS,2
	GOTO	_00109_DS_
	RETURN	
; exit point of _wait


;	code size estimation:
;	  156+   28 =   184 instructions (  424 byte)

	end
