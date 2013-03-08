#include <stdio.h>
#include "fsl.h"
#include "fftref.h"
#include "fftverify.h"

// YOU NEED TO PROVIDE AN ACCELERATED IMPLEMENTATION
// FOR THE FUNCTION MY_FFTFIX
//
// THE MY_FFTFIX FUNCTION NEEDS TO HAVE THE SAME BEHAVIOR AS
// REFERENCE_FFTFIX, WHICH CAN BE FOUND IN FFTREF.C

extern int sintab[];

void my_fftfix(unsigned m, int *x, int *y) {
	int n,i,i1,j,k,i2,l,l1,l2;
	int tx,ty,t1,t2,u1,u2;
	int x_temp, y_temp, maxlogsubone_temp;
	int maxlogsubtwo_temp = 1 << (MAXLOG2FFT - 2);

	n = 1L << m;
	i2 = n >> 1;
	j = 0;

	/*	Do bit reversal and reordering	*/
	for (i=0;i<n-1;i++) {
	
		/*	Get bit reversed address from coprocessor	*/
		putfslx((unsigned) n, 1, FSL_CONTROL);
		putfslx((unsigned) i, 1, FSL_CONTROL);
		getfslx((unsigned*) j, 1, FSL_CONTROL);

		if (i < j) {
			tx = x[i];
			ty = y[i];
			x[i] = x[j];
			y[i] = y[j];
			x[j] = tx;
			y[j] = ty;
		}
	}
	
	/* Compute the FFT */
	l2 = 1;
	for (l=0;l<m;l++) {
		l1 = l2;
		l2 <<= 1;
		maxlogsubone_temp = (MAXLOG2FFT - l - 1);
		for (j=0;j<l1;j++) {
			u1 =  sintab[(j << maxlogsubone_temp) + maxlogsubtwo_temp];
			u2 = -sintab[(j << maxlogsubone_temp)];
			u1 >>= 1;
			u2 >>= 1;
			for (i=j;i<n;i+=l2) {
				i1 = i + l1;
				
				x_temp = x[i] >> 1;
				y_temp = y[i] >> 1;
				
				/* Get butterfly calculation from coprocessor	*/
				putfslx((unsigned) u2, 0, FSL_CONTROL);
				putfslx((unsigned) u1, 0, FSL_CONTROL);
				putfslx((unsigned) x[i1], 0, FSL_CONTROL);
				putfslx((unsigned) y[i1], 0, FSL_CONTROL);
				getfslx((unsigned*) t1, 0, FSL_CONTROL);
				getfslx((unsigned*) t2, 0, FSL_CONTROL);
				
				x[i1] = x_temp - t1; 
				y[i1] = y_temp - t2;
				x[i]  = x_temp + t1;
				y[i]  = y_temp + t2;
			}
		}
	}
}
int main() {
  unsigned error;
  
  // verification of functional correctness
  error = comparefft();

  // performance evaluation
  measurefft();

  return 0;
}
