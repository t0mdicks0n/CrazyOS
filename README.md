# CrazyOS

A bare-metal x86 operating system kernel built from scratch in C++ and assembly.

## What's implemented

- **Multiboot-compliant bootloader** -- x86 assembly loader (`loader.s`) with Multiboot header, sets up 2 MiB kernel stack
- **Kernel entry point** -- C++ kernel with global constructor support, calls `kernelMain` after initialization
- **VGA text-mode output** -- custom `printf` that writes directly to video memory at `0xb8000`
- **Custom type system** -- freestanding `types.h` with fixed-width integer types (no standard library)
- **Linker script** -- ELF32 layout loaded at `0x0100000` with `.text`, `.data`, `.bss` sections and constructor array ordering
- **Build toolchain** -- cross-compiles with `-nostdlib -fno-builtin -fno-rtti -fno-exceptions`, links as `elf32-i386`
- **GRUB2 bootable ISO** -- `make crazykernel.iso` produces a bootable ISO image, runs in VirtualBox

## How to run

Requires: `g++`, `as`, `ld`, `grub-mkrescue`, VirtualBox (with a VM named "CrazyVM")

```bash
make crazykernel.iso    # Build bootable ISO
make run                # Launch in VirtualBox
```

Or step by step:

```bash
make loader.o           # Assemble bootloader
make kernel.o           # Compile kernel
make crazykernel.bin    # Link into ELF binary
make crazykernel.iso    # Package as GRUB2 ISO
```

## Stack

C++, x86 Assembly, GRUB2, VirtualBox
