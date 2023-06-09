#ifndef COSMOPOLITAN_LIBC_SYSV_CONSTS_WAITID_H_
#define COSMOPOLITAN_LIBC_SYSV_CONSTS_WAITID_H_
#if !(__ASSEMBLER__ + __LINKER__ + 0)
COSMOPOLITAN_C_START_

extern const int WEXITED;
extern const int WSTOPPED;
extern const int WNOWAIT;

#define WEXITED  WEXITED
#define WSTOPPED WSTOPPED
#define WNOWAIT  WNOWAIT

#define __tmpcosmo_WEXITED  1050022740
#define __tmpcosmo_WSTOPPED 1487795159
#define __tmpcosmo_WNOWAIT  -1738934425

COSMOPOLITAN_C_END_
#endif /* !(__ASSEMBLER__ + __LINKER__ + 0) */
#endif /* COSMOPOLITAN_LIBC_SYSV_CONSTS_WAITID_H_ */
