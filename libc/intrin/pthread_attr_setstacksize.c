/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2022 Justine Alexandra Roberts Tunney                              │
│                                                                              │
│ Permission to use, copy, modify, and/or distribute this software for         │
│ any purpose with or without fee is hereby granted, provided that the         │
│ above copyright notice and this permission notice appear in all copies.      │
│                                                                              │
│ THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL                │
│ WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED                │
│ WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE             │
│ AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         │
│ DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR        │
│ PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER               │
│ TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR             │
│ PERFORMANCE OF THIS SOFTWARE.                                                │
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/errno.h"
#include "libc/intrin/pthread.h"

/**
 * Sets size of thread stack.
 *
 * Your stack must have at least `PTHREAD_STACK_MIN` bytes, which
 * Cosmpolitan Libc defines as `GetStackSize()`. It's a link-time
 * constant used by Actually Portable Executable that's 128 kb by
 * default. See libc/runtime/stack.h for docs on your stack limit
 * since the APE ELF phdrs are the one true source of truth here.
 *
 * Cosmpolitan Libc runtime magic (e.g. ftrace) and memory safety
 * (e.g. kprintf) assumes that stack sizes are two-powers and are
 * aligned to that two-power. Conformance isn't required since we
 * say caveat emptor to those who don't maintain these invariants
 *
 * Unlike pthread_attr_setstack() this function should be used if
 * you want the Cosmopolitan Libc runtime to allocate a stack for
 * you. Since the runtime uses mmap(MAP_STACK) to do that, you'll
 * need to choose a multiple of FRAMESIZE, due to Windows.
 *
 * If this function isn't called it'll default to GetStackSize().
 *
 * @param x contains stack size in bytes
 * @return 0 on success, or errno on error
 * @raise EINVAL if `x` is less than `PTHREAD_STACK_MIN`
 */
int pthread_attr_setstacksize(pthread_attr_t *a, size_t x) {
  if (x < PTHREAD_STACK_MIN) return EINVAL;
  if (x & (FRAMESIZE - 1)) return EINVAL;
  if (x < FRAMESIZE) return EINVAL;
  a->stacksize = x;
  return 0;
}