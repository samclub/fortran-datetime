#!/bin/csh

rm -rf a.out

ifort -O2 -Ofast time_manager.F90 test_time_manager.F90 -o a.out
rm -rf *.o *.mod

./a.out


