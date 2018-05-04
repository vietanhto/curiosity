DEFAULT_HOST!=i686-elf
HOST?=DEFAULT_HOST
HOSTARCH!=i386

CFLAGS?=-O2 -g
CPPFLAGS?=
LDFLAGS?=
LIBS?=

DESTDIR?=
PREFIX?=/usr/local
EXEC_PREFIX?=$(PREFIX)
BOOTDIR?=$(EXEC_PREFIX)/boot
INCLUDEDIR?=$(PREFIX)/include

CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS:=$(LDFLAGS)
LIBS:=$(LIBS) -nostdlib -lgcc

ARCHDIR=arch/i386

# include $(ARCHDIR)/make.config

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_ARCH_OBJS=\
$(ARCHDIR)/boot.o

KERNEL_OBJS=\
$(KERNEL_ARCH_OBJS) \
src/kernel/kernel.o \

OBJS=\
$(ARCHDIR)/boot.o \
$(KERNEL_OBJS) \

LINK_LIST=\
$(LDFLAGS) \
$(KERNEL_OBJS) \
$(LIBS) \

# .PHONY: all clean install install-headers install-kernel
.PHONY: all clean
# .SUFFIXES: .o .c .S

all: curiosity.bin

curiosity.bin: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)

$(ARCHDIR)/boot.o:
	OBJ=`$(CC) $(CFLAGS) $(LDFLAGS) -print-file-name=$(@F)` && cp "$$OBJ" $@

.c.o:
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)

.s.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

clean:
	rm -f curiosity.bin
# 	rm -f $(OBJS) *.o */*.o */*/*.o
# 	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d

# install: install-headers install-kernel

# install-headers:
# 	mkdir -p $(DESTDIR)$(INCLUDEDIR)
# 	cp -R --preserve=timestamps include/. $(DESTDIR)$(INCLUDEDIR)/.

# install-kernel: myos.kernel
# 	mkdir -p $(DESTDIR)$(BOOTDIR)
# 	cp myos.kernel $(DESTDIR)$(BOOTDIR)

# -include $(OBJS:.o=.d)
