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

define GRUBCONFIG
menuentry "wfos" {
	set root='hd0,1'
	multiboot /boot/wf-kernel ro
}
endef
export GRUBCONFIG
install: kernel
	cp kernel/kernel /boot/wf-kernel
	echo "Writing Grub config"
	@echo "$$GRUBCONFIG" > /boot/grub/custom.cfg

clean:
	rm  -rf kernel/*.o kernel/kernel
