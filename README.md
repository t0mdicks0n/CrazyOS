## CrazyOS

### System Requirements
grub2

### How to Run
Compile the loader
```
make loader.o
```
Compile the main kernel CPP program
```
make kernel.o
```
Link the loader and the linker and create the binary executable of the CrazyOS Kernel
```
make crazykernel.bin
```
Create an ISO file of the kernel
```
make crazykernel.iso
```
To run it simply execute
```
make run
```