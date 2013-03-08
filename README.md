FFT-Coprocessor
===============

Three forms of source are included in this repository: VHDL, Gezel, and C.

The C code, which is responsible for managing the FPGA coprocessor, is found in the //fft/ directory. This includes a fully serial reference implementation of the FFT algorithm (found in the file fftref.c), and my own implementation which makes use of the FGPA coprocessor for large speed gains (found in the file main.c). 

The fft.fdl file (in the root directory of this repo) is written in Gezel, a hardware description language designed by my professor. It is used specifically for designing hardware coprocessors, and is translated into VHDL via scripts. This file contains descriptions of two pieces of hardware: one to accomplish an 8-bit address reversal, and one to perform the "butterfly" computation necessary for the Cooley-Tukey FFT algorithm. 

The VHDL, generated from the fft.fdl Gezel file, becomes very dense. The two hardware modules from above are found in //pcores/fsladdress_v1_00_a and //pcores/fslbutterfly_v1_00_a. These modules are what the FPGA is programmed with.
