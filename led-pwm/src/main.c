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
unsigned char delay, stat, delays[] = {0x01, 0x07, 0x10, 0x20, 0x30, 0x60, 0x90, 0xA0, 0xC0, 0xE0};


// functions
void isr(void) __interrupt (0) {
  INTCON = 0x00;
  
  delay = delays[ stat++ % 10 ];

  INTCON = 0x90;
}

void wait(void) {
  unsigned int i = delay << 5;
  while(i--);
}

void set_duty_cycle(char duty_cycle_percent) {
  unsigned char duty_cycle = (char)(duty_cycle_percent << 6 / 25); // duty_cycle_percent * 256 / 100
  CCPR1L = duty_cycle;
}

void raise(void) {
  unsigned long duty_cycle = 0;
  while (duty_cycle != 100) {
    set_duty_cycle(duty_cycle++);
    wait();
  }
}

void fall(void) {
  unsigned long duty_cycle = 100;
  while (duty_cycle != 0) {
    set_duty_cycle(duty_cycle--);
    wait();
  }
}

void main(void) {

  TRISB = 0xF7; // just RB3 is output

  // config pwm module at ~= 98KHz
  PR2   = 0x33;
  T2CON = 0x04;
  CCP1CON = 0x0C;

  OPTION_REG = 0x40;
  isr();

  while(1) {
    raise();
    fall();
  }
}
