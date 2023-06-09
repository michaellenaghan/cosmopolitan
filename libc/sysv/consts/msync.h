#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_MSYNC_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_MSYNC_H_
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const int MS_SYNC;
extern const int MS_ASYNC;
extern const int MS_INVALIDATE;

#define MS_ASYNC      1
#define MS_SYNC       MS_SYNC
#define MS_INVALIDATE MS_INVALIDATE

#define __tmpcosmo_MS_SYNC       534308386
#define __tmpcosmo_MS_INVALIDATE 635516839

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_MSYNC_H_ */
