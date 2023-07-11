#-*-mode:makefile-gmake;indent-tabs-mode:t;tab-width:8;coding:utf-8-*-┐
#───vi: set et ft=make ts=8 tw=8 fenc=utf-8 :vi───────────────────────┘
#
# OVERVIEW
#
#   αcτµαlly pδrταblε εxεcµταblε
#
# DESCRIPTION
#
#   This file defines the libraries, runtimes, and build rules needed to
#   create executables from your Linux workstation that'll run anywhere.
#   Loading this package will make certain systemic modifications to the
#   build like turning off the System V "Red Zone" optimization, because
#   αcτµαlly pδrταblε εxεcµταblεs need to be able to run in kernelspace.

PKGS += APE

APE_FILES := $(wildcard ape/*.*)
APE_HDRS = $(filter %.h,$(APE_FILES))
APE_INCS = $(filter %.inc,$(APE_FILES))

ifeq ($(ARCH), aarch64)

APE = o/$(MODE)/ape/aarch64.lds

APELINK =					\
	$(COMPILE)				\
	-ALINK.ape				\
	$(LINK)					\
	$(LINKARGS)				\
	$(OUTPUT_OPTION) &&			\
	$(COMPILE)				\
	-AFIXUP.ape				\
	-wT$@					\
	$(FIXUPOBJ)				\
	$@

APE_SRCS = ape/ape.S
APE_OBJS = o/$(MODE)/ape/ape.o
APE_NO_MODIFY_SELF = $(APE)
APE_COPY_SELF = $(APE)

.PHONY: o/$(MODE)/ape
o/$(MODE)/ape: $(APE)

o/$(MODE)/ape/aarch64.lds:			\
	ape/aarch64.lds				\
	libc/zip.internal.h			\
	libc/intrin/bits.h			\
	libc/thread/tls.h			\
	libc/calls/struct/timespec.h		\
	libc/macros.internal.h			\
	libc/str/str.h

else

APE =	o/$(MODE)/ape/ape.o			\
	o/$(MODE)/ape/ape.lds

APELINK =					\
	$(COMPILE)				\
	-ALINK.ape				\
	$(LINK)					\
	$(LINKARGS)				\
	$(OUTPUT_OPTION) &&			\
	$(COMPILE)				\
	-AFIXUP.ape				\
	-wT$@					\
	$(FIXUPOBJ)				\
	$@

APE_NO_MODIFY_SELF =				\
	o/$(MODE)/ape/ape.lds			\
	o/$(MODE)/ape/ape-no-modify-self.o

APE_COPY_SELF =					\
	o/$(MODE)/ape/ape.lds			\
	o/$(MODE)/ape/ape-copy-self.o

APE_LOADER_FLAGS =				\
	-DNDEBUG				\
	-iquote.				\
	-Wall					\
	-Wextra					\
	-fpie					\
	-Os					\
	-ffreestanding				\
	-mgeneral-regs-only			\
	-fno-stack-protector			\
	-fno-ident				\
	-fno-gnu-unique				\
	-c					\
	 $(OUTPUT_OPTION)			\
	$<

APE_SRCS_C = ape/loader.c
APE_SRCS_S = $(filter %.S,$(APE_FILES))
APE_SRCS = $(APE_SRCS_C) $(APE_SRCS_S)
APE_OBJS = $(APE_SRCS_S:%.S=o/$(MODE)/%.o)
APE_CHECKS = $(APE_HDRS:%=o/%.ok)

o/$(MODE)/ape/public/ape.lds: CPPFLAGS += -UCOSMO
o/$(MODE)/ape/public/ape.lds:			\
		ape/public/ape.lds		\
		ape/ape.lds			\
		ape/ape.internal.h		\
		ape/macros.internal.h		\
		ape/relocations.h		\
		libc/intrin/bits.h		\
		libc/thread/tls.h		\
		libc/calls/struct/timespec.h	\
		libc/thread/thread.h		\
		libc/dce.h			\
		libc/elf/def.h			\
		libc/elf/pf2prot.internal.h	\
		libc/macros.internal.h		\
		libc/nt/pedef.internal.h	\
		libc/str/str.h			\
		libc/zip.internal.h

o/ape/idata.inc:				\
		ape/idata.internal.h		\
		ape/relocations.h

o/$(MODE)/ape/ape-no-modify-self.o:		\
		ape/ape.S			\
		ape/macros.internal.h		\
		ape/notice.inc			\
		ape/relocations.h		\
		ape/ape.internal.h		\
		libc/dce.h			\
		libc/elf/def.h			\
		libc/thread/tls.h		\
		libc/intrin/asancodes.h		\
		libc/macho.internal.h		\
		libc/macros.internal.h		\
		libc/nexgen32e/uart.internal.h	\
		libc/calls/metalfile.internal.h	\
		libc/nexgen32e/vidya.internal.h	\
		libc/nt/pedef.internal.h	\
		libc/runtime/e820.internal.h	\
		libc/runtime/mman.internal.h	\
		libc/runtime/pc.internal.h	\
		libc/sysv/consts/prot.h		\
		ape/blink-linux-aarch64.gz	\
		ape/blink-xnu-aarch64.gz	\
		o/$(MODE)/ape/ape.elf
	@$(COMPILE)				\
		-AOBJECTIFY.S			\
		$(OBJECTIFY.S)			\
		$(OUTPUT_OPTION)		\
		-DAPE_NO_MODIFY_SELF		\
		-DAPE_LOADER='"o/$(MODE)/ape/ape.elf"' $<

o/$(MODE)/ape/ape-copy-self.o:			\
		ape/ape.S			\
		ape/macros.internal.h		\
		ape/notice.inc			\
		ape/relocations.h		\
		ape/ape.internal.h		\
		libc/dce.h			\
		libc/elf/def.h			\
		libc/thread/tls.h		\
		libc/intrin/asancodes.h		\
		libc/macho.internal.h		\
		libc/macros.internal.h		\
		libc/nexgen32e/uart.internal.h	\
		libc/calls/metalfile.internal.h	\
		libc/nexgen32e/vidya.internal.h	\
		libc/nt/pedef.internal.h	\
		libc/runtime/e820.internal.h	\
		libc/runtime/mman.internal.h	\
		libc/runtime/pc.internal.h	\
		libc/sysv/consts/prot.h		\
		ape/blink-linux-aarch64.gz	\
		ape/blink-xnu-aarch64.gz
	@$(COMPILE)				\
		-AOBJECTIFY.S			\
		$(OBJECTIFY.S)			\
		$(OUTPUT_OPTION)		\
		-DAPE_NO_MODIFY_SELF $<

o/$(MODE)/ape/loader.o: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CC) -DSUPPORT_VECTOR=0b01111001 -g $(APE_LOADER_FLAGS)
o/$(MODE)/ape/loader-gcc.asm: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CC) -DSUPPORT_VECTOR=0b01111001 -S -g0 $(APE_LOADER_FLAGS)
o/$(MODE)/ape/loader-clang.asm: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CLANG) -DSUPPORT_VECTOR=0b01111001 -S -g0 $(APE_LOADER_FLAGS)

o/$(MODE)/ape/loader-xnu.o: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CC) -DSUPPORT_VECTOR=0b00001000 -g $(APE_LOADER_FLAGS)
o/$(MODE)/ape/loader-xnu-gcc.asm: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CC) -DSUPPORT_VECTOR=0b00001000 -S -g0 $(APE_LOADER_FLAGS)
o/$(MODE)/ape/loader-xnu-clang.asm: ape/loader.c
	@$(COMPILE) -AOBJECTIFY.c $(CLANG) -DSUPPORT_VECTOR=0b00001000 -S -g0 $(APE_LOADER_FLAGS)

o/$(MODE)/ape/ape.elf: o/$(MODE)/ape/ape.elf.dbg
o/$(MODE)/ape/ape.macho: o/$(MODE)/ape/ape.macho.dbg

APE_LOADER_LDFLAGS =				\
	-static					\
	-no-pie					\
	-nostdlib				\
	--no-dynamic-linker			\
	-zcommon-page-size=0x1000		\
	-zmax-page-size=0x1000

o/$(MODE)/ape/ape.elf.dbg:			\
		o/$(MODE)/ape/loader.o		\
		o/$(MODE)/ape/loader-elf.o	\
		ape/loader.lds
	@$(COMPILE) -ALINK.elf $(LINK) -T ape/loader.lds $(APE_LOADER_LDFLAGS) -o $@ o/$(MODE)/ape/loader-elf.o o/$(MODE)/ape/loader.o

o/$(MODE)/ape/ape.macho.dbg:			\
		o/$(MODE)/ape/loader-xnu.o	\
		o/$(MODE)/ape/loader-macho.o	\
		ape/loader.lds
	@$(COMPILE) -ALINK.elf $(LINK) -T ape/loader.lds $(APE_LOADER_LDFLAGS) -o $@ o/$(MODE)/ape/loader-macho.o o/$(MODE)/ape/loader-xnu.o

.PHONY: o/$(MODE)/ape
o/$(MODE)/ape:	$(APE_CHECKS)			\
		o/$(MODE)/ape/ape.o		\
		o/$(MODE)/ape/ape.lds		\
		o/$(MODE)/ape/public/ape.lds	\
		o/$(MODE)/ape/ape.elf		\
		o/$(MODE)/ape/ape.macho		\
		o/$(MODE)/ape/ape-copy-self.o	\
		o/$(MODE)/ape/ape-no-modify-self.o

endif

# these assembly files are safe to build on aarch64
o/$(MODE)/ape/ape.o: ape/ape.S
	@$(COMPILE) -AOBJECTIFY.S $(OBJECTIFY.S) $(OUTPUT_OPTION) -c $<

o/$(MODE)/ape/ape.o:				\
		ape/blink-linux-aarch64.gz	\
		ape/blink-xnu-aarch64.gz

o/$(MODE)/ape/ape.lds:				\
		ape/ape.lds			\
		ape/macros.internal.h		\
		ape/relocations.h		\
		ape/ape.internal.h		\
		libc/intrin/bits.h		\
		libc/thread/tls.h		\
		libc/calls/struct/timespec.h	\
		libc/thread/thread.h		\
		libc/dce.h			\
		libc/elf/def.h			\
		libc/elf/pf2prot.internal.h	\
		libc/macros.internal.h		\
		libc/nt/pedef.internal.h	\
		libc/str/str.h			\
		libc/zip.internal.h
