// header file
#include <pic14/pic16f627a.h>


// configuration word
static __code unsigned int __at (_CONFIG) config_word = 
  _HS_OSC &     // high speed osc(20MHz)
  _WDT_OFF &    // watchdog off
  _MCLRE_OFF &  // MCLR off
  _LVP_OFF &    // disable low voltage programming
  _CP_OFF;      // disable code protection


// global variables
unsigned int i;


// functions
void wait(void) {
  i = 0xFFFF;
  while(i--);
}

void main(void) {
  TRISB = 0xF7; // just RB3 is output

  while(1) {
    RB3++;
    wait();
  }
}
