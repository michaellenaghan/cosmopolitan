#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_FIO_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_FIO_H_
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const uint32_t FIOASYNC;
extern const uint32_t FIOCLEX;
extern const uint32_t FIONBIO;
extern const uint32_t FIONCLEX;
extern const uint32_t FIONREAD;

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */

#define FIOASYNC FIOASYNC
#define FIOCLEX  FIOCLEX
#define FIONBIO  FIONBIO
#define FIONCLEX FIONCLEX
#define FIONREAD FIONREAD

#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_FIO_H_ */
