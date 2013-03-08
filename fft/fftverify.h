#ifndef VERIFY_H
#define VERIFY_H

extern  volatile unsigned *fftbuffer_real;
extern  volatile unsigned *fftbuffer_imag;

void     load_reference_pulse();
unsigned comparefft();
void     measurefft();

#endif
