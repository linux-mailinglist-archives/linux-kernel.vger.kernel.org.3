Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C504C9E84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiCBHnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCBHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:43:51 -0500
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [60.248.187.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB175F8F1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 23:43:04 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 2227gofM061830;
        Wed, 2 Mar 2022 15:42:50 +0800 (+08)
        (envelope-from alankao@andestech.com)
Received: from atcsi01.andestech.com (10.0.15.167) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 2 Mar 2022
 15:42:46 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        "Greentime Hu" <green.hu@gmail.com>
CC:     Alan Kao <alankao@andestech.com>
Subject: [PATCH] nds32: Remove the architecture
Date:   Wed, 2 Mar 2022 15:42:45 +0800
Message-ID: <20220302074245.257153-1-alankao@andestech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 2227gofM061830
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous discussion is here:
https://www.spinics.net/lists/linux-mm/msg286280.html

Signed-off-by: Alan Kao <alankao@andestech.com>
---
 .../andestech,ativic32.txt                    |   19 -
 .../bindings/nds32/andestech-boards           |   40 -
 .../devicetree/bindings/nds32/atl2c.txt       |   28 -
 .../devicetree/bindings/nds32/cpus.txt        |   38 -
 .../devicetree/bindings/perf/nds32v3-pmu.txt  |   17 -
 .../timer/andestech,atcpit100-timer.txt       |   33 -
 .../features/core/cBPF-JIT/arch-support.txt   |    1 -
 .../features/core/eBPF-JIT/arch-support.txt   |    1 -
 .../core/generic-idle-thread/arch-support.txt |    1 -
 .../core/jump-labels/arch-support.txt         |    1 -
 .../core/thread-info-in-task/arch-support.txt |    1 -
 .../features/core/tracehook/arch-support.txt  |    1 -
 .../features/debug/KASAN/arch-support.txt     |    1 -
 .../debug/debug-vm-pgtable/arch-support.txt   |    1 -
 .../debug/gcov-profile-all/arch-support.txt   |    1 -
 .../features/debug/kcov/arch-support.txt      |    1 -
 .../features/debug/kgdb/arch-support.txt      |    1 -
 .../features/debug/kmemleak/arch-support.txt  |    1 -
 .../debug/kprobes-on-ftrace/arch-support.txt  |    1 -
 .../features/debug/kprobes/arch-support.txt   |    1 -
 .../debug/kretprobes/arch-support.txt         |    1 -
 .../features/debug/optprobes/arch-support.txt |    1 -
 .../debug/stackprotector/arch-support.txt     |    1 -
 .../features/debug/uprobes/arch-support.txt   |    1 -
 .../debug/user-ret-profiler/arch-support.txt  |    1 -
 .../io/dma-contiguous/arch-support.txt        |    1 -
 .../locking/cmpxchg-local/arch-support.txt    |    1 -
 .../features/locking/lockdep/arch-support.txt |    1 -
 .../locking/queued-rwlocks/arch-support.txt   |    1 -
 .../locking/queued-spinlocks/arch-support.txt |    1 -
 .../perf/kprobes-event/arch-support.txt       |    1 -
 .../features/perf/perf-regs/arch-support.txt  |    1 -
 .../perf/perf-stackdump/arch-support.txt      |    1 -
 .../membarrier-sync-core/arch-support.txt     |    1 -
 .../sched/numa-balancing/arch-support.txt     |    1 -
 .../seccomp/seccomp-filter/arch-support.txt   |    1 -
 .../time/arch-tick-broadcast/arch-support.txt |    1 -
 .../time/clockevents/arch-support.txt         |    1 -
 .../time/context-tracking/arch-support.txt    |    1 -
 .../time/irq-time-acct/arch-support.txt       |    1 -
 .../time/virt-cpuacct/arch-support.txt        |    1 -
 .../features/vm/ELF-ASLR/arch-support.txt     |    1 -
 .../features/vm/PG_uncached/arch-support.txt  |    1 -
 .../features/vm/THP/arch-support.txt          |    1 -
 .../features/vm/TLB/arch-support.txt          |    1 -
 .../features/vm/huge-vmap/arch-support.txt    |    1 -
 .../features/vm/ioremap_prot/arch-support.txt |    1 -
 .../features/vm/pte_special/arch-support.txt  |    1 -
 MAINTAINERS                                   |   12 -
 arch/nds32/Kbuild                             |    4 -
 arch/nds32/Kconfig                            |  102 --
 arch/nds32/Kconfig.cpu                        |  218 ---
 arch/nds32/Kconfig.debug                      |    2 -
 arch/nds32/Makefile                           |   63 -
 arch/nds32/boot/.gitignore                    |    2 -
 arch/nds32/boot/Makefile                      |   16 -
 arch/nds32/boot/dts/Makefile                  |    2 -
 arch/nds32/boot/dts/ae3xx.dts                 |   90 -
 arch/nds32/configs/defconfig                  |  104 --
 arch/nds32/include/asm/Kbuild                 |    8 -
 arch/nds32/include/asm/assembler.h            |   39 -
 arch/nds32/include/asm/barrier.h              |   15 -
 arch/nds32/include/asm/bitfield.h             |  985 -----------
 arch/nds32/include/asm/cache.h                |   12 -
 arch/nds32/include/asm/cache_info.h           |   13 -
 arch/nds32/include/asm/cacheflush.h           |   53 -
 arch/nds32/include/asm/current.h              |   12 -
 arch/nds32/include/asm/delay.h                |   39 -
 arch/nds32/include/asm/elf.h                  |  180 --
 arch/nds32/include/asm/fixmap.h               |   29 -
 arch/nds32/include/asm/fpu.h                  |  126 --
 arch/nds32/include/asm/fpuemu.h               |   44 -
 arch/nds32/include/asm/ftrace.h               |   46 -
 arch/nds32/include/asm/futex.h                |  101 --
 arch/nds32/include/asm/highmem.h              |   65 -
 arch/nds32/include/asm/io.h                   |   84 -
 arch/nds32/include/asm/irqflags.h             |   41 -
 arch/nds32/include/asm/l2_cache.h             |  137 --
 arch/nds32/include/asm/linkage.h              |   11 -
 arch/nds32/include/asm/memory.h               |   91 -
 arch/nds32/include/asm/mmu.h                  |   12 -
 arch/nds32/include/asm/mmu_context.h          |   62 -
 arch/nds32/include/asm/nds32.h                |   82 -
 arch/nds32/include/asm/nds32_fpu_inst.h       |  109 --
 arch/nds32/include/asm/page.h                 |   64 -
 arch/nds32/include/asm/perf_event.h           |   16 -
 arch/nds32/include/asm/pgalloc.h              |   62 -
 arch/nds32/include/asm/pgtable.h              |  377 -----
 arch/nds32/include/asm/pmu.h                  |  386 -----
 arch/nds32/include/asm/proc-fns.h             |   44 -
 arch/nds32/include/asm/processor.h            |  104 --
 arch/nds32/include/asm/ptrace.h               |   77 -
 arch/nds32/include/asm/sfp-machine.h          |  158 --
 arch/nds32/include/asm/shmparam.h             |   19 -
 arch/nds32/include/asm/stacktrace.h           |   39 -
 arch/nds32/include/asm/string.h               |   17 -
 arch/nds32/include/asm/suspend.h              |   11 -
 arch/nds32/include/asm/swab.h                 |   35 -
 arch/nds32/include/asm/syscall.h              |  142 --
 arch/nds32/include/asm/syscalls.h             |   14 -
 arch/nds32/include/asm/thread_info.h          |   76 -
 arch/nds32/include/asm/tlb.h                  |   11 -
 arch/nds32/include/asm/tlbflush.h             |   46 -
 arch/nds32/include/asm/uaccess.h              |  286 ----
 arch/nds32/include/asm/unistd.h               |    6 -
 arch/nds32/include/asm/vdso.h                 |   24 -
 arch/nds32/include/asm/vdso_datapage.h        |   37 -
 arch/nds32/include/asm/vdso_timer_info.h      |   14 -
 arch/nds32/include/asm/vermagic.h             |    9 -
 arch/nds32/include/asm/vmalloc.h              |    4 -
 arch/nds32/include/uapi/asm/Kbuild            |    2 -
 arch/nds32/include/uapi/asm/auxvec.h          |   19 -
 arch/nds32/include/uapi/asm/byteorder.h       |   13 -
 arch/nds32/include/uapi/asm/cachectl.h        |   14 -
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h  |   16 -
 arch/nds32/include/uapi/asm/param.h           |   11 -
 arch/nds32/include/uapi/asm/ptrace.h          |   25 -
 arch/nds32/include/uapi/asm/sigcontext.h      |   84 -
 arch/nds32/include/uapi/asm/unistd.h          |   16 -
 arch/nds32/kernel/.gitignore                  |    2 -
 arch/nds32/kernel/Makefile                    |   33 -
 arch/nds32/kernel/asm-offsets.c               |   28 -
 arch/nds32/kernel/atl2c.c                     |   65 -
 arch/nds32/kernel/cacheinfo.c                 |   49 -
 arch/nds32/kernel/devtree.c                   |   19 -
 arch/nds32/kernel/dma.c                       |   82 -
 arch/nds32/kernel/ex-entry.S                  |  177 --
 arch/nds32/kernel/ex-exit.S                   |  193 ---
 arch/nds32/kernel/ex-scall.S                  |  100 --
 arch/nds32/kernel/fpu.c                       |  266 ---
 arch/nds32/kernel/ftrace.c                    |  278 ---
 arch/nds32/kernel/head.S                      |  197 ---
 arch/nds32/kernel/irq.c                       |    9 -
 arch/nds32/kernel/module.c                    |  278 ---
 arch/nds32/kernel/nds32_ksyms.c               |   25 -
 arch/nds32/kernel/perf_event_cpu.c            | 1500 -----------------
 arch/nds32/kernel/pm.c                        |   80 -
 arch/nds32/kernel/process.c                   |  257 ---
 arch/nds32/kernel/ptrace.c                    |  118 --
 arch/nds32/kernel/setup.c                     |  369 ----
 arch/nds32/kernel/signal.c                    |  384 -----
 arch/nds32/kernel/sleep.S                     |  131 --
 arch/nds32/kernel/stacktrace.c                |   53 -
 arch/nds32/kernel/sys_nds32.c                 |   84 -
 arch/nds32/kernel/syscall_table.c             |   17 -
 arch/nds32/kernel/time.c                      |   11 -
 arch/nds32/kernel/traps.c                     |  354 ----
 arch/nds32/kernel/vdso.c                      |  231 ---
 arch/nds32/kernel/vdso/.gitignore             |    2 -
 arch/nds32/kernel/vdso/Makefile               |   79 -
 arch/nds32/kernel/vdso/datapage.S             |   21 -
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh    |   15 -
 arch/nds32/kernel/vdso/gettimeofday.c         |  269 ---
 arch/nds32/kernel/vdso/note.S                 |   11 -
 arch/nds32/kernel/vdso/sigreturn.S            |   19 -
 arch/nds32/kernel/vdso/vdso.S                 |   18 -
 arch/nds32/kernel/vdso/vdso.lds.S             |   75 -
 arch/nds32/kernel/vmlinux.lds.S               |   70 -
 arch/nds32/lib/Makefile                       |    4 -
 arch/nds32/lib/clear_user.S                   |   42 -
 arch/nds32/lib/copy_from_user.S               |   45 -
 arch/nds32/lib/copy_page.S                    |   40 -
 arch/nds32/lib/copy_template.S                |   69 -
 arch/nds32/lib/copy_to_user.S                 |   45 -
 arch/nds32/lib/memcpy.S                       |   30 -
 arch/nds32/lib/memmove.S                      |   70 -
 arch/nds32/lib/memset.S                       |   33 -
 arch/nds32/lib/memzero.S                      |   18 -
 arch/nds32/math-emu/Makefile                  |   10 -
 arch/nds32/math-emu/faddd.c                   |   24 -
 arch/nds32/math-emu/fadds.c                   |   24 -
 arch/nds32/math-emu/fcmpd.c                   |   24 -
 arch/nds32/math-emu/fcmps.c                   |   24 -
 arch/nds32/math-emu/fd2s.c                    |   22 -
 arch/nds32/math-emu/fd2si.c                   |   30 -
 arch/nds32/math-emu/fd2siz.c                  |   30 -
 arch/nds32/math-emu/fd2ui.c                   |   30 -
 arch/nds32/math-emu/fd2uiz.c                  |   30 -
 arch/nds32/math-emu/fdivd.c                   |   27 -
 arch/nds32/math-emu/fdivs.c                   |   26 -
 arch/nds32/math-emu/fmuld.c                   |   23 -
 arch/nds32/math-emu/fmuls.c                   |   23 -
 arch/nds32/math-emu/fnegd.c                   |   21 -
 arch/nds32/math-emu/fnegs.c                   |   21 -
 arch/nds32/math-emu/fpuemu.c                  |  406 -----
 arch/nds32/math-emu/fs2d.c                    |   23 -
 arch/nds32/math-emu/fs2si.c                   |   29 -
 arch/nds32/math-emu/fs2siz.c                  |   29 -
 arch/nds32/math-emu/fs2ui.c                   |   29 -
 arch/nds32/math-emu/fs2uiz.c                  |   30 -
 arch/nds32/math-emu/fsi2d.c                   |   22 -
 arch/nds32/math-emu/fsi2s.c                   |   22 -
 arch/nds32/math-emu/fsqrtd.c                  |   21 -
 arch/nds32/math-emu/fsqrts.c                  |   21 -
 arch/nds32/math-emu/fsubd.c                   |   27 -
 arch/nds32/math-emu/fsubs.c                   |   27 -
 arch/nds32/math-emu/fui2d.c                   |   22 -
 arch/nds32/math-emu/fui2s.c                   |   22 -
 arch/nds32/mm/Makefile                        |   10 -
 arch/nds32/mm/alignment.c                     |  578 -------
 arch/nds32/mm/cacheflush.c                    |  338 ----
 arch/nds32/mm/extable.c                       |   16 -
 arch/nds32/mm/fault.c                         |  396 -----
 arch/nds32/mm/init.c                          |  263 ---
 arch/nds32/mm/mm-nds32.c                      |   96 --
 arch/nds32/mm/mmap.c                          |   73 -
 arch/nds32/mm/proc.c                          |  536 ------
 arch/nds32/mm/tlb.c                           |   50 -
 drivers/clocksource/Kconfig                   |    9 -
 drivers/clocksource/timer-atcpit100.c         |  266 ---
 drivers/irqchip/Makefile                      |    1 -
 drivers/irqchip/irq-ativic32.c                |  156 --
 drivers/net/ethernet/faraday/Kconfig          |   12 +-
 drivers/video/console/Kconfig                 |    2 +-
 scripts/recordmcount.pl                       |    3 -
 tools/include/asm/barrier.h                   |    2 -
 tools/perf/arch/nds32/Build                   |    1 -
 tools/perf/arch/nds32/util/Build              |    1 -
 tools/perf/arch/nds32/util/header.c           |   29 -
 tools/testing/selftests/vDSO/vdso_config.h    |    4 -
 220 files changed, 6 insertions(+), 15826 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
 delete mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards
 delete mode 100644 Documentation/devicetree/bindings/nds32/atl2c.txt
 delete mode 100644 Documentation/devicetree/bindings/nds32/cpus.txt
 delete mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 delete mode 100644 arch/nds32/Kbuild
 delete mode 100644 arch/nds32/Kconfig
 delete mode 100644 arch/nds32/Kconfig.cpu
 delete mode 100644 arch/nds32/Kconfig.debug
 delete mode 100644 arch/nds32/Makefile
 delete mode 100644 arch/nds32/boot/.gitignore
 delete mode 100644 arch/nds32/boot/Makefile
 delete mode 100644 arch/nds32/boot/dts/Makefile
 delete mode 100644 arch/nds32/boot/dts/ae3xx.dts
 delete mode 100644 arch/nds32/configs/defconfig
 delete mode 100644 arch/nds32/include/asm/Kbuild
 delete mode 100644 arch/nds32/include/asm/assembler.h
 delete mode 100644 arch/nds32/include/asm/barrier.h
 delete mode 100644 arch/nds32/include/asm/bitfield.h
 delete mode 100644 arch/nds32/include/asm/cache.h
 delete mode 100644 arch/nds32/include/asm/cache_info.h
 delete mode 100644 arch/nds32/include/asm/cacheflush.h
 delete mode 100644 arch/nds32/include/asm/current.h
 delete mode 100644 arch/nds32/include/asm/delay.h
 delete mode 100644 arch/nds32/include/asm/elf.h
 delete mode 100644 arch/nds32/include/asm/fixmap.h
 delete mode 100644 arch/nds32/include/asm/fpu.h
 delete mode 100644 arch/nds32/include/asm/fpuemu.h
 delete mode 100644 arch/nds32/include/asm/ftrace.h
 delete mode 100644 arch/nds32/include/asm/futex.h
 delete mode 100644 arch/nds32/include/asm/highmem.h
 delete mode 100644 arch/nds32/include/asm/io.h
 delete mode 100644 arch/nds32/include/asm/irqflags.h
 delete mode 100644 arch/nds32/include/asm/l2_cache.h
 delete mode 100644 arch/nds32/include/asm/linkage.h
 delete mode 100644 arch/nds32/include/asm/memory.h
 delete mode 100644 arch/nds32/include/asm/mmu.h
 delete mode 100644 arch/nds32/include/asm/mmu_context.h
 delete mode 100644 arch/nds32/include/asm/nds32.h
 delete mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
 delete mode 100644 arch/nds32/include/asm/page.h
 delete mode 100644 arch/nds32/include/asm/perf_event.h
 delete mode 100644 arch/nds32/include/asm/pgalloc.h
 delete mode 100644 arch/nds32/include/asm/pgtable.h
 delete mode 100644 arch/nds32/include/asm/pmu.h
 delete mode 100644 arch/nds32/include/asm/proc-fns.h
 delete mode 100644 arch/nds32/include/asm/processor.h
 delete mode 100644 arch/nds32/include/asm/ptrace.h
 delete mode 100644 arch/nds32/include/asm/sfp-machine.h
 delete mode 100644 arch/nds32/include/asm/shmparam.h
 delete mode 100644 arch/nds32/include/asm/stacktrace.h
 delete mode 100644 arch/nds32/include/asm/string.h
 delete mode 100644 arch/nds32/include/asm/suspend.h
 delete mode 100644 arch/nds32/include/asm/swab.h
 delete mode 100644 arch/nds32/include/asm/syscall.h
 delete mode 100644 arch/nds32/include/asm/syscalls.h
 delete mode 100644 arch/nds32/include/asm/thread_info.h
 delete mode 100644 arch/nds32/include/asm/tlb.h
 delete mode 100644 arch/nds32/include/asm/tlbflush.h
 delete mode 100644 arch/nds32/include/asm/uaccess.h
 delete mode 100644 arch/nds32/include/asm/unistd.h
 delete mode 100644 arch/nds32/include/asm/vdso.h
 delete mode 100644 arch/nds32/include/asm/vdso_datapage.h
 delete mode 100644 arch/nds32/include/asm/vdso_timer_info.h
 delete mode 100644 arch/nds32/include/asm/vermagic.h
 delete mode 100644 arch/nds32/include/asm/vmalloc.h
 delete mode 100644 arch/nds32/include/uapi/asm/Kbuild
 delete mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 delete mode 100644 arch/nds32/include/uapi/asm/byteorder.h
 delete mode 100644 arch/nds32/include/uapi/asm/cachectl.h
 delete mode 100644 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
 delete mode 100644 arch/nds32/include/uapi/asm/param.h
 delete mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 delete mode 100644 arch/nds32/include/uapi/asm/sigcontext.h
 delete mode 100644 arch/nds32/include/uapi/asm/unistd.h
 delete mode 100644 arch/nds32/kernel/.gitignore
 delete mode 100644 arch/nds32/kernel/Makefile
 delete mode 100644 arch/nds32/kernel/asm-offsets.c
 delete mode 100644 arch/nds32/kernel/atl2c.c
 delete mode 100644 arch/nds32/kernel/cacheinfo.c
 delete mode 100644 arch/nds32/kernel/devtree.c
 delete mode 100644 arch/nds32/kernel/dma.c
 delete mode 100644 arch/nds32/kernel/ex-entry.S
 delete mode 100644 arch/nds32/kernel/ex-exit.S
 delete mode 100644 arch/nds32/kernel/ex-scall.S
 delete mode 100644 arch/nds32/kernel/fpu.c
 delete mode 100644 arch/nds32/kernel/ftrace.c
 delete mode 100644 arch/nds32/kernel/head.S
 delete mode 100644 arch/nds32/kernel/irq.c
 delete mode 100644 arch/nds32/kernel/module.c
 delete mode 100644 arch/nds32/kernel/nds32_ksyms.c
 delete mode 100644 arch/nds32/kernel/perf_event_cpu.c
 delete mode 100644 arch/nds32/kernel/pm.c
 delete mode 100644 arch/nds32/kernel/process.c
 delete mode 100644 arch/nds32/kernel/ptrace.c
 delete mode 100644 arch/nds32/kernel/setup.c
 delete mode 100644 arch/nds32/kernel/signal.c
 delete mode 100644 arch/nds32/kernel/sleep.S
 delete mode 100644 arch/nds32/kernel/stacktrace.c
 delete mode 100644 arch/nds32/kernel/sys_nds32.c
 delete mode 100644 arch/nds32/kernel/syscall_table.c
 delete mode 100644 arch/nds32/kernel/time.c
 delete mode 100644 arch/nds32/kernel/traps.c
 delete mode 100644 arch/nds32/kernel/vdso.c
 delete mode 100644 arch/nds32/kernel/vdso/.gitignore
 delete mode 100644 arch/nds32/kernel/vdso/Makefile
 delete mode 100644 arch/nds32/kernel/vdso/datapage.S
 delete mode 100755 arch/nds32/kernel/vdso/gen_vdso_offsets.sh
 delete mode 100644 arch/nds32/kernel/vdso/gettimeofday.c
 delete mode 100644 arch/nds32/kernel/vdso/note.S
 delete mode 100644 arch/nds32/kernel/vdso/sigreturn.S
 delete mode 100644 arch/nds32/kernel/vdso/vdso.S
 delete mode 100644 arch/nds32/kernel/vdso/vdso.lds.S
 delete mode 100644 arch/nds32/kernel/vmlinux.lds.S
 delete mode 100644 arch/nds32/lib/Makefile
 delete mode 100644 arch/nds32/lib/clear_user.S
 delete mode 100644 arch/nds32/lib/copy_from_user.S
 delete mode 100644 arch/nds32/lib/copy_page.S
 delete mode 100644 arch/nds32/lib/copy_template.S
 delete mode 100644 arch/nds32/lib/copy_to_user.S
 delete mode 100644 arch/nds32/lib/memcpy.S
 delete mode 100644 arch/nds32/lib/memmove.S
 delete mode 100644 arch/nds32/lib/memset.S
 delete mode 100644 arch/nds32/lib/memzero.S
 delete mode 100644 arch/nds32/math-emu/Makefile
 delete mode 100644 arch/nds32/math-emu/faddd.c
 delete mode 100644 arch/nds32/math-emu/fadds.c
 delete mode 100644 arch/nds32/math-emu/fcmpd.c
 delete mode 100644 arch/nds32/math-emu/fcmps.c
 delete mode 100644 arch/nds32/math-emu/fd2s.c
 delete mode 100644 arch/nds32/math-emu/fd2si.c
 delete mode 100644 arch/nds32/math-emu/fd2siz.c
 delete mode 100644 arch/nds32/math-emu/fd2ui.c
 delete mode 100644 arch/nds32/math-emu/fd2uiz.c
 delete mode 100644 arch/nds32/math-emu/fdivd.c
 delete mode 100644 arch/nds32/math-emu/fdivs.c
 delete mode 100644 arch/nds32/math-emu/fmuld.c
 delete mode 100644 arch/nds32/math-emu/fmuls.c
 delete mode 100644 arch/nds32/math-emu/fnegd.c
 delete mode 100644 arch/nds32/math-emu/fnegs.c
 delete mode 100644 arch/nds32/math-emu/fpuemu.c
 delete mode 100644 arch/nds32/math-emu/fs2d.c
 delete mode 100644 arch/nds32/math-emu/fs2si.c
 delete mode 100644 arch/nds32/math-emu/fs2siz.c
 delete mode 100644 arch/nds32/math-emu/fs2ui.c
 delete mode 100644 arch/nds32/math-emu/fs2uiz.c
 delete mode 100644 arch/nds32/math-emu/fsi2d.c
 delete mode 100644 arch/nds32/math-emu/fsi2s.c
 delete mode 100644 arch/nds32/math-emu/fsqrtd.c
 delete mode 100644 arch/nds32/math-emu/fsqrts.c
 delete mode 100644 arch/nds32/math-emu/fsubd.c
 delete mode 100644 arch/nds32/math-emu/fsubs.c
 delete mode 100644 arch/nds32/math-emu/fui2d.c
 delete mode 100644 arch/nds32/math-emu/fui2s.c
 delete mode 100644 arch/nds32/mm/Makefile
 delete mode 100644 arch/nds32/mm/alignment.c
 delete mode 100644 arch/nds32/mm/cacheflush.c
 delete mode 100644 arch/nds32/mm/extable.c
 delete mode 100644 arch/nds32/mm/fault.c
 delete mode 100644 arch/nds32/mm/init.c
 delete mode 100644 arch/nds32/mm/mm-nds32.c
 delete mode 100644 arch/nds32/mm/mmap.c
 delete mode 100644 arch/nds32/mm/proc.c
 delete mode 100644 arch/nds32/mm/tlb.c
 delete mode 100644 drivers/clocksource/timer-atcpit100.c
 delete mode 100644 drivers/irqchip/irq-ativic32.c
 delete mode 100644 tools/perf/arch/nds32/Build
 delete mode 100644 tools/perf/arch/nds32/util/Build
 delete mode 100644 tools/perf/arch/nds32/util/header.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
deleted file mode 100644
index f4b4193d830e..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Andestech Internal Vector Interrupt Controller
-
-The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
-suitable for a simpler SoC platform not requiring a more sophisticated and
-bigger External Vector Interrupt Controller.
-
-
-Main node required properties:
-
-- compatible : should at least contain  "andestech,ativic32".
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells: 1 cells and refer to interrupt-controller/interrupts
-
-Examples:
-	intc: interrupt-controller {
-		compatible = "andestech,ativic32";
-		#interrupt-cells = <1>;
-		interrupt-controller;
-	};
diff --git a/Documentation/devicetree/bindings/nds32/andestech-boards b/Documentation/devicetree/bindings/nds32/andestech-boards
deleted file mode 100644
index f5d75693e3c7..000000000000
--- a/Documentation/devicetree/bindings/nds32/andestech-boards
+++ /dev/null
@@ -1,40 +0,0 @@
-Andestech(nds32) AE3XX Platform
------------------------------------------------------------------------------
-The AE3XX prototype demonstrates the AE3XX example platform on the FPGA. It
-is composed of one Andestech(nds32) processor and AE3XX.
-
-Required properties (in root node):
-- compatible = "andestech,ae3xx";
-
-Example:
-/dts-v1/;
-/ {
-	compatible = "andestech,ae3xx";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&intc>;
-};
-
-Andestech(nds32) AG101P Platform
------------------------------------------------------------------------------
-AG101P is a generic SoC Platform IP that works with any of Andestech(nds32)
-processors to provide a cost-effective and high performance solution for
-majority of embedded systems in variety of application domains. Users may
-simply attach their IP on one of the system buses together with certain glue
-logics to complete a SoC solution for a specific application. With
-comprehensive simulation and design environments, users may evaluate the
-system performance of their applications and track bugs of their designs
-efficiently. The optional hardware development platform further provides real
-system environment for early prototyping and software/hardware co-development.
-
-Required properties (in root node):
-	compatible = "andestech,ag101p";
-
-Example:
-/dts-v1/;
-/ {
-	compatible = "andestech,ag101p";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&intc>;
-};
diff --git a/Documentation/devicetree/bindings/nds32/atl2c.txt b/Documentation/devicetree/bindings/nds32/atl2c.txt
deleted file mode 100644
index da8ab8e7ae9b..000000000000
--- a/Documentation/devicetree/bindings/nds32/atl2c.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Andestech L2 cache Controller
-
-The level-2 cache controller plays an important role in reducing memory latency
-for high performance systems, such as thoese designs with AndesCore processors.
-Level-2 cache controller in general enhances overall system performance
-signigicantly and the system power consumption might be reduced as well by
-reducing DRAM accesses.
-
-This binding specifies what properties must be available in the device tree
-representation of an Andestech L2 cache controller.
-
-Required properties:
-	- compatible:
-		Usage: required
-		Value type: <string>
-		Definition: "andestech,atl2c"
-	- reg : Physical base address and size of cache controller's memory mapped
-	- cache-unified : Specifies the cache is a unified cache.
-	- cache-level : Should be set to 2 for a level 2 cache.
-
-* Example
-
-	cache-controller@e0500000 {
-		compatible = "andestech,atl2c";
-		reg = <0xe0500000 0x1000>;
-		cache-unified;
-		cache-level = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/nds32/cpus.txt b/Documentation/devicetree/bindings/nds32/cpus.txt
deleted file mode 100644
index 6f9e311b6589..000000000000
--- a/Documentation/devicetree/bindings/nds32/cpus.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Andestech Processor Binding
-
-This binding specifies what properties must be available in the device tree
-representation of a Andestech Processor Core, which is the root node in the
-tree.
-
-Required properties:
-
-	- compatible:
-		Usage: required
-		Value type: <string>
-		Definition: Should be "andestech,<core_name>", "andestech,nds32v3" as fallback.
-		Must contain "andestech,nds32v3" as the most generic value, in addition to
-		one of the following identifiers for a particular CPU core:
-		"andestech,n13"
-		"andestech,n15"
-		"andestech,d15"
-		"andestech,n10"
-		"andestech,d10"
-	- device_type
-		Usage: required
-		Value type: <string>
-		Definition: must be "cpu"
-	- reg: Contains CPU index.
-	- clock-frequency: Contains the clock frequency for CPU, in Hz.
-
-* Examples
-
-/ {
-	cpus {
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "andestech,n13", "andestech,nds32v3";
-			reg = <0x0>;
-			clock-frequency = <60000000>
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
deleted file mode 100644
index 1bd15785b4ae..000000000000
--- a/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* NDS32 Performance Monitor Units
-
-NDS32 core have a PMU for counting cpu and cache events like cache misses.
-The NDS32 PMU representation in the device tree should be done as under:
-
-Required properties:
-
-- compatible :
-	"andestech,nds32v3-pmu"
-
-- interrupts : The interrupt number for NDS32 PMU is 13.
-
-Example:
-pmu{
-	compatible = "andestech,nds32v3-pmu";
-	interrupts = <13>;
-}
diff --git a/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt b/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
deleted file mode 100644
index 4c9ea5989e35..000000000000
--- a/Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Andestech ATCPIT100 timer
-------------------------------------------------------------------
-ATCPIT100 is a generic IP block from Andes Technology, embedded in
-Andestech AE3XX platforms and other designs.
-
-This timer is a set of compact multi-function timers, which can be
-used as pulse width modulators (PWM) as well as simple timers.
-
-It supports up to 4 PIT channels. Each PIT channel is a
-multi-function timer and provide the following usage scenarios:
-One 32-bit timer
-Two 16-bit timers
-Four 8-bit timers
-One 16-bit PWM
-One 16-bit timer and one 8-bit PWM
-Two 8-bit timer and one 8-bit PWM
-
-Required properties:
-- compatible	: Should be "andestech,atcpit100"
-- reg		: Address and length of the register set
-- interrupts	: Reference to the timer interrupt
-- clocks 	: a clock to provide the tick rate for "andestech,atcpit100"
-- clock-names 	: should be "PCLK" for the peripheral clock source.
-
-Examples:
-
-timer0: timer@f0400000 {
-	compatible = "andestech,atcpit100";
-	reg = <0xf0400000 0x1000>;
-	interrupts = <2>;
-	clocks = <&apb>;
-	clock-names = "PCLK";
-};
diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index e59b5215402d..77bd6974dd6d 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index dcbd8679f514..d5ab547b2be6 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 4efcba7b5239..ddb3762ca7f5 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 0c801d1bd2da..d5380ef68713 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index bc74d8beea72..0654ba3a42ff 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index af34308fce7f..8e95dc0c7b90 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index c244ac7eee26..407ca1d91242 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index fa83403b4aec..83eafe1a7f68 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index b39c1a5de3f3..49e0dda11227 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index 7e44013cc320..3d34b724ddae 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 2cb0576f9180..7aa073d908c5 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: |  ok  |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index e9ac415f8aec..5c784ff9768a 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 96156e8802a7..a1f6e98c6b1f 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index ee95ed61909a..e7e7015175e7 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 612cb97d47b8..838eb53a6fa5 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index d6ff141a6122..6358b00b1723 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index ad4de22a71ab..f6cdf781305f 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 8bd5548a4485..0b871e797d24 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 2a3fe812a5fa..a2feda7adff1 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index bece89586efa..9b407f26d45e 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 52bdda004f5c..090520b0e02d 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index a8cd163c8b7e..6d840b103537 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 8c85949752b3..de586be05d64 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 5f4e1b3841af..29d0c8b7b1c5 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 78f3fe080f0e..881a8a50e41e 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 5bf3b1854a1f..7639a796a8e1 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index d88659bb4fc1..df1a4c679a45 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 883d33b265d6..51b7afc937f1 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -40,7 +40,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 9affb7c2c500..d0e308135434 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index 26eec58ab819..05613c5ff560 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 8dcaab070c7b..b4c96ebab7e3 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 9a81cb03b1fd..3f6976052e2a 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
-    |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 4ed116c2ec39..bb1c1801553e 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index bc30c15557c7..3cea25b80c8c 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ..  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 050de43bbbb9..5163a60a1c1e 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 2949c99fbb2f..73ec761f1e27 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 6cde38458596..9066a90b38d9 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 7dbd6967b37e..f717ab792e5a 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index e1c3a4c4d107..6fa76a37f299 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index bc53905a0306..6e1792ee37fe 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 9a0c8783b84d..a6dcbe5f47b6 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 40b969f3a6bb..376477749c42 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -17,7 +17,6 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
-    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ba1e4af2cbc..41992140b155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1229,18 +1229,6 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
-ANDES ARCHITECTURE
-M:	Nick Hu <nickhu@andestech.com>
-M:	Greentime Hu <green.hu@gmail.com>
-M:	Vincent Chen <deanbo422@gmail.com>
-S:	Supported
-T:	git https://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
-F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
-F:	Documentation/devicetree/bindings/nds32/
-F:	arch/nds32/
-N:	nds32
-K:	nds32
-
 ANDROID CONFIG FRAGMENTS
 M:	Rob Herring <robh@kernel.org>
 S:	Supported
diff --git a/arch/nds32/Kbuild b/arch/nds32/Kbuild
deleted file mode 100644
index 4e39f7abdeb6..000000000000
--- a/arch/nds32/Kbuild
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-# for cleaning
-subdir- += boot
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
deleted file mode 100644
index 4d1421b18734..000000000000
--- a/arch/nds32/Kconfig
+++ /dev/null
@@ -1,102 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# For a description of the syntax of this configuration file,
-# see Documentation/kbuild/kconfig-language.rst.
-#
-
-config NDS32
-	def_bool y
-	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_DMA_PREP_COHERENT
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_WANT_FRAME_POINTERS if FTRACE
-	select CLKSRC_MMIO
-	select CLONE_BACKWARDS
-	select COMMON_CLK
-	select DMA_DIRECT_REMAP
-	select GENERIC_ATOMIC64
-	select GENERIC_CPU_DEVICES
-	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_SHOW
-	select GENERIC_IOREMAP
-	select GENERIC_LIB_ASHLDI3
-	select GENERIC_LIB_ASHRDI3
-	select GENERIC_LIB_CMPDI2
-	select GENERIC_LIB_LSHRDI3
-	select GENERIC_LIB_MULDI3
-	select GENERIC_LIB_UCMPDI2
-	select GENERIC_TIME_VSYSCALL
-	select HAVE_ARCH_TRACEHOOK
-	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_EXIT_THREAD
-	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_PERF_EVENTS
-	select IRQ_DOMAIN
-	select LOCKDEP_SUPPORT
-	select MODULES_USE_ELF_RELA
-	select OF
-	select OF_EARLY_FLATTREE
-	select NO_IOPORT_MAP
-	select RTC_LIB
-	select THREAD_INFO_IN_TASK
-	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_DYNAMIC_FTRACE
-	select SET_FS
-	select TRACE_IRQFLAGS_SUPPORT
-	help
-	  Andes(nds32) Linux support.
-
-config GENERIC_CALIBRATE_DELAY
-	def_bool y
-
-config GENERIC_CSUM
-	def_bool y
-
-config GENERIC_HWEIGHT
-	def_bool y
-
-config GENERIC_LOCKBREAK
-	def_bool y
-	depends on PREEMPTION
-
-config STACKTRACE_SUPPORT
-	def_bool y
-
-config FIX_EARLYCON_MEM
-	def_bool y
-
-config PGTABLE_LEVELS
-	default 2
-
-menu "System Type"
-source "arch/nds32/Kconfig.cpu"
-config NR_CPUS
-	int
-	default 1
-
-config MMU
-	def_bool y
-
-config NDS32_BUILTIN_DTB
-	string "Builtin DTB"
-	default ""
-	help
-	  User can use it to specify the dts of the SoC
-endmenu
-
-menu "Kernel Features"
-source "kernel/Kconfig.hz"
-endmenu
-
-menu "Power management options"
-config SYS_SUPPORTS_APM_EMULATION
-	bool
-
-config ARCH_SUSPEND_POSSIBLE
-	def_bool y
-
-source "kernel/power/Kconfig"
-endmenu
diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
deleted file mode 100644
index c10759952485..000000000000
--- a/arch/nds32/Kconfig.cpu
+++ /dev/null
@@ -1,218 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-comment "Processor Features"
-
-config CPU_BIG_ENDIAN
-	def_bool !CPU_LITTLE_ENDIAN
-
-config CPU_LITTLE_ENDIAN
-	bool "Little endian"
-	default y
-
-config FPU
-	bool "FPU support"
-	default n
-	help
-	  If FPU ISA is used in user space, this configuration shall be Y to
-          enable required support in kernel such as fpu context switch and
-          fpu exception handler.
-
-	  If no FPU ISA is used in user space, say N.
-
-config LAZY_FPU
-	bool "lazy FPU support"
-	depends on FPU
-	default y
-	help
-	  Say Y here to enable the lazy FPU scheme. The lazy FPU scheme can
-          enhance system performance by reducing the context switch
-	  frequency of the FPU register.
-
-	  For normal case, say Y.
-
-config SUPPORT_DENORMAL_ARITHMETIC
-	bool "Denormal arithmetic support"
-	depends on FPU
-	default n
-	help
-	  Say Y here to enable arithmetic of denormalized number. Enabling
-	  this feature can enhance the precision for tininess number.
-	  However, performance loss in float point calculations is
-	  possibly significant due to additional FPU exception.
-
-	  If the calculated tolerance for tininess number is not critical,
-	  say N to prevent performance loss.
-
-config HWZOL
-	bool "hardware zero overhead loop support"
-	depends on CPU_D10 || CPU_D15
-	default n
-	help
-	  A set of Zero-Overhead Loop mechanism is provided to reduce the
-	  instruction fetch and execution overhead of loop-control instructions.
-	  It will save 3 registers($LB, $LC, $LE) for context saving if say Y.
-	  You don't need to save these registers if you can make sure your user
-	  program doesn't use these registers.
-
-	  If unsure, say N.
-
-config CPU_CACHE_ALIASING
-	bool "Aliasing cache"
-	depends on CPU_N10 || CPU_D10 || CPU_N13 || CPU_V3
-	default y
-	help
-	  If this CPU is using VIPT data cache and its cache way size is larger
-	  than page size, say Y. If it is using PIPT data cache, say N.
-
-	  If unsure, say Y.
-
-choice
-	prompt "minimum CPU type"
-	default CPU_V3
-	help
-	  The data cache of N15/D15 is implemented as PIPT and it will not cause
-	  the cache aliasing issue. The rest cpus(N13, N10 and D10) are
-	  implemented as VIPT data cache. It may cause the cache aliasing issue
-	  if its cache way size is larger than page size. You can specify the
-	  CPU type directly or choose CPU_V3 if unsure.
-
-          A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
-          A kernel built for N15 is able to run on N15 or D15.
-          A kernel built for D10 is able to run on D10 or D15.
-          A kernel built for D15 is able to run on D15.
-          A kernel built for N13 is able to run on N15, N13 or D15.
-
-config CPU_N15
-	bool "AndesCore N15"
-config CPU_N13
-	bool "AndesCore N13"
-	select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
-config CPU_N10
-	bool "AndesCore N10"
-	select CPU_CACHE_ALIASING
-config CPU_D15
-	bool "AndesCore D15"
-config CPU_D10
-	bool "AndesCore D10"
-	select CPU_CACHE_ALIASING
-config CPU_V3
-	bool "AndesCore v3 compatible"
-	select CPU_CACHE_ALIASING
-endchoice
-choice
-	prompt "Paging -- page size "
-	default ANDES_PAGE_SIZE_4KB
-config  ANDES_PAGE_SIZE_4KB
-	bool "use 4KB page size"
-config  ANDES_PAGE_SIZE_8KB
-	bool "use 8KB page size"
-endchoice
-
-config CPU_ICACHE_DISABLE
-	bool "Disable I-Cache"
-	help
-	  Say Y here to disable the processor instruction cache. Unless
-	  you have a reason not to or are unsure, say N.
-
-config CPU_DCACHE_DISABLE
-	bool "Disable D-Cache"
-	help
-	  Say Y here to disable the processor data cache. Unless
-	  you have a reason not to or are unsure, say N.
-
-config CPU_DCACHE_WRITETHROUGH
-	bool "Force write through D-cache"
-	depends on !CPU_DCACHE_DISABLE
-	help
-	  Say Y here to use the data cache in writethrough mode. Unless you
-	  specifically require this or are unsure, say N.
-
-config WBNA
-	bool "WBNA"
-	default n
-	help
-	  Say Y here to enable write-back memory with no-write-allocation policy.
-
-config ALIGNMENT_TRAP
-	bool "Kernel support unaligned access handling by sw"
-	depends on PROC_FS
-	default n
-	help
-	  Andes processors cannot load/store information which is not
-	  naturally aligned on the bus, i.e., a 4 byte load must start at an
-	  address divisible by 4. On 32-bit Andes processors, these non-aligned
-	  load/store instructions will be emulated in software if you say Y
-	  here, which has a severe performance impact. With an IP-only
-	  configuration it is safe to say N, otherwise say Y.
-
-config HW_SUPPORT_UNALIGNMENT_ACCESS
-	bool "Kernel support unaligned access handling by hw"
-	depends on !ALIGNMENT_TRAP
-	default n
-	help
-	  Andes processors load/store world/half-word instructions can access
-	  unaligned memory locations without generating the Data Alignment
-	  Check exceptions. With an IP-only configuration it is safe to say N,
-	  otherwise say Y.
-
-config HIGHMEM
-	bool "High Memory Support"
-	depends on MMU && !CPU_CACHE_ALIASING
-	select KMAP_LOCAL
-	help
-	  The address space of Andes processors is only 4 Gigabytes large
-	  and it has to accommodate user address space, kernel address
-	  space as well as some memory mapped IO. That means that, if you
-	  have a large amount of physical memory and/or IO, not all of the
-	  memory can be "permanently mapped" by the kernel. The physical
-	  memory that is not permanently mapped is called "high memory".
-
-	  Depending on the selected kernel/user memory split, minimum
-	  vmalloc space and actual amount of RAM, you may not need this
-	  option which should result in a slightly faster kernel.
-
-	  If unsure, say N.
-
-config CACHE_L2
-	bool "Support L2 cache"
-        default y
-	help
-	  Say Y here to enable L2 cache if your SoC are integrated with L2CC.
-	  If unsure, say N.
-
-config HW_PRE
-	bool "Enable hardware prefetcher"
-	default y
-	help
-	  Say Y here to enable hardware prefetcher feature.
-	  Only when CPU_VER.REV >= 0x09 can support.
-
-menu "Memory configuration"
-
-choice
-	prompt "Memory split"
-	depends on MMU
-	default VMSPLIT_3G_OPT
-	help
-	  Select the desired split between kernel and user memory.
-
-	  If you are not absolutely sure what you are doing, leave this
-	  option alone!
-
-	config VMSPLIT_3G
-		bool "3G/1G user/kernel split"
-	config VMSPLIT_3G_OPT
-		bool "3G/1G user/kernel split (for full 1G low memory)"
-	config VMSPLIT_2G
-		bool "2G/2G user/kernel split"
-	config VMSPLIT_1G
-		bool "1G/3G user/kernel split"
-endchoice
-
-config PAGE_OFFSET
-	hex
-	default 0x40000000 if VMSPLIT_1G
-	default 0x80000000 if VMSPLIT_2G
-	default 0xB0000000 if VMSPLIT_3G_OPT
-	default 0xC0000000
-
-endmenu
diff --git a/arch/nds32/Kconfig.debug b/arch/nds32/Kconfig.debug
deleted file mode 100644
index 295942fe3fd5..000000000000
--- a/arch/nds32/Kconfig.debug
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# dummy file, do not delete
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
deleted file mode 100644
index b33d5d81b6ae..000000000000
--- a/arch/nds32/Makefile
+++ /dev/null
@@ -1,63 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-LDFLAGS_vmlinux	:= --no-undefined -X
-OBJCOPYFLAGS	:= -O binary -R .note -R .note.gnu.build-id -R .comment -S
-
-ifdef CONFIG_FUNCTION_TRACER
-arch-y += -malways-save-lp -mno-relax
-endif
-
-# Avoid generating FPU instructions
-arch-y  += -mno-ext-fpu-sp -mno-ext-fpu-dp -mfloat-abi=soft
-
-# Enable <nds32_intrinsic.h>
-KBUILD_CFLAGS	+= -isystem $(shell $(CC) -print-file-name=include)
-KBUILD_CFLAGS	+= $(call cc-option, -mno-sched-prolog-epilog)
-KBUILD_CFLAGS	+= -mcmodel=large
-
-KBUILD_CFLAGS	+=$(arch-y) $(tune-y)
-KBUILD_AFLAGS	+=$(arch-y) $(tune-y)
-
-#Default value
-head-y		 := arch/nds32/kernel/head.o
-textaddr-y	 := $(CONFIG_PAGE_OFFSET)+0xc000
-
-TEXTADDR := $(textaddr-y)
-
-export	TEXTADDR
-
-
-# If we have a machine-specific directory, then include it in the build.
-core-y				+= arch/nds32/kernel/ arch/nds32/mm/
-core-$(CONFIG_FPU)              += arch/nds32/math-emu/
-libs-y				+= arch/nds32/lib/
-
-ifdef CONFIG_CPU_LITTLE_ENDIAN
-KBUILD_CFLAGS   += $(call cc-option, -EL)
-KBUILD_AFLAGS   += $(call cc-option, -EL)
-KBUILD_LDFLAGS  += $(call cc-option, -EL)
-CHECKFLAGS      += -D__NDS32_EL__
-else
-KBUILD_CFLAGS   += $(call cc-option, -EB)
-KBUILD_AFLAGS   += $(call cc-option, -EB)
-KBUILD_LDFLAGS  += $(call cc-option, -EB)
-CHECKFLAGS      += -D__NDS32_EB__
-endif
-
-boot := arch/nds32/boot
-core-y += $(boot)/dts/
-
-Image: vmlinux
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-
-
-PHONY += vdso_install
-vdso_install:
-	$(Q)$(MAKE) $(build)=arch/nds32/kernel/vdso $@
-
-prepare: vdso_prepare
-vdso_prepare: prepare0
-	$(Q)$(MAKE) $(build)=arch/nds32/kernel/vdso include/generated/vdso-offsets.h
-
-define archhelp
-  echo  '  Image         - kernel image (arch/$(ARCH)/boot/Image)'
-endef
diff --git a/arch/nds32/boot/.gitignore b/arch/nds32/boot/.gitignore
deleted file mode 100644
index 9182a3a1ea0a..000000000000
--- a/arch/nds32/boot/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-/Image
diff --git a/arch/nds32/boot/Makefile b/arch/nds32/boot/Makefile
deleted file mode 100644
index c4cc0c2689f7..000000000000
--- a/arch/nds32/boot/Makefile
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-targets := Image Image.gz
-
-$(obj)/Image: vmlinux FORCE
-	$(call if_changed,objcopy)
-
-$(obj)/Image.gz: $(obj)/Image FORCE
-	$(call if_changed,gzip)
-
-install: $(obj)/Image
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
-	$(obj)/Image System.map "$(INSTALL_PATH)"
-
-zinstall: $(obj)/Image.gz
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
-	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
deleted file mode 100644
index 4fc69562eae8..000000000000
--- a/arch/nds32/boot/dts/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_OF) += $(addsuffix .dtb.o, $(CONFIG_NDS32_BUILTIN_DTB))
diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
deleted file mode 100644
index 16a9f54a805e..000000000000
--- a/arch/nds32/boot/dts/ae3xx.dts
+++ /dev/null
@@ -1,90 +0,0 @@
-/dts-v1/;
-/ {
-	compatible = "andestech,ae3xx";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&intc>;
-
-	chosen {
-		stdout-path = &serial0;
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000>;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "andestech,n13", "andestech,nds32v3";
-			reg = <0>;
-			clock-frequency = <60000000>;
-			next-level-cache = <&L2>;
-		};
-	};
-
-	intc: interrupt-controller {
-		compatible = "andestech,ativic32";
-		#interrupt-cells = <1>;
-		interrupt-controller;
-	};
-
-	clock: clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <30000000>;
-	};
-
-	apb {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		serial0: serial@f0300000 {
-			compatible = "andestech,uart16550", "ns16550a";
-			reg = <0xf0300000 0x1000>;
-			interrupts = <8>;
-			clock-frequency = <14745600>;
-			reg-shift = <2>;
-			reg-offset = <32>;
-			no-loopback-test = <1>;
-		};
-
-		timer0: timer@f0400000 {
-			compatible = "andestech,atcpit100";
-			reg = <0xf0400000 0x1000>;
-			interrupts = <2>;
-			clocks = <&clock>;
-			clock-names = "PCLK";
-		};
-	};
-
-	ahb {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		L2: cache-controller@e0500000 {
-			compatible = "andestech,atl2c";
-			reg = <0xe0500000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		mac0: ethernet@e0100000 {
-			compatible = "andestech,atmac100";
-			reg = <0xe0100000 0x1000>;
-			interrupts = <18>;
-		};
-	};
-
-	pmu {
-		compatible = "andestech,nds32v3-pmu";
-		interrupts= <13>;
-	};
-};
diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
deleted file mode 100644
index f9a89cf00aa6..000000000000
--- a/arch/nds32/configs/defconfig
+++ /dev/null
@@ -1,104 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_USER_NS=y
-CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_PROFILING=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_CACHE_L2 is not set
-CONFIG_PREEMPT=y
-# CONFIG_COMPACTION is not set
-CONFIG_HZ_100=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_BLK_DEV is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-CONFIG_FTMAC100=y
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-# CONFIG_SERIO is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_8250=y
-# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=3
-CONFIG_SERIAL_8250_RUNTIME_UARTS=3
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_HID_A4TECH is not set
-# CONFIG_HID_APPLE is not set
-# CONFIG_HID_BELKIN is not set
-# CONFIG_HID_CHERRY is not set
-# CONFIG_HID_CHICONY is not set
-# CONFIG_HID_CYPRESS is not set
-# CONFIG_HID_EZKEY is not set
-# CONFIG_HID_ITE is not set
-# CONFIG_HID_KENSINGTON is not set
-# CONFIG_HID_LOGITECH is not set
-# CONFIG_HID_MICROSOFT is not set
-# CONFIG_HID_MONTEREY is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_GENERIC_PHY=y
-CONFIG_EXT4_FS=y
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
-CONFIG_FS_ENCRYPTION=y
-CONFIG_FUSE_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CONFIGFS_FS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_NFS_V4_1=y
-CONFIG_NFS_USE_LEGACY_DNS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_DWARF4=y
-CONFIG_GDB_SCRIPTS=y
-CONFIG_READABLE_ASM=y
-CONFIG_HEADERS_INSTALL=y
-CONFIG_HEADERS_CHECK=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_PANIC_ON_OOPS=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_DEBUG_PREEMPT is not set
-CONFIG_STACKTRACE=y
-CONFIG_RCU_CPU_STALL_TIMEOUT=300
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
deleted file mode 100644
index 82a4453c9c2d..000000000000
--- a/arch/nds32/include/asm/Kbuild
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-generic-y += asm-offsets.h
-generic-y += cmpxchg.h
-generic-y += export.h
-generic-y += gpio.h
-generic-y += kvm_para.h
-generic-y += parport.h
-generic-y += user.h
diff --git a/arch/nds32/include/asm/assembler.h b/arch/nds32/include/asm/assembler.h
deleted file mode 100644
index 5e7c56926049..000000000000
--- a/arch/nds32/include/asm/assembler.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_ASSEMBLER_H__
-#define __NDS32_ASSEMBLER_H__
-
-.macro gie_disable
-	setgie.d
-	dsb
-.endm
-
-.macro gie_enable
-	setgie.e
-	dsb
-.endm
-
-.macro gie_save oldpsw
-	mfsr \oldpsw, $ir0
-	setgie.d
-        dsb
-.endm
-
-.macro gie_restore oldpsw
-	andi \oldpsw, \oldpsw, #0x1
-	beqz \oldpsw, 7001f
-	setgie.e
-	dsb
-7001:
-.endm
-
-
-#define USER(insn,  reg, addr, opr)	\
-9999:	insn  reg, addr, opr;		\
-	.section __ex_table,"a";	\
-	.align 3;			\
-	.long	9999b, 9001f;		\
-	.previous
-
-#endif /* __NDS32_ASSEMBLER_H__ */
diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
deleted file mode 100644
index 16413172fd50..000000000000
--- a/arch/nds32/include/asm/barrier.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_ASM_BARRIER_H
-#define __NDS32_ASM_BARRIER_H
-
-#ifndef __ASSEMBLY__
-#define mb()		asm volatile("msync all":::"memory")
-#define rmb()		asm volatile("msync all":::"memory")
-#define wmb()		asm volatile("msync store":::"memory")
-#include <asm-generic/barrier.h>
-
-#endif	/* __ASSEMBLY__ */
-
-#endif	/* __NDS32_ASM_BARRIER_H */
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
deleted file mode 100644
index b02a58e71f80..000000000000
--- a/arch/nds32/include/asm/bitfield.h
+++ /dev/null
@@ -1,985 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_BITFIELD_H__
-#define __NDS32_BITFIELD_H__
-/******************************************************************************
- * cr0: CPU_VER (CPU Version Register)
- *****************************************************************************/
-#define CPU_VER_offCFGID	0	/* Minor configuration */
-#define CPU_VER_offREV		16	/* Revision of the CPU version */
-#define CPU_VER_offCPUID	24	/* Major CPU versions */
-
-#define CPU_VER_mskCFGID	( 0xFFFF  << CPU_VER_offCFGID )
-#define CPU_VER_mskREV		( 0xFF  << CPU_VER_offREV )
-#define CPU_VER_mskCPUID	( 0xFF  << CPU_VER_offCPUID )
-
-/******************************************************************************
- * cr1: ICM_CFG (Instruction Cache/Memory Configuration Register)
- *****************************************************************************/
-#define ICM_CFG_offISET		0	/* I-cache sets (# of cache lines) per way */
-#define ICM_CFG_offIWAY		3	/* I-cache ways */
-#define ICM_CFG_offISZ		6	/* I-cache line size */
-#define ICM_CFG_offILCK		9	/* I-cache locking support */
-#define ICM_CFG_offILMB		10	/* On-chip ILM banks */
-#define ICM_CFG_offBSAV		13	/* ILM base register alignment version */
-/* bit 15:31 reserved */
-
-#define ICM_CFG_mskISET		( 0x7  << ICM_CFG_offISET )
-#define ICM_CFG_mskIWAY		( 0x7  << ICM_CFG_offIWAY )
-#define ICM_CFG_mskISZ		( 0x7  << ICM_CFG_offISZ )
-#define ICM_CFG_mskILCK		( 0x1  << ICM_CFG_offILCK )
-#define ICM_CFG_mskILMB		( 0x7  << ICM_CFG_offILMB )
-#define ICM_CFG_mskBSAV		( 0x3  << ICM_CFG_offBSAV )
-
-/******************************************************************************
- * cr2: DCM_CFG (Data Cache/Memory Configuration Register)
- *****************************************************************************/
-#define DCM_CFG_offDSET		0	/* D-cache sets (# of cache lines) per way */
-#define DCM_CFG_offDWAY		3	/* D-cache ways */
-#define DCM_CFG_offDSZ		6	/* D-cache line size */
-#define DCM_CFG_offDLCK		9	/* D-cache locking support */
-#define DCM_CFG_offDLMB		10	/* On-chip DLM banks */
-#define DCM_CFG_offBSAV		13	/* DLM base register alignment version */
-/* bit 15:31 reserved */
-
-#define DCM_CFG_mskDSET		( 0x7  << DCM_CFG_offDSET )
-#define DCM_CFG_mskDWAY		( 0x7  << DCM_CFG_offDWAY )
-#define DCM_CFG_mskDSZ		( 0x7  << DCM_CFG_offDSZ )
-#define DCM_CFG_mskDLCK		( 0x1  << DCM_CFG_offDLCK )
-#define DCM_CFG_mskDLMB		( 0x7  << DCM_CFG_offDLMB )
-#define DCM_CFG_mskBSAV		( 0x3  << DCM_CFG_offBSAV )
-
-/******************************************************************************
- * cr3: MMU_CFG (MMU Configuration Register)
- *****************************************************************************/
-#define MMU_CFG_offMMPS		0	/* Memory management protection scheme */
-#define MMU_CFG_offMMPV		2	/* Memory management protection version number */
-#define MMU_CFG_offFATB		7	/* Fully-associative or non-fully-associative TLB */
-
-#define MMU_CFG_offTBW		8	/* TLB ways(non-associative) TBS */
-#define MMU_CFG_offTBS		11	/* TLB sets per way(non-associative) TBS */
-/* bit 14:14 reserved */
-
-#define MMU_CFG_offEP8MIN4	15	/* 8KB page supported while minimum page is 4KB */
-#define MMU_CFG_offfEPSZ	16	/* Extra page size supported */
-#define MMU_CFG_offTLBLCK	24	/* TLB locking support */
-#define MMU_CFG_offHPTWK	25	/* Hardware Page Table Walker implemented */
-#define MMU_CFG_offDE		26	/* Default endian */
-#define MMU_CFG_offNTPT		27	/* Partitions for non-translated attributes */
-#define MMU_CFG_offIVTB		28	/* Invisible TLB */
-#define MMU_CFG_offVLPT		29	/* VLPT for fast TLB fill handling implemented */
-#define MMU_CFG_offNTME		30	/* Non-translated VA to PA mapping */
-/* bit 31 reserved */
-
-#define MMU_CFG_mskMMPS		( 0x3  << MMU_CFG_offMMPS )
-#define MMU_CFG_mskMMPV		( 0x1F  << MMU_CFG_offMMPV )
-#define MMU_CFG_mskFATB		( 0x1  << MMU_CFG_offFATB )
-#define MMU_CFG_mskTBW		( 0x7  << MMU_CFG_offTBW )
-#define MMU_CFG_mskTBS		( 0x7  << MMU_CFG_offTBS )
-#define MMU_CFG_mskEP8MIN4	( 0x1  << MMU_CFG_offEP8MIN4 )
-#define MMU_CFG_mskfEPSZ	( 0xFF  << MMU_CFG_offfEPSZ )
-#define MMU_CFG_mskTLBLCK	( 0x1  << MMU_CFG_offTLBLCK )
-#define MMU_CFG_mskHPTWK	( 0x1  << MMU_CFG_offHPTWK )
-#define MMU_CFG_mskDE		( 0x1  << MMU_CFG_offDE )
-#define MMU_CFG_mskNTPT		( 0x1  << MMU_CFG_offNTPT )
-#define MMU_CFG_mskIVTB		( 0x1  << MMU_CFG_offIVTB )
-#define MMU_CFG_mskVLPT		( 0x1  << MMU_CFG_offVLPT )
-#define MMU_CFG_mskNTME		( 0x1  << MMU_CFG_offNTME )
-
-/******************************************************************************
- * cr4: MSC_CFG (Misc Configuration Register)
- *****************************************************************************/
-#define MSC_CFG_offEDM		0
-#define MSC_CFG_offLMDMA	1
-#define MSC_CFG_offPFM		2
-#define MSC_CFG_offHSMP		3
-#define MSC_CFG_offTRACE	4
-#define MSC_CFG_offDIV		5
-#define MSC_CFG_offMAC		6
-#define MSC_CFG_offAUDIO	7
-#define MSC_CFG_offL2C		9
-#define MSC_CFG_offRDREG	10
-#define MSC_CFG_offADR24	11
-#define MSC_CFG_offINTLC	12
-#define MSC_CFG_offBASEV	13
-#define MSC_CFG_offNOD		16
-/* bit 13:31 reserved */
-
-#define MSC_CFG_mskEDM		( 0x1  << MSC_CFG_offEDM )
-#define MSC_CFG_mskLMDMA	( 0x1  << MSC_CFG_offLMDMA )
-#define MSC_CFG_mskPFM		( 0x1  << MSC_CFG_offPFM )
-#define MSC_CFG_mskHSMP		( 0x1  << MSC_CFG_offHSMP )
-#define MSC_CFG_mskTRACE	( 0x1  << MSC_CFG_offTRACE )
-#define MSC_CFG_mskDIV		( 0x1  << MSC_CFG_offDIV )
-#define MSC_CFG_mskMAC		( 0x1  << MSC_CFG_offMAC )
-#define MSC_CFG_mskAUDIO	( 0x3  << MSC_CFG_offAUDIO )
-#define MSC_CFG_mskL2C		( 0x1  << MSC_CFG_offL2C )
-#define MSC_CFG_mskRDREG	( 0x1  << MSC_CFG_offRDREG )
-#define MSC_CFG_mskADR24	( 0x1  << MSC_CFG_offADR24 )
-#define MSC_CFG_mskINTLC	( 0x1  << MSC_CFG_offINTLC )
-#define MSC_CFG_mskBASEV	( 0x7  << MSC_CFG_offBASEV )
-#define MSC_CFG_mskNOD		( 0x1  << MSC_CFG_offNOD )
-
-/******************************************************************************
- * cr5: CORE_CFG (Core Identification Register)
- *****************************************************************************/
-#define CORE_ID_offCOREID	0
-/* bit 4:31 reserved */
-
-#define CORE_ID_mskCOREID	( 0xF  << CORE_ID_offCOREID )
-
-/******************************************************************************
- * cr6: FUCOP_EXIST (FPU and Coprocessor Existence Configuration Register)
- *****************************************************************************/
-#define FUCOP_EXIST_offCP0EX	0
-#define FUCOP_EXIST_offCP1EX	1
-#define FUCOP_EXIST_offCP2EX	2
-#define FUCOP_EXIST_offCP3EX	3
-#define FUCOP_EXIST_offCP0ISFPU	31
-
-#define FUCOP_EXIST_mskCP0EX	( 0x1  << FUCOP_EXIST_offCP0EX )
-#define FUCOP_EXIST_mskCP1EX	( 0x1  << FUCOP_EXIST_offCP1EX )
-#define FUCOP_EXIST_mskCP2EX	( 0x1  << FUCOP_EXIST_offCP2EX )
-#define FUCOP_EXIST_mskCP3EX	( 0x1  << FUCOP_EXIST_offCP3EX )
-#define FUCOP_EXIST_mskCP0ISFPU	( 0x1  << FUCOP_EXIST_offCP0ISFPU )
-
-/******************************************************************************
- * ir0: PSW (Processor Status Word Register)
- * ir1: IPSW (Interruption PSW Register)
- * ir2: P_IPSW (Previous IPSW Register)
- *****************************************************************************/
-#define PSW_offGIE		0	/* Global Interrupt Enable */
-#define PSW_offINTL		1	/* Interruption Stack Level */
-#define PSW_offPOM		3	/* Processor Operation Mode, User/Superuser */
-#define PSW_offBE		5	/* Endianness for data memory access, 1:MSB, 0:LSB */
-#define PSW_offIT		6	/* Enable instruction address translation */
-#define PSW_offDT		7	/* Enable data address translation */
-#define PSW_offIME		8	/* Instruction Machine Error flag */
-#define PSW_offDME		9	/* Data Machine Error flag */
-#define PSW_offDEX		10	/* Debug Exception */
-#define PSW_offHSS		11	/* Hardware Single Stepping */
-#define PSW_offDRBE		12	/* Device Register Endian Mode */
-#define PSW_offAEN		13	/* Audio ISA special feature */
-#define PSW_offWBNA		14	/* Write Back Non-Allocate */
-#define PSW_offIFCON		15	/* IFC On */
-#define PSW_offCPL		16	/* Current Priority Level */
-/* bit 19:31 reserved */
-
-#define PSW_mskGIE		( 0x1  << PSW_offGIE )
-#define PSW_mskINTL		( 0x3  << PSW_offINTL )
-#define PSW_mskPOM		( 0x3  << PSW_offPOM )
-#define PSW_mskBE		( 0x1  << PSW_offBE )
-#define PSW_mskIT		( 0x1  << PSW_offIT )
-#define PSW_mskDT		( 0x1  << PSW_offDT )
-#define PSW_mskIME		( 0x1  << PSW_offIME )
-#define PSW_mskDME		( 0x1  << PSW_offDME )
-#define PSW_mskDEX		( 0x1  << PSW_offDEX )
-#define PSW_mskHSS		( 0x1  << PSW_offHSS )
-#define PSW_mskDRBE		( 0x1  << PSW_offDRBE )
-#define PSW_mskAEN		( 0x1  << PSW_offAEN )
-#define PSW_mskWBNA		( 0x1  << PSW_offWBNA )
-#define PSW_mskIFCON		( 0x1  << PSW_offIFCON )
-#define PSW_mskCPL		( 0x7  << PSW_offCPL )
-
-#define PSW_SYSTEM		( 1 << PSW_offPOM )
-#define PSW_INTL_1		( 1 << PSW_offINTL )
-#define PSW_CPL_NO		( 0 << PSW_offCPL )
-#define PSW_CPL_ANY		( 7 << PSW_offCPL )
-
-#define PSW_clr			(PSW_mskGIE|PSW_mskINTL|PSW_mskPOM|PSW_mskIT|PSW_mskDT|PSW_mskIME|PSW_mskWBNA)
-#ifdef __NDS32_EB__
-#ifdef CONFIG_WBNA
-#define PSW_init		(PSW_mskWBNA|(1<<PSW_offINTL)|(1<<PSW_offPOM)|PSW_mskIT|PSW_mskDT|PSW_mskBE)
-#else
-#define PSW_init		((1<<PSW_offINTL)|(1<<PSW_offPOM)|PSW_mskIT|PSW_mskDT|PSW_mskBE)
-#endif
-#else
-#ifdef CONFIG_WBNA
-#define PSW_init		(PSW_mskWBNA|(1<<PSW_offINTL)|(1<<PSW_offPOM)|PSW_mskIT|PSW_mskDT)
-#else
-#define PSW_init		((1<<PSW_offINTL)|(1<<PSW_offPOM)|PSW_mskIT|PSW_mskDT)
-#endif
-#endif
-/******************************************************************************
- * ir3: IVB (Interruption Vector Base Register)
- *****************************************************************************/
-/* bit 0:12 reserved */
-#define IVB_offNIVIC		1	/* Number of input for IVIC Controller */
-#define IVB_offIVIC_VER		11	/* IVIC Version */
-#define IVB_offEVIC		13	/* External Vector Interrupt Controller mode */
-#define IVB_offESZ		14	/* Size of each vector entry */
-#define IVB_offIVBASE		16	/* BasePA of interrupt vector table */
-
-#define IVB_mskNIVIC		( 0x7  << IVB_offNIVIC )
-#define IVB_mskIVIC_VER		( 0x3  << IVB_offIVIC_VER )
-#define IVB_mskEVIC		( 0x1  << IVB_offEVIC )
-#define IVB_mskESZ		( 0x3  << IVB_offESZ )
-#define IVB_mskIVBASE		( 0xFFFF  << IVB_offIVBASE )
-
-#define IVB_valESZ4		0
-#define IVB_valESZ16		1
-#define IVB_valESZ64		2
-#define IVB_valESZ256		3
-/******************************************************************************
- * ir4: EVA (Exception Virtual Address Register)
- * ir5: P_EVA (Previous EVA Register)
- *****************************************************************************/
-
-	/* This register contains the VA that causes the exception */
-
-/******************************************************************************
- * ir6: ITYPE (Interruption Type Register)
- * ir7: P_ITYPE (Previous ITYPE Register)
- *****************************************************************************/
-#define ITYPE_offETYPE		0	/* Exception Type */
-#define ITYPE_offINST		4	/* Exception caused by insn fetch or data access */
-/* bit 5:15 reserved */
-#define ITYPE_offVECTOR		5	/* Vector */
-#define ITYPE_offSWID		16	/* SWID of debugging exception */
-/* bit 31:31 reserved */
-
-#define ITYPE_mskETYPE		( 0xF  << ITYPE_offETYPE )
-#define ITYPE_mskINST		( 0x1  << ITYPE_offINST )
-#define ITYPE_mskVECTOR		( 0x7F  << ITYPE_offVECTOR )
-#define ITYPE_mskSWID		( 0x7FFF  << ITYPE_offSWID )
-
-/* Additional definitions for ITYPE register */
-#define ITYPE_offSTYPE          16	/* Arithmetic Sub Type */
-#define ITYPE_offCPID           20	/* Co-Processor ID which generate the exception */
-
-#define ITYPE_mskSTYPE		( 0xF  << ITYPE_offSTYPE )
-#define ITYPE_mskCPID		( 0x3  << ITYPE_offCPID )
-
-/* Additional definitions of ITYPE register for FPU */
-#define FPU_DISABLE_EXCEPTION	(0x1  << ITYPE_offSTYPE)
-#define FPU_EXCEPTION		(0x2  << ITYPE_offSTYPE)
-#define FPU_CPID		0	/* FPU Co-Processor ID is 0 */
-
-#define NDS32_VECTOR_mskNONEXCEPTION	0x78
-#define NDS32_VECTOR_offEXCEPTION	8
-#define NDS32_VECTOR_offINTERRUPT	9
-
-/* Interrupt vector entry */
-#define ENTRY_RESET_NMI			0
-#define ENTRY_TLB_FILL			1
-#define ENTRY_PTE_NOT_PRESENT		2
-#define ENTRY_TLB_MISC			3
-#define ENTRY_TLB_VLPT_MISS		4
-#define ENTRY_MACHINE_ERROR		5
-#define ENTRY_DEBUG_RELATED		6
-#define ENTRY_GENERAL_EXCPETION		7
-#define ENTRY_SYSCALL			8
-
-/* PTE not present exception definition */
-#define ETYPE_NON_LEAF_PTE_NOT_PRESENT	0
-#define ETYPE_LEAF_PTE_NOT_PRESENT	1
-
-/* General exception ETYPE definition */
-#define ETYPE_ALIGNMENT_CHECK		0
-#define ETYPE_RESERVED_INSTRUCTION	1
-#define ETYPE_TRAP			2
-#define ETYPE_ARITHMETIC		3
-#define ETYPE_PRECISE_BUS_ERROR		4
-#define ETYPE_IMPRECISE_BUS_ERROR	5
-#define ETYPE_COPROCESSOR		6
-#define ETYPE_RESERVED_VALUE		7
-#define ETYPE_NONEXISTENT_MEM_ADDRESS	8
-#define ETYPE_MPZIU_CONTROL		9
-#define ETYPE_NEXT_PRECISE_STACK_OFL	10
-
-/* Kerenl reserves software ID */
-#define SWID_RAISE_INTERRUPT_LEVEL	0x1a	/* SWID_RAISE_INTERRUPT_LEVEL is used to
-						 * raise interrupt level for debug exception
-						 */
-
-/******************************************************************************
- * ir8: MERR (Machine Error Log Register)
- *****************************************************************************/
-/* bit 0:30 reserved */
-#define MERR_offBUSERR		31	/* Bus error caused by a load insn */
-
-#define MERR_mskBUSERR		( 0x1  << MERR_offBUSERR )
-
-/******************************************************************************
- * ir9: IPC (Interruption Program Counter Register)
- * ir10: P_IPC (Previous IPC Register)
- * ir11: OIPC (Overflow Interruption Program Counter Register)
- *****************************************************************************/
-
-	/* This is the shadow stack register of the Program Counter */
-
-/******************************************************************************
- * ir12: P_P0 (Previous P0 Register)
- * ir13: P_P1 (Previous P1 Register)
- *****************************************************************************/
-
-	/* These are shadow registers of $p0 and $p1 */
-
-/******************************************************************************
- * ir14: INT_MASK (Interruption Masking Register)
- *****************************************************************************/
-#define INT_MASK_offH0IM	0	/* Hardware Interrupt 0 Mask bit */
-#define INT_MASK_offH1IM	1	/* Hardware Interrupt 1 Mask bit */
-#define INT_MASK_offH2IM	2	/* Hardware Interrupt 2 Mask bit */
-#define INT_MASK_offH3IM	3	/* Hardware Interrupt 3 Mask bit */
-#define INT_MASK_offH4IM	4	/* Hardware Interrupt 4 Mask bit */
-#define INT_MASK_offH5IM	5	/* Hardware Interrupt 5 Mask bit */
-/* bit 6:15 reserved */
-#define INT_MASK_offSIM		16	/* Software Interrupt Mask bit */
-/* bit 17:29 reserved */
-#define INT_MASK_offIDIVZE	30	/* Enable detection for Divide-By-Zero */
-#define INT_MASK_offDSSIM	31	/* Default Single Stepping Interruption Mask */
-
-#define INT_MASK_mskH0IM	( 0x1  << INT_MASK_offH0IM )
-#define INT_MASK_mskH1IM	( 0x1  << INT_MASK_offH1IM )
-#define INT_MASK_mskH2IM	( 0x1  << INT_MASK_offH2IM )
-#define INT_MASK_mskH3IM	( 0x1  << INT_MASK_offH3IM )
-#define INT_MASK_mskH4IM	( 0x1  << INT_MASK_offH4IM )
-#define INT_MASK_mskH5IM	( 0x1  << INT_MASK_offH5IM )
-#define INT_MASK_mskSIM		( 0x1  << INT_MASK_offSIM )
-#define INT_MASK_mskIDIVZE	( 0x1  << INT_MASK_offIDIVZE )
-#define INT_MASK_mskDSSIM	( 0x1  << INT_MASK_offDSSIM )
-
-#define INT_MASK_INITAIAL_VAL	(INT_MASK_mskDSSIM|INT_MASK_mskIDIVZE)
-
-/******************************************************************************
- * ir15: INT_PEND (Interrupt Pending Register)
- *****************************************************************************/
-#define INT_PEND_offH0I		0	/* Hardware Interrupt 0 pending bit */
-#define INT_PEND_offH1I		1	/* Hardware Interrupt 1 pending bit */
-#define INT_PEND_offH2I		2	/* Hardware Interrupt 2 pending bit */
-#define INT_PEND_offH3I		3	/* Hardware Interrupt 3 pending bit */
-#define INT_PEND_offH4I		4	/* Hardware Interrupt 4 pending bit */
-#define INT_PEND_offH5I		5	/* Hardware Interrupt 5 pending bit */
-
-#define INT_PEND_offCIPL	0	/* Current Interrupt Priority Level */
-
-/* bit 6:15 reserved */
-#define INT_PEND_offSWI		16	/* Software Interrupt pending bit */
-/* bit 17:31 reserved */
-
-#define INT_PEND_mskH0I		( 0x1  << INT_PEND_offH0I )
-#define INT_PEND_mskH1I		( 0x1  << INT_PEND_offH1I )
-#define INT_PEND_mskH2I		( 0x1  << INT_PEND_offH2I )
-#define INT_PEND_mskH3I		( 0x1  << INT_PEND_offH3I )
-#define INT_PEND_mskH4I		( 0x1  << INT_PEND_offH4I )
-#define INT_PEND_mskH5I		( 0x1  << INT_PEND_offH5I )
-#define INT_PEND_mskCIPL	( 0x1  << INT_PEND_offCIPL )
-#define INT_PEND_mskSWI		( 0x1  << INT_PEND_offSWI )
-
-/******************************************************************************
- * mr0: MMU_CTL (MMU Control Register)
- *****************************************************************************/
-#define MMU_CTL_offD		0	/* Default minimum page size */
-#define MMU_CTL_offNTC0		1	/* Non-Translated Cachebility of partition 0 */
-#define MMU_CTL_offNTC1		3	/* Non-Translated Cachebility of partition 1 */
-#define MMU_CTL_offNTC2		5	/* Non-Translated Cachebility of partition 2 */
-#define MMU_CTL_offNTC3		7	/* Non-Translated Cachebility of partition 3 */
-#define MMU_CTL_offTBALCK	9	/* TLB all-lock resolution scheme */
-#define MMU_CTL_offMPZIU	10	/* Multiple Page Size In Use bit */
-#define MMU_CTL_offNTM0		11	/* Non-Translated VA to PA of partition 0 */
-#define MMU_CTL_offNTM1		13	/* Non-Translated VA to PA of partition 1 */
-#define MMU_CTL_offNTM2		15	/* Non-Translated VA to PA of partition 2 */
-#define MMU_CTL_offNTM3		17	/* Non-Translated VA to PA of partition 3 */
-#define MMU_CTL_offUNA		23	/* Unaligned access */
-/* bit 24:31 reserved */
-
-#define MMU_CTL_mskD		( 0x1  << MMU_CTL_offD )
-#define MMU_CTL_mskNTC0		( 0x3  << MMU_CTL_offNTC0 )
-#define MMU_CTL_mskNTC1		( 0x3  << MMU_CTL_offNTC1 )
-#define MMU_CTL_mskNTC2		( 0x3  << MMU_CTL_offNTC2 )
-#define MMU_CTL_mskNTC3		( 0x3  << MMU_CTL_offNTC3 )
-#define MMU_CTL_mskTBALCK	( 0x1  << MMU_CTL_offTBALCK )
-#define MMU_CTL_mskMPZIU	( 0x1  << MMU_CTL_offMPZIU )
-#define MMU_CTL_mskNTM0		( 0x3  << MMU_CTL_offNTM0 )
-#define MMU_CTL_mskNTM1         ( 0x3  << MMU_CTL_offNTM1 )
-#define MMU_CTL_mskNTM2         ( 0x3  << MMU_CTL_offNTM2 )
-#define MMU_CTL_mskNTM3         ( 0x3  << MMU_CTL_offNTM3 )
-
-#define MMU_CTL_D4KB		0
-#define MMU_CTL_D8KB		1
-#define MMU_CTL_UNA		( 0x1  << MMU_CTL_offUNA )
-
-#define MMU_CTL_CACHEABLE_NON   0
-#define MMU_CTL_CACHEABLE_WB	2
-#define MMU_CTL_CACHEABLE_WT	3
-
-/******************************************************************************
- * mr1: L1_PPTB (L1 Physical Page Table Base Register)
- *****************************************************************************/
-#define L1_PPTB_offNV		0	/* Enable Hardware Page Table Walker (HPTWK) */
-/* bit 1:11 reserved */
-#define L1_PPTB_offBASE		12	/* First level physical page table base address */
-
-#define L1_PPTB_mskNV		( 0x1  << L1_PPTB_offNV )
-#define L1_PPTB_mskBASE		( 0xFFFFF  << L1_PPTB_offBASE )
-
-/******************************************************************************
- * mr2: TLB_VPN (TLB Access VPN Register)
- *****************************************************************************/
-/* bit 0:11 reserved */
-#define TLB_VPN_offVPN		12	/* Virtual Page Number */
-
-#define TLB_VPN_mskVPN		( 0xFFFFF  << TLB_VPN_offVPN )
-
-/******************************************************************************
- * mr3: TLB_DATA (TLB Access Data Register)
- *****************************************************************************/
-#define TLB_DATA_offV		0	/* PTE is valid and present */
-#define TLB_DATA_offM		1	/* Page read/write access privilege */
-#define TLB_DATA_offD		4	/* Dirty bit */
-#define TLB_DATA_offX		5	/* Executable bit */
-#define TLB_DATA_offA		6	/* Access bit */
-#define TLB_DATA_offG		7	/* Global page (shared across contexts) */
-#define TLB_DATA_offC		8	/* Cacheability atribute */
-/* bit 11:11 reserved */
-#define TLB_DATA_offPPN		12	/* Phisical Page Number */
-
-#define TLB_DATA_mskV		( 0x1  << TLB_DATA_offV )
-#define TLB_DATA_mskM		( 0x7  << TLB_DATA_offM )
-#define TLB_DATA_mskD		( 0x1  << TLB_DATA_offD )
-#define TLB_DATA_mskX		( 0x1  << TLB_DATA_offX )
-#define TLB_DATA_mskA		( 0x1  << TLB_DATA_offA )
-#define TLB_DATA_mskG		( 0x1  << TLB_DATA_offG )
-#define TLB_DATA_mskC		( 0x7  << TLB_DATA_offC )
-#define TLB_DATA_mskPPN		( 0xFFFFF  << TLB_DATA_offPPN )
-
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-#define TLB_DATA_kernel_text_attr	(TLB_DATA_mskV|TLB_DATA_mskM|TLB_DATA_mskD|TLB_DATA_mskX|TLB_DATA_mskG|TLB_DATA_mskC)
-#else
-#define TLB_DATA_kernel_text_attr	(TLB_DATA_mskV|TLB_DATA_mskM|TLB_DATA_mskD|TLB_DATA_mskX|TLB_DATA_mskG|(0x6 << TLB_DATA_offC))
-#endif
-
-/******************************************************************************
- * mr4: TLB_MISC (TLB Access Misc Register)
- *****************************************************************************/
-#define TLB_MISC_offACC_PSZ	0	/* Page size of a PTE entry */
-#define TLB_MISC_offCID		4	/* Context id */
-/* bit 13:31 reserved */
-
-#define TLB_MISC_mskACC_PSZ    ( 0xF  << TLB_MISC_offACC_PSZ )
-#define TLB_MISC_mskCID        ( 0x1FF  << TLB_MISC_offCID )
-
-/******************************************************************************
- * mr5: VLPT_IDX (Virtual Linear Page Table Index Register)
- *****************************************************************************/
-#define VLPT_IDX_offZERO	0	/* Always 0 */
-#define VLPT_IDX_offEVPN	2	/* Exception Virtual Page Number */
-#define VLPT_IDX_offVLPTB	22	/* Base VA of VLPT */
-
-#define VLPT_IDX_mskZERO	( 0x3  << VLPT_IDX_offZERO )
-#define VLPT_IDX_mskEVPN	( 0xFFFFF  << VLPT_IDX_offEVPN )
-#define VLPT_IDX_mskVLPTB	( 0x3FF  << VLPT_IDX_offVLPTB )
-
-/******************************************************************************
- * mr6: ILMB (Instruction Local Memory Base Register)
- *****************************************************************************/
-#define ILMB_offIEN		0	/* Enable ILM */
-#define ILMB_offILMSZ		1	/* Size of ILM */
-/* bit 5:19 reserved */
-#define ILMB_offIBPA		20	/* Base PA of ILM */
-
-#define ILMB_mskIEN		( 0x1  << ILMB_offIEN )
-#define ILMB_mskILMSZ		( 0xF  << ILMB_offILMSZ )
-#define ILMB_mskIBPA		( 0xFFF  << ILMB_offIBPA )
-
-/******************************************************************************
- * mr7: DLMB (Data Local Memory Base Register)
- *****************************************************************************/
-#define DLMB_offDEN		0	/* Enable DLM */
-#define DLMB_offDLMSZ		1	/* Size of DLM */
-#define DLMB_offDBM		5	/* Enable Double-Buffer Mode for DLM */
-#define DLMB_offDBB		6	/* Double-buffer bank which can be accessed by the processor */
-/* bit 7:19 reserved */
-#define DLMB_offDBPA		20	/* Base PA of DLM */
-
-#define DLMB_mskDEN		( 0x1  << DLMB_offDEN )
-#define DLMB_mskDLMSZ		( 0xF  << DLMB_offDLMSZ )
-#define DLMB_mskDBM		( 0x1  << DLMB_offDBM )
-#define DLMB_mskDBB		( 0x1  << DLMB_offDBB )
-#define DLMB_mskDBPA		( 0xFFF  << DLMB_offDBPA )
-
-/******************************************************************************
- * mr8: CACHE_CTL (Cache Control Register)
- *****************************************************************************/
-#define CACHE_CTL_offIC_EN	0	/* Enable I-cache */
-#define CACHE_CTL_offDC_EN	1	/* Enable D-cache */
-#define CACHE_CTL_offICALCK	2	/* I-cache all-lock resolution scheme */
-#define CACHE_CTL_offDCALCK	3	/* D-cache all-lock resolution scheme */
-#define CACHE_CTL_offDCCWF	4	/* Enable D-cache Critical Word Forwarding */
-#define CACHE_CTL_offDCPMW	5	/* Enable D-cache concurrent miss and write-back processing */
-/* bit 6:31 reserved */
-
-#define CACHE_CTL_mskIC_EN	( 0x1  << CACHE_CTL_offIC_EN )
-#define CACHE_CTL_mskDC_EN	( 0x1  << CACHE_CTL_offDC_EN )
-#define CACHE_CTL_mskICALCK	( 0x1  << CACHE_CTL_offICALCK )
-#define CACHE_CTL_mskDCALCK	( 0x1  << CACHE_CTL_offDCALCK )
-#define CACHE_CTL_mskDCCWF	( 0x1  << CACHE_CTL_offDCCWF )
-#define CACHE_CTL_mskDCPMW	( 0x1  << CACHE_CTL_offDCPMW )
-
-/******************************************************************************
- * mr9: HSMP_SADDR (High Speed Memory Port Starting Address)
- *****************************************************************************/
-#define HSMP_SADDR_offEN	0	/* Enable control bit for the High Speed Memory port */
-/* bit 1:19 reserved */
-
-#define HSMP_SADDR_offRANGE	1	/* Denote the address range (only defined in HSMP v2 ) */
-#define HSMP_SADDR_offSADDR	20	/* Starting base PA of the High Speed Memory Port region */
-
-#define HSMP_SADDR_mskEN	( 0x1  << HSMP_SADDR_offEN )
-#define HSMP_SADDR_mskRANGE	( 0xFFF  << HSMP_SADDR_offRANGE )
-#define HSMP_SADDR_mskSADDR	( 0xFFF  << HSMP_SADDR_offSADDR )
-
-/******************************************************************************
- * mr10: HSMP_EADDR (High Speed Memory Port Ending Address)
- *****************************************************************************/
-/* bit 0:19 reserved */
-#define HSMP_EADDR_offEADDR	20
-
-#define HSMP_EADDR_mskEADDR	( 0xFFF  << HSMP_EADDR_offEADDR )
-
-/******************************************************************************
- * dr0+(n*5): BPCn (n=0-7) (Breakpoint Control Register)
- *****************************************************************************/
-#define BPC_offWP		0	/* Configuration of BPAn */
-#define BPC_offEL		1	/* Enable BPAn */
-#define BPC_offS		2	/* Data address comparison for a store instruction */
-#define BPC_offP		3	/* Compared data address is PA */
-#define BPC_offC		4	/* CID value is compared with the BPCIDn register */
-#define BPC_offBE0		5	/* Enable byte mask for the comparison with register */
-#define BPC_offBE1		6	/* Enable byte mask for the comparison with register */
-#define BPC_offBE2		7	/* Enable byte mask for the comparison with register */
-#define BPC_offBE3		8	/* Enable byte mask for the comparison with register */
-#define BPC_offT		9	/* Enable breakpoint Embedded Tracer triggering operation */
-
-#define BPC_mskWP		( 0x1  << BPC_offWP )
-#define BPC_mskEL		( 0x1  << BPC_offEL )
-#define BPC_mskS		( 0x1  << BPC_offS )
-#define BPC_mskP		( 0x1  << BPC_offP )
-#define BPC_mskC		( 0x1  << BPC_offC )
-#define BPC_mskBE0		( 0x1  << BPC_offBE0 )
-#define BPC_mskBE1		( 0x1  << BPC_offBE1 )
-#define BPC_mskBE2		( 0x1  << BPC_offBE2 )
-#define BPC_mskBE3		( 0x1  << BPC_offBE3 )
-#define BPC_mskT		( 0x1  << BPC_offT )
-
-/******************************************************************************
- * dr1+(n*5): BPAn (n=0-7) (Breakpoint Address Register)
- *****************************************************************************/
-
-	/* These registers contain break point address */
-
-/******************************************************************************
- * dr2+(n*5): BPAMn (n=0-7) (Breakpoint Address Mask Register)
- *****************************************************************************/
-
-	/* These registerd contain the address comparison mask for the BPAn register */
-
-/******************************************************************************
- * dr3+(n*5): BPVn (n=0-7) Breakpoint Data Value Register
- *****************************************************************************/
-
-	/* The BPVn register contains the data value that will be compared with the
-	 * incoming load/store data value */
-
-/******************************************************************************
- * dr4+(n*5): BPCIDn (n=0-7) (Breakpoint Context ID Register)
- *****************************************************************************/
-#define BPCID_offCID		0	/* CID that will be compared with a process's CID */
-/* bit 9:31 reserved */
-
-#define BPCID_mskCID		( 0x1FF  << BPCID_offCID )
-
-/******************************************************************************
- * dr40: EDM_CFG (EDM Configuration Register)
- *****************************************************************************/
-#define EDM_CFG_offBC		0	/* Number of hardware breakpoint sets implemented */
-#define EDM_CFG_offDIMU		3	/* Debug Instruction Memory Unit exists */
-/* bit 4:15 reserved */
-#define EDM_CFG_offVER		16	/* EDM version */
-
-#define EDM_CFG_mskBC		( 0x7  << EDM_CFG_offBC )
-#define EDM_CFG_mskDIMU		( 0x1  << EDM_CFG_offDIMU )
-#define EDM_CFG_mskVER		( 0xFFFF  << EDM_CFG_offVER )
-
-/******************************************************************************
- * dr41: EDMSW (EDM Status Word)
- *****************************************************************************/
-#define EDMSW_offWV		0	/* Write Valid */
-#define EDMSW_offRV		1	/* Read Valid */
-#define EDMSW_offDE		2	/* Debug exception has occurred for this core */
-/* bit 3:31 reserved */
-
-#define EDMSW_mskWV		( 0x1  << EDMSW_offWV )
-#define EDMSW_mskRV		( 0x1  << EDMSW_offRV )
-#define EDMSW_mskDE		( 0x1  << EDMSW_offDE )
-
-/******************************************************************************
- * dr42: EDM_CTL (EDM Control Register)
- *****************************************************************************/
-/* bit 0:30 reserved */
-#define EDM_CTL_offV3_EDM_MODE	6	/* EDM compatibility control bit */
-#define EDM_CTL_offDEH_SEL	31	/* Controls where debug exception is directed to */
-
-#define EDM_CTL_mskV3_EDM_MODE	( 0x1 << EDM_CTL_offV3_EDM_MODE )
-#define EDM_CTL_mskDEH_SEL	( 0x1 << EDM_CTL_offDEH_SEL )
-
-/******************************************************************************
- * dr43: EDM_DTR (EDM Data Transfer Register)
- *****************************************************************************/
-
-	/* This is used to exchange data between the embedded EDM logic
-	 * and the processor core */
-
-/******************************************************************************
- * dr44: BPMTC (Breakpoint Match Trigger Counter Register)
- *****************************************************************************/
-#define BPMTC_offBPMTC		0	/* Breakpoint match trigger counter value */
-/* bit 16:31 reserved */
-
-#define BPMTC_mskBPMTC		( 0xFFFF  << BPMTC_offBPMTC )
-
-/******************************************************************************
- * dr45: DIMBR (Debug Instruction Memory Base Register)
- *****************************************************************************/
-/* bit 0:11 reserved */
-#define DIMBR_offDIMB		12	/* Base address of the Debug Instruction Memory (DIM) */
-#define DIMBR_mskDIMB		( 0xFFFFF  << DIMBR_offDIMB )
-
-/******************************************************************************
- * dr46: TECR0(Trigger Event Control register 0)
- * dr47: TECR1 (Trigger Event Control register 1)
- *****************************************************************************/
-#define TECR_offBP		0	/* Controld which BP is used as a trigger source */
-#define TECR_offNMI		8	/* Use NMI as a trigger source */
-#define TECR_offHWINT		9	/* Corresponding interrupt is used as a trigger source */
-#define TECR_offEVIC		15	/* Enable HWINT as a trigger source in EVIC mode */
-#define TECR_offSYS		16	/* Enable SYSCALL instruction as a trigger source */
-#define TECR_offDBG		17	/* Enable debug exception as a trigger source */
-#define TECR_offMRE		18	/* Enable MMU related exception as a trigger source */
-#define TECR_offE		19	/* An exception is used as a trigger source */
-/* bit 20:30 reserved */
-#define TECR_offL		31	/* Link/Cascade TECR0 trigger event to TECR1 trigger event */
-
-#define TECR_mskBP		( 0xFF  << TECR_offBP )
-#define TECR_mskNMI		( 0x1  << TECR_offBNMI )
-#define TECR_mskHWINT		( 0x3F  << TECR_offBHWINT )
-#define TECR_mskEVIC		( 0x1  << TECR_offBEVIC )
-#define TECR_mskSYS		( 0x1  << TECR_offBSYS )
-#define TECR_mskDBG		( 0x1  << TECR_offBDBG )
-#define TECR_mskMRE		( 0x1  << TECR_offBMRE )
-#define TECR_mskE		( 0x1  << TECR_offE )
-#define TECR_mskL		( 0x1  << TECR_offL )
-
-/******************************************************************************
- * pfr0-2: PFMC0-2 (Performance Counter Register 0-2)
- *****************************************************************************/
-
-	/* These registers contains performance event count */
-
-/******************************************************************************
- * pfr3: PFM_CTL (Performance Counter Control Register)
- *****************************************************************************/
-#define PFM_CTL_offEN0		0	/* Enable PFMC0 */
-#define PFM_CTL_offEN1		1	/* Enable PFMC1 */
-#define PFM_CTL_offEN2		2	/* Enable PFMC2 */
-#define PFM_CTL_offIE0		3	/* Enable interrupt for PFMC0 */
-#define PFM_CTL_offIE1		4	/* Enable interrupt for PFMC1 */
-#define PFM_CTL_offIE2		5	/* Enable interrupt for PFMC2 */
-#define PFM_CTL_offOVF0		6	/* Overflow bit of PFMC0 */
-#define PFM_CTL_offOVF1		7	/* Overflow bit of PFMC1 */
-#define PFM_CTL_offOVF2		8	/* Overflow bit of PFMC2 */
-#define PFM_CTL_offKS0		9	/* Enable superuser mode event counting for PFMC0 */
-#define PFM_CTL_offKS1		10	/* Enable superuser mode event counting for PFMC1 */
-#define PFM_CTL_offKS2		11	/* Enable superuser mode event counting for PFMC2 */
-#define PFM_CTL_offKU0		12	/* Enable user mode event counting for PFMC0 */
-#define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
-#define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
-#define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
-#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
-#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
-/* bit 28:31 reserved */
-
-#define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
-#define PFM_CTL_mskEN1		( 0x01  << PFM_CTL_offEN1 )
-#define PFM_CTL_mskEN2		( 0x01  << PFM_CTL_offEN2 )
-#define PFM_CTL_mskIE0		( 0x01  << PFM_CTL_offIE0 )
-#define PFM_CTL_mskIE1		( 0x01  << PFM_CTL_offIE1 )
-#define PFM_CTL_mskIE2		( 0x01  << PFM_CTL_offIE2 )
-#define PFM_CTL_mskOVF0		( 0x01  << PFM_CTL_offOVF0 )
-#define PFM_CTL_mskOVF1		( 0x01  << PFM_CTL_offOVF1 )
-#define PFM_CTL_mskOVF2		( 0x01  << PFM_CTL_offOVF2 )
-#define PFM_CTL_mskKS0		( 0x01  << PFM_CTL_offKS0 )
-#define PFM_CTL_mskKS1		( 0x01  << PFM_CTL_offKS1 )
-#define PFM_CTL_mskKS2		( 0x01  << PFM_CTL_offKS2 )
-#define PFM_CTL_mskKU0		( 0x01  << PFM_CTL_offKU0 )
-#define PFM_CTL_mskKU1		( 0x01  << PFM_CTL_offKU1 )
-#define PFM_CTL_mskKU2		( 0x01  << PFM_CTL_offKU2 )
-#define PFM_CTL_mskSEL0		( 0x01  << PFM_CTL_offSEL0 )
-#define PFM_CTL_mskSEL1		( 0x3F  << PFM_CTL_offSEL1 )
-#define PFM_CTL_mskSEL2		( 0x3F  << PFM_CTL_offSEL2 )
-
-/******************************************************************************
- * SDZ_CTL (Structure Downsizing Control Register)
- *****************************************************************************/
-#define SDZ_CTL_offICDZ		0	/* I-cache downsizing control */
-#define SDZ_CTL_offDCDZ		3	/* D-cache downsizing control */
-#define SDZ_CTL_offMTBDZ	6	/* MTLB downsizing control */
-#define SDZ_CTL_offBTBDZ	9	/* Branch Target Table downsizing control */
-/* bit 12:31 reserved */
-#define SDZ_CTL_mskICDZ		( 0x07  << SDZ_CTL_offICDZ )
-#define SDZ_CTL_mskDCDZ		( 0x07  << SDZ_CTL_offDCDZ )
-#define SDZ_CTL_mskMTBDZ	( 0x07  << SDZ_CTL_offMTBDZ )
-#define SDZ_CTL_mskBTBDZ	( 0x07  << SDZ_CTL_offBTBDZ )
-
-/******************************************************************************
- * N13MISC_CTL (N13 Miscellaneous Control Register)
- *****************************************************************************/
-#define N13MISC_CTL_offBTB	0	/* Disable Branch Target Buffer */
-#define N13MISC_CTL_offRTP	1	/* Disable Return Target Predictor */
-#define N13MISC_CTL_offPTEPF	2	/* Disable HPTWK L2 PTE pefetch */
-#define N13MISC_CTL_offSP_SHADOW_EN	4	/* Enable shadow stack pointers */
-#define MISC_CTL_offHWPRE      11      /* Enable HardWare PREFETCH */
-/* bit 6, 9:31 reserved */
-
-#define N13MISC_CTL_makBTB	( 0x1  << N13MISC_CTL_offBTB )
-#define N13MISC_CTL_makRTP	( 0x1  << N13MISC_CTL_offRTP )
-#define N13MISC_CTL_makPTEPF	( 0x1  << N13MISC_CTL_offPTEPF )
-#define N13MISC_CTL_makSP_SHADOW_EN	( 0x1  << N13MISC_CTL_offSP_SHADOW_EN )
-#define MISC_CTL_makHWPRE_EN     ( 0x1  << MISC_CTL_offHWPRE )
-
-#ifdef CONFIG_HW_PRE
-#define MISC_init	(N13MISC_CTL_makBTB|N13MISC_CTL_makRTP|N13MISC_CTL_makSP_SHADOW_EN|MISC_CTL_makHWPRE_EN)
-#else
-#define MISC_init	(N13MISC_CTL_makBTB|N13MISC_CTL_makRTP|N13MISC_CTL_makSP_SHADOW_EN)
-#endif
-
-/******************************************************************************
- * PRUSR_ACC_CTL (Privileged Resource User Access Control Registers)
- *****************************************************************************/
-#define PRUSR_ACC_CTL_offDMA_EN	0	/* Allow user mode access of DMA registers */
-#define PRUSR_ACC_CTL_offPFM_EN	1	/* Allow user mode access of PFM registers */
-
-#define PRUSR_ACC_CTL_mskDMA_EN	( 0x1  << PRUSR_ACC_CTL_offDMA_EN )
-#define PRUSR_ACC_CTL_mskPFM_EN	( 0x1  << PRUSR_ACC_CTL_offPFM_EN )
-
-/******************************************************************************
- * dmar0: DMA_CFG (DMA Configuration Register)
- *****************************************************************************/
-#define DMA_CFG_offNCHN		0	/* The number of DMA channels implemented */
-#define DMA_CFG_offUNEA		2	/* Un-aligned External Address transfer feature */
-#define DMA_CFG_off2DET		3	/* 2-D Element Transfer feature */
-/* bit 4:15 reserved */
-#define DMA_CFG_offVER		16	/* DMA architecture and implementation version */
-
-#define DMA_CFG_mskNCHN		( 0x3  << DMA_CFG_offNCHN )
-#define DMA_CFG_mskUNEA		( 0x1  << DMA_CFG_offUNEA )
-#define DMA_CFG_msk2DET		( 0x1  << DMA_CFG_off2DET )
-#define DMA_CFG_mskVER		( 0xFFFF  << DMA_CFG_offVER )
-
-/******************************************************************************
- * dmar1: DMA_GCSW (DMA Global Control and Status Word Register)
- *****************************************************************************/
-#define DMA_GCSW_offC0STAT	0	/* DMA channel 0 state */
-#define DMA_GCSW_offC1STAT	3	/* DMA channel 1 state */
-/* bit 6:11 reserved */
-#define DMA_GCSW_offC0INT	12	/* DMA channel 0 generate interrupt */
-#define DMA_GCSW_offC1INT	13	/* DMA channel 1 generate interrupt */
-/* bit 14:30 reserved */
-#define DMA_GCSW_offEN		31	/* Enable DMA engine */
-
-#define DMA_GCSW_mskC0STAT	( 0x7  << DMA_GCSW_offC0STAT )
-#define DMA_GCSW_mskC1STAT	( 0x7  << DMA_GCSW_offC1STAT )
-#define DMA_GCSW_mskC0INT	( 0x1  << DMA_GCSW_offC0INT )
-#define DMA_GCSW_mskC1INT	( 0x1  << DMA_GCSW_offC1INT )
-#define DMA_GCSW_mskEN		( 0x1  << DMA_GCSW_offEN )
-
-/******************************************************************************
- * dmar2: DMA_CHNSEL (DMA Channel Selection Register)
- *****************************************************************************/
-#define DMA_CHNSEL_offCHAN	0	/* Selected channel number */
-/* bit 2:31 reserved */
-
-#define DMA_CHNSEL_mskCHAN	( 0x3  << DMA_CHNSEL_offCHAN )
-
-/******************************************************************************
- * dmar3: DMA_ACT (DMA Action Register)
- *****************************************************************************/
-#define DMA_ACT_offACMD		0	/* DMA Action Command */
-/* bit 2:31 reserved */
-#define DMA_ACT_mskACMD		( 0x3  << DMA_ACT_offACMD )
-
-/******************************************************************************
- * dmar4: DMA_SETUP (DMA Setup Register)
- *****************************************************************************/
-#define DMA_SETUP_offLM		0	/* Local Memory Selection */
-#define DMA_SETUP_offTDIR	1	/* Transfer Direction */
-#define DMA_SETUP_offTES	2	/* Transfer Element Size */
-#define DMA_SETUP_offESTR	4	/* External memory transfer Stride */
-#define DMA_SETUP_offCIE	16	/* Interrupt Enable on Completion */
-#define DMA_SETUP_offSIE	17	/* Interrupt Enable on explicit Stop */
-#define DMA_SETUP_offEIE	18	/* Interrupt Enable on Error */
-#define DMA_SETUP_offUE		19	/* Enable the Un-aligned External Address */
-#define DMA_SETUP_off2DE	20	/* Enable the 2-D External Transfer */
-#define DMA_SETUP_offCOA	21	/* Transfer Coalescable */
-/* bit 22:31 reserved */
-
-#define DMA_SETUP_mskLM		( 0x1  << DMA_SETUP_offLM )
-#define DMA_SETUP_mskTDIR	( 0x1  << DMA_SETUP_offTDIR )
-#define DMA_SETUP_mskTES	( 0x3  << DMA_SETUP_offTES )
-#define DMA_SETUP_mskESTR	( 0xFFF  << DMA_SETUP_offESTR )
-#define DMA_SETUP_mskCIE	( 0x1  << DMA_SETUP_offCIE )
-#define DMA_SETUP_mskSIE	( 0x1  << DMA_SETUP_offSIE )
-#define DMA_SETUP_mskEIE	( 0x1  << DMA_SETUP_offEIE )
-#define DMA_SETUP_mskUE		( 0x1  << DMA_SETUP_offUE )
-#define DMA_SETUP_msk2DE	( 0x1  << DMA_SETUP_off2DE )
-#define DMA_SETUP_mskCOA	( 0x1  << DMA_SETUP_offCOA )
-
-/******************************************************************************
- * dmar5: DMA_ISADDR (DMA Internal Start Address Register)
- *****************************************************************************/
-#define DMA_ISADDR_offISADDR	0	/* Internal Start Address */
-/* bit 20:31 reserved */
-#define DMA_ISADDR_mskISADDR	( 0xFFFFF  << DMA_ISADDR_offISADDR )
-
-/******************************************************************************
- * dmar6: DMA_ESADDR (DMA External Start Address Register)
- *****************************************************************************/
-/* This register holds External Start Address */
-
-/******************************************************************************
- * dmar7: DMA_TCNT (DMA Transfer Element Count Register)
- *****************************************************************************/
-#define DMA_TCNT_offTCNT	0	/* DMA transfer element count */
-/* bit 18:31 reserved */
-#define DMA_TCNT_mskTCNT	( 0x3FFFF  << DMA_TCNT_offTCNT )
-
-/******************************************************************************
- * dmar8: DMA_STATUS (DMA Status Register)
- *****************************************************************************/
-#define DMA_STATUS_offSTAT	0	/* DMA channel state */
-#define DMA_STATUS_offSTUNA	3	/* Un-aligned error on External Stride value */
-#define DMA_STATUS_offDERR	4	/* DMA Transfer Disruption Error */
-#define DMA_STATUS_offEUNA	5	/* Un-aligned error on the External address */
-#define DMA_STATUS_offIUNA	6	/* Un-aligned error on the Internal address */
-#define DMA_STATUS_offIOOR	7	/* Out-Of-Range error on the Internal address */
-#define DMA_STATUS_offEBUS	8	/* Bus Error on an External DMA transfer */
-#define DMA_STATUS_offESUP	9	/* DMA setup error */
-/* bit 10:31 reserved */
-
-#define DMA_STATUS_mskSTAT	( 0x7  << DMA_STATUS_offSTAT )
-#define DMA_STATUS_mskSTUNA	( 0x1  << DMDMA_STATUS_offSTUNA )
-#define DMA_STATUS_mskDERR	( 0x1  << DMDMA_STATUS_offDERR )
-#define DMA_STATUS_mskEUNA	( 0x1  << DMDMA_STATUS_offEUNA )
-#define DMA_STATUS_mskIUNA	( 0x1  << DMDMA_STATUS_offIUNA )
-#define DMA_STATUS_mskIOOR	( 0x1  << DMDMA_STATUS_offIOOR )
-#define DMA_STATUS_mskEBUS	( 0x1  << DMDMA_STATUS_offEBUS )
-#define DMA_STATUS_mskESUP	( 0x1  << DMDMA_STATUS_offESUP )
-
-/******************************************************************************
- * dmar9: DMA_2DSET (DMA 2D Setup Register)
- *****************************************************************************/
-#define DMA_2DSET_offWECNT	0	/* The Width Element Count for a 2-D region */
-#define DMA_2DSET_offHTSTR	16	/* The Height Stride for a 2-D region */
-
-#define DMA_2DSET_mskHTSTR	( 0xFFFF  << DMA_2DSET_offHTSTR )
-#define DMA_2DSET_mskWECNT	( 0xFFFF  << DMA_2DSET_offWECNT )
-
-/******************************************************************************
- * dmar10: DMA_2DSCTL (DMA 2D Startup Control Register)
- *****************************************************************************/
-#define DMA_2DSCTL_offSTWECNT	0	/* Startup Width Element Count for a 2-D region */
-/* bit 16:31 reserved */
-
-#define DMA_2DSCTL_mskSTWECNT	( 0xFFFF  << DMA_2DSCTL_offSTWECNT )
-
-/******************************************************************************
- * fpcsr: FPCSR (Floating-Point Control Status Register)
- *****************************************************************************/
-#define FPCSR_offRM		0
-#define FPCSR_offIVO		2
-#define FPCSR_offDBZ		3
-#define FPCSR_offOVF		4
-#define FPCSR_offUDF		5
-#define FPCSR_offIEX		6
-#define FPCSR_offIVOE		7
-#define FPCSR_offDBZE		8
-#define FPCSR_offOVFE		9
-#define FPCSR_offUDFE		10
-#define FPCSR_offIEXE		11
-#define FPCSR_offDNZ		12
-#define FPCSR_offIVOT		13
-#define FPCSR_offDBZT		14
-#define FPCSR_offOVFT		15
-#define FPCSR_offUDFT		16
-#define FPCSR_offIEXT		17
-#define FPCSR_offDNIT		18
-#define FPCSR_offRIT		19
-
-#define FPCSR_mskRM             ( 0x3  << FPCSR_offRM )
-#define FPCSR_mskIVO            ( 0x1  << FPCSR_offIVO )
-#define FPCSR_mskDBZ            ( 0x1  << FPCSR_offDBZ )
-#define FPCSR_mskOVF            ( 0x1  << FPCSR_offOVF )
-#define FPCSR_mskUDF            ( 0x1  << FPCSR_offUDF )
-#define FPCSR_mskIEX            ( 0x1  << FPCSR_offIEX )
-#define FPCSR_mskIVOE           ( 0x1  << FPCSR_offIVOE )
-#define FPCSR_mskDBZE           ( 0x1  << FPCSR_offDBZE )
-#define FPCSR_mskOVFE           ( 0x1  << FPCSR_offOVFE )
-#define FPCSR_mskUDFE           ( 0x1  << FPCSR_offUDFE )
-#define FPCSR_mskIEXE           ( 0x1  << FPCSR_offIEXE )
-#define FPCSR_mskDNZ            ( 0x1  << FPCSR_offDNZ )
-#define FPCSR_mskIVOT           ( 0x1  << FPCSR_offIVOT )
-#define FPCSR_mskDBZT           ( 0x1  << FPCSR_offDBZT )
-#define FPCSR_mskOVFT           ( 0x1  << FPCSR_offOVFT )
-#define FPCSR_mskUDFT           ( 0x1  << FPCSR_offUDFT )
-#define FPCSR_mskIEXT           ( 0x1  << FPCSR_offIEXT )
-#define FPCSR_mskDNIT           ( 0x1  << FPCSR_offDNIT )
-#define FPCSR_mskRIT		( 0x1  << FPCSR_offRIT )
-#define FPCSR_mskALL		(FPCSR_mskIVO | FPCSR_mskDBZ | FPCSR_mskOVF | FPCSR_mskUDF | FPCSR_mskIEX)
-#define FPCSR_mskALLE_NO_UDF_IEXE (FPCSR_mskIVOE | FPCSR_mskDBZE | FPCSR_mskOVFE)
-#define FPCSR_mskALLE		(FPCSR_mskIVOE | FPCSR_mskDBZE | FPCSR_mskOVFE | FPCSR_mskUDFE | FPCSR_mskIEXE)
-#define FPCSR_mskALLT           (FPCSR_mskIVOT | FPCSR_mskDBZT | FPCSR_mskOVFT | FPCSR_mskUDFT | FPCSR_mskIEXT |FPCSR_mskDNIT | FPCSR_mskRIT)
-
-/******************************************************************************
- * fpcfg: FPCFG (Floating-Point Configuration Register)
- *****************************************************************************/
-#define	FPCFG_offSP		0
-#define FPCFG_offDP		1
-#define FPCFG_offFREG		2
-#define FPCFG_offFMA		4
-#define FPCFG_offIMVER		22
-#define FPCFG_offAVER		27
-
-#define FPCFG_mskSP		( 0x1  << FPCFG_offSP )
-#define FPCFG_mskDP		( 0x1  << FPCFG_offDP )
-#define FPCFG_mskFREG		( 0x3  << FPCFG_offFREG )
-#define FPCFG_mskFMA		( 0x1  << FPCFG_offFMA )
-#define FPCFG_mskIMVER		( 0x1F  << FPCFG_offIMVER )
-#define FPCFG_mskAVER		( 0x1F  << FPCFG_offAVER )
-
-/* 8 Single precision or 4 double precision registers are available */
-#define SP8_DP4_reg		0
-/* 16 Single precision or 8 double precision registers are available */
-#define SP16_DP8_reg		1
-/* 32 Single precision or 16 double precision registers are available */
-#define SP32_DP16_reg		2
-/* 32 Single precision or 32 double precision registers are available */
-#define SP32_DP32_reg		3
-
-/******************************************************************************
- * fucpr: FUCOP_CTL (FPU and Coprocessor Enable Control Register)
- *****************************************************************************/
-#define FUCOP_CTL_offCP0EN	0
-#define FUCOP_CTL_offCP1EN	1
-#define FUCOP_CTL_offCP2EN	2
-#define FUCOP_CTL_offCP3EN	3
-#define FUCOP_CTL_offAUEN	31
-
-#define FUCOP_CTL_mskCP0EN	( 0x1  << FUCOP_CTL_offCP0EN )
-#define FUCOP_CTL_mskCP1EN	( 0x1  << FUCOP_CTL_offCP1EN )
-#define FUCOP_CTL_mskCP2EN      ( 0x1  << FUCOP_CTL_offCP2EN )
-#define FUCOP_CTL_mskCP3EN      ( 0x1  << FUCOP_CTL_offCP3EN )
-#define FUCOP_CTL_mskAUEN       ( 0x1  << FUCOP_CTL_offAUEN )
-
-#endif /* __NDS32_BITFIELD_H__ */
diff --git a/arch/nds32/include/asm/cache.h b/arch/nds32/include/asm/cache.h
deleted file mode 100644
index fc3c41b59169..000000000000
--- a/arch/nds32/include/asm/cache.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_CACHE_H__
-#define __NDS32_CACHE_H__
-
-#define L1_CACHE_BYTES	32
-#define L1_CACHE_SHIFT	5
-
-#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
-
-#endif /* __NDS32_CACHE_H__ */
diff --git a/arch/nds32/include/asm/cache_info.h b/arch/nds32/include/asm/cache_info.h
deleted file mode 100644
index e89d8078f3a6..000000000000
--- a/arch/nds32/include/asm/cache_info.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-struct cache_info {
-	unsigned char ways;
-	unsigned char line_size;
-	unsigned short sets;
-	unsigned short size;
-#if defined(CONFIG_CPU_CACHE_ALIASING)
-	unsigned short aliasing_num;
-	unsigned int aliasing_mask;
-#endif
-};
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
deleted file mode 100644
index c2a222ebfa2a..000000000000
--- a/arch/nds32/include/asm/cacheflush.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_CACHEFLUSH_H__
-#define __NDS32_CACHEFLUSH_H__
-
-#include <linux/mm.h>
-
-#define PG_dcache_dirty PG_arch_1
-
-void flush_icache_range(unsigned long start, unsigned long end);
-#define flush_icache_range flush_icache_range
-
-void flush_icache_page(struct vm_area_struct *vma, struct page *page);
-#define flush_icache_page flush_icache_page
-
-#ifdef CONFIG_CPU_CACHE_ALIASING
-void flush_cache_mm(struct mm_struct *mm);
-void flush_cache_dup_mm(struct mm_struct *mm);
-void flush_cache_range(struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end);
-void flush_cache_page(struct vm_area_struct *vma,
-		      unsigned long addr, unsigned long pfn);
-void flush_cache_kmaps(void);
-void flush_cache_vmap(unsigned long start, unsigned long end);
-void flush_cache_vunmap(unsigned long start, unsigned long end);
-
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-void flush_dcache_page(struct page *page);
-void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
-		       unsigned long vaddr, void *dst, void *src, int len);
-void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
-			 unsigned long vaddr, void *dst, void *src, int len);
-
-#define ARCH_HAS_FLUSH_ANON_PAGE
-void flush_anon_page(struct vm_area_struct *vma,
-		     struct page *page, unsigned long vaddr);
-
-#define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
-void flush_kernel_vmap_range(void *addr, int size);
-void invalidate_kernel_vmap_range(void *addr, int size);
-#define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
-#define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
-
-#else
-void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
-	                     unsigned long addr, int len);
-#define flush_icache_user_page flush_icache_user_page
-
-#include <asm-generic/cacheflush.h>
-#endif
-
-#endif /* __NDS32_CACHEFLUSH_H__ */
diff --git a/arch/nds32/include/asm/current.h b/arch/nds32/include/asm/current.h
deleted file mode 100644
index 65d30096142b..000000000000
--- a/arch/nds32/include/asm/current.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASM_NDS32_CURRENT_H
-#define _ASM_NDS32_CURRENT_H
-
-#ifndef __ASSEMBLY__
-register struct task_struct *current asm("$r25");
-#endif /* __ASSEMBLY__ */
-#define tsk $r25
-
-#endif /* _ASM_NDS32_CURRENT_H */
diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
deleted file mode 100644
index 56ea3894f8f8..000000000000
--- a/arch/nds32/include/asm/delay.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_DELAY_H__
-#define __NDS32_DELAY_H__
-
-#include <asm/param.h>
-
-/* There is no clocksource cycle counter in the CPU. */
-static inline void __delay(unsigned long loops)
-{
-	__asm__ __volatile__(".align 2\n"
-			     "1:\n"
-			     "\taddi\t%0, %0, -1\n"
-			     "\tbgtz\t%0, 1b\n"
-			     :"=r"(loops)
-			     :"0"(loops));
-}
-
-static inline void __udelay(unsigned long usecs, unsigned long lpj)
-{
-	usecs *= (unsigned long)(((0x8000000000000000ULL / (500000 / HZ)) +
-				  0x80000000ULL) >> 32);
-	usecs = (unsigned long)(((unsigned long long)usecs * lpj) >> 32);
-	__delay(usecs);
-}
-
-#define udelay(usecs) __udelay((usecs), loops_per_jiffy)
-
-/* make sure "usecs *= ..." in udelay do not overflow. */
-#if HZ >= 1000
-#define MAX_UDELAY_MS	1
-#elif HZ <= 200
-#define MAX_UDELAY_MS	5
-#else
-#define MAX_UDELAY_MS	(1000 / HZ)
-#endif
-
-#endif
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
deleted file mode 100644
index 1853dc89b8ac..000000000000
--- a/arch/nds32/include/asm/elf.h
+++ /dev/null
@@ -1,180 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASMNDS32_ELF_H
-#define __ASMNDS32_ELF_H
-
-/*
- * ELF register definitions..
- */
-
-#include <asm/ptrace.h>
-#include <asm/fpu.h>
-#include <linux/elf-em.h>
-
-typedef unsigned long elf_greg_t;
-typedef unsigned long elf_freg_t[3];
-
-extern unsigned int elf_hwcap;
-
-#define R_NDS32_NONE			0
-#define R_NDS32_16_RELA			19
-#define R_NDS32_32_RELA			20
-#define R_NDS32_9_PCREL_RELA		22
-#define R_NDS32_15_PCREL_RELA		23
-#define R_NDS32_17_PCREL_RELA		24
-#define R_NDS32_25_PCREL_RELA		25
-#define R_NDS32_HI20_RELA		26
-#define R_NDS32_LO12S3_RELA		27
-#define R_NDS32_LO12S2_RELA		28
-#define R_NDS32_LO12S1_RELA		29
-#define R_NDS32_LO12S0_RELA		30
-#define R_NDS32_SDA15S3_RELA    	31
-#define R_NDS32_SDA15S2_RELA    	32
-#define R_NDS32_SDA15S1_RELA    	33
-#define R_NDS32_SDA15S0_RELA    	34
-#define R_NDS32_GOT20			37
-#define R_NDS32_25_PLTREL		38
-#define R_NDS32_COPY			39
-#define R_NDS32_GLOB_DAT		40
-#define R_NDS32_JMP_SLOT		41
-#define R_NDS32_RELATIVE		42
-#define R_NDS32_GOTOFF			43
-#define R_NDS32_GOTPC20			44
-#define R_NDS32_GOT_HI20		45
-#define R_NDS32_GOT_LO12		46
-#define R_NDS32_GOTPC_HI20		47
-#define R_NDS32_GOTPC_LO12		48
-#define R_NDS32_GOTOFF_HI20		49
-#define R_NDS32_GOTOFF_LO12		50
-#define R_NDS32_INSN16			51
-#define R_NDS32_LABEL			52
-#define R_NDS32_LONGCALL1		53
-#define R_NDS32_LONGCALL2		54
-#define R_NDS32_LONGCALL3		55
-#define R_NDS32_LONGJUMP1		56
-#define R_NDS32_LONGJUMP2		57
-#define R_NDS32_LONGJUMP3		58
-#define R_NDS32_LOADSTORE		59
-#define R_NDS32_9_FIXED_RELA		60
-#define R_NDS32_15_FIXED_RELA		61
-#define R_NDS32_17_FIXED_RELA		62
-#define R_NDS32_25_FIXED_RELA		63
-#define R_NDS32_PLTREL_HI20		64
-#define R_NDS32_PLTREL_LO12		65
-#define R_NDS32_PLT_GOTREL_HI20		66
-#define R_NDS32_PLT_GOTREL_LO12		67
-#define R_NDS32_LO12S0_ORI_RELA		72
-#define R_NDS32_DWARF2_OP1_RELA     	77
-#define R_NDS32_DWARF2_OP2_RELA     	78
-#define R_NDS32_DWARF2_LEB_RELA     	79
-#define R_NDS32_WORD_9_PCREL_RELA	94
-#define R_NDS32_LONGCALL4 		107
-#define R_NDS32_RELA_NOP_MIX		192
-#define R_NDS32_RELA_NOP_MAX		255
-
-#define ELF_NGREG (sizeof (struct user_pt_regs) / sizeof(elf_greg_t))
-#define ELF_CORE_COPY_REGS(dest, regs)	\
-	*(struct user_pt_regs *)&(dest) = (regs)->user_regs;
-
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-/* Core file format: The core file is written in such a way that gdb
-   can understand it and provide useful information to the user (under
-   linux we use the 'trad-core' bfd).  There are quite a number of
-   obstacles to being able to view the contents of the floating point
-   registers, and until these are solved you will not be able to view the
-   contents of them.  Actually, you can read in the core file and look at
-   the contents of the user struct to find out what the floating point
-   registers contain.
-   The actual file contents are as follows:
-   UPAGE: 1 page consisting of a user struct that tells gdb what is present
-   in the file.  Directly after this is a copy of the task_struct, which
-   is currently not used by gdb, but it may come in useful at some point.
-   All of the registers are stored as part of the upage.  The upage should
-   always be only one page.
-   DATA: The data area is stored.  We use current->end_text to
-   current->brk to pick up all of the user variables, plus any memory
-   that may have been malloced.  No attempt is made to determine if a page
-   is demand-zero or if a page is totally unused, we just cover the entire
-   range.  All of the addresses are rounded in such a way that an integral
-   number of pages is written.
-   STACK: We need the stack information in order to get a meaningful
-   backtrace.  We need to write the data from (esp) to
-   current->start_stack, so we round each of these off in order to be able
-   to write an integer number of pages.
-   The minimum core file size is 3 pages, or 12288 bytes.
-*/
-
-struct user_fp {
-        unsigned long long fd_regs[32];
-        unsigned long fpcsr;
-};
-
-typedef struct user_fp elf_fpregset_t;
-
-struct elf32_hdr;
-#define elf_check_arch(x)		((x)->e_machine == EM_NDS32)
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS	ELFCLASS32
-#ifdef __NDS32_EB__
-#define ELF_DATA	ELFDATA2MSB
-#else
-#define ELF_DATA	ELFDATA2LSB
-#endif
-#define ELF_ARCH	EM_NDS32
-#define ELF_EXEC_PAGESIZE	PAGE_SIZE
-
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-#define ELF_ET_DYN_BASE	(2 * TASK_SIZE / 3)
-
-/* When the program starts, a1 contains a pointer to a function to be
-   registered with atexit, as per the SVR4 ABI.  A value of 0 means we
-   have no such handler.  */
-#define ELF_PLAT_INIT(_r, load_addr)	(_r)->uregs[0] = 0
-
-/* This yields a mask that user programs can use to figure out what
-   instruction set this cpu supports. */
-
-#define ELF_HWCAP	(elf_hwcap)
-
-#ifdef __KERNEL__
-
-#define ELF_PLATFORM    (NULL)
-
-/* Old NetWinder binaries were compiled in such a way that the iBCS
-   heuristic always trips on them.  Until these binaries become uncommon
-   enough not to care, don't trust the `ibcs' flag here.  In any case
-   there is no other ELF system currently supported by iBCS.
-   @@ Could print a warning message to encourage users to upgrade.  */
-#define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
-
-#endif
-
-
-#if IS_ENABLED(CONFIG_FPU)
-#define FPU_AUX_ENT	NEW_AUX_ENT(AT_FPUCW, FPCSR_INIT)
-#else
-#define FPU_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
-#endif
-
-#define ARCH_DLINFO						\
-do {								\
-	/* Optional FPU initialization */			\
-	FPU_AUX_ENT;						\
-								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		    (elf_addr_t)current->mm->context.vdso);	\
-} while (0)
-#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-struct linux_binprm;
-int arch_setup_additional_pages(struct linux_binprm *, int);
-
-#endif
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
deleted file mode 100644
index 2fa09a2de428..000000000000
--- a/arch/nds32/include/asm/fixmap.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_FIXMAP_H
-#define __ASM_NDS32_FIXMAP_H
-
-#ifdef CONFIG_HIGHMEM
-#include <linux/threads.h>
-#include <asm/kmap_size.h>
-#endif
-
-enum fixed_addresses {
-	FIX_HOLE,
-	FIX_KMAP_RESERVED,
-	FIX_KMAP_BEGIN,
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
-#endif
-	FIX_EARLYCON_MEM_BASE,
-	__end_of_fixed_addresses
-};
-#define FIXADDR_TOP             ((unsigned long) (-(16 * PAGE_SIZE)))
-#define FIXADDR_SIZE		((__end_of_fixed_addresses) << PAGE_SHIFT)
-#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
-#define FIXMAP_PAGE_IO		__pgprot(PAGE_DEVICE)
-void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
-
-#include <asm-generic/fixmap.h>
-#endif /* __ASM_NDS32_FIXMAP_H */
diff --git a/arch/nds32/include/asm/fpu.h b/arch/nds32/include/asm/fpu.h
deleted file mode 100644
index 8294ed4aaa2c..000000000000
--- a/arch/nds32/include/asm/fpu.h
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2005-2018 Andes Technology Corporation */
-
-#ifndef __ASM_NDS32_FPU_H
-#define __ASM_NDS32_FPU_H
-
-#if IS_ENABLED(CONFIG_FPU)
-#ifndef __ASSEMBLY__
-#include <linux/sched/task_stack.h>
-#include <linux/preempt.h>
-#include <asm/ptrace.h>
-
-extern bool has_fpu;
-
-extern void save_fpu(struct task_struct *__tsk);
-extern void load_fpu(const struct fpu_struct *fpregs);
-extern bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs);
-extern int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu);
-
-#define test_tsk_fpu(regs)	(regs->fucop_ctl & FUCOP_CTL_mskCP0EN)
-
-/*
- * Initially load the FPU with signalling NANS.  This bit pattern
- * has the property that no matter whether considered as single or as
- * double precision, it still represents a signalling NAN.
- */
-
-#define sNAN64    0xFFFFFFFFFFFFFFFFULL
-#define sNAN32    0xFFFFFFFFUL
-
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-/*
- * Denormalized number is unsupported by nds32 FPU. Hence the operation
- * is treated as underflow cases when the final result is a denormalized
- * number. To enhance precision, underflow exception trap should be
- * enabled by default and kerenl will re-execute it by fpu emulator
- * when getting underflow exception.
- */
-#define FPCSR_INIT  (FPCSR_mskUDFE | FPCSR_mskIEXE)
-#else
-#define FPCSR_INIT  0x0UL
-#endif
-
-extern const struct fpu_struct init_fpuregs;
-
-static inline void disable_ptreg_fpu(struct pt_regs *regs)
-{
-	regs->fucop_ctl &= ~FUCOP_CTL_mskCP0EN;
-}
-
-static inline void enable_ptreg_fpu(struct pt_regs *regs)
-{
-	regs->fucop_ctl |= FUCOP_CTL_mskCP0EN;
-}
-
-static inline void enable_fpu(void)
-{
-	unsigned long fucop_ctl;
-
-	fucop_ctl = __nds32__mfsr(NDS32_SR_FUCOP_CTL) | FUCOP_CTL_mskCP0EN;
-	__nds32__mtsr(fucop_ctl, NDS32_SR_FUCOP_CTL);
-	__nds32__isb();
-}
-
-static inline void disable_fpu(void)
-{
-	unsigned long fucop_ctl;
-
-	fucop_ctl = __nds32__mfsr(NDS32_SR_FUCOP_CTL) & ~FUCOP_CTL_mskCP0EN;
-	__nds32__mtsr(fucop_ctl, NDS32_SR_FUCOP_CTL);
-	__nds32__isb();
-}
-
-static inline void lose_fpu(void)
-{
-	preempt_disable();
-#if IS_ENABLED(CONFIG_LAZY_FPU)
-	if (last_task_used_math == current) {
-		last_task_used_math = NULL;
-#else
-	if (test_tsk_fpu(task_pt_regs(current))) {
-#endif
-		save_fpu(current);
-	}
-	disable_ptreg_fpu(task_pt_regs(current));
-	preempt_enable();
-}
-
-static inline void own_fpu(void)
-{
-	preempt_disable();
-#if IS_ENABLED(CONFIG_LAZY_FPU)
-	if (last_task_used_math != current) {
-		if (last_task_used_math != NULL)
-			save_fpu(last_task_used_math);
-		load_fpu(&current->thread.fpu);
-		last_task_used_math = current;
-	}
-#else
-	if (!test_tsk_fpu(task_pt_regs(current))) {
-		load_fpu(&current->thread.fpu);
-	}
-#endif
-	enable_ptreg_fpu(task_pt_regs(current));
-	preempt_enable();
-}
-
-#if !IS_ENABLED(CONFIG_LAZY_FPU)
-static inline void unlazy_fpu(struct task_struct *tsk)
-{
-	preempt_disable();
-	if (test_tsk_fpu(task_pt_regs(tsk)))
-		save_fpu(tsk);
-	preempt_enable();
-}
-#endif /* !CONFIG_LAZY_FPU */
-static inline void clear_fpu(struct pt_regs *regs)
-{
-	preempt_disable();
-	if (test_tsk_fpu(regs))
-		disable_ptreg_fpu(regs);
-	preempt_enable();
-}
-#endif /* CONFIG_FPU */
-#endif /* __ASSEMBLY__ */
-#endif /* __ASM_NDS32_FPU_H */
diff --git a/arch/nds32/include/asm/fpuemu.h b/arch/nds32/include/asm/fpuemu.h
deleted file mode 100644
index 63e7ef5f7969..000000000000
--- a/arch/nds32/include/asm/fpuemu.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2005-2018 Andes Technology Corporation */
-
-#ifndef __ARCH_NDS32_FPUEMU_H
-#define __ARCH_NDS32_FPUEMU_H
-
-/*
- * single precision
- */
-
-void fadds(void *ft, void *fa, void *fb);
-void fsubs(void *ft, void *fa, void *fb);
-void fmuls(void *ft, void *fa, void *fb);
-void fdivs(void *ft, void *fa, void *fb);
-void fs2d(void *ft, void *fa);
-void fs2si(void *ft, void *fa);
-void fs2si_z(void *ft, void *fa);
-void fs2ui(void *ft, void *fa);
-void fs2ui_z(void *ft, void *fa);
-void fsi2s(void *ft, void *fa);
-void fui2s(void *ft, void *fa);
-void fsqrts(void *ft, void *fa);
-void fnegs(void *ft, void *fa);
-int fcmps(void *ft, void *fa, void *fb, int cop);
-
-/*
- * double precision
- */
-void faddd(void *ft, void *fa, void *fb);
-void fsubd(void *ft, void *fa, void *fb);
-void fmuld(void *ft, void *fa, void *fb);
-void fdivd(void *ft, void *fa, void *fb);
-void fsqrtd(void *ft, void *fa);
-void fd2s(void *ft, void *fa);
-void fd2si(void *ft, void *fa);
-void fd2si_z(void *ft, void *fa);
-void fd2ui(void *ft, void *fa);
-void fd2ui_z(void *ft, void *fa);
-void fsi2d(void *ft, void *fa);
-void fui2d(void *ft, void *fa);
-void fnegd(void *ft, void *fa);
-int fcmpd(void *ft, void *fa, void *fb, int cop);
-
-#endif /* __ARCH_NDS32_FPUEMU_H */
diff --git a/arch/nds32/include/asm/ftrace.h b/arch/nds32/include/asm/ftrace.h
deleted file mode 100644
index 2f96cc96aa35..000000000000
--- a/arch/nds32/include/asm/ftrace.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_NDS32_FTRACE_H
-#define __ASM_NDS32_FTRACE_H
-
-#ifdef CONFIG_FUNCTION_TRACER
-
-#define HAVE_FUNCTION_GRAPH_FP_TEST
-
-#define MCOUNT_ADDR ((unsigned long)(_mcount))
-/* mcount call is composed of three instructions:
- * sethi + ori + jral
- */
-#define MCOUNT_INSN_SIZE 12
-
-extern void _mcount(unsigned long parent_ip);
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-
-#define FTRACE_ADDR ((unsigned long)_ftrace_caller)
-
-#ifdef __NDS32_EL__
-#define INSN_NOP		0x09000040
-#define INSN_SIZE(insn)		(((insn & 0x00000080) == 0) ? 4 : 2)
-#define IS_SETHI(insn)		((insn & 0x000000fe) == 0x00000046)
-#define ENDIAN_CONVERT(insn)	be32_to_cpu(insn)
-#else /* __NDS32_EB__ */
-#define INSN_NOP		0x40000009
-#define INSN_SIZE(insn)		(((insn & 0x80000000) == 0) ? 4 : 2)
-#define IS_SETHI(insn)		((insn & 0xfe000000) == 0x46000000)
-#define ENDIAN_CONVERT(insn)	(insn)
-#endif
-
-extern void _ftrace_caller(unsigned long parent_ip);
-static inline unsigned long ftrace_call_adjust(unsigned long addr)
-{
-	return addr;
-}
-struct dyn_arch_ftrace {
-};
-
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-#endif /* CONFIG_FUNCTION_TRACER */
-
-#endif /* __ASM_NDS32_FTRACE_H */
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
deleted file mode 100644
index 4223f473bd36..000000000000
--- a/arch/nds32/include/asm/futex.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_FUTEX_H__
-#define __NDS32_FUTEX_H__
-
-#include <linux/futex.h>
-#include <linux/uaccess.h>
-#include <asm/errno.h>
-
-#define __futex_atomic_ex_table(err_reg)			\
-	"	.pushsection __ex_table,\"a\"\n"		\
-	"	.align	3\n"					\
-	"	.long	1b, 4f\n"				\
-	"	.long	2b, 4f\n"				\
-	"	.popsection\n"					\
-	"	.pushsection .fixup,\"ax\"\n"			\
-	"4:	move	%0, " err_reg "\n"			\
-	"	b	3b\n"					\
-	"	.popsection"
-
-#define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
-	smp_mb();						\
-	asm volatile(					\
-	"	movi	$ta, #0\n"				\
-	"1:	llw	%1, [%2+$ta]\n"				\
-	"	" insn "\n"					\
-	"2:	scw	%0, [%2+$ta]\n"				\
-	"	beqz	%0, 1b\n"				\
-	"	movi	%0, #0\n"				\
-	"3:\n"							\
-	__futex_atomic_ex_table("%4")				\
-	: "=&r" (ret), "=&r" (oldval)				\
-	: "r" (uaddr), "r" (oparg), "i" (-EFAULT)		\
-	: "cc", "memory")
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
-			      u32 oldval, u32 newval)
-{
-	int ret = 0;
-	u32 val, tmp, flags;
-
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
-	smp_mb();
-	asm volatile ("       movi    $ta, #0\n"
-		      "1:     llw     %1, [%6 + $ta]\n"
-		      "       sub     %3, %1, %4\n"
-		      "       cmovz   %2, %5, %3\n"
-		      "       cmovn   %2, %1, %3\n"
-		      "2:     scw     %2, [%6 + $ta]\n"
-		      "       beqz    %2, 1b\n"
-		      "3:\n                   " __futex_atomic_ex_table("%7")
-		      :"+&r"(ret), "=&r"(val), "=&r"(tmp), "=&r"(flags)
-		      :"r"(oldval), "r"(newval), "r"(uaddr), "i"(-EFAULT)
-		      :"$ta", "memory");
-	smp_mb();
-
-	*uval = val;
-	return ret;
-}
-
-static inline int
-arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
-{
-	int oldval = 0, ret;
-
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-	switch (op) {
-	case FUTEX_OP_SET:
-		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
-				  oparg);
-		break;
-	case FUTEX_OP_ADD:
-		__futex_atomic_op("add	%0, %1, %3", ret, oldval, tmp, uaddr,
-				  oparg);
-		break;
-	case FUTEX_OP_OR:
-		__futex_atomic_op("or	%0, %1, %3", ret, oldval, tmp, uaddr,
-				  oparg);
-		break;
-	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	%0, %1, %3", ret, oldval, tmp, uaddr,
-				  ~oparg);
-		break;
-	case FUTEX_OP_XOR:
-		__futex_atomic_op("xor	%0, %1, %3", ret, oldval, tmp, uaddr,
-				  oparg);
-		break;
-	default:
-		ret = -ENOSYS;
-	}
-
-	if (!ret)
-		*oval = oldval;
-
-	return ret;
-}
-#endif /* __NDS32_FUTEX_H__ */
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
deleted file mode 100644
index 16159a8716f2..000000000000
--- a/arch/nds32/include/asm/highmem.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASM_HIGHMEM_H
-#define _ASM_HIGHMEM_H
-
-#include <asm/proc-fns.h>
-#include <asm/fixmap.h>
-
-/*
- * Right now we initialize only a single pte table. It can be extended
- * easily, subsequent pte tables have to be allocated in one physical
- * chunk of RAM.
- */
-/*
- * Ordering is (from lower to higher memory addresses):
- *
- * high_memory
- *			Persistent kmap area
- * PKMAP_BASE
- *			fixed_addresses
- * FIXADDR_START
- * FIXADDR_TOP
- *			Vmalloc area
- * VMALLOC_START
- * VMALLOC_END
- */
-#define PKMAP_BASE		((FIXADDR_START - PGDIR_SIZE) & (PGDIR_MASK))
-#define LAST_PKMAP		PTRS_PER_PTE
-#define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
-#define PKMAP_NR(virt)		(((virt) - (PKMAP_BASE)) >> PAGE_SHIFT)
-#define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
-
-static inline void flush_cache_kmaps(void)
-{
-	cpu_dcache_wbinval_all();
-}
-
-/* declarations for highmem.c */
-extern unsigned long highstart_pfn, highend_pfn;
-
-extern pte_t *pkmap_page_table;
-
-extern void kmap_init(void);
-
-/*
- * FIXME: The below looks broken vs. a kmap_atomic() in task context which
- * is interupted and another kmap_atomic() happens in interrupt context.
- * But what do I know about nds32. -- tglx
- */
-#define arch_kmap_local_post_map(vaddr, pteval)			\
-	do {							\
-		__nds32__tlbop_inv(vaddr);			\
-		__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);	\
-		__nds32__tlbop_rwr(pteval);			\
-		__nds32__isb();					\
-	} while (0)
-
-#define arch_kmap_local_pre_unmap(vaddr)			\
-	do {							\
-		__nds32__tlbop_inv(vaddr);			\
-		__nds32__isb();					\
-	} while (0)
-
-#endif
diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
deleted file mode 100644
index e57378d04006..000000000000
--- a/arch/nds32/include/asm/io.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_IO_H
-#define __ASM_NDS32_IO_H
-
-#include <linux/types.h>
-
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
-{
-	asm volatile("sbi %0, [%1]" : : "r" (val), "r" (addr));
-}
-
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
-{
-	asm volatile("shi %0, [%1]" : : "r" (val), "r" (addr));
-}
-
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 val, volatile void __iomem *addr)
-{
-	asm volatile("swi %0, [%1]" : : "r" (val), "r" (addr));
-}
-
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	u8 val;
-
-	asm volatile("lbi %0, [%1]" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	u16 val;
-
-	asm volatile("lhi %0, [%1]" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	u32 val;
-
-	asm volatile("lwi %0, [%1]" : "=r" (val) : "r" (addr));
-	return val;
-}
-
-#define __iormb()               rmb()
-#define __iowmb()               wmb()
-
-/*
- * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
- * are not guaranteed to provide ordering against spinlocks or memory
- * accesses.
- */
-
-#define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
-#define readw_relaxed(c)	({ u16 __v = le16_to_cpu((__force __le16)__raw_readw(c)); __v; })
-#define readl_relaxed(c)	({ u32 __v = le32_to_cpu((__force __le32)__raw_readl(c)); __v; })
-#define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
-#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
-#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
-
-/*
- * {read,write}{b,w,l,q}() access little endian memory and return result in
- * native endianness.
- */
-#define readb(c)	({ u8  __v = readb_relaxed(c); __iormb(); __v; })
-#define readw(c)	({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-#define readl(c)	({ u32 __v = readl_relaxed(c); __iormb(); __v; })
-
-#define writeb(v,c)	({ __iowmb(); writeb_relaxed((v),(c)); })
-#define writew(v,c)	({ __iowmb(); writew_relaxed((v),(c)); })
-#define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
-
-#include <asm-generic/io.h>
-
-#endif /* __ASM_NDS32_IO_H */
diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
deleted file mode 100644
index 51ef800bb301..000000000000
--- a/arch/nds32/include/asm/irqflags.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <asm/nds32.h>
-#include <nds32_intrinsic.h>
-
-#define arch_local_irq_disable()	\
-	GIE_DISABLE();
-
-#define arch_local_irq_enable()	\
-	GIE_ENABLE();
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
-	GIE_DISABLE();
-	return flags;
-}
-
-static inline unsigned long arch_local_save_flags(void)
-{
-	unsigned long flags;
-	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
-	return flags;
-}
-
-static inline void arch_local_irq_restore(unsigned long flags)
-{
-	if(flags)
-		GIE_ENABLE();
-}
-
-static inline int arch_irqs_disabled_flags(unsigned long flags)
-{
-	return !flags;
-}
-
-static inline int arch_irqs_disabled(void)
-{
-	return arch_irqs_disabled_flags(arch_local_save_flags());
-}
diff --git a/arch/nds32/include/asm/l2_cache.h b/arch/nds32/include/asm/l2_cache.h
deleted file mode 100644
index 3ea48e19e6de..000000000000
--- a/arch/nds32/include/asm/l2_cache.h
+++ /dev/null
@@ -1,137 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef L2_CACHE_H
-#define L2_CACHE_H
-
-/* CCTL_CMD_OP */
-#define L2_CA_CONF_OFF		0x0
-#define L2_IF_CONF_OFF		0x4
-#define L2CC_SETUP_OFF		0x8
-#define L2CC_PROT_OFF		0xC
-#define L2CC_CTRL_OFF		0x10
-#define L2_INT_EN_OFF           0x20
-#define L2_STA_OFF              0x24
-#define RDERR_ADDR_OFF		0x28
-#define WRERR_ADDR_OFF		0x2c
-#define EVDPTERR_ADDR_OFF	0x30
-#define IMPL3ERR_ADDR_OFF	0x34
-#define L2_CNT0_CTRL_OFF        0x40
-#define L2_EVNT_CNT0_OFF        0x44
-#define L2_CNT1_CTRL_OFF        0x48
-#define L2_EVNT_CNT1_OFF        0x4c
-#define L2_CCTL_CMD_OFF		0x60
-#define L2_CCTL_STATUS_OFF	0x64
-#define L2_LINE_TAG_OFF		0x68
-#define L2_LINE_DPT_OFF		0x70
-
-#define CCTL_CMD_L2_IX_INVAL    0x0
-#define CCTL_CMD_L2_PA_INVAL    0x1
-#define CCTL_CMD_L2_IX_WB       0x2
-#define CCTL_CMD_L2_PA_WB       0x3
-#define CCTL_CMD_L2_PA_WBINVAL  0x5
-#define CCTL_CMD_L2_SYNC        0xa
-
-/* CCTL_CMD_TYPE */
-#define CCTL_SINGLE_CMD         0
-#define CCTL_BLOCK_CMD          0x10
-#define CCTL_ALL_CMD		0x10
-
-/******************************************************************************
- * L2_CA_CONF (Cache architecture configuration)
- *****************************************************************************/
-#define L2_CA_CONF_offL2SET		0
-#define L2_CA_CONF_offL2WAY		4
-#define L2_CA_CONF_offL2CLSZ            8
-#define L2_CA_CONF_offL2DW		11
-#define L2_CA_CONF_offL2PT		14
-#define L2_CA_CONF_offL2VER		16
-
-#define L2_CA_CONF_mskL2SET	(0xFUL << L2_CA_CONF_offL2SET)
-#define L2_CA_CONF_mskL2WAY	(0xFUL << L2_CA_CONF_offL2WAY)
-#define L2_CA_CONF_mskL2CLSZ    (0x7UL << L2_CA_CONF_offL2CLSZ)
-#define L2_CA_CONF_mskL2DW	(0x7UL << L2_CA_CONF_offL2DW)
-#define L2_CA_CONF_mskL2PT	(0x3UL << L2_CA_CONF_offL2PT)
-#define L2_CA_CONF_mskL2VER	(0xFFFFUL << L2_CA_CONF_offL2VER)
-
-/******************************************************************************
- * L2CC_SETUP (L2CC Setup register)
- *****************************************************************************/
-#define L2CC_SETUP_offPART              0
-#define L2CC_SETUP_mskPART              (0x3UL << L2CC_SETUP_offPART)
-#define L2CC_SETUP_offDDLATC            4
-#define L2CC_SETUP_mskDDLATC            (0x3UL << L2CC_SETUP_offDDLATC)
-#define L2CC_SETUP_offTDLATC            8
-#define L2CC_SETUP_mskTDLATC            (0x3UL << L2CC_SETUP_offTDLATC)
-
-/******************************************************************************
- * L2CC_PROT (L2CC Protect register)
- *****************************************************************************/
-#define L2CC_PROT_offMRWEN              31
-#define L2CC_PROT_mskMRWEN      (0x1UL << L2CC_PROT_offMRWEN)
-
-/******************************************************************************
- * L2_CCTL_STATUS_Mn (The L2CCTL command working status for Master n)
- *****************************************************************************/
-#define L2CC_CTRL_offEN                 31
-#define L2CC_CTRL_mskEN                 (0x1UL << L2CC_CTRL_offEN)
-
-/******************************************************************************
- * L2_CCTL_STATUS_Mn (The L2CCTL command working status for Master n)
- *****************************************************************************/
-#define L2_CCTL_STATUS_offCMD_COMP      31
-#define L2_CCTL_STATUS_mskCMD_COMP      (0x1 << L2_CCTL_STATUS_offCMD_COMP)
-
-extern void __iomem *atl2c_base;
-#include <linux/smp.h>
-#include <asm/io.h>
-#include <asm/bitfield.h>
-
-#define L2C_R_REG(offset)               readl(atl2c_base + offset)
-#define L2C_W_REG(offset, value)        writel(value, atl2c_base + offset)
-
-#define L2_CMD_RDY()    \
-        do{;}while((L2C_R_REG(L2_CCTL_STATUS_OFF) & L2_CCTL_STATUS_mskCMD_COMP) == 0)
-
-static inline unsigned long L2_CACHE_SET(void)
-{
-	return 64 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2SET) >>
-		      L2_CA_CONF_offL2SET);
-}
-
-static inline unsigned long L2_CACHE_WAY(void)
-{
-	return 1 +
-	    ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2WAY) >>
-	     L2_CA_CONF_offL2WAY);
-}
-
-static inline unsigned long L2_CACHE_LINE_SIZE(void)
-{
-
-	return 4 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2CLSZ) >>
-		     L2_CA_CONF_offL2CLSZ);
-}
-
-static inline unsigned long GET_L2CC_CTRL_CPU(unsigned long cpu)
-{
-	if (cpu == smp_processor_id())
-		return L2C_R_REG(L2CC_CTRL_OFF);
-	return L2C_R_REG(L2CC_CTRL_OFF + (cpu << 8));
-}
-
-static inline void SET_L2CC_CTRL_CPU(unsigned long cpu, unsigned long val)
-{
-	if (cpu == smp_processor_id())
-		L2C_W_REG(L2CC_CTRL_OFF, val);
-	else
-		L2C_W_REG(L2CC_CTRL_OFF + (cpu << 8), val);
-}
-
-static inline unsigned long GET_L2CC_STATUS_CPU(unsigned long cpu)
-{
-	if (cpu == smp_processor_id())
-		return L2C_R_REG(L2_CCTL_STATUS_OFF);
-	return L2C_R_REG(L2_CCTL_STATUS_OFF + (cpu << 8));
-}
-#endif
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
deleted file mode 100644
index a696469abb70..000000000000
--- a/arch/nds32/include/asm/linkage.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* This file is required by include/linux/linkage.h */
-#define __ALIGN .align 2
-#define __ALIGN_STR ".align 2"
-
-#endif
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
deleted file mode 100644
index 62faafbc28e4..000000000000
--- a/arch/nds32/include/asm/memory.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_MEMORY_H
-#define __ASM_NDS32_MEMORY_H
-
-#include <linux/compiler.h>
-#include <linux/sizes.h>
-
-#ifndef __ASSEMBLY__
-#include <asm/page.h>
-#endif
-
-#ifndef PHYS_OFFSET
-#define PHYS_OFFSET     (0x0)
-#endif
-
-/*
- * TASK_SIZE - the maximum size of a user space task.
- * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
- */
-#define TASK_SIZE		((CONFIG_PAGE_OFFSET) - (SZ_32M))
-#define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_32M)
-#define PAGE_OFFSET		(CONFIG_PAGE_OFFSET)
-
-/*
- * Physical vs virtual RAM address space conversion.  These are
- * private definitions which should NOT be used outside memory.h
- * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
- */
-#ifndef __virt_to_phys
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
-#endif
-
-/*
- * The module space lives between the addresses given by TASK_SIZE
- * and PAGE_OFFSET - it must be within 32MB of the kernel text.
- */
-#define MODULES_END	(PAGE_OFFSET)
-#define MODULES_VADDR	(MODULES_END - SZ_32M)
-
-#if TASK_SIZE > MODULES_VADDR
-#error Top of user space clashes with start of module space
-#endif
-
-#ifndef __ASSEMBLY__
-
-/*
- * PFNs are used to describe any physical page; this means
- * PFN 0 == physical address 0.
- *
- * This is the PFN of the first RAM page in the kernel
- * direct-mapped view.  We assume this is the first page
- * of RAM in the mem_map as well.
- */
-#define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
-
-/*
- * Drivers should NOT use these either.
- */
-#define __pa(x)			__virt_to_phys((unsigned long)(x))
-#define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
-
-/*
- * Conversion between a struct page and a physical address.
- *
- * Note: when converting an unknown physical address to a
- * struct page, the resulting pointer must be validated
- * using VALID_PAGE().  It must return an invalid struct page
- * for any physical address not corresponding to a system
- * RAM address.
- *
- *  pfn_valid(pfn)	indicates whether a PFN number is valid
- *
- *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
- *  virt_addr_valid(k)	indicates whether a virtual address is valid
- */
-#define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
-#define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
-
-#define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
-#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
-
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
-
-#endif
-
-#include <asm-generic/memory_model.h>
-
-#endif
diff --git a/arch/nds32/include/asm/mmu.h b/arch/nds32/include/asm/mmu.h
deleted file mode 100644
index 89d63afee455..000000000000
--- a/arch/nds32/include/asm/mmu.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_MMU_H
-#define __NDS32_MMU_H
-
-typedef struct {
-	unsigned int id;
-	void *vdso;
-} mm_context_t;
-
-#endif
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
deleted file mode 100644
index c651bc8cacdc..000000000000
--- a/arch/nds32/include/asm/mmu_context.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_MMU_CONTEXT_H
-#define __ASM_NDS32_MMU_CONTEXT_H
-
-#include <linux/spinlock.h>
-#include <asm/tlbflush.h>
-#include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
-
-#define init_new_context init_new_context
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	mm->context.id = 0;
-	return 0;
-}
-
-#define CID_BITS	9
-extern spinlock_t cid_lock;
-extern unsigned int cpu_last_cid;
-
-static inline void __new_context(struct mm_struct *mm)
-{
-	unsigned int cid;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cid_lock, flags);
-	cid = cpu_last_cid;
-	cpu_last_cid += 1 << TLB_MISC_offCID;
-	if (cpu_last_cid == 0)
-		cpu_last_cid = 1 << TLB_MISC_offCID << CID_BITS;
-
-	if ((cid & TLB_MISC_mskCID) == 0)
-		flush_tlb_all();
-	spin_unlock_irqrestore(&cid_lock, flags);
-
-	mm->context.id = cid;
-}
-
-static inline void check_context(struct mm_struct *mm)
-{
-	if (unlikely
-	    ((mm->context.id ^ cpu_last_cid) >> TLB_MISC_offCID >> CID_BITS))
-		__new_context(mm);
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
-{
-	unsigned int cpu = smp_processor_id();
-
-	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
-		check_context(next);
-		cpu_switch_mm(next);
-	}
-}
-
-#include <asm-generic/mmu_context.h>
-
-#endif
diff --git a/arch/nds32/include/asm/nds32.h b/arch/nds32/include/asm/nds32.h
deleted file mode 100644
index 4994f6a9e0a0..000000000000
--- a/arch/nds32/include/asm/nds32.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASM_NDS32_NDS32_H_
-#define _ASM_NDS32_NDS32_H_
-
-#include <asm/bitfield.h>
-#include <asm/cachectl.h>
-
-#ifndef __ASSEMBLY__
-#include <linux/init.h>
-#include <asm/barrier.h>
-#include <nds32_intrinsic.h>
-
-#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-#define FP_OFFSET (-3)
-#else
-#define FP_OFFSET (-2)
-#endif
-#define LP_OFFSET (-1)
-
-extern void __init early_trap_init(void);
-static inline void GIE_ENABLE(void)
-{
-	mb();
-	__nds32__gie_en();
-}
-
-static inline void GIE_DISABLE(void)
-{
-	mb();
-	__nds32__gie_dis();
-}
-
-static inline unsigned long CACHE_SET(unsigned char cache)
-{
-
-	if (cache == ICACHE)
-		return 64 << ((__nds32__mfsr(NDS32_SR_ICM_CFG) & ICM_CFG_mskISET) >>
-			      ICM_CFG_offISET);
-	else
-		return 64 << ((__nds32__mfsr(NDS32_SR_DCM_CFG) & DCM_CFG_mskDSET) >>
-			      DCM_CFG_offDSET);
-}
-
-static inline unsigned long CACHE_WAY(unsigned char cache)
-{
-
-	if (cache == ICACHE)
-		return 1 +
-		    ((__nds32__mfsr(NDS32_SR_ICM_CFG) & ICM_CFG_mskIWAY) >> ICM_CFG_offIWAY);
-	else
-		return 1 +
-		    ((__nds32__mfsr(NDS32_SR_DCM_CFG) & DCM_CFG_mskDWAY) >> DCM_CFG_offDWAY);
-}
-
-static inline unsigned long CACHE_LINE_SIZE(unsigned char cache)
-{
-
-	if (cache == ICACHE)
-		return 8 <<
-		    (((__nds32__mfsr(NDS32_SR_ICM_CFG) & ICM_CFG_mskISZ) >> ICM_CFG_offISZ) - 1);
-	else
-		return 8 <<
-		    (((__nds32__mfsr(NDS32_SR_DCM_CFG) & DCM_CFG_mskDSZ) >> DCM_CFG_offDSZ) - 1);
-}
-
-#endif /* __ASSEMBLY__ */
-
-#define IVB_BASE		PHYS_OFFSET	/* in user space for intr/exc/trap/break table base, 64KB aligned
-						 * We defined at the start of the physical memory */
-
-/* dispatched sub-entry exception handler numbering */
-#define RD_PROT			0	/* read protrection */
-#define WRT_PROT		1	/* write protection */
-#define NOEXEC			2	/* non executable */
-#define PAGE_MODIFY		3	/* page modified */
-#define ACC_BIT			4	/* access bit */
-#define RESVED_PTE		5	/* reserved PTE attribute */
-/* reserved 6 ~ 16 */
-
-#endif /* _ASM_NDS32_NDS32_H_ */
diff --git a/arch/nds32/include/asm/nds32_fpu_inst.h b/arch/nds32/include/asm/nds32_fpu_inst.h
deleted file mode 100644
index 1e4b86a90a48..000000000000
--- a/arch/nds32/include/asm/nds32_fpu_inst.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2005-2018 Andes Technology Corporation */
-
-#ifndef __NDS32_FPU_INST_H
-#define __NDS32_FPU_INST_H
-
-#define cop0_op	0x35
-
-/*
- * COP0 field of opcodes.
- */
-#define fs1_op	0x0
-#define fs2_op  0x4
-#define fd1_op  0x8
-#define fd2_op  0xc
-
-/*
- * FS1 opcode.
- */
-enum fs1 {
-	fadds_op, fsubs_op, fcpynss_op, fcpyss_op,
-	fmadds_op, fmsubs_op, fcmovns_op, fcmovzs_op,
-	fnmadds_op, fnmsubs_op,
-	fmuls_op = 0xc, fdivs_op,
-	fs1_f2op_op = 0xf
-};
-
-/*
- * FS1/F2OP opcode.
- */
-enum fs1_f2 {
-	fs2d_op, fsqrts_op,
-	fui2s_op = 0x8, fsi2s_op = 0xc,
-	fs2ui_op = 0x10, fs2ui_z_op = 0x14,
-	fs2si_op = 0x18, fs2si_z_op = 0x1c
-};
-
-/*
- * FS2 opcode.
- */
-enum fs2 {
-	fcmpeqs_op, fcmpeqs_e_op, fcmplts_op, fcmplts_e_op,
-	fcmples_op, fcmples_e_op, fcmpuns_op, fcmpuns_e_op
-};
-
-/*
- * FD1 opcode.
- */
-enum fd1 {
-	faddd_op, fsubd_op, fcpynsd_op, fcpysd_op,
-	fmaddd_op, fmsubd_op, fcmovnd_op, fcmovzd_op,
-	fnmaddd_op, fnmsubd_op,
-	fmuld_op = 0xc, fdivd_op, fd1_f2op_op = 0xf
-};
-
-/*
- * FD1/F2OP opcode.
- */
-enum fd1_f2 {
-	fd2s_op, fsqrtd_op,
-	fui2d_op = 0x8, fsi2d_op = 0xc,
-	fd2ui_op = 0x10, fd2ui_z_op = 0x14,
-	fd2si_op = 0x18, fd2si_z_op = 0x1c
-};
-
-/*
- * FD2 opcode.
- */
-enum fd2 {
-	fcmpeqd_op, fcmpeqd_e_op, fcmpltd_op, fcmpltd_e_op,
-	fcmpled_op, fcmpled_e_op, fcmpund_op, fcmpund_e_op
-};
-
-#define NDS32Insn(x) x
-
-#define I_OPCODE_off			25
-#define NDS32Insn_OPCODE(x)		(NDS32Insn(x) >> I_OPCODE_off)
-
-#define I_OPCODE_offRt			20
-#define I_OPCODE_mskRt			(0x1fUL << I_OPCODE_offRt)
-#define NDS32Insn_OPCODE_Rt(x) \
-	((NDS32Insn(x) & I_OPCODE_mskRt) >> I_OPCODE_offRt)
-
-#define I_OPCODE_offRa			15
-#define I_OPCODE_mskRa			(0x1fUL << I_OPCODE_offRa)
-#define NDS32Insn_OPCODE_Ra(x) \
-	((NDS32Insn(x) & I_OPCODE_mskRa) >> I_OPCODE_offRa)
-
-#define I_OPCODE_offRb			10
-#define I_OPCODE_mskRb			(0x1fUL << I_OPCODE_offRb)
-#define NDS32Insn_OPCODE_Rb(x) \
-	((NDS32Insn(x) & I_OPCODE_mskRb) >> I_OPCODE_offRb)
-
-#define I_OPCODE_offbit1014		10
-#define I_OPCODE_mskbit1014		(0x1fUL << I_OPCODE_offbit1014)
-#define NDS32Insn_OPCODE_BIT1014(x) \
-	((NDS32Insn(x) & I_OPCODE_mskbit1014) >> I_OPCODE_offbit1014)
-
-#define I_OPCODE_offbit69		6
-#define I_OPCODE_mskbit69		(0xfUL << I_OPCODE_offbit69)
-#define NDS32Insn_OPCODE_BIT69(x) \
-	((NDS32Insn(x) & I_OPCODE_mskbit69) >> I_OPCODE_offbit69)
-
-#define I_OPCODE_offCOP0		0
-#define I_OPCODE_mskCOP0		(0x3fUL << I_OPCODE_offCOP0)
-#define NDS32Insn_OPCODE_COP0(x) \
-	((NDS32Insn(x) & I_OPCODE_mskCOP0) >> I_OPCODE_offCOP0)
-
-#endif /* __NDS32_FPU_INST_H */
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
deleted file mode 100644
index add33a7f02c8..000000000000
--- a/arch/nds32/include/asm/page.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2005-2017 Andes Technology Corporation
- */
-
-#ifndef _ASMNDS32_PAGE_H
-#define _ASMNDS32_PAGE_H
-
-#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
-#define PAGE_SHIFT      12
-#endif
-#ifdef CONFIG_ANDES_PAGE_SIZE_8KB
-#define PAGE_SHIFT      13
-#endif
-#include <linux/const.h>
-#define PAGE_SIZE       (_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK       (~(PAGE_SIZE-1))
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-struct page;
-struct vm_area_struct;
-#ifdef CONFIG_CPU_CACHE_ALIASING
-extern void copy_user_highpage(struct page *to, struct page *from,
-			       unsigned long vaddr, struct vm_area_struct *vma);
-extern void clear_user_highpage(struct page *page, unsigned long vaddr);
-
-void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-		    struct page *to);
-void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
-#define __HAVE_ARCH_COPY_USER_HIGHPAGE
-#define clear_user_highpage	clear_user_highpage
-#else
-#define clear_user_page(page, vaddr, pg)        clear_page(page)
-#define copy_user_page(to, from, vaddr, pg)     copy_page(to, from)
-#endif
-
-void clear_page(void *page);
-void copy_page(void *to, void *from);
-
-typedef unsigned long pte_t;
-typedef unsigned long pgd_t;
-typedef unsigned long pgprot_t;
-
-#define pte_val(x)      (x)
-#define pgd_val(x)	(x)
-#define pgprot_val(x)   (x)
-
-#define __pte(x)        (x)
-#define __pgd(x)        (x)
-#define __pgprot(x)     (x)
-
-typedef struct page *pgtable_t;
-
-#include <asm/memory.h>
-#include <asm-generic/getorder.h>
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif
diff --git a/arch/nds32/include/asm/perf_event.h b/arch/nds32/include/asm/perf_event.h
deleted file mode 100644
index fcdff02acc14..000000000000
--- a/arch/nds32/include/asm/perf_event.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2008-2018 Andes Technology Corporation */
-
-#ifndef __ASM_PERF_EVENT_H
-#define __ASM_PERF_EVENT_H
-
-/*
- * This file is request by Perf,
- * please refer to tools/perf/design.txt for more details
- */
-struct pt_regs;
-unsigned long perf_instruction_pointer(struct pt_regs *regs);
-unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)   perf_misc_flags(regs)
-
-#endif
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
deleted file mode 100644
index a08e1ebca70e..000000000000
--- a/arch/nds32/include/asm/pgalloc.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMNDS32_PGALLOC_H
-#define _ASMNDS32_PGALLOC_H
-
-#include <asm/processor.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <asm/proc-fns.h>
-
-#define __HAVE_ARCH_PTE_ALLOC_ONE
-#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
-
-extern pgd_t *pgd_alloc(struct mm_struct *mm);
-extern void pgd_free(struct mm_struct *mm, pgd_t * pgd);
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	pgtable_t pte;
-
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
-	if (pte)
-		cpu_dcache_wb_page((unsigned long)page_address(pte));
-
-	return pte;
-}
-
-/*
- * Populate the pmdp entry with a pointer to the pte.  This pmd is part
- * of the mm address space.
- *
- * Ensure that we always set both PMD entries.
- */
-static inline void
-pmd_populate_kernel(struct mm_struct *mm, pmd_t * pmdp, pte_t * ptep)
-{
-	unsigned long pte_ptr = (unsigned long)ptep;
-	unsigned long pmdval;
-
-	BUG_ON(mm != &init_mm);
-
-	/*
-	 * The pmd must be loaded with the physical
-	 * address of the PTE table
-	 */
-	pmdval = __pa(pte_ptr) | _PAGE_KERNEL_TABLE;
-	set_pmd(pmdp, __pmd(pmdval));
-}
-
-static inline void
-pmd_populate(struct mm_struct *mm, pmd_t * pmdp, pgtable_t ptep)
-{
-	unsigned long pmdval;
-
-	BUG_ON(mm == &init_mm);
-
-	pmdval = page_to_pfn(ptep) << PAGE_SHIFT | _PAGE_USER_TABLE;
-	set_pmd(pmdp, __pmd(pmdval));
-}
-
-#endif
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
deleted file mode 100644
index 419f984eef70..000000000000
--- a/arch/nds32/include/asm/pgtable.h
+++ /dev/null
@@ -1,377 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMNDS32_PGTABLE_H
-#define _ASMNDS32_PGTABLE_H
-
-#include <asm-generic/pgtable-nopmd.h>
-#include <linux/sizes.h>
-
-#include <asm/memory.h>
-#include <asm/nds32.h>
-#ifndef __ASSEMBLY__
-#include <asm/fixmap.h>
-#include <nds32_intrinsic.h>
-#endif
-
-#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
-#define PGDIR_SHIFT      22
-#define PTRS_PER_PGD     1024
-#define PTRS_PER_PTE     1024
-#endif
-
-#ifdef CONFIG_ANDES_PAGE_SIZE_8KB
-#define PGDIR_SHIFT      24
-#define PTRS_PER_PGD     256
-#define PTRS_PER_PTE     2048
-#endif
-
-#ifndef __ASSEMBLY__
-extern void __pte_error(const char *file, int line, unsigned long val);
-extern void __pgd_error(const char *file, int line, unsigned long val);
-
-#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
-#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
-#endif /* !__ASSEMBLY__ */
-
-#define PMD_SIZE		(1UL << PMD_SHIFT)
-#define PMD_MASK		(~(PMD_SIZE-1))
-#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK		(~(PGDIR_SIZE-1))
-
-/*
- * This is the lowest virtual address we can permit any user space
- * mapping to be mapped at.  This is particularly important for
- * non-high vector CPUs.
- */
-#define FIRST_USER_ADDRESS	0x8000
-
-#ifdef CONFIG_HIGHMEM
-#define CONSISTENT_BASE		((PKMAP_BASE) - (SZ_2M))
-#define CONSISTENT_END		(PKMAP_BASE)
-#else
-#define CONSISTENT_BASE		(FIXADDR_START - SZ_2M)
-#define CONSISTENT_END		(FIXADDR_START)
-#endif
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-
-#ifdef CONFIG_HIGHMEM
-#ifndef __ASSEMBLY__
-#include <asm/highmem.h>
-#endif
-#endif
-
-#define VMALLOC_RESERVE 	SZ_128M
-#define VMALLOC_END		(CONSISTENT_BASE - PAGE_SIZE)
-#define VMALLOC_START		((VMALLOC_END) - VMALLOC_RESERVE)
-#define VMALLOC_VMADDR(x)	((unsigned long)(x))
-#define MAXMEM			__pa(VMALLOC_START)
-#define MAXMEM_PFN		PFN_DOWN(MAXMEM)
-
-#define FIRST_USER_PGD_NR	0
-#define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) + FIRST_USER_PGD_NR)
-
-/* L2 PTE */
-#define _PAGE_V			(1UL << 0)
-
-#define _PAGE_M_XKRW            (0UL << 1)
-#define _PAGE_M_UR_KR		(1UL << 1)
-#define _PAGE_M_UR_KRW		(2UL << 1)
-#define _PAGE_M_URW_KRW		(3UL << 1)
-#define _PAGE_M_KR		(5UL << 1)
-#define _PAGE_M_KRW		(7UL << 1)
-
-#define _PAGE_D			(1UL << 4)
-#define _PAGE_E			(1UL << 5)
-#define _PAGE_A			(1UL << 6)
-#define _PAGE_G			(1UL << 7)
-
-#define _PAGE_C_DEV		(0UL << 8)
-#define _PAGE_C_DEV_WB		(1UL << 8)
-#define _PAGE_C_MEM		(2UL << 8)
-#define _PAGE_C_MEM_SHRD_WB	(4UL << 8)
-#define _PAGE_C_MEM_SHRD_WT	(5UL << 8)
-#define _PAGE_C_MEM_WB		(6UL << 8)
-#define _PAGE_C_MEM_WT		(7UL << 8)
-
-#define _PAGE_L			(1UL << 11)
-
-#define _HAVE_PAGE_L		(_PAGE_L)
-#define _PAGE_FILE		(1UL << 1)
-#define _PAGE_YOUNG		0
-#define _PAGE_M_MASK		_PAGE_M_KRW
-#define _PAGE_C_MASK		_PAGE_C_MEM_WT
-
-#ifdef CONFIG_SMP
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_SHRD_WT
-#else
-#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_SHRD_WB
-#endif
-#else
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_WT
-#else
-#define _PAGE_CACHE_SHRD	_PAGE_C_MEM_WB
-#endif
-#endif
-
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-#define _PAGE_CACHE		_PAGE_C_MEM_WT
-#else
-#define _PAGE_CACHE		_PAGE_C_MEM_WB
-#endif
-
-#define _PAGE_IOREMAP \
-	(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
-
-/*
- * + Level 1 descriptor (PMD)
- */
-#define PMD_TYPE_TABLE		0
-
-#ifndef __ASSEMBLY__
-
-#define _PAGE_USER_TABLE     PMD_TYPE_TABLE
-#define _PAGE_KERNEL_TABLE   PMD_TYPE_TABLE
-
-#define PAGE_EXEC	__pgprot(_PAGE_V | _PAGE_M_XKRW | _PAGE_E)
-#define PAGE_NONE	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_A)
-#define PAGE_READ	__pgprot(_PAGE_V | _PAGE_M_UR_KR)
-#define PAGE_RDWR	__pgprot(_PAGE_V | _PAGE_M_URW_KRW | _PAGE_D)
-#define PAGE_COPY	__pgprot(_PAGE_V | _PAGE_M_UR_KR)
-
-#define PAGE_UXKRWX_V1	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
-#define PAGE_UXKRWX_V2	__pgprot(_PAGE_V | _PAGE_M_XKRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
-#define PAGE_URXKRWX_V2	__pgprot(_PAGE_V | _PAGE_M_UR_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
-#define PAGE_CACHE_L1	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE)
-#define PAGE_MEMORY	__pgprot(_HAVE_PAGE_L | _PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
-#define PAGE_KERNEL	__pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_E | _PAGE_G | _PAGE_CACHE_SHRD)
-#define PAGE_SHARED	__pgprot(_PAGE_V | _PAGE_M_URW_KRW | _PAGE_D | _PAGE_CACHE_SHRD)
-#define PAGE_DEVICE    __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
-#endif /* __ASSEMBLY__ */
-
-/*         xwr */
-#define __P000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __P001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __P010  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P011  (PAGE_COPY | _PAGE_CACHE_SHRD)
-#define __P100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __P101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P110  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __P111  (PAGE_COPY | _PAGE_E | _PAGE_CACHE_SHRD)
-
-#define __S000  (PAGE_NONE | _PAGE_CACHE_SHRD)
-#define __S001  (PAGE_READ | _PAGE_CACHE_SHRD)
-#define __S010  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S011  (PAGE_RDWR | _PAGE_CACHE_SHRD)
-#define __S100  (PAGE_EXEC | _PAGE_CACHE_SHRD)
-#define __S101  (PAGE_READ | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S110  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
-#define __S111  (PAGE_RDWR | _PAGE_E | _PAGE_CACHE_SHRD)
-
-#ifndef __ASSEMBLY__
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-extern struct page *empty_zero_page;
-extern void paging_init(void);
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
-
-#define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
-#define pfn_pte(pfn,prot)	(__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
-
-#define pte_none(pte)	        !(pte_val(pte))
-#define pte_clear(mm,addr,ptep)	set_pte_at((mm),(addr),(ptep), __pte(0))
-#define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
-
-static unsigned long pmd_page_vaddr(pmd_t pmd)
-{
-	return ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK));
-}
-
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-/*
- * Set a level 1 translation table entry, and clean it out of
- * any caches such that the MMUs can load it correctly.
- */
-static inline void set_pmd(pmd_t * pmdp, pmd_t pmd)
-{
-
-	*pmdp = pmd;
-#if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
-	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (pmdp):"memory");
-	__nds32__msync_all();
-	__nds32__dsb();
-#endif
-}
-
-/*
- * Set a PTE and flush it out
- */
-static inline void set_pte(pte_t * ptep, pte_t pte)
-{
-
-	*ptep = pte;
-#if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
-	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (ptep):"memory");
-	__nds32__msync_all();
-	__nds32__dsb();
-#endif
-}
-
-/*
- * The following only work if pte_present() is true.
- * Undefined behaviour if not..
- */
-
-/*
- * pte_write: 	     this page is writeable for user mode
- * pte_read:         this page is readable for user mode
- * pte_kernel_write: this page is writeable for kernel mode
- *
- * We don't have pte_kernel_read because kernel always can read.
- *
- * */
-
-#define pte_present(pte)        (pte_val(pte) & _PAGE_V)
-#define pte_write(pte)          ((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW)
-#define pte_read(pte)		(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KR) || \
-				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
-				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW))
-#define pte_kernel_write(pte)   (((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW) || \
-				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
-				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_KRW) || \
-				(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_XKRW) && pte_exec(pte)))
-#define pte_exec(pte)		(pte_val(pte) & _PAGE_E)
-#define pte_dirty(pte)		(pte_val(pte) & _PAGE_D)
-#define pte_young(pte)		(pte_val(pte) & _PAGE_YOUNG)
-
-/*
- * The following only works if pte_present() is not true.
- */
-#define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
-#define pte_to_pgoff(x)		(pte_val(x) >> 2)
-#define pgoff_to_pte(x)		__pte(((x) << 2) | _PAGE_FILE)
-
-#define PTE_FILE_MAX_BITS	29
-
-#define PTE_BIT_FUNC(fn,op) \
-static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
-
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
-	pte_val(pte) = pte_val(pte) | _PAGE_M_UR_KR;
-	return pte;
-}
-
-static inline pte_t pte_mkwrite(pte_t pte)
-{
-	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
-	pte_val(pte) = pte_val(pte) | _PAGE_M_URW_KRW;
-	return pte;
-}
-
-PTE_BIT_FUNC(exprotect, &=~_PAGE_E);
-PTE_BIT_FUNC(mkexec, |=_PAGE_E);
-PTE_BIT_FUNC(mkclean, &=~_PAGE_D);
-PTE_BIT_FUNC(mkdirty, |=_PAGE_D);
-PTE_BIT_FUNC(mkold, &=~_PAGE_YOUNG);
-PTE_BIT_FUNC(mkyoung, |=_PAGE_YOUNG);
-
-/*
- * Mark the prot value as uncacheable and unbufferable.
- */
-#define pgprot_noncached(prot)	   __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV)
-#define pgprot_writecombine(prot)  __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV_WB)
-
-#define pmd_none(pmd)         (pmd_val(pmd)&0x1)
-#define pmd_present(pmd)      (!pmd_none(pmd))
-#define	pmd_bad(pmd)	      pmd_none(pmd)
-
-#define copy_pmd(pmdpd,pmdps)	set_pmd((pmdpd), *(pmdps))
-#define pmd_clear(pmdp)		set_pmd((pmdp), __pmd(1))
-
-static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
-{
-	unsigned long ptr = (unsigned long)ptep;
-	pmd_t pmd;
-
-	/*
-	 * The pmd must be loaded with the physical
-	 * address of the PTE table
-	 */
-
-	pmd_val(pmd) = __virt_to_phys(ptr) | prot;
-	return pmd;
-}
-
-#define pmd_page(pmd)        virt_to_page(__va(pmd_val(pmd)))
-
-/*
- * Permanent address of a page. We never have highmem, so this is trivial.
- */
-#define pages_to_mb(x)       ((x) >> (20 - PAGE_SHIFT))
-
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
-
-/*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
- * into the pgd entry)
- */
-#define pgd_none(pgd)		(0)
-#define pgd_bad(pgd)		(0)
-#define pgd_present(pgd)  	(1)
-#define pgd_clear(pgdp)		do { } while (0)
-
-#define page_pte_prot(page,prot)     	mk_pte(page, prot)
-#define page_pte(page)		        mk_pte(page, __pgprot(0))
-/*
- *     L1PTE = $mr1 + ((virt >> PMD_SHIFT) << 2);
- *     L2PTE = (((virt >> PAGE_SHIFT) & (PTRS_PER_PTE -1 )) << 2);
- *     PPN = (phys & 0xfffff000);
- *
-*/
-
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{
-	const unsigned long mask = 0xfff;
-	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
-	return pte;
-}
-
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-
-/* Encode and decode a swap entry.
- *
- * We support up to 32GB of swap on 4k machines
- */
-#define __swp_type(x)	 	     (((x).val >> 2) & 0x7f)
-#define __swp_offset(x)	   	     ((x).val >> 9)
-#define __swp_entry(type,offset)     ((swp_entry_t) { ((type) << 2) | ((offset) << 9) })
-#define __pte_to_swp_entry(pte)	     ((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(swp)	     ((pte_t) { (swp).val })
-
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr)	(1)
-
-/*
- * We provide our own arch_get_unmapped_area to cope with VIPT caches.
- */
-#define HAVE_ARCH_UNMAPPED_AREA
-
-/*
- * remap a physical address `phys' of size `size' with page protection `prot'
- * into virtual address `from'
- */
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* _ASMNDS32_PGTABLE_H */
diff --git a/arch/nds32/include/asm/pmu.h b/arch/nds32/include/asm/pmu.h
deleted file mode 100644
index e1ac0b0b8bcf..000000000000
--- a/arch/nds32/include/asm/pmu.h
+++ /dev/null
@@ -1,386 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2008-2018 Andes Technology Corporation */
-
-#ifndef __ASM_PMU_H
-#define __ASM_PMU_H
-
-#include <linux/interrupt.h>
-#include <linux/perf_event.h>
-#include <asm/unistd.h>
-#include <asm/bitfield.h>
-
-/* Has special meaning for perf core implementation */
-#define HW_OP_UNSUPPORTED		0x0
-#define C(_x)				PERF_COUNT_HW_CACHE_##_x
-#define CACHE_OP_UNSUPPORTED		0x0
-
-/* Enough for both software and hardware defined events */
-#define SOFTWARE_EVENT_MASK		0xFF
-
-#define PFM_OFFSET_MAGIC_0		2	/* DO NOT START FROM 0 */
-#define PFM_OFFSET_MAGIC_1		(PFM_OFFSET_MAGIC_0 + 36)
-#define PFM_OFFSET_MAGIC_2		(PFM_OFFSET_MAGIC_1 + 36)
-
-enum { PFMC0, PFMC1, PFMC2, MAX_COUNTERS };
-
-u32 PFM_CTL_OVF[3] = { PFM_CTL_mskOVF0, PFM_CTL_mskOVF1,
-		       PFM_CTL_mskOVF2 };
-u32 PFM_CTL_EN[3] = { PFM_CTL_mskEN0, PFM_CTL_mskEN1,
-		      PFM_CTL_mskEN2 };
-u32 PFM_CTL_OFFSEL[3] = { PFM_CTL_offSEL0, PFM_CTL_offSEL1,
-			  PFM_CTL_offSEL2 };
-u32 PFM_CTL_IE[3] = { PFM_CTL_mskIE0, PFM_CTL_mskIE1, PFM_CTL_mskIE2 };
-u32 PFM_CTL_KS[3] = { PFM_CTL_mskKS0, PFM_CTL_mskKS1, PFM_CTL_mskKS2 };
-u32 PFM_CTL_KU[3] = { PFM_CTL_mskKU0, PFM_CTL_mskKU1, PFM_CTL_mskKU2 };
-u32 PFM_CTL_SEL[3] = { PFM_CTL_mskSEL0, PFM_CTL_mskSEL1, PFM_CTL_mskSEL2 };
-/*
- * Perf Events' indices
- */
-#define NDS32_IDX_CYCLE_COUNTER			0
-#define NDS32_IDX_COUNTER0			1
-#define NDS32_IDX_COUNTER1			2
-
-/* The events for a given PMU register set. */
-struct pmu_hw_events {
-	/*
-	 * The events that are active on the PMU for the given index.
-	 */
-	struct perf_event *events[MAX_COUNTERS];
-
-	/*
-	 * A 1 bit for an index indicates that the counter is being used for
-	 * an event. A 0 means that the counter can be used.
-	 */
-	unsigned long used_mask[BITS_TO_LONGS(MAX_COUNTERS)];
-
-	/*
-	 * Hardware lock to serialize accesses to PMU registers. Needed for the
-	 * read/modify/write sequences.
-	 */
-	raw_spinlock_t pmu_lock;
-};
-
-struct nds32_pmu {
-	struct pmu pmu;
-	cpumask_t active_irqs;
-	char *name;
-	 irqreturn_t (*handle_irq)(int irq_num, void *dev);
-	void (*enable)(struct perf_event *event);
-	void (*disable)(struct perf_event *event);
-	int (*get_event_idx)(struct pmu_hw_events *hw_events,
-			     struct perf_event *event);
-	int (*set_event_filter)(struct hw_perf_event *evt,
-				struct perf_event_attr *attr);
-	u32 (*read_counter)(struct perf_event *event);
-	void (*write_counter)(struct perf_event *event, u32 val);
-	void (*start)(struct nds32_pmu *nds32_pmu);
-	void (*stop)(struct nds32_pmu *nds32_pmu);
-	void (*reset)(void *data);
-	int (*request_irq)(struct nds32_pmu *nds32_pmu, irq_handler_t handler);
-	void (*free_irq)(struct nds32_pmu *nds32_pmu);
-	int (*map_event)(struct perf_event *event);
-	int num_events;
-	atomic_t active_events;
-	u64 max_period;
-	struct platform_device *plat_device;
-	struct pmu_hw_events *(*get_hw_events)(void);
-};
-
-#define to_nds32_pmu(p)			(container_of(p, struct nds32_pmu, pmu))
-
-int nds32_pmu_register(struct nds32_pmu *nds32_pmu, int type);
-
-u64 nds32_pmu_event_update(struct perf_event *event);
-
-int nds32_pmu_event_set_period(struct perf_event *event);
-
-/*
- * Common NDS32 SPAv3 event types
- *
- * Note: An implementation may not be able to count all of these events
- * but the encodings are considered to be `reserved' in the case that
- * they are not available.
- *
- * SEL_TOTAL_CYCLES will add an offset is due to ZERO is defined as
- * NOT_SUPPORTED EVENT mapping in generic perf code.
- * You will need to deal it in the event writing implementation.
- */
-enum spav3_counter_0_perf_types {
-	SPAV3_0_SEL_BASE = -1 + PFM_OFFSET_MAGIC_0,	/* counting symbol */
-	SPAV3_0_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_0,
-	SPAV3_0_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_0,
-	SPAV3_0_SEL_LAST	/* counting symbol */
-};
-
-enum spav3_counter_1_perf_types {
-	SPAV3_1_SEL_BASE = -1 + PFM_OFFSET_MAGIC_1,	/* counting symbol */
-	SPAV3_1_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_CONDITIONAL_BRANCH = 2 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_TAKEN_CONDITIONAL_BRANCH = 3 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_PREFETCH_INSTRUCTION = 4 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_RET_INST = 5 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_JR_INST = 6 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_JAL_JRAL_INST = 7 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_NOP_INST = 8 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_SCW_INST = 9 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_ISB_DSB_INST = 10 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_CCTL_INST = 11 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_TAKEN_INTERRUPTS = 12 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_LOADS_COMPLETED = 13 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_UITLB_ACCESS = 14 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_UDTLB_ACCESS = 15 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_MTLB_ACCESS = 16 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_CODE_CACHE_ACCESS = 17 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_DATA_DEPENDENCY_STALL_CYCLES = 18 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_DATA_CACHE_MISS_STALL_CYCLES = 19 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_DATA_CACHE_ACCESS = 20 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_DATA_CACHE_MISS = 21 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_LOAD_DATA_CACHE_ACCESS = 22 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_STORE_DATA_CACHE_ACCESS = 23 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_ILM_ACCESS = 24 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_LSU_BIU_CYCLES = 25 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_HPTWK_BIU_CYCLES = 26 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_DMA_BIU_CYCLES = 27 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_CODE_CACHE_FILL_BIU_CYCLES = 28 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_LEGAL_UNALIGN_DCACHE_ACCESS = 29 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_PUSH25 = 30 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_SYSCALLS_INST = 31 + PFM_OFFSET_MAGIC_1,
-	SPAV3_1_SEL_LAST	/* counting symbol */
-};
-
-enum spav3_counter_2_perf_types {
-	SPAV3_2_SEL_BASE = -1 + PFM_OFFSET_MAGIC_2,	/* counting symbol */
-	SPAV3_2_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_CONDITIONAL_BRANCH_MISPREDICT = 2 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_TAKEN_CONDITIONAL_BRANCH_MISPREDICT =
-	    3 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_PREFETCH_INSTRUCTION_CACHE_HIT = 4 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_RET_MISPREDICT = 5 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_IMMEDIATE_J_INST = 6 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_MULTIPLY_INST = 7 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_16_BIT_INST = 8 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_FAILED_SCW_INST = 9 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_LD_AFTER_ST_CONFLICT_REPLAYS = 10 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_TAKEN_EXCEPTIONS = 12 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_STORES_COMPLETED = 13 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_UITLB_MISS = 14 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_UDTLB_MISS = 15 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_MTLB_MISS = 16 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_CODE_CACHE_MISS = 17 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_EMPTY_INST_QUEUE_STALL_CYCLES = 18 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_DATA_WRITE_BACK = 19 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_DATA_CACHE_MISS = 21 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_LOAD_DATA_CACHE_MISS = 22 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_STORE_DATA_CACHE_MISS = 23 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_DLM_ACCESS = 24 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_LSU_BIU_REQUEST = 25 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_HPTWK_BIU_REQUEST = 26 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_DMA_BIU_REQUEST = 27 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_CODE_CACHE_FILL_BIU_REQUEST = 28 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_EXTERNAL_EVENTS = 29 + PFM_OFFSET_MAGIC_2,
-	SPAV3_1_SEL_POP25 = 30 + PFM_OFFSET_MAGIC_2,
-	SPAV3_2_SEL_LAST	/* counting symbol */
-};
-
-/* Get converted event counter index */
-static inline int get_converted_event_idx(unsigned long event)
-{
-	int idx;
-
-	if ((event) > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST) {
-		idx = 0;
-	} else if ((event) > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST) {
-		idx = 1;
-	} else if ((event) > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST) {
-		idx = 2;
-	} else {
-		pr_err("GET_CONVERTED_EVENT_IDX PFM counter range error\n");
-		return -EPERM;
-	}
-
-	return idx;
-}
-
-/* Get converted hardware event number */
-static inline u32 get_converted_evet_hw_num(u32 event)
-{
-	if (event > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST)
-		event -= PFM_OFFSET_MAGIC_0;
-	else if (event > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST)
-		event -= PFM_OFFSET_MAGIC_1;
-	else if (event > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST)
-		event -= PFM_OFFSET_MAGIC_2;
-	else if (event != 0)
-		pr_err("GET_CONVERTED_EVENT_HW_NUM PFM counter range error\n");
-
-	return event;
-}
-
-/*
- * NDS32 HW events mapping
- *
- * The hardware events that we support. We do support cache operations but
- * we have harvard caches and no way to combine instruction and data
- * accesses/misses in hardware.
- */
-static const unsigned int nds32_pfm_perf_map[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = SPAV3_0_SEL_TOTAL_CYCLES,
-	[PERF_COUNT_HW_INSTRUCTIONS] = SPAV3_1_SEL_COMPLETED_INSTRUCTION,
-	[PERF_COUNT_HW_CACHE_REFERENCES] = SPAV3_1_SEL_DATA_CACHE_ACCESS,
-	[PERF_COUNT_HW_CACHE_MISSES] = SPAV3_2_SEL_DATA_CACHE_MISS,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_BRANCH_MISSES] = HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_BUS_CYCLES] = HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = HW_OP_UNSUPPORTED,
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = HW_OP_UNSUPPORTED
-};
-
-static const unsigned int nds32_pfm_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
-	[PERF_COUNT_HW_CACHE_OP_MAX]
-	[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
-	[C(L1D)] = {
-		    [C(OP_READ)] = {
-				    [C(RESULT_ACCESS)] =
-				    SPAV3_1_SEL_LOAD_DATA_CACHE_ACCESS,
-				    [C(RESULT_MISS)] =
-				    SPAV3_2_SEL_LOAD_DATA_CACHE_MISS,
-				    },
-		    [C(OP_WRITE)] = {
-				     [C(RESULT_ACCESS)] =
-				     SPAV3_1_SEL_STORE_DATA_CACHE_ACCESS,
-				     [C(RESULT_MISS)] =
-				     SPAV3_2_SEL_STORE_DATA_CACHE_MISS,
-				     },
-		    [C(OP_PREFETCH)] = {
-					[C(RESULT_ACCESS)] =
-						CACHE_OP_UNSUPPORTED,
-					[C(RESULT_MISS)] =
-						CACHE_OP_UNSUPPORTED,
-					},
-		    },
-	[C(L1I)] = {
-		    [C(OP_READ)] = {
-				    [C(RESULT_ACCESS)] =
-				    SPAV3_1_SEL_CODE_CACHE_ACCESS,
-				    [C(RESULT_MISS)] =
-				    SPAV3_2_SEL_CODE_CACHE_MISS,
-				    },
-		    [C(OP_WRITE)] = {
-				     [C(RESULT_ACCESS)] =
-				     SPAV3_1_SEL_CODE_CACHE_ACCESS,
-				     [C(RESULT_MISS)] =
-				     SPAV3_2_SEL_CODE_CACHE_MISS,
-				     },
-		    [C(OP_PREFETCH)] = {
-					[C(RESULT_ACCESS)] =
-					CACHE_OP_UNSUPPORTED,
-					[C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-					},
-		    },
-	/* TODO: L2CC */
-	[C(LL)] = {
-		   [C(OP_READ)] = {
-				   [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
-				   [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				   },
-		   [C(OP_WRITE)] = {
-				    [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
-				    [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				    },
-		   [C(OP_PREFETCH)] = {
-				       [C(RESULT_ACCESS)] =
-				       CACHE_OP_UNSUPPORTED,
-				       [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				       },
-		   },
-	/* NDS32 PMU does not support TLB read/write hit/miss,
-	 * However, it can count access/miss, which mixed with read and write.
-	 * Therefore, only READ counter will use it.
-	 * We do as possible as we can.
-	 */
-	[C(DTLB)] = {
-		     [C(OP_READ)] = {
-				     [C(RESULT_ACCESS)] =
-					SPAV3_1_SEL_UDTLB_ACCESS,
-				     [C(RESULT_MISS)] =
-					SPAV3_2_SEL_UDTLB_MISS,
-				     },
-		     [C(OP_WRITE)] = {
-				      [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
-				      [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				      },
-		     [C(OP_PREFETCH)] = {
-					 [C(RESULT_ACCESS)] =
-					 CACHE_OP_UNSUPPORTED,
-					 [C(RESULT_MISS)] =
-					 CACHE_OP_UNSUPPORTED,
-					 },
-		     },
-	[C(ITLB)] = {
-		     [C(OP_READ)] = {
-				     [C(RESULT_ACCESS)] =
-					SPAV3_1_SEL_UITLB_ACCESS,
-				     [C(RESULT_MISS)] =
-					SPAV3_2_SEL_UITLB_MISS,
-				     },
-		     [C(OP_WRITE)] = {
-				      [C(RESULT_ACCESS)] =
-					CACHE_OP_UNSUPPORTED,
-				      [C(RESULT_MISS)] =
-					CACHE_OP_UNSUPPORTED,
-				      },
-		     [C(OP_PREFETCH)] = {
-					 [C(RESULT_ACCESS)] =
-						CACHE_OP_UNSUPPORTED,
-					 [C(RESULT_MISS)] =
-						CACHE_OP_UNSUPPORTED,
-					 },
-		     },
-	[C(BPU)] = {		/* What is BPU? */
-		    [C(OP_READ)] = {
-				    [C(RESULT_ACCESS)] =
-					CACHE_OP_UNSUPPORTED,
-				    [C(RESULT_MISS)] =
-					CACHE_OP_UNSUPPORTED,
-				    },
-		    [C(OP_WRITE)] = {
-				     [C(RESULT_ACCESS)] =
-					CACHE_OP_UNSUPPORTED,
-				     [C(RESULT_MISS)] =
-					CACHE_OP_UNSUPPORTED,
-				     },
-		    [C(OP_PREFETCH)] = {
-					[C(RESULT_ACCESS)] =
-						CACHE_OP_UNSUPPORTED,
-					[C(RESULT_MISS)] =
-						CACHE_OP_UNSUPPORTED,
-					},
-		    },
-	[C(NODE)] = {		/* What is NODE? */
-		     [C(OP_READ)] = {
-				     [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
-				     [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				     },
-		     [C(OP_WRITE)] = {
-				      [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
-				      [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
-				      },
-		     [C(OP_PREFETCH)] = {
-					 [C(RESULT_ACCESS)] =
-						CACHE_OP_UNSUPPORTED,
-					 [C(RESULT_MISS)] =
-						CACHE_OP_UNSUPPORTED,
-					 },
-		     },
-};
-
-int nds32_pmu_map_event(struct perf_event *event,
-			const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
-			const unsigned int (*cache_map)[PERF_COUNT_HW_CACHE_MAX]
-			[PERF_COUNT_HW_CACHE_OP_MAX]
-			[PERF_COUNT_HW_CACHE_RESULT_MAX], u32 raw_event_mask);
-
-#endif /* __ASM_PMU_H */
diff --git a/arch/nds32/include/asm/proc-fns.h b/arch/nds32/include/asm/proc-fns.h
deleted file mode 100644
index 27c617fa77af..000000000000
--- a/arch/nds32/include/asm/proc-fns.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_PROCFNS_H__
-#define __NDS32_PROCFNS_H__
-
-#ifdef __KERNEL__
-#include <asm/page.h>
-
-struct mm_struct;
-struct vm_area_struct;
-extern void cpu_proc_init(void);
-extern void cpu_proc_fin(void);
-extern void cpu_do_idle(void);
-extern void cpu_reset(unsigned long reset);
-extern void cpu_switch_mm(struct mm_struct *mm);
-
-extern void cpu_dcache_inval_all(void);
-extern void cpu_dcache_wbinval_all(void);
-extern void cpu_dcache_inval_page(unsigned long page);
-extern void cpu_dcache_wb_page(unsigned long page);
-extern void cpu_dcache_wbinval_page(unsigned long page);
-extern void cpu_dcache_inval_range(unsigned long start, unsigned long end);
-extern void cpu_dcache_wb_range(unsigned long start, unsigned long end);
-extern void cpu_dcache_wbinval_range(unsigned long start, unsigned long end);
-
-extern void cpu_icache_inval_all(void);
-extern void cpu_icache_inval_page(unsigned long page);
-extern void cpu_icache_inval_range(unsigned long start, unsigned long end);
-
-extern void cpu_cache_wbinval_page(unsigned long page, int flushi);
-extern void cpu_cache_wbinval_range(unsigned long start,
-				    unsigned long end, int flushi);
-extern void cpu_cache_wbinval_range_check(struct vm_area_struct *vma,
-					  unsigned long start,
-					  unsigned long end, bool flushi,
-					  bool wbd);
-
-extern void cpu_dma_wb_range(unsigned long start, unsigned long end);
-extern void cpu_dma_inval_range(unsigned long start, unsigned long end);
-extern void cpu_dma_wbinval_range(unsigned long start, unsigned long end);
-
-#endif /* __KERNEL__ */
-#endif /* __NDS32_PROCFNS_H__ */
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
deleted file mode 100644
index e6bfc74972bb..000000000000
--- a/arch/nds32/include/asm/processor.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_PROCESSOR_H
-#define __ASM_NDS32_PROCESSOR_H
-
-#ifdef __KERNEL__
-
-#include <asm/ptrace.h>
-#include <asm/types.h>
-#include <asm/sigcontext.h>
-
-#define KERNEL_STACK_SIZE	PAGE_SIZE
-#define STACK_TOP	TASK_SIZE
-#define STACK_TOP_MAX   TASK_SIZE
-
-struct cpu_context {
-	unsigned long r6;
-	unsigned long r7;
-	unsigned long r8;
-	unsigned long r9;
-	unsigned long r10;
-	unsigned long r11;
-	unsigned long r12;
-	unsigned long r13;
-	unsigned long r14;
-	unsigned long fp;
-	unsigned long pc;
-	unsigned long sp;
-};
-
-struct thread_struct {
-	struct cpu_context cpu_context;	/* cpu context */
-	/* fault info     */
-	unsigned long address;
-	unsigned long trap_no;
-	unsigned long error_code;
-
-	struct fpu_struct fpu;
-};
-
-#define INIT_THREAD  {	}
-
-#ifdef __NDS32_EB__
-#define PSW_DE	PSW_mskBE
-#else
-#define PSW_DE	0x0
-#endif
-
-#ifdef CONFIG_WBNA
-#define PSW_valWBNA	PSW_mskWBNA
-#else
-#define PSW_valWBNA	0x0
-#endif
-
-#ifdef CONFIG_HWZOL
-#define	PSW_valINIT (PSW_CPL_ANY | PSW_mskAEN | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_mskGIE)
-#else
-#define	PSW_valINIT (PSW_CPL_ANY | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_mskGIE)
-#endif
-
-#define start_thread(regs,pc,stack)			\
-({							\
-	memzero(regs, sizeof(struct pt_regs));		\
-	forget_syscall(regs);				\
-	regs->ipsw = PSW_valINIT;			\
-	regs->ir0 = (PSW_CPL_ANY | PSW_valWBNA | PSW_mskDT | PSW_mskIT | PSW_DE | PSW_SYSTEM | PSW_INTL_1);	\
-	regs->ipc = pc;					\
-	regs->sp = stack;				\
-})
-
-/* Forward declaration, a strange C thing */
-struct task_struct;
-
-/* Free all resources held by a thread. */
-#define release_thread(thread) do { } while(0)
-#if IS_ENABLED(CONFIG_FPU)
-#if !IS_ENABLED(CONFIG_UNLAZU_FPU)
-extern struct task_struct *last_task_used_math;
-#endif
-#endif
-
-/* Prepare to copy thread state - unlazy all lazy status */
-#define prepare_to_copy(tsk)	do { } while (0)
-
-unsigned long __get_wchan(struct task_struct *p);
-
-#define cpu_relax()			barrier()
-
-#define task_pt_regs(task) \
-	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
-		- 8) - 1)
-
-/*
- * Create a new kernel thread
- */
-extern int kernel_thread(int (*fn) (void *), void *arg, unsigned long flags);
-
-#define KSTK_EIP(tsk)	instruction_pointer(task_pt_regs(tsk))
-#define KSTK_ESP(tsk)	user_stack_pointer(task_pt_regs(tsk))
-
-#endif
-
-#endif /* __ASM_NDS32_PROCESSOR_H */
diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
deleted file mode 100644
index 919ee223620c..000000000000
--- a/arch/nds32/include/asm/ptrace.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_PTRACE_H
-#define __ASM_NDS32_PTRACE_H
-
-#include <uapi/asm/ptrace.h>
-
-/*
- * If pt_regs.syscallno == NO_SYSCALL, then the thread is not executing
- * a syscall -- i.e., its most recent entry into the kernel from
- * userspace was not via syscall, or otherwise a tracer cancelled the
- * syscall.
- *
- * This must have the value -1, for ABI compatibility with ptrace etc.
- */
-#define NO_SYSCALL (-1)
-#ifndef __ASSEMBLY__
-#include <linux/types.h>
-
-struct pt_regs {
-	union {
-		struct user_pt_regs user_regs;
-		struct {
-			long uregs[26];
-			long fp;
-			long gp;
-			long lp;
-			long sp;
-			long ipc;
-#if defined(CONFIG_HWZOL)
-			long lb;
-			long le;
-			long lc;
-#else
-			long dummy[3];
-#endif
-			long syscallno;
-		};
-	};
-	long orig_r0;
-	long ir0;
-	long ipsw;
-	long pipsw;
-	long pipc;
-	long pp0;
-	long pp1;
-	long fucop_ctl;
-	long osp;
-};
-
-static inline bool in_syscall(struct pt_regs const *regs)
-{
-	return regs->syscallno != NO_SYSCALL;
-}
-
-static inline void forget_syscall(struct pt_regs *regs)
-{
-	regs->syscallno = NO_SYSCALL;
-}
-static inline unsigned long regs_return_value(struct pt_regs *regs)
-{
-	return regs->uregs[0];
-}
-extern void show_regs(struct pt_regs *);
-/* Avoid circular header include via sched.h */
-struct task_struct;
-
-#define arch_has_single_step()		(1)
-#define user_mode(regs)			(((regs)->ipsw & PSW_mskPOM) == 0)
-#define interrupts_enabled(regs)	(!!((regs)->ipsw & PSW_mskGIE))
-#define user_stack_pointer(regs)	((regs)->sp)
-#define instruction_pointer(regs)	((regs)->ipc)
-#define profile_pc(regs) 		instruction_pointer(regs)
-
-#endif /* __ASSEMBLY__ */
-#endif
diff --git a/arch/nds32/include/asm/sfp-machine.h b/arch/nds32/include/asm/sfp-machine.h
deleted file mode 100644
index b1a5caa332b5..000000000000
--- a/arch/nds32/include/asm/sfp-machine.h
+++ /dev/null
@@ -1,158 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2005-2018 Andes Technology Corporation */
-
-#include <asm/bitfield.h>
-
-#define _FP_W_TYPE_SIZE		32
-#define _FP_W_TYPE		unsigned long
-#define _FP_WS_TYPE		signed long
-#define _FP_I_TYPE		long
-
-#define __ll_B ((UWtype) 1 << (W_TYPE_SIZE / 2))
-#define __ll_lowpart(t) ((UWtype) (t) & (__ll_B - 1))
-#define __ll_highpart(t) ((UWtype) (t) >> (W_TYPE_SIZE / 2))
-
-#define _FP_MUL_MEAT_S(R, X, Y)				\
-	_FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
-#define _FP_MUL_MEAT_D(R, X, Y)				\
-	_FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
-#define _FP_MUL_MEAT_Q(R, X, Y)				\
-	_FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
-
-#define _FP_MUL_MEAT_DW_S(R, X, Y)			\
-	_FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
-#define _FP_MUL_MEAT_DW_D(R, X, Y)			\
-	_FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
-
-#define _FP_DIV_MEAT_S(R, X, Y)	_FP_DIV_MEAT_1_udiv_norm(S, R, X, Y)
-#define _FP_DIV_MEAT_D(R, X, Y)	_FP_DIV_MEAT_2_udiv(D, R, X, Y)
-
-#define _FP_NANFRAC_S		((_FP_QNANBIT_S << 1) - 1)
-#define _FP_NANFRAC_D		((_FP_QNANBIT_D << 1) - 1), -1
-#define _FP_NANFRAC_Q		((_FP_QNANBIT_Q << 1) - 1), -1, -1, -1
-#define _FP_NANSIGN_S		0
-#define _FP_NANSIGN_D		0
-#define _FP_NANSIGN_Q		0
-
-#define _FP_KEEPNANFRACP 1
-#define _FP_QNANNEGATEDP 0
-
-#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)			\
-do {								\
-	if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs)	\
-	  && !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs)) { \
-		R##_s = Y##_s;					\
-		_FP_FRAC_COPY_##wc(R, Y);			\
-	} else {						\
-		R##_s = X##_s;					\
-		_FP_FRAC_COPY_##wc(R, X);			\
-	}							\
-	R##_c = FP_CLS_NAN;					\
-} while (0)
-
-#define __FPU_FPCSR	(current->thread.fpu.fpcsr)
-
-/* Obtain the current rounding mode. */
-#define FP_ROUNDMODE                    \
-({                                      \
-	__FPU_FPCSR & FPCSR_mskRM;      \
-})
-
-#define FP_RND_NEAREST		0
-#define FP_RND_PINF		1
-#define FP_RND_MINF		2
-#define FP_RND_ZERO		3
-
-#define FP_EX_INVALID		FPCSR_mskIVO
-#define FP_EX_DIVZERO		FPCSR_mskDBZ
-#define FP_EX_OVERFLOW		FPCSR_mskOVF
-#define FP_EX_UNDERFLOW		FPCSR_mskUDF
-#define FP_EX_INEXACT		FPCSR_mskIEX
-
-#define SF_CEQ	2
-#define SF_CLT	1
-#define SF_CGT	3
-#define SF_CUN	4
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN__
-#define __BYTE_ORDER __BIG_ENDIAN
-#define __LITTLE_ENDIAN 0
-#else
-#define __BYTE_ORDER __LITTLE_ENDIAN
-#define __BIG_ENDIAN 0
-#endif
-
-#define abort() do { } while (0)
-#define umul_ppmm(w1, w0, u, v)						\
-do {									\
-	UWtype __x0, __x1, __x2, __x3;                                  \
-	UHWtype __ul, __vl, __uh, __vh;                                 \
-									\
-	__ul = __ll_lowpart(u);						\
-	__uh = __ll_highpart(u);					\
-	__vl = __ll_lowpart(v);						\
-	__vh = __ll_highpart(v);					\
-									\
-	__x0 = (UWtype) __ul * __vl;                                    \
-	__x1 = (UWtype) __ul * __vh;                                    \
-	__x2 = (UWtype) __uh * __vl;                                    \
-	__x3 = (UWtype) __uh * __vh;                                    \
-									\
-	__x1 += __ll_highpart(__x0);					\
-	__x1 += __x2;							\
-	if (__x1 < __x2)						\
-		__x3 += __ll_B;						\
-									\
-	(w1) = __x3 + __ll_highpart(__x1);				\
-	(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);	\
-} while (0)
-
-#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
-do { \
-	UWtype __x; \
-	__x = (al) + (bl); \
-	(sh) = (ah) + (bh) + (__x < (al)); \
-	(sl) = __x; \
-} while (0)
-
-#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
-do { \
-	UWtype __x; \
-	__x = (al) - (bl); \
-	(sh) = (ah) - (bh) - (__x > (al)); \
-	(sl) = __x; \
-} while (0)
-
-#define udiv_qrnnd(q, r, n1, n0, d)				\
-do {								\
-	UWtype __d1, __d0, __q1, __q0, __r1, __r0, __m;		\
-	__d1 = __ll_highpart(d);				\
-	__d0 = __ll_lowpart(d);					\
-								\
-	__r1 = (n1) % __d1;					\
-	__q1 = (n1) / __d1;					\
-	__m = (UWtype) __q1 * __d0;				\
-	__r1 = __r1 * __ll_B | __ll_highpart(n0);		\
-	if (__r1 < __m)	{					\
-		__q1--, __r1 += (d);				\
-		if (__r1 >= (d))				\
-			if (__r1 < __m)				\
-				__q1--, __r1 += (d);		\
-	}							\
-	__r1 -= __m;						\
-	__r0 = __r1 % __d1;					\
-	__q0 = __r1 / __d1;					\
-	__m = (UWtype) __q0 * __d0;				\
-	__r0 = __r0 * __ll_B | __ll_lowpart(n0);		\
-	if (__r0 < __m)	{					\
-		__q0--, __r0 += (d);				\
-		if (__r0 >= (d))				\
-			if (__r0 < __m)				\
-				__q0--, __r0 += (d);		\
-	}							\
-	__r0 -= __m;						\
-	(q) = (UWtype) __q1 * __ll_B | __q0;			\
-	(r) = __r0;						\
-} while (0)
diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
deleted file mode 100644
index 3aeee946973d..000000000000
--- a/arch/nds32/include/asm/shmparam.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMNDS32_SHMPARAM_H
-#define _ASMNDS32_SHMPARAM_H
-
-/*
- * This should be the size of the virtually indexed cache/ways,
- * whichever is greater since the cache aliases every size/ways
- * bytes.
- */
-#define	SHMLBA	(4 * SZ_8K)	/* attach addr a multiple of this */
-
-/*
- * Enforce SHMLBA in shmat
- */
-#define __ARCH_FORCE_SHMLBA
-
-#endif /* _ASMNDS32_SHMPARAM_H */
diff --git a/arch/nds32/include/asm/stacktrace.h b/arch/nds32/include/asm/stacktrace.h
deleted file mode 100644
index 6bf7c777bda4..000000000000
--- a/arch/nds32/include/asm/stacktrace.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2008-2018 Andes Technology Corporation */
-
-#ifndef __ASM_STACKTRACE_H
-#define __ASM_STACKTRACE_H
-
-/* Kernel callchain */
-struct stackframe {
-	unsigned long fp;
-	unsigned long sp;
-	unsigned long lp;
-};
-
-/*
- * struct frame_tail: User callchain
- * IMPORTANT:
- * This struct is used for call-stack walking,
- * the order and types matters.
- * Do not use array, it only stores sizeof(pointer)
- *
- * The details can refer to arch/arm/kernel/perf_event.c
- */
-struct frame_tail {
-	unsigned long stack_fp;
-	unsigned long stack_lp;
-};
-
-/* For User callchain with optimize for size */
-struct frame_tail_opt_size {
-	unsigned long stack_r6;
-	unsigned long stack_fp;
-	unsigned long stack_gp;
-	unsigned long stack_lp;
-};
-
-extern void
-get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph);
-
-#endif /* __ASM_STACKTRACE_H */
diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
deleted file mode 100644
index cae8fe16de98..000000000000
--- a/arch/nds32/include/asm/string.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_STRING_H
-#define __ASM_NDS32_STRING_H
-
-#define __HAVE_ARCH_MEMCPY
-extern void *memcpy(void *, const void *, __kernel_size_t);
-
-#define __HAVE_ARCH_MEMMOVE
-extern void *memmove(void *, const void *, __kernel_size_t);
-
-#define __HAVE_ARCH_MEMSET
-extern void *memset(void *, int, __kernel_size_t);
-
-extern void *memzero(void *ptr, __kernel_size_t n);
-#endif
diff --git a/arch/nds32/include/asm/suspend.h b/arch/nds32/include/asm/suspend.h
deleted file mode 100644
index 6ed2418af1ac..000000000000
--- a/arch/nds32/include/asm/suspend.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2008-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_SUSPEND_H
-#define __ASM_NDS32_SUSPEND_H
-
-extern void suspend2ram(void);
-extern void cpu_resume(void);
-extern unsigned long wake_mask;
-
-#endif
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
deleted file mode 100644
index 362a466f2976..000000000000
--- a/arch/nds32/include/asm/swab.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_SWAB_H__
-#define __NDS32_SWAB_H__
-
-#include <linux/types.h>
-#include <linux/compiler.h>
-
-static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
-{
-	__asm__("wsbh   %0, %0\n\t"	/* word swap byte within halfword */
-		"rotri  %0, %0, #16\n"
-		:"=r"(x)
-		:"0"(x));
-	return x;
-}
-
-static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
-{
-	__asm__("wsbh   %0, %0\n"	/* word swap byte within halfword */
-		:"=r"(x)
-		:"0"(x));
-	return x;
-}
-
-#define __arch_swab32(x) ___arch__swab32(x)
-#define __arch_swab16(x) ___arch__swab16(x)
-
-#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#define __BYTEORDER_HAS_U64__
-#define __SWAB_64_THRU_32__
-#endif
-
-#endif /* __NDS32_SWAB_H__ */
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
deleted file mode 100644
index 90aa56c94af1..000000000000
--- a/arch/nds32/include/asm/syscall.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASM_NDS32_SYSCALL_H
-#define _ASM_NDS32_SYSCALL_H	1
-
-#include <uapi/linux/audit.h>
-#include <linux/err.h>
-struct task_struct;
-struct pt_regs;
-
-/**
- * syscall_get_nr - find what system call a task is executing
- * @task:	task of interest, must be blocked
- * @regs:	task_pt_regs() of @task
- *
- * If @task is executing a system call or is at system call
- * tracing about to attempt one, returns the system call number.
- * If @task is not executing a system call, i.e. it's blocked
- * inside the kernel for a fault or signal, returns -1.
- *
- * Note this returns int even on 64-bit machines.  Only 32 bits of
- * system call number can be meaningful.  If the actual arch value
- * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
- *
- * It's only valid to call this when @task is known to be blocked.
- */
-static inline int
-syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
-{
-	return regs->syscallno;
-}
-
-/**
- * syscall_rollback - roll back registers after an aborted system call
- * @task:	task of interest, must be in system call exit tracing
- * @regs:	task_pt_regs() of @task
- *
- * It's only valid to call this when @task is stopped for system
- * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
- * after tracehook_report_syscall_entry() returned nonzero to prevent
- * the system call from taking place.
- *
- * This rolls back the register state in @regs so it's as if the
- * system call instruction was a no-op.  The registers containing
- * the system call number and arguments are as they were before the
- * system call instruction.  This may not be the same as what the
- * register state looked like at system call entry tracing.
- */
-static inline void
-syscall_rollback(struct task_struct *task, struct pt_regs *regs)
-{
-	regs->uregs[0] = regs->orig_r0;
-}
-
-/**
- * syscall_get_error - check result of traced system call
- * @task:	task of interest, must be blocked
- * @regs:	task_pt_regs() of @task
- *
- * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
- *
- * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- */
-static inline long
-syscall_get_error(struct task_struct *task, struct pt_regs *regs)
-{
-	unsigned long error = regs->uregs[0];
-	return IS_ERR_VALUE(error) ? error : 0;
-}
-
-/**
- * syscall_get_return_value - get the return value of a traced system call
- * @task:	task of interest, must be blocked
- * @regs:	task_pt_regs() of @task
- *
- * Returns the return value of the successful system call.
- * This value is meaningless if syscall_get_error() returned nonzero.
- *
- * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- */
-static inline long
-syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
-{
-	return regs->uregs[0];
-}
-
-/**
- * syscall_set_return_value - change the return value of a traced system call
- * @task:	task of interest, must be blocked
- * @regs:	task_pt_regs() of @task
- * @error:	negative error code, or zero to indicate success
- * @val:	user return value if @error is zero
- *
- * This changes the results of the system call that user mode will see.
- * If @error is zero, the user sees a successful system call with a
- * return value of @val.  If @error is nonzero, it's a negated errno
- * code; the user sees a failed system call with this errno code.
- *
- * It's only valid to call this when @task is stopped for tracing on exit
- * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- */
-static inline void
-syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
-			 int error, long val)
-{
-	regs->uregs[0] = (long)error ? error : val;
-}
-
-/**
- * syscall_get_arguments - extract system call parameter values
- * @task:	task of interest, must be blocked
- * @regs:	task_pt_regs() of @task
- * @args:	array filled with argument values
- *
- * Fetches 6 arguments to the system call (from 0 through 5). The first
- * argument is stored in @args[0], and so on.
- *
- * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- */
-#define SYSCALL_MAX_ARGS 6
-static inline void
-syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned long *args)
-{
-	args[0] = regs->orig_r0;
-	args++;
-	memcpy(args, &regs->uregs[0] + 1, 5 * sizeof(args[0]));
-}
-
-static inline int
-syscall_get_arch(struct task_struct *task)
-{
-	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
-		? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
-}
-
-#endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
deleted file mode 100644
index 4e7216082a67..000000000000
--- a/arch/nds32/include/asm/syscalls.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_SYSCALLS_H
-#define __ASM_NDS32_SYSCALLS_H
-
-asmlinkage long sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
-asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
-asmlinkage long sys_rt_sigreturn_wrapper(void);
-asmlinkage long sys_fp_udfiex_crtl(int cmd, int act);
-
-#include <asm-generic/syscalls.h>
-
-#endif /* __ASM_NDS32_SYSCALLS_H */
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
deleted file mode 100644
index d3967ad184f0..000000000000
--- a/arch/nds32/include/asm/thread_info.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_THREAD_INFO_H
-#define __ASM_NDS32_THREAD_INFO_H
-
-#ifdef __KERNEL__
-
-#define THREAD_SIZE_ORDER 	(1)
-#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
-
-#ifndef __ASSEMBLY__
-
-struct task_struct;
-
-#include <asm/ptrace.h>
-#include <asm/types.h>
-
-typedef unsigned long mm_segment_t;
-
-/*
- * low level task data that entry.S needs immediate access to.
- * __switch_to() assumes cpu_context follows immediately after cpu_domain.
- */
-struct thread_info {
-	unsigned long flags;	/* low level flags */
-	__s32 preempt_count;	/* 0 => preemptable, <0 => bug */
-	mm_segment_t addr_limit;	/* address limit */
-};
-#define INIT_THREAD_INFO(tsk)						\
-{									\
-	.preempt_count	= INIT_PREEMPT_COUNT,				\
-	.addr_limit	= KERNEL_DS,					\
-}
-#define thread_saved_pc(tsk) ((unsigned long)(tsk->thread.cpu_context.pc))
-#define thread_saved_fp(tsk) ((unsigned long)(tsk->thread.cpu_context.fp))
-#endif
-
-/*
- * thread information flags:
- *  TIF_SYSCALL_TRACE	- syscall trace active
- *  TIF_SIGPENDING	- signal pending
- *  TIF_NEED_RESCHED	- rescheduling necessary
- *  TIF_NOTIFY_RESUME	- callback before returning to user
- *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
- */
-#define TIF_SIGPENDING		1
-#define TIF_NEED_RESCHED	2
-#define TIF_SINGLESTEP		3
-#define TIF_NOTIFY_RESUME	4	/* callback before returning to user */
-#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8
-#define TIF_POLLING_NRFLAG	17
-#define TIF_MEMDIE		18
-#define TIF_FREEZE		19
-#define TIF_RESTORE_SIGMASK	20
-
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
-#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
-#define _TIF_FREEZE		(1 << TIF_FREEZE)
-#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
-
-/*
- * Change these and you break ASM code in entry-common.S
- */
-#define _TIF_WORK_MASK		0x000000ff
-#define _TIF_WORK_SYSCALL_ENTRY (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
-#define _TIF_WORK_SYSCALL_LEAVE (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)
-
-#endif /* __KERNEL__ */
-#endif /* __ASM_NDS32_THREAD_INFO_H */
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
deleted file mode 100644
index 672603804a3b..000000000000
--- a/arch/nds32/include/asm/tlb.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASMNDS32_TLB_H
-#define __ASMNDS32_TLB_H
-
-#include <asm-generic/tlb.h>
-
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
-
-#endif
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
deleted file mode 100644
index 97155366ea01..000000000000
--- a/arch/nds32/include/asm/tlbflush.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMNDS32_TLBFLUSH_H
-#define _ASMNDS32_TLBFLUSH_H
-
-#include <linux/spinlock.h>
-#include <linux/mm.h>
-#include <nds32_intrinsic.h>
-
-static inline void local_flush_tlb_all(void)
-{
-	__nds32__tlbop_flua();
-	__nds32__isb();
-}
-
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
-{
-	__nds32__tlbop_flua();
-	__nds32__isb();
-}
-
-static inline void local_flush_tlb_kernel_range(unsigned long start,
-						unsigned long end)
-{
-	while (start < end) {
-		__nds32__tlbop_inv(start);
-		__nds32__isb();
-		start += PAGE_SIZE;
-	}
-}
-
-void local_flush_tlb_range(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end);
-void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
-
-#define flush_tlb_all		local_flush_tlb_all
-#define flush_tlb_mm		local_flush_tlb_mm
-#define flush_tlb_range		local_flush_tlb_range
-#define flush_tlb_page		local_flush_tlb_page
-#define flush_tlb_kernel_range	local_flush_tlb_kernel_range
-
-void update_mmu_cache(struct vm_area_struct *vma,
-		      unsigned long address, pte_t * pte);
-
-#endif
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
deleted file mode 100644
index d4cbf069dc22..000000000000
--- a/arch/nds32/include/asm/uaccess.h
+++ /dev/null
@@ -1,286 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMANDES_UACCESS_H
-#define _ASMANDES_UACCESS_H
-
-/*
- * User space memory access functions
- */
-#include <linux/sched.h>
-#include <asm/errno.h>
-#include <asm/memory.h>
-#include <asm/types.h>
-
-#define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
-
-/*
- * The exception table consists of pairs of addresses: the first is the
- * address of an instruction that is allowed to fault, and the second is
- * the address at which the program should continue.  No registers are
- * modified, so it is entirely up to the continuation code to figure out
- * what to do.
- *
- * All the routines below use bits of fixup code that are out of line
- * with the main instruction path.  This means when everything is well,
- * we don't even have to jump over them.  Further, they do not intrude
- * on our cache or tlb entries.
- */
-
-struct exception_table_entry {
-	unsigned long insn, fixup;
-};
-
-extern int fixup_exception(struct pt_regs *regs);
-
-#define KERNEL_DS 	((mm_segment_t) { ~0UL })
-#define USER_DS		((mm_segment_t) {TASK_SIZE - 1})
-
-#define get_fs()	(current_thread_info()->addr_limit)
-#define user_addr_max	get_fs
-
-static inline void set_fs(mm_segment_t fs)
-{
-	current_thread_info()->addr_limit = fs;
-}
-
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
-#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
-
-#define access_ok(addr, size)	\
-	__range_ok((unsigned long)addr, (unsigned long)size)
-/*
- * Single-value transfer routines.  They automatically use the right
- * size if we just have the right pointer type.  Note that the functions
- * which read from user space (*get_*) need to take care not to leak
- * kernel data even if the calling code is buggy and fails to check
- * the return value.  This means zeroing out the destination variable
- * or buffer on error.  Normally this is done out of line by the
- * fixup code, but there are a few places where it intrudes on the
- * main code path.  When we only write to user space, there is no
- * problem.
- *
- * The "__xxx" versions of the user access functions do not verify the
- * address space - it must have been done previously with a separate
- * "access_ok()" call.
- *
- * The "xxx_error" versions set the third argument to EFAULT if an
- * error occurs, and leave it unchanged on success.  Note that these
- * versions are void (ie, don't return a value as such).
- */
-
-#define get_user	__get_user					\
-
-#define __get_user(x, ptr)						\
-({									\
-	long __gu_err = 0;						\
-	__get_user_check((x), (ptr), __gu_err);				\
-	__gu_err;							\
-})
-
-#define __get_user_error(x, ptr, err)					\
-({									\
-	__get_user_check((x), (ptr), (err));				\
-	(void)0;							\
-})
-
-#define __get_user_check(x, ptr, err)					\
-({									\
-	const __typeof__(*(ptr)) __user *__p = (ptr);			\
-	might_fault();							\
-	if (access_ok(__p, sizeof(*__p))) {		\
-		__get_user_err((x), __p, (err));			\
-	} else {							\
-		(x) = 0; (err) = -EFAULT;				\
-	}								\
-})
-
-#define __get_user_err(x, ptr, err)					\
-do {									\
-	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		__get_user_asm("lbi", __gu_val, (ptr), (err));		\
-		break;							\
-	case 2:								\
-		__get_user_asm("lhi", __gu_val, (ptr), (err));		\
-		break;							\
-	case 4:								\
-		__get_user_asm("lwi", __gu_val, (ptr), (err));		\
-		break;							\
-	case 8:								\
-		__get_user_asm_dword(__gu_val, (ptr), (err));		\
-		break;							\
-	default:							\
-		BUILD_BUG(); 						\
-		break;							\
-	}								\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-} while (0)
-
-#define __get_user_asm(inst, x, addr, err)				\
-	__asm__ __volatile__ (						\
-		"1:	"inst"	%1,[%2]\n"				\
-		"2:\n"							\
-		"	.section .fixup,\"ax\"\n"			\
-		"	.align	2\n"					\
-		"3:	move %0, %3\n"					\
-		"	move %1, #0\n"					\
-		"	b	2b\n"					\
-		"	.previous\n"					\
-		"	.section __ex_table,\"a\"\n"			\
-		"	.align	3\n"					\
-		"	.long	1b, 3b\n"				\
-		"	.previous"					\
-		: "+r" (err), "=&r" (x)					\
-		: "r" (addr), "i" (-EFAULT)				\
-		: "cc")
-
-#ifdef __NDS32_EB__
-#define __gu_reg_oper0 "%H1"
-#define __gu_reg_oper1 "%L1"
-#else
-#define __gu_reg_oper0 "%L1"
-#define __gu_reg_oper1 "%H1"
-#endif
-
-#define __get_user_asm_dword(x, addr, err) 				\
-	__asm__ __volatile__ (						\
-		"\n1:\tlwi " __gu_reg_oper0 ",[%2]\n"			\
-		"\n2:\tlwi " __gu_reg_oper1 ",[%2+4]\n"			\
-		"3:\n"							\
-		"	.section .fixup,\"ax\"\n"			\
-		"	.align	2\n"					\
-		"4:	move	%0, %3\n"				\
-		"	b	3b\n"					\
-		"	.previous\n"					\
-		"	.section __ex_table,\"a\"\n"			\
-		"	.align	3\n"					\
-		"	.long	1b, 4b\n"				\
-		"	.long	2b, 4b\n"				\
-		"	.previous"					\
-		: "+r"(err), "=&r"(x)					\
-		: "r"(addr), "i"(-EFAULT)				\
-		: "cc")
-
-#define put_user	__put_user					\
-
-#define __put_user(x, ptr)						\
-({									\
-	long __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err);				\
-	__pu_err;							\
-})
-
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_err((x), (ptr), (err));				\
-	(void)0;							\
-})
-
-#define __put_user_check(x, ptr, err)					\
-({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	if (access_ok(__p, sizeof(*__p))) {		\
-		__put_user_err((x), __p, (err));			\
-	} else	{							\
-		(err) = -EFAULT;					\
-	}								\
-})
-
-#define __put_user_err(x, ptr, err)					\
-do {									\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		__put_user_asm("sbi", __pu_val, (ptr), (err));		\
-		break;							\
-	case 2: 							\
-		__put_user_asm("shi", __pu_val, (ptr), (err));		\
-		break;							\
-	case 4: 							\
-		__put_user_asm("swi", __pu_val, (ptr), (err));		\
-		break;							\
-	case 8:								\
-		__put_user_asm_dword(__pu_val, (ptr), (err));		\
-		break;							\
-	default:							\
-		BUILD_BUG(); 						\
-		break;							\
-	}								\
-} while (0)
-
-#define __put_user_asm(inst, x, addr, err)				\
-	__asm__ __volatile__ (						\
-		"1:	"inst"	%1,[%2]\n"				\
-		"2:\n"							\
-		"	.section .fixup,\"ax\"\n"			\
-		"	.align	2\n"					\
-		"3:	move	%0, %3\n"				\
-		"	b	2b\n"					\
-		"	.previous\n"					\
-		"	.section __ex_table,\"a\"\n"			\
-		"	.align	3\n"					\
-		"	.long	1b, 3b\n"				\
-		"	.previous"					\
-		: "+r" (err)						\
-		: "r" (x), "r" (addr), "i" (-EFAULT)			\
-		: "cc")
-
-#ifdef __NDS32_EB__
-#define __pu_reg_oper0 "%H2"
-#define __pu_reg_oper1 "%L2"
-#else
-#define __pu_reg_oper0 "%L2"
-#define __pu_reg_oper1 "%H2"
-#endif
-
-#define __put_user_asm_dword(x, addr, err) 				\
-	__asm__ __volatile__ (						\
-		"\n1:\tswi " __pu_reg_oper0 ",[%1]\n"			\
-		"\n2:\tswi " __pu_reg_oper1 ",[%1+4]\n"			\
-		"3:\n"							\
-		"	.section .fixup,\"ax\"\n"			\
-		"	.align	2\n"					\
-		"4:	move	%0, %3\n"				\
-		"	b	3b\n"					\
-		"	.previous\n"					\
-		"	.section __ex_table,\"a\"\n"			\
-		"	.align	3\n"					\
-		"	.long	1b, 4b\n"				\
-		"	.long	2b, 4b\n"				\
-		"	.previous"					\
-		: "+r"(err)						\
-		: "r"(addr), "r"(x), "i"(-EFAULT)			\
-		: "cc")
-
-extern unsigned long __arch_clear_user(void __user * addr, unsigned long n);
-extern long strncpy_from_user(char *dest, const char __user * src, long count);
-extern __must_check long strnlen_user(const char __user * str, long n);
-extern unsigned long __arch_copy_from_user(void *to, const void __user * from,
-                                           unsigned long n);
-extern unsigned long __arch_copy_to_user(void __user * to, const void *from,
-                                         unsigned long n);
-
-#define raw_copy_from_user __arch_copy_from_user
-#define raw_copy_to_user __arch_copy_to_user
-
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USER
-static inline unsigned long clear_user(void __user * to, unsigned long n)
-{
-	if (access_ok(to, n))
-		n = __arch_clear_user(to, n);
-	return n;
-}
-
-static inline unsigned long __clear_user(void __user * to, unsigned long n)
-{
-	return __arch_clear_user(to, n);
-}
-
-#endif /* _ASMNDS32_UACCESS_H */
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
deleted file mode 100644
index bf5e2d440913..000000000000
--- a/arch/nds32/include/asm/unistd.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#define __ARCH_WANT_SYS_CLONE
-
-#include <uapi/asm/unistd.h>
diff --git a/arch/nds32/include/asm/vdso.h b/arch/nds32/include/asm/vdso.h
deleted file mode 100644
index 89b113ffc3dc..000000000000
--- a/arch/nds32/include/asm/vdso.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2005-2017 Andes Technology Corporation
- */
-
-#ifndef __ASM_VDSO_H
-#define __ASM_VDSO_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-#include <generated/vdso-offsets.h>
-
-#define VDSO_SYMBOL(base, name)						   \
-({									   \
-	(unsigned long)(vdso_offset_##name + (unsigned long)(base)); \
-})
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_H */
diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
deleted file mode 100644
index 74c68802021e..000000000000
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2012 ARM Limited
-// Copyright (C) 2005-2017 Andes Technology Corporation
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-struct vdso_data {
-	bool cycle_count_down;	/* timer cyclye counter is decrease with time */
-	u32 cycle_count_offset;	/* offset of timer cycle counter register */
-	u32 seq_count;		/* sequence count - odd during updates */
-	u32 xtime_coarse_sec;	/* coarse time */
-	u32 xtime_coarse_nsec;
-
-	u32 wtm_clock_sec;	/* wall to monotonic offset */
-	u32 wtm_clock_nsec;
-	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
-	u32 cs_mult;		/* clocksource multiplier */
-	u32 cs_shift;		/* Cycle to nanosecond divisor (power of two) */
-	u32 hrtimer_res;	/* hrtimer resolution */
-
-	u64 cs_cycle_last;	/* last cycle value */
-	u64 cs_mask;		/* clocksource mask */
-
-	u64 xtime_clock_nsec;	/* CLOCK_REALTIME sub-ns base */
-	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
-	u32 tz_dsttime;
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/nds32/include/asm/vdso_timer_info.h b/arch/nds32/include/asm/vdso_timer_info.h
deleted file mode 100644
index 328439ce37db..000000000000
--- a/arch/nds32/include/asm/vdso_timer_info.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-extern struct timer_info_t timer_info;
-#define EMPTY_VALUE ~(0UL)
-#define EMPTY_TIMER_MAPPING EMPTY_VALUE
-#define EMPTY_REG_OFFSET EMPTY_VALUE
-
-struct timer_info_t
-{
-	bool cycle_count_down;
-	unsigned long mapping_base;
-	unsigned long cycle_count_reg_offset;
-};
diff --git a/arch/nds32/include/asm/vermagic.h b/arch/nds32/include/asm/vermagic.h
deleted file mode 100644
index f772e7ba33f1..000000000000
--- a/arch/nds32/include/asm/vermagic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASM_VERMAGIC_H
-#define _ASM_VERMAGIC_H
-
-#define MODULE_ARCH_VERMAGIC	"NDS32v3"
-
-#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/nds32/include/asm/vmalloc.h b/arch/nds32/include/asm/vmalloc.h
deleted file mode 100644
index caeed3898419..000000000000
--- a/arch/nds32/include/asm/vmalloc.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _ASM_NDS32_VMALLOC_H
-#define _ASM_NDS32_VMALLOC_H
-
-#endif /* _ASM_NDS32_VMALLOC_H */
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
deleted file mode 100644
index e78470141932..000000000000
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-generic-y += ucontext.h
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
deleted file mode 100644
index bc0b92ab8c15..000000000000
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_AUXVEC_H
-#define __ASM_AUXVEC_H
-
-/*
- * This entry gives some information about the FPU initialization
- * performed by the kernel.
- */
-#define AT_FPUCW	18	/* Used FPU control word.  */
-
-
-/* VDSO location */
-#define AT_SYSINFO_EHDR	33
-
-#define AT_VECTOR_SIZE_ARCH 1
-
-#endif
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
deleted file mode 100644
index c264ef12c49c..000000000000
--- a/arch/nds32/include/uapi/asm/byteorder.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __NDS32_BYTEORDER_H__
-#define __NDS32_BYTEORDER_H__
-
-#ifdef __NDS32_EB__
-#include <linux/byteorder/big_endian.h>
-#else
-#include <linux/byteorder/little_endian.h>
-#endif
-
-#endif /* __NDS32_BYTEORDER_H__ */
diff --git a/arch/nds32/include/uapi/asm/cachectl.h b/arch/nds32/include/uapi/asm/cachectl.h
deleted file mode 100644
index 31b9b439d819..000000000000
--- a/arch/nds32/include/uapi/asm/cachectl.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 1994, 1995, 1996 by Ralf Baechle
-// Copyright (C) 2005-2017 Andes Technology Corporation
-#ifndef	_ASM_CACHECTL
-#define	_ASM_CACHECTL
-
-/*
- * Options for cacheflush system call
- */
-#define	ICACHE	0		/* flush instruction cache        */
-#define	DCACHE	1		/* writeback and flush data cache */
-#define	BCACHE	2		/* flush instruction cache + writeback and flush data cache */
-
-#endif /* _ASM_CACHECTL */
diff --git a/arch/nds32/include/uapi/asm/fp_udfiex_crtl.h b/arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
deleted file mode 100644
index f17396db16ec..000000000000
--- a/arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* Copyright (C) 2005-2019 Andes Technology Corporation */
-#ifndef	_FP_UDF_IEX_CRTL_H
-#define	_FP_UDF_IEX_CRTL_H
-
-/*
- * The cmd list of sys_fp_udfiex_crtl()
- */
-/* Disable UDF or IEX trap based on the content of parameter act */
-#define DISABLE_UDF_IEX_TRAP	0
-/* Enable UDF or IEX trap based on the content of parameter act */
-#define ENABLE_UDF_IEX_TRAP	1
-/* Get current status of UDF and IEX trap */
-#define GET_UDF_IEX_TRAP	2
-
-#endif /* _FP_UDF_IEX_CRTL_H */
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
deleted file mode 100644
index 48d00328d328..000000000000
--- a/arch/nds32/include/uapi/asm/param.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __ASM_NDS32_PARAM_H
-#define __ASM_NDS32_PARAM_H
-
-#define EXEC_PAGESIZE	8192
-
-#include <asm-generic/param.h>
-
-#endif /* __ASM_NDS32_PARAM_H */
diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
deleted file mode 100644
index d76217c7c010..000000000000
--- a/arch/nds32/include/uapi/asm/ptrace.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef __UAPI_ASM_NDS32_PTRACE_H
-#define __UAPI_ASM_NDS32_PTRACE_H
-
-#ifndef __ASSEMBLY__
-
-/*
- * User structures for general purpose register.
- */
-struct user_pt_regs {
-	long uregs[26];
-	long fp;
-	long gp;
-	long lp;
-	long sp;
-	long ipc;
-	long lb;
-	long le;
-	long lc;
-	long syscallno;
-};
-#endif
-#endif
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 6c1e6648878f..000000000000
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#ifndef _ASMNDS32_SIGCONTEXT_H
-#define _ASMNDS32_SIGCONTEXT_H
-
-/*
- * Signal context structure - contains all info to do with the state
- * before the signal handler was invoked.  Note: only add new entries
- * to the end of the structure.
- */
-struct fpu_struct {
-	unsigned long long fd_regs[32];
-	unsigned long fpcsr;
-	/*
-	 * When CONFIG_SUPPORT_DENORMAL_ARITHMETIC is defined, kernel prevents
-	 * hardware from treating the denormalized output as an underflow case
-	 * and rounding it to a normal number. Hence kernel enables the UDF and
-	 * IEX trap in the fpcsr register to step in the calculation.
-	 * However, the UDF and IEX trap enable bit in $fpcsr also lose
-	 * their use.
-	 *
-	 * UDF_IEX_trap replaces the feature of UDF and IEX trap enable bit in
-	 * $fpcsr to control the trap of underflow and inexact. The bit filed
-	 * of UDF_IEX_trap is the same as $fpcsr, 10th bit is used to enable UDF
-	 * exception trapping and 11th bit is used to enable IEX exception
-	 * trapping.
-	 *
-	 * UDF_IEX_trap is only modified through fp_udfiex_crtl syscall.
-	 * Therefore, UDF_IEX_trap needn't be saved and restored in each
-	 * context switch.
-	 */
-	unsigned long UDF_IEX_trap;
-};
-
-struct zol_struct {
-	unsigned long nds32_lc;	/* $LC */
-	unsigned long nds32_le;	/* $LE */
-	unsigned long nds32_lb;	/* $LB */
-};
-
-struct sigcontext {
-	unsigned long trap_no;
-	unsigned long error_code;
-	unsigned long oldmask;
-	unsigned long nds32_r0;
-	unsigned long nds32_r1;
-	unsigned long nds32_r2;
-	unsigned long nds32_r3;
-	unsigned long nds32_r4;
-	unsigned long nds32_r5;
-	unsigned long nds32_r6;
-	unsigned long nds32_r7;
-	unsigned long nds32_r8;
-	unsigned long nds32_r9;
-	unsigned long nds32_r10;
-	unsigned long nds32_r11;
-	unsigned long nds32_r12;
-	unsigned long nds32_r13;
-	unsigned long nds32_r14;
-	unsigned long nds32_r15;
-	unsigned long nds32_r16;
-	unsigned long nds32_r17;
-	unsigned long nds32_r18;
-	unsigned long nds32_r19;
-	unsigned long nds32_r20;
-	unsigned long nds32_r21;
-	unsigned long nds32_r22;
-	unsigned long nds32_r23;
-	unsigned long nds32_r24;
-	unsigned long nds32_r25;
-	unsigned long nds32_fp;	/* $r28 */
-	unsigned long nds32_gp;	/* $r29 */
-	unsigned long nds32_lp;	/* $r30 */
-	unsigned long nds32_sp;	/* $r31 */
-	unsigned long nds32_ipc;
-	unsigned long fault_address;
-	unsigned long used_math_flag;
-	/* FPU Registers */
-	struct fpu_struct fpu;
-	struct zol_struct zol;
-};
-
-#endif
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
deleted file mode 100644
index 410795e280fe..000000000000
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYNC_FILE_RANGE2
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
-
-/* Use the standard ABI for syscalls */
-#include <asm-generic/unistd.h>
-
-/* Additional NDS32 specific syscalls. */
-#define __NR_cacheflush		(__NR_arch_specific_syscall)
-#define __NR_fp_udfiex_crtl	(__NR_arch_specific_syscall + 1)
-__SYSCALL(__NR_cacheflush, sys_cacheflush)
-__SYSCALL(__NR_fp_udfiex_crtl, sys_fp_udfiex_crtl)
diff --git a/arch/nds32/kernel/.gitignore b/arch/nds32/kernel/.gitignore
deleted file mode 100644
index bbb90f92d051..000000000000
--- a/arch/nds32/kernel/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-vmlinux.lds
diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
deleted file mode 100644
index 394df3f6442c..000000000000
--- a/arch/nds32/kernel/Makefile
+++ /dev/null
@@ -1,33 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux kernel.
-#
-
-CPPFLAGS_vmlinux.lds	:= -DTEXTADDR=$(TEXTADDR)
-AFLAGS_head.o		:= -DTEXTADDR=$(TEXTADDR)
-# Object file lists.
-
-obj-y			:= ex-entry.o ex-exit.o ex-scall.o irq.o \
-			process.o ptrace.o setup.o signal.o \
-			sys_nds32.o time.o traps.o cacheinfo.o \
-			dma.o syscall_table.o vdso.o
-
-obj-$(CONFIG_MODULES)		+= nds32_ksyms.o module.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
-obj-$(CONFIG_FPU)		+= fpu.o
-obj-$(CONFIG_OF)		+= devtree.o
-obj-$(CONFIG_CACHE_L2)		+= atl2c.o
-obj-$(CONFIG_PERF_EVENTS) += perf_event_cpu.o
-obj-$(CONFIG_PM)		+= pm.o sleep.o
-extra-y := head.o vmlinux.lds
-
-CFLAGS_fpu.o += -mext-fpu-sp -mext-fpu-dp
-
-
-obj-y				+= vdso/
-
-obj-$(CONFIG_FUNCTION_TRACER)   += ftrace.o
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
-endif
diff --git a/arch/nds32/kernel/asm-offsets.c b/arch/nds32/kernel/asm-offsets.c
deleted file mode 100644
index 3541d5981de7..000000000000
--- a/arch/nds32/kernel/asm-offsets.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/kbuild.h>
-#include <asm/thread_info.h>
-#include <asm/ptrace.h>
-
-int main(void)
-{
-	DEFINE(TSK_TI_FLAGS, offsetof(struct task_struct, thread_info.flags));
-	DEFINE(TSK_TI_PREEMPT,
-	       offsetof(struct task_struct, thread_info.preempt_count));
-	DEFINE(THREAD_CPU_CONTEXT,
-	       offsetof(struct task_struct, thread.cpu_context));
-	DEFINE(OSP_OFFSET, offsetof(struct pt_regs, osp));
-	DEFINE(SP_OFFSET, offsetof(struct pt_regs, sp));
-	DEFINE(FUCOP_CTL_OFFSET, offsetof(struct pt_regs, fucop_ctl));
-	DEFINE(IPSW_OFFSET, offsetof(struct pt_regs, ipsw));
-	DEFINE(SYSCALLNO_OFFSET, offsetof(struct pt_regs, syscallno));
-	DEFINE(IPC_OFFSET, offsetof(struct pt_regs, ipc));
-	DEFINE(R0_OFFSET, offsetof(struct pt_regs, uregs[0]));
-	DEFINE(R15_OFFSET, offsetof(struct pt_regs, uregs[15]));
-	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
-	DEFINE(CLOCK_COARSE_RES, LOW_RES_NSEC);
-	return 0;
-}
diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
deleted file mode 100644
index 0c5386e72098..000000000000
--- a/arch/nds32/kernel/atl2c.c
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/compiler.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/of_platform.h>
-#include <asm/l2_cache.h>
-
-void __iomem *atl2c_base;
-static const struct of_device_id atl2c_ids[] __initconst = {
-	{.compatible = "andestech,atl2c",},
-	{}
-};
-
-static int __init atl2c_of_init(void)
-{
-	struct device_node *np;
-	struct resource res;
-	unsigned long tmp = 0;
-	unsigned long l2set, l2way, l2clsz;
-
-	if (!(__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskL2C))
-		return -ENODEV;
-
-	np = of_find_matching_node(NULL, atl2c_ids);
-	if (!np)
-		return -ENODEV;
-
-	if (of_address_to_resource(np, 0, &res))
-		return -ENODEV;
-
-	atl2c_base = ioremap(res.start, resource_size(&res));
-	if (!atl2c_base)
-		return -ENOMEM;
-
-	l2set =
-	    64 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2SET) >>
-		   L2_CA_CONF_offL2SET);
-	l2way =
-	    1 +
-	    ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2WAY) >>
-	     L2_CA_CONF_offL2WAY);
-	l2clsz =
-	    4 << ((L2C_R_REG(L2_CA_CONF_OFF) & L2_CA_CONF_mskL2CLSZ) >>
-		  L2_CA_CONF_offL2CLSZ);
-	pr_info("L2:%luKB/%luS/%luW/%luB\n",
-		l2set * l2way * l2clsz / 1024, l2set, l2way, l2clsz);
-
-	tmp = L2C_R_REG(L2CC_PROT_OFF);
-	tmp &= ~L2CC_PROT_mskMRWEN;
-	L2C_W_REG(L2CC_PROT_OFF, tmp);
-
-	tmp = L2C_R_REG(L2CC_SETUP_OFF);
-	tmp &= ~L2CC_SETUP_mskPART;
-	L2C_W_REG(L2CC_SETUP_OFF, tmp);
-
-	tmp = L2C_R_REG(L2CC_CTRL_OFF);
-	tmp |= L2CC_CTRL_mskEN;
-	L2C_W_REG(L2CC_CTRL_OFF, tmp);
-
-	return 0;
-}
-
-subsys_initcall(atl2c_of_init);
diff --git a/arch/nds32/kernel/cacheinfo.c b/arch/nds32/kernel/cacheinfo.c
deleted file mode 100644
index aab98e447feb..000000000000
--- a/arch/nds32/kernel/cacheinfo.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/bitops.h>
-#include <linux/cacheinfo.h>
-#include <linux/cpu.h>
-
-static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 enum cache_type type, unsigned int level)
-{
-	char cache_type = (type & CACHE_TYPE_INST ? ICACHE : DCACHE);
-
-	this_leaf->level = level;
-	this_leaf->type = type;
-	this_leaf->coherency_line_size = CACHE_LINE_SIZE(cache_type);
-	this_leaf->number_of_sets = CACHE_SET(cache_type);
-	this_leaf->ways_of_associativity = CACHE_WAY(cache_type);
-	this_leaf->size = this_leaf->number_of_sets *
-	    this_leaf->coherency_line_size * this_leaf->ways_of_associativity;
-#if defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
-	this_leaf->attributes = CACHE_WRITE_THROUGH;
-#else
-	this_leaf->attributes = CACHE_WRITE_BACK;
-#endif
-}
-
-int init_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	/* Only 1 level and I/D cache seperate. */
-	this_cpu_ci->num_levels = 1;
-	this_cpu_ci->num_leaves = 2;
-	return 0;
-}
-
-int populate_cache_leaves(unsigned int cpu)
-{
-	unsigned int level, idx;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
-
-	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
-		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-	}
-	return 0;
-}
diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
deleted file mode 100644
index bdce0fe5af9f..000000000000
--- a/arch/nds32/kernel/devtree.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/bug.h>
-#include <linux/printk.h>
-#include <linux/of_fdt.h>
-
-void __init early_init_devtree(void *params)
-{
-	if (!params || !early_init_dt_scan(params)) {
-		pr_crit("\n"
-			"Error: invalid device tree blob at (virtual address 0x%p)\n"
-			"\nPlease check your bootloader.", params);
-
-		BUG_ON(1);
-	}
-
-	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
-}
diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
deleted file mode 100644
index 2ac8e6c82a61..000000000000
--- a/arch/nds32/kernel/dma.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/dma-map-ops.h>
-#include <linux/cache.h>
-#include <linux/highmem.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <asm/proc-fns.h>
-
-static inline void cache_op(phys_addr_t paddr, size_t size,
-		void (*fn)(unsigned long start, unsigned long end))
-{
-	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
-	unsigned offset = paddr & ~PAGE_MASK;
-	size_t left = size;
-	unsigned long start;
-
-	do {
-		size_t len = left;
-
-		if (PageHighMem(page)) {
-			void *addr;
-
-			if (offset + len > PAGE_SIZE) {
-				if (offset >= PAGE_SIZE) {
-					page += offset >> PAGE_SHIFT;
-					offset &= ~PAGE_MASK;
-				}
-				len = PAGE_SIZE - offset;
-			}
-
-			addr = kmap_atomic(page);
-			start = (unsigned long)(addr + offset);
-			fn(start, start + len);
-			kunmap_atomic(addr);
-		} else {
-			start = (unsigned long)phys_to_virt(paddr);
-			fn(start, start + size);
-		}
-		offset = 0;
-		page++;
-		left -= len;
-	} while (left);
-}
-
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_FROM_DEVICE:
-		break;
-	case DMA_TO_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		cache_op(paddr, size, cpu_dma_wb_range);
-		break;
-	default:
-		BUG();
-	}
-}
-
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_TO_DEVICE:
-		break;
-	case DMA_FROM_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		cache_op(paddr, size, cpu_dma_inval_range);
-		break;
-	default:
-		BUG();
-	}
-}
-
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	cache_op(page_to_phys(page), size, cpu_dma_wbinval_range);
-}
diff --git a/arch/nds32/kernel/ex-entry.S b/arch/nds32/kernel/ex-entry.S
deleted file mode 100644
index 107d98a1d1b8..000000000000
--- a/arch/nds32/kernel/ex-entry.S
+++ /dev/null
@@ -1,177 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/memory.h>
-#include <asm/nds32.h>
-#include <asm/errno.h>
-#include <asm/asm-offsets.h>
-#include <asm/page.h>
-#include <asm/fpu.h>
-
-#ifdef CONFIG_HWZOL
-	.macro push_zol
-	mfusr	$r14, $LB
-	mfusr	$r15, $LE
-	mfusr	$r16, $LC
-	.endm
-#endif
-	.macro  skip_save_fucop_ctl
-#if defined(CONFIG_FPU)
-skip_fucop_ctl:
-	smw.adm $p0, [$sp], $p0, #0x1
-	j fucop_ctl_done
-#endif
-	.endm
-
-	.macro	save_user_regs
-#if defined(CONFIG_FPU)
-	sethi   $p0, hi20(has_fpu)
-	lbsi 	$p0, [$p0+lo12(has_fpu)]
-	beqz	$p0, skip_fucop_ctl
-	mfsr    $p0, $FUCOP_CTL
-	smw.adm $p0, [$sp], $p0, #0x1
-	bclr    $p0, $p0, #FUCOP_CTL_offCP0EN
-	mtsr    $p0, $FUCOP_CTL
-fucop_ctl_done:
-	/* move $SP to the bottom of pt_regs */
-	addi    $sp, $sp, -FUCOP_CTL_OFFSET
-#else
-	smw.adm $sp, [$sp], $sp, #0x1
-	/* move $SP to the bottom of pt_regs */
-	addi    $sp, $sp, -OSP_OFFSET
-#endif
-
-	/* push $r0 ~ $r25 */
-	smw.bim $r0, [$sp], $r25
-	/* push $fp, $gp, $lp */
-	smw.bim $sp, [$sp], $sp, #0xe
-
-	mfsr	$r12, $SP_USR
-	mfsr	$r13, $IPC
-#ifdef CONFIG_HWZOL
-	push_zol
-#endif
-	movi	$r17, -1
-	move	$r18, $r0
-	mfsr	$r19, $PSW
-	mfsr	$r20, $IPSW
-	mfsr	$r21, $P_IPSW
-	mfsr	$r22, $P_IPC
-	mfsr	$r23, $P_P0
-	mfsr	$r24, $P_P1
-	smw.bim $r12, [$sp], $r24, #0
-	addi	$sp, $sp, -FUCOP_CTL_OFFSET
-
-	/* Initialize kernel space $fp */
-	andi    $p0, $r20, #PSW_mskPOM
-	movi    $p1, #0x0
-	cmovz   $fp, $p1, $p0
-
-	andi	$r16, $r19, #PSW_mskINTL
-	slti	$r17, $r16, #4
-	bnez	$r17, 1f
-	addi	$r17, $r19, #-2
-	mtsr	$r17, $PSW
-	isb
-1:
-	/* If it was superuser mode, we don't need to update $r25 */
-	bnez	$p0, 2f
-	la	$p0, __entry_task
-	lw	$r25, [$p0]
-2:
-	.endm
-
-	.text
-
-/*
- * Exception Vector
- */
-exception_handlers:
-	.long	unhandled_exceptions	!Reset/NMI
-	.long	unhandled_exceptions	!TLB fill
-	.long	do_page_fault		!PTE not present
-	.long	do_dispatch_tlb_misc	!TLB misc
-	.long	unhandled_exceptions	!TLB VLPT
-	.long	unhandled_exceptions	!Machine Error
-	.long	do_debug_trap		!Debug related
-	.long	do_dispatch_general	!General exception
-	.long	eh_syscall		!Syscall
-	.long	asm_do_IRQ		!IRQ
-
-	skip_save_fucop_ctl
-common_exception_handler:
-	save_user_regs
-	mfsr	$p0, $ITYPE
-	andi	$p0, $p0, #ITYPE_mskVECTOR
-	srli	$p0, $p0, #ITYPE_offVECTOR
-	andi	$p1, $p0, #NDS32_VECTOR_mskNONEXCEPTION
-	bnez	$p1, 1f
-	sethi	$lp, hi20(ret_from_exception)
-	ori	$lp, $lp, lo12(ret_from_exception)
-	sethi	$p1, hi20(exception_handlers)
-	ori	$p1, $p1, lo12(exception_handlers)
-	lw	$p1, [$p1+$p0<<2]
-	move	$r0, $p0
-	mfsr	$r1, $EVA
-	mfsr	$r2, $ITYPE
-	move	$r3, $sp
-	mfsr    $r4, $OIPC
-	/* enable gie if it is enabled in IPSW. */
-	mfsr	$r21, $PSW
-	andi	$r20, $r20, #PSW_mskGIE	/* r20 is $IPSW*/
-	or	$r21, $r21, $r20
-	mtsr	$r21, $PSW
-	dsb
-	jr	$p1
-	/* syscall */
-1:
-	addi	$p1, $p0, #-NDS32_VECTOR_offEXCEPTION
-	bnez	$p1, 2f
-	sethi	$lp, hi20(ret_from_exception)
-	ori	$lp, $lp, lo12(ret_from_exception)
-	sethi	$p1, hi20(exception_handlers)
-	ori	$p1, $p1, lo12(exception_handlers)
-	lwi	$p1, [$p1+#NDS32_VECTOR_offEXCEPTION<<2]
-	jr	$p1
-
-	/* interrupt */
-2:
-#ifdef CONFIG_TRACE_IRQFLAGS
-	jal     __trace_hardirqs_off
-#endif
-	move	$r0, $sp
-	sethi	$lp, hi20(ret_from_intr)
-	ori	$lp, $lp, lo12(ret_from_intr)
-	sethi	$p0, hi20(exception_handlers)
-	ori	$p0, $p0, lo12(exception_handlers)
-	lwi	$p0, [$p0+#NDS32_VECTOR_offINTERRUPT<<2]
-	jr	$p0
-
-	.macro	EXCEPTION_VECTOR_DEBUG
-	.align 4
-	mfsr     $p0, $EDM_CTL
-	andi     $p0, $p0, EDM_CTL_mskV3_EDM_MODE
-	tnez     $p0, SWID_RAISE_INTERRUPT_LEVEL
-	.endm
-
-	.macro	EXCEPTION_VECTOR
-	.align 4
-	sethi	 $p0, hi20(common_exception_handler)
-	ori	 $p0, $p0, lo12(common_exception_handler)
-	jral.ton $p0, $p0
-	.endm
-
-	.section	".text.init", #alloc, #execinstr
-	.global	exception_vector
-exception_vector:
-.rept 6
-	EXCEPTION_VECTOR
-.endr
-	EXCEPTION_VECTOR_DEBUG
-.rept 121
-	EXCEPTION_VECTOR
-.endr
-	.align 4
-	.global	exception_vector_end
-exception_vector_end:
diff --git a/arch/nds32/kernel/ex-exit.S b/arch/nds32/kernel/ex-exit.S
deleted file mode 100644
index b30699911b81..000000000000
--- a/arch/nds32/kernel/ex-exit.S
+++ /dev/null
@@ -1,193 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/unistd.h>
-#include <asm/assembler.h>
-#include <asm/nds32.h>
-#include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
-#include <asm/current.h>
-#include <asm/fpu.h>
-
-
-
-#ifdef CONFIG_HWZOL
-	.macro pop_zol
-	mtusr	$r14, $LB
-	mtusr	$r15, $LE
-	mtusr	$r16, $LC
-	.endm
-#endif
-
-	.macro	restore_user_regs_first
-	setgie.d
-	isb
-#if defined(CONFIG_FPU)
-	addi    $sp, $sp, OSP_OFFSET
-	lmw.adm $r12, [$sp], $r25, #0x0
-	sethi   $p0, hi20(has_fpu)
-	lbsi 	$p0, [$p0+lo12(has_fpu)]
-	beqz	$p0, 2f
-	mtsr    $r25, $FUCOP_CTL
-2:
-#else
-	addi	$sp, $sp, FUCOP_CTL_OFFSET
-	lmw.adm $r12, [$sp], $r24, #0x0
-#endif
-	mtsr	$r12, $SP_USR
-	mtsr	$r13, $IPC
-#ifdef CONFIG_HWZOL
-	pop_zol
-#endif
-	mtsr	$r19, $PSW
-	mtsr	$r20, $IPSW
-	mtsr    $r21, $P_IPSW
-	mtsr	$r22, $P_IPC
-	mtsr	$r23, $P_P0
-	mtsr	$r24, $P_P1
-	lmw.adm $sp, [$sp], $sp, #0xe
-	.endm
-
-	.macro	restore_user_regs_last
-	pop	$p0
-	cmovn	$sp, $p0, $p0
-
-	iret
-	nop
-
-	.endm
-
-	.macro	restore_user_regs
-	restore_user_regs_first
-	lmw.adm $r0, [$sp], $r25, #0x0
-	addi	$sp, $sp, OSP_OFFSET
-	restore_user_regs_last
-	.endm
-
-	.macro	fast_restore_user_regs
-	restore_user_regs_first
-	lmw.adm $r1, [$sp], $r25, #0x0
-	addi	$sp, $sp, OSP_OFFSET-4
-	restore_user_regs_last
-	.endm
-
-#ifdef CONFIG_PREEMPTION
-	.macro	preempt_stop
-	.endm
-#else
-	.macro	preempt_stop
-	setgie.d
-	isb
-	.endm
-#define	resume_kernel	no_work_pending
-#endif
-
-ENTRY(ret_from_exception)
-	preempt_stop
-ENTRY(ret_from_intr)
-
-/*
- * judge Kernel or user mode
- *
- */
-	lwi	$p0, [$sp+(#IPSW_OFFSET)]	! Check if in nested interrupt
-	andi	$p0, $p0, #PSW_mskINTL
-	bnez	$p0, resume_kernel		! done with iret
-	j	resume_userspace
-
-
-/*
- * This is the fast syscall return path.  We do as little as
- * possible here, and this includes saving $r0 back into the SVC
- * stack.
- * fixed: tsk - $r25, syscall # - $r7, syscall table pointer - $r8
- */
-ENTRY(ret_fast_syscall)
-	gie_disable
-	lwi	$r1, [tsk+#TSK_TI_FLAGS]
-	andi	$p1, $r1, #_TIF_WORK_MASK
-	bnez	$p1, fast_work_pending
-	fast_restore_user_regs			! iret
-
-/*
- * Ok, we need to do extra processing,
- * enter the slow path returning from syscall, while pending work.
- */
-fast_work_pending:
-	swi	$r0, [$sp+(#R0_OFFSET)]		! what is different from ret_from_exception
-work_pending:
-	andi	$p1, $r1, #_TIF_NEED_RESCHED
-	bnez	$p1, work_resched
-
-	andi	$p1, $r1, #_TIF_SIGPENDING|#_TIF_NOTIFY_RESUME|#_TIF_NOTIFY_SIGNAL
-	beqz	$p1, no_work_pending
-
-	move	$r0, $sp			! 'regs'
-	gie_enable
-	bal	do_notify_resume
-	b       ret_slow_syscall
-work_resched:
-	bal	schedule			! path, return to user mode
-
-/*
- * "slow" syscall return path.
- */
-ENTRY(resume_userspace)
-ENTRY(ret_slow_syscall)
-	gie_disable
-	lwi	$p0, [$sp+(#IPSW_OFFSET)]	! Check if in nested interrupt
-	andi	$p0, $p0, #PSW_mskINTL
-	bnez	$p0, no_work_pending		! done with iret
-	lwi	$r1, [tsk+#TSK_TI_FLAGS]
-	andi	$p1, $r1, #_TIF_WORK_MASK
-	bnez	$p1, work_pending		! handle work_resched, sig_pend
-
-no_work_pending:
-#ifdef CONFIG_TRACE_IRQFLAGS
-	lwi	$p0, [$sp+(#IPSW_OFFSET)]
-	andi	$p0, $p0, #0x1
-	la	$r10, __trace_hardirqs_off
-	la	$r9, __trace_hardirqs_on
-	cmovz	$r9, $p0, $r10
-	jral	$r9
-#endif
-	restore_user_regs			! return from iret
-
-
-/*
- * preemptive kernel
- */
-#ifdef CONFIG_PREEMPTION
-resume_kernel:
-	gie_disable
-	lwi	$t0, [tsk+#TSK_TI_PREEMPT]
-	bnez	$t0, no_work_pending
-
-	lwi	$t0, [tsk+#TSK_TI_FLAGS]
-	andi	$p1, $t0, #_TIF_NEED_RESCHED
-	beqz	$p1, no_work_pending
-
-	lwi	$t0, [$sp+(#IPSW_OFFSET)]	! Interrupts off?
-	andi	$t0, $t0, #1
-	beqz	$t0, no_work_pending
-
-	jal	preempt_schedule_irq
-	b	no_work_pending
-#endif
-
-/*
- * This is how we return from a fork.
- */
-ENTRY(ret_from_fork)
-	bal	schedule_tail
-	beqz	$r6, 1f				! r6 stores fn for kernel thread
-	move	$r0, $r7			! prepare kernel thread arg
-	jral	$r6
-1:
-	lwi	$r1, [tsk+#TSK_TI_FLAGS]		! check for syscall tracing
-	andi	$p1, $r1, #_TIF_WORK_SYSCALL_LEAVE	! are we tracing syscalls?
-	beqz	$p1, ret_slow_syscall
-	move    $r0, $sp
-	bal	syscall_trace_leave
-	b	ret_slow_syscall
diff --git a/arch/nds32/kernel/ex-scall.S b/arch/nds32/kernel/ex-scall.S
deleted file mode 100644
index 270050f1b7b1..000000000000
--- a/arch/nds32/kernel/ex-scall.S
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/unistd.h>
-#include <asm/assembler.h>
-#include <asm/nds32.h>
-#include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
-#include <asm/current.h>
-
-/*
- * $r0 = previous task_struct,
- * $r1 = next task_struct,
- * previous and next are guaranteed not to be the same.
- */
-
-ENTRY(__switch_to)
-
-	la	$p0, __entry_task
-	sw	$r1, [$p0]
-	addi	$p1, $r0, #THREAD_CPU_CONTEXT
-	smw.bi 	$r6, [$p1], $r14, #0xb		! push r6~r14, fp, lp, sp
-	move	$r25, $r1
-#if defined(CONFIG_FPU)
-	call	_switch_fpu
-#endif
-	addi	$r1, $r25, #THREAD_CPU_CONTEXT
-	lmw.bi 	$r6, [$r1], $r14, #0xb		! pop r6~r14, fp, lp, sp
-	ret
-
-
-#define tbl $r8
-
-/*
- * $r7 will be writen as syscall nr
- */
-	.macro	get_scno
-	lwi	$r7, [$sp + R15_OFFSET]
-	swi	$r7, [$sp + SYSCALLNO_OFFSET]
-	.endm
-
-	.macro	updateipc
-	addi	$r17, $r13, #4				! $r13 is $IPC
-	swi	$r17, [$sp + IPC_OFFSET]
-	.endm
-
-ENTRY(eh_syscall)
-	updateipc
-
-	get_scno
-	gie_enable
-
-	lwi	$p0, [tsk+#TSK_TI_FLAGS]		! check for syscall tracing
-
-	andi	$p1, $p0, #_TIF_WORK_SYSCALL_ENTRY	! are we tracing syscalls?
-	bnez	$p1, __sys_trace
-
-	la	$lp, ret_fast_syscall		! return address
-jmp_systbl:
-	addi	$p1, $r7, #-__NR_syscalls	! syscall number of syscall instruction is guarded by addembler
-	bgez	$p1, _SCNO_EXCEED		! call sys_* routine
-	la	tbl, sys_call_table		! load syscall table pointer
-	slli	$p1, $r7, #2
-	add	$p1, tbl, $p1
-	lwi	$p1, [$p1]
-	jr	$p1				! no return
-
-_SCNO_EXCEED:
-	ori	$r0, $r7, #0
-        ori	$r1, $sp, #0
-	b	bad_syscall
-
-/*
- * This is the really slow path.  We're going to be doing
- * context switches, and waiting for our parent to respond.
- */
-__sys_trace:
-	move	$r0, $sp
-	bal	syscall_trace_enter
-	move	$r7, $r0
-	la	$lp, __sys_trace_return		! return address
-
-	addi    $p1, $r7, #1
-	beqz    $p1, ret_slow_syscall		! fatal signal is pending
-
-	addi	$p1, $sp, #R0_OFFSET		! pointer to regs
-	lmw.bi	$r0, [$p1], $r5			! have to reload $r0 - $r5
-	b	jmp_systbl
-
-__sys_trace_return:
-	swi	$r0, [$sp+#R0_OFFSET]		! T: save returned $r0
-	move	$r0, $sp			! set pt_regs for syscall_trace_leave
-	bal	syscall_trace_leave
-	b	ret_slow_syscall
-
-ENTRY(sys_rt_sigreturn_wrapper)
-	addi	$r0, $sp, #0
-	b	sys_rt_sigreturn
-ENDPROC(sys_rt_sigreturn_wrapper)
diff --git a/arch/nds32/kernel/fpu.c b/arch/nds32/kernel/fpu.c
deleted file mode 100644
index 701c09a668de..000000000000
--- a/arch/nds32/kernel/fpu.c
+++ /dev/null
@@ -1,266 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/sched/signal.h>
-#include <asm/processor.h>
-#include <asm/user.h>
-#include <asm/io.h>
-#include <asm/bitfield.h>
-#include <asm/fpu.h>
-
-const struct fpu_struct init_fpuregs = {
-	.fd_regs = {[0 ... 31] = sNAN64},
-	.fpcsr = FPCSR_INIT,
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-	.UDF_IEX_trap = 0
-#endif
-};
-
-void save_fpu(struct task_struct *tsk)
-{
-	unsigned int fpcfg, fpcsr;
-
-	enable_fpu();
-	fpcfg = ((__nds32__fmfcfg() & FPCFG_mskFREG) >> FPCFG_offFREG);
-	switch (fpcfg) {
-	case SP32_DP32_reg:
-		asm volatile ("fsdi $fd31, [%0+0xf8]\n\t"
-			      "fsdi $fd30, [%0+0xf0]\n\t"
-			      "fsdi $fd29, [%0+0xe8]\n\t"
-			      "fsdi $fd28, [%0+0xe0]\n\t"
-			      "fsdi $fd27, [%0+0xd8]\n\t"
-			      "fsdi $fd26, [%0+0xd0]\n\t"
-			      "fsdi $fd25, [%0+0xc8]\n\t"
-			      "fsdi $fd24, [%0+0xc0]\n\t"
-			      "fsdi $fd23, [%0+0xb8]\n\t"
-			      "fsdi $fd22, [%0+0xb0]\n\t"
-			      "fsdi $fd21, [%0+0xa8]\n\t"
-			      "fsdi $fd20, [%0+0xa0]\n\t"
-			      "fsdi $fd19, [%0+0x98]\n\t"
-			      "fsdi $fd18, [%0+0x90]\n\t"
-			      "fsdi $fd17, [%0+0x88]\n\t"
-			      "fsdi $fd16, [%0+0x80]\n\t"
-			      :	/* no output */
-			      : "r" (&tsk->thread.fpu)
-			      : "memory");
-		fallthrough;
-	case SP32_DP16_reg:
-		asm volatile ("fsdi $fd15, [%0+0x78]\n\t"
-			      "fsdi $fd14, [%0+0x70]\n\t"
-			      "fsdi $fd13, [%0+0x68]\n\t"
-			      "fsdi $fd12, [%0+0x60]\n\t"
-			      "fsdi $fd11, [%0+0x58]\n\t"
-			      "fsdi $fd10, [%0+0x50]\n\t"
-			      "fsdi $fd9,  [%0+0x48]\n\t"
-			      "fsdi $fd8,  [%0+0x40]\n\t"
-			      :	/* no output */
-			      : "r" (&tsk->thread.fpu)
-			      : "memory");
-		fallthrough;
-	case SP16_DP8_reg:
-		asm volatile ("fsdi $fd7,  [%0+0x38]\n\t"
-			      "fsdi $fd6,  [%0+0x30]\n\t"
-			      "fsdi $fd5,  [%0+0x28]\n\t"
-			      "fsdi $fd4,  [%0+0x20]\n\t"
-			      :	/* no output */
-			      : "r" (&tsk->thread.fpu)
-			      : "memory");
-		fallthrough;
-	case SP8_DP4_reg:
-		asm volatile ("fsdi $fd3,  [%1+0x18]\n\t"
-			      "fsdi $fd2,  [%1+0x10]\n\t"
-			      "fsdi $fd1,  [%1+0x8]\n\t"
-			      "fsdi $fd0,  [%1+0x0]\n\t"
-			      "fmfcsr	%0\n\t"
-			      "swi  %0, [%1+0x100]\n\t"
-			      : "=&r" (fpcsr)
-			      : "r"(&tsk->thread.fpu)
-			      : "memory");
-	}
-	disable_fpu();
-}
-
-void load_fpu(const struct fpu_struct *fpregs)
-{
-	unsigned int fpcfg, fpcsr;
-
-	enable_fpu();
-	fpcfg = ((__nds32__fmfcfg() & FPCFG_mskFREG) >> FPCFG_offFREG);
-	switch (fpcfg) {
-	case SP32_DP32_reg:
-		asm volatile ("fldi $fd31, [%0+0xf8]\n\t"
-			      "fldi $fd30, [%0+0xf0]\n\t"
-			      "fldi $fd29, [%0+0xe8]\n\t"
-			      "fldi $fd28, [%0+0xe0]\n\t"
-			      "fldi $fd27, [%0+0xd8]\n\t"
-			      "fldi $fd26, [%0+0xd0]\n\t"
-			      "fldi $fd25, [%0+0xc8]\n\t"
-			      "fldi $fd24, [%0+0xc0]\n\t"
-			      "fldi $fd23, [%0+0xb8]\n\t"
-			      "fldi $fd22, [%0+0xb0]\n\t"
-			      "fldi $fd21, [%0+0xa8]\n\t"
-			      "fldi $fd20, [%0+0xa0]\n\t"
-			      "fldi $fd19, [%0+0x98]\n\t"
-			      "fldi $fd18, [%0+0x90]\n\t"
-			      "fldi $fd17, [%0+0x88]\n\t"
-			      "fldi $fd16, [%0+0x80]\n\t"
-			      :	/* no output */
-			      : "r" (fpregs));
-		fallthrough;
-	case SP32_DP16_reg:
-		asm volatile ("fldi $fd15, [%0+0x78]\n\t"
-			      "fldi $fd14, [%0+0x70]\n\t"
-			      "fldi $fd13, [%0+0x68]\n\t"
-			      "fldi $fd12, [%0+0x60]\n\t"
-			      "fldi $fd11, [%0+0x58]\n\t"
-			      "fldi $fd10, [%0+0x50]\n\t"
-			      "fldi $fd9,  [%0+0x48]\n\t"
-			      "fldi $fd8,  [%0+0x40]\n\t"
-			      :	/* no output */
-			      : "r" (fpregs));
-		fallthrough;
-	case SP16_DP8_reg:
-		asm volatile ("fldi $fd7,  [%0+0x38]\n\t"
-			      "fldi $fd6,  [%0+0x30]\n\t"
-			      "fldi $fd5,  [%0+0x28]\n\t"
-			      "fldi $fd4,  [%0+0x20]\n\t"
-			      :	/* no output */
-			      : "r" (fpregs));
-		fallthrough;
-	case SP8_DP4_reg:
-		asm volatile ("fldi $fd3,  [%1+0x18]\n\t"
-			      "fldi $fd2,  [%1+0x10]\n\t"
-			      "fldi $fd1,  [%1+0x8]\n\t"
-			      "fldi $fd0,  [%1+0x0]\n\t"
-			      "lwi  %0, [%1+0x100]\n\t"
-			      "fmtcsr	%0\n\t":"=&r" (fpcsr)
-			      : "r"(fpregs));
-	}
-	disable_fpu();
-}
-void store_fpu_for_suspend(void)
-{
-#ifdef CONFIG_LAZY_FPU
-	if (last_task_used_math != NULL)
-		save_fpu(last_task_used_math);
-	last_task_used_math = NULL;
-#else
-	if (!used_math())
-		return;
-	unlazy_fpu(current);
-#endif
-	clear_fpu(task_pt_regs(current));
-}
-inline void do_fpu_context_switch(struct pt_regs *regs)
-{
-	/* Enable to use FPU. */
-
-	if (!user_mode(regs)) {
-		pr_err("BUG: FPU is used in kernel mode.\n");
-		BUG();
-		return;
-	}
-
-	enable_ptreg_fpu(regs);
-#ifdef CONFIG_LAZY_FPU	//Lazy FPU is used
-	if (last_task_used_math == current)
-		return;
-	if (last_task_used_math != NULL)
-		/* Other processes fpu state, save away */
-		save_fpu(last_task_used_math);
-	last_task_used_math = current;
-#endif
-	if (used_math()) {
-		load_fpu(&current->thread.fpu);
-	} else {
-		/* First time FPU user.  */
-		load_fpu(&init_fpuregs);
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-		current->thread.fpu.UDF_IEX_trap = init_fpuregs.UDF_IEX_trap;
-#endif
-		set_used_math();
-	}
-
-}
-
-inline void fill_sigfpe_signo(unsigned int fpcsr, int *signo)
-{
-	if (fpcsr & FPCSR_mskOVFT)
-		*signo = FPE_FLTOVF;
-#ifndef CONFIG_SUPPORT_DENORMAL_ARITHMETIC
-	else if (fpcsr & FPCSR_mskUDFT)
-		*signo = FPE_FLTUND;
-#endif
-	else if (fpcsr & FPCSR_mskIVOT)
-		*signo = FPE_FLTINV;
-	else if (fpcsr & FPCSR_mskDBZT)
-		*signo = FPE_FLTDIV;
-	else if (fpcsr & FPCSR_mskIEXT)
-		*signo = FPE_FLTRES;
-}
-
-inline void handle_fpu_exception(struct pt_regs *regs)
-{
-	unsigned int fpcsr;
-	int si_code = 0, si_signo = SIGFPE;
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-	unsigned long redo_except = FPCSR_mskDNIT|FPCSR_mskUDFT|FPCSR_mskIEXT;
-#else
-	unsigned long redo_except = FPCSR_mskDNIT;
-#endif
-
-	lose_fpu();
-	fpcsr = current->thread.fpu.fpcsr;
-
-	if (fpcsr & redo_except) {
-		si_signo = do_fpuemu(regs, &current->thread.fpu);
-		fpcsr = current->thread.fpu.fpcsr;
-		if (!si_signo) {
-			current->thread.fpu.fpcsr &= ~(redo_except);
-			goto done;
-		}
-	} else if (fpcsr & FPCSR_mskRIT) {
-		if (!user_mode(regs))
-			make_task_dead(SIGILL);
-		si_signo = SIGILL;
-	}
-
-	switch (si_signo) {
-	case SIGFPE:
-		fill_sigfpe_signo(fpcsr, &si_code);
-		break;
-	case SIGILL:
-		show_regs(regs);
-		si_code = ILL_COPROC;
-		break;
-	case SIGBUS:
-		si_code = BUS_ADRERR;
-		break;
-	default:
-		break;
-	}
-
-	force_sig_fault(si_signo, si_code,
-			(void __user *)instruction_pointer(regs));
-done:
-	own_fpu();
-}
-
-bool do_fpu_exception(unsigned int subtype, struct pt_regs *regs)
-{
-	int done = true;
-	/* Coprocessor disabled exception */
-	if (subtype == FPU_DISABLE_EXCEPTION) {
-		preempt_disable();
-		do_fpu_context_switch(regs);
-		preempt_enable();
-	}
-	/* Coprocessor exception such as underflow and overflow */
-	else if (subtype == FPU_EXCEPTION)
-		handle_fpu_exception(regs);
-	else
-		done = false;
-	return done;
-}
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
deleted file mode 100644
index 711bc8cd186d..000000000000
--- a/arch/nds32/kernel/ftrace.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/ftrace.h>
-#include <linux/uaccess.h>
-#include <asm/cacheflush.h>
-
-#ifndef CONFIG_DYNAMIC_FTRACE
-extern void (*ftrace_trace_function)(unsigned long, unsigned long,
-				     struct ftrace_ops*, struct ftrace_regs*);
-extern void ftrace_graph_caller(void);
-
-noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
-				  struct ftrace_ops *op, struct ftrace_regs *fregs)
-{
-	__asm__ ("");  /* avoid to optimize as pure function */
-}
-
-noinline void _mcount(unsigned long parent_ip)
-{
-	/* save all state by the compiler prologue */
-
-	unsigned long ip = (unsigned long)__builtin_return_address(0);
-
-	if (ftrace_trace_function != ftrace_stub)
-		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
-				      NULL, NULL);
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (ftrace_graph_return != (trace_func_graph_ret_t)ftrace_stub
-	    || ftrace_graph_entry != ftrace_graph_entry_stub)
-		ftrace_graph_caller();
-#endif
-
-	/* restore all state by the compiler epilogue */
-}
-EXPORT_SYMBOL(_mcount);
-
-#else /* CONFIG_DYNAMIC_FTRACE */
-
-noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
-				  struct ftrace_ops *op, struct ftrace_regs *fregs)
-{
-	__asm__ ("");  /* avoid to optimize as pure function */
-}
-
-noinline void __naked _mcount(unsigned long parent_ip)
-{
-	__asm__ ("");  /* avoid to optimize as pure function */
-}
-EXPORT_SYMBOL(_mcount);
-
-#define XSTR(s) STR(s)
-#define STR(s) #s
-void _ftrace_caller(unsigned long parent_ip)
-{
-	/* save all state needed by the compiler prologue */
-
-	/*
-	 * prepare arguments for real tracing function
-	 * first  arg : __builtin_return_address(0) - MCOUNT_INSN_SIZE
-	 * second arg : parent_ip
-	 */
-	__asm__ __volatile__ (
-		"move $r1, %0				   \n\t"
-		"addi $r0, %1, #-" XSTR(MCOUNT_INSN_SIZE) "\n\t"
-		:
-		: "r" (parent_ip), "r" (__builtin_return_address(0)));
-
-	/* a placeholder for the call to a real tracing function */
-	__asm__ __volatile__ (
-		"ftrace_call:		\n\t"
-		"nop			\n\t"
-		"nop			\n\t"
-		"nop			\n\t");
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* a placeholder for the call to ftrace_graph_caller */
-	__asm__ __volatile__ (
-		"ftrace_graph_call:	\n\t"
-		"nop			\n\t"
-		"nop			\n\t"
-		"nop			\n\t");
-#endif
-	/* restore all state needed by the compiler epilogue */
-}
-
-static unsigned long gen_sethi_insn(unsigned long addr)
-{
-	unsigned long opcode = 0x46000000;
-	unsigned long imm = addr >> 12;
-	unsigned long rt_num = 0xf << 20;
-
-	return ENDIAN_CONVERT(opcode | rt_num | imm);
-}
-
-static unsigned long gen_ori_insn(unsigned long addr)
-{
-	unsigned long opcode = 0x58000000;
-	unsigned long imm = addr & 0x0000fff;
-	unsigned long rt_num = 0xf << 20;
-	unsigned long ra_num = 0xf << 15;
-
-	return ENDIAN_CONVERT(opcode | rt_num | ra_num | imm);
-}
-
-static unsigned long gen_jral_insn(unsigned long addr)
-{
-	unsigned long opcode = 0x4a000001;
-	unsigned long rt_num = 0x1e << 20;
-	unsigned long rb_num = 0xf << 10;
-
-	return ENDIAN_CONVERT(opcode | rt_num | rb_num);
-}
-
-static void ftrace_gen_call_insn(unsigned long *call_insns,
-				 unsigned long addr)
-{
-	call_insns[0] = gen_sethi_insn(addr); /* sethi $r15, imm20u       */
-	call_insns[1] = gen_ori_insn(addr);   /* ori   $r15, $r15, imm15u */
-	call_insns[2] = gen_jral_insn(addr);  /* jral  $lp,  $r15         */
-}
-
-static int __ftrace_modify_code(unsigned long pc, unsigned long *old_insn,
-				unsigned long *new_insn, bool validate)
-{
-	unsigned long orig_insn[3];
-
-	if (validate) {
-		if (copy_from_kernel_nofault(orig_insn, (void *)pc,
-				MCOUNT_INSN_SIZE))
-			return -EFAULT;
-		if (memcmp(orig_insn, old_insn, MCOUNT_INSN_SIZE))
-			return -EINVAL;
-	}
-
-	if (copy_to_kernel_nofault((void *)pc, new_insn, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	return 0;
-}
-
-static int ftrace_modify_code(unsigned long pc, unsigned long *old_insn,
-			      unsigned long *new_insn, bool validate)
-{
-	int ret;
-
-	ret = __ftrace_modify_code(pc, old_insn, new_insn, validate);
-	if (ret)
-		return ret;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
-
-	return ret;
-}
-
-int ftrace_update_ftrace_func(ftrace_func_t func)
-{
-	unsigned long pc = (unsigned long)&ftrace_call;
-	unsigned long old_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-	unsigned long new_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-
-	if (func != ftrace_stub)
-		ftrace_gen_call_insn(new_insn, (unsigned long)func);
-
-	return ftrace_modify_code(pc, old_insn, new_insn, false);
-}
-
-int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
-{
-	unsigned long pc = rec->ip;
-	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-
-	ftrace_gen_call_insn(call_insn, addr);
-
-	return ftrace_modify_code(pc, nop_insn, call_insn, true);
-}
-
-int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
-		    unsigned long addr)
-{
-	unsigned long pc = rec->ip;
-	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-
-	ftrace_gen_call_insn(call_insn, addr);
-
-	return ftrace_modify_code(pc, call_insn, nop_insn, true);
-}
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
-			   unsigned long frame_pointer)
-{
-	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	unsigned long old;
-
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
-		return;
-
-	old = *parent;
-
-	if (!function_graph_enter(old, self_addr, frame_pointer, NULL))
-		*parent = return_hooker;
-}
-
-noinline void ftrace_graph_caller(void)
-{
-	unsigned long *parent_ip =
-		(unsigned long *)(__builtin_frame_address(2) - 4);
-
-	unsigned long selfpc =
-		(unsigned long)(__builtin_return_address(1) - MCOUNT_INSN_SIZE);
-
-	unsigned long frame_pointer =
-		(unsigned long)__builtin_frame_address(3);
-
-	prepare_ftrace_return(parent_ip, selfpc, frame_pointer);
-}
-
-extern unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
-void __naked return_to_handler(void)
-{
-	__asm__ __volatile__ (
-		/* save state needed by the ABI     */
-		"smw.adm $r0,[$sp],$r1,#0x0  \n\t"
-
-		/* get original return address      */
-		"move $r0, $fp               \n\t"
-		"bal ftrace_return_to_handler\n\t"
-		"move $lp, $r0               \n\t"
-
-		/* restore state needed by the ABI  */
-		"lmw.bim $r0,[$sp],$r1,#0x0  \n\t");
-}
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-extern unsigned long ftrace_graph_call;
-
-static int ftrace_modify_graph_caller(bool enable)
-{
-	unsigned long pc = (unsigned long)&ftrace_graph_call;
-	unsigned long nop_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-	unsigned long call_insn[3] = {INSN_NOP, INSN_NOP, INSN_NOP};
-
-	ftrace_gen_call_insn(call_insn, (unsigned long)ftrace_graph_caller);
-
-	if (enable)
-		return ftrace_modify_code(pc, nop_insn, call_insn, true);
-	else
-		return ftrace_modify_code(pc, call_insn, nop_insn, true);
-}
-
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	return ftrace_modify_graph_caller(true);
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	return ftrace_modify_graph_caller(false);
-}
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-noinline void __trace_hardirqs_off(void)
-{
-	trace_hardirqs_off();
-}
-noinline void __trace_hardirqs_on(void)
-{
-	trace_hardirqs_on();
-}
-#endif /* CONFIG_TRACE_IRQFLAGS */
diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
deleted file mode 100644
index 7347f00451a9..000000000000
--- a/arch/nds32/kernel/head.S
+++ /dev/null
@@ -1,197 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/pgtable.h>
-#include <asm/ptrace.h>
-#include <asm/asm-offsets.h>
-#include <asm/page.h>
-#include <linux/sizes.h>
-#include <asm/thread_info.h>
-
-#ifdef CONFIG_CPU_BIG_ENDIAN
-#define OF_DT_MAGIC 0xd00dfeed
-#else
-#define OF_DT_MAGIC 0xedfe0dd0
-#endif
-
-	.globl  swapper_pg_dir
-	.equ    swapper_pg_dir, TEXTADDR - 0x4000
-
-/*
- * Kernel startup entry point.
- */
-	.section ".head.text", "ax"
-	.type   _stext, %function
-ENTRY(_stext)
-	setgie.d                            ! Disable interrupt
-	isb
-/*
- * Disable I/D-cache and enable it at a proper time
- */
-	mfsr    $r0, $mr8
-	li      $r1, #~(CACHE_CTL_mskIC_EN|CACHE_CTL_mskDC_EN)
-	and     $r0, $r0, $r1
-	mtsr    $r0, $mr8
-
-/*
- * Process device tree blob
- */
-	andi 	$r0,$r2,#0x3
-	li	$r10, 0
-	bne     $r0, $r10, _nodtb
-	lwi	$r0, [$r2]
-	li	$r1, OF_DT_MAGIC
-	bne     $r0, $r1, _nodtb
-	move	$r10, $r2
-_nodtb:
-
-/*
- * Create a temporary mapping area for booting, before start_kernel
- */
-	sethi   $r4, hi20(swapper_pg_dir)
-	li      $p0, (PAGE_OFFSET - PHYS_OFFSET)
-	sub     $r4, $r4, $p0
-	tlbop   FlushAll            ! invalidate TLB\n"
-	isb
-	mtsr    $r4, $L1_PPTB       ! load page table pointer\n"
-
-#ifdef CONFIG_CPU_DCACHE_DISABLE
-	#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_NON
-#else
-	#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-		#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_WT
-	#else
-		#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_WB
-	#endif
-#endif
-
-/* set NTC cacheability, mutliple page size in use */
-	mfsr    $r3, $MMU_CTL
-#if CONFIG_MEMORY_START >= 0xc0000000
-	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC3)
-#elif CONFIG_MEMORY_START >= 0x80000000
-	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC2)
-#elif CONFIG_MEMORY_START >= 0x40000000
-	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC1)
-#else
-	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC0)
-#endif
-
-#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
-	ori     $r3, $r3, #(MMU_CTL_mskMPZIU)
-#else
-	ori     $r3, $r3, #(MMU_CTL_mskMPZIU|MMU_CTL_D8KB)
-#endif
-#ifdef CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS
-	li      $r0, #MMU_CTL_UNA
-	or      $r3, $r3, $r0
-#endif
-	mtsr    $r3, $MMU_CTL
-	isb
-
-/* set page size and size of kernel image */
-        mfsr    $r0, $MMU_CFG
-        srli    $r3, $r0, MMU_CFG_offfEPSZ
-        zeb     $r3, $r3
-        bnez    $r3, _extra_page_size_support
-#ifdef CONFIG_ANDES_PAGE_SIZE_4KB
-        li      $r5, #SZ_4K                 ! Use 4KB page size
-#else
-        li      $r5, #SZ_8K                 ! Use 8KB page size
-        li      $r3, #1
-#endif
-        mtsr    $r3, $TLB_MISC
-        b       _image_size_check
-
-_extra_page_size_support:                    ! Use epzs pages size
-        clz     $r6, $r3
-        subri   $r2, $r6, #31
-        li      $r3, #1
-        sll     $r3, $r3, $r2
-        /* MMU_CFG.EPSZ value -> meaning */
-        mul     $r5, $r3, $r3
-        slli    $r5, $r5, #14
-        /* MMU_CFG.EPSZ  -> TLB_MISC.ACC_PSZ */
-        addi    $r3, $r2, #0x2
-        mtsr    $r3, $TLB_MISC
-
-_image_size_check:
-        /* calculate the image maximum size accepted by TLB config */
-        andi    $r6, $r0, MMU_CFG_mskTBW
-        andi    $r0, $r0, MMU_CFG_mskTBS
-        srli    $r6, $r6, MMU_CFG_offTBW
-        srli    $r0, $r0, MMU_CFG_offTBS
-	addi    $r6, $r6, #0x1               ! MMU_CFG.TBW value -> meaning
-        addi    $r0, $r0, #0x2               ! MMU_CFG.TBS value -> meaning
-        sll     $r0, $r6, $r0                ! entries = k-way * n-set
-        mul     $r6, $r0, $r5                ! max size = entries * page size
-        /* check kernel image size */
-        la      $r3, (_end - PAGE_OFFSET)
-        bgt     $r3, $r6, __error
-
-	li      $r2, #(PHYS_OFFSET + TLB_DATA_kernel_text_attr)
-        li      $r3, PAGE_OFFSET
-        add     $r6, $r6, $r3
-
-_tlb:
-	mtsr    $r3, $TLB_VPN
-	dsb
-	tlbop   $r2, RWR
-	isb
-	add     $r3, $r3, $r5
-	add     $r2, $r2, $r5
-	bgt     $r6, $r3, _tlb
-	mfsr    $r3, $TLB_MISC      ! setup access page size
-	li      $r2, #~0xf
-	and     $r3, $r3, $r2
-#ifdef CONFIG_ANDES_PAGE_SIZE_8KB
-	ori    $r3, $r3, #0x1
-#endif
-	mtsr    $r3, $TLB_MISC
-
-	mfsr    $r0, $MISC_CTL      ! Enable BTB, RTP, shadow sp, and HW_PRE
-	ori     $r0, $r0, #MISC_init
-	mtsr    $r0, $MISC_CTL
-
-	mfsr    $p1, $PSW
-	li      $r15, #~PSW_clr             ! clear WBNA|DME|IME|DT|IT|POM|INTL|GIE
-	and     $p1, $p1, $r15
-	ori     $p1, $p1, #PSW_init
-	mtsr    $p1, $IPSW                  ! when iret, it will automatically enable MMU
-	la      $lp, __mmap_switched
-	mtsr    $lp, $IPC
-	iret
-	nop
-
-	.type   __switch_data, %object
-__switch_data:
-	.long   __bss_start                 ! $r6
-	.long   _end                        ! $r7
-	.long	__atags_pointer 	    ! $atag_pointer
-	.long   init_task                   ! $r9, move to $r25
-	.long   init_thread_union + THREAD_SIZE    ! $sp
-
-
-/*
- * The following fragment of code is executed with the MMU on in MMU mode,
- * and uses absolute addresses; this is not position independent.
- */
-	.align
-	.type   __mmap_switched, %function
-__mmap_switched:
-	la  $r3, __switch_data
-	lmw.bim $r6, [$r3], $r9, #0b0001
-	move	$r25, $r9
-	move    $fp, #0             ! Clear  BSS (and zero $fp)
-	beq $r7, $r6, _RRT
-1:	swi.bi  $fp, [$r6], #4
-	bne $r7, $r6, 1b
-	swi	$r10, [$r8]
-
-_RRT:
-	b   start_kernel
-
-__error:
-	b   __error
diff --git a/arch/nds32/kernel/irq.c b/arch/nds32/kernel/irq.c
deleted file mode 100644
index 6ff5a672be27..000000000000
--- a/arch/nds32/kernel/irq.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/irqchip.h>
-
-void __init init_IRQ(void)
-{
-	irqchip_init();
-}
diff --git a/arch/nds32/kernel/module.c b/arch/nds32/kernel/module.c
deleted file mode 100644
index 3897fd14a21d..000000000000
--- a/arch/nds32/kernel/module.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/module.h>
-#include <linux/elf.h>
-#include <linux/vmalloc.h>
-#include <linux/moduleloader.h>
-#include <linux/pgtable.h>
-
-void *module_alloc(unsigned long size)
-{
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				    GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-
-void module_free(struct module *module, void *region)
-{
-	vfree(region);
-}
-
-int module_frob_arch_sections(Elf_Ehdr * hdr,
-			      Elf_Shdr * sechdrs,
-			      char *secstrings, struct module *mod)
-{
-	return 0;
-}
-
-void do_reloc16(unsigned int val, unsigned int *loc, unsigned int val_mask,
-		unsigned int val_shift, unsigned int loc_mask,
-		unsigned int partial_in_place, unsigned int swap)
-{
-	unsigned int tmp = 0, tmp2 = 0;
-
-	__asm__ __volatile__("\tlhi.bi\t%0, [%2], 0\n"
-			     "\tbeqz\t%3, 1f\n"
-			     "\twsbh\t%0, %1\n"
-			     "1:\n":"=r"(tmp):"0"(tmp), "r"(loc), "r"(swap)
-	    );
-
-	tmp2 = tmp & loc_mask;
-	if (partial_in_place) {
-		tmp &= (~loc_mask);
-		tmp =
-		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
-	} else {
-		tmp = tmp2 | ((val & val_mask) >> val_shift);
-	}
-
-	__asm__ __volatile__("\tbeqz\t%3, 2f\n"
-			     "\twsbh\t%0, %1\n"
-			     "2:\n"
-			     "\tshi.bi\t%0, [%2], 0\n":"=r"(tmp):"0"(tmp),
-			     "r"(loc), "r"(swap)
-	    );
-}
-
-void do_reloc32(unsigned int val, unsigned int *loc, unsigned int val_mask,
-		unsigned int val_shift, unsigned int loc_mask,
-		unsigned int partial_in_place, unsigned int swap)
-{
-	unsigned int tmp = 0, tmp2 = 0;
-
-	__asm__ __volatile__("\tlmw.bi\t%0, [%2], %0, 0\n"
-			     "\tbeqz\t%3, 1f\n"
-			     "\twsbh\t%0, %1\n"
-			     "\trotri\t%0, %1, 16\n"
-			     "1:\n":"=r"(tmp):"0"(tmp), "r"(loc), "r"(swap)
-	    );
-
-	tmp2 = tmp & loc_mask;
-	if (partial_in_place) {
-		tmp &= (~loc_mask);
-		tmp =
-		    tmp2 | ((tmp + ((val & val_mask) >> val_shift)) & val_mask);
-	} else {
-		tmp = tmp2 | ((val & val_mask) >> val_shift);
-	}
-
-	__asm__ __volatile__("\tbeqz\t%3, 2f\n"
-			     "\twsbh\t%0, %1\n"
-			     "\trotri\t%0, %1, 16\n"
-			     "2:\n"
-			     "\tsmw.bi\t%0, [%2], %0, 0\n":"=r"(tmp):"0"(tmp),
-			     "r"(loc), "r"(swap)
-	    );
-}
-
-static inline int exceed_limit(int offset, unsigned int val_mask,
-			       struct module *module, Elf32_Rela * rel,
-			       unsigned int relindex, unsigned int reloc_order)
-{
-	int abs_off = offset < 0 ? ~offset : offset;
-
-	if (abs_off & (~val_mask)) {
-		pr_err("\n%s: relocation type %d out of range.\n"
-		       "please rebuild the kernel module with gcc option \"-Wa,-mno-small-text\".\n",
-		       module->name, ELF32_R_TYPE(rel->r_info));
-		pr_err("section %d reloc %d offset 0x%x relative 0x%x.\n",
-		       relindex, reloc_order, rel->r_offset, offset);
-		return true;
-	}
-	return false;
-}
-
-#ifdef __NDS32_EL__
-#define NEED_SWAP 1
-#else
-#define NEED_SWAP 0
-#endif
-
-int
-apply_relocate_add(Elf32_Shdr * sechdrs, const char *strtab,
-		   unsigned int symindex, unsigned int relindex,
-		   struct module *module)
-{
-	Elf32_Shdr *symsec = sechdrs + symindex;
-	Elf32_Shdr *relsec = sechdrs + relindex;
-	Elf32_Shdr *dstsec = sechdrs + relsec->sh_info;
-	Elf32_Rela *rel = (void *)relsec->sh_addr;
-	unsigned int i;
-
-	for (i = 0; i < relsec->sh_size / sizeof(Elf32_Rela); i++, rel++) {
-		Elf32_Addr *loc;
-		Elf32_Sym *sym;
-		Elf32_Addr v;
-		s32 offset;
-
-		offset = ELF32_R_SYM(rel->r_info);
-		if (offset < 0
-		    || offset > (symsec->sh_size / sizeof(Elf32_Sym))) {
-			pr_err("%s: bad relocation\n", module->name);
-			pr_err("section %d reloc %d\n", relindex, i);
-			return -ENOEXEC;
-		}
-
-		sym = ((Elf32_Sym *) symsec->sh_addr) + offset;
-
-		if (rel->r_offset < 0
-		    || rel->r_offset > dstsec->sh_size - sizeof(u16)) {
-			pr_err("%s: out of bounds relocation\n", module->name);
-			pr_err("section %d reloc %d offset 0x%0x size %d\n",
-			       relindex, i, rel->r_offset, dstsec->sh_size);
-			return -ENOEXEC;
-		}
-
-		loc = (Elf32_Addr *) (dstsec->sh_addr + rel->r_offset);
-		v = sym->st_value + rel->r_addend;
-
-		switch (ELF32_R_TYPE(rel->r_info)) {
-		case R_NDS32_NONE:
-		case R_NDS32_INSN16:
-		case R_NDS32_LABEL:
-		case R_NDS32_LONGCALL1:
-		case R_NDS32_LONGCALL2:
-		case R_NDS32_LONGCALL3:
-		case R_NDS32_LONGCALL4:
-		case R_NDS32_LONGJUMP1:
-		case R_NDS32_LONGJUMP2:
-		case R_NDS32_LONGJUMP3:
-		case R_NDS32_9_FIXED_RELA:
-		case R_NDS32_15_FIXED_RELA:
-		case R_NDS32_17_FIXED_RELA:
-		case R_NDS32_25_FIXED_RELA:
-		case R_NDS32_LOADSTORE:
-		case R_NDS32_DWARF2_OP1_RELA:
-		case R_NDS32_DWARF2_OP2_RELA:
-		case R_NDS32_DWARF2_LEB_RELA:
-		case R_NDS32_RELA_NOP_MIX ... R_NDS32_RELA_NOP_MAX:
-			break;
-
-		case R_NDS32_32_RELA:
-			do_reloc32(v, loc, 0xffffffff, 0, 0, 0, 0);
-			break;
-
-		case R_NDS32_HI20_RELA:
-			do_reloc32(v, loc, 0xfffff000, 12, 0xfff00000, 0,
-				   NEED_SWAP);
-			break;
-
-		case R_NDS32_LO12S3_RELA:
-			do_reloc32(v, loc, 0x00000fff, 3, 0xfffff000, 0,
-				   NEED_SWAP);
-			break;
-
-		case R_NDS32_LO12S2_RELA:
-			do_reloc32(v, loc, 0x00000fff, 2, 0xfffff000, 0,
-				   NEED_SWAP);
-			break;
-
-		case R_NDS32_LO12S1_RELA:
-			do_reloc32(v, loc, 0x00000fff, 1, 0xfffff000, 0,
-				   NEED_SWAP);
-			break;
-
-		case R_NDS32_LO12S0_RELA:
-		case R_NDS32_LO12S0_ORI_RELA:
-			do_reloc32(v, loc, 0x00000fff, 0, 0xfffff000, 0,
-				   NEED_SWAP);
-			break;
-
-		case R_NDS32_9_PCREL_RELA:
-			if (exceed_limit
-			    ((v - (Elf32_Addr) loc), 0x000000ff, module, rel,
-			     relindex, i))
-				return -ENOEXEC;
-			do_reloc16(v - (Elf32_Addr) loc, loc, 0x000001ff, 1,
-				   0xffffff00, 0, NEED_SWAP);
-			break;
-
-		case R_NDS32_15_PCREL_RELA:
-			if (exceed_limit
-			    ((v - (Elf32_Addr) loc), 0x00003fff, module, rel,
-			     relindex, i))
-				return -ENOEXEC;
-			do_reloc32(v - (Elf32_Addr) loc, loc, 0x00007fff, 1,
-				   0xffffc000, 0, NEED_SWAP);
-			break;
-
-		case R_NDS32_17_PCREL_RELA:
-			if (exceed_limit
-			    ((v - (Elf32_Addr) loc), 0x0000ffff, module, rel,
-			     relindex, i))
-				return -ENOEXEC;
-			do_reloc32(v - (Elf32_Addr) loc, loc, 0x0001ffff, 1,
-				   0xffff0000, 0, NEED_SWAP);
-			break;
-
-		case R_NDS32_25_PCREL_RELA:
-			if (exceed_limit
-			    ((v - (Elf32_Addr) loc), 0x00ffffff, module, rel,
-			     relindex, i))
-				return -ENOEXEC;
-			do_reloc32(v - (Elf32_Addr) loc, loc, 0x01ffffff, 1,
-				   0xff000000, 0, NEED_SWAP);
-			break;
-		case R_NDS32_WORD_9_PCREL_RELA:
-			if (exceed_limit
-			    ((v - (Elf32_Addr) loc), 0x000000ff, module, rel,
-			     relindex, i))
-				return -ENOEXEC;
-			do_reloc32(v - (Elf32_Addr) loc, loc, 0x000001ff, 1,
-				   0xffffff00, 0, NEED_SWAP);
-			break;
-
-		case R_NDS32_SDA15S3_RELA:
-		case R_NDS32_SDA15S2_RELA:
-		case R_NDS32_SDA15S1_RELA:
-		case R_NDS32_SDA15S0_RELA:
-			pr_err("%s: unsupported relocation type %d.\n",
-			       module->name, ELF32_R_TYPE(rel->r_info));
-			pr_err
-			    ("Small data section access doesn't work in the kernel space; "
-			     "please rebuild the kernel module with gcc option -mcmodel=large.\n");
-			pr_err("section %d reloc %d offset 0x%x size %d\n",
-			       relindex, i, rel->r_offset, dstsec->sh_size);
-			break;
-
-		default:
-			pr_err("%s: unsupported relocation type %d.\n",
-			       module->name, ELF32_R_TYPE(rel->r_info));
-			pr_err("section %d reloc %d offset 0x%x size %d\n",
-			       relindex, i, rel->r_offset, dstsec->sh_size);
-		}
-	}
-	return 0;
-}
-
-int
-module_finalize(const Elf32_Ehdr * hdr, const Elf_Shdr * sechdrs,
-		struct module *module)
-{
-	return 0;
-}
-
-void module_arch_cleanup(struct module *mod)
-{
-}
diff --git a/arch/nds32/kernel/nds32_ksyms.c b/arch/nds32/kernel/nds32_ksyms.c
deleted file mode 100644
index 20719e42ae36..000000000000
--- a/arch/nds32/kernel/nds32_ksyms.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/delay.h>
-#include <linux/in6.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-
-#include <asm/checksum.h>
-#include <asm/io.h>
-#include <asm/ftrace.h>
-#include <asm/proc-fns.h>
-
-/* mem functions */
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memzero);
-
-/* user mem (segment) */
-EXPORT_SYMBOL(__arch_copy_from_user);
-EXPORT_SYMBOL(__arch_copy_to_user);
-EXPORT_SYMBOL(__arch_clear_user);
diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
deleted file mode 100644
index a78a879e7ef1..000000000000
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ /dev/null
@@ -1,1500 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2008-2017 Andes Technology Corporation
- *
- * Reference ARMv7: Jean Pihet <jpihet@mvista.com>
- * 2010 (c) MontaVista Software, LLC.
- */
-
-#include <linux/perf_event.h>
-#include <linux/bitmap.h>
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/pm_runtime.h>
-#include <linux/ftrace.h>
-#include <linux/uaccess.h>
-#include <linux/sched/clock.h>
-#include <linux/percpu-defs.h>
-
-#include <asm/pmu.h>
-#include <asm/irq_regs.h>
-#include <asm/nds32.h>
-#include <asm/stacktrace.h>
-#include <asm/perf_event.h>
-#include <nds32_intrinsic.h>
-
-/* Set at runtime when we know what CPU type we are. */
-static struct nds32_pmu *cpu_pmu;
-
-static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
-static void nds32_pmu_start(struct nds32_pmu *cpu_pmu);
-static void nds32_pmu_stop(struct nds32_pmu *cpu_pmu);
-static struct platform_device_id cpu_pmu_plat_device_ids[] = {
-	{.name = "nds32-pfm"},
-	{},
-};
-
-static int nds32_pmu_map_cache_event(const unsigned int (*cache_map)
-				  [PERF_COUNT_HW_CACHE_MAX]
-				  [PERF_COUNT_HW_CACHE_OP_MAX]
-				  [PERF_COUNT_HW_CACHE_RESULT_MAX], u64 config)
-{
-	unsigned int cache_type, cache_op, cache_result, ret;
-
-	cache_type = (config >> 0) & 0xff;
-	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
-		return -EINVAL;
-
-	cache_op = (config >> 8) & 0xff;
-	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
-		return -EINVAL;
-
-	cache_result = (config >> 16) & 0xff;
-	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
-		return -EINVAL;
-
-	ret = (int)(*cache_map)[cache_type][cache_op][cache_result];
-
-	if (ret == CACHE_OP_UNSUPPORTED)
-		return -ENOENT;
-
-	return ret;
-}
-
-static int
-nds32_pmu_map_hw_event(const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
-		       u64 config)
-{
-	int mapping;
-
-	if (config >= PERF_COUNT_HW_MAX)
-		return -ENOENT;
-
-	mapping = (*event_map)[config];
-	return mapping == HW_OP_UNSUPPORTED ? -ENOENT : mapping;
-}
-
-static int nds32_pmu_map_raw_event(u32 raw_event_mask, u64 config)
-{
-	int ev_type = (int)(config & raw_event_mask);
-	int idx = config >> 8;
-
-	switch (idx) {
-	case 0:
-		ev_type = PFM_OFFSET_MAGIC_0 + ev_type;
-		if (ev_type >= SPAV3_0_SEL_LAST || ev_type <= SPAV3_0_SEL_BASE)
-			return -ENOENT;
-		break;
-	case 1:
-		ev_type = PFM_OFFSET_MAGIC_1 + ev_type;
-		if (ev_type >= SPAV3_1_SEL_LAST || ev_type <= SPAV3_1_SEL_BASE)
-			return -ENOENT;
-		break;
-	case 2:
-		ev_type = PFM_OFFSET_MAGIC_2 + ev_type;
-		if (ev_type >= SPAV3_2_SEL_LAST || ev_type <= SPAV3_2_SEL_BASE)
-			return -ENOENT;
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	return ev_type;
-}
-
-int
-nds32_pmu_map_event(struct perf_event *event,
-		    const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
-		    const unsigned int (*cache_map)
-		    [PERF_COUNT_HW_CACHE_MAX]
-		    [PERF_COUNT_HW_CACHE_OP_MAX]
-		    [PERF_COUNT_HW_CACHE_RESULT_MAX], u32 raw_event_mask)
-{
-	u64 config = event->attr.config;
-
-	switch (event->attr.type) {
-	case PERF_TYPE_HARDWARE:
-		return nds32_pmu_map_hw_event(event_map, config);
-	case PERF_TYPE_HW_CACHE:
-		return nds32_pmu_map_cache_event(cache_map, config);
-	case PERF_TYPE_RAW:
-		return nds32_pmu_map_raw_event(raw_event_mask, config);
-	}
-
-	return -ENOENT;
-}
-
-static int nds32_spav3_map_event(struct perf_event *event)
-{
-	return nds32_pmu_map_event(event, &nds32_pfm_perf_map,
-				&nds32_pfm_perf_cache_map, SOFTWARE_EVENT_MASK);
-}
-
-static inline u32 nds32_pfm_getreset_flags(void)
-{
-	/* Read overflow status */
-	u32 val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 old_val = val;
-
-	/* Write overflow bit to clear status, and others keep it 0 */
-	u32 ov_flag = PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2];
-
-	__nds32__mtsr(val | ov_flag, NDS32_SR_PFM_CTL);
-
-	return old_val;
-}
-
-static inline int nds32_pfm_has_overflowed(u32 pfm)
-{
-	u32 ov_flag = PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2];
-
-	return pfm & ov_flag;
-}
-
-static inline int nds32_pfm_counter_has_overflowed(u32 pfm, int idx)
-{
-	u32 mask = 0;
-
-	switch (idx) {
-	case 0:
-		mask = PFM_CTL_OVF[0];
-		break;
-	case 1:
-		mask = PFM_CTL_OVF[1];
-		break;
-	case 2:
-		mask = PFM_CTL_OVF[2];
-		break;
-	default:
-		pr_err("%s index wrong\n", __func__);
-		break;
-	}
-	return pfm & mask;
-}
-
-/*
- * Set the next IRQ period, based on the hwc->period_left value.
- * To be called with the event disabled in hw:
- */
-int nds32_pmu_event_set_period(struct perf_event *event)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	s64 left = local64_read(&hwc->period_left);
-	s64 period = hwc->sample_period;
-	int ret = 0;
-
-	/* The period may have been changed by PERF_EVENT_IOC_PERIOD */
-	if (unlikely(period != hwc->last_period))
-		left = period - (hwc->last_period - left);
-
-	if (unlikely(left <= -period)) {
-		left = period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	if (unlikely(left <= 0)) {
-		left += period;
-		local64_set(&hwc->period_left, left);
-		hwc->last_period = period;
-		ret = 1;
-	}
-
-	if (left > (s64)nds32_pmu->max_period)
-		left = nds32_pmu->max_period;
-
-	/*
-	 * The hw event starts counting from this event offset,
-	 * mark it to be able to extract future "deltas":
-	 */
-	local64_set(&hwc->prev_count, (u64)(-left));
-
-	nds32_pmu->write_counter(event, (u64)(-left) & nds32_pmu->max_period);
-
-	perf_event_update_userpage(event);
-
-	return ret;
-}
-
-static irqreturn_t nds32_pmu_handle_irq(int irq_num, void *dev)
-{
-	u32 pfm;
-	struct perf_sample_data data;
-	struct nds32_pmu *cpu_pmu = (struct nds32_pmu *)dev;
-	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
-	struct pt_regs *regs;
-	int idx;
-	/*
-	 * Get and reset the IRQ flags
-	 */
-	pfm = nds32_pfm_getreset_flags();
-
-	/*
-	 * Did an overflow occur?
-	 */
-	if (!nds32_pfm_has_overflowed(pfm))
-		return IRQ_NONE;
-
-	/*
-	 * Handle the counter(s) overflow(s)
-	 */
-	regs = get_irq_regs();
-
-	nds32_pmu_stop(cpu_pmu);
-	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
-		struct perf_event *event = cpuc->events[idx];
-		struct hw_perf_event *hwc;
-
-		/* Ignore if we don't have an event. */
-		if (!event)
-			continue;
-
-		/*
-		 * We have a single interrupt for all counters. Check that
-		 * each counter has overflowed before we process it.
-		 */
-		if (!nds32_pfm_counter_has_overflowed(pfm, idx))
-			continue;
-
-		hwc = &event->hw;
-		nds32_pmu_event_update(event);
-		perf_sample_data_init(&data, 0, hwc->last_period);
-		if (!nds32_pmu_event_set_period(event))
-			continue;
-
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
-	}
-	nds32_pmu_start(cpu_pmu);
-	/*
-	 * Handle the pending perf events.
-	 *
-	 * Note: this call *must* be run with interrupts disabled. For
-	 * platforms that can have the PMU interrupts raised as an NMI, this
-	 * will not work.
-	 */
-	irq_work_run();
-
-	return IRQ_HANDLED;
-}
-
-static inline int nds32_pfm_counter_valid(struct nds32_pmu *cpu_pmu, int idx)
-{
-	return ((idx >= 0) && (idx < cpu_pmu->num_events));
-}
-
-static inline int nds32_pfm_disable_counter(int idx)
-{
-	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 mask = 0;
-
-	mask = PFM_CTL_EN[idx];
-	val &= ~mask;
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-	return idx;
-}
-
-/*
- * Add an event filter to a given event.
- */
-static int nds32_pmu_set_event_filter(struct hw_perf_event *event,
-				      struct perf_event_attr *attr)
-{
-	unsigned long config_base = 0;
-	int idx = event->idx;
-	unsigned long no_kernel_tracing = 0;
-	unsigned long no_user_tracing = 0;
-	/* If index is -1, do not do anything */
-	if (idx == -1)
-		return 0;
-
-	no_kernel_tracing = PFM_CTL_KS[idx];
-	no_user_tracing = PFM_CTL_KU[idx];
-	/*
-	 * Default: enable both kernel and user mode tracing.
-	 */
-	if (attr->exclude_user)
-		config_base |= no_user_tracing;
-
-	if (attr->exclude_kernel)
-		config_base |= no_kernel_tracing;
-
-	/*
-	 * Install the filter into config_base as this is used to
-	 * construct the event type.
-	 */
-	event->config_base |= config_base;
-	return 0;
-}
-
-static inline void nds32_pfm_write_evtsel(int idx, u32 evnum)
-{
-	u32 offset = 0;
-	u32 ori_val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 ev_mask = 0;
-	u32 no_kernel_mask = 0;
-	u32 no_user_mask = 0;
-	u32 val;
-
-	offset = PFM_CTL_OFFSEL[idx];
-	/* Clear previous mode selection, and write new one */
-	no_kernel_mask = PFM_CTL_KS[idx];
-	no_user_mask = PFM_CTL_KU[idx];
-	ori_val &= ~no_kernel_mask;
-	ori_val &= ~no_user_mask;
-	if (evnum & no_kernel_mask)
-		ori_val |= no_kernel_mask;
-
-	if (evnum & no_user_mask)
-		ori_val |= no_user_mask;
-
-	/* Clear previous event selection */
-	ev_mask = PFM_CTL_SEL[idx];
-	ori_val &= ~ev_mask;
-	evnum &= SOFTWARE_EVENT_MASK;
-
-	/* undo the linear mapping */
-	evnum = get_converted_evet_hw_num(evnum);
-	val = ori_val | (evnum << offset);
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-}
-
-static inline int nds32_pfm_enable_counter(int idx)
-{
-	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 mask = 0;
-
-	mask = PFM_CTL_EN[idx];
-	val |= mask;
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-	return idx;
-}
-
-static inline int nds32_pfm_enable_intens(int idx)
-{
-	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 mask = 0;
-
-	mask = PFM_CTL_IE[idx];
-	val |= mask;
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-	return idx;
-}
-
-static inline int nds32_pfm_disable_intens(int idx)
-{
-	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	u32 mask = 0;
-
-	mask = PFM_CTL_IE[idx];
-	val &= ~mask;
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-	return idx;
-}
-
-static int event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	/* Other modes NDS32 does not support */
-	return attr->exclude_user || attr->exclude_kernel;
-}
-
-static void nds32_pmu_enable_event(struct perf_event *event)
-{
-	unsigned long flags;
-	unsigned int evnum = 0;
-	struct hw_perf_event *hwc = &event->hw;
-	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-	int idx = hwc->idx;
-
-	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
-		pr_err("CPU enabling wrong pfm counter IRQ enable\n");
-		return;
-	}
-
-	/*
-	 * Enable counter and interrupt, and set the counter to count
-	 * the event that we're interested in.
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
-	 * Disable counter
-	 */
-	nds32_pfm_disable_counter(idx);
-
-	/*
-	 * Check whether we need to exclude the counter from certain modes.
-	 */
-	if ((!cpu_pmu->set_event_filter ||
-	     cpu_pmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
-		pr_notice
-		("NDS32 performance counters do not support mode exclusion\n");
-		hwc->config_base = 0;
-	}
-	/* Write event */
-	evnum = hwc->config_base;
-	nds32_pfm_write_evtsel(idx, evnum);
-
-	/*
-	 * Enable interrupt for this counter
-	 */
-	nds32_pfm_enable_intens(idx);
-
-	/*
-	 * Enable counter
-	 */
-	nds32_pfm_enable_counter(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void nds32_pmu_disable_event(struct perf_event *event)
-{
-	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
-	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-	int idx = hwc->idx;
-
-	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
-		pr_err("CPU disabling wrong pfm counter IRQ enable %d\n", idx);
-		return;
-	}
-
-	/*
-	 * Disable counter and interrupt
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/*
-	 * Disable counter
-	 */
-	nds32_pfm_disable_counter(idx);
-
-	/*
-	 * Disable interrupt for this counter
-	 */
-	nds32_pfm_disable_intens(idx);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static inline u32 nds32_pmu_read_counter(struct perf_event *event)
-{
-	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
-	u32 count = 0;
-
-	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
-		pr_err("CPU reading wrong counter %d\n", idx);
-	} else {
-		switch (idx) {
-		case PFMC0:
-			count = __nds32__mfsr(NDS32_SR_PFMC0);
-			break;
-		case PFMC1:
-			count = __nds32__mfsr(NDS32_SR_PFMC1);
-			break;
-		case PFMC2:
-			count = __nds32__mfsr(NDS32_SR_PFMC2);
-			break;
-		default:
-			pr_err
-			    ("%s: CPU has no performance counters %d\n",
-			     __func__, idx);
-		}
-	}
-	return count;
-}
-
-static inline void nds32_pmu_write_counter(struct perf_event *event, u32 value)
-{
-	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
-
-	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
-		pr_err("CPU writing wrong counter %d\n", idx);
-	} else {
-		switch (idx) {
-		case PFMC0:
-			__nds32__mtsr_isb(value, NDS32_SR_PFMC0);
-			break;
-		case PFMC1:
-			__nds32__mtsr_isb(value, NDS32_SR_PFMC1);
-			break;
-		case PFMC2:
-			__nds32__mtsr_isb(value, NDS32_SR_PFMC2);
-			break;
-		default:
-			pr_err
-			    ("%s: CPU has no performance counters %d\n",
-			     __func__, idx);
-		}
-	}
-}
-
-static int nds32_pmu_get_event_idx(struct pmu_hw_events *cpuc,
-				   struct perf_event *event)
-{
-	int idx;
-	struct hw_perf_event *hwc = &event->hw;
-	/*
-	 * Current implementation maps cycles, instruction count and cache-miss
-	 * to specific counter.
-	 * However, multiple of the 3 counters are able to count these events.
-	 *
-	 *
-	 * SOFTWARE_EVENT_MASK mask for getting event num ,
-	 * This is defined by Jia-Rung, you can change the polocies.
-	 * However, do not exceed 8 bits. This is hardware specific.
-	 * The last number is SPAv3_2_SEL_LAST.
-	 */
-	unsigned long evtype = hwc->config_base & SOFTWARE_EVENT_MASK;
-
-	idx = get_converted_event_idx(evtype);
-	/*
-	 * Try to get the counter for correpsonding event
-	 */
-	if (evtype == SPAV3_0_SEL_TOTAL_CYCLES) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-		if (!test_and_set_bit(NDS32_IDX_COUNTER0, cpuc->used_mask))
-			return NDS32_IDX_COUNTER0;
-		if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
-			return NDS32_IDX_COUNTER1;
-	} else if (evtype == SPAV3_1_SEL_COMPLETED_INSTRUCTION) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-		else if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
-			return NDS32_IDX_COUNTER1;
-		else if (!test_and_set_bit
-			 (NDS32_IDX_CYCLE_COUNTER, cpuc->used_mask))
-			return NDS32_IDX_CYCLE_COUNTER;
-	} else {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
-	return -EAGAIN;
-}
-
-static void nds32_pmu_start(struct nds32_pmu *cpu_pmu)
-{
-	unsigned long flags;
-	unsigned int val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/* Enable all counters , NDS PFM has 3 counters */
-	val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	val |= (PFM_CTL_EN[0] | PFM_CTL_EN[1] | PFM_CTL_EN[2]);
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void nds32_pmu_stop(struct nds32_pmu *cpu_pmu)
-{
-	unsigned long flags;
-	unsigned int val;
-	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
-	/* Disable all counters , NDS PFM has 3 counters */
-	val = __nds32__mfsr(NDS32_SR_PFM_CTL);
-	val &= ~(PFM_CTL_EN[0] | PFM_CTL_EN[1] | PFM_CTL_EN[2]);
-	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-}
-
-static void nds32_pmu_reset(void *info)
-{
-	u32 val = 0;
-
-	val |= (PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
-	__nds32__mtsr(val, NDS32_SR_PFM_CTL);
-	__nds32__mtsr(0, NDS32_SR_PFM_CTL);
-	__nds32__mtsr(0, NDS32_SR_PFMC0);
-	__nds32__mtsr(0, NDS32_SR_PFMC1);
-	__nds32__mtsr(0, NDS32_SR_PFMC2);
-}
-
-static void nds32_pmu_init(struct nds32_pmu *cpu_pmu)
-{
-	cpu_pmu->handle_irq = nds32_pmu_handle_irq;
-	cpu_pmu->enable = nds32_pmu_enable_event;
-	cpu_pmu->disable = nds32_pmu_disable_event;
-	cpu_pmu->read_counter = nds32_pmu_read_counter;
-	cpu_pmu->write_counter = nds32_pmu_write_counter;
-	cpu_pmu->get_event_idx = nds32_pmu_get_event_idx;
-	cpu_pmu->start = nds32_pmu_start;
-	cpu_pmu->stop = nds32_pmu_stop;
-	cpu_pmu->reset = nds32_pmu_reset;
-	cpu_pmu->max_period = 0xFFFFFFFF;	/* Maximum counts */
-};
-
-static u32 nds32_read_num_pfm_events(void)
-{
-	/* NDS32 SPAv3 PMU support 3 counter */
-	return 3;
-}
-
-static int device_pmu_init(struct nds32_pmu *cpu_pmu)
-{
-	nds32_pmu_init(cpu_pmu);
-	/*
-	 * This name should be devive-specific name, whatever you like :)
-	 * I think "PMU" will be a good generic name.
-	 */
-	cpu_pmu->name = "nds32v3-pmu";
-	cpu_pmu->map_event = nds32_spav3_map_event;
-	cpu_pmu->num_events = nds32_read_num_pfm_events();
-	cpu_pmu->set_event_filter = nds32_pmu_set_event_filter;
-	return 0;
-}
-
-/*
- * CPU PMU identification and probing.
- */
-static int probe_current_pmu(struct nds32_pmu *pmu)
-{
-	int ret;
-
-	get_cpu();
-	ret = -ENODEV;
-	/*
-	 * If ther are various CPU types with its own PMU, initialize with
-	 *
-	 * the corresponding one
-	 */
-	device_pmu_init(pmu);
-	put_cpu();
-	return ret;
-}
-
-static void nds32_pmu_enable(struct pmu *pmu)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(pmu);
-	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
-	int enabled = bitmap_weight(hw_events->used_mask,
-				    nds32_pmu->num_events);
-
-	if (enabled)
-		nds32_pmu->start(nds32_pmu);
-}
-
-static void nds32_pmu_disable(struct pmu *pmu)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(pmu);
-
-	nds32_pmu->stop(nds32_pmu);
-}
-
-static void nds32_pmu_release_hardware(struct nds32_pmu *nds32_pmu)
-{
-	nds32_pmu->free_irq(nds32_pmu);
-	pm_runtime_put_sync(&nds32_pmu->plat_device->dev);
-}
-
-static irqreturn_t nds32_pmu_dispatch_irq(int irq, void *dev)
-{
-	struct nds32_pmu *nds32_pmu = (struct nds32_pmu *)dev;
-	int ret;
-	u64 start_clock, finish_clock;
-
-	start_clock = local_clock();
-	ret = nds32_pmu->handle_irq(irq, dev);
-	finish_clock = local_clock();
-
-	perf_sample_event_took(finish_clock - start_clock);
-	return ret;
-}
-
-static int nds32_pmu_reserve_hardware(struct nds32_pmu *nds32_pmu)
-{
-	int err;
-	struct platform_device *pmu_device = nds32_pmu->plat_device;
-
-	if (!pmu_device)
-		return -ENODEV;
-
-	pm_runtime_get_sync(&pmu_device->dev);
-	err = nds32_pmu->request_irq(nds32_pmu, nds32_pmu_dispatch_irq);
-	if (err) {
-		nds32_pmu_release_hardware(nds32_pmu);
-		return err;
-	}
-
-	return 0;
-}
-
-static int
-validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
-	       struct perf_event *event)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-
-	if (is_software_event(event))
-		return 1;
-
-	if (event->pmu != pmu)
-		return 0;
-
-	if (event->state < PERF_EVENT_STATE_OFF)
-		return 1;
-
-	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
-		return 1;
-
-	return nds32_pmu->get_event_idx(hw_events, event) >= 0;
-}
-
-static int validate_group(struct perf_event *event)
-{
-	struct perf_event *sibling, *leader = event->group_leader;
-	struct pmu_hw_events fake_pmu;
-	DECLARE_BITMAP(fake_used_mask, MAX_COUNTERS);
-	/*
-	 * Initialize the fake PMU. We only need to populate the
-	 * used_mask for the purposes of validation.
-	 */
-	memset(fake_used_mask, 0, sizeof(fake_used_mask));
-
-	if (!validate_event(event->pmu, &fake_pmu, leader))
-		return -EINVAL;
-
-	for_each_sibling_event(sibling, leader) {
-		if (!validate_event(event->pmu, &fake_pmu, sibling))
-			return -EINVAL;
-	}
-
-	if (!validate_event(event->pmu, &fake_pmu, event))
-		return -EINVAL;
-
-	return 0;
-}
-
-static int __hw_perf_event_init(struct perf_event *event)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	int mapping;
-
-	mapping = nds32_pmu->map_event(event);
-
-	if (mapping < 0) {
-		pr_debug("event %x:%llx not supported\n", event->attr.type,
-			 event->attr.config);
-		return mapping;
-	}
-
-	/*
-	 * We don't assign an index until we actually place the event onto
-	 * hardware. Use -1 to signify that we haven't decided where to put it
-	 * yet. For SMP systems, each core has it's own PMU so we can't do any
-	 * clever allocation or constraints checking at this point.
-	 */
-	hwc->idx = -1;
-	hwc->config_base = 0;
-	hwc->config = 0;
-	hwc->event_base = 0;
-
-	/*
-	 * Check whether we need to exclude the counter from certain modes.
-	 */
-	if ((!nds32_pmu->set_event_filter ||
-	     nds32_pmu->set_event_filter(hwc, &event->attr)) &&
-	    event_requires_mode_exclusion(&event->attr)) {
-		pr_debug
-			("NDS performance counters do not support mode exclusion\n");
-		return -EOPNOTSUPP;
-	}
-
-	/*
-	 * Store the event encoding into the config_base field.
-	 */
-	hwc->config_base |= (unsigned long)mapping;
-
-	if (!hwc->sample_period) {
-		/*
-		 * For non-sampling runs, limit the sample_period to half
-		 * of the counter width. That way, the new counter value
-		 * is far less likely to overtake the previous one unless
-		 * you have some serious IRQ latency issues.
-		 */
-		hwc->sample_period = nds32_pmu->max_period >> 1;
-		hwc->last_period = hwc->sample_period;
-		local64_set(&hwc->period_left, hwc->sample_period);
-	}
-
-	if (event->group_leader != event) {
-		if (validate_group(event) != 0)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int nds32_pmu_event_init(struct perf_event *event)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	int err = 0;
-	atomic_t *active_events = &nds32_pmu->active_events;
-
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
-		return -EOPNOTSUPP;
-
-	if (nds32_pmu->map_event(event) == -ENOENT)
-		return -ENOENT;
-
-	if (!atomic_inc_not_zero(active_events)) {
-		if (atomic_read(active_events) == 0) {
-			/* Register irq handler */
-			err = nds32_pmu_reserve_hardware(nds32_pmu);
-		}
-
-		if (!err)
-			atomic_inc(active_events);
-	}
-
-	if (err)
-		return err;
-
-	err = __hw_perf_event_init(event);
-
-	return err;
-}
-
-static void nds32_start(struct perf_event *event, int flags)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	/*
-	 * NDS pmu always has to reprogram the period, so ignore
-	 * PERF_EF_RELOAD, see the comment below.
-	 */
-	if (flags & PERF_EF_RELOAD)
-		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
-
-	hwc->state = 0;
-	/* Set the period for the event. */
-	nds32_pmu_event_set_period(event);
-
-	nds32_pmu->enable(event);
-}
-
-static int nds32_pmu_add(struct perf_event *event, int flags)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
-	struct hw_perf_event *hwc = &event->hw;
-	int idx;
-	int err = 0;
-
-	perf_pmu_disable(event->pmu);
-
-	/* If we don't have a space for the counter then finish early. */
-	idx = nds32_pmu->get_event_idx(hw_events, event);
-	if (idx < 0) {
-		err = idx;
-		goto out;
-	}
-
-	/*
-	 * If there is an event in the counter we are going to use then make
-	 * sure it is disabled.
-	 */
-	event->hw.idx = idx;
-	nds32_pmu->disable(event);
-	hw_events->events[idx] = event;
-
-	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	if (flags & PERF_EF_START)
-		nds32_start(event, PERF_EF_RELOAD);
-
-	/* Propagate our changes to the userspace mapping. */
-	perf_event_update_userpage(event);
-
-out:
-	perf_pmu_enable(event->pmu);
-	return err;
-}
-
-u64 nds32_pmu_event_update(struct perf_event *event)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	u64 delta, prev_raw_count, new_raw_count;
-
-again:
-	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = nds32_pmu->read_counter(event);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count) {
-		goto again;
-	}
-	/*
-	 * Whether overflow or not, "unsigned substraction"
-	 * will always get their delta
-	 */
-	delta = (new_raw_count - prev_raw_count) & nds32_pmu->max_period;
-
-	local64_add(delta, &event->count);
-	local64_sub(delta, &hwc->period_left);
-
-	return new_raw_count;
-}
-
-static void nds32_stop(struct perf_event *event, int flags)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
-	/*
-	 * NDS pmu always has to update the counter, so ignore
-	 * PERF_EF_UPDATE, see comments in nds32_start().
-	 */
-	if (!(hwc->state & PERF_HES_STOPPED)) {
-		nds32_pmu->disable(event);
-		nds32_pmu_event_update(event);
-		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
-	}
-}
-
-static void nds32_pmu_del(struct perf_event *event, int flags)
-{
-	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
-	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
-	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
-
-	nds32_stop(event, PERF_EF_UPDATE);
-	hw_events->events[idx] = NULL;
-	clear_bit(idx, hw_events->used_mask);
-
-	perf_event_update_userpage(event);
-}
-
-static void nds32_pmu_read(struct perf_event *event)
-{
-	nds32_pmu_event_update(event);
-}
-
-/* Please refer to SPAv3 for more hardware specific details */
-PMU_FORMAT_ATTR(event, "config:0-63");
-
-static struct attribute *nds32_arch_formats_attr[] = {
-	&format_attr_event.attr,
-	NULL,
-};
-
-static struct attribute_group nds32_pmu_format_group = {
-	.name = "format",
-	.attrs = nds32_arch_formats_attr,
-};
-
-static ssize_t nds32_pmu_cpumask_show(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	return 0;
-}
-
-static DEVICE_ATTR(cpus, 0444, nds32_pmu_cpumask_show, NULL);
-
-static struct attribute *nds32_pmu_common_attrs[] = {
-	&dev_attr_cpus.attr,
-	NULL,
-};
-
-static struct attribute_group nds32_pmu_common_group = {
-	.attrs = nds32_pmu_common_attrs,
-};
-
-static const struct attribute_group *nds32_pmu_attr_groups[] = {
-	&nds32_pmu_format_group,
-	&nds32_pmu_common_group,
-	NULL,
-};
-
-static void nds32_init(struct nds32_pmu *nds32_pmu)
-{
-	atomic_set(&nds32_pmu->active_events, 0);
-
-	nds32_pmu->pmu = (struct pmu) {
-		.pmu_enable = nds32_pmu_enable,
-		.pmu_disable = nds32_pmu_disable,
-		.attr_groups = nds32_pmu_attr_groups,
-		.event_init = nds32_pmu_event_init,
-		.add = nds32_pmu_add,
-		.del = nds32_pmu_del,
-		.start = nds32_start,
-		.stop = nds32_stop,
-		.read = nds32_pmu_read,
-	};
-}
-
-int nds32_pmu_register(struct nds32_pmu *nds32_pmu, int type)
-{
-	nds32_init(nds32_pmu);
-	pm_runtime_enable(&nds32_pmu->plat_device->dev);
-	pr_info("enabled with %s PMU driver, %d counters available\n",
-		nds32_pmu->name, nds32_pmu->num_events);
-	return perf_pmu_register(&nds32_pmu->pmu, nds32_pmu->name, type);
-}
-
-static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
-{
-	return this_cpu_ptr(&cpu_hw_events);
-}
-
-static int cpu_pmu_request_irq(struct nds32_pmu *cpu_pmu, irq_handler_t handler)
-{
-	int err, irq, irqs;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
-
-	if (!pmu_device)
-		return -ENODEV;
-
-	irqs = min(pmu_device->num_resources, num_possible_cpus());
-	if (irqs < 1) {
-		pr_err("no irqs for PMUs defined\n");
-		return -ENODEV;
-	}
-
-	irq = platform_get_irq(pmu_device, 0);
-	err = request_irq(irq, handler, IRQF_NOBALANCING, "nds32-pfm",
-			  cpu_pmu);
-	if (err) {
-		pr_err("unable to request IRQ%d for NDS PMU counters\n",
-		       irq);
-		return err;
-	}
-	return 0;
-}
-
-static void cpu_pmu_free_irq(struct nds32_pmu *cpu_pmu)
-{
-	int irq;
-	struct platform_device *pmu_device = cpu_pmu->plat_device;
-
-	irq = platform_get_irq(pmu_device, 0);
-	if (irq >= 0)
-		free_irq(irq, cpu_pmu);
-}
-
-static void cpu_pmu_init(struct nds32_pmu *cpu_pmu)
-{
-	int cpu;
-	struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
-
-	raw_spin_lock_init(&events->pmu_lock);
-
-	cpu_pmu->get_hw_events = cpu_pmu_get_cpu_events;
-	cpu_pmu->request_irq = cpu_pmu_request_irq;
-	cpu_pmu->free_irq = cpu_pmu_free_irq;
-
-	/* Ensure the PMU has sane values out of reset. */
-	if (cpu_pmu->reset)
-		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
-}
-
-static const struct of_device_id cpu_pmu_of_device_ids[] = {
-	{.compatible = "andestech,nds32v3-pmu",
-	 .data = device_pmu_init},
-	{},
-};
-
-static int cpu_pmu_device_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *of_id;
-	int (*init_fn)(struct nds32_pmu *nds32_pmu);
-	struct device_node *node = pdev->dev.of_node;
-	struct nds32_pmu *pmu;
-	int ret = -ENODEV;
-
-	if (cpu_pmu) {
-		pr_notice("[perf] attempt to register multiple PMU devices!\n");
-		return -ENOSPC;
-	}
-
-	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
-	if (!pmu)
-		return -ENOMEM;
-
-	of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node);
-	if (node && of_id) {
-		init_fn = of_id->data;
-		ret = init_fn(pmu);
-	} else {
-		ret = probe_current_pmu(pmu);
-	}
-
-	if (ret) {
-		pr_notice("[perf] failed to probe PMU!\n");
-		goto out_free;
-	}
-
-	cpu_pmu = pmu;
-	cpu_pmu->plat_device = pdev;
-	cpu_pmu_init(cpu_pmu);
-	ret = nds32_pmu_register(cpu_pmu, PERF_TYPE_RAW);
-
-	if (!ret)
-		return 0;
-
-out_free:
-	pr_notice("[perf] failed to register PMU devices!\n");
-	kfree(pmu);
-	return ret;
-}
-
-static struct platform_driver cpu_pmu_driver = {
-	.driver = {
-		   .name = "nds32-pfm",
-		   .of_match_table = cpu_pmu_of_device_ids,
-		   },
-	.probe = cpu_pmu_device_probe,
-	.id_table = cpu_pmu_plat_device_ids,
-};
-
-static int __init register_pmu_driver(void)
-{
-	int err = 0;
-
-	err = platform_driver_register(&cpu_pmu_driver);
-	if (err)
-		pr_notice("[perf] PMU initialization failed\n");
-	else
-		pr_notice("[perf] PMU initialization done\n");
-
-	return err;
-}
-
-device_initcall(register_pmu_driver);
-
-/*
- * References: arch/nds32/kernel/traps.c:__dump()
- * You will need to know the NDS ABI first.
- */
-static int unwind_frame_kernel(struct stackframe *frame)
-{
-	int graph = 0;
-#ifdef CONFIG_FRAME_POINTER
-	/* 0x3 means misalignment */
-	if (!kstack_end((void *)frame->fp) &&
-	    !((unsigned long)frame->fp & 0x3) &&
-	    ((unsigned long)frame->fp >= TASK_SIZE)) {
-		/*
-		 *	The array index is based on the ABI, the below graph
-		 *	illustrate the reasons.
-		 *	Function call procedure: "smw" and "lmw" will always
-		 *	update SP and FP for you automatically.
-		 *
-		 *	Stack                                 Relative Address
-		 *	|  |                                          0
-		 *	----
-		 *	|LP| <-- SP(before smw)  <-- FP(after smw)   -1
-		 *	----
-		 *	|FP|                                         -2
-		 *	----
-		 *	|  | <-- SP(after smw)                       -3
-		 */
-		frame->lp = ((unsigned long *)frame->fp)[-1];
-		frame->fp = ((unsigned long *)frame->fp)[FP_OFFSET];
-		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
-		if (__kernel_text_address(frame->lp))
-			frame->lp = ftrace_graph_ret_addr
-						(NULL, &graph, frame->lp, NULL);
-
-		return 0;
-	} else {
-		return -EPERM;
-	}
-#else
-	/*
-	 * You can refer to arch/nds32/kernel/traps.c:__dump()
-	 * Treat "sp" as "fp", but the "sp" is one frame ahead of "fp".
-	 * And, the "sp" is not always correct.
-	 *
-	 *   Stack                                 Relative Address
-	 *   |  |                                          0
-	 *   ----
-	 *   |LP| <-- SP(before smw)                      -1
-	 *   ----
-	 *   |  | <-- SP(after smw)                       -2
-	 *   ----
-	 */
-	if (!kstack_end((void *)frame->sp)) {
-		frame->lp = ((unsigned long *)frame->sp)[1];
-		/* TODO: How to deal with the value in first
-		 * "sp" is not correct?
-		 */
-		if (__kernel_text_address(frame->lp))
-			frame->lp = ftrace_graph_ret_addr
-						(tsk, &graph, frame->lp, NULL);
-
-		frame->sp = ((unsigned long *)frame->sp) + 1;
-
-		return 0;
-	} else {
-		return -EPERM;
-	}
-#endif
-}
-
-static void notrace
-walk_stackframe(struct stackframe *frame,
-		int (*fn_record)(struct stackframe *, void *),
-		void *data)
-{
-	while (1) {
-		int ret;
-
-		if (fn_record(frame, data))
-			break;
-
-		ret = unwind_frame_kernel(frame);
-		if (ret < 0)
-			break;
-	}
-}
-
-/*
- * Gets called by walk_stackframe() for every stackframe. This will be called
- * whist unwinding the stackframe and is like a subroutine return so we use
- * the PC.
- */
-static int callchain_trace(struct stackframe *fr, void *data)
-{
-	struct perf_callchain_entry_ctx *entry = data;
-
-	perf_callchain_store(entry, fr->lp);
-	return 0;
-}
-
-/*
- * Get the return address for a single stackframe and return a pointer to the
- * next frame tail.
- */
-static unsigned long
-user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp)
-{
-	struct frame_tail buftail;
-	unsigned long lp = 0;
-	unsigned long *user_frame_tail =
-		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
-
-	/* Check accessibility of one struct frame_tail beyond */
-	if (!access_ok(user_frame_tail, sizeof(buftail)))
-		return 0;
-	if (__copy_from_user_inatomic
-		(&buftail, user_frame_tail, sizeof(buftail)))
-		return 0;
-
-	/*
-	 * Refer to unwind_frame_kernel() for more illurstration
-	 */
-	lp = buftail.stack_lp;  /* ((unsigned long *)fp)[-1] */
-	fp = buftail.stack_fp;  /* ((unsigned long *)fp)[FP_OFFSET] */
-	perf_callchain_store(entry, lp);
-	return fp;
-}
-
-static unsigned long
-user_backtrace_opt_size(struct perf_callchain_entry_ctx *entry,
-			unsigned long fp)
-{
-	struct frame_tail_opt_size buftail;
-	unsigned long lp = 0;
-
-	unsigned long *user_frame_tail =
-		(unsigned long *)(fp - (unsigned long)sizeof(buftail));
-
-	/* Check accessibility of one struct frame_tail beyond */
-	if (!access_ok(user_frame_tail, sizeof(buftail)))
-		return 0;
-	if (__copy_from_user_inatomic
-		(&buftail, user_frame_tail, sizeof(buftail)))
-		return 0;
-
-	/*
-	 * Refer to unwind_frame_kernel() for more illurstration
-	 */
-	lp = buftail.stack_lp;  /* ((unsigned long *)fp)[-1] */
-	fp = buftail.stack_fp;  /* ((unsigned long *)fp)[FP_OFFSET] */
-
-	perf_callchain_store(entry, lp);
-	return fp;
-}
-
-/*
- * This will be called when the target is in user mode
- * This function will only be called when we use
- * "PERF_SAMPLE_CALLCHAIN" in
- * kernel/events/core.c:perf_prepare_sample()
- *
- * How to trigger perf_callchain_[user/kernel] :
- * $ perf record -e cpu-clock --call-graph fp ./program
- * $ perf report --call-graph
- */
-unsigned long leaf_fp;
-void
-perf_callchain_user(struct perf_callchain_entry_ctx *entry,
-		    struct pt_regs *regs)
-{
-	unsigned long fp = 0;
-	unsigned long gp = 0;
-	unsigned long lp = 0;
-	unsigned long sp = 0;
-	unsigned long *user_frame_tail;
-
-	leaf_fp = 0;
-
-	perf_callchain_store(entry, regs->ipc);
-	fp = regs->fp;
-	gp = regs->gp;
-	lp = regs->lp;
-	sp = regs->sp;
-	if (entry->nr < PERF_MAX_STACK_DEPTH &&
-	    (unsigned long)fp && !((unsigned long)fp & 0x7) && fp > sp) {
-		user_frame_tail =
-			(unsigned long *)(fp - (unsigned long)sizeof(fp));
-
-		if (!access_ok(user_frame_tail, sizeof(fp)))
-			return;
-
-		if (__copy_from_user_inatomic
-			(&leaf_fp, user_frame_tail, sizeof(fp)))
-			return;
-
-		if (leaf_fp == lp) {
-			/*
-			 * Maybe this is non leaf function
-			 * with optimize for size,
-			 * or maybe this is the function
-			 * with optimize for size
-			 */
-			struct frame_tail buftail;
-
-			user_frame_tail =
-				(unsigned long *)(fp -
-					(unsigned long)sizeof(buftail));
-
-			if (!access_ok(user_frame_tail, sizeof(buftail)))
-				return;
-
-			if (__copy_from_user_inatomic
-				(&buftail, user_frame_tail, sizeof(buftail)))
-				return;
-
-			if (buftail.stack_fp == gp) {
-				/* non leaf function with optimize
-				 * for size condition
-				 */
-				struct frame_tail_opt_size buftail_opt_size;
-
-				user_frame_tail =
-					(unsigned long *)(fp - (unsigned long)
-						sizeof(buftail_opt_size));
-
-				if (!access_ok(user_frame_tail,
-					       sizeof(buftail_opt_size)))
-					return;
-
-				if (__copy_from_user_inatomic
-				   (&buftail_opt_size, user_frame_tail,
-				   sizeof(buftail_opt_size)))
-					return;
-
-				perf_callchain_store(entry, lp);
-				fp = buftail_opt_size.stack_fp;
-
-				while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-				       (unsigned long)fp &&
-						!((unsigned long)fp & 0x7) &&
-						fp > sp) {
-					sp = fp;
-					fp = user_backtrace_opt_size(entry, fp);
-				}
-
-			} else {
-				/* this is the function
-				 * without optimize for size
-				 */
-				fp = buftail.stack_fp;
-				perf_callchain_store(entry, lp);
-				while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-				       (unsigned long)fp &&
-						!((unsigned long)fp & 0x7) &&
-						fp > sp) {
-					sp = fp;
-					fp = user_backtrace(entry, fp);
-				}
-			}
-		} else {
-			/* this is leaf function */
-			fp = leaf_fp;
-			perf_callchain_store(entry, lp);
-
-			/* previous function callcahin  */
-			while ((entry->nr < PERF_MAX_STACK_DEPTH) &&
-			       (unsigned long)fp &&
-				   !((unsigned long)fp & 0x7) && fp > sp) {
-				sp = fp;
-				fp = user_backtrace(entry, fp);
-			}
-		}
-		return;
-	}
-}
-
-/* This will be called when the target is in kernel mode */
-void
-perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
-		      struct pt_regs *regs)
-{
-	struct stackframe fr;
-
-	fr.fp = regs->fp;
-	fr.lp = regs->lp;
-	fr.sp = regs->sp;
-	walk_stackframe(&fr, callchain_trace, entry);
-}
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}
diff --git a/arch/nds32/kernel/pm.c b/arch/nds32/kernel/pm.c
deleted file mode 100644
index e25700e125d8..000000000000
--- a/arch/nds32/kernel/pm.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2008-2017 Andes Technology Corporation
-
-#include <linux/init.h>
-#include <linux/suspend.h>
-#include <linux/device.h>
-#include <linux/printk.h>
-#include <asm/suspend.h>
-#include <nds32_intrinsic.h>
-
-unsigned int resume_addr;
-unsigned int *phy_addr_sp_tmp;
-
-static void nds32_suspend2ram(void)
-{
-	pgd_t *pgdv;
-	p4d_t *p4dv;
-	pud_t *pudv;
-	pmd_t *pmdv;
-	pte_t *ptev;
-
-	pgdv = (pgd_t *)__va((__nds32__mfsr(NDS32_SR_L1_PPTB) &
-		L1_PPTB_mskBASE)) + pgd_index((unsigned int)cpu_resume);
-
-	p4dv = p4d_offset(pgdv, (unsigned int)cpu_resume);
-	pudv = pud_offset(p4dv, (unsigned int)cpu_resume);
-	pmdv = pmd_offset(pudv, (unsigned int)cpu_resume);
-	ptev = pte_offset_map(pmdv, (unsigned int)cpu_resume);
-
-	resume_addr = ((*ptev) & TLB_DATA_mskPPN)
-			| ((unsigned int)cpu_resume & 0x00000fff);
-
-	suspend2ram();
-}
-
-static void nds32_suspend_cpu(void)
-{
-	while (!(__nds32__mfsr(NDS32_SR_INT_PEND) & wake_mask))
-		__asm__ volatile ("standby no_wake_grant\n\t");
-}
-
-static int nds32_pm_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_ON:
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-static int nds32_pm_enter(suspend_state_t state)
-{
-	pr_debug("%s:state:%d\n", __func__, state);
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		nds32_suspend_cpu();
-		return 0;
-	case PM_SUSPEND_MEM:
-		nds32_suspend2ram();
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct platform_suspend_ops nds32_pm_ops = {
-	.valid = nds32_pm_valid,
-	.enter = nds32_pm_enter,
-};
-
-static int __init nds32_pm_init(void)
-{
-	pr_debug("Enter %s\n", __func__);
-	suspend_set_ops(&nds32_pm_ops);
-	return 0;
-}
-late_initcall(nds32_pm_init);
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
deleted file mode 100644
index 49fab9e39cbf..000000000000
--- a/arch/nds32/kernel/process.c
+++ /dev/null
@@ -1,257 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/sched.h>
-#include <linux/sched/debug.h>
-#include <linux/sched/task_stack.h>
-#include <linux/delay.h>
-#include <linux/kallsyms.h>
-#include <linux/uaccess.h>
-#include <asm/elf.h>
-#include <asm/proc-fns.h>
-#include <asm/fpu.h>
-#include <linux/ptrace.h>
-#include <linux/reboot.h>
-
-#if IS_ENABLED(CONFIG_LAZY_FPU)
-struct task_struct *last_task_used_math;
-#endif
-
-extern void setup_mm_for_reboot(char mode);
-
-extern inline void arch_reset(char mode)
-{
-	if (mode == 's') {
-		/* Use cpu handler, jump to 0 */
-		cpu_reset(0);
-	}
-}
-
-void (*pm_power_off) (void);
-EXPORT_SYMBOL(pm_power_off);
-
-static char reboot_mode_nds32 = 'h';
-
-int __init reboot_setup(char *str)
-{
-	reboot_mode_nds32 = str[0];
-	return 1;
-}
-
-static int cpub_pwroff(void)
-{
-	return 0;
-}
-
-__setup("reboot=", reboot_setup);
-
-void machine_halt(void)
-{
-	cpub_pwroff();
-}
-
-EXPORT_SYMBOL(machine_halt);
-
-void machine_power_off(void)
-{
-	if (pm_power_off)
-		pm_power_off();
-}
-
-EXPORT_SYMBOL(machine_power_off);
-
-void machine_restart(char *cmd)
-{
-	/*
-	 * Clean and disable cache, and turn off interrupts
-	 */
-	cpu_proc_fin();
-
-	/*
-	 * Tell the mm system that we are going to reboot -
-	 * we may need it to insert some 1:1 mappings so that
-	 * soft boot works.
-	 */
-	setup_mm_for_reboot(reboot_mode_nds32);
-
-	/* Execute kernel restart handler call chain */
-	do_kernel_restart(cmd);
-
-	/*
-	 * Now call the architecture specific reboot code.
-	 */
-	arch_reset(reboot_mode_nds32);
-
-	/*
-	 * Whoops - the architecture was unable to reboot.
-	 * Tell the user!
-	 */
-	mdelay(1000);
-	pr_info("Reboot failed -- System halted\n");
-	while (1) ;
-}
-
-EXPORT_SYMBOL(machine_restart);
-
-void show_regs(struct pt_regs *regs)
-{
-	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
-	printk("LP is at %pS\n", (void *)regs->lp);
-	pr_info("pc : [<%08lx>]    lp : [<%08lx>]    %s\n"
-		"sp : %08lx  fp : %08lx  gp : %08lx\n",
-		instruction_pointer(regs),
-		regs->lp, print_tainted(), regs->sp, regs->fp, regs->gp);
-	pr_info("r25: %08lx  r24: %08lx\n", regs->uregs[25], regs->uregs[24]);
-
-	pr_info("r23: %08lx  r22: %08lx  r21: %08lx  r20: %08lx\n",
-		regs->uregs[23], regs->uregs[22],
-		regs->uregs[21], regs->uregs[20]);
-	pr_info("r19: %08lx  r18: %08lx  r17: %08lx  r16: %08lx\n",
-		regs->uregs[19], regs->uregs[18],
-		regs->uregs[17], regs->uregs[16]);
-	pr_info("r15: %08lx  r14: %08lx  r13: %08lx  r12: %08lx\n",
-		regs->uregs[15], regs->uregs[14],
-		regs->uregs[13], regs->uregs[12]);
-	pr_info("r11: %08lx  r10: %08lx  r9 : %08lx  r8 : %08lx\n",
-		regs->uregs[11], regs->uregs[10],
-		regs->uregs[9], regs->uregs[8]);
-	pr_info("r7 : %08lx  r6 : %08lx  r5 : %08lx  r4 : %08lx\n",
-		regs->uregs[7], regs->uregs[6], regs->uregs[5], regs->uregs[4]);
-	pr_info("r3 : %08lx  r2 : %08lx  r1 : %08lx  r0 : %08lx\n",
-		regs->uregs[3], regs->uregs[2], regs->uregs[1], regs->uregs[0]);
-	pr_info("  IRQs o%s  Segment %s\n",
-		interrupts_enabled(regs) ? "n" : "ff",
-		uaccess_kernel() ? "kernel" : "user");
-}
-
-EXPORT_SYMBOL(show_regs);
-
-void exit_thread(struct task_struct *tsk)
-{
-#if defined(CONFIG_FPU) && defined(CONFIG_LAZY_FPU)
-	if (last_task_used_math == tsk)
-		last_task_used_math = NULL;
-#endif
-}
-
-void flush_thread(void)
-{
-#if defined(CONFIG_FPU)
-	clear_fpu(task_pt_regs(current));
-	clear_used_math();
-# ifdef CONFIG_LAZY_FPU
-	if (last_task_used_math == current)
-		last_task_used_math = NULL;
-# endif
-#endif
-}
-
-DEFINE_PER_CPU(struct task_struct *, __entry_task);
-
-asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
-int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
-{
-	struct pt_regs *childregs = task_pt_regs(p);
-
-	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
-
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
-		memset(childregs, 0, sizeof(struct pt_regs));
-		/* kernel thread fn */
-		p->thread.cpu_context.r6 = stack_start;
-		/* kernel thread argument */
-		p->thread.cpu_context.r7 = stk_sz;
-	} else {
-		*childregs = *current_pt_regs();
-		if (stack_start)
-			childregs->sp = stack_start;
-		/* child get zero as ret. */
-		childregs->uregs[0] = 0;
-		childregs->osp = 0;
-		if (clone_flags & CLONE_SETTLS)
-			childregs->uregs[25] = tls;
-	}
-	/* cpu context switching  */
-	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
-	p->thread.cpu_context.sp = (unsigned long)childregs;
-
-#if IS_ENABLED(CONFIG_FPU)
-	if (used_math()) {
-# if !IS_ENABLED(CONFIG_LAZY_FPU)
-		unlazy_fpu(current);
-# else
-		preempt_disable();
-		if (last_task_used_math == current)
-			save_fpu(current);
-		preempt_enable();
-# endif
-		p->thread.fpu = current->thread.fpu;
-		clear_fpu(task_pt_regs(p));
-		set_stopped_child_used_math(p);
-	}
-#endif
-
-#ifdef CONFIG_HWZOL
-	childregs->lb = 0;
-	childregs->le = 0;
-	childregs->lc = 0;
-#endif
-
-	return 0;
-}
-
-#if IS_ENABLED(CONFIG_FPU)
-struct task_struct *_switch_fpu(struct task_struct *prev, struct task_struct *next)
-{
-#if !IS_ENABLED(CONFIG_LAZY_FPU)
-	unlazy_fpu(prev);
-#endif
-	if (!(next->flags & PF_KTHREAD))
-		clear_fpu(task_pt_regs(next));
-	return prev;
-}
-#endif
-
-/*
- * fill in the fpe structure for a core dump...
- */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
-{
-	int fpvalid = 0;
-#if IS_ENABLED(CONFIG_FPU)
-	struct task_struct *tsk = current;
-
-	fpvalid = tsk_used_math(tsk);
-	if (fpvalid) {
-		lose_fpu();
-		memcpy(fpu, &tsk->thread.fpu, sizeof(*fpu));
-	}
-#endif
-	return fpvalid;
-}
-
-EXPORT_SYMBOL(dump_fpu);
-
-unsigned long __get_wchan(struct task_struct *p)
-{
-	unsigned long fp, lr;
-	unsigned long stack_start, stack_end;
-	int count = 0;
-
-	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
-		stack_start = (unsigned long)end_of_stack(p);
-		stack_end = (unsigned long)task_stack_page(p) + THREAD_SIZE;
-
-		fp = thread_saved_fp(p);
-		do {
-			if (fp < stack_start || fp > stack_end)
-				return 0;
-			lr = ((unsigned long *)fp)[0];
-			if (!in_sched_functions(lr))
-				return lr;
-			fp = *(unsigned long *)(fp + 4);
-		} while (count++ < 16);
-	}
-	return 0;
-}
diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
deleted file mode 100644
index d0eda870fbc2..000000000000
--- a/arch/nds32/kernel/ptrace.c
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/ptrace.h>
-#include <linux/regset.h>
-#include <linux/tracehook.h>
-#include <linux/elf.h>
-#include <linux/sched/task_stack.h>
-
-enum nds32_regset {
-	REGSET_GPR,
-};
-
-static int gpr_get(struct task_struct *target,
-		   const struct user_regset *regset,
-		   struct membuf to)
-{
-	return membuf_write(&to, &task_pt_regs(target)->user_regs,
-				sizeof(struct user_pt_regs));
-}
-
-static int gpr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user * ubuf)
-{
-	int err;
-	struct user_pt_regs newregs = task_pt_regs(target)->user_regs;
-
-	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newregs, 0, -1);
-	if (err)
-		return err;
-
-	task_pt_regs(target)->user_regs = newregs;
-	return 0;
-}
-
-static const struct user_regset nds32_regsets[] = {
-	[REGSET_GPR] = {
-			.core_note_type = NT_PRSTATUS,
-			.n = sizeof(struct user_pt_regs) / sizeof(u32),
-			.size = sizeof(elf_greg_t),
-			.align = sizeof(elf_greg_t),
-			.regset_get = gpr_get,
-			.set = gpr_set}
-};
-
-static const struct user_regset_view nds32_user_view = {
-	.name = "nds32",
-	.e_machine = EM_NDS32,
-	.regsets = nds32_regsets,
-	.n = ARRAY_SIZE(nds32_regsets)
-};
-
-const struct user_regset_view *task_user_regset_view(struct task_struct *task)
-{
-	return &nds32_user_view;
-}
-
-void ptrace_disable(struct task_struct *child)
-{
-	user_disable_single_step(child);
-}
-
-/* do_ptrace()
- *
- * Provide ptrace defined service.
- */
-long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
-		 unsigned long data)
-{
-	int ret = -EIO;
-
-	switch (request) {
-	default:
-		ret = ptrace_request(child, request, addr, data);
-		break;
-	}
-
-	return ret;
-}
-
-void user_enable_single_step(struct task_struct *child)
-{
-	struct pt_regs *regs;
-	regs = task_pt_regs(child);
-	regs->ipsw |= PSW_mskHSS;
-	set_tsk_thread_flag(child, TIF_SINGLESTEP);
-}
-
-void user_disable_single_step(struct task_struct *child)
-{
-	struct pt_regs *regs;
-	regs = task_pt_regs(child);
-	regs->ipsw &= ~PSW_mskHSS;
-	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-}
-
-/* sys_trace()
- *
- * syscall trace handler.
- */
-
-asmlinkage int syscall_trace_enter(struct pt_regs *regs)
-{
-	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (tracehook_report_syscall_entry(regs))
-			forget_syscall(regs);
-	}
-	return regs->syscallno;
-}
-
-asmlinkage void syscall_trace_leave(struct pt_regs *regs)
-{
-	int step = test_thread_flag(TIF_SINGLESTEP);
-	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
-
-}
diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
deleted file mode 100644
index b3d34d646652..000000000000
--- a/arch/nds32/kernel/setup.c
+++ /dev/null
@@ -1,369 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/cpu.h>
-#include <linux/memblock.h>
-#include <linux/seq_file.h>
-#include <linux/console.h>
-#include <linux/screen_info.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_fdt.h>
-#include <linux/of_platform.h>
-#include <asm/setup.h>
-#include <asm/sections.h>
-#include <asm/proc-fns.h>
-#include <asm/cache_info.h>
-#include <asm/elf.h>
-#include <asm/fpu.h>
-#include <nds32_intrinsic.h>
-
-#define HWCAP_MFUSR_PC		0x000001
-#define HWCAP_EXT		0x000002
-#define HWCAP_EXT2		0x000004
-#define HWCAP_FPU		0x000008
-#define HWCAP_AUDIO		0x000010
-#define HWCAP_BASE16		0x000020
-#define HWCAP_STRING		0x000040
-#define HWCAP_REDUCED_REGS	0x000080
-#define HWCAP_VIDEO		0x000100
-#define HWCAP_ENCRYPT		0x000200
-#define HWCAP_EDM		0x000400
-#define HWCAP_LMDMA		0x000800
-#define HWCAP_PFM		0x001000
-#define HWCAP_HSMP		0x002000
-#define HWCAP_TRACE		0x004000
-#define HWCAP_DIV		0x008000
-#define HWCAP_MAC		0x010000
-#define HWCAP_L2C		0x020000
-#define HWCAP_FPU_DP		0x040000
-#define HWCAP_V2		0x080000
-#define HWCAP_DX_REGS		0x100000
-#define HWCAP_HWPRE		0x200000
-
-unsigned long cpu_id, cpu_rev, cpu_cfgid;
-bool has_fpu = false;
-char cpu_series;
-char *endianness = NULL;
-
-unsigned int __atags_pointer __initdata;
-unsigned int elf_hwcap;
-EXPORT_SYMBOL(elf_hwcap);
-
-/*
- * The following string table, must sync with HWCAP_xx bitmask,
- * which is defined above
- */
-static const char *hwcap_str[] = {
-	"mfusr_pc",
-	"perf1",
-	"perf2",
-	"fpu",
-	"audio",
-	"16b",
-	"string",
-	"reduced_regs",
-	"video",
-	"encrypt",
-	"edm",
-	"lmdma",
-	"pfm",
-	"hsmp",
-	"trace",
-	"div",
-	"mac",
-	"l2c",
-	"fpu_dp",
-	"v2",
-	"dx_regs",
-	"hw_pre",
-	NULL,
-};
-
-#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
-#define WRITE_METHOD "write through"
-#else
-#define WRITE_METHOD "write back"
-#endif
-
-struct cache_info L1_cache_info[2];
-static void __init dump_cpu_info(int cpu)
-{
-	int i, p = 0;
-	char str[sizeof(hwcap_str) + 16];
-
-	for (i = 0; hwcap_str[i]; i++) {
-		if (elf_hwcap & (1 << i)) {
-			sprintf(str + p, "%s ", hwcap_str[i]);
-			p += strlen(hwcap_str[i]) + 1;
-		}
-	}
-
-	pr_info("CPU%d Features: %s\n", cpu, str);
-
-	L1_cache_info[ICACHE].ways = CACHE_WAY(ICACHE);
-	L1_cache_info[ICACHE].line_size = CACHE_LINE_SIZE(ICACHE);
-	L1_cache_info[ICACHE].sets = CACHE_SET(ICACHE);
-	L1_cache_info[ICACHE].size =
-	    L1_cache_info[ICACHE].ways * L1_cache_info[ICACHE].line_size *
-	    L1_cache_info[ICACHE].sets / 1024;
-	pr_info("L1I:%dKB/%dS/%dW/%dB\n", L1_cache_info[ICACHE].size,
-		L1_cache_info[ICACHE].sets, L1_cache_info[ICACHE].ways,
-		L1_cache_info[ICACHE].line_size);
-	L1_cache_info[DCACHE].ways = CACHE_WAY(DCACHE);
-	L1_cache_info[DCACHE].line_size = CACHE_LINE_SIZE(DCACHE);
-	L1_cache_info[DCACHE].sets = CACHE_SET(DCACHE);
-	L1_cache_info[DCACHE].size =
-	    L1_cache_info[DCACHE].ways * L1_cache_info[DCACHE].line_size *
-	    L1_cache_info[DCACHE].sets / 1024;
-	pr_info("L1D:%dKB/%dS/%dW/%dB\n", L1_cache_info[DCACHE].size,
-		L1_cache_info[DCACHE].sets, L1_cache_info[DCACHE].ways,
-		L1_cache_info[DCACHE].line_size);
-	pr_info("L1 D-Cache is %s\n", WRITE_METHOD);
-	if (L1_cache_info[DCACHE].size != L1_CACHE_BYTES)
-		pr_crit
-		    ("The cache line size(%d) of this processor is not the same as L1_CACHE_BYTES(%d).\n",
-		     L1_cache_info[DCACHE].size, L1_CACHE_BYTES);
-#ifdef CONFIG_CPU_CACHE_ALIASING
-	{
-		int aliasing_num;
-		aliasing_num =
-		    L1_cache_info[ICACHE].size * 1024 / PAGE_SIZE /
-		    L1_cache_info[ICACHE].ways;
-		L1_cache_info[ICACHE].aliasing_num = aliasing_num;
-		L1_cache_info[ICACHE].aliasing_mask =
-		    (aliasing_num - 1) << PAGE_SHIFT;
-		aliasing_num =
-		    L1_cache_info[DCACHE].size * 1024 / PAGE_SIZE /
-		    L1_cache_info[DCACHE].ways;
-		L1_cache_info[DCACHE].aliasing_num = aliasing_num;
-		L1_cache_info[DCACHE].aliasing_mask =
-		    (aliasing_num - 1) << PAGE_SHIFT;
-	}
-#endif
-#ifdef CONFIG_FPU
-	/* Disable fpu and enable when it is used. */
-	if (has_fpu)
-		disable_fpu();
-#endif
-}
-
-static void __init setup_cpuinfo(void)
-{
-	unsigned long tmp = 0, cpu_name;
-
-	cpu_dcache_inval_all();
-	cpu_icache_inval_all();
-	__nds32__isb();
-
-	cpu_id = (__nds32__mfsr(NDS32_SR_CPU_VER) & CPU_VER_mskCPUID) >> CPU_VER_offCPUID;
-	cpu_name = ((cpu_id) & 0xf0) >> 4;
-	cpu_series = cpu_name ? cpu_name - 10 + 'A' : 'N';
-	cpu_id = cpu_id & 0xf;
-	cpu_rev = (__nds32__mfsr(NDS32_SR_CPU_VER) & CPU_VER_mskREV) >> CPU_VER_offREV;
-	cpu_cfgid = (__nds32__mfsr(NDS32_SR_CPU_VER) & CPU_VER_mskCFGID) >> CPU_VER_offCFGID;
-
-	pr_info("CPU:%c%ld, CPU_VER 0x%08x(id %lu, rev %lu, cfg %lu)\n",
-		cpu_series, cpu_id, __nds32__mfsr(NDS32_SR_CPU_VER), cpu_id, cpu_rev, cpu_cfgid);
-
-	elf_hwcap |= HWCAP_MFUSR_PC;
-
-	if (((__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskBASEV) >> MSC_CFG_offBASEV) == 0) {
-		if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskDIV)
-			elf_hwcap |= HWCAP_DIV;
-
-		if ((__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskMAC)
-		    || (cpu_id == 12 && cpu_rev < 4))
-			elf_hwcap |= HWCAP_MAC;
-	} else {
-		elf_hwcap |= HWCAP_V2;
-		elf_hwcap |= HWCAP_DIV;
-		elf_hwcap |= HWCAP_MAC;
-	}
-
-	if (cpu_cfgid & 0x0001)
-		elf_hwcap |= HWCAP_EXT;
-
-	if (cpu_cfgid & 0x0002)
-		elf_hwcap |= HWCAP_BASE16;
-
-	if (cpu_cfgid & 0x0004)
-		elf_hwcap |= HWCAP_EXT2;
-
-	if (cpu_cfgid & 0x0008) {
-		elf_hwcap |= HWCAP_FPU;
-		has_fpu = true;
-	}
-	if (cpu_cfgid & 0x0010)
-		elf_hwcap |= HWCAP_STRING;
-
-	if (__nds32__mfsr(NDS32_SR_MMU_CFG) & MMU_CFG_mskDE)
-		endianness = "MSB";
-	else
-		endianness = "LSB";
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskEDM)
-		elf_hwcap |= HWCAP_EDM;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskLMDMA)
-		elf_hwcap |= HWCAP_LMDMA;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskPFM)
-		elf_hwcap |= HWCAP_PFM;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskHSMP)
-		elf_hwcap |= HWCAP_HSMP;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskTRACE)
-		elf_hwcap |= HWCAP_TRACE;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskAUDIO)
-		elf_hwcap |= HWCAP_AUDIO;
-
-	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskL2C)
-		elf_hwcap |= HWCAP_L2C;
-
-#ifdef CONFIG_HW_PRE
-	if (__nds32__mfsr(NDS32_SR_MISC_CTL) & MISC_CTL_makHWPRE_EN)
-		elf_hwcap |= HWCAP_HWPRE;
-#endif
-
-	tmp = __nds32__mfsr(NDS32_SR_CACHE_CTL);
-	if (!IS_ENABLED(CONFIG_CPU_DCACHE_DISABLE))
-		tmp |= CACHE_CTL_mskDC_EN;
-
-	if (!IS_ENABLED(CONFIG_CPU_ICACHE_DISABLE))
-		tmp |= CACHE_CTL_mskIC_EN;
-	__nds32__mtsr_isb(tmp, NDS32_SR_CACHE_CTL);
-
-	dump_cpu_info(smp_processor_id());
-}
-
-static void __init setup_memory(void)
-{
-	unsigned long ram_start_pfn;
-	unsigned long free_ram_start_pfn;
-	phys_addr_t memory_start, memory_end;
-
-	memory_end = memory_start = 0;
-
-	/* Find main memory where is the kernel */
-	memory_start = memblock_start_of_DRAM();
-	memory_end = memblock_end_of_DRAM();
-
-	if (!memory_end) {
-		panic("No memory!");
-	}
-
-	ram_start_pfn = PFN_UP(memblock_start_of_DRAM());
-	/* free_ram_start_pfn is first page after kernel */
-	free_ram_start_pfn = PFN_UP(__pa(&_end));
-	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
-	/* it could update max_pfn */
-	if (max_pfn - ram_start_pfn <= MAXMEM_PFN)
-		max_low_pfn = max_pfn;
-	else {
-		max_low_pfn = MAXMEM_PFN + ram_start_pfn;
-		if (!IS_ENABLED(CONFIG_HIGHMEM))
-			max_pfn = MAXMEM_PFN + ram_start_pfn;
-	}
-	/* high_memory is related with VMALLOC */
-	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
-	min_low_pfn = free_ram_start_pfn;
-
-	/*
-	 * initialize the boot-time allocator (with low memory only).
-	 *
-	 * This makes the memory from the end of the kernel to the end of
-	 * RAM usable.
-	 */
-	memblock_set_bottom_up(true);
-	memblock_reserve(PFN_PHYS(ram_start_pfn), PFN_PHYS(free_ram_start_pfn - ram_start_pfn));
-
-	early_init_fdt_reserve_self();
-	early_init_fdt_scan_reserved_mem();
-
-	memblock_dump_all();
-}
-
-void __init setup_arch(char **cmdline_p)
-{
-	early_init_devtree(__atags_pointer ? \
-		phys_to_virt(__atags_pointer) : __dtb_start);
-
-	setup_cpuinfo();
-
-	setup_initial_init_mm(_stext, _etext, _edata, _end);
-
-	/* setup bootmem allocator */
-	setup_memory();
-
-	/* paging_init() sets up the MMU and marks all pages as reserved */
-	paging_init();
-
-	/* invalidate all TLB entries because the new mapping is created */
-	__nds32__tlbop_flua();
-
-	/* use generic way to parse */
-	parse_early_param();
-
-	unflatten_and_copy_device_tree();
-
-	*cmdline_p = boot_command_line;
-	early_trap_init();
-}
-
-static int c_show(struct seq_file *m, void *v)
-{
-	int i;
-
-	seq_printf(m, "Processor\t: %c%ld (id %lu, rev %lu, cfg %lu)\n",
-		   cpu_series, cpu_id, cpu_id, cpu_rev, cpu_cfgid);
-
-	seq_printf(m, "L1I\t\t: %luKB/%luS/%luW/%luB\n",
-		   CACHE_SET(ICACHE) * CACHE_WAY(ICACHE) *
-		   CACHE_LINE_SIZE(ICACHE) / 1024, CACHE_SET(ICACHE),
-		   CACHE_WAY(ICACHE), CACHE_LINE_SIZE(ICACHE));
-
-	seq_printf(m, "L1D\t\t: %luKB/%luS/%luW/%luB\n",
-		   CACHE_SET(DCACHE) * CACHE_WAY(DCACHE) *
-		   CACHE_LINE_SIZE(DCACHE) / 1024, CACHE_SET(DCACHE),
-		   CACHE_WAY(DCACHE), CACHE_LINE_SIZE(DCACHE));
-
-	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
-		   loops_per_jiffy / (500000 / HZ),
-		   (loops_per_jiffy / (5000 / HZ)) % 100);
-
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
-
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
-
-	seq_puts(m, "\n\n");
-
-	return 0;
-}
-
-static void *c_start(struct seq_file *m, loff_t * pos)
-{
-	return *pos < 1 ? (void *)1 : NULL;
-}
-
-static void *c_next(struct seq_file *m, void *v, loff_t * pos)
-{
-	++*pos;
-	return NULL;
-}
-
-static void c_stop(struct seq_file *m, void *v)
-{
-}
-
-struct seq_operations cpuinfo_op = {
-	.start = c_start,
-	.next = c_next,
-	.stop = c_stop,
-	.show = c_show
-};
diff --git a/arch/nds32/kernel/signal.c b/arch/nds32/kernel/signal.c
deleted file mode 100644
index 7e3ca430a223..000000000000
--- a/arch/nds32/kernel/signal.c
+++ /dev/null
@@ -1,384 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/ptrace.h>
-#include <linux/personality.h>
-#include <linux/freezer.h>
-#include <linux/tracehook.h>
-#include <linux/uaccess.h>
-
-#include <asm/cacheflush.h>
-#include <asm/ucontext.h>
-#include <asm/unistd.h>
-#include <asm/fpu.h>
-
-#include <asm/ptrace.h>
-#include <asm/vdso.h>
-
-struct rt_sigframe {
-	struct siginfo info;
-	struct ucontext uc;
-};
-#if IS_ENABLED(CONFIG_FPU)
-static inline int restore_sigcontext_fpu(struct pt_regs *regs,
-					 struct sigcontext __user *sc)
-{
-	struct task_struct *tsk = current;
-	unsigned long used_math_flag;
-	int ret = 0;
-
-	clear_used_math();
-	__get_user_error(used_math_flag, &sc->used_math_flag, ret);
-
-	if (!used_math_flag)
-		return 0;
-	set_used_math();
-
-#if IS_ENABLED(CONFIG_LAZY_FPU)
-	preempt_disable();
-	if (current == last_task_used_math) {
-		last_task_used_math = NULL;
-		disable_ptreg_fpu(regs);
-	}
-	preempt_enable();
-#else
-	clear_fpu(regs);
-#endif
-
-	return __copy_from_user(&tsk->thread.fpu, &sc->fpu,
-				sizeof(struct fpu_struct));
-}
-
-static inline int setup_sigcontext_fpu(struct pt_regs *regs,
-				       struct sigcontext __user *sc)
-{
-	struct task_struct *tsk = current;
-	int ret = 0;
-
-	__put_user_error(used_math(), &sc->used_math_flag, ret);
-
-	if (!used_math())
-		return ret;
-
-	preempt_disable();
-#if IS_ENABLED(CONFIG_LAZY_FPU)
-	if (last_task_used_math == tsk)
-		save_fpu(last_task_used_math);
-#else
-	unlazy_fpu(tsk);
-#endif
-	ret = __copy_to_user(&sc->fpu, &tsk->thread.fpu,
-			     sizeof(struct fpu_struct));
-	preempt_enable();
-	return ret;
-}
-#endif
-
-static int restore_sigframe(struct pt_regs *regs,
-			    struct rt_sigframe __user * sf)
-{
-	sigset_t set;
-	int err;
-
-	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
-	if (err == 0) {
-		set_current_blocked(&set);
-	}
-
-	__get_user_error(regs->uregs[0], &sf->uc.uc_mcontext.nds32_r0, err);
-	__get_user_error(regs->uregs[1], &sf->uc.uc_mcontext.nds32_r1, err);
-	__get_user_error(regs->uregs[2], &sf->uc.uc_mcontext.nds32_r2, err);
-	__get_user_error(regs->uregs[3], &sf->uc.uc_mcontext.nds32_r3, err);
-	__get_user_error(regs->uregs[4], &sf->uc.uc_mcontext.nds32_r4, err);
-	__get_user_error(regs->uregs[5], &sf->uc.uc_mcontext.nds32_r5, err);
-	__get_user_error(regs->uregs[6], &sf->uc.uc_mcontext.nds32_r6, err);
-	__get_user_error(regs->uregs[7], &sf->uc.uc_mcontext.nds32_r7, err);
-	__get_user_error(regs->uregs[8], &sf->uc.uc_mcontext.nds32_r8, err);
-	__get_user_error(regs->uregs[9], &sf->uc.uc_mcontext.nds32_r9, err);
-	__get_user_error(regs->uregs[10], &sf->uc.uc_mcontext.nds32_r10, err);
-	__get_user_error(regs->uregs[11], &sf->uc.uc_mcontext.nds32_r11, err);
-	__get_user_error(regs->uregs[12], &sf->uc.uc_mcontext.nds32_r12, err);
-	__get_user_error(regs->uregs[13], &sf->uc.uc_mcontext.nds32_r13, err);
-	__get_user_error(regs->uregs[14], &sf->uc.uc_mcontext.nds32_r14, err);
-	__get_user_error(regs->uregs[15], &sf->uc.uc_mcontext.nds32_r15, err);
-	__get_user_error(regs->uregs[16], &sf->uc.uc_mcontext.nds32_r16, err);
-	__get_user_error(regs->uregs[17], &sf->uc.uc_mcontext.nds32_r17, err);
-	__get_user_error(regs->uregs[18], &sf->uc.uc_mcontext.nds32_r18, err);
-	__get_user_error(regs->uregs[19], &sf->uc.uc_mcontext.nds32_r19, err);
-	__get_user_error(regs->uregs[20], &sf->uc.uc_mcontext.nds32_r20, err);
-	__get_user_error(regs->uregs[21], &sf->uc.uc_mcontext.nds32_r21, err);
-	__get_user_error(regs->uregs[22], &sf->uc.uc_mcontext.nds32_r22, err);
-	__get_user_error(regs->uregs[23], &sf->uc.uc_mcontext.nds32_r23, err);
-	__get_user_error(regs->uregs[24], &sf->uc.uc_mcontext.nds32_r24, err);
-	__get_user_error(regs->uregs[25], &sf->uc.uc_mcontext.nds32_r25, err);
-
-	__get_user_error(regs->fp, &sf->uc.uc_mcontext.nds32_fp, err);
-	__get_user_error(regs->gp, &sf->uc.uc_mcontext.nds32_gp, err);
-	__get_user_error(regs->lp, &sf->uc.uc_mcontext.nds32_lp, err);
-	__get_user_error(regs->sp, &sf->uc.uc_mcontext.nds32_sp, err);
-	__get_user_error(regs->ipc, &sf->uc.uc_mcontext.nds32_ipc, err);
-#if defined(CONFIG_HWZOL)
-	__get_user_error(regs->lc, &sf->uc.uc_mcontext.zol.nds32_lc, err);
-	__get_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
-	__get_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
-#endif
-#if IS_ENABLED(CONFIG_FPU)
-	err |= restore_sigcontext_fpu(regs, &sf->uc.uc_mcontext);
-#endif
-	/*
-	 * Avoid sys_rt_sigreturn() restarting.
-	 */
-	forget_syscall(regs);
-	return err;
-}
-
-asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
-{
-	struct rt_sigframe __user *frame;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	/*
-	 * Since we stacked the signal on a 64-bit boundary,
-	 * then 'sp' should be two-word aligned here.  If it's
-	 * not, then the user is trying to mess with us.
-	 */
-	if (regs->sp & 7)
-		goto badframe;
-
-	frame = (struct rt_sigframe __user *)regs->sp;
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-
-	if (restore_sigframe(regs, frame))
-		goto badframe;
-
-	if (restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->uregs[0];
-
-badframe:
-	force_sig(SIGSEGV);
-	return 0;
-}
-
-static int
-setup_sigframe(struct rt_sigframe __user * sf, struct pt_regs *regs,
-	       sigset_t * set)
-{
-	int err = 0;
-
-	__put_user_error(regs->uregs[0], &sf->uc.uc_mcontext.nds32_r0, err);
-	__put_user_error(regs->uregs[1], &sf->uc.uc_mcontext.nds32_r1, err);
-	__put_user_error(regs->uregs[2], &sf->uc.uc_mcontext.nds32_r2, err);
-	__put_user_error(regs->uregs[3], &sf->uc.uc_mcontext.nds32_r3, err);
-	__put_user_error(regs->uregs[4], &sf->uc.uc_mcontext.nds32_r4, err);
-	__put_user_error(regs->uregs[5], &sf->uc.uc_mcontext.nds32_r5, err);
-	__put_user_error(regs->uregs[6], &sf->uc.uc_mcontext.nds32_r6, err);
-	__put_user_error(regs->uregs[7], &sf->uc.uc_mcontext.nds32_r7, err);
-	__put_user_error(regs->uregs[8], &sf->uc.uc_mcontext.nds32_r8, err);
-	__put_user_error(regs->uregs[9], &sf->uc.uc_mcontext.nds32_r9, err);
-	__put_user_error(regs->uregs[10], &sf->uc.uc_mcontext.nds32_r10, err);
-	__put_user_error(regs->uregs[11], &sf->uc.uc_mcontext.nds32_r11, err);
-	__put_user_error(regs->uregs[12], &sf->uc.uc_mcontext.nds32_r12, err);
-	__put_user_error(regs->uregs[13], &sf->uc.uc_mcontext.nds32_r13, err);
-	__put_user_error(regs->uregs[14], &sf->uc.uc_mcontext.nds32_r14, err);
-	__put_user_error(regs->uregs[15], &sf->uc.uc_mcontext.nds32_r15, err);
-	__put_user_error(regs->uregs[16], &sf->uc.uc_mcontext.nds32_r16, err);
-	__put_user_error(regs->uregs[17], &sf->uc.uc_mcontext.nds32_r17, err);
-	__put_user_error(regs->uregs[18], &sf->uc.uc_mcontext.nds32_r18, err);
-	__put_user_error(regs->uregs[19], &sf->uc.uc_mcontext.nds32_r19, err);
-	__put_user_error(regs->uregs[20], &sf->uc.uc_mcontext.nds32_r20, err);
-
-	__put_user_error(regs->uregs[21], &sf->uc.uc_mcontext.nds32_r21, err);
-	__put_user_error(regs->uregs[22], &sf->uc.uc_mcontext.nds32_r22, err);
-	__put_user_error(regs->uregs[23], &sf->uc.uc_mcontext.nds32_r23, err);
-	__put_user_error(regs->uregs[24], &sf->uc.uc_mcontext.nds32_r24, err);
-	__put_user_error(regs->uregs[25], &sf->uc.uc_mcontext.nds32_r25, err);
-	__put_user_error(regs->fp, &sf->uc.uc_mcontext.nds32_fp, err);
-	__put_user_error(regs->gp, &sf->uc.uc_mcontext.nds32_gp, err);
-	__put_user_error(regs->lp, &sf->uc.uc_mcontext.nds32_lp, err);
-	__put_user_error(regs->sp, &sf->uc.uc_mcontext.nds32_sp, err);
-	__put_user_error(regs->ipc, &sf->uc.uc_mcontext.nds32_ipc, err);
-#if defined(CONFIG_HWZOL)
-	__put_user_error(regs->lc, &sf->uc.uc_mcontext.zol.nds32_lc, err);
-	__put_user_error(regs->le, &sf->uc.uc_mcontext.zol.nds32_le, err);
-	__put_user_error(regs->lb, &sf->uc.uc_mcontext.zol.nds32_lb, err);
-#endif
-#if IS_ENABLED(CONFIG_FPU)
-	err |= setup_sigcontext_fpu(regs, &sf->uc.uc_mcontext);
-#endif
-
-	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no,
-			 err);
-	__put_user_error(current->thread.error_code,
-			 &sf->uc.uc_mcontext.error_code, err);
-	__put_user_error(current->thread.address,
-			 &sf->uc.uc_mcontext.fault_address, err);
-	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
-
-	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
-
-	return err;
-}
-
-static inline void __user *get_sigframe(struct ksignal *ksig,
-					struct pt_regs *regs, int framesize)
-{
-	unsigned long sp;
-
-	/* Default to using normal stack */
-	sp = regs->sp;
-
-	/*
-	 * If we are on the alternate signal stack and would overflow it, don't.
-	 * Return an always-bogus address instead so we will die with SIGSEGV.
-	 */
-	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
-		return (void __user __force *)(-1UL);
-
-	/* This is the X/Open sanctioned signal stack switching. */
-	sp = (sigsp(sp, ksig) - framesize);
-
-	/*
-	 * nds32 mandates 8-byte alignment
-	 */
-	sp &= ~0x7UL;
-
-	return (void __user *)sp;
-}
-
-static int
-setup_return(struct pt_regs *regs, struct ksignal *ksig, void __user * frame)
-{
-	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
-	unsigned long retcode;
-
-	retcode = VDSO_SYMBOL(current->mm->context.vdso, rt_sigtramp);
-	regs->uregs[0] = ksig->sig;
-	regs->sp = (unsigned long)frame;
-	regs->lp = retcode;
-	regs->ipc = handler;
-
-	return 0;
-}
-
-static int
-setup_rt_frame(struct ksignal *ksig, sigset_t * set, struct pt_regs *regs)
-{
-	struct rt_sigframe __user *frame =
-	    get_sigframe(ksig, regs, sizeof(*frame));
-	int err = 0;
-
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	__put_user_error(0, &frame->uc.uc_flags, err);
-	__put_user_error(NULL, &frame->uc.uc_link, err);
-
-	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(frame, regs, set);
-	if (err == 0) {
-		setup_return(regs, ksig, frame);
-		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-			regs->uregs[1] = (unsigned long)&frame->info;
-			regs->uregs[2] = (unsigned long)&frame->uc;
-		}
-	}
-	return err;
-}
-
-/*
- * OK, we're invoking a handler
- */
-static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
-{
-	int ret;
-	sigset_t *oldset = sigmask_to_save();
-
-	if (in_syscall(regs)) {
-		/* Avoid additional syscall restarting via ret_slow_syscall. */
-		forget_syscall(regs);
-
-		switch (regs->uregs[0]) {
-		case -ERESTART_RESTARTBLOCK:
-		case -ERESTARTNOHAND:
-			regs->uregs[0] = -EINTR;
-			break;
-		case -ERESTARTSYS:
-			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
-				regs->uregs[0] = -EINTR;
-				break;
-			}
-			fallthrough;
-		case -ERESTARTNOINTR:
-			regs->uregs[0] = regs->orig_r0;
-			regs->ipc -= 4;
-			break;
-		}
-	}
-	/*
-	 * Set up the stack frame
-	 */
-	ret = setup_rt_frame(ksig, oldset, regs);
-
-	signal_setup_done(ret, ksig, 0);
-}
-
-/*
- * Note that 'init' is a special process: it doesn't get signals it doesn't
- * want to handle. Thus you cannot kill init even with a SIGKILL even by
- * mistake.
- *
- * Note that we go through the signals twice: once to check the signals that
- * the kernel can handle, and then we build all the user-level signal handling
- * stack-frames in one go after that.
- */
-static void do_signal(struct pt_regs *regs)
-{
-	struct ksignal ksig;
-
-	if (get_signal(&ksig)) {
-		handle_signal(&ksig, regs);
-		return;
-	}
-
-	/*
-	 * If we were from a system call, check for system call restarting...
-	 */
-	if (in_syscall(regs)) {
-		/* Restart the system call - no handlers present */
-
-		/* Avoid additional syscall restarting via ret_slow_syscall. */
-		forget_syscall(regs);
-
-		switch (regs->uregs[0]) {
-		case -ERESTART_RESTARTBLOCK:
-			regs->uregs[15] = __NR_restart_syscall;
-			fallthrough;
-		case -ERESTARTNOHAND:
-		case -ERESTARTSYS:
-		case -ERESTARTNOINTR:
-			regs->uregs[0] = regs->orig_r0;
-			regs->ipc -= 0x4;
-			break;
-		}
-	}
-	restore_saved_sigmask();
-}
-
-asmlinkage void
-do_notify_resume(struct pt_regs *regs, unsigned int thread_flags)
-{
-	if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-		do_signal(regs);
-
-	if (thread_flags & _TIF_NOTIFY_RESUME)
-		tracehook_notify_resume(regs);
-}
diff --git a/arch/nds32/kernel/sleep.S b/arch/nds32/kernel/sleep.S
deleted file mode 100644
index ca4e61f3656f..000000000000
--- a/arch/nds32/kernel/sleep.S
+++ /dev/null
@@ -1,131 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2017 Andes Technology Corporation */
-
-#include <asm/memory.h>
-
-.data
-.global sp_tmp
-sp_tmp:
-.long
-
-.text
-.globl suspend2ram
-.globl cpu_resume
-
-suspend2ram:
-	pushm   $r0, $r31
-#if defined(CONFIG_HWZOL)
-	mfusr   $r0, $lc
-	mfusr   $r1, $le
-	mfusr   $r2, $lb
-#endif
-	mfsr	$r3, $mr0
-	mfsr    $r4, $mr1
-	mfsr    $r5, $mr4
-	mfsr    $r6, $mr6
-	mfsr    $r7, $mr7
-	mfsr    $r8, $mr8
-	mfsr    $r9, $ir0
-	mfsr    $r10, $ir1
-	mfsr    $r11, $ir2
-	mfsr    $r12, $ir3
-	mfsr    $r13, $ir9
-	mfsr    $r14, $ir10
-	mfsr    $r15, $ir12
-	mfsr    $r16, $ir13
-	mfsr    $r17, $ir14
-	mfsr    $r18, $ir15
-	pushm   $r0, $r19
-#if defined(CONFIG_FPU)
-	jal	store_fpu_for_suspend
-#endif
-	tlbop	FlushAll
-	isb
-
-	// transfer $sp from va to pa
-	sethi	$r0, hi20(PAGE_OFFSET)
-	ori	$r0, $r0, lo12(PAGE_OFFSET)
-	movi	$r2, PHYS_OFFSET
-	sub	$r1, $sp, $r0
-	add	$r2, $r1, $r2
-
-	// store pa($sp) to sp_tmp
-	sethi 	$r1, hi20(sp_tmp)
-	swi	$r2, [$r1 + lo12(sp_tmp)]
-
-	pushm	$r16, $r25
-	pushm	$r29, $r30
-#ifdef	CONFIG_CACHE_L2
-	jal	dcache_wb_all_level
-#else
-	jal	cpu_dcache_wb_all
-#endif
-	popm	$r29, $r30
-	popm	$r16, $r25
-
-	// get wake_mask and loop in standby
-	la	$r1, wake_mask
-	lwi	$r1, [$r1]
-self_loop:
-	standby wake_grant
-	mfsr	$r2, $ir15
-	and	$r2, $r1, $r2
-	beqz	$r2, self_loop
-
-	// set ipc to resume address
-	la	$r1, resume_addr
-	lwi	$r1, [$r1]
-	mtsr	$r1, $ipc
-	isb
-
-	// reset psw, turn off the address translation
-	li      $r2, 0x7000a
-	mtsr    $r2, $ipsw
-	isb
-
-	iret
-cpu_resume:
-	// translate the address of sp_tmp variable to pa
-	la	$r1, sp_tmp
-	sethi   $r0, hi20(PAGE_OFFSET)
-	ori     $r0, $r0, lo12(PAGE_OFFSET)
-	movi    $r2, PHYS_OFFSET
-	sub     $r1, $r1, $r0
-	add     $r1, $r1, $r2
-
-	// access the sp_tmp to get stack pointer
-	lwi	$sp, [$r1]
-
-	popm	$r0, $r19
-#if defined(CONFIG_HWZOL)
-	mtusr   $r0, $lb
-	mtusr   $r1, $lc
-	mtusr   $r2, $le
-#endif
-	mtsr	$r3, $mr0
-	mtsr    $r4, $mr1
-	mtsr    $r5, $mr4
-	mtsr    $r6, $mr6
-	mtsr    $r7, $mr7
-	mtsr    $r8, $mr8
-	// set original psw to ipsw
-	mtsr    $r9, $ir1
-
-	mtsr    $r11, $ir2
-	mtsr    $r12, $ir3
-
-	// set ipc to RR
-	la	$r13, RR
-	mtsr	$r13, $ir9
-
-	mtsr    $r14, $ir10
-	mtsr    $r15, $ir12
-	mtsr    $r16, $ir13
-	mtsr    $r17, $ir14
-	mtsr    $r18, $ir15
-	popm    $r0, $r31
-
-	isb
-	iret
-RR:
-	ret
diff --git a/arch/nds32/kernel/stacktrace.c b/arch/nds32/kernel/stacktrace.c
deleted file mode 100644
index d974c0c1c65f..000000000000
--- a/arch/nds32/kernel/stacktrace.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/sched/debug.h>
-#include <linux/sched/task_stack.h>
-#include <linux/stacktrace.h>
-#include <linux/ftrace.h>
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	save_stack_trace_tsk(current, trace);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	unsigned long *fpn;
-	int skip = trace->skip;
-	int savesched;
-	int graph_idx = 0;
-
-	if (tsk == current) {
-		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
-		savesched = 1;
-	} else {
-		fpn = (unsigned long *)thread_saved_fp(tsk);
-		savesched = 0;
-	}
-
-	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
-	       && (fpn >= (unsigned long *)TASK_SIZE)) {
-		unsigned long lpp, fpp;
-
-		lpp = fpn[LP_OFFSET];
-		fpp = fpn[FP_OFFSET];
-		if (!__kernel_text_address(lpp))
-			break;
-		else
-			lpp = ftrace_graph_ret_addr(tsk, &graph_idx, lpp, NULL);
-
-		if (savesched || !in_sched_functions(lpp)) {
-			if (skip) {
-				skip--;
-			} else {
-				trace->entries[trace->nr_entries++] = lpp;
-				if (trace->nr_entries >= trace->max_entries)
-					break;
-			}
-		}
-		fpn = (unsigned long *)fpp;
-	}
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
deleted file mode 100644
index cb2d1e219bb3..000000000000
--- a/arch/nds32/kernel/sys_nds32.c
+++ /dev/null
@@ -1,84 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-
-#include <asm/cachectl.h>
-#include <asm/proc-fns.h>
-#include <asm/fpu.h>
-#include <asm/fp_udfiex_crtl.h>
-
-SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
-	       unsigned long, prot, unsigned long, flags,
-	       unsigned long, fd, unsigned long, pgoff)
-{
-	if (pgoff & (~PAGE_MASK >> 12))
-		return -EINVAL;
-
-	return sys_mmap_pgoff(addr, len, prot, flags, fd,
-			      pgoff >> (PAGE_SHIFT - 12));
-}
-
-SYSCALL_DEFINE4(fadvise64_64_wrapper,int, fd, int, advice, loff_t, offset,
-					 loff_t, len)
-{
-	return sys_fadvise64_64(fd, offset, len, advice);
-}
-
-SYSCALL_DEFINE3(cacheflush, unsigned int, start, unsigned int, end, int, cache)
-{
-	struct vm_area_struct *vma;
-	bool flushi = true, wbd = true;
-
-	vma = find_vma(current->mm, start);
-	if (!vma)
-		return -EFAULT;
-	switch (cache) {
-	case ICACHE:
-		wbd = false;
-		break;
-	case DCACHE:
-		flushi = false;
-		break;
-	case BCACHE:
-		break;
-	default:
-		return -EINVAL;
-	}
-	cpu_cache_wbinval_range_check(vma, start, end, flushi, wbd);
-
-	return 0;
-}
-
-SYSCALL_DEFINE2(fp_udfiex_crtl, unsigned int, cmd, unsigned int, act)
-{
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-	int old_udf_iex;
-
-	if (!used_math()) {
-		load_fpu(&init_fpuregs);
-		current->thread.fpu.UDF_IEX_trap = init_fpuregs.UDF_IEX_trap;
-		set_used_math();
-	}
-
-	old_udf_iex = current->thread.fpu.UDF_IEX_trap;
-	act &= (FPCSR_mskUDFE | FPCSR_mskIEXE);
-
-	switch (cmd) {
-	case DISABLE_UDF_IEX_TRAP:
-		current->thread.fpu.UDF_IEX_trap &= ~act;
-		break;
-	case ENABLE_UDF_IEX_TRAP:
-		current->thread.fpu.UDF_IEX_trap |= act;
-		break;
-	case GET_UDF_IEX_TRAP:
-		break;
-	default:
-		return -EINVAL;
-	}
-	return old_udf_iex;
-#else
-	return -ENOTSUPP;
-#endif
-}
diff --git a/arch/nds32/kernel/syscall_table.c b/arch/nds32/kernel/syscall_table.c
deleted file mode 100644
index 7879c061b87f..000000000000
--- a/arch/nds32/kernel/syscall_table.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/syscalls.h>
-#include <linux/signal.h>
-#include <linux/unistd.h>
-#include <asm/syscalls.h>
-
-#undef __SYSCALL
-#define __SYSCALL(nr, call) [nr] = (call),
-
-#define sys_rt_sigreturn sys_rt_sigreturn_wrapper
-#define sys_fadvise64_64 sys_fadvise64_64_wrapper
-void *sys_call_table[__NR_syscalls] __aligned(8192) = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
-#include <asm/unistd.h>
-};
diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
deleted file mode 100644
index 574a3d0a8539..000000000000
--- a/arch/nds32/kernel/time.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/clocksource.h>
-#include <linux/of_clk.h>
-
-void __init time_init(void)
-{
-	of_clk_init(NULL);
-	timer_probe();
-}
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
deleted file mode 100644
index c0a8f3344fb9..000000000000
--- a/arch/nds32/kernel/traps.c
+++ /dev/null
@@ -1,354 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/module.h>
-#include <linux/personality.h>
-#include <linux/kallsyms.h>
-#include <linux/hardirq.h>
-#include <linux/kdebug.h>
-#include <linux/sched/task_stack.h>
-#include <linux/uaccess.h>
-#include <linux/ftrace.h>
-
-#include <asm/proc-fns.h>
-#include <asm/unistd.h>
-#include <asm/fpu.h>
-
-#include <linux/ptrace.h>
-#include <nds32_intrinsic.h>
-
-extern void show_pte(struct mm_struct *mm, unsigned long addr);
-
-/*
- * Dump out the contents of some memory nicely...
- */
-void dump_mem(const char *lvl, unsigned long bottom, unsigned long top)
-{
-	unsigned long first;
-	int i;
-
-	pr_emerg("%s(0x%08lx to 0x%08lx)\n", lvl, bottom, top);
-
-	for (first = bottom & ~31; first < top; first += 32) {
-		unsigned long p;
-		char str[sizeof(" 12345678") * 8 + 1];
-
-		memset(str, ' ', sizeof(str));
-		str[sizeof(str) - 1] = '\0';
-
-		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
-			if (p >= bottom && p < top) {
-				unsigned long val;
-
-				if (get_kernel_nofault(val,
-						(unsigned long *)p) == 0)
-					sprintf(str + i * 9, " %08lx", val);
-				else
-					sprintf(str + i * 9, " ????????");
-			}
-		}
-		pr_emerg("%s%04lx:%s\n", lvl, first & 0xffff, str);
-	}
-}
-
-EXPORT_SYMBOL(dump_mem);
-
-#define LOOP_TIMES (100)
-static void __dump(struct task_struct *tsk, unsigned long *base_reg,
-		   const char *loglvl)
-{
-	unsigned long ret_addr;
-	int cnt = LOOP_TIMES, graph = 0;
-	printk("%sCall Trace:\n", loglvl);
-	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
-		while (!kstack_end(base_reg)) {
-			ret_addr = *base_reg++;
-			if (__kernel_text_address(ret_addr)) {
-				ret_addr = ftrace_graph_ret_addr(
-						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(loglvl, ret_addr);
-			}
-			if (--cnt < 0)
-				break;
-		}
-	} else {
-		while (!kstack_end((void *)base_reg) &&
-		       !((unsigned long)base_reg & 0x3) &&
-		       ((unsigned long)base_reg >= TASK_SIZE)) {
-			unsigned long next_fp;
-			ret_addr = base_reg[LP_OFFSET];
-			next_fp = base_reg[FP_OFFSET];
-			if (__kernel_text_address(ret_addr)) {
-
-				ret_addr = ftrace_graph_ret_addr(
-						tsk, &graph, ret_addr, NULL);
-				print_ip_sym(loglvl, ret_addr);
-			}
-			if (--cnt < 0)
-				break;
-			base_reg = (unsigned long *)next_fp;
-		}
-	}
-	printk("%s\n", loglvl);
-}
-
-void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
-{
-	unsigned long *base_reg;
-
-	if (!tsk)
-		tsk = current;
-	if (!IS_ENABLED(CONFIG_FRAME_POINTER)) {
-		if (tsk != current)
-			base_reg = (unsigned long *)(tsk->thread.cpu_context.sp);
-		else
-			__asm__ __volatile__("\tori\t%0, $sp, #0\n":"=r"(base_reg));
-	} else {
-		if (tsk != current)
-			base_reg = (unsigned long *)(tsk->thread.cpu_context.fp);
-		else
-			__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
-	}
-	__dump(tsk, base_reg, loglvl);
-	barrier();
-}
-
-DEFINE_SPINLOCK(die_lock);
-
-/*
- * This function is protected against re-entrancy.
- */
-void __noreturn die(const char *str, struct pt_regs *regs, int err)
-{
-	struct task_struct *tsk = current;
-	static int die_counter;
-
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-
-	pr_emerg("Internal error: %s: %x [#%d]\n", str, err, ++die_counter);
-	print_modules();
-	pr_emerg("CPU: %i\n", smp_processor_id());
-	show_regs(regs);
-	pr_emerg("Process %s (pid: %d, stack limit = 0x%p)\n",
-		 tsk->comm, tsk->pid, end_of_stack(tsk));
-
-	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem("Stack: ", regs->sp, (regs->sp + PAGE_SIZE) & PAGE_MASK);
-		dump_stack();
-	}
-
-	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
-	make_task_dead(SIGSEGV);
-}
-
-EXPORT_SYMBOL(die);
-
-void die_if_kernel(const char *str, struct pt_regs *regs, int err)
-{
-	if (user_mode(regs))
-		return;
-
-	die(str, regs, err);
-}
-
-int bad_syscall(int n, struct pt_regs *regs)
-{
-	if (current->personality != PER_LINUX) {
-		send_sig(SIGSEGV, current, 1);
-		return regs->uregs[0];
-	}
-
-	force_sig_fault(SIGILL, ILL_ILLTRP,
-			(void __user *)instruction_pointer(regs) - 4);
-	die_if_kernel("Oops - bad syscall", regs, n);
-	return regs->uregs[0];
-}
-
-void __pte_error(const char *file, int line, unsigned long val)
-{
-	pr_emerg("%s:%d: bad pte %08lx.\n", file, line, val);
-}
-
-void __pmd_error(const char *file, int line, unsigned long val)
-{
-	pr_emerg("%s:%d: bad pmd %08lx.\n", file, line, val);
-}
-
-void __pgd_error(const char *file, int line, unsigned long val)
-{
-	pr_emerg("%s:%d: bad pgd %08lx.\n", file, line, val);
-}
-
-extern char *exception_vector, *exception_vector_end;
-void __init early_trap_init(void)
-{
-	unsigned long ivb = 0;
-	unsigned long base = PAGE_OFFSET;
-
-	memcpy((unsigned long *)base, (unsigned long *)&exception_vector,
-	       ((unsigned long)&exception_vector_end -
-		(unsigned long)&exception_vector));
-	ivb = __nds32__mfsr(NDS32_SR_IVB);
-	/* Check platform support. */
-	if (((ivb & IVB_mskNIVIC) >> IVB_offNIVIC) < 2)
-		panic
-		    ("IVIC mode is not allowed on the platform with interrupt controller\n");
-	__nds32__mtsr((ivb & ~IVB_mskESZ) | (IVB_valESZ16 << IVB_offESZ) |
-		      IVB_BASE, NDS32_SR_IVB);
-	__nds32__mtsr(INT_MASK_INITAIAL_VAL, NDS32_SR_INT_MASK);
-
-	/*
-	 * 0x800 = 128 vectors * 16byte.
-	 * It should be enough to flush a page.
-	 */
-	cpu_cache_wbinval_page(base, true);
-}
-
-static void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
-{
-	struct task_struct *tsk = current;
-
-	tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
-	tsk->thread.error_code = error_code;
-
-	force_sig_fault(SIGTRAP, si_code,
-			(void __user *)instruction_pointer(regs));
-}
-
-void do_debug_trap(unsigned long entry, unsigned long addr,
-		   unsigned long type, struct pt_regs *regs)
-{
-	if (notify_die(DIE_OOPS, "Oops", regs, addr, type, SIGTRAP)
-	    == NOTIFY_STOP)
-		return;
-
-	if (user_mode(regs)) {
-		/* trap_signal */
-		send_sigtrap(regs, 0, TRAP_BRKPT);
-	} else {
-		/* kernel_trap */
-		if (!fixup_exception(regs))
-			die("unexpected kernel_trap", regs, 0);
-	}
-}
-
-void unhandled_interruption(struct pt_regs *regs)
-{
-	pr_emerg("unhandled_interruption\n");
-	show_regs(regs);
-	if (!user_mode(regs))
-		make_task_dead(SIGKILL);
-	force_sig(SIGKILL);
-}
-
-void unhandled_exceptions(unsigned long entry, unsigned long addr,
-			  unsigned long type, struct pt_regs *regs)
-{
-	pr_emerg("Unhandled Exception: entry: %lx addr:%lx itype:%lx\n", entry,
-		 addr, type);
-	show_regs(regs);
-	if (!user_mode(regs))
-		make_task_dead(SIGKILL);
-	force_sig(SIGKILL);
-}
-
-extern int do_page_fault(unsigned long entry, unsigned long addr,
-			 unsigned int error_code, struct pt_regs *regs);
-
-/*
- * 2:DEF dispatch for TLB MISC exception handler
-*/
-
-void do_dispatch_tlb_misc(unsigned long entry, unsigned long addr,
-			  unsigned long type, struct pt_regs *regs)
-{
-	type = type & (ITYPE_mskINST | ITYPE_mskETYPE);
-	if ((type & ITYPE_mskETYPE) < 5) {
-		/* Permission exceptions */
-		do_page_fault(entry, addr, type, regs);
-	} else
-		unhandled_exceptions(entry, addr, type, regs);
-}
-
-void do_revinsn(struct pt_regs *regs)
-{
-	pr_emerg("Reserved Instruction\n");
-	show_regs(regs);
-	if (!user_mode(regs))
-		make_task_dead(SIGILL);
-	force_sig(SIGILL);
-}
-
-#ifdef CONFIG_ALIGNMENT_TRAP
-extern int unalign_access_mode;
-extern int do_unaligned_access(unsigned long addr, struct pt_regs *regs);
-#endif
-void do_dispatch_general(unsigned long entry, unsigned long addr,
-			 unsigned long itype, struct pt_regs *regs,
-			 unsigned long oipc)
-{
-	unsigned int swid = itype >> ITYPE_offSWID;
-	unsigned long type = itype & (ITYPE_mskINST | ITYPE_mskETYPE);
-	if (type == ETYPE_ALIGNMENT_CHECK) {
-#ifdef CONFIG_ALIGNMENT_TRAP
-		/* Alignment check */
-		if (user_mode(regs) && unalign_access_mode) {
-			int ret;
-			ret = do_unaligned_access(addr, regs);
-
-			if (ret == 0)
-				return;
-
-			if (ret == -EFAULT)
-				pr_emerg
-				    ("Unhandled unaligned access exception\n");
-		}
-#endif
-		do_page_fault(entry, addr, type, regs);
-	} else if (type == ETYPE_RESERVED_INSTRUCTION) {
-		/* Reserved instruction */
-		do_revinsn(regs);
-	} else if (type == ETYPE_COPROCESSOR) {
-		/* Coprocessor */
-#if IS_ENABLED(CONFIG_FPU)
-		unsigned int fucop_exist = __nds32__mfsr(NDS32_SR_FUCOP_EXIST);
-		unsigned int cpid = ((itype & ITYPE_mskCPID) >> ITYPE_offCPID);
-
-		if ((cpid == FPU_CPID) &&
-		    (fucop_exist & FUCOP_EXIST_mskCP0ISFPU)) {
-			unsigned int subtype = (itype & ITYPE_mskSTYPE);
-
-			if (true == do_fpu_exception(subtype, regs))
-				return;
-		}
-#endif
-		unhandled_exceptions(entry, addr, type, regs);
-	} else if (type == ETYPE_TRAP && swid == SWID_RAISE_INTERRUPT_LEVEL) {
-		/* trap, used on v3 EDM target debugging workaround */
-		/*
-		 * DIPC(OIPC) is passed as parameter before
-		 * interrupt is enabled, so the DIPC will not be corrupted
-		 * even though interrupts are coming in
-		 */
-		/*
-		 * 1. update ipc
-		 * 2. update pt_regs ipc with oipc
-		 * 3. update pt_regs ipsw (clear DEX)
-		 */
-		__asm__ volatile ("mtsr %0, $IPC\n\t"::"r" (oipc));
-		regs->ipc = oipc;
-		if (regs->pipsw & PSW_mskDEX) {
-			pr_emerg
-			    ("Nested Debug exception is possibly happened\n");
-			pr_emerg("ipc:%08x pipc:%08x\n",
-				 (unsigned int)regs->ipc,
-				 (unsigned int)regs->pipc);
-		}
-		do_debug_trap(entry, addr, itype, regs);
-		regs->ipsw &= ~PSW_mskDEX;
-	} else
-		unhandled_exceptions(entry, addr, type, regs);
-}
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
deleted file mode 100644
index e16009a07971..000000000000
--- a/arch/nds32/kernel/vdso.c
+++ /dev/null
@@ -1,231 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2012 ARM Limited
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/cache.h>
-#include <linux/clocksource.h>
-#include <linux/elf.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/slab.h>
-#include <linux/timekeeper_internal.h>
-#include <linux/vmalloc.h>
-#include <linux/random.h>
-
-#include <asm/cacheflush.h>
-#include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
-#include <asm/vdso_timer_info.h>
-#include <asm/cache_info.h>
-extern struct cache_info L1_cache_info[2];
-extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
-static unsigned long timer_mapping_base;
-
-struct timer_info_t timer_info = {
-	.cycle_count_down = true,
-	.mapping_base = EMPTY_TIMER_MAPPING,
-	.cycle_count_reg_offset = EMPTY_REG_OFFSET
-};
-/*
- * The vDSO data page.
- */
-static struct page *no_pages[] = { NULL };
-
-static union {
-	struct vdso_data data;
-	u8 page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
-	{
-	 .name = "[vvar]",
-	 .pages = no_pages,
-	 },
-	{
-	 .name = "[vdso]",
-	 },
-};
-
-static void get_timer_node_info(void)
-{
-	timer_mapping_base = timer_info.mapping_base;
-	vdso_data->cycle_count_offset =
-		timer_info.cycle_count_reg_offset;
-	vdso_data->cycle_count_down =
-		timer_info.cycle_count_down;
-}
-
-static int __init vdso_init(void)
-{
-	int i;
-	struct page **vdso_pagelist;
-
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		return -EINVAL;
-	}
-	/* Creat a timer io mapping to get clock cycles counter */
-	get_timer_node_info();
-
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
-
-	/* Allocate the vDSO pagelist */
-	vdso_pagelist = kcalloc(vdso_pages, sizeof(struct page *), GFP_KERNEL);
-	if (vdso_pagelist == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i] = virt_to_page(vdso_start + i * PAGE_SIZE);
-	vdso_spec[1].pages = &vdso_pagelist[0];
-
-	return 0;
-}
-
-arch_initcall(vdso_init);
-
-unsigned long inline vdso_random_addr(unsigned long vdso_mapping_len)
-{
-	unsigned long start = current->mm->mmap_base, end, offset, addr;
-	start = PAGE_ALIGN(start);
-
-	/* Round the lowest possible end address up to a PMD boundary. */
-	end = (start + vdso_mapping_len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE)
-		end = TASK_SIZE;
-	end -= vdso_mapping_len;
-
-	if (end > start) {
-		offset = get_random_int() % (((end - start) >> PAGE_SHIFT) + 1);
-		addr = start + (offset << PAGE_SHIFT);
-	} else {
-		addr = start;
-	}
-	return addr;
-}
-
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	struct vm_area_struct *vma;
-	unsigned long addr = 0;
-	pgprot_t prot;
-	int ret, vvar_page_num = 2;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-
-	if(timer_mapping_base == EMPTY_VALUE)
-		vvar_page_num = 1;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + vvar_page_num * PAGE_SIZE;
-#ifdef CONFIG_CPU_CACHE_ALIASING
-	vdso_mapping_len += L1_cache_info[DCACHE].aliasing_num - 1;
-#endif
-
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	addr = vdso_random_addr(vdso_mapping_len);
-	vdso_base = get_unmapped_area(NULL, addr, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = vdso_base;
-		goto up_fail;
-	}
-
-#ifdef CONFIG_CPU_CACHE_ALIASING
-	{
-		unsigned int aliasing_mask =
-		    L1_cache_info[DCACHE].aliasing_mask;
-		unsigned int page_colour_ofs;
-		page_colour_ofs = ((unsigned int)vdso_data & aliasing_mask) -
-		    (vdso_base & aliasing_mask);
-		vdso_base += page_colour_ofs & aliasing_mask;
-	}
-#endif
-
-	vma = _install_special_mapping(mm, vdso_base, vvar_page_num * PAGE_SIZE,
-				       VM_READ | VM_MAYREAD, &vdso_spec[0]);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto up_fail;
-	}
-
-	/*Map vdata to user space */
-	ret = io_remap_pfn_range(vma, vdso_base,
-				 virt_to_phys(vdso_data) >> PAGE_SHIFT,
-				 PAGE_SIZE, vma->vm_page_prot);
-	if (ret)
-		goto up_fail;
-
-	/*Map timer to user space */
-	vdso_base += PAGE_SIZE;
-	prot = __pgprot(_PAGE_V | _PAGE_M_UR_KR | _PAGE_D |  _PAGE_C_DEV);
-	ret = io_remap_pfn_range(vma, vdso_base, timer_mapping_base >> PAGE_SHIFT,
-				 PAGE_SIZE, prot);
-	if (ret)
-		goto up_fail;
-
-	/*Map vdso to user space */
-	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
-	vma = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto up_fail;
-	}
-
-	mmap_write_unlock(mm);
-	return 0;
-
-up_fail:
-	mm->context.vdso = NULL;
-	mmap_write_unlock(mm);
-	return ret;
-}
-
-static void vdso_write_begin(struct vdso_data *vdata)
-{
-	++vdso_data->seq_count;
-	smp_wmb();		/* Pairs with smp_rmb in vdso_read_retry */
-}
-
-static void vdso_write_end(struct vdso_data *vdata)
-{
-	smp_wmb();		/* Pairs with smp_rmb in vdso_read_begin */
-	++vdso_data->seq_count;
-}
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	vdso_write_begin(vdso_data);
-	vdso_data->cs_mask = tk->tkr_mono.mask;
-	vdso_data->cs_mult = tk->tkr_mono.mult;
-	vdso_data->cs_shift = tk->tkr_mono.shift;
-	vdso_data->cs_cycle_last = tk->tkr_mono.cycle_last;
-	vdso_data->wtm_clock_sec = tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtm_clock_nsec = tk->wall_to_monotonic.tv_nsec;
-	vdso_data->xtime_clock_sec = tk->xtime_sec;
-	vdso_data->xtime_clock_nsec = tk->tkr_mono.xtime_nsec;
-	vdso_data->xtime_coarse_sec = tk->xtime_sec;
-	vdso_data->xtime_coarse_nsec = tk->tkr_mono.xtime_nsec >>
-	    tk->tkr_mono.shift;
-	vdso_data->hrtimer_res = hrtimer_resolution;
-	vdso_write_end(vdso_data);
-}
-
-void update_vsyscall_tz(void)
-{
-	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
-}
diff --git a/arch/nds32/kernel/vdso/.gitignore b/arch/nds32/kernel/vdso/.gitignore
deleted file mode 100644
index 652e31d82582..000000000000
--- a/arch/nds32/kernel/vdso/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-vdso.lds
diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Makefile
deleted file mode 100644
index 55df25ef0057..000000000000
--- a/arch/nds32/kernel/vdso/Makefile
+++ /dev/null
@@ -1,79 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Building a vDSO image for AArch64.
-#
-# Author: Will Deacon <will.deacon@arm.com>
-# Heavily based on the vDSO Makefiles for other archs.
-#
-
-obj-vdso := note.o datapage.o sigreturn.o gettimeofday.o
-
-# Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg
-obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
-
-ccflags-y := -shared -fno-common -fno-builtin -nostdlib -fPIC -Wl,-shared -g \
-	-Wl,-soname=linux-vdso.so.1 -Wl,--hash-style=sysv
-
-# Disable gcov profiling for VDSO code
-GCOV_PROFILE := n
-
-
-obj-y += vdso.o
-targets += vdso.lds
-CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
-
-# Force dependency
-$(obj)/vdso.o : $(obj)/vdso.so
-
-# Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
-
-
-# Strip rule for the .so file
-$(obj)/%.so: OBJCOPYFLAGS := -S
-$(obj)/%.so: $(obj)/%.so.dbg FORCE
-	$(call if_changed,objcopy)
-
-# Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
-quiet_cmd_vdsosym = VDSOSYM $@
-      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
-
-include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
-
-
-# Assembly rules for the .S files
-
-sigreturn.o : sigreturn.S
-	$(call if_changed_dep,vdsoas)
-
-note.o : note.S
-	$(call if_changed_dep,vdsoas)
-
-datapage.o : datapage.S
-	$(call if_changed_dep,vdsoas)
-
-gettimeofday.o : gettimeofday.c FORCE
-	$(call if_changed_dep,vdsocc)
-
-# Actual build commands
-quiet_cmd_vdsold = VDSOL   $@
-      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
-quiet_cmd_vdsoas = VDSOA   $@
-      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
-quiet_cmd_vdsocc = VDSOA   $@
-      cmd_vdsocc = $(CC) $(c_flags) -c -o $@ $<
-
-# Install commands for the unstripped file
-quiet_cmd_vdso_install = INSTALL $@
-      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
-
-vdso.so: $(obj)/vdso.so.dbg
-	@mkdir -p $(MODLIB)/vdso
-	$(call cmd,vdso_install)
-
-vdso_install: vdso.so
diff --git a/arch/nds32/kernel/vdso/datapage.S b/arch/nds32/kernel/vdso/datapage.S
deleted file mode 100644
index 4a62c3cab1c8..000000000000
--- a/arch/nds32/kernel/vdso/datapage.S
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/page.h>
-
-ENTRY(__get_timerpage)
-	sethi	$r0, hi20(. + PAGE_SIZE + 8)
-	ori	$r0, $r0, lo12(. + PAGE_SIZE + 4)
-	mfusr	$r1, $pc
-	sub	$r0, $r1, $r0
-	ret
-ENDPROC(__get_timerpage)
-
-ENTRY(__get_datapage)
-	sethi	$r0, hi20(. + 2*PAGE_SIZE + 8)
-	ori	$r0, $r0, lo12(. + 2*PAGE_SIZE + 4)
-	mfusr	$r1, $pc
-	sub	$r0, $r1, $r0
-	ret
-ENDPROC(__get_datapage)
diff --git a/arch/nds32/kernel/vdso/gen_vdso_offsets.sh b/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
deleted file mode 100755
index 01924ff071ad..000000000000
--- a/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-
-#
-# Match symbols in the DSO that look like VDSO_*; produce a header file
-# of constant offsets into the shared object.
-#
-# Doing this inside the Makefile will break the $(filter-out) function,
-# causing Kbuild to rebuild the vdso-offsets header file every time.
-#
-# Author: Will Deacon <will.deacon@arm.com
-#
-
-LC_ALL=C
-sed -n -e 's/^00*/0/' -e \
-'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define vdso_offset_\2\t0x\1/p'
diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
deleted file mode 100644
index 9ec03cf0ec54..000000000000
--- a/arch/nds32/kernel/vdso/gettimeofday.c
+++ /dev/null
@@ -1,269 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/compiler.h>
-#include <linux/hrtimer.h>
-#include <linux/time.h>
-#include <asm/io.h>
-#include <asm/barrier.h>
-#include <asm/bug.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-#include <asm/vdso_datapage.h>
-#include <asm/vdso_timer_info.h>
-#include <asm/asm-offsets.h>
-
-#define X(x) #x
-#define Y(x) X(x)
-
-extern struct vdso_data *__get_datapage(void);
-extern struct vdso_data *__get_timerpage(void);
-
-static notrace unsigned int __vdso_read_begin(const struct vdso_data *vdata)
-{
-	u32 seq;
-repeat:
-	seq = READ_ONCE(vdata->seq_count);
-	if (seq & 1) {
-		cpu_relax();
-		goto repeat;
-	}
-	return seq;
-}
-
-static notrace unsigned int vdso_read_begin(const struct vdso_data *vdata)
-{
-	unsigned int seq;
-
-	seq = __vdso_read_begin(vdata);
-
-	smp_rmb();		/* Pairs with smp_wmb in vdso_write_end */
-	return seq;
-}
-
-static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
-{
-	smp_rmb();		/* Pairs with smp_wmb in vdso_write_begin */
-	return vdata->seq_count != start;
-}
-
-static notrace long clock_gettime_fallback(clockid_t _clkid,
-					   struct __kernel_old_timespec *_ts)
-{
-	register struct __kernel_old_timespec *ts asm("$r1") = _ts;
-	register clockid_t clkid asm("$r0") = _clkid;
-	register long ret asm("$r0");
-
-	asm volatile ("movi	$r15, %3\n"
-		      "syscall 	0x0\n"
-		      :"=r" (ret)
-		      :"r"(clkid), "r"(ts), "i"(__NR_clock_gettime)
-		      :"$r15", "memory");
-
-	return ret;
-}
-
-static notrace int do_realtime_coarse(struct __kernel_old_timespec *ts,
-				      struct vdso_data *vdata)
-{
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		ts->tv_sec = vdata->xtime_coarse_sec;
-		ts->tv_nsec = vdata->xtime_coarse_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-	return 0;
-}
-
-static notrace int do_monotonic_coarse(struct __kernel_old_timespec *ts,
-				       struct vdso_data *vdata)
-{
-	u32 seq;
-	u64 ns;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		ts->tv_sec = vdata->xtime_coarse_sec + vdata->wtm_clock_sec;
-		ns = vdata->xtime_coarse_nsec + vdata->wtm_clock_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-static notrace inline u64 vgetsns(struct vdso_data *vdso)
-{
-	u32 cycle_now;
-	u32 cycle_delta;
-	u32 *timer_cycle_base;
-
-	timer_cycle_base =
-	    (u32 *) ((char *)__get_timerpage() + vdso->cycle_count_offset);
-	cycle_now = readl_relaxed(timer_cycle_base);
-	if (true == vdso->cycle_count_down)
-		cycle_now = ~(*timer_cycle_base);
-	cycle_delta = cycle_now - (u32) vdso->cs_cycle_last;
-	return ((u64) cycle_delta & vdso->cs_mask) * vdso->cs_mult;
-}
-
-static notrace int do_realtime(struct __kernel_old_timespec *ts, struct vdso_data *vdata)
-{
-	unsigned count;
-	u64 ns;
-	do {
-		count = vdso_read_begin(vdata);
-		ts->tv_sec = vdata->xtime_clock_sec;
-		ns = vdata->xtime_clock_nsec;
-		ns += vgetsns(vdata);
-		ns >>= vdata->cs_shift;
-	} while (vdso_read_retry(vdata, count));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-static notrace int do_monotonic(struct __kernel_old_timespec *ts, struct vdso_data *vdata)
-{
-	u64 ns;
-	u32 seq;
-
-	do {
-		seq = vdso_read_begin(vdata);
-
-		ts->tv_sec = vdata->xtime_clock_sec;
-		ns = vdata->xtime_clock_nsec;
-		ns += vgetsns(vdata);
-		ns >>= vdata->cs_shift;
-
-		ts->tv_sec += vdata->wtm_clock_sec;
-		ns += vdata->wtm_clock_nsec;
-
-	} while (vdso_read_retry(vdata, seq));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace int __vdso_clock_gettime(clockid_t clkid, struct __kernel_old_timespec *ts)
-{
-	struct vdso_data *vdata;
-	int ret = -1;
-
-	vdata = __get_datapage();
-	if (vdata->cycle_count_offset == EMPTY_REG_OFFSET)
-		return clock_gettime_fallback(clkid, ts);
-
-	switch (clkid) {
-	case CLOCK_REALTIME_COARSE:
-		ret = do_realtime_coarse(ts, vdata);
-		break;
-	case CLOCK_MONOTONIC_COARSE:
-		ret = do_monotonic_coarse(ts, vdata);
-		break;
-	case CLOCK_REALTIME:
-		ret = do_realtime(ts, vdata);
-		break;
-	case CLOCK_MONOTONIC:
-		ret = do_monotonic(ts, vdata);
-		break;
-	default:
-		break;
-	}
-
-	if (ret)
-		ret = clock_gettime_fallback(clkid, ts);
-
-	return ret;
-}
-
-static notrace int clock_getres_fallback(clockid_t _clk_id,
-					  struct __kernel_old_timespec *_res)
-{
-	register clockid_t clk_id asm("$r0") = _clk_id;
-	register struct __kernel_old_timespec *res asm("$r1") = _res;
-	register int ret asm("$r0");
-
-	asm volatile ("movi	$r15, %3\n"
-		      "syscall	0x0\n"
-		      :"=r" (ret)
-		      :"r"(clk_id), "r"(res), "i"(__NR_clock_getres)
-		      :"$r15", "memory");
-
-	return ret;
-}
-
-notrace int __vdso_clock_getres(clockid_t clk_id, struct __kernel_old_timespec *res)
-{
-	struct vdso_data *vdata = __get_datapage();
-
-	if (res == NULL)
-		return 0;
-	switch (clk_id) {
-	case CLOCK_REALTIME:
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		res->tv_sec = 0;
-		res->tv_nsec = vdata->hrtimer_res;
-		break;
-	case CLOCK_REALTIME_COARSE:
-	case CLOCK_MONOTONIC_COARSE:
-		res->tv_sec = 0;
-		res->tv_nsec = CLOCK_COARSE_RES;
-		break;
-	default:
-		return clock_getres_fallback(clk_id, res);
-	}
-	return 0;
-}
-
-static notrace inline int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
-						struct timezone *_tz)
-{
-	register struct __kernel_old_timeval *tv asm("$r0") = _tv;
-	register struct timezone *tz asm("$r1") = _tz;
-	register int ret asm("$r0");
-
-	asm volatile ("movi	$r15, %3\n"
-		      "syscall	0x0\n"
-		      :"=r" (ret)
-		      :"r"(tv), "r"(tz), "i"(__NR_gettimeofday)
-		      :"$r15", "memory");
-
-	return ret;
-}
-
-notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	struct __kernel_old_timespec ts;
-	struct vdso_data *vdata;
-	int ret;
-
-	vdata = __get_datapage();
-
-	if (vdata->cycle_count_offset == EMPTY_REG_OFFSET)
-		return gettimeofday_fallback(tv, tz);
-
-	ret = do_realtime(&ts, vdata);
-
-	if (tv) {
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-	if (tz) {
-		tz->tz_minuteswest = vdata->tz_minuteswest;
-		tz->tz_dsttime = vdata->tz_dsttime;
-	}
-
-	return ret;
-}
diff --git a/arch/nds32/kernel/vdso/note.S b/arch/nds32/kernel/vdso/note.S
deleted file mode 100644
index 0aeaa19b05f0..000000000000
--- a/arch/nds32/kernel/vdso/note.S
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2012 ARM Limited
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/uts.h>
-#include <linux/version.h>
-#include <linux/elfnote.h>
-
-ELFNOTE_START(Linux, 0, "a")
-	.long LINUX_VERSION_CODE
-ELFNOTE_END
diff --git a/arch/nds32/kernel/vdso/sigreturn.S b/arch/nds32/kernel/vdso/sigreturn.S
deleted file mode 100644
index 67e4d1d1612a..000000000000
--- a/arch/nds32/kernel/vdso/sigreturn.S
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2012 ARM Limited
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/unistd.h>
-
-	.text
-
-ENTRY(__kernel_rt_sigreturn)
-	.cfi_startproc
-	movi $r15, __NR_rt_sigreturn
-	/*
-	 * The SWID of syscall should be __NR_rt_sigreturn to synchronize
-	 * the unwinding scheme in gcc
-	 */
-	syscall	__NR_rt_sigreturn
-	.cfi_endproc
-ENDPROC(__kernel_rt_sigreturn)
diff --git a/arch/nds32/kernel/vdso/vdso.S b/arch/nds32/kernel/vdso/vdso.S
deleted file mode 100644
index 16737c11e55b..000000000000
--- a/arch/nds32/kernel/vdso/vdso.S
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2012 ARM Limited
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/init.h>
-#include <linux/linkage.h>
-#include <linux/const.h>
-#include <asm/page.h>
-
-	.globl vdso_start, vdso_end
-	.section .rodata
-	.balign PAGE_SIZE
-vdso_start:
-	.incbin "arch/nds32/kernel/vdso/vdso.so"
-	.balign PAGE_SIZE
-vdso_end:
-
-	.previous
diff --git a/arch/nds32/kernel/vdso/vdso.lds.S b/arch/nds32/kernel/vdso/vdso.lds.S
deleted file mode 100644
index 1f2b16004594..000000000000
--- a/arch/nds32/kernel/vdso/vdso.lds.S
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- * Copyright (C) 2005-2017 Andes Technology Corporation
- */
-
-
-#include <linux/const.h>
-#include <asm/page.h>
-#include <asm/vdso.h>
-
-OUTPUT_ARCH(nds32)
-
-SECTIONS
-{
-	. = SIZEOF_HEADERS;
-
-	.hash		: { *(.hash) }			:text
-	.gnu.hash	: { *(.gnu.hash) }
-	.dynsym		: { *(.dynsym) }
-	.dynstr		: { *(.dynstr) }
-	.gnu.version	: { *(.gnu.version) }
-	.gnu.version_d	: { *(.gnu.version_d) }
-	.gnu.version_r	: { *(.gnu.version_r) }
-
-	.note		: { *(.note.*) }		:text	:note
-
-
-	.text		: { *(.text*) }			:text
-
-	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
-
-	.dynamic	: { *(.dynamic) }		:text	:dynamic
-
-	.rodata		: { *(.rodata*) }		:text
-
-
-	/DISCARD/	: {
-		*(.note.GNU-stack)
-		*(.data .data.* .gnu.linkonce.d.* .sdata*)
-		*(.bss .sbss .dynbss .dynsbss)
-	}
-}
-
-/*
- * We must supply the ELF program headers explicitly to get just one
- * PT_LOAD segment, and set the flags explicitly to make segments read-only.
- */
-PHDRS
-{
-	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
-	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
-	note		PT_NOTE		FLAGS(4);		/* PF_R */
-	eh_frame_hdr	PT_GNU_EH_FRAME;
-}
-
-/*
- * This controls what symbols we export from the DSO.
- */
-VERSION
-{
-	LINUX_4 {
-	global:
-		__kernel_rt_sigreturn;
-		__vdso_gettimeofday;
-		__vdso_clock_getres;
-		__vdso_clock_gettime;
-	local: *;
-	};
-}
-
-/*
- * Make the rt_sigreturn code visible to the kernel.
- */
-VDSO_rt_sigtramp	= __kernel_rt_sigreturn;
diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
deleted file mode 100644
index 6a91b965fb1e..000000000000
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <asm/page.h>
-#include <asm/thread_info.h>
-#include <asm/cache.h>
-#include <asm/memory.h>
-
-#define LOAD_OFFSET	(PAGE_OFFSET - PHYS_OFFSET)
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_ARCH(nds32)
-ENTRY(_stext_lma)
-jiffies = jiffies_64;
-
-#if defined(CONFIG_GCOV_KERNEL)
-#define NDS32_EXIT_KEEP(x)	x
-#else
-#define NDS32_EXIT_KEEP(x)
-#endif
-
-SECTIONS
-{
-	_stext_lma = TEXTADDR - LOAD_OFFSET;
-	. = TEXTADDR;
-	__init_begin = .;
-	HEAD_TEXT_SECTION
-	.exit.text : {
-		NDS32_EXIT_KEEP(EXIT_TEXT)
-	}
-	INIT_TEXT_SECTION(PAGE_SIZE)
-	INIT_DATA_SECTION(16)
-	.exit.data : {
-		NDS32_EXIT_KEEP(EXIT_DATA)
-	}
-	PERCPU_SECTION(L1_CACHE_BYTES)
-	__init_end = .;
-
-	. = ALIGN(PAGE_SIZE);
-	_stext = .;
-	/* Real text segment */
-	.text : AT(ADDR(.text) - LOAD_OFFSET) {
-		_text = .;		/* Text and read-only data	*/
-		TEXT_TEXT
-		SCHED_TEXT
-		CPUIDLE_TEXT
-		LOCK_TEXT
-		KPROBES_TEXT
-		IRQENTRY_TEXT
-		SOFTIRQENTRY_TEXT
-		*(.fixup)
-	}
-
-	_etext = .;			/* End of text and rodata section */
-
-	_sdata = .;
-	RO_DATA(PAGE_SIZE)
-	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
-	_edata  =  .;
-
-	EXCEPTION_TABLE(16)
-	BSS_SECTION(4, 4, 4)
-	_end = .;
-
-	STABS_DEBUG
-	DWARF_DEBUG
-	ELF_DETAILS
-
-	DISCARDS
-}
diff --git a/arch/nds32/lib/Makefile b/arch/nds32/lib/Makefile
deleted file mode 100644
index dddbc15d6b37..000000000000
--- a/arch/nds32/lib/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-lib-y		:= copy_page.o memcpy.o memmove.o   \
-		   memset.o memzero.o \
-		   copy_from_user.o copy_to_user.o clear_user.o
diff --git a/arch/nds32/lib/clear_user.S b/arch/nds32/lib/clear_user.S
deleted file mode 100644
index 805dfcd25bf8..000000000000
--- a/arch/nds32/lib/clear_user.S
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-
-/* Prototype: int __arch_clear_user(void *addr, size_t sz)
- * Purpose  : clear some user memory
- * Params   : addr - user memory address to clear
- *          : sz   - number of bytes to clear
- * Returns  : number of bytes NOT cleared
- */
-	.text
-	.align	5
-ENTRY(__arch_clear_user)
-	add	$r5, $r0, $r1
-	beqz	$r1, clear_exit
-	xor	$p1, $p1, $p1		! Use $p1=0 to clear mem
-	srli	$p0, $r1, #2		! $p0 = number of word to clear
-	andi	$r1, $r1, #3		! Bytes less than a word to copy
-	beqz	$p0, byte_clear		! Only less than a word to clear
-word_clear:
-USER(	smw.bim,$p1, [$r0], $p1)	! Clear the word
-	addi	$p0, $p0, #-1		! Decrease word count
-	bnez	$p0, word_clear		! Continue looping to clear all words
-	beqz	$r1, clear_exit		! No left bytes to copy
-byte_clear:
-USER(	sbi.bi,	$p1, [$r0], #1)		! Clear the byte
-	addi	$r1, $r1, #-1		! Decrease byte count
-	bnez	$r1, byte_clear		! Continue looping to clear all left bytes
-clear_exit:
-	move	$r0, $r1		! Set return value
-	ret
-
-	.section .fixup,"ax"
-	.align	0
-9001:
-	sub	$r0, $r5, $r0		! Bytes left to copy
-	ret
-	.previous
-ENDPROC(__arch_clear_user)
diff --git a/arch/nds32/lib/copy_from_user.S b/arch/nds32/lib/copy_from_user.S
deleted file mode 100644
index ad1857b20067..000000000000
--- a/arch/nds32/lib/copy_from_user.S
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-
-.macro 	lbi1 dst, addr, adj
-USER( lbi.bi, \dst, [\addr], \adj)
-.endm
-
-.macro 	sbi1 src, addr, adj
-sbi.bi	\src, [\addr], \adj
-.endm
-
-.macro	lmw1 start_reg, addr, end_reg
-USER( lmw.bim, \start_reg, [\addr], \end_reg)
-.endm
-
-.macro	smw1 start_reg, addr, end_reg
-smw.bim \start_reg, [\addr], \end_reg
-.endm
-
-
-/* Prototype: int __arch_copy_from_user(void *to, const char *from, size_t n)
- * Purpose  : copy a block from user memory to kernel memory
- * Params   : to   - kernel memory
- *          : from - user memory
- *          : n    - number of bytes to copy
- * Returns  : Number of bytes NOT copied.
- */
-
-.text
-ENTRY(__arch_copy_from_user)
-	add	$r5, $r0, $r2
-#include "copy_template.S"
-	move	$r0, $r2
-	ret
-.section .fixup,"ax"
-.align  2
-9001:
-	sub	$r0, $r5, $r0
-	ret
-.previous
-ENDPROC(__arch_copy_from_user)
diff --git a/arch/nds32/lib/copy_page.S b/arch/nds32/lib/copy_page.S
deleted file mode 100644
index f8701ed161a8..000000000000
--- a/arch/nds32/lib/copy_page.S
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/export.h>
-#include <asm/page.h>
-
-	.text
-ENTRY(copy_page)
-	pushm	$r2, $r10
-	movi	$r2, PAGE_SIZE >> 5
-.Lcopy_loop:
-	lmw.bim	$r3, [$r1], $r10
-	smw.bim	$r3, [$r0], $r10
-	subi45	$r2, #1
-	bnez38	$r2, .Lcopy_loop
-	popm	$r2, $r10
-	ret
-ENDPROC(copy_page)
-EXPORT_SYMBOL(copy_page)
-
-ENTRY(clear_page)
-	pushm	$r1, $r9
-	movi	$r1, PAGE_SIZE >> 5
-	movi55	$r2, #0
-	movi55	$r3, #0
-	movi55	$r4, #0
-	movi55	$r5, #0
-	movi55	$r6, #0
-	movi55	$r7, #0
-	movi55	$r8, #0
-	movi55	$r9, #0
-.Lclear_loop:
-	smw.bim	$r2, [$r0], $r9
-	subi45	$r1, #1
-	bnez38	$r1, .Lclear_loop
-	popm	$r1, $r9
-        ret
-ENDPROC(clear_page)
-EXPORT_SYMBOL(clear_page)
diff --git a/arch/nds32/lib/copy_template.S b/arch/nds32/lib/copy_template.S
deleted file mode 100644
index 3a9a2de468c2..000000000000
--- a/arch/nds32/lib/copy_template.S
+++ /dev/null
@@ -1,69 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-
-	beq	$r1, $r0, quit_memcpy
-	beqz	$r2, quit_memcpy
-	srli    $r3, $r2, #5	! check if len < cache-line size 32
-	beqz	$r3, word_copy_entry
-	andi	$r4, $r0, #0x3	! check byte-align
-	beqz	$r4, unalign_word_copy_entry
-
-	addi	$r4, $r4,#-4
-	abs	$r4, $r4	! check how many un-align byte to copy
-	sub	$r2, $r2, $r4	! update $R2
-
-unalign_byte_copy:
-	lbi1	$r3, $r1, #1
-	addi	$r4, $r4, #-1
-	sbi1	$r3, $r0, #1
-	bnez	$r4, unalign_byte_copy
-	beqz	$r2, quit_memcpy
-
-unalign_word_copy_entry:
-	andi	$r3, $r0, 0x1f	! check cache-line unaligncount
-	beqz	$r3, cache_copy
-
-	addi	$r3, $r3, #-32
-	abs	$r3, $r3
-	sub	$r2, $r2, $r3	! update $R2
-
-unalign_word_copy:
-	lmw1	$r4, $r1, $r4
-	addi	$r3, $r3, #-4
-	smw1	$r4, $r0, $r4
-	bnez	$r3, unalign_word_copy
-	beqz	$r2, quit_memcpy
-
-	addi	$r3, $r2, #-32	! to check $r2< cache_line , than go to word_copy
-	bltz	$r3, word_copy_entry
-cache_copy:
-	srli	$r3, $r2, #5
-	beqz	$r3, word_copy_entry
-3:
-	lmw1	$r17, $r1, $r24
-	addi	$r3, $r3, #-1
-	smw1	$r17, $r0, $r24
-	bnez	$r3, 3b
-
-word_copy_entry:
-	andi	$r2, $r2, #31
-
-	beqz	$r2, quit_memcpy
-5:
-	srli	$r3, $r2, #2
-	beqz	$r3, byte_copy
-word_copy:
-	lmw1	$r4, $r1, $r4
-	addi	$r3, $r3, #-1
-	smw1	$r4, $r0, $r4
-	bnez	$r3, word_copy
-	andi	$r2, $r2, #3
-	beqz	$r2, quit_memcpy
-byte_copy:
-	lbi1	$r3, $r1, #1
-	addi	$r2, $r2, #-1
-
-	sbi1	$r3, $r0, #1
-	bnez	$r2, byte_copy
-quit_memcpy:
diff --git a/arch/nds32/lib/copy_to_user.S b/arch/nds32/lib/copy_to_user.S
deleted file mode 100644
index 3230044dcfb8..000000000000
--- a/arch/nds32/lib/copy_to_user.S
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/errno.h>
-
-.macro 	lbi1 dst, addr, adj
-lbi.bi	\dst, [\addr], \adj
-.endm
-
-.macro 	sbi1 src, addr, adj
-USER( sbi.bi, \src, [\addr], \adj)
-.endm
-
-.macro	lmw1 start_reg, addr, end_reg
-lmw.bim \start_reg, [\addr], \end_reg
-.endm
-
-.macro	smw1 start_reg, addr, end_reg
-USER( smw.bim, \start_reg, [\addr], \end_reg)
-.endm
-
-
-/* Prototype: int __arch_copy_to_user(void *to, const char *from, size_t n)
- * Purpose  : copy a block to user memory from kernel memory
- * Params   : to   - user memory
- *          : from - kernel memory
- *          : n    - number of bytes to copy
- * Returns  : Number of bytes NOT copied.
- */
-
-.text
-ENTRY(__arch_copy_to_user)
-	add	$r5, $r0, $r2
-#include "copy_template.S"
-	move	$r0, $r2
-	ret
-.section .fixup,"ax"
-.align  2
-9001:
-	sub	$r0, $r5, $r0
-	ret
-.previous
-ENDPROC(__arch_copy_to_user)
diff --git a/arch/nds32/lib/memcpy.S b/arch/nds32/lib/memcpy.S
deleted file mode 100644
index a2345ea721e4..000000000000
--- a/arch/nds32/lib/memcpy.S
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-
-
-.macro 	lbi1 dst, addr, adj
-lbi.bi	\dst, [\addr], \adj
-.endm
-
-.macro 	sbi1 src, addr, adj
-sbi.bi	\src, [\addr], \adj
-.endm
-
-.macro	lmw1 start_reg, addr, end_reg
-lmw.bim \start_reg, [\addr], \end_reg
-.endm
-
-.macro	smw1 start_reg, addr, end_reg
-smw.bim \start_reg, [\addr], \end_reg
-.endm
-
-.text
-ENTRY(memcpy)
-	move	$r5, $r0
-#include "copy_template.S"
-	move	$r0, $r5
-	ret
-
-ENDPROC(memcpy)
diff --git a/arch/nds32/lib/memmove.S b/arch/nds32/lib/memmove.S
deleted file mode 100644
index c823aada2271..000000000000
--- a/arch/nds32/lib/memmove.S
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-
-/*
-  void *memmove(void *dst, const void *src, int n);
-
-  dst: $r0
-  src: $r1
-  n  : $r2
-  ret: $r0 - pointer to the memory area dst.
-*/
-	.text
-
-ENTRY(memmove)
-	move	$r5, $r0		! Set return value = det
-	beq	$r0, $r1, exit_memcpy	! Exit when det = src
-	beqz	$r2, exit_memcpy	! Exit when n = 0
-	pushm	$t0, $t1		! Save reg
-	srli	$p1, $r2, #2		! $p1 is how many words to copy
-
-	! Avoid data lost when memory overlap
-	! Copy data reversely when src < dst
-	slt	$p0, $r0, $r1		! check if $r0 < $r1
-	beqz	$p0, do_reverse		! branch if dst > src
-
-	! No reverse, dst < src
-	andi	$r2, $r2, #3		! How many bytes are less than a word
-	li	$t0, #1			! Determining copy direction in byte_cpy
-	beqz	$p1, byte_cpy		! When n is less than a word
-
-word_cpy:
-	lmw.bim	$p0, [$r1], $p0		! Read a word from src
-	addi	$p1, $p1, #-1		! How many words left to copy
-	smw.bim	$p0, [$r0], $p0		! Copy the word to det
-	bnez	$p1, word_cpy		! If remained words > 0
-	beqz	$r2, end_memcpy		! No left bytes to copy
-	b	byte_cpy
-
-do_reverse:
-	add	$r0, $r0, $r2		! Start with the end of $r0
-	add	$r1, $r1, $r2		! Start with the end of $r1
-	andi	$r2, $r2, #3		! How many bytes are less than a word
-	li	$t0, #-1		! Determining copy direction in byte_cpy
-	beqz	$p1, reverse_byte_cpy	! When n is less than a word
-
-reverse_word_cpy:
-	lmw.adm	$p0, [$r1], $p0		! Read a word from src
-	addi	$p1, $p1, #-1		! How many words left to copy
-	smw.adm	$p0, [$r0], $p0		! Copy the word to det
-	bnez	$p1, reverse_word_cpy	! If remained words > 0
-	beqz	$r2, end_memcpy		! No left bytes to copy
-
-reverse_byte_cpy:
-	addi	$r0, $r0, #-1
-	addi	$r1, $r1, #-1
-byte_cpy:				! Less than 4 bytes to copy now
-	lb.bi	$p0, [$r1], $t0		! Read a byte from src
-	addi	$r2, $r2, #-1		! How many bytes left to copy
-	sb.bi	$p0, [$r0], $t0		! copy the byte to det
-	bnez	$r2, byte_cpy		! If remained bytes > 0
-
-end_memcpy:
-	popm	$t0, $t1
-exit_memcpy:
-	move	$r0, $r5
-	ret
-
-ENDPROC(memmove)
diff --git a/arch/nds32/lib/memset.S b/arch/nds32/lib/memset.S
deleted file mode 100644
index 193cb6ce21a9..000000000000
--- a/arch/nds32/lib/memset.S
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-
-	.text
-ENTRY(memset)
-	move	$r5, $r0		! Return value
-	beqz	$r2, end_memset		! Exit when len = 0
-	srli	$p1, $r2, 2		! $p1 is how many words to copy
-	andi	$r2, $r2, 3		! How many bytes are less than a word
-	beqz	$p1, byte_set		! When n is less than a word
-
-	! set $r1 from ??????ab to abababab
-	andi	$r1, $r1, #0x00ff	! $r1 = 000000ab
-	slli	$p0, $r1, #8		! $p0 = 0000ab00
-	or	$r1, $r1, $p0		! $r1 = 0000abab
-	slli	$p0, $r1, #16		! $p0 = abab0000
-	or	$r1, $r1, $p0		! $r1 = abababab
-word_set:
-	addi	$p1, $p1, #-1		! How many words left to copy
-	smw.bim	$r1, [$r0], $r1		! Copy the word to det
-	bnez	$p1, word_set		! Still words to set, continue looping
-	beqz	$r2, end_memset		! No left byte to set
-byte_set:				! Less than 4 bytes left to set
-	addi	$r2, $r2, #-1		! Decrease len by 1
-	sbi.bi	$r1, [$r0], #1		! Set data of the next byte to $r1
-	bnez	$r2, byte_set		! Still bytes left to set
-end_memset:
-	move	$r0, $r5
-	ret
-
-ENDPROC(memset)
diff --git a/arch/nds32/lib/memzero.S b/arch/nds32/lib/memzero.S
deleted file mode 100644
index f055972c9343..000000000000
--- a/arch/nds32/lib/memzero.S
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/linkage.h>
-
-	.text
-ENTRY(memzero)
-	beqz	$r1, 1f
-	push	$lp
-	move    $r2, $r1
-	move    $r1, #0
-	push	$r0
-	bal     memset
-	pop	$r0
-	pop	$lp
-1:
-        ret
-ENDPROC(memzero)
diff --git a/arch/nds32/math-emu/Makefile b/arch/nds32/math-emu/Makefile
deleted file mode 100644
index 3bed7e5d5d05..000000000000
--- a/arch/nds32/math-emu/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the Linux/nds32 kernel FPU emulation.
-#
-
-obj-y	:= fpuemu.o \
-	   fdivd.o fmuld.o fsubd.o faddd.o fs2d.o fsqrtd.o fcmpd.o fnegs.o \
-	   fd2si.o fd2ui.o fd2siz.o fd2uiz.o fsi2d.o fui2d.o \
-	   fdivs.o fmuls.o fsubs.o fadds.o fd2s.o fsqrts.o fcmps.o fnegd.o \
-	   fs2si.o fs2ui.o fs2siz.o fs2uiz.o fsi2s.o fui2s.o
diff --git a/arch/nds32/math-emu/faddd.c b/arch/nds32/math-emu/faddd.c
deleted file mode 100644
index f7fd4e3c3904..000000000000
--- a/arch/nds32/math-emu/faddd.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-void faddd(void *ft, void *fa, void *fb)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(B);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-	FP_UNPACK_DP(B, fb);
-
-	FP_ADD_D(R, A, B);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/math-emu/fadds.c b/arch/nds32/math-emu/fadds.c
deleted file mode 100644
index f5af6ca8cca5..000000000000
--- a/arch/nds32/math-emu/fadds.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fadds(void *ft, void *fa, void *fb)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(B);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-	FP_UNPACK_SP(B, fb);
-
-	FP_ADD_S(R, A, B);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/math-emu/fcmpd.c b/arch/nds32/math-emu/fcmpd.c
deleted file mode 100644
index 0ea225abe880..000000000000
--- a/arch/nds32/math-emu/fcmpd.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-int fcmpd(void *ft, void *fa, void *fb, int cmpop)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(B);
-	FP_DECL_EX;
-	long cmp;
-
-	FP_UNPACK_DP(A, fa);
-	FP_UNPACK_DP(B, fb);
-
-	FP_CMP_D(cmp, A, B, SF_CUN);
-	cmp += 2;
-	if (cmp == SF_CGT)
-		*(long *)ft = 0;
-	else
-		*(long *)ft = (cmp & cmpop) ? 1 : 0;
-
-	return 0;
-}
diff --git a/arch/nds32/math-emu/fcmps.c b/arch/nds32/math-emu/fcmps.c
deleted file mode 100644
index 681480758213..000000000000
--- a/arch/nds32/math-emu/fcmps.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-int fcmps(void *ft, void *fa, void *fb, int cmpop)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(B);
-	FP_DECL_EX;
-	long cmp;
-
-	FP_UNPACK_SP(A, fa);
-	FP_UNPACK_SP(B, fb);
-
-	FP_CMP_S(cmp, A, B, SF_CUN);
-	cmp += 2;
-	if (cmp == SF_CGT)
-		*(int *)ft = 0x0;
-	else
-		*(int *)ft = (cmp & cmpop) ? 0x1 : 0x0;
-
-	return 0;
-}
diff --git a/arch/nds32/math-emu/fd2s.c b/arch/nds32/math-emu/fd2s.c
deleted file mode 100644
index 1328371e8170..000000000000
--- a/arch/nds32/math-emu/fd2s.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
-#include <math-emu/soft-fp.h>
-void fd2s(void *ft, void *fa)
-{
-	FP_DECL_D(A);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	FP_CONV(S, D, 1, 2, R, A);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fd2si.c b/arch/nds32/math-emu/fd2si.c
deleted file mode 100644
index fae3e16a0a10..000000000000
--- a/arch/nds32/math-emu/fd2si.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fd2si(void *ft, void *fa)
-{
-	int r;
-
-	FP_DECL_D(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_ROUND_D(r, A, 32, 1);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(int *)ft = r;
-	}
-
-}
diff --git a/arch/nds32/math-emu/fd2siz.c b/arch/nds32/math-emu/fd2siz.c
deleted file mode 100644
index 92fe6774f112..000000000000
--- a/arch/nds32/math-emu/fd2siz.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fd2si_z(void *ft, void *fa)
-{
-	int r;
-
-	FP_DECL_D(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_D(r, A, 32, 1);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(int *)ft = r;
-	}
-
-}
diff --git a/arch/nds32/math-emu/fd2ui.c b/arch/nds32/math-emu/fd2ui.c
deleted file mode 100644
index a0423b699aa4..000000000000
--- a/arch/nds32/math-emu/fd2ui.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fd2ui(void *ft, void *fa)
-{
-	unsigned int r;
-
-	FP_DECL_D(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(unsigned int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_ROUND_D(r, A, 32, 0);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(unsigned int *)ft = r;
-	}
-
-}
diff --git a/arch/nds32/math-emu/fd2uiz.c b/arch/nds32/math-emu/fd2uiz.c
deleted file mode 100644
index 8ae17cfce90d..000000000000
--- a/arch/nds32/math-emu/fd2uiz.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fd2ui_z(void *ft, void *fa)
-{
-	unsigned int r;
-
-	FP_DECL_D(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(unsigned int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_D(r, A, 32, 0);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(unsigned int *)ft = r;
-	}
-
-}
diff --git a/arch/nds32/math-emu/fdivd.c b/arch/nds32/math-emu/fdivd.c
deleted file mode 100644
index 458e7e98b08e..000000000000
--- a/arch/nds32/math-emu/fdivd.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <linux/uaccess.h>
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fdivd(void *ft, void *fa, void *fb)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(B);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-	FP_UNPACK_DP(B, fb);
-
-	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO)
-		FP_SET_EXCEPTION(FP_EX_DIVZERO);
-
-	FP_DIV_D(R, A, B);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fdivs.c b/arch/nds32/math-emu/fdivs.c
deleted file mode 100644
index c7d202159ce2..000000000000
--- a/arch/nds32/math-emu/fdivs.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fdivs(void *ft, void *fa, void *fb)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(B);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-	FP_UNPACK_SP(B, fb);
-
-	if (B_c == FP_CLS_ZERO && A_c != FP_CLS_ZERO)
-		FP_SET_EXCEPTION(FP_EX_DIVZERO);
-
-	FP_DIV_S(R, A, B);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fmuld.c b/arch/nds32/math-emu/fmuld.c
deleted file mode 100644
index f3c77a45ddc2..000000000000
--- a/arch/nds32/math-emu/fmuld.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-void fmuld(void *ft, void *fa, void *fb)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(B);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-	FP_UNPACK_DP(B, fb);
-
-	FP_MUL_D(R, A, B);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fmuls.c b/arch/nds32/math-emu/fmuls.c
deleted file mode 100644
index cf150df938f9..000000000000
--- a/arch/nds32/math-emu/fmuls.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fmuls(void *ft, void *fa, void *fb)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(B);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-	FP_UNPACK_SP(B, fb);
-
-	FP_MUL_S(R, A, B);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fnegd.c b/arch/nds32/math-emu/fnegd.c
deleted file mode 100644
index de7ea6a0873e..000000000000
--- a/arch/nds32/math-emu/fnegd.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-void fnegd(void *ft, void *fa)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	FP_NEG_D(R, A);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fnegs.c b/arch/nds32/math-emu/fnegs.c
deleted file mode 100644
index 07270b326a77..000000000000
--- a/arch/nds32/math-emu/fnegs.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fnegs(void *ft, void *fa)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	FP_NEG_S(R, A);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fpuemu.c b/arch/nds32/math-emu/fpuemu.c
deleted file mode 100644
index 46558a15c0dc..000000000000
--- a/arch/nds32/math-emu/fpuemu.c
+++ /dev/null
@@ -1,406 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <asm/bitfield.h>
-#include <asm/uaccess.h>
-#include <asm/sfp-machine.h>
-#include <asm/fpuemu.h>
-#include <asm/nds32_fpu_inst.h>
-
-#define DPFROMREG(dp, x) (dp = (void *)((unsigned long *)fpu_reg + 2*x))
-#ifdef __NDS32_EL__
-#define SPFROMREG(sp, x)\
-	((sp) = (void *)((unsigned long *)fpu_reg + (x^1)))
-#else
-#define SPFROMREG(sp, x) ((sp) = (void *)((unsigned long *)fpu_reg + x))
-#endif
-
-#define DEF3OP(name, p, f1, f2) \
-void fpemu_##name##p(void *ft, void *fa, void *fb) \
-{ \
-	f1(fa, fa, fb); \
-	f2(ft, ft, fa); \
-}
-
-#define DEF3OPNEG(name, p, f1, f2, f3) \
-void fpemu_##name##p(void *ft, void *fa, void *fb) \
-{ \
-	f1(fa, fa, fb); \
-	f2(ft, ft, fa); \
-	f3(ft, ft); \
-}
-DEF3OP(fmadd, s, fmuls, fadds);
-DEF3OP(fmsub, s, fmuls, fsubs);
-DEF3OP(fmadd, d, fmuld, faddd);
-DEF3OP(fmsub, d, fmuld, fsubd);
-DEF3OPNEG(fnmadd, s, fmuls, fadds, fnegs);
-DEF3OPNEG(fnmsub, s, fmuls, fsubs, fnegs);
-DEF3OPNEG(fnmadd, d, fmuld, faddd, fnegd);
-DEF3OPNEG(fnmsub, d, fmuld, fsubd, fnegd);
-
-static const unsigned char cmptab[8] = {
-	SF_CEQ,
-	SF_CEQ,
-	SF_CLT,
-	SF_CLT,
-	SF_CLT | SF_CEQ,
-	SF_CLT | SF_CEQ,
-	SF_CUN,
-	SF_CUN
-};
-
-enum ARGTYPE {
-	S1S = 1,
-	S2S,
-	S1D,
-	CS,
-	D1D,
-	D2D,
-	D1S,
-	CD
-};
-union func_t {
-	void (*t)(void *ft, void *fa, void *fb);
-	void (*b)(void *ft, void *fa);
-};
-/*
- * Emulate a single FPU arithmetic instruction.
- */
-static int fpu_emu(struct fpu_struct *fpu_reg, unsigned long insn)
-{
-	int rfmt;		/* resulting format */
-	union func_t func;
-	int ftype = 0;
-
-	switch (rfmt = NDS32Insn_OPCODE_COP0(insn)) {
-	case fs1_op:{
-			switch (NDS32Insn_OPCODE_BIT69(insn)) {
-			case fadds_op:
-				func.t = fadds;
-				ftype = S2S;
-				break;
-			case fsubs_op:
-				func.t = fsubs;
-				ftype = S2S;
-				break;
-			case fmadds_op:
-				func.t = fpemu_fmadds;
-				ftype = S2S;
-				break;
-			case fmsubs_op:
-				func.t = fpemu_fmsubs;
-				ftype = S2S;
-				break;
-			case fnmadds_op:
-				func.t = fpemu_fnmadds;
-				ftype = S2S;
-				break;
-			case fnmsubs_op:
-				func.t = fpemu_fnmsubs;
-				ftype = S2S;
-				break;
-			case fmuls_op:
-				func.t = fmuls;
-				ftype = S2S;
-				break;
-			case fdivs_op:
-				func.t = fdivs;
-				ftype = S2S;
-				break;
-			case fs1_f2op_op:
-				switch (NDS32Insn_OPCODE_BIT1014(insn)) {
-				case fs2d_op:
-					func.b = fs2d;
-					ftype = S1D;
-					break;
-				case fs2si_op:
-					func.b = fs2si;
-					ftype = S1S;
-					break;
-				case fs2si_z_op:
-					func.b = fs2si_z;
-					ftype = S1S;
-					break;
-				case fs2ui_op:
-					func.b = fs2ui;
-					ftype = S1S;
-					break;
-				case fs2ui_z_op:
-					func.b = fs2ui_z;
-					ftype = S1S;
-					break;
-				case fsi2s_op:
-					func.b = fsi2s;
-					ftype = S1S;
-					break;
-				case fui2s_op:
-					func.b = fui2s;
-					ftype = S1S;
-					break;
-				case fsqrts_op:
-					func.b = fsqrts;
-					ftype = S1S;
-					break;
-				default:
-					return SIGILL;
-				}
-				break;
-			default:
-				return SIGILL;
-			}
-			break;
-		}
-	case fs2_op:
-		switch (NDS32Insn_OPCODE_BIT69(insn)) {
-		case fcmpeqs_op:
-		case fcmpeqs_e_op:
-		case fcmplts_op:
-		case fcmplts_e_op:
-		case fcmples_op:
-		case fcmples_e_op:
-		case fcmpuns_op:
-		case fcmpuns_e_op:
-			ftype = CS;
-			break;
-		default:
-			return SIGILL;
-		}
-		break;
-	case fd1_op:{
-			switch (NDS32Insn_OPCODE_BIT69(insn)) {
-			case faddd_op:
-				func.t = faddd;
-				ftype = D2D;
-				break;
-			case fsubd_op:
-				func.t = fsubd;
-				ftype = D2D;
-				break;
-			case fmaddd_op:
-				func.t = fpemu_fmaddd;
-				ftype = D2D;
-				break;
-			case fmsubd_op:
-				func.t = fpemu_fmsubd;
-				ftype = D2D;
-				break;
-			case fnmaddd_op:
-				func.t = fpemu_fnmaddd;
-				ftype = D2D;
-				break;
-			case fnmsubd_op:
-				func.t = fpemu_fnmsubd;
-				ftype = D2D;
-				break;
-			case fmuld_op:
-				func.t = fmuld;
-				ftype = D2D;
-				break;
-			case fdivd_op:
-				func.t = fdivd;
-				ftype = D2D;
-				break;
-			case fd1_f2op_op:
-				switch (NDS32Insn_OPCODE_BIT1014(insn)) {
-				case fd2s_op:
-					func.b = fd2s;
-					ftype = D1S;
-					break;
-				case fd2si_op:
-					func.b = fd2si;
-					ftype = D1S;
-					break;
-				case fd2si_z_op:
-					func.b = fd2si_z;
-					ftype = D1S;
-					break;
-				case fd2ui_op:
-					func.b = fd2ui;
-					ftype = D1S;
-					break;
-				case fd2ui_z_op:
-					func.b = fd2ui_z;
-					ftype = D1S;
-					break;
-				case fsi2d_op:
-					func.b = fsi2d;
-					ftype = D1S;
-					break;
-				case fui2d_op:
-					func.b = fui2d;
-					ftype = D1S;
-					break;
-				case fsqrtd_op:
-					func.b = fsqrtd;
-					ftype = D1D;
-					break;
-				default:
-					return SIGILL;
-				}
-				break;
-			default:
-				return SIGILL;
-
-			}
-			break;
-		}
-
-	case fd2_op:
-		switch (NDS32Insn_OPCODE_BIT69(insn)) {
-		case fcmpeqd_op:
-		case fcmpeqd_e_op:
-		case fcmpltd_op:
-		case fcmpltd_e_op:
-		case fcmpled_op:
-		case fcmpled_e_op:
-		case fcmpund_op:
-		case fcmpund_e_op:
-			ftype = CD;
-			break;
-		default:
-			return SIGILL;
-		}
-		break;
-
-	default:
-		return SIGILL;
-	}
-
-	switch (ftype) {
-	case S1S:{
-			void *ft, *fa;
-
-			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			func.b(ft, fa);
-			break;
-		}
-	case S2S:{
-			void *ft, *fa, *fb;
-
-			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			SPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
-			func.t(ft, fa, fb);
-			break;
-		}
-	case S1D:{
-			void *ft, *fa;
-
-			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			func.b(ft, fa);
-			break;
-		}
-	case CS:{
-			unsigned int cmpop = NDS32Insn_OPCODE_BIT69(insn);
-			void *ft, *fa, *fb;
-
-			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			SPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			SPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
-			if (cmpop < 0x8) {
-				cmpop = cmptab[cmpop];
-				fcmps(ft, fa, fb, cmpop);
-			} else
-				return SIGILL;
-			break;
-		}
-	case D1D:{
-			void *ft, *fa;
-
-			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			func.b(ft, fa);
-			break;
-		}
-	case D2D:{
-			void *ft, *fa, *fb;
-
-			DPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			DPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
-			func.t(ft, fa, fb);
-			break;
-		}
-	case D1S:{
-			void *ft, *fa;
-
-			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			func.b(ft, fa);
-			break;
-		}
-	case CD:{
-			unsigned int cmpop = NDS32Insn_OPCODE_BIT69(insn);
-			void *ft, *fa, *fb;
-
-			SPFROMREG(ft, NDS32Insn_OPCODE_Rt(insn));
-			DPFROMREG(fa, NDS32Insn_OPCODE_Ra(insn));
-			DPFROMREG(fb, NDS32Insn_OPCODE_Rb(insn));
-			if (cmpop < 0x8) {
-				cmpop = cmptab[cmpop];
-				fcmpd(ft, fa, fb, cmpop);
-			} else
-				return SIGILL;
-			break;
-		}
-	default:
-		return SIGILL;
-	}
-
-	/*
-	 * If an exception is required, generate a tidy SIGFPE exception.
-	 */
-#if IS_ENABLED(CONFIG_SUPPORT_DENORMAL_ARITHMETIC)
-	if (((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE_NO_UDF_IEXE)
-	    || ((fpu_reg->fpcsr << 5) & (fpu_reg->UDF_IEX_trap))) {
-#else
-	if ((fpu_reg->fpcsr << 5) & fpu_reg->fpcsr & FPCSR_mskALLE) {
-#endif
-		return SIGFPE;
-	}
-	return 0;
-}
-
-int do_fpuemu(struct pt_regs *regs, struct fpu_struct *fpu)
-{
-	unsigned long insn = 0, addr = regs->ipc;
-	unsigned long emulpc, contpc;
-	unsigned char *pc = (void *)&insn;
-	char c;
-	int i = 0, ret;
-
-	for (i = 0; i < 4; i++) {
-		if (__get_user(c, (unsigned char *)addr++))
-			return SIGBUS;
-		*pc++ = c;
-	}
-
-	insn = be32_to_cpu(insn);
-
-	emulpc = regs->ipc;
-	contpc = regs->ipc + 4;
-
-	if (NDS32Insn_OPCODE(insn) != cop0_op)
-		return SIGILL;
-
-	switch (NDS32Insn_OPCODE_COP0(insn)) {
-	case fs1_op:
-	case fs2_op:
-	case fd1_op:
-	case fd2_op:
-		{
-			/* a real fpu computation instruction */
-			ret = fpu_emu(fpu, insn);
-			if (!ret)
-				regs->ipc = contpc;
-		}
-		break;
-
-	default:
-		return SIGILL;
-	}
-
-	return ret;
-}
diff --git a/arch/nds32/math-emu/fs2d.c b/arch/nds32/math-emu/fs2d.c
deleted file mode 100644
index 0e8db9035631..000000000000
--- a/arch/nds32/math-emu/fs2d.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <linux/uaccess.h>
-#include <asm/sfp-machine.h>
-#include <math-emu/double.h>
-#include <math-emu/single.h>
-#include <math-emu/soft-fp.h>
-
-void fs2d(void *ft, void *fa)
-{
-	FP_DECL_S(A);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	FP_CONV(D, S, 2, 1, R, A);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fs2si.c b/arch/nds32/math-emu/fs2si.c
deleted file mode 100644
index b4931d60980e..000000000000
--- a/arch/nds32/math-emu/fs2si.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fs2si(void *ft, void *fa)
-{
-	int r;
-
-	FP_DECL_S(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_ROUND_S(r, A, 32, 1);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(int *)ft = r;
-	}
-}
diff --git a/arch/nds32/math-emu/fs2siz.c b/arch/nds32/math-emu/fs2siz.c
deleted file mode 100644
index 1c2b99ce3e38..000000000000
--- a/arch/nds32/math-emu/fs2siz.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fs2si_z(void *ft, void *fa)
-{
-	int r;
-
-	FP_DECL_S(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(int *)ft = (A_s == 0) ? 0x7fffffff : 0x80000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_S(r, A, 32, 1);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(int *)ft = r;
-	}
-}
diff --git a/arch/nds32/math-emu/fs2ui.c b/arch/nds32/math-emu/fs2ui.c
deleted file mode 100644
index c337f0384d06..000000000000
--- a/arch/nds32/math-emu/fs2ui.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fs2ui(void *ft, void *fa)
-{
-	unsigned int r;
-
-	FP_DECL_S(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(unsigned int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_ROUND_S(r, A, 32, 0);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(unsigned int *)ft = r;
-	}
-}
diff --git a/arch/nds32/math-emu/fs2uiz.c b/arch/nds32/math-emu/fs2uiz.c
deleted file mode 100644
index 22c5e4768044..000000000000
--- a/arch/nds32/math-emu/fs2uiz.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fs2ui_z(void *ft, void *fa)
-{
-	unsigned int r;
-
-	FP_DECL_S(A);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	if (A_c == FP_CLS_INF) {
-		*(unsigned int *)ft = (A_s == 0) ? 0xffffffff : 0x00000000;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else if (A_c == FP_CLS_NAN) {
-		*(unsigned int *)ft = 0xffffffff;
-		__FPU_FPCSR |= FP_EX_INVALID;
-	} else {
-		FP_TO_INT_S(r, A, 32, 0);
-		__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-		*(unsigned int *)ft = r;
-	}
-
-}
diff --git a/arch/nds32/math-emu/fsi2d.c b/arch/nds32/math-emu/fsi2d.c
deleted file mode 100644
index 6b04cec0c5c5..000000000000
--- a/arch/nds32/math-emu/fsi2d.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fsi2d(void *ft, void *fa)
-{
-	int a = *(int *)fa;
-
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_FROM_INT_D(R, a, 32, int);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/math-emu/fsi2s.c b/arch/nds32/math-emu/fsi2s.c
deleted file mode 100644
index 689864a5df90..000000000000
--- a/arch/nds32/math-emu/fsi2s.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fsi2s(void *ft, void *fa)
-{
-	int a = *(int *)fa;
-
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_FROM_INT_S(R, a, 32, int);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/math-emu/fsqrtd.c b/arch/nds32/math-emu/fsqrtd.c
deleted file mode 100644
index c3a8dbd81d4e..000000000000
--- a/arch/nds32/math-emu/fsqrtd.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <linux/uaccess.h>
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-void fsqrtd(void *ft, void *fa)
-{
-	FP_DECL_D(A);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-
-	FP_SQRT_D(R, A);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fsqrts.c b/arch/nds32/math-emu/fsqrts.c
deleted file mode 100644
index 4c6f94b27328..000000000000
--- a/arch/nds32/math-emu/fsqrts.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-
-#include <linux/uaccess.h>
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fsqrts(void *ft, void *fa)
-{
-	FP_DECL_S(A);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-
-	FP_SQRT_S(R, A);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fsubd.c b/arch/nds32/math-emu/fsubd.c
deleted file mode 100644
index 81b6a0d02a1f..000000000000
--- a/arch/nds32/math-emu/fsubd.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-void fsubd(void *ft, void *fa, void *fb)
-{
-
-	FP_DECL_D(A);
-	FP_DECL_D(B);
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_DP(A, fa);
-	FP_UNPACK_DP(B, fb);
-
-	if (B_c != FP_CLS_NAN)
-		B_s ^= 1;
-
-	FP_ADD_D(R, A, B);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fsubs.c b/arch/nds32/math-emu/fsubs.c
deleted file mode 100644
index 61ddd9708465..000000000000
--- a/arch/nds32/math-emu/fsubs.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2018 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-void fsubs(void *ft, void *fa, void *fb)
-{
-
-	FP_DECL_S(A);
-	FP_DECL_S(B);
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_UNPACK_SP(A, fa);
-	FP_UNPACK_SP(B, fb);
-
-	if (B_c != FP_CLS_NAN)
-		B_s ^= 1;
-
-	FP_ADD_S(R, A, B);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-}
diff --git a/arch/nds32/math-emu/fui2d.c b/arch/nds32/math-emu/fui2d.c
deleted file mode 100644
index 9689d33a8d50..000000000000
--- a/arch/nds32/math-emu/fui2d.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/double.h>
-
-void fui2d(void *ft, void *fa)
-{
-	unsigned int a = *(unsigned int *)fa;
-
-	FP_DECL_D(R);
-	FP_DECL_EX;
-
-	FP_FROM_INT_D(R, a, 32, int);
-
-	FP_PACK_DP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/math-emu/fui2s.c b/arch/nds32/math-emu/fui2s.c
deleted file mode 100644
index f70f0762547d..000000000000
--- a/arch/nds32/math-emu/fui2s.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2019 Andes Technology Corporation
-#include <linux/uaccess.h>
-
-#include <asm/sfp-machine.h>
-#include <math-emu/soft-fp.h>
-#include <math-emu/single.h>
-
-void fui2s(void *ft, void *fa)
-{
-	unsigned int a = *(unsigned int *)fa;
-
-	FP_DECL_S(R);
-	FP_DECL_EX;
-
-	FP_FROM_INT_S(R, a, 32, int);
-
-	FP_PACK_SP(ft, R);
-
-	__FPU_FPCSR |= FP_CUR_EXCEPTIONS;
-
-}
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
deleted file mode 100644
index 14fb2e8eb036..000000000000
--- a/arch/nds32/mm/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y				:= extable.o tlb.o fault.o init.o mmap.o \
-                                   mm-nds32.o cacheflush.o proc.o
-
-obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
-endif
-CFLAGS_proc.o              += -fomit-frame-pointer
diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
deleted file mode 100644
index 1eb7ded6992b..000000000000
--- a/arch/nds32/mm/alignment.c
+++ /dev/null
@@ -1,578 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/proc_fs.h>
-#include <linux/uaccess.h>
-#include <linux/sysctl.h>
-#include <asm/unaligned.h>
-
-#define DEBUG(enable, tagged, ...)				\
-	do{							\
-		if (enable) {					\
-			if (tagged)				\
-			pr_warn("[ %30s() ] ", __func__);	\
-			pr_warn(__VA_ARGS__);			\
-		}						\
-	} while (0)
-
-#define RT(inst)	(((inst) >> 20) & 0x1FUL)
-#define RA(inst)	(((inst) >> 15) & 0x1FUL)
-#define RB(inst)	(((inst) >> 10) & 0x1FUL)
-#define SV(inst)	(((inst) >> 8) & 0x3UL)
-#define IMM(inst)	(((inst) >> 0) & 0x7FFFUL)
-
-#define RA3(inst)	(((inst) >> 3) & 0x7UL)
-#define RT3(inst)	(((inst) >> 6) & 0x7UL)
-#define IMM3U(inst)	(((inst) >> 0) & 0x7UL)
-
-#define RA5(inst)	(((inst) >> 0) & 0x1FUL)
-#define RT4(inst)	(((inst) >> 5) & 0xFUL)
-
-#define GET_IMMSVAL(imm_value) \
-	(((imm_value >> 14) & 0x1) ? (imm_value - 0x8000) : imm_value)
-
-#define __get8_data(val,addr,err)	\
-	__asm__(					\
-	"1:	lbi.bi	%1, [%2], #1\n"			\
-	"2:\n"						\
-	"	.pushsection .text.fixup,\"ax\"\n"	\
-	"	.align	2\n"				\
-	"3:	movi	%0, #1\n"			\
-	"	j	2b\n"				\
-	"	.popsection\n"				\
-	"	.pushsection __ex_table,\"a\"\n"	\
-	"	.align	3\n"				\
-	"	.long	1b, 3b\n"			\
-	"	.popsection\n"				\
-	: "=r" (err), "=&r" (val), "=r" (addr)		\
-	: "0" (err), "2" (addr))
-
-#define get16_data(addr, val_ptr)				\
-	do {							\
-		unsigned int err = 0, v, a = addr;		\
-		__get8_data(v,a,err);				\
-		*val_ptr =  v << 0;				\
-		__get8_data(v,a,err);				\
-		*val_ptr |= v << 8;				\
-		if (err)					\
-			goto fault;				\
-		*val_ptr = le16_to_cpu(*val_ptr);		\
-	} while(0)
-
-#define get32_data(addr, val_ptr)				\
-	do {							\
-		unsigned int err = 0, v, a = addr;		\
-		__get8_data(v,a,err);				\
-		*val_ptr =  v << 0;				\
-		__get8_data(v,a,err);				\
-		*val_ptr |= v << 8;				\
-		__get8_data(v,a,err);				\
-		*val_ptr |= v << 16;				\
-		__get8_data(v,a,err);				\
-		*val_ptr |= v << 24;				\
-		if (err)					\
-			goto fault;				\
-		*val_ptr = le32_to_cpu(*val_ptr);		\
-	} while(0)
-
-#define get_data(addr, val_ptr, len)				\
-	if (len == 2)						\
-		get16_data(addr, val_ptr);			\
-	else							\
-		get32_data(addr, val_ptr);
-
-#define set16_data(addr, val)					\
-	do {							\
-		unsigned int err = 0, *ptr = addr ;		\
-		val = le32_to_cpu(val);				\
-		__asm__(					\
-                "1:	sbi.bi 	%2, [%1], #1\n"			\
-                "	srli 	%2, %2, #8\n"			\
-                "2:	sbi	%2, [%1]\n"			\
-		"3:\n"						\
-		"	.pushsection .text.fixup,\"ax\"\n"	\
-		"	.align	2\n"				\
-		"4:	movi	%0, #1\n"			\
-		"	j	3b\n"				\
-		"	.popsection\n"				\
-		"	.pushsection __ex_table,\"a\"\n"	\
-		"	.align	3\n"				\
-		"	.long	1b, 4b\n"			\
-		"	.long	2b, 4b\n"			\
-		"	.popsection\n"				\
-		: "=r" (err), "+r" (ptr), "+r" (val)		\
-		: "0" (err)					\
-		);						\
-		if (err)					\
-			goto fault;				\
-	} while(0)
-
-#define set32_data(addr, val)					\
-	do {							\
-		unsigned int err = 0, *ptr = addr ;		\
-		val = le32_to_cpu(val);				\
-		__asm__(					\
-                "1:	sbi.bi 	%2, [%1], #1\n"			\
-                "	srli 	%2, %2, #8\n"			\
-                "2:	sbi.bi 	%2, [%1], #1\n"			\
-                "	srli 	%2, %2, #8\n"			\
-                "3:	sbi.bi 	%2, [%1], #1\n"			\
-                "	srli 	%2, %2, #8\n"			\
-                "4:	sbi 	%2, [%1]\n"			\
-		"5:\n"						\
-		"	.pushsection .text.fixup,\"ax\"\n"	\
-		"	.align	2\n"				\
-		"6:	movi	%0, #1\n"			\
-		"	j	5b\n"				\
-		"	.popsection\n"				\
-		"	.pushsection __ex_table,\"a\"\n"	\
-		"	.align	3\n"				\
-		"	.long	1b, 6b\n"			\
-		"	.long	2b, 6b\n"			\
-		"	.long	3b, 6b\n"			\
-		"	.long	4b, 6b\n"			\
-		"	.popsection\n"				\
-		: "=r" (err), "+r" (ptr), "+r" (val)		\
-		: "0" (err)					\
-		);						\
-		if (err)					\
-			goto fault;				\
-	} while(0)
-#define set_data(addr, val, len)				\
-	if (len == 2)						\
-		set16_data(addr, val);				\
-	else							\
-		set32_data(addr, val);
-#define NDS32_16BIT_INSTRUCTION	0x80000000
-
-extern pte_t va_present(struct mm_struct *mm, unsigned long addr);
-extern pte_t va_kernel_present(unsigned long addr);
-extern int va_readable(struct pt_regs *regs, unsigned long addr);
-extern int va_writable(struct pt_regs *regs, unsigned long addr);
-
-int unalign_access_mode = 0, unalign_access_debug = 0;
-
-static inline unsigned long *idx_to_addr(struct pt_regs *regs, int idx)
-{
-	/* this should be consistent with ptrace.h */
-	if (idx >= 0 && idx <= 25)	/* R0-R25 */
-		return &regs->uregs[0] + idx;
-	else if (idx >= 28 && idx <= 30)	/* FP, GP, LP */
-		return &regs->fp + (idx - 28);
-	else if (idx == 31)	/* SP */
-		return &regs->sp;
-	else
-		return NULL;	/* cause a segfault */
-}
-
-static inline unsigned long get_inst(unsigned long addr)
-{
-	return be32_to_cpu(get_unaligned((u32 *) addr));
-}
-
-static inline unsigned long sign_extend(unsigned long val, int len)
-{
-	unsigned long ret = 0;
-	unsigned char *s, *t;
-	int i = 0;
-
-	val = cpu_to_le32(val);
-
-	s = (void *)&val;
-	t = (void *)&ret;
-
-	while (i++ < len)
-		*t++ = *s++;
-
-	if (((*(t - 1)) & 0x80) && (i < 4)) {
-
-		while (i++ <= 4)
-			*t++ = 0xff;
-	}
-
-	return le32_to_cpu(ret);
-}
-
-static inline int do_16(unsigned long inst, struct pt_regs *regs)
-{
-	int imm, regular, load, len, addr_mode, idx_mode;
-	unsigned long unaligned_addr, target_val, source_idx, target_idx,
-	    shift = 0;
-	switch ((inst >> 9) & 0x3F) {
-
-	case 0x12:		/* LHI333    */
-		imm = 1;
-		regular = 1;
-		load = 1;
-		len = 2;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x10:		/* LWI333    */
-		imm = 1;
-		regular = 1;
-		load = 1;
-		len = 4;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x11:		/* LWI333.bi */
-		imm = 1;
-		regular = 0;
-		load = 1;
-		len = 4;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x1A:		/* LWI450    */
-		imm = 0;
-		regular = 1;
-		load = 1;
-		len = 4;
-		addr_mode = 5;
-		idx_mode = 4;
-		break;
-	case 0x16:		/* SHI333    */
-		imm = 1;
-		regular = 1;
-		load = 0;
-		len = 2;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x14:		/* SWI333    */
-		imm = 1;
-		regular = 1;
-		load = 0;
-		len = 4;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x15:		/* SWI333.bi */
-		imm = 1;
-		regular = 0;
-		load = 0;
-		len = 4;
-		addr_mode = 3;
-		idx_mode = 3;
-		break;
-	case 0x1B:		/* SWI450    */
-		imm = 0;
-		regular = 1;
-		load = 0;
-		len = 4;
-		addr_mode = 5;
-		idx_mode = 4;
-		break;
-
-	default:
-		return -EFAULT;
-	}
-
-	if (addr_mode == 3) {
-		unaligned_addr = *idx_to_addr(regs, RA3(inst));
-		source_idx = RA3(inst);
-	} else {
-		unaligned_addr = *idx_to_addr(regs, RA5(inst));
-		source_idx = RA5(inst);
-	}
-
-	if (idx_mode == 3)
-		target_idx = RT3(inst);
-	else
-		target_idx = RT4(inst);
-
-	if (imm)
-		shift = IMM3U(inst) * len;
-
-	if (regular)
-		unaligned_addr += shift;
-
-	if (load) {
-		if (!access_ok((void *)unaligned_addr, len))
-			return -EACCES;
-
-		get_data(unaligned_addr, &target_val, len);
-		*idx_to_addr(regs, target_idx) = target_val;
-	} else {
-		if (!access_ok((void *)unaligned_addr, len))
-			return -EACCES;
-		target_val = *idx_to_addr(regs, target_idx);
-		set_data((void *)unaligned_addr, target_val, len);
-	}
-
-	if (!regular)
-		*idx_to_addr(regs, source_idx) = unaligned_addr + shift;
-	regs->ipc += 2;
-
-	return 0;
-fault:
-	return -EACCES;
-}
-
-static inline int do_32(unsigned long inst, struct pt_regs *regs)
-{
-	int imm, regular, load, len, sign_ext;
-	unsigned long unaligned_addr, target_val, shift;
-
-	unaligned_addr = *idx_to_addr(regs, RA(inst));
-
-	switch ((inst >> 25) << 1) {
-
-	case 0x02:		/* LHI       */
-		imm = 1;
-		regular = 1;
-		load = 1;
-		len = 2;
-		sign_ext = 0;
-		break;
-	case 0x0A:		/* LHI.bi    */
-		imm = 1;
-		regular = 0;
-		load = 1;
-		len = 2;
-		sign_ext = 0;
-		break;
-	case 0x22:		/* LHSI      */
-		imm = 1;
-		regular = 1;
-		load = 1;
-		len = 2;
-		sign_ext = 1;
-		break;
-	case 0x2A:		/* LHSI.bi   */
-		imm = 1;
-		regular = 0;
-		load = 1;
-		len = 2;
-		sign_ext = 1;
-		break;
-	case 0x04:		/* LWI       */
-		imm = 1;
-		regular = 1;
-		load = 1;
-		len = 4;
-		sign_ext = 0;
-		break;
-	case 0x0C:		/* LWI.bi    */
-		imm = 1;
-		regular = 0;
-		load = 1;
-		len = 4;
-		sign_ext = 0;
-		break;
-	case 0x12:		/* SHI       */
-		imm = 1;
-		regular = 1;
-		load = 0;
-		len = 2;
-		sign_ext = 0;
-		break;
-	case 0x1A:		/* SHI.bi    */
-		imm = 1;
-		regular = 0;
-		load = 0;
-		len = 2;
-		sign_ext = 0;
-		break;
-	case 0x14:		/* SWI       */
-		imm = 1;
-		regular = 1;
-		load = 0;
-		len = 4;
-		sign_ext = 0;
-		break;
-	case 0x1C:		/* SWI.bi    */
-		imm = 1;
-		regular = 0;
-		load = 0;
-		len = 4;
-		sign_ext = 0;
-		break;
-
-	default:
-		switch (inst & 0xff) {
-
-		case 0x01:	/* LH        */
-			imm = 0;
-			regular = 1;
-			load = 1;
-			len = 2;
-			sign_ext = 0;
-			break;
-		case 0x05:	/* LH.bi     */
-			imm = 0;
-			regular = 0;
-			load = 1;
-			len = 2;
-			sign_ext = 0;
-			break;
-		case 0x11:	/* LHS       */
-			imm = 0;
-			regular = 1;
-			load = 1;
-			len = 2;
-			sign_ext = 1;
-			break;
-		case 0x15:	/* LHS.bi    */
-			imm = 0;
-			regular = 0;
-			load = 1;
-			len = 2;
-			sign_ext = 1;
-			break;
-		case 0x02:	/* LW        */
-			imm = 0;
-			regular = 1;
-			load = 1;
-			len = 4;
-			sign_ext = 0;
-			break;
-		case 0x06:	/* LW.bi     */
-			imm = 0;
-			regular = 0;
-			load = 1;
-			len = 4;
-			sign_ext = 0;
-			break;
-		case 0x09:	/* SH        */
-			imm = 0;
-			regular = 1;
-			load = 0;
-			len = 2;
-			sign_ext = 0;
-			break;
-		case 0x0D:	/* SH.bi     */
-			imm = 0;
-			regular = 0;
-			load = 0;
-			len = 2;
-			sign_ext = 0;
-			break;
-		case 0x0A:	/* SW        */
-			imm = 0;
-			regular = 1;
-			load = 0;
-			len = 4;
-			sign_ext = 0;
-			break;
-		case 0x0E:	/* SW.bi     */
-			imm = 0;
-			regular = 0;
-			load = 0;
-			len = 4;
-			sign_ext = 0;
-			break;
-
-		default:
-			return -EFAULT;
-		}
-	}
-
-	if (imm)
-		shift = GET_IMMSVAL(IMM(inst)) * len;
-	else
-		shift = *idx_to_addr(regs, RB(inst)) << SV(inst);
-
-	if (regular)
-		unaligned_addr += shift;
-
-	if (load) {
-
-		if (!access_ok((void *)unaligned_addr, len))
-			return -EACCES;
-
-		get_data(unaligned_addr, &target_val, len);
-
-		if (sign_ext)
-			*idx_to_addr(regs, RT(inst)) =
-			    sign_extend(target_val, len);
-		else
-			*idx_to_addr(regs, RT(inst)) = target_val;
-	} else {
-
-		if (!access_ok((void *)unaligned_addr, len))
-			return -EACCES;
-
-		target_val = *idx_to_addr(regs, RT(inst));
-		set_data((void *)unaligned_addr, target_val, len);
-	}
-
-	if (!regular)
-		*idx_to_addr(regs, RA(inst)) = unaligned_addr + shift;
-
-	regs->ipc += 4;
-
-	return 0;
-fault:
-	return -EACCES;
-}
-
-int do_unaligned_access(unsigned long addr, struct pt_regs *regs)
-{
-	unsigned long inst;
-	int ret = -EFAULT;
-	mm_segment_t seg;
-
-	inst = get_inst(regs->ipc);
-
-	DEBUG((unalign_access_debug > 0), 1,
-	      "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", addr,
-	      regs->ipc, inst);
-
-	seg = force_uaccess_begin();
-	if (inst & NDS32_16BIT_INSTRUCTION)
-		ret = do_16((inst >> 16) & 0xffff, regs);
-	else
-		ret = do_32(inst, regs);
-	force_uaccess_end(seg);
-
-	return ret;
-}
-
-#ifdef CONFIG_PROC_FS
-
-static struct ctl_table alignment_tbl[3] = {
-	{
-	 .procname = "enable",
-	 .data = &unalign_access_mode,
-	 .maxlen = sizeof(unalign_access_mode),
-	 .mode = 0666,
-	 .proc_handler = &proc_dointvec
-	}
-	,
-	{
-	 .procname = "debug_info",
-	 .data = &unalign_access_debug,
-	 .maxlen = sizeof(unalign_access_debug),
-	 .mode = 0644,
-	 .proc_handler = &proc_dointvec
-	}
-	,
-	{}
-};
-
-static struct ctl_table nds32_sysctl_table[2] = {
-	{
-	 .procname = "unaligned_access",
-	 .mode = 0555,
-	 .child = alignment_tbl},
-	{}
-};
-
-static struct ctl_path nds32_path[2] = {
-	{.procname = "nds32"},
-	{}
-};
-
-/*
- * Initialize nds32 alignment-correction interface
- */
-static int __init nds32_sysctl_init(void)
-{
-	register_sysctl_paths(nds32_path, nds32_sysctl_table);
-	return 0;
-}
-
-__initcall(nds32_sysctl_init);
-#endif /* CONFIG_PROC_FS */
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
deleted file mode 100644
index 07aac65d1cab..000000000000
--- a/arch/nds32/mm/cacheflush.c
+++ /dev/null
@@ -1,338 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/pagemap.h>
-#include <linux/module.h>
-#include <asm/cacheflush.h>
-#include <asm/proc-fns.h>
-#include <asm/shmparam.h>
-#include <asm/cache_info.h>
-
-extern struct cache_info L1_cache_info[2];
-
-void flush_icache_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size, flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & ~(line_size - 1);
-	end = (end + line_size - 1) & ~(line_size - 1);
-	local_irq_save(flags);
-	cpu_cache_wbinval_range(start, end, 1);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(flush_icache_range);
-
-void flush_icache_page(struct vm_area_struct *vma, struct page *page)
-{
-	unsigned long flags;
-	unsigned long kaddr;
-	local_irq_save(flags);
-	kaddr = (unsigned long)kmap_atomic(page);
-	cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
-	kunmap_atomic((void *)kaddr);
-	local_irq_restore(flags);
-}
-
-void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
-	                     unsigned long addr, int len)
-{
-	unsigned long kaddr;
-	kaddr = (unsigned long)kmap_atomic(page) + (addr & ~PAGE_MASK);
-	flush_icache_range(kaddr, kaddr + len);
-	kunmap_atomic((void *)kaddr);
-}
-
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-		      pte_t * pte)
-{
-	struct page *page;
-	unsigned long pfn = pte_pfn(*pte);
-	unsigned long flags;
-
-	if (!pfn_valid(pfn))
-		return;
-
-	if (vma->vm_mm == current->active_mm) {
-		local_irq_save(flags);
-		__nds32__mtsr_dsb(addr, NDS32_SR_TLB_VPN);
-		__nds32__tlbop_rwr(*pte);
-		__nds32__isb();
-		local_irq_restore(flags);
-	}
-	page = pfn_to_page(pfn);
-
-	if ((test_and_clear_bit(PG_dcache_dirty, &page->flags)) ||
-	    (vma->vm_flags & VM_EXEC)) {
-		unsigned long kaddr;
-		local_irq_save(flags);
-		kaddr = (unsigned long)kmap_atomic(page);
-		cpu_cache_wbinval_page(kaddr, vma->vm_flags & VM_EXEC);
-		kunmap_atomic((void *)kaddr);
-		local_irq_restore(flags);
-	}
-}
-#ifdef CONFIG_CPU_CACHE_ALIASING
-extern pte_t va_present(struct mm_struct *mm, unsigned long addr);
-
-static inline unsigned long aliasing(unsigned long addr, unsigned long page)
-{
-	return ((addr & PAGE_MASK) ^ page) & (SHMLBA - 1);
-}
-
-static inline unsigned long kremap0(unsigned long uaddr, unsigned long pa)
-{
-	unsigned long kaddr, pte;
-
-#define BASE_ADDR0 0xffffc000
-	kaddr = BASE_ADDR0 | (uaddr & L1_cache_info[DCACHE].aliasing_mask);
-	pte = (pa | PAGE_KERNEL);
-	__nds32__mtsr_dsb(kaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwlk(pte);
-	__nds32__isb();
-	return kaddr;
-}
-
-static inline void kunmap01(unsigned long kaddr)
-{
-	__nds32__tlbop_unlk(kaddr);
-	__nds32__tlbop_inv(kaddr);
-	__nds32__isb();
-}
-
-static inline unsigned long kremap1(unsigned long uaddr, unsigned long pa)
-{
-	unsigned long kaddr, pte;
-
-#define BASE_ADDR1 0xffff8000
-	kaddr = BASE_ADDR1 | (uaddr & L1_cache_info[DCACHE].aliasing_mask);
-	pte = (pa | PAGE_KERNEL);
-	__nds32__mtsr_dsb(kaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwlk(pte);
-	__nds32__isb();
-	return kaddr;
-}
-
-void flush_cache_mm(struct mm_struct *mm)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cpu_dcache_wbinval_all();
-	cpu_icache_inval_all();
-	local_irq_restore(flags);
-}
-
-void flush_cache_dup_mm(struct mm_struct *mm)
-{
-}
-
-void flush_cache_range(struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end)
-{
-	unsigned long flags;
-
-	if ((end - start) > 8 * PAGE_SIZE) {
-		cpu_dcache_wbinval_all();
-		if (vma->vm_flags & VM_EXEC)
-			cpu_icache_inval_all();
-		return;
-	}
-	local_irq_save(flags);
-	while (start < end) {
-		if (va_present(vma->vm_mm, start))
-			cpu_cache_wbinval_page(start, vma->vm_flags & VM_EXEC);
-		start += PAGE_SIZE;
-	}
-	local_irq_restore(flags);
-	return;
-}
-
-void flush_cache_page(struct vm_area_struct *vma,
-		      unsigned long addr, unsigned long pfn)
-{
-	unsigned long vto, flags;
-
-	local_irq_save(flags);
-	vto = kremap0(addr, pfn << PAGE_SHIFT);
-	cpu_cache_wbinval_page(vto, vma->vm_flags & VM_EXEC);
-	kunmap01(vto);
-	local_irq_restore(flags);
-}
-
-void flush_cache_vmap(unsigned long start, unsigned long end)
-{
-	cpu_dcache_wbinval_all();
-	cpu_icache_inval_all();
-}
-
-void flush_cache_vunmap(unsigned long start, unsigned long end)
-{
-	cpu_dcache_wbinval_all();
-	cpu_icache_inval_all();
-}
-
-void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-		    struct page *to)
-{
-	cpu_dcache_wbinval_page((unsigned long)vaddr);
-	cpu_icache_inval_page((unsigned long)vaddr);
-	copy_page(vto, vfrom);
-	cpu_dcache_wbinval_page((unsigned long)vto);
-	cpu_icache_inval_page((unsigned long)vto);
-}
-
-void clear_user_page(void *addr, unsigned long vaddr, struct page *page)
-{
-	cpu_dcache_wbinval_page((unsigned long)vaddr);
-	cpu_icache_inval_page((unsigned long)vaddr);
-	clear_page(addr);
-	cpu_dcache_wbinval_page((unsigned long)addr);
-	cpu_icache_inval_page((unsigned long)addr);
-}
-
-void copy_user_highpage(struct page *to, struct page *from,
-			unsigned long vaddr, struct vm_area_struct *vma)
-{
-	unsigned long vto, vfrom, flags, kto, kfrom, pfrom, pto;
-	kto = ((unsigned long)page_address(to) & PAGE_MASK);
-	kfrom = ((unsigned long)page_address(from) & PAGE_MASK);
-	pto = page_to_phys(to);
-	pfrom = page_to_phys(from);
-
-	local_irq_save(flags);
-	if (aliasing(vaddr, (unsigned long)kfrom))
-		cpu_dcache_wb_page((unsigned long)kfrom);
-	vto = kremap0(vaddr, pto);
-	vfrom = kremap1(vaddr, pfrom);
-	copy_page((void *)vto, (void *)vfrom);
-	kunmap01(vfrom);
-	kunmap01(vto);
-	local_irq_restore(flags);
-}
-
-EXPORT_SYMBOL(copy_user_highpage);
-
-void clear_user_highpage(struct page *page, unsigned long vaddr)
-{
-	unsigned long vto, flags, kto;
-
-	kto = ((unsigned long)page_address(page) & PAGE_MASK);
-
-	local_irq_save(flags);
-	if (aliasing(kto, vaddr) && kto != 0) {
-		cpu_dcache_inval_page(kto);
-		cpu_icache_inval_page(kto);
-	}
-	vto = kremap0(vaddr, page_to_phys(page));
-	clear_page((void *)vto);
-	kunmap01(vto);
-	local_irq_restore(flags);
-}
-
-EXPORT_SYMBOL(clear_user_highpage);
-
-void flush_dcache_page(struct page *page)
-{
-	struct address_space *mapping;
-
-	mapping = page_mapping_file(page);
-	if (mapping && !mapping_mapped(mapping))
-		set_bit(PG_dcache_dirty, &page->flags);
-	else {
-		unsigned long kaddr, flags;
-
-		kaddr = (unsigned long)page_address(page);
-		local_irq_save(flags);
-		cpu_dcache_wbinval_page(kaddr);
-		if (mapping) {
-			unsigned long vaddr, kto;
-
-			vaddr = page->index << PAGE_SHIFT;
-			if (aliasing(vaddr, kaddr)) {
-				kto = kremap0(vaddr, page_to_phys(page));
-				cpu_dcache_wbinval_page(kto);
-				kunmap01(kto);
-			}
-		}
-		local_irq_restore(flags);
-	}
-}
-EXPORT_SYMBOL(flush_dcache_page);
-
-void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
-		       unsigned long vaddr, void *dst, void *src, int len)
-{
-	unsigned long line_size, start, end, vto, flags;
-
-	local_irq_save(flags);
-	vto = kremap0(vaddr, page_to_phys(page));
-	dst = (void *)(vto | (vaddr & (PAGE_SIZE - 1)));
-	memcpy(dst, src, len);
-	if (vma->vm_flags & VM_EXEC) {
-		line_size = L1_cache_info[DCACHE].line_size;
-		start = (unsigned long)dst & ~(line_size - 1);
-		end =
-		    ((unsigned long)dst + len + line_size - 1) & ~(line_size -
-								   1);
-		cpu_cache_wbinval_range(start, end, 1);
-	}
-	kunmap01(vto);
-	local_irq_restore(flags);
-}
-
-void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
-			 unsigned long vaddr, void *dst, void *src, int len)
-{
-	unsigned long vto, flags;
-
-	local_irq_save(flags);
-	vto = kremap0(vaddr, page_to_phys(page));
-	src = (void *)(vto | (vaddr & (PAGE_SIZE - 1)));
-	memcpy(dst, src, len);
-	kunmap01(vto);
-	local_irq_restore(flags);
-}
-
-void flush_anon_page(struct vm_area_struct *vma,
-		     struct page *page, unsigned long vaddr)
-{
-	unsigned long kaddr, flags, ktmp;
-	if (!PageAnon(page))
-		return;
-
-	if (vma->vm_mm != current->active_mm)
-		return;
-
-	local_irq_save(flags);
-	if (vma->vm_flags & VM_EXEC)
-		cpu_icache_inval_page(vaddr & PAGE_MASK);
-	kaddr = (unsigned long)page_address(page);
-	if (aliasing(vaddr, kaddr)) {
-		ktmp = kremap0(vaddr, page_to_phys(page));
-		cpu_dcache_wbinval_page(ktmp);
-		kunmap01(ktmp);
-	}
-	local_irq_restore(flags);
-}
-
-void flush_kernel_vmap_range(void *addr, int size)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	cpu_dcache_wb_range((unsigned long)addr, (unsigned long)addr +  size);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(flush_kernel_vmap_range);
-
-void invalidate_kernel_vmap_range(void *addr, int size)
-{
-	unsigned long flags;
-	local_irq_save(flags);
-	cpu_dcache_inval_range((unsigned long)addr, (unsigned long)addr + size);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(invalidate_kernel_vmap_range);
-#endif
diff --git a/arch/nds32/mm/extable.c b/arch/nds32/mm/extable.c
deleted file mode 100644
index db7f0a7c8966..000000000000
--- a/arch/nds32/mm/extable.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/extable.h>
-#include <linux/uaccess.h>
-
-int fixup_exception(struct pt_regs *regs)
-{
-	const struct exception_table_entry *fixup;
-
-	fixup = search_exception_tables(instruction_pointer(regs));
-	if (fixup)
-		regs->ipc = fixup->fixup;
-
-	return fixup != NULL;
-}
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
deleted file mode 100644
index 636977a1c8b9..000000000000
--- a/arch/nds32/mm/fault.c
+++ /dev/null
@@ -1,396 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/extable.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/ptrace.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/hardirq.h>
-#include <linux/uaccess.h>
-#include <linux/perf_event.h>
-
-#include <asm/tlbflush.h>
-
-extern void __noreturn die(const char *str, struct pt_regs *regs, long err);
-
-/*
- * This is useful to dump out the page tables associated with
- * 'addr' in mm 'mm'.
- */
-void show_pte(struct mm_struct *mm, unsigned long addr)
-{
-	pgd_t *pgd;
-	if (!mm)
-		mm = &init_mm;
-
-	pr_alert("pgd = %p\n", mm->pgd);
-	pgd = pgd_offset(mm, addr);
-	pr_alert("[%08lx] *pgd=%08lx", addr, pgd_val(*pgd));
-
-	do {
-		p4d_t *p4d;
-		pud_t *pud;
-		pmd_t *pmd;
-
-		if (pgd_none(*pgd))
-			break;
-
-		if (pgd_bad(*pgd)) {
-			pr_alert("(bad)");
-			break;
-		}
-
-		p4d = p4d_offset(pgd, addr);
-		pud = pud_offset(p4d, addr);
-		pmd = pmd_offset(pud, addr);
-#if PTRS_PER_PMD != 1
-		pr_alert(", *pmd=%08lx", pmd_val(*pmd));
-#endif
-
-		if (pmd_none(*pmd))
-			break;
-
-		if (pmd_bad(*pmd)) {
-			pr_alert("(bad)");
-			break;
-		}
-
-		if (IS_ENABLED(CONFIG_HIGHMEM))
-		{
-			pte_t *pte;
-			/* We must not map this if we have highmem enabled */
-			pte = pte_offset_map(pmd, addr);
-			pr_alert(", *pte=%08lx", pte_val(*pte));
-			pte_unmap(pte);
-		}
-	} while (0);
-
-	pr_alert("\n");
-}
-
-void do_page_fault(unsigned long entry, unsigned long addr,
-		   unsigned int error_code, struct pt_regs *regs)
-{
-	struct task_struct *tsk;
-	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	int si_code;
-	vm_fault_t fault;
-	unsigned int mask = VM_ACCESS_FLAGS;
-	unsigned int flags = FAULT_FLAG_DEFAULT;
-
-	error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
-	tsk = current;
-	mm = tsk->mm;
-	si_code = SEGV_MAPERR;
-	/*
-	 * We fault-in kernel-space virtual memory on-demand. The
-	 * 'reference' page table is init_mm.pgd.
-	 *
-	 * NOTE! We MUST NOT take any locks for this case. We may
-	 * be in an interrupt or a critical region, and should
-	 * only copy the information from the master page table,
-	 * nothing more.
-	 */
-	if (addr >= TASK_SIZE) {
-		if (user_mode(regs))
-			goto bad_area_nosemaphore;
-
-		if (addr >= TASK_SIZE && addr < VMALLOC_END
-		    && (entry == ENTRY_PTE_NOT_PRESENT))
-			goto vmalloc_fault;
-		else
-			goto no_context;
-	}
-
-	/* Send a signal to the task for handling the unalignment access. */
-	if (entry == ENTRY_GENERAL_EXCPETION
-	    && error_code == ETYPE_ALIGNMENT_CHECK) {
-		if (user_mode(regs))
-			goto bad_area_nosemaphore;
-		else
-			goto no_context;
-	}
-
-	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
-	 */
-	if (unlikely(faulthandler_disabled() || !mm))
-		goto no_context;
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
-
-	/*
-	 * As per x86, we may deadlock here. However, since the kernel only
-	 * validly references user space from well defined areas of the code,
-	 * we can bug out early if this is from code which shouldn't.
-	 */
-	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!user_mode(regs) &&
-		    !search_exception_tables(instruction_pointer(regs)))
-			goto no_context;
-retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in which
-		 * case, we'll have missed the might_sleep() from down_read().
-		 */
-		might_sleep();
-		if (IS_ENABLED(CONFIG_DEBUG_VM)) {
-			if (!user_mode(regs) &&
-			    !search_exception_tables(instruction_pointer(regs)))
-				goto no_context;
-		}
-	}
-
-	vma = find_vma(mm, addr);
-
-	if (unlikely(!vma))
-		goto bad_area;
-
-	if (vma->vm_start <= addr)
-		goto good_area;
-
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-		goto bad_area;
-
-	if (unlikely(expand_stack(vma, addr)))
-		goto bad_area;
-
-	/*
-	 * Ok, we have a good vm_area for this memory access, so
-	 * we can handle it..
-	 */
-
-good_area:
-	si_code = SEGV_ACCERR;
-
-	/* first do some preliminary protection checks */
-	if (entry == ENTRY_PTE_NOT_PRESENT) {
-		if (error_code & ITYPE_mskINST)
-			mask = VM_EXEC;
-		else {
-			mask = VM_READ | VM_WRITE;
-		}
-	} else if (entry == ENTRY_TLB_MISC) {
-		switch (error_code & ITYPE_mskETYPE) {
-		case RD_PROT:
-			mask = VM_READ;
-			break;
-		case WRT_PROT:
-			mask = VM_WRITE;
-			flags |= FAULT_FLAG_WRITE;
-			break;
-		case NOEXEC:
-			mask = VM_EXEC;
-			break;
-		case PAGE_MODIFY:
-			mask = VM_WRITE;
-			flags |= FAULT_FLAG_WRITE;
-			break;
-		case ACC_BIT:
-			BUG();
-		default:
-			break;
-		}
-
-	}
-	if (!(vma->vm_flags & mask))
-		goto bad_area;
-
-	/*
-	 * If for any reason at all we couldn't handle the fault,
-	 * make sure we exit gracefully rather than endlessly redo
-	 * the fault.
-	 */
-
-	fault = handle_mm_fault(vma, addr, flags, regs);
-
-	/*
-	 * If we need to retry but a fatal signal is pending, handle the
-	 * signal first. We do not need to release the mmap_lock because it
-	 * would already be released in __lock_page_or_retry in mm/filemap.c.
-	 */
-	if (fault_signal_pending(fault, regs)) {
-		if (!user_mode(regs))
-			goto no_context;
-		return;
-	}
-
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		if (fault & VM_FAULT_OOM)
-			goto out_of_memory;
-		else if (fault & VM_FAULT_SIGBUS)
-			goto do_sigbus;
-		else
-			goto bad_area;
-	}
-
-	if (fault & VM_FAULT_RETRY) {
-		flags |= FAULT_FLAG_TRIED;
-
-		/* No need to mmap_read_unlock(mm) as we would
-		 * have already released it in __lock_page_or_retry
-		 * in mm/filemap.c.
-		 */
-		goto retry;
-	}
-
-	mmap_read_unlock(mm);
-	return;
-
-	/*
-	 * Something tried to access memory that isn't in our memory map..
-	 * Fix it, but check if it's kernel or user first..
-	 */
-bad_area:
-	mmap_read_unlock(mm);
-
-bad_area_nosemaphore:
-
-	/* User mode accesses just cause a SIGSEGV */
-
-	if (user_mode(regs)) {
-		tsk->thread.address = addr;
-		tsk->thread.error_code = error_code;
-		tsk->thread.trap_no = entry;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)addr);
-		return;
-	}
-
-no_context:
-
-	/* Are we prepared to handle this kernel fault?
-	 *
-	 * (The kernel has valid exception-points in the source
-	 *  when it acesses user-memory. When it fails in one
-	 *  of those points, we find it in a table and do a jump
-	 *  to some fixup code that loads an appropriate error
-	 *  code)
-	 */
-
-	{
-		const struct exception_table_entry *entry;
-
-		if ((entry =
-		     search_exception_tables(instruction_pointer(regs))) !=
-		    NULL) {
-			/* Adjust the instruction pointer in the stackframe */
-			instruction_pointer(regs) = entry->fixup;
-			return;
-		}
-	}
-
-	/*
-	 * Oops. The kernel tried to access some bad page. We'll have to
-	 * terminate things with extreme prejudice.
-	 */
-
-	bust_spinlocks(1);
-	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
-		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
-		 "paging request", addr);
-
-	show_pte(mm, addr);
-	die("Oops", regs, error_code);
-
-	/*
-	 * We ran out of memory, or some other thing happened to us that made
-	 * us unable to handle the page fault gracefully.
-	 */
-
-out_of_memory:
-	mmap_read_unlock(mm);
-	if (!user_mode(regs))
-		goto no_context;
-	pagefault_out_of_memory();
-	return;
-
-do_sigbus:
-	mmap_read_unlock(mm);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!user_mode(regs))
-		goto no_context;
-
-	/*
-	 * Send a sigbus
-	 */
-	tsk->thread.address = addr;
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_no = entry;
-	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr);
-
-	return;
-
-vmalloc_fault:
-	{
-		/*
-		 * Synchronize this task's top level page-table
-		 * with the 'reference' page table.
-		 *
-		 * Use current_pgd instead of tsk->active_mm->pgd
-		 * since the latter might be unavailable if this
-		 * code is executed in a misfortunately run irq
-		 * (like inside schedule() between switch_mm and
-		 *  switch_to...).
-		 */
-
-		unsigned int index = pgd_index(addr);
-		pgd_t *pgd, *pgd_k;
-		p4d_t *p4d, *p4d_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
-
-		pgd = (pgd_t *) __va(__nds32__mfsr(NDS32_SR_L1_PPTB)) + index;
-		pgd_k = init_mm.pgd + index;
-
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-
-		p4d = p4d_offset(pgd, addr);
-		p4d_k = p4d_offset(pgd_k, addr);
-		if (!p4d_present(*p4d_k))
-			goto no_context;
-
-		pud = pud_offset(p4d, addr);
-		pud_k = pud_offset(p4d_k, addr);
-		if (!pud_present(*pud_k))
-			goto no_context;
-
-		pmd = pmd_offset(pud, addr);
-		pmd_k = pmd_offset(pud_k, addr);
-		if (!pmd_present(*pmd_k))
-			goto no_context;
-
-		if (!pmd_present(*pmd))
-			set_pmd(pmd, *pmd_k);
-		else
-			BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
-
-		/*
-		 * Since the vmalloc area is global, we don't
-		 * need to copy individual PTE's, it is enough to
-		 * copy the pgd pointer into the pte page of the
-		 * root task. If that is there, we'll find our pte if
-		 * it exists.
-		 */
-
-		/* Make sure the actual PTE exists as well to
-		 * catch kernel vmalloc-area accesses to non-mapped
-		 * addres. If we don't do this, this will just
-		 * silently loop forever.
-		 */
-
-		pte_k = pte_offset_kernel(pmd_k, addr);
-		if (!pte_present(*pte_k))
-			goto no_context;
-
-		return;
-	}
-}
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
deleted file mode 100644
index f63f839738c4..000000000000
--- a/arch/nds32/mm/init.c
+++ /dev/null
@@ -1,263 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 1995-2005 Russell King
-// Copyright (C) 2012 ARM Ltd.
-// Copyright (C) 2013-2017 Andes Technology Corporation
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/swap.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/mman.h>
-#include <linux/nodemask.h>
-#include <linux/initrd.h>
-#include <linux/highmem.h>
-
-#include <asm/sections.h>
-#include <asm/setup.h>
-#include <asm/tlb.h>
-#include <asm/page.h>
-
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-DEFINE_SPINLOCK(anon_alias_lock);
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-
-/*
- * empty_zero_page is a special page that is used for
- * zero-initialized data and COW.
- */
-struct page *empty_zero_page;
-EXPORT_SYMBOL(empty_zero_page);
-
-static void __init zone_sizes_init(void)
-{
-	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
-
-	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
-#ifdef CONFIG_HIGHMEM
-	max_zone_pfn[ZONE_HIGHMEM] = max_pfn;
-#endif
-	free_area_init(max_zone_pfn);
-
-}
-
-/*
- * Map all physical memory under high_memory into kernel's address space.
- *
- * This is explicitly coded for two-level page tables, so if you need
- * something else then this needs to change.
- */
-static void __init map_ram(void)
-{
-	unsigned long v, p, e;
-	pgd_t *pge;
-	p4d_t *p4e;
-	pud_t *pue;
-	pmd_t *pme;
-	pte_t *pte;
-	/* These mark extents of read-only kernel pages...
-	 * ...from vmlinux.lds.S
-	 */
-
-	p = (u32) memblock_start_of_DRAM() & PAGE_MASK;
-	e = min((u32) memblock_end_of_DRAM(), (u32) __pa(high_memory));
-
-	v = (u32) __va(p);
-	pge = pgd_offset_k(v);
-
-	while (p < e) {
-		int j;
-		p4e = p4d_offset(pge, v);
-		pue = pud_offset(p4e, v);
-		pme = pmd_offset(pue, v);
-
-		if ((u32) pue != (u32) pge || (u32) pme != (u32) pge) {
-			panic("%s: Kernel hardcoded for "
-			      "two-level page tables", __func__);
-		}
-
-		/* Alloc one page for holding PTE's... */
-		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		if (!pte)
-			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-			      __func__, PAGE_SIZE, PAGE_SIZE);
-		set_pmd(pme, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
-
-		/* Fill the newly allocated page with PTE'S */
-		for (j = 0; p < e && j < PTRS_PER_PTE;
-		     v += PAGE_SIZE, p += PAGE_SIZE, j++, pte++) {
-			/* Create mapping between p and v. */
-			/* TODO: more fine grant for page access permission */
-			set_pte(pte, __pte(p + pgprot_val(PAGE_KERNEL)));
-		}
-
-		pge++;
-	}
-}
-static pmd_t *fixmap_pmd_p;
-static void __init fixedrange_init(void)
-{
-	unsigned long vaddr;
-	pmd_t *pmd;
-#ifdef CONFIG_HIGHMEM
-	pte_t *pte;
-#endif /* CONFIG_HIGHMEM */
-
-	/*
-	 * Fixed mappings:
-	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
-	pmd = pmd_off_k(vaddr);
-	fixmap_pmd_p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	if (!fixmap_pmd_p)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(fixmap_pmd_p) + _PAGE_KERNEL_TABLE));
-
-#ifdef CONFIG_HIGHMEM
-	/*
-	 * Permanent kmaps:
-	 */
-	vaddr = PKMAP_BASE;
-
-	pmd = pmd_off_k(vaddr);
-	pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	if (!pte)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
-	pkmap_page_table = pte;
-#endif /* CONFIG_HIGHMEM */
-}
-
-/*
- * paging_init() sets up the page tables, initialises the zone memory
- * maps, and sets up the zero page, bad page and bad page tables.
- */
-void __init paging_init(void)
-{
-	int i;
-	void *zero_page;
-
-	pr_info("Setting up paging and PTEs.\n");
-	/* clear out the init_mm.pgd that will contain the kernel's mappings */
-	for (i = 0; i < PTRS_PER_PGD; i++)
-		swapper_pg_dir[i] = __pgd(1);
-
-	map_ram();
-
-	fixedrange_init();
-
-	/* allocate space for empty_zero_page */
-	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	if (!zero_page)
-		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
-		      __func__, PAGE_SIZE, PAGE_SIZE);
-	zone_sizes_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	flush_dcache_page(empty_zero_page);
-}
-
-static inline void __init free_highmem(void)
-{
-#ifdef CONFIG_HIGHMEM
-	unsigned long pfn;
-	for (pfn = PFN_UP(__pa(high_memory)); pfn < max_pfn; pfn++) {
-		phys_addr_t paddr = (phys_addr_t) pfn << PAGE_SHIFT;
-		if (!memblock_is_reserved(paddr))
-			free_highmem_page(pfn_to_page(pfn));
-	}
-#endif
-}
-
-static void __init set_max_mapnr_init(void)
-{
-	max_mapnr = max_pfn;
-}
-
-/*
- * mem_init() marks the free areas in the mem_map and tells us how much
- * memory is free.  This is done after various parts of the system have
- * claimed their memory after the kernel image.
- */
-void __init mem_init(void)
-{
-	phys_addr_t memory_start = memblock_start_of_DRAM();
-	BUG_ON(!mem_map);
-	set_max_mapnr_init();
-
-	free_highmem();
-
-	/* this will put all low memory onto the freelists */
-	memblock_free_all();
-
-	pr_info("virtual kernel memory layout:\n"
-		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-		"    consist : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
-		FIXADDR_START, FIXADDR_TOP, (FIXADDR_TOP - FIXADDR_START) >> 10,
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
-		(LAST_PKMAP * PAGE_SIZE) >> 10,
-#endif
-		CONSISTENT_BASE, CONSISTENT_END,
-		((CONSISTENT_END) - (CONSISTENT_BASE)) >> 20, VMALLOC_START,
-		(unsigned long)VMALLOC_END, (VMALLOC_END - VMALLOC_START) >> 20,
-		(unsigned long)__va(memory_start), (unsigned long)high_memory,
-		((unsigned long)high_memory -
-		 (unsigned long)__va(memory_start)) >> 20,
-		(unsigned long)&__init_begin, (unsigned long)&__init_end,
-		((unsigned long)&__init_end -
-		 (unsigned long)&__init_begin) >> 10, (unsigned long)&_etext,
-		(unsigned long)&_edata,
-		((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
-		(unsigned long)&_text, (unsigned long)&_etext,
-		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
-
-	/*
-	 * Check boundaries twice: Some fundamental inconsistencies can
-	 * be detected at build time already.
-	 */
-#ifdef CONFIG_HIGHMEM
-	BUILD_BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > FIXADDR_START);
-	BUILD_BUG_ON((CONSISTENT_END) > PKMAP_BASE);
-#endif
-	BUILD_BUG_ON(VMALLOC_END > CONSISTENT_BASE);
-	BUILD_BUG_ON(VMALLOC_START >= VMALLOC_END);
-
-#ifdef CONFIG_HIGHMEM
-	BUG_ON(PKMAP_BASE + LAST_PKMAP * PAGE_SIZE > FIXADDR_START);
-	BUG_ON(CONSISTENT_END > PKMAP_BASE);
-#endif
-	BUG_ON(VMALLOC_END > CONSISTENT_BASE);
-	BUG_ON(VMALLOC_START >= VMALLOC_END);
-	BUG_ON((unsigned long)high_memory > VMALLOC_START);
-
-	return;
-}
-
-void __set_fixmap(enum fixed_addresses idx,
-			       phys_addr_t phys, pgprot_t flags)
-{
-	unsigned long addr = __fix_to_virt(idx);
-	pte_t *pte;
-
-	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
-
-	pte = (pte_t *)&fixmap_pmd_p[pte_index(addr)];
-
-	if (pgprot_val(flags)) {
-		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
-	} else {
-		pte_clear(&init_mm, addr, pte);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-	}
-}
diff --git a/arch/nds32/mm/mm-nds32.c b/arch/nds32/mm/mm-nds32.c
deleted file mode 100644
index f2778f2b39f6..000000000000
--- a/arch/nds32/mm/mm-nds32.c
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/init_task.h>
-
-#define __HAVE_ARCH_PGD_FREE
-#include <asm/pgalloc.h>
-
-#define FIRST_KERNEL_PGD_NR	(USER_PTRS_PER_PGD)
-
-/*
- * need to get a page for level 1
- */
-
-pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	pgd_t *new_pgd, *init_pgd;
-	int i;
-
-	new_pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, 0);
-	if (!new_pgd)
-		return NULL;
-	for (i = 0; i < PTRS_PER_PGD; i++) {
-		(*new_pgd) = 1;
-		new_pgd++;
-	}
-	new_pgd -= PTRS_PER_PGD;
-
-	init_pgd = pgd_offset_k(0);
-
-	memcpy(new_pgd + FIRST_KERNEL_PGD_NR, init_pgd + FIRST_KERNEL_PGD_NR,
-	       (PTRS_PER_PGD - FIRST_KERNEL_PGD_NR) * sizeof(pgd_t));
-
-	cpu_dcache_wb_range((unsigned long)new_pgd,
-			    (unsigned long)new_pgd +
-			    PTRS_PER_PGD * sizeof(pgd_t));
-	inc_lruvec_page_state(virt_to_page((unsigned long *)new_pgd),
-			      NR_PAGETABLE);
-
-	return new_pgd;
-}
-
-void pgd_free(struct mm_struct *mm, pgd_t * pgd)
-{
-	pmd_t *pmd;
-	struct page *pte;
-
-	if (!pgd)
-		return;
-
-	pmd = (pmd_t *) pgd;
-	if (pmd_none(*pmd))
-		goto free;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		goto free;
-	}
-
-	pte = pmd_page(*pmd);
-	pmd_clear(pmd);
-	dec_lruvec_page_state(virt_to_page((unsigned long *)pgd), NR_PAGETABLE);
-	pte_free(mm, pte);
-	mm_dec_nr_ptes(mm);
-	pmd_free(mm, pmd);
-free:
-	free_pages((unsigned long)pgd, 0);
-}
-
-/*
- * In order to soft-boot, we need to insert a 1:1 mapping in place of
- * the user-mode pages.  This will then ensure that we have predictable
- * results when turning the mmu off
- */
-void setup_mm_for_reboot(char mode)
-{
-	unsigned long pmdval;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	int i;
-
-	if (current->mm && current->mm->pgd)
-		pgd = current->mm->pgd;
-	else
-		pgd = init_mm.pgd;
-
-	for (i = 0; i < USER_PTRS_PER_PGD; i++) {
-		pmdval = (i << PGDIR_SHIFT);
-		p4d = p4d_offset(pgd, i << PGDIR_SHIFT);
-		pud = pud_offset(p4d, i << PGDIR_SHIFT);
-		pmd = pmd_offset(pud + i, i << PGDIR_SHIFT);
-		set_pmd(pmd, __pmd(pmdval));
-	}
-}
diff --git a/arch/nds32/mm/mmap.c b/arch/nds32/mm/mmap.c
deleted file mode 100644
index 1bdf5e7d1b43..000000000000
--- a/arch/nds32/mm/mmap.c
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/sched.h>
-#include <linux/mman.h>
-#include <linux/shm.h>
-
-#define COLOUR_ALIGN(addr,pgoff)		\
-	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
-	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
-
-/*
- * We need to ensure that shared mappings are correctly aligned to
- * avoid aliasing issues with VIPT caches.  We need to ensure that
- * a specific page of an object is always mapped at a multiple of
- * SHMLBA bytes.
- *
- * We unconditionally provide this function for all cases, however
- * in the VIVT case, we optimise out the alignment rules.
- */
-unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		       unsigned long len, unsigned long pgoff,
-		       unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int do_align = 0;
-	struct vm_unmapped_area_info info;
-	int aliasing = 0;
-	if(IS_ENABLED(CONFIG_CPU_CACHE_ALIASING))
-		aliasing = 1;
-
-	/*
-	 * We only need to do colour alignment if either the I or D
-	 * caches alias.
-	 */
-	if (aliasing)
-		do_align = filp || (flags & MAP_SHARED);
-
-	/*
-	 * We enforce the MAP_FIXED case.
-	 */
-	if (flags & MAP_FIXED) {
-		if (aliasing && flags & MAP_SHARED &&
-		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (addr) {
-		if (do_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
-	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
-	return vm_unmapped_area(&info);
-}
diff --git a/arch/nds32/mm/proc.c b/arch/nds32/mm/proc.c
deleted file mode 100644
index 848c845f5f33..000000000000
--- a/arch/nds32/mm/proc.c
+++ /dev/null
@@ -1,536 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/nds32.h>
-#include <asm/tlbflush.h>
-#include <asm/cacheflush.h>
-#include <asm/l2_cache.h>
-#include <nds32_intrinsic.h>
-
-#include <asm/cache_info.h>
-extern struct cache_info L1_cache_info[2];
-
-int va_kernel_present(unsigned long addr)
-{
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	pmd = pmd_off_k(addr);
-	if (!pmd_none(*pmd)) {
-		ptep = pte_offset_map(pmd, addr);
-		pte = *ptep;
-		if (pte_present(pte))
-			return pte;
-	}
-	return 0;
-}
-
-pte_t va_present(struct mm_struct * mm, unsigned long addr)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-
-	pgd = pgd_offset(mm, addr);
-	if (!pgd_none(*pgd)) {
-		p4d = p4d_offset(pgd, addr);
-		if (!p4d_none(*p4d)) {
-			pud = pud_offset(p4d, addr);
-			if (!pud_none(*pud)) {
-				pmd = pmd_offset(pud, addr);
-				if (!pmd_none(*pmd)) {
-					ptep = pte_offset_map(pmd, addr);
-					pte = *ptep;
-					if (pte_present(pte))
-						return pte;
-				}
-			}
-		}
-	}
-	return 0;
-
-}
-
-int va_readable(struct pt_regs *regs, unsigned long addr)
-{
-	struct mm_struct *mm = current->mm;
-	pte_t pte;
-	int ret = 0;
-
-	if (user_mode(regs)) {
-		/* user mode */
-		pte = va_present(mm, addr);
-		if (!pte && pte_read(pte))
-			ret = 1;
-	} else {
-		/* superuser mode is always readable, so we can only
-		 * check it is present or not*/
-		return (! !va_kernel_present(addr));
-	}
-	return ret;
-}
-
-int va_writable(struct pt_regs *regs, unsigned long addr)
-{
-	struct mm_struct *mm = current->mm;
-	pte_t pte;
-	int ret = 0;
-
-	if (user_mode(regs)) {
-		/* user mode */
-		pte = va_present(mm, addr);
-		if (!pte && pte_write(pte))
-			ret = 1;
-	} else {
-		/* superuser mode */
-		pte = va_kernel_present(addr);
-		if (!pte && pte_kernel_write(pte))
-			ret = 1;
-	}
-	return ret;
-}
-
-/*
- * All
- */
-void cpu_icache_inval_all(void)
-{
-	unsigned long end, line_size;
-
-	line_size = L1_cache_info[ICACHE].line_size;
-	end =
-	    line_size * L1_cache_info[ICACHE].ways * L1_cache_info[ICACHE].sets;
-
-	do {
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_IX_INVAL"::"r" (end));
-	} while (end > 0);
-	__nds32__isb();
-}
-
-void cpu_dcache_inval_all(void)
-{
-	__nds32__cctl_l1d_invalall();
-}
-
-#ifdef CONFIG_CACHE_L2
-void dcache_wb_all_level(void)
-{
-	unsigned long flags, cmd;
-	local_irq_save(flags);
-	__nds32__cctl_l1d_wball_alvl();
-	/* Section 1: Ensure the section 2 & 3 program code execution after */
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-
-	/* Section 2: Confirm the writeback all level is done in CPU and L2C */
-	cmd = CCTL_CMD_L2_SYNC;
-	L2_CMD_RDY();
-	L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
-	L2_CMD_RDY();
-
-	/* Section 3: Writeback whole L2 cache */
-	cmd = CCTL_ALL_CMD | CCTL_CMD_L2_IX_WB;
-	L2_CMD_RDY();
-	L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
-	L2_CMD_RDY();
-	__nds32__msync_all();
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(dcache_wb_all_level);
-#endif
-
-void cpu_dcache_wb_all(void)
-{
-	__nds32__cctl_l1d_wball_one_lvl();
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-}
-
-void cpu_dcache_wbinval_all(void)
-{
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	unsigned long flags;
-	local_irq_save(flags);
-#endif
-	cpu_dcache_wb_all();
-	cpu_dcache_inval_all();
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	local_irq_restore(flags);
-#endif
-}
-
-/*
- * Page
- */
-void cpu_icache_inval_page(unsigned long start)
-{
-	unsigned long line_size, end;
-
-	line_size = L1_cache_info[ICACHE].line_size;
-	end = start + PAGE_SIZE;
-
-	do {
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (end));
-	} while (end != start);
-	__nds32__isb();
-}
-
-void cpu_dcache_inval_page(unsigned long start)
-{
-	unsigned long line_size, end;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-	end = start + PAGE_SIZE;
-
-	do {
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-	} while (end != start);
-}
-
-void cpu_dcache_wb_page(unsigned long start)
-{
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	unsigned long line_size, end;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-	end = start + PAGE_SIZE;
-
-	do {
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-		end -= line_size;
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-	} while (end != start);
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-#endif
-}
-
-void cpu_dcache_wbinval_page(unsigned long start)
-{
-	unsigned long line_size, end;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-	end = start + PAGE_SIZE;
-
-	do {
-		end -= line_size;
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-#endif
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-#endif
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-#endif
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-		end -= line_size;
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (end));
-#endif
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (end));
-	} while (end != start);
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-}
-
-void cpu_cache_wbinval_page(unsigned long page, int flushi)
-{
-	cpu_dcache_wbinval_page(page);
-	if (flushi)
-		cpu_icache_inval_page(page);
-}
-
-/*
- * Range
- */
-void cpu_icache_inval_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-
-	line_size = L1_cache_info[ICACHE].line_size;
-
-	while (end > start) {
-		__asm__ volatile ("\n\tcctl %0, L1I_VA_INVAL"::"r" (start));
-		start += line_size;
-	}
-	__nds32__isb();
-}
-
-void cpu_dcache_inval_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-
-	while (end > start) {
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (start));
-		start += line_size;
-	}
-}
-
-void cpu_dcache_wb_range(unsigned long start, unsigned long end)
-{
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	unsigned long line_size;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-
-	while (end > start) {
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (start));
-		start += line_size;
-	}
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-#endif
-}
-
-void cpu_dcache_wbinval_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-
-	while (end > start) {
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (start));
-#endif
-		__asm__ volatile ("\n\tcctl %0, L1D_VA_INVAL"::"r" (start));
-		start += line_size;
-	}
-	__nds32__cctlidx_read(NDS32_CCTL_L1D_IX_RWD,0);
-}
-
-void cpu_cache_wbinval_range(unsigned long start, unsigned long end, int flushi)
-{
-	unsigned long line_size, align_start, align_end;
-
-	line_size = L1_cache_info[DCACHE].line_size;
-	align_start = start & ~(line_size - 1);
-	align_end = (end + line_size - 1) & ~(line_size - 1);
-	cpu_dcache_wbinval_range(align_start, align_end);
-
-	if (flushi) {
-		line_size = L1_cache_info[ICACHE].line_size;
-		align_start = start & ~(line_size - 1);
-		align_end = (end + line_size - 1) & ~(line_size - 1);
-		cpu_icache_inval_range(align_start, align_end);
-	}
-}
-
-void cpu_cache_wbinval_range_check(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   bool flushi, bool wbd)
-{
-	unsigned long line_size, t_start, t_end;
-
-	if (!flushi && !wbd)
-		return;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & ~(line_size - 1);
-	end = (end + line_size - 1) & ~(line_size - 1);
-
-	if ((end - start) > (8 * PAGE_SIZE)) {
-		if (wbd)
-			cpu_dcache_wbinval_all();
-		if (flushi)
-			cpu_icache_inval_all();
-		return;
-	}
-
-	t_start = (start + PAGE_SIZE) & PAGE_MASK;
-	t_end = ((end - 1) & PAGE_MASK);
-
-	if ((start & PAGE_MASK) == t_end) {
-		if (va_present(vma->vm_mm, start)) {
-			if (wbd)
-				cpu_dcache_wbinval_range(start, end);
-			if (flushi)
-				cpu_icache_inval_range(start, end);
-		}
-		return;
-	}
-
-	if (va_present(vma->vm_mm, start)) {
-		if (wbd)
-			cpu_dcache_wbinval_range(start, t_start);
-		if (flushi)
-			cpu_icache_inval_range(start, t_start);
-	}
-
-	if (va_present(vma->vm_mm, end - 1)) {
-		if (wbd)
-			cpu_dcache_wbinval_range(t_end, end);
-		if (flushi)
-			cpu_icache_inval_range(t_end, end);
-	}
-
-	while (t_start < t_end) {
-		if (va_present(vma->vm_mm, t_start)) {
-			if (wbd)
-				cpu_dcache_wbinval_page(t_start);
-			if (flushi)
-				cpu_icache_inval_page(t_start);
-		}
-		t_start += PAGE_SIZE;
-	}
-}
-
-#ifdef CONFIG_CACHE_L2
-static inline void cpu_l2cache_op(unsigned long start, unsigned long end, unsigned long op)
-{
-	if (atl2c_base) {
-		unsigned long p_start = __pa(start);
-		unsigned long p_end = __pa(end);
-		unsigned long cmd;
-		unsigned long line_size;
-		/* TODO Can Use PAGE Mode to optimize if range large than PAGE_SIZE */
-		line_size = L2_CACHE_LINE_SIZE();
-		p_start = p_start & (~(line_size - 1));
-		p_end = (p_end + line_size - 1) & (~(line_size - 1));
-		cmd =
-		    (p_start & ~(line_size - 1)) | op |
-		    CCTL_SINGLE_CMD;
-		do {
-			L2_CMD_RDY();
-			L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
-			cmd += line_size;
-			p_start += line_size;
-		} while (p_end > p_start);
-		cmd = CCTL_CMD_L2_SYNC;
-		L2_CMD_RDY();
-		L2C_W_REG(L2_CCTL_CMD_OFF, cmd);
-		L2_CMD_RDY();
-	}
-}
-#else
-#define cpu_l2cache_op(start,end,op) do { } while (0)
-#endif
-/*
- * DMA
- */
-void cpu_dma_wb_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-	unsigned long flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & (~(line_size - 1));
-	end = (end + line_size - 1) & (~(line_size - 1));
-	if (unlikely(start == end))
-		return;
-
-	local_irq_save(flags);
-	cpu_dcache_wb_range(start, end);
-	cpu_l2cache_op(start, end, CCTL_CMD_L2_PA_WB);
-	__nds32__msync_all();
-	local_irq_restore(flags);
-}
-
-void cpu_dma_inval_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-	unsigned long old_start = start;
-	unsigned long old_end = end;
-	unsigned long flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & (~(line_size - 1));
-	end = (end + line_size - 1) & (~(line_size - 1));
-	if (unlikely(start == end))
-		return;
-	local_irq_save(flags);
-	if (start != old_start) {
-		cpu_dcache_wbinval_range(start, start + line_size);
-		cpu_l2cache_op(start, start + line_size, CCTL_CMD_L2_PA_WBINVAL);
-	}
-	if (end != old_end) {
-		cpu_dcache_wbinval_range(end - line_size, end);
-		cpu_l2cache_op(end - line_size, end, CCTL_CMD_L2_PA_WBINVAL);
-	}
-	cpu_dcache_inval_range(start, end);
-	cpu_l2cache_op(start, end, CCTL_CMD_L2_PA_INVAL);
-	__nds32__msync_all();
-	local_irq_restore(flags);
-
-}
-
-void cpu_dma_wbinval_range(unsigned long start, unsigned long end)
-{
-	unsigned long line_size;
-	unsigned long flags;
-	line_size = L1_cache_info[DCACHE].line_size;
-	start = start & (~(line_size - 1));
-	end = (end + line_size - 1) & (~(line_size - 1));
-	if (unlikely(start == end))
-		return;
-
-	local_irq_save(flags);
-	cpu_dcache_wbinval_range(start, end);
-	cpu_l2cache_op(start, end, CCTL_CMD_L2_PA_WBINVAL);
-	__nds32__msync_all();
-	local_irq_restore(flags);
-}
-
-void cpu_proc_init(void)
-{
-}
-
-void cpu_proc_fin(void)
-{
-}
-
-void cpu_do_idle(void)
-{
-	__nds32__standby_no_wake_grant();
-}
-
-void cpu_reset(unsigned long reset)
-{
-	u32 tmp;
-	GIE_DISABLE();
-	tmp = __nds32__mfsr(NDS32_SR_CACHE_CTL);
-	tmp &= ~(CACHE_CTL_mskIC_EN | CACHE_CTL_mskDC_EN);
-	__nds32__mtsr_isb(tmp, NDS32_SR_CACHE_CTL);
-	cpu_dcache_wbinval_all();
-	cpu_icache_inval_all();
-
-	__asm__ __volatile__("jr.toff %0\n\t"::"r"(reset));
-}
-
-void cpu_switch_mm(struct mm_struct *mm)
-{
-	unsigned long cid;
-	cid = __nds32__mfsr(NDS32_SR_TLB_MISC);
-	cid = (cid & ~TLB_MISC_mskCID) | mm->context.id;
-	__nds32__mtsr_dsb(cid, NDS32_SR_TLB_MISC);
-	__nds32__mtsr_isb(__pa(mm->pgd), NDS32_SR_L1_PPTB);
-}
diff --git a/arch/nds32/mm/tlb.c b/arch/nds32/mm/tlb.c
deleted file mode 100644
index dd41f5e0712f..000000000000
--- a/arch/nds32/mm/tlb.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/spinlock_types.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <asm/nds32.h>
-#include <nds32_intrinsic.h>
-
-unsigned int cpu_last_cid = { TLB_MISC_mskCID + (2 << TLB_MISC_offCID) };
-
-DEFINE_SPINLOCK(cid_lock);
-
-void local_flush_tlb_range(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end)
-{
-	unsigned long flags, ocid, ncid;
-
-	if ((end - start) > 0x400000) {
-		__nds32__tlbop_flua();
-		__nds32__isb();
-		return;
-	}
-
-	spin_lock_irqsave(&cid_lock, flags);
-	ocid = __nds32__mfsr(NDS32_SR_TLB_MISC);
-	ncid = (ocid & ~TLB_MISC_mskCID) | vma->vm_mm->context.id;
-	__nds32__mtsr_dsb(ncid, NDS32_SR_TLB_MISC);
-	while (start < end) {
-		__nds32__tlbop_inv(start);
-		__nds32__isb();
-		start += PAGE_SIZE;
-	}
-	__nds32__mtsr_dsb(ocid, NDS32_SR_TLB_MISC);
-	spin_unlock_irqrestore(&cid_lock, flags);
-}
-
-void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
-{
-	unsigned long flags, ocid, ncid;
-
-	spin_lock_irqsave(&cid_lock, flags);
-	ocid = __nds32__mfsr(NDS32_SR_TLB_MISC);
-	ncid = (ocid & ~TLB_MISC_mskCID) | vma->vm_mm->context.id;
-	__nds32__mtsr_dsb(ncid, NDS32_SR_TLB_MISC);
-	__nds32__tlbop_inv(addr);
-	__nds32__isb();
-	__nds32__mtsr_dsb(ocid, NDS32_SR_TLB_MISC);
-	spin_unlock_irqrestore(&cid_lock, flags);
-}
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..ae95d06a4a8f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -617,15 +617,6 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
-config ATCPIT100_TIMER
-	bool "ATCPIT100 timer driver"
-	depends on NDS32 || COMPILE_TEST
-	depends on HAS_IOMEM
-	select TIMER_OF
-	default NDS32
-	help
-	  This option enables support for the Andestech ATCPIT100 timers.
-
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV && RISCV_SBI
diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
deleted file mode 100644
index b4bd2f5b801d..000000000000
--- a/drivers/clocksource/timer-atcpit100.c
+++ /dev/null
@@ -1,266 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-/*
- *  Andestech ATCPIT100 Timer Device Driver Implementation
- * Rick Chen, Andes Technology Corporation <rick@andestech.com>
- *
- */
-
-#include <linux/irq.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/cpufreq.h>
-#include <linux/sched.h>
-#include <linux/sched_clock.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include "timer-of.h"
-#ifdef CONFIG_NDS32
-#include <asm/vdso_timer_info.h>
-#endif
-
-/*
- * Definition of register offsets
- */
-
-/* ID and Revision Register */
-#define ID_REV		0x0
-
-/* Configuration Register */
-#define CFG		0x10
-
-/* Interrupt Enable Register */
-#define INT_EN		0x14
-#define CH_INT_EN(c, i)	((1<<i)<<(4*c))
-#define CH0INT0EN	0x01
-
-/* Interrupt Status Register */
-#define INT_STA		0x18
-#define CH0INT0		0x01
-
-/* Channel Enable Register */
-#define CH_EN		0x1C
-#define CH0TMR0EN	0x1
-#define CH1TMR0EN	0x10
-
-/* Channel 0 , 1 Control Register */
-#define CH0_CTL		(0x20)
-#define CH1_CTL		(0x20 + 0x10)
-
-/* Channel clock source , bit 3 , 0:External clock , 1:APB clock */
-#define APB_CLK		BIT(3)
-
-/* Channel mode , bit 0~2 */
-#define TMR_32		0x1
-#define TMR_16		0x2
-#define TMR_8		0x3
-
-/* Channel 0 , 1 Reload Register */
-#define CH0_REL		(0x24)
-#define CH1_REL		(0x24 + 0x10)
-
-/* Channel 0 , 1 Counter Register */
-#define CH0_CNT		(0x28)
-#define CH1_CNT		(0x28 + 0x10)
-
-#define TIMER_SYNC_TICKS	3
-
-static void atcpit100_ch1_tmr0_en(void __iomem *base)
-{
-	writel(~0, base + CH1_REL);
-	writel(APB_CLK|TMR_32, base + CH1_CTL);
-}
-
-static void atcpit100_ch0_tmr0_en(void __iomem *base)
-{
-	writel(APB_CLK|TMR_32, base + CH0_CTL);
-}
-
-static void atcpit100_clkevt_time_setup(void __iomem *base, unsigned long delay)
-{
-	writel(delay, base + CH0_CNT);
-	writel(delay, base + CH0_REL);
-}
-
-static void atcpit100_timer_clear_interrupt(void __iomem *base)
-{
-	u32 val;
-
-	val = readl(base + INT_STA);
-	writel(val | CH0INT0, base + INT_STA);
-}
-
-static void atcpit100_clocksource_start(void __iomem *base)
-{
-	u32 val;
-
-	val = readl(base + CH_EN);
-	writel(val | CH1TMR0EN, base + CH_EN);
-}
-
-static void atcpit100_clkevt_time_start(void __iomem *base)
-{
-	u32 val;
-
-	val = readl(base + CH_EN);
-	writel(val | CH0TMR0EN, base + CH_EN);
-}
-
-static void atcpit100_clkevt_time_stop(void __iomem *base)
-{
-	u32 val;
-
-	atcpit100_timer_clear_interrupt(base);
-	val = readl(base + CH_EN);
-	writel(val & ~CH0TMR0EN, base + CH_EN);
-}
-
-static int atcpit100_clkevt_next_event(unsigned long evt,
-	struct clock_event_device *clkevt)
-{
-	u32 val;
-	struct timer_of *to = to_timer_of(clkevt);
-
-	val = readl(timer_of_base(to) + CH_EN);
-	writel(val & ~CH0TMR0EN, timer_of_base(to) + CH_EN);
-	writel(evt, timer_of_base(to) + CH0_REL);
-	writel(val | CH0TMR0EN, timer_of_base(to) + CH_EN);
-
-	return 0;
-}
-
-static int atcpit100_clkevt_set_periodic(struct clock_event_device *evt)
-{
-	struct timer_of *to = to_timer_of(evt);
-
-	atcpit100_clkevt_time_setup(timer_of_base(to), timer_of_period(to));
-	atcpit100_clkevt_time_start(timer_of_base(to));
-
-	return 0;
-}
-static int atcpit100_clkevt_shutdown(struct clock_event_device *evt)
-{
-	struct timer_of *to = to_timer_of(evt);
-
-	atcpit100_clkevt_time_stop(timer_of_base(to));
-
-	return 0;
-}
-static int atcpit100_clkevt_set_oneshot(struct clock_event_device *evt)
-{
-	struct timer_of *to = to_timer_of(evt);
-	u32 val;
-
-	writel(~0x0, timer_of_base(to) + CH0_REL);
-	val = readl(timer_of_base(to) + CH_EN);
-	writel(val | CH0TMR0EN, timer_of_base(to) + CH_EN);
-
-	return 0;
-}
-
-static irqreturn_t atcpit100_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	struct timer_of *to = to_timer_of(evt);
-
-	atcpit100_timer_clear_interrupt(timer_of_base(to));
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct timer_of to = {
-	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
-
-	.clkevt = {
-		.name = "atcpit100_tick",
-		.rating = 300,
-		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-		.set_state_shutdown = atcpit100_clkevt_shutdown,
-		.set_state_periodic = atcpit100_clkevt_set_periodic,
-		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
-		.tick_resume = atcpit100_clkevt_shutdown,
-		.set_next_event = atcpit100_clkevt_next_event,
-		.cpumask = cpu_possible_mask,
-	},
-
-	.of_irq = {
-		.handler = atcpit100_timer_interrupt,
-		.flags = IRQF_TIMER | IRQF_IRQPOLL,
-	},
-
-	/*
-	 * FIXME: we currently only support clocking using PCLK
-	 * and using EXTCLK is not supported in the driver.
-	 */
-	.of_clk = {
-		.name = "PCLK",
-	}
-};
-
-static u64 notrace atcpit100_timer_sched_read(void)
-{
-	return ~readl(timer_of_base(&to) + CH1_CNT);
-}
-
-#ifdef CONFIG_NDS32
-static void fill_vdso_need_info(struct device_node *node)
-{
-	struct resource timer_res;
-	of_address_to_resource(node, 0, &timer_res);
-	timer_info.mapping_base = (unsigned long)timer_res.start;
-	timer_info.cycle_count_down = true;
-	timer_info.cycle_count_reg_offset = CH1_CNT;
-}
-#endif
-
-static int __init atcpit100_timer_init(struct device_node *node)
-{
-	int ret;
-	u32 val;
-	void __iomem *base;
-
-	ret = timer_of_init(node, &to);
-	if (ret)
-		return ret;
-
-	base = timer_of_base(&to);
-
-	sched_clock_register(atcpit100_timer_sched_read, 32,
-		timer_of_rate(&to));
-
-	ret = clocksource_mmio_init(base + CH1_CNT,
-		node->name, timer_of_rate(&to), 300, 32,
-		clocksource_mmio_readl_down);
-
-	if (ret) {
-		pr_err("Failed to register clocksource\n");
-		return ret;
-	}
-
-	/* clear channel 0 timer0 interrupt */
-	atcpit100_timer_clear_interrupt(base);
-
-	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
-					TIMER_SYNC_TICKS, 0xffffffff);
-	atcpit100_ch0_tmr0_en(base);
-	atcpit100_ch1_tmr0_en(base);
-	atcpit100_clocksource_start(base);
-	atcpit100_clkevt_time_start(base);
-
-	/* Enable channel 0 timer0 interrupt */
-	val = readl(base + INT_EN);
-	writel(val | CH0INT0EN, base + INT_EN);
-
-#ifdef CONFIG_NDS32
-	fill_vdso_need_info(node);
-#endif
-
-	return ret;
-}
-
-TIMER_OF_DECLARE(atcpit100, "andestech,atcpit100", atcpit100_timer_init);
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..c6161b0b0cb6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -92,7 +92,6 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
-obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
deleted file mode 100644
index 223dd2f97d28..000000000000
--- a/drivers/irqchip/irq-ativic32.c
+++ /dev/null
@@ -1,156 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/hardirq.h>
-#include <linux/interrupt.h>
-#include <linux/irqdomain.h>
-#include <linux/irqchip.h>
-#include <nds32_intrinsic.h>
-
-#include <asm/irq_regs.h>
-
-unsigned long wake_mask;
-
-static void ativic32_ack_irq(struct irq_data *data)
-{
-	__nds32__mtsr_dsb(BIT(data->hwirq), NDS32_SR_INT_PEND2);
-}
-
-static void ativic32_mask_irq(struct irq_data *data)
-{
-	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
-	__nds32__mtsr_dsb(int_mask2 & (~(BIT(data->hwirq))), NDS32_SR_INT_MASK2);
-}
-
-static void ativic32_unmask_irq(struct irq_data *data)
-{
-	unsigned long int_mask2 = __nds32__mfsr(NDS32_SR_INT_MASK2);
-	__nds32__mtsr_dsb(int_mask2 | (BIT(data->hwirq)), NDS32_SR_INT_MASK2);
-}
-
-static int nointc_set_wake(struct irq_data *data, unsigned int on)
-{
-	unsigned long int_mask = __nds32__mfsr(NDS32_SR_INT_MASK);
-	static unsigned long irq_orig_bit;
-	u32 bit = 1 << data->hwirq;
-
-	if (on) {
-		if (int_mask & bit)
-			__assign_bit(data->hwirq, &irq_orig_bit, true);
-		else
-			__assign_bit(data->hwirq, &irq_orig_bit, false);
-
-		__assign_bit(data->hwirq, &int_mask, true);
-		__assign_bit(data->hwirq, &wake_mask, true);
-
-	} else {
-		if (!(irq_orig_bit & bit))
-			__assign_bit(data->hwirq, &int_mask, false);
-
-		__assign_bit(data->hwirq, &wake_mask, false);
-		__assign_bit(data->hwirq, &irq_orig_bit, false);
-	}
-
-	__nds32__mtsr_dsb(int_mask, NDS32_SR_INT_MASK);
-
-	return 0;
-}
-
-static struct irq_chip ativic32_chip = {
-	.name = "ativic32",
-	.irq_ack = ativic32_ack_irq,
-	.irq_mask = ativic32_mask_irq,
-	.irq_unmask = ativic32_unmask_irq,
-	.irq_set_wake = nointc_set_wake,
-};
-
-static unsigned int __initdata nivic_map[6] = { 6, 2, 10, 16, 24, 32 };
-
-static struct irq_domain *root_domain;
-static int ativic32_irq_domain_map(struct irq_domain *id, unsigned int virq,
-				  irq_hw_number_t hw)
-{
-
-	unsigned long int_trigger_type;
-	u32 type;
-	struct irq_data *irq_data;
-	int_trigger_type = __nds32__mfsr(NDS32_SR_INT_TRIGGER);
-	irq_data = irq_get_irq_data(virq);
-	if (!irq_data)
-		return -EINVAL;
-
-	if (int_trigger_type & (BIT(hw))) {
-		irq_set_chip_and_handler(virq, &ativic32_chip, handle_edge_irq);
-		type = IRQ_TYPE_EDGE_RISING;
-	} else {
-		irq_set_chip_and_handler(virq, &ativic32_chip, handle_level_irq);
-		type = IRQ_TYPE_LEVEL_HIGH;
-	}
-
-	irqd_set_trigger_type(irq_data, type);
-	return 0;
-}
-
-static const struct irq_domain_ops ativic32_ops = {
-	.map = ativic32_irq_domain_map,
-	.xlate = irq_domain_xlate_onecell
-};
-
-static irq_hw_number_t get_intr_src(void)
-{
-	return ((__nds32__mfsr(NDS32_SR_ITYPE) & ITYPE_mskVECTOR) >> ITYPE_offVECTOR)
-		- NDS32_VECTOR_offINTERRUPT;
-}
-
-static void ativic32_handle_irq(struct pt_regs *regs)
-{
-	irq_hw_number_t hwirq = get_intr_src();
-	generic_handle_domain_irq(root_domain, hwirq);
-}
-
-/*
- * TODO: convert nds32 to GENERIC_IRQ_MULTI_HANDLER so that this entry logic
- * can live in arch code.
- */
-asmlinkage void asm_do_IRQ(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs;
-
-	irq_enter();
-	old_regs = set_irq_regs(regs);
-	ativic32_handle_irq(regs);
-	set_irq_regs(old_regs);
-	irq_exit();
-}
-
-int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
-{
-	unsigned long int_vec_base, nivic, nr_ints;
-
-	if (WARN(parent, "non-root ativic32 are not supported"))
-		return -EINVAL;
-
-	int_vec_base = __nds32__mfsr(NDS32_SR_IVB);
-
-	if (((int_vec_base & IVB_mskIVIC_VER) >> IVB_offIVIC_VER) == 0)
-		panic("Unable to use atcivic32 for this cpu.\n");
-
-	nivic = (int_vec_base & IVB_mskNIVIC) >> IVB_offNIVIC;
-	if (nivic >= ARRAY_SIZE(nivic_map))
-		panic("The number of input for ativic32 is not supported.\n");
-
-	nr_ints = nivic_map[nivic];
-
-	root_domain = irq_domain_add_linear(node, nr_ints,
-			&ativic32_ops, NULL);
-
-	if (!root_domain)
-		panic("%s: unable to create IRQ domain\n", node->full_name);
-
-	return 0;
-}
-IRQCHIP_DECLARE(ativic32, "andestech,ativic32", ativic32_init_irq);
diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 3d1e9a302148..c699bd6bcbb9 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM || NDS32 || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -19,24 +19,22 @@ if NET_VENDOR_FARADAY
 
 config FTMAC100
 	tristate "Faraday FTMAC100 10/100 Ethernet support"
-	depends on ARM || NDS32 || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	depends on !64BIT || BROKEN
 	select MII
 	help
 	  This driver supports the FTMAC100 10/100 Ethernet controller
-	  from Faraday. It is used on Faraday A320, Andes AG101 and some
-	  other ARM/NDS32 SoC's.
+	  from Faraday. It is used on Faraday A320 and some other ARM SoC's.
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM || NDS32 || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	depends on !64BIT || BROKEN
 	select PHYLIB
 	select MDIO_ASPEED if MACH_ASPEED_G6
 	select CRC32
 	help
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-	  from Faraday. It is used on Faraday A369, Andes AG102 and some
-	  other ARM/NDS32 SoC's.
+	  from Faraday. It is used on Faraday A369 and some other ARM SoC's.
 
 endif # NET_VENDOR_FARADAY
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index fcc46380e7c9..40c50fa2dd70 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390 && !UML
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 3ccb2c70add4..6a4645a57976 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -362,9 +362,6 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL(_PLT)?\\s_?mcount\$";
     $type = ".quad";
     $alignment = 2;
-} elsif ($arch eq "nds32") {
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_NDS32_HI20_RELA\\s+_mcount\$";
-    $alignment = 2;
 } elsif ($arch eq "csky") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_CKCORE_PCREL_JSR_IMM26BY2\\s+_mcount\$";
     $alignment = 2;
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index dc696c151e1c..8d378c57cb01 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -24,8 +24,6 @@
 #include "../../arch/ia64/include/asm/barrier.h"
 #elif defined(__xtensa__)
 #include "../../arch/xtensa/include/asm/barrier.h"
-#elif defined(__nds32__)
-#include "../../arch/nds32/include/asm/barrier.h"
 #else
 #include <asm-generic/barrier.h>
 #endif
diff --git a/tools/perf/arch/nds32/Build b/tools/perf/arch/nds32/Build
deleted file mode 100644
index e4e5f33c84d8..000000000000
--- a/tools/perf/arch/nds32/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-y += util/
diff --git a/tools/perf/arch/nds32/util/Build b/tools/perf/arch/nds32/util/Build
deleted file mode 100644
index d0bc205fe49a..000000000000
--- a/tools/perf/arch/nds32/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-y += header.o
diff --git a/tools/perf/arch/nds32/util/header.c b/tools/perf/arch/nds32/util/header.c
deleted file mode 100644
index ef9dbdbe7968..000000000000
--- a/tools/perf/arch/nds32/util/header.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <api/fs/fs.h>
-#include "header.h"
-
-#define STR_LEN 1024
-
-char *get_cpuid_str(struct perf_pmu *pmu)
-{
-	/* In nds32, we only have one cpu */
-	char *buf = NULL;
-	struct cpu_map *cpus;
-	const char *sysfs = sysfs__mountpoint();
-
-	if (!sysfs || !pmu || !pmu->cpus)
-		return NULL;
-
-	buf = malloc(STR_LEN);
-	if (!buf)
-		return NULL;
-
-	cpus = cpu_map__get(pmu->cpus);
-	sprintf(buf, "0x%x", cpus->nr - 1);
-	cpu_map__put(cpus);
-	return buf;
-}
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 6188b16827d1..cdfed403ba13 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -53,10 +53,6 @@
 #if __riscv_xlen == 32
 #define VDSO_32BIT		1
 #endif
-#else /* nds32 */
-#define VDSO_VERSION		4
-#define VDSO_NAMES		1
-#define VDSO_32BIT		1
 #endif
 
 static const char *versions[6] = {
-- 
2.25.1

