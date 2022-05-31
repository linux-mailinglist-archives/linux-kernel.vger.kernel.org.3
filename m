Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5323A53954B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbiEaRNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiEaRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:13:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9970369
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:13:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so2054668pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=hCG9E6PlaWTrYDTG2pJFHHWUOtCqOQpKj9TBeAvpTLc=;
        b=7D3rufycsASVpNtBpZXlluVqusoQV2HsoxTvXNuoR4EVDPT6F78dg9VPAujwjJxebU
         r4bSfNYAHOnLn7AlivCn/ADocXggnbdC9q+tPskX/wpJPwIrI/WOSwziytXEidER6667
         1JMkDCjfcZvoJIydrZN5c8NbZT2bbTbKkzlL5zVczO5ZW+2j6l6OL3mo8YzrmaHqPoCI
         umRmqXVmmptXtgJfnh6OqXe6jsCzchwzlguGS4LOb7aCo1Qxwq9ywrCUYiZeZ18rj7Ob
         VodcMWHKVLUNYBbKohOKhlH4LO6WafWIqJewsGHpa92QrjUh/GtAz9amENDebw0aoyUp
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=hCG9E6PlaWTrYDTG2pJFHHWUOtCqOQpKj9TBeAvpTLc=;
        b=6X61SbYr1dl7BrN+L9fGlZeLPBC0WRG808qXI6vKl8NNQujcUVHZKa1Z5503Vh98sN
         HsHBF7NFYznFzP7JZnK8e3CDM7DLrLaxjflh81IJM9UlZ+AJTIuWiCHQdiFTIO04hnF5
         i4l4Zz4ZKgGFE4J55JwcbLYg8a+k7twv24aF5W6z3ebWjuMZorRvpLxFMW1/2+0pueCC
         AvvoYegqSkh+7enQezt3f7ukQseY/v85A+CXyX/qb9fiDu40GM9W+3pkMFH5Ti3qKTcP
         gGw5sYry6gG1NSsmeNNGX9IrKg9c6ImY2jEntWV1yldxpmwLm9fObO0rkNiG1Nl32Hwr
         gqgw==
X-Gm-Message-State: AOAM532JwRvqlJjujz3j/Q1Wh6UdUSdt6BsNhEZU6sZ4tx+B4jIhJfHi
        UhX+0YqVS2tUInimPIVSJZvtaw==
X-Google-Smtp-Source: ABdhPJx/JoumSW/KZfhD0aKh+Ax/wSpupMcL3xtrrVnsAwuSaZn9mRwSSnqpBF1UTi8y2TkXn+aWEQ==
X-Received: by 2002:a17:90b:1b08:b0:1df:f11a:7d51 with SMTP id nu8-20020a17090b1b0800b001dff11a7d51mr30112438pjb.190.1654017187496;
        Tue, 31 May 2022 10:13:07 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b001e2608203d4sm2391167pjb.5.2022.05.31.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:13:06 -0700 (PDT)
Date:   Tue, 31 May 2022 10:13:06 -0700 (PDT)
X-Google-Original-Date: Tue, 31 May 2022 10:13:02 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3cfe92b5-a83a-4642-9b9e-8416ae717fd6@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9282d0996936c5fbf877c0d096a3feb456c878ad:

  csky: Move to generic ticket-spinlock (2022-05-11 11:50:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw0

for you to fetch changes up to 7699f7aacf3ebfee51c670b6f796b2797f0f7487:

  RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add] (2022-05-30 16:04:37 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.19 Merge Window, Part 1

* Support for the Svpbmt extension, which allows memory attributes to be
  encoded in pages.
* Support for the Allwinner D1's implementation of page-based memory
  attributes.
* Support for running rv32 binaries on rv64 systems, via the compat
  subsystem.
* Support for kexec_file().
* Support for the new generic ticket-based spinlocks, which allows us to
  also move to qrwlock.  These should have already gone in through the
  asm-geneic tree as well.
* A handful of cleanups and fixes, include some larger ones around
  atomics and XIP.

----------------------------------------------------------------
The spinlock stuff that already went in isn't called out in the shortlog, IIUC
that's a feature.  It might have slightly messed up git-request-pull, though,
as I'd consider the base here really 5.18-rc1.

I have a single manual resolution in the fe510 device tree, just the result of
some conflicting fixes.  It's not showing up in my merge, but a bunch of other
automatic resolutions are which is a bit worrisome on my end -- I don't usually
touch other trees, but we had a handful of big cross-tree things this time.
Sorry in advance if I've screwed something up, here's what I'm seeing:

    diff --cc arch/arm64/Kconfig
    index ff674808681a,a4968845e67f..1652a9800ebe
    --- a/arch/arm64/Kconfig
    +++ b/arch/arm64/Kconfig
    @@@ -2120,8 -2155,12 +2155,8 @@@ config DM
      	  However, even with this option, the resultant kernel should
      	  continue to boot on existing non-UEFI platforms.
    
    - endmenu
    + endmenu # "Boot options"
    
     -config SYSVIPC_COMPAT
     -	def_bool y
     -	depends on COMPAT && SYSVIPC
     -
      menu "Power management options"
    
      source "kernel/power/Kconfig"
    diff --cc arch/x86/include/asm/compat.h
    index e74a107de0d0,20fd0acd7d80..b1221da477b7
    --- a/arch/x86/include/asm/compat.h
    +++ b/arch/x86/include/asm/compat.h
    @@@ -15,27 -15,20 +15,26 @@@
      #define compat_mode_t	compat_mode_t
      typedef u16		compat_mode_t;
    
     +#define __compat_uid_t	__compat_uid_t
     +typedef u16		__compat_uid_t;
     +typedef u16		__compat_gid_t;
     +
     +#define compat_dev_t	compat_dev_t
     +typedef u16		compat_dev_t;
     +
     +#define compat_ipc_pid_t compat_ipc_pid_t
     +typedef u16		 compat_ipc_pid_t;
     +
     +#define compat_statfs	compat_statfs
     +
      #include <asm-generic/compat.h>
    
     -#define COMPAT_USER_HZ		100
      #define COMPAT_UTS_MACHINE	"i686\0\0"
    
     -typedef u16		__compat_uid_t;
     -typedef u16		__compat_gid_t;
     -typedef u16		compat_dev_t;
      typedef u16		compat_nlink_t;
     -typedef u16		compat_ipc_pid_t;
     -typedef __kernel_fsid_t	compat_fsid_t;
    
      struct compat_stat {
    - 	compat_dev_t	st_dev;
    - 	u16		__pad1;
    + 	u32		st_dev;
      	compat_ino_t	st_ino;
      	compat_mode_t	st_mode;
      	compat_nlink_t	st_nlink;
    diff --cc include/linux/kexec.h
    index ebb1bffbf068,fcd5035209f1..ce6536f1d269
    --- a/include/linux/kexec.h
    +++ b/include/linux/kexec.h
    @@@ -227,8 -219,46 +219,46 @@@ struct crash_mem
      extern int crash_exclude_mem_range(struct crash_mem *mem,
      				   unsigned long long mstart,
      				   unsigned long long mend);
     -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
     +extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
      				       void **addr, unsigned long *sz);
    +
    + #ifndef arch_kexec_apply_relocations_add
    + /*
    +  * arch_kexec_apply_relocations_add - apply relocations of type RELA
    +  * @pi:		Purgatory to be relocated.
    +  * @section:	Section relocations applying to.
    +  * @relsec:	Section containing RELAs.
    +  * @symtab:	Corresponding symtab.
    +  *
    +  * Return: 0 on success, negative errno on error.
    +  */
    + static inline int
    + arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
    + 				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
    + {
    + 	pr_err("RELA relocation unsupported.\n");
    + 	return -ENOEXEC;
    + }
    + #endif
    +
    + #ifndef arch_kexec_apply_relocations
    + /*
    +  * arch_kexec_apply_relocations - apply relocations of type REL
    +  * @pi:		Purgatory to be relocated.
    +  * @section:	Section relocations applying to.
    +  * @relsec:	Section containing RELs.
    +  * @symtab:	Corresponding symtab.
    +  *
    +  * Return: 0 on success, negative errno on error.
    +  */
    + static inline int
    + arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
    + 			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
    + {
    + 	pr_err("REL relocation unsupported.\n");
    + 	return -ENOEXEC;
    + }
    + #endif
      #endif /* CONFIG_KEXEC_FILE */
    
      #ifdef CONFIG_KEXEC_ELF

The arm64 stuff is from a refactoring so it seems pretty safe, and the kexec
stuff looks like a straight-forward merge conflict that was autoresolved
correctly.  The x86 merge looks a bit scarier, but IIUC the autoresolver is
doing the right thing: 932aba1e1690 ("stat: fix inconsistency between struct
stat and struct compat_stat") changed compat_stat without changing
compat_dev_t, we're still matching that behavior.

I'll definately have a part 2 (or a respin), I'm farther behind that I usually
am this round.

----------------------------------------------------------------
Christoph Hellwig (3):
      uapi: simplify __ARCH_FLOCK{,64}_PAD a little
      uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
      compat: consolidate the compat_flock{,64} definition

Chuanhua Han (1):
      riscv: mm: Remove the copy operation of pmd

Guo Ren (21):
      arch: Add SYSVIPC_COMPAT for all architectures
      fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
      asm-generic: compat: Cleanup duplicate definitions
      syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
      riscv: Fixup difference with defconfig
      riscv: compat: Add basic compat data type implementation
      riscv: compat: Support TASK_SIZE for compat mode
      riscv: compat: syscall: Add compat_sys_call_table implementation
      riscv: compat: syscall: Add entry.S implementation
      riscv: compat: process: Add UXL_32 support in start_thread
      riscv: compat: Add elf.h implementation
      riscv: compat: Add hw capability check for elf
      riscv: compat: vdso: Add COMPAT_VDSO base code implementation
      riscv: compat: vdso: Add setup additional pages implementation
      riscv: compat: signal: Add rt_frame implementation
      riscv: compat: ptrace: Add compat_arch_ptrace implement
      riscv: compat: Add COMPAT Kbuild skeletal support
      riscv: atomic: Cleanup unnecessary definition
      riscv: atomic: Optimize dec_if_positive functions
      riscv: atomic: Add custom conditional atomic operation implementation
      riscv: compat: Using seperated vdso_maps for compat_vdso_info

Heiko Stuebner (12):
      riscv: integrate alternatives better into the main architecture
      riscv: allow different stages with alternatives
      riscv: implement module alternatives
      riscv: implement ALTERNATIVE_2 macro
      riscv: extend concatenated alternatives-lines to the same length
      riscv: prevent compressed instructions in alternatives
      riscv: move boot alternatives to after fill_hwcap
      riscv: Fix accessing pfn bits in PTEs for non-32bit variants
      riscv: add RISC-V Svpbmt extension support
      riscv: remove FIXMAP_PAGE_IO and fall back to its default value
      riscv: don't use global static vars to store alternative data
      riscv: add memory-type errata for T-Head

Li Zhengyu (3):
      RISC-V: Support for kexec_file on panic
      RISC-V: Add purgatory
      RISC-V: Load purgatory in kexec_file

Liao Chang (3):
      kexec_file: Fix kexec_file.c build error for riscv platform
      RISC-V: use memcpy for kexec_file mode
      RISC-V: Add kexec_file support

Niklas Cassel (1):
      riscv: Don't output a bogus mmu-type on a no MMU kernel

Palmer Dabbelt (9):
      riscv: support for Svpbmt and D1 memory types
      RISC-V: Add support for rv32 userspace via COMPAT
      riscv: kexec: add kexec_file_load() support
      Merge tag 'generic-ticket-spinlocks-v6' into for-next
      RISC-V: Avoid empty create_*_mapping definitions
      RISC-V: ignore xipImage
      RISC-V: Split out the XIP fixups into their own file
      RISC-V: Fix the XIP build
      RISC-V: Various XIP fixes

Uwe Kleine-König (1):
      RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]

Zong Li (2):
      riscv: dts: Add dma-channels property and modify compatible
      riscv: dts: rename the node name of dma

 arch/arm64/Kconfig                                 |   4 -
 arch/arm64/include/asm/compat.h                    |  93 +----
 arch/arm64/include/asm/unistd.h                    |   1 +
 arch/mips/Kconfig                                  |   5 -
 arch/mips/include/asm/compat.h                     |  41 +-
 arch/mips/include/asm/unistd.h                     |   2 +
 arch/mips/include/uapi/asm/fcntl.h                 |  30 +-
 arch/parisc/Kconfig                                |   4 -
 arch/parisc/include/asm/compat.h                   |  45 +--
 arch/parisc/include/asm/unistd.h                   |   1 +
 arch/powerpc/Kconfig                               |   5 -
 arch/powerpc/include/asm/compat.h                  |  50 +--
 arch/powerpc/include/asm/unistd.h                  |   1 +
 arch/riscv/Kbuild                                  |   2 +
 arch/riscv/Kconfig                                 |  67 +++
 arch/riscv/Kconfig.erratas                         |  34 +-
 arch/riscv/Kconfig.socs                            |   1 -
 arch/riscv/Makefile                                |  11 +-
 arch/riscv/boot/.gitignore                         |   1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |   5 +-
 arch/riscv/errata/Makefile                         |   2 +-
 arch/riscv/errata/alternative.c                    |  75 ----
 arch/riscv/errata/sifive/errata.c                  |  20 +-
 arch/riscv/errata/thead/Makefile                   |  11 +
 arch/riscv/errata/thead/errata.c                   |  82 ++++
 arch/riscv/include/asm/alternative-macros.h        | 129 ++++--
 arch/riscv/include/asm/alternative.h               |  25 +-
 arch/riscv/include/asm/asm.h                       |  26 --
 arch/riscv/include/asm/atomic.h                    | 102 ++++-
 arch/riscv/include/asm/cmpxchg.h                   |  12 -
 arch/riscv/include/asm/compat.h                    | 129 ++++++
 arch/riscv/include/asm/csr.h                       |   7 +
 arch/riscv/include/asm/elf.h                       |  50 ++-
 arch/riscv/include/asm/errata_list.h               |  59 +++
 arch/riscv/include/asm/fixmap.h                    |   2 -
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/kexec.h                     |  11 +
 arch/riscv/include/asm/mmu.h                       |   1 +
 arch/riscv/include/asm/pgtable-32.h                |  17 +
 arch/riscv/include/asm/pgtable-64.h                |  79 +++-
 arch/riscv/include/asm/pgtable-bits.h              |  10 -
 arch/riscv/include/asm/pgtable.h                   |  68 +++-
 arch/riscv/include/asm/processor.h                 |   6 +-
 arch/riscv/include/asm/signal32.h                  |  18 +
 arch/riscv/include/asm/syscall.h                   |   1 +
 arch/riscv/include/asm/thread_info.h               |   1 +
 arch/riscv/include/asm/unistd.h                    |  11 +
 arch/riscv/include/asm/vdso.h                      |   9 +
 arch/riscv/include/asm/vendorid_list.h             |   1 +
 arch/riscv/include/asm/xip_fixup.h                 |  31 ++
 arch/riscv/include/uapi/asm/unistd.h               |   2 +-
 arch/riscv/kernel/Makefile                         |  19 +
 arch/riscv/kernel/alternative.c                    | 118 ++++++
 arch/riscv/kernel/compat_signal.c                  | 243 +++++++++++
 arch/riscv/kernel/compat_syscall_table.c           |  19 +
 arch/riscv/kernel/compat_vdso/.gitignore           |   2 +
 arch/riscv/kernel/compat_vdso/Makefile             |  78 ++++
 arch/riscv/kernel/compat_vdso/compat_vdso.S        |   8 +
 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S    |   3 +
 arch/riscv/kernel/compat_vdso/flush_icache.S       |   3 +
 .../kernel/compat_vdso/gen_compat_vdso_offsets.sh  |   5 +
 arch/riscv/kernel/compat_vdso/getcpu.S             |   3 +
 arch/riscv/kernel/compat_vdso/note.S               |   3 +
 arch/riscv/kernel/compat_vdso/rt_sigreturn.S       |   3 +
 arch/riscv/kernel/cpu.c                            |   5 +
 arch/riscv/kernel/cpufeature.c                     |  80 +++-
 arch/riscv/kernel/elf_kexec.c                      | 448 +++++++++++++++++++++
 arch/riscv/kernel/entry.S                          |  18 +-
 arch/riscv/kernel/head.S                           |   1 +
 arch/riscv/kernel/machine_kexec.c                  |   4 +-
 arch/riscv/kernel/machine_kexec_file.c             |  14 +
 arch/riscv/kernel/module.c                         |  29 ++
 arch/riscv/kernel/process.c                        |  37 ++
 arch/riscv/kernel/ptrace.c                         |  87 +++-
 arch/riscv/kernel/setup.c                          |   2 +
 arch/riscv/kernel/signal.c                         |   7 +-
 arch/riscv/kernel/smpboot.c                        |   4 -
 arch/riscv/kernel/suspend_entry.S                  |   1 +
 arch/riscv/kernel/sys_riscv.c                      |   6 +-
 arch/riscv/kernel/traps.c                          |   2 +-
 arch/riscv/kernel/vdso.c                           | 114 ++++--
 arch/riscv/kernel/vdso/vdso.S                      |   6 +-
 arch/riscv/mm/fault.c                              |  10 +-
 arch/riscv/mm/init.c                               |   9 +-
 arch/riscv/purgatory/.gitignore                    |   4 +
 arch/riscv/purgatory/Makefile                      |  95 +++++
 arch/riscv/purgatory/entry.S                       |  47 +++
 arch/riscv/purgatory/purgatory.c                   |  45 +++
 arch/s390/Kconfig                                  |   3 -
 arch/s390/include/asm/compat.h                     |  99 +----
 arch/s390/include/asm/unistd.h                     |   1 +
 arch/sparc/Kconfig                                 |   5 -
 arch/sparc/include/asm/compat.h                    |  61 +--
 arch/sparc/include/asm/unistd.h                    |   1 +
 arch/x86/Kconfig                                   |   4 -
 arch/x86/include/asm/compat.h                      | 104 +----
 arch/x86/include/asm/unistd.h                      |   1 +
 fs/open.c                                          |  24 ++
 fs/read_write.c                                    |  16 +
 fs/stat.c                                          |   2 +-
 fs/sync.c                                          |   9 +
 include/asm-generic/compat.h                       | 113 ++++++
 include/linux/compat.h                             |  68 ++++
 include/linux/kexec.h                              |   2 +-
 include/uapi/asm-generic/fcntl.h                   |  23 +-
 include/uapi/asm-generic/unistd.h                  |   4 +-
 init/Kconfig                                       |   4 +
 kernel/kexec_file.c                                |   4 +-
 mm/fadvise.c                                       |  11 +
 mm/readahead.c                                     |   7 +
 tools/include/uapi/asm-generic/fcntl.h             |  21 +-
 tools/include/uapi/asm-generic/unistd.h            |   4 +-
 112 files changed, 2786 insertions(+), 788 deletions(-)
 delete mode 100644 arch/riscv/errata/alternative.c
 create mode 100644 arch/riscv/errata/thead/Makefile
 create mode 100644 arch/riscv/errata/thead/errata.c
 create mode 100644 arch/riscv/include/asm/compat.h
 create mode 100644 arch/riscv/include/asm/signal32.h
 create mode 100644 arch/riscv/include/asm/xip_fixup.h
 create mode 100644 arch/riscv/kernel/alternative.c
 create mode 100644 arch/riscv/kernel/compat_signal.c
 create mode 100644 arch/riscv/kernel/compat_syscall_table.c
 create mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
 create mode 100644 arch/riscv/kernel/compat_vdso/Makefile
 create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
 create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
 create mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
 create mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
 create mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
 create mode 100644 arch/riscv/kernel/compat_vdso/note.S
 create mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
 create mode 100644 arch/riscv/kernel/elf_kexec.c
 create mode 100644 arch/riscv/kernel/machine_kexec_file.c
 create mode 100644 arch/riscv/purgatory/.gitignore
 create mode 100644 arch/riscv/purgatory/Makefile
 create mode 100644 arch/riscv/purgatory/entry.S
 create mode 100644 arch/riscv/purgatory/purgatory.c
