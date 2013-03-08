#include "fftref.h"
#include "fftverify.h"
#include "xparameters.h"
#include "xtmrctr.h"

// YOU ARE NOT ALLOWED TO MAKE CHANGES IN THIS FILE
// THE VERIFICATION ROUTINE MUST EXECUTE UNMODIFIED

extern void my_fftfix(unsigned m, int *x, int *y);
extern void reference_fftfix(unsigned m, int *x, int *y);

volatile unsigned *fftbuffer_real = 
	(volatile unsigned *) XPAR_XPS_BRAM_IF_CNTLR_0_BASEADDR;

volatile unsigned *fftbuffer_imag = 
	(volatile unsigned *) (XPAR_XPS_BRAM_IF_CNTLR_0_BASEADDR + 0x1000);

void load_reference_pulse() {
	unsigned i;
	for (i=0; i<(1 << MAXLOG2FFT); i++) {
		fftbuffer_real[i] = 0;
		fftbuffer_imag[i] = 0;
	}
	fftbuffer_real[0] = SCALEUP(1);
	fftbuffer_real[1] = SCALEUP(1);
	fftbuffer_real[2] = SCALEUP(1);
	fftbuffer_real[3] = SCALEUP(1);
	fftbuffer_real[4] = SCALEUP(1);
	fftbuffer_real[5] = SCALEUP(1);
	fftbuffer_real[6] = SCALEUP(1);
	fftbuffer_real[7] = SCALEUP(1);
}

int bufr[1 << MAXLOG2FFT];
int bufi[1 << MAXLOG2FFT];

unsigned comparefft() {
	unsigned i, acc;

	xil_printf("Functional Correctness Test\n");

	xil_printf("... Reference FFT\n");
	load_reference_pulse();
	reference_fftfix(MAXLOG2FFT, 
						  (int *) fftbuffer_real, 
						  (int *) fftbuffer_imag);
	for (i=0; i<(1 << MAXLOG2FFT); i++) {
		bufr[i] = fftbuffer_real[i];
		bufi[i] = fftbuffer_imag[i];
	}

	xil_printf("... Optimized FFT\n");
	load_reference_pulse();
	my_fftfix(MAXLOG2FFT, 
			    (int *) fftbuffer_real, 
				 (int *) fftbuffer_imag);

	xil_printf("... Error accumulation\n");
	acc = 0;
	for (i=0; i<(1 << MAXLOG2FFT); i++) {
		acc += (fftbuffer_real[i] - bufr[i]) * 
		       (fftbuffer_real[i] - bufr[i]);
		acc += (fftbuffer_imag[i] - bufi[i]) *
		       (fftbuffer_imag[i] - bufi[i]);
	}

   xil_printf("... Accumulated error: %d\n", acc);
   if (acc < 200000) {
     xil_printf("... Error is within acceptable range.\n");
   } else {
     xil_printf("... Error is too large!\n");
	}
	return acc;
}

void measurefft() {
  unsigned i, j;
  unsigned reftiming[4];
  unsigned hwtiming[4];
  XTmrCtr  T;

  XTmrCtr_Initialize(&T, XPAR_XPS_TIMER_0_DEVICE_ID);
  XTmrCtr_SetResetValue(&T, 0, 0);

  xil_printf("Performance Test\n");
  for (i=4; i>0; i--) {
    reftiming[i-1] = 0;
    xil_printf("... Reference FFT size %4d ", (1 << (MAXLOG2FFT - i + 1)));
    for (j=0; j<8; j++) {
      load_reference_pulse();
      XTmrCtr_Reset(&T, 0);
	   XTmrCtr_Start(&T, 0);
      reference_fftfix(MAXLOG2FFT - i + 1, 
						     (int *) fftbuffer_real, 
							  (int *) fftbuffer_imag);
      XTmrCtr_Stop(&T, 0);
	   reftiming[i-1] += XTmrCtr_GetValue(&T, 0);
      xil_printf("%8d ", XTmrCtr_GetValue(&T, 0));
    }
	 xil_printf("\n");
    reftiming[i-1] >>= 3;
  }

  for (i=4; i>0; i--) {
    hwtiming[i-1] = 0;
    xil_printf("... Optimized FFT size %4d ", (1 << (MAXLOG2FFT - i + 1)));
    for (j=0; j<8; j++) {
      load_reference_pulse();
      XTmrCtr_Reset(&T, 0);
	   XTmrCtr_Start(&T, 0);
      my_fftfix(MAXLOG2FFT - i + 1, 
					 (int *) fftbuffer_real, 
					 (int *) fftbuffer_imag);
      XTmrCtr_Stop(&T, 0);
	   hwtiming[i-1] += XTmrCtr_GetValue(&T, 0);
      xil_printf("%8d ", XTmrCtr_GetValue(&T, 0));
    }
	 xil_printf("\n");
    hwtiming[i-1] >>= 3;
  }

          //  1234567890123456789012345678901234567890
  xil_printf("     N        REF        OPT SPEEDUPx100\n");
  for (i=4; i>0; i--) {
    xil_printf("%6d %10d %10d     %7d\n",
	             (1 << (MAXLOG2FFT - i + 1)),
					 reftiming[i-1],
					 hwtiming[i-1],
					 100*reftiming[i-1]/hwtiming[i-1]);
  }

}
