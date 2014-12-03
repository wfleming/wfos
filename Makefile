CC=gcc
LD=ld
CFLAGS=-c -Wall


all: kernel

kernel: kasm.o kernel.o
	$(LD) -m elf_i386 -T kernel/link.ld -o kernel/kernel kernel/kasm.o kernel/kernel.o

kasm.o:
	nasm -f elf kernel/kernel.asm -o kernel/kasm.o

kernel.o:
	$(CC) $(CFLAGS) -m32 kernel/*.c -o kernel/kernel.o

clean:
	rm  -rf kernel/*.o kernel/kernel
