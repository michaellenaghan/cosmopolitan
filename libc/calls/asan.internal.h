#ifndef COSMOPOLITAN_LIBC_CALLS_ASAN_INTERNAL_H_
#define COSMOPOLITAN_LIBC_CALLS_ASAN_INTERNAL_H_
#include "libc/intrin/asmflag.h"
#include "libc/calls/struct/timespec.h"
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

forceinline bool __asan_is_valid_timespec(const struct timespec *ts) {
  bool zf;
  asm(ZFLAG_ASM("cmpw\t$0,0x7fff8000(%1)")
      : ZFLAG_CONSTRAINT(zf)
      : "r"((intptr_t)ts >> 3)
      : "memory");
  return zf;
}

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_CALLS_ASAN_INTERNAL_H_ */
