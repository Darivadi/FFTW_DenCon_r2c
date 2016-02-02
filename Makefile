CC = gcc

CFLAGS = -O3 -I/home/$(USER)/local/include -I/usr/include/ -DCIC -DASCIIDATA -DOUTOFPLACE -DPOTDOTEXACT -DPOTDOTLINEAR -DPSLINEAL
#CFLAGS = -O3 -I/home/$(USER)/local/include -I/usr/include/ -DCIC -DASCIIDATA -DOUTOFPLACE
CFLAGSINPLACE = -O3 -I/home/$(USER)/local/include -I/usr/include/ -DCIC -DASCIIDATA -DINPLACE -DPOTDOTEXACT -DPOTDOTLINEAR
CFLAGSDEBUG = -g -Wall -c -I/home/$(USER)/local/include/ -I/usr/include/ -DCIC -DASCIIDATA -DOUTOFPLACE -DPOTDOTEXACT -DPOTDOTLINEAR
CFLAGSASCII = -g -Wall -c -I/home/$(USER)/local/include/ -I/usr/include/ -DCIC -DASCIIDATA
LFLAGS = -L$(HOME)/local/lib

PROGRAM = FFT_of_densities


$(PROGRAM):	
	$(CC) -c -save-temps $@.c $(CFLAGS)
	$(CC) $@.o -lgsl -lgslcblas -lm -lfftw3 $(LFLAGS) -o $@.x


debug:
	echo Compiling for debug $(PROGRAM).c
	$(CC) $(CFLAGSDEBUG) $(PROGRAM).c -o $(PROGRAM).o
	$(CC) $(PROGRAM).o $(LFLAGS) -lgsl -lgslcblas -lfftw3 -lm -o $(PROGRAM)_debug.x


asciidata:
	echo Compiling for ascii format $(PROGRAM).c
	$(CC) $(CFLAGSASCII) $(PROGRAM).c -o $(PROGRAM).o
	$(CC) $(PROGRAM).o $(LFLAGS) -lgsl -lgslcblas -lfftw3 -lm -o $(PROGRAM)_ascii.x


inplace:
	echo Compiling for in-place transforms $(PROGRAM).c
	$(CC) -c -save-temps $(PROGRAM).c $(CFLAGSINPLACE)
	$(CC) $(PROGRAM).o $(LFLAGS) -lgsl -lgslcblas -lm -lfftw3 -o $(PROGRAM)_inplace.x


clean:
	rm -rf $(PROGRAM)
	rm -rf *~
	rm -rf *.out
	rm -rf *#
	rm -rf *.o
	rm -rf *.a
	rm -rf *.i
	rm -rf *.so
	rm -rf *.x
