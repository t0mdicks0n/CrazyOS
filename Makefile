# Tell C++ to use the 32 bit version, also give it the extra params to know that it is missing all these libs
GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAMS) -c -o $@ $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

crazykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: crazykernel.bin
	sudo cp $< /boot/crazykernel.bin

crazykernel.iso: crazykernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "Crazy Operating System" {' >> iso/boot/grub/grub.cfg
	echo '  multiboot /boot/crazykernel.bin' >> iso/boot/grub/grub.cfg
	echo '  boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue --output=$@ iso
	# grub2-common:i386-mkrescue --output=$@ iso
	rm -rf iso

run: crazykernel.iso
	(killall VirtualBox && sleep 1) || true
	virtualbox --startvm "CrazyVM" &>/dev/null