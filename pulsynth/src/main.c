// header file
#include <pic14/pic16f627a.h>


// configuration word
static __code unsigned int __at (_CONFIG) config_word = 
  _HS_OSC &     // high speed osc(20MHz)
  _WDT_OFF &    // watchdog off
  _MCLRE_OFF &  // MCLR off
  _LVP_OFF &    // disable low voltage programming
  _CP_OFF;      // disable code protection


// constants
#define INTCON_CONFIG 0xA0

// timer configuration
#define INT_FREQ      86207
#define TMR_CONFIG    0xE2


// global variables
unsigned int skips; // number of interrupts to skip


// functions
void isr(void) __interrupt (0) {
  INTCON = 0x00;

  if (--skips) {
    PORTAbits.RA0++;
  }
  
  TMR0 = TMR0_CONFIG;
  INTCON = INTCON_CONFIG;
}

void setup(void) {
  PORTA = 0x00;
  TRISA = 0xFE;

  OPTION_REG = 0x80;
  TMR0 = TMR0_CONFIG;
  INTCON = INTCON_CONFIG;
}

void calc_skips(void) {
  skips = 0x62;
}

void main(void) {

  setup();

  while(1) if (skips == 0) calc_skips();

}
