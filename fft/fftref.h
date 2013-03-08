#ifndef FFTREF_H
#define FFTREF_H

#define MAXLOG2FFT 10
#define SCALEDOWN(A) (A >> 16)
#define SCALEUP(A)   (A << 16)
void    reference_fftfix(unsigned m, int *x, int *y);

#endif
