# AVR_folders
AVR example directories for build and firmware from linux

# Installing packages
#sudo pacman -S avr-gcc avr-libc avr-binutils avr-gdb avrdude
# Set device permissions for the USBasp programmer  
> $ lsusb  
...  
Bus 003 Device 018: ID 16c0:05dc Van Ooijen Technische Informatica shared ID for use with libusb  
...  
$ ls -al /dev/bus/usb/003/018  
crw-rw-r-- 1 root root 189, 273 23. Aug 11:23 /dev/bus/usb/003/018

The quick and dirty solution is to simply change the device permissions by hand.  
__#sudo chmod 666 /dev/bus/usb/003/018__  
## Permanent solution
The rule from the firmware package just sets the file permissions to 666, which is a bit crude. In Arch Linux the group ***uucp*** is used for "Serial and USB devices such as modems, handhelds, RS-232/serial ports", so it makes sense to use it for the USBasp device.  
 __#sudo vim /etc/udev/rules.d/99-USBasp.rules__  
> #Set Group for USBasp  
  SUBSYSTEM=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", GROUP="uucp", MODE="0666"
 
You also have to add your user to that group. For this to take effect you have to log out and then log in again.  
__#gpasswd -a <user_name> uucp__  
Please note that the group is called ***uucp*** only in Arch Linux. Other distributions use a different group for the same thing. Ubuntu for example uses the group ***dialout***.
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




