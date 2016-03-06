
/*
 * HEADER FILE(S)
 */

// device header file
#include <pic14/pic16f627a.h>


/*
 * CONFIGURATION WORD
 */
static __code unsigned int __at (_CONFIG) config_word = 
  _HS_OSC &     // high speed osc(20MHz)
  _WDT_OFF &    // watchdog off
  _MCLRE_OFF &  // MCLR off
  _LVP_OFF &    // disable low voltage programming
  _CP_OFF;      // disable code protection


/*
 * CONSTANTS
 */

// INTCON configuration for enabled state of TMR0
#define INTCON_CONFIG 0xA0

// interrupt frequency in Hz
#define INT_FREQ      86207
#define INT_FREQ_HALF 43103

// timer configuration for generating INT_FREQ
#define TMR_CONFIG    0xE2


/*
 * GLOBAL VARIABLES
 */

// number of interrupts to skip and it's buffer.
// each skips means (1/INT_FREQ) second is passed, and it's the only way to determine the time.
unsigned int skips, skips_buffer;


/*
 * FUNCTIONS
 */

// interrupt handler
void isr(void) __interrupt (0) {
  INTCON = 0x00;

  if (--skips) {
    PORTAbits.RA0++;
  }
  
  TMR0 = TMR0_CONFIG;
  INTCON = INTCON_CONFIG;
}

// apply system configuration and enable TMR0 interrupts
void setup(void) {
  PORTA = 0x00;
  TRISA = 0xFE;

  OPTION_REG = 0x80;
  TMR0 = TMR0_CONFIG;
  INTCON = INTCON_CONFIG;
}

// calculcate count of needed skips to generate exact frequency.
void calc_skips(int freq) {

  // skips calculated from following eq:
  // skips = INT_FREQ / ( 2 * freq )
  skips = INT_FREQ_HALF / freq;

}

// program start point
void main(void) {

  // setup system configuration
  setup();

  while(1) {

    // if buffer is used, fill it again
    if (skips_buffer == 0)
      calc_skips(440);

    // if skips are done, fill it with buffer and empty buffer
    if (skips == 0) {
      skips = skips_buffer;
      skips_buffer = 0;
    }

  }

}
