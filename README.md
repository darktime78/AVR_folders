# AVR_folders
AVR example directories for build and firmware from linux

# Installing packages
#sudo pacman -S avr-gcc avr-libc avr-binutils avr-gdb avrdude
# Debugging firmware  
- Now launch in QEMU, halting the CPU when it first starts, and listening on TCP port 1234 for gdb remote control:  
__#qemu-system-avr -S -s -nographic -machine mega2560 -bios blinky.elf__  
  > - -S - freeze CPU at startup (use 'c' to start execution)  
  > - -s - shorthand for -gdb tcp::1234  
- We can connect AVR GDB to QEMU in another terminal:  
__#avr-gdb -ex 'target remote :1234' blinky.elf__  
You can kill the QEMU session with 'k' or 'mon q' in GDB.   
- Continuous non interrupted execution with serial output into telnet window:  
__#qemu-system-avr -M mega2560 -bios blinky.elf -nographic -serial tcp::5678,server=on,wait=off__  
- Connect in another shell:  
 __#telnet localhost 5678__  
- Print out executed instructions (that have not been translated by the JIT compiler yet):  
__#qemu-system-avr -machine mega2560 -bios blinky.elf -d in_asm__




