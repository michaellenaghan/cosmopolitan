#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_RUSAGE_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_RUSAGE_H_
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const int RUSAGE_BOTH;
extern const int RUSAGE_CHILDREN;
extern const int RUSAGE_SELF;
extern const int RUSAGE_THREAD;

#define RUSAGE_SELF 0

#define RUSAGE_BOTH     RUSAGE_BOTH
#define RUSAGE_CHILDREN RUSAGE_CHILDREN
#define RUSAGE_THREAD   RUSAGE_THREAD

#define __tmpcosmo_RUSAGE_BOTH     -1832733122
#define __tmpcosmo_RUSAGE_CHILDREN 1527420554
#define __tmpcosmo_RUSAGE_THREAD   1172956153

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_RUSAGE_H_ */
