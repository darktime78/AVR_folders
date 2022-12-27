PROGS = test_i2c
DIR = ./src
MCU = atmega168pa
CC = avr-gcc
INCLUDE = ./inc
OBJCOPY = avr-objcopy
SIZE = avr-size
CFLAGS = -I $(INCLUDE) -std=gnu99 -DF_CPU=16000000 -mmcu=$(MCU) -fdata-sections -ffunction-sections -Wl,-gc-sections -Wa,-a,-ad -Wall -Os >>compile_asm.log
OBJ = $(addprefix $(DIR)/, test_i2c.o i2c_avr.o )
#TARGET = control_t2313a
#CLEANFILES = core core.* *.o temp.* *.out
.PHONY: all clean

%.o:	$(DIR)/%.c
	$(CC) -c $(CFLAGS) -o $@ $< 

all:	$(PROGS)

$(PROGS):	$(OBJ)
	$(CC) $(CFLAGS) -o $@.elf $(OBJ)
	$(SIZE) $(PROGS).elf
	$(OBJCOPY) -O ihex $(PROGS).elf $@.hex

clean:
	@rm -f $(DIR)/*.o
