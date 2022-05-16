Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22CF528DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbiEPTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345311AbiEPTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867723969C;
        Mon, 16 May 2022 12:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13073614C6;
        Mon, 16 May 2022 19:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7ACC385AA;
        Mon, 16 May 2022 19:09:15 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.40-rt43
Date:   Mon, 16 May 2022 19:08:25 -0000
Message-ID: <165272810508.507274.552990901918954361@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.40-rt43 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 3122b8942f4d214f432a601d1646ed08b1a0d381

Or to build 5.15.40-rt43 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.40.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.40-rt43.patch.xz


Enjoy!
Clark

Changes from v5.15.39-rt42:
---

Arnaldo Carvalho de Melo (1):
      tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in 'perf bench mem memcpy'

Borislav Petkov (1):
      kvm/emulate: Fix SETcc emulation function offsets with SLS

Clark Williams (2):
      Merge tag 'v5.15.40' into v5.15-rt
      'Linux 5.15.40-rt43'

Gleb Fotengauer-Malinovskiy (1):
      rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE ioctl request definition

Greg Kroah-Hartman (1):
      Linux 5.15.40

Itay Iellin (1):
      Bluetooth: Fix the creation of hdev->name

Jan Kara (1):
      udf: Avoid using stale lengthOfImpUse

Masahiro Yamada (1):
      kbuild: move objtool_args back to scripts/Makefile.build

Miaohe Lin (1):
      mm/mlock: fix potential imbalanced rlimit ucounts adjustment

Muchun Song (4):
      mm: fix missing cache flush for all tail pages of compound page
      mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
      mm: shmem: fix missing cache flush in shmem_mfill_atomic_pte()
      mm: userfaultfd: fix missing cache flush in mcopy_atomic_pte() and __mcopy_atomic()

Naoya Horiguchi (1):
      mm/hwpoison: fix error page recovered but reported "not recovered"

Peter Xu (1):
      mm: fix invalid page pointer returned with FOLL_PIN gups

Peter Zijlstra (8):
      x86/lib/atomic64_386_32: Rename things
      x86: Prepare asm files for straight-line-speculation
      x86: Prepare inline-asm for straight-line-speculation
      objtool: Add straight-line-speculation validation
      x86/alternative: Relax text_poke_bp() constraint
      x86: Add straight-line-speculation mitigation
      crypto: x86/poly1305 - Fixup SLS
      objtool: Fix SLS validation for kcov tail-call replacement
---
Makefile                                      |  2 +-
 arch/x86/Kconfig                              | 12 ++++
 arch/x86/Makefile                             |  4 ++
 arch/x86/boot/compressed/efi_thunk_64.S       |  2 +-
 arch/x86/boot/compressed/head_64.S            |  8 +--
 arch/x86/boot/compressed/mem_encrypt.S        |  6 +-
 arch/x86/crypto/aegis128-aesni-asm.S          | 48 +++++++--------
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S       |  2 +-
 arch/x86/crypto/aesni-intel_asm.S             | 56 ++++++++---------
 arch/x86/crypto/aesni-intel_avx-x86_64.S      | 40 ++++++-------
 arch/x86/crypto/blake2s-core.S                |  4 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S      | 12 ++--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S   | 14 ++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S  | 14 ++---
 arch/x86/crypto/camellia-x86_64-asm_64.S      | 12 ++--
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S     | 12 ++--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S     | 10 ++--
 arch/x86/crypto/chacha-avx2-x86_64.S          |  6 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S      |  6 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S         |  8 +--
 arch/x86/crypto/crc32-pclmul_asm.S            |  2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S     |  2 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S        |  2 +-
 arch/x86/crypto/des3_ede-asm_64.S             |  4 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S     |  6 +-
 arch/x86/crypto/nh-avx2-x86_64.S              |  2 +-
 arch/x86/crypto/nh-sse2-x86_64.S              |  2 +-
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl | 38 ++++++------
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S   | 10 ++--
 arch/x86/crypto/serpent-avx2-asm_64.S         | 10 ++--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S    |  6 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S  |  6 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S        |  2 +-
 arch/x86/crypto/sha1_ni_asm.S                 |  2 +-
 arch/x86/crypto/sha1_ssse3_asm.S              |  2 +-
 arch/x86/crypto/sha256-avx-asm.S              |  2 +-
 arch/x86/crypto/sha256-avx2-asm.S             |  2 +-
 arch/x86/crypto/sha256-ssse3-asm.S            |  2 +-
 arch/x86/crypto/sha256_ni_asm.S               |  2 +-
 arch/x86/crypto/sha512-avx-asm.S              |  2 +-
 arch/x86/crypto/sha512-avx2-asm.S             |  2 +-
 arch/x86/crypto/sha512-ssse3-asm.S            |  2 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S        | 12 ++--
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S       |  8 +--
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S   | 10 ++--
 arch/x86/crypto/twofish-i586-asm_32.S         |  4 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S  |  6 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S       |  4 +-
 arch/x86/entry/entry_32.S                     |  2 +-
 arch/x86/entry/entry_64.S                     | 10 ++--
 arch/x86/entry/thunk_32.S                     |  2 +-
 arch/x86/entry/thunk_64.S                     |  2 +-
 arch/x86/entry/vdso/vdso32/system_call.S      |  2 +-
 arch/x86/entry/vdso/vsgx.S                    |  2 +-
 arch/x86/entry/vsyscall/vsyscall_emu_64.S     |  6 +-
 arch/x86/include/asm/linkage.h                | 14 +++++
 arch/x86/include/asm/paravirt.h               |  2 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |  4 +-
 arch/x86/include/asm/static_call.h            |  2 +-
 arch/x86/kernel/acpi/wakeup_32.S              |  6 +-
 arch/x86/kernel/alternative.c                 | 51 +++++++++++-----
 arch/x86/kernel/ftrace.c                      |  2 +-
 arch/x86/kernel/ftrace_32.S                   |  6 +-
 arch/x86/kernel/ftrace_64.S                   | 10 ++--
 arch/x86/kernel/head_32.S                     |  2 +-
 arch/x86/kernel/irqflags.S                    |  2 +-
 arch/x86/kernel/kprobes/core.c                |  2 +-
 arch/x86/kernel/paravirt.c                    |  2 +-
 arch/x86/kernel/relocate_kernel_32.S          | 10 ++--
 arch/x86/kernel/relocate_kernel_64.S          | 10 ++--
 arch/x86/kernel/sev_verify_cbit.S             |  2 +-
 arch/x86/kernel/static_call.c                 |  5 +-
 arch/x86/kernel/verify_cpu.S                  |  4 +-
 arch/x86/kvm/emulate.c                        | 23 +++++--
 arch/x86/kvm/svm/vmenter.S                    |  4 +-
 arch/x86/kvm/vmx/vmenter.S                    | 14 ++---
 arch/x86/lib/atomic64_386_32.S                | 86 +++++++++++++++------------
 arch/x86/lib/atomic64_cx8_32.S                | 16 ++---
 arch/x86/lib/checksum_32.S                    |  8 +--
 arch/x86/lib/clear_page_64.S                  |  6 +-
 arch/x86/lib/cmpxchg16b_emu.S                 |  4 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |  4 +-
 arch/x86/lib/copy_mc_64.S                     |  6 +-
 arch/x86/lib/copy_page_64.S                   |  4 +-
 arch/x86/lib/copy_user_64.S                   | 12 ++--
 arch/x86/lib/csum-copy_64.S                   |  2 +-
 arch/x86/lib/error-inject.c                   |  3 +-
 arch/x86/lib/getuser.S                        | 22 +++----
 arch/x86/lib/hweight.S                        |  6 +-
 arch/x86/lib/iomap_copy_64.S                  |  2 +-
 arch/x86/lib/memcpy_64.S                      | 12 ++--
 arch/x86/lib/memmove_64.S                     |  4 +-
 arch/x86/lib/memset_64.S                      |  6 +-
 arch/x86/lib/msr-reg.S                        |  4 +-
 arch/x86/lib/putuser.S                        |  6 +-
 arch/x86/lib/retpoline.S                      |  4 +-
 arch/x86/math-emu/div_Xsig.S                  |  2 +-
 arch/x86/math-emu/div_small.S                 |  2 +-
 arch/x86/math-emu/mul_Xsig.S                  |  6 +-
 arch/x86/math-emu/polynom_Xsig.S              |  2 +-
 arch/x86/math-emu/reg_norm.S                  |  6 +-
 arch/x86/math-emu/reg_round.S                 |  2 +-
 arch/x86/math-emu/reg_u_add.S                 |  2 +-
 arch/x86/math-emu/reg_u_div.S                 |  2 +-
 arch/x86/math-emu/reg_u_mul.S                 |  2 +-
 arch/x86/math-emu/reg_u_sub.S                 |  2 +-
 arch/x86/math-emu/round_Xsig.S                |  4 +-
 arch/x86/math-emu/shr_Xsig.S                  |  8 +--
 arch/x86/math-emu/wm_shrx.S                   | 16 ++---
 arch/x86/mm/mem_encrypt_boot.S                |  4 +-
 arch/x86/platform/efi/efi_stub_32.S           |  2 +-
 arch/x86/platform/efi/efi_stub_64.S           |  2 +-
 arch/x86/platform/efi/efi_thunk_64.S          |  2 +-
 arch/x86/platform/olpc/xo1-wakeup.S           |  6 +-
 arch/x86/power/hibernate_asm_32.S             |  4 +-
 arch/x86/power/hibernate_asm_64.S             |  4 +-
 arch/x86/um/checksum_32.S                     |  4 +-
 arch/x86/um/setjmp_32.S                       |  2 +-
 arch/x86/um/setjmp_64.S                       |  2 +-
 arch/x86/xen/xen-asm.S                        | 12 ++--
 arch/x86/xen/xen-head.S                       |  2 +-
 fs/udf/namei.c                                |  8 +--
 include/net/bluetooth/hci_core.h              |  3 +
 include/uapi/linux/rfkill.h                   |  2 +-
 localversion-rt                               |  2 +-
 mm/gup.c                                      |  2 +-
 mm/memory-failure.c                           |  4 +-
 mm/memory.c                                   |  2 +
 mm/migrate.c                                  |  7 ++-
 mm/mlock.c                                    |  1 +
 mm/shmem.c                                    |  4 +-
 mm/userfaultfd.c                              |  3 +
 net/bluetooth/hci_core.c                      |  6 +-
 samples/ftrace/ftrace-direct-modify.c         |  4 +-
 samples/ftrace/ftrace-direct-too.c            |  2 +-
 samples/ftrace/ftrace-direct.c                |  2 +-
 scripts/Makefile.build                        | 11 ++++
 scripts/Makefile.lib                          | 11 ----
 scripts/link-vmlinux.sh                       |  3 +
 tools/arch/x86/lib/memcpy_64.S                | 12 ++--
 tools/arch/x86/lib/memset_64.S                |  6 +-
 tools/objtool/arch/x86/decode.c               | 13 ++--
 tools/objtool/builtin-check.c                 |  3 +-
 tools/objtool/check.c                         | 24 ++++++++
 tools/objtool/include/objtool/arch.h          |  1 +
 tools/objtool/include/objtool/builtin.h       |  2 +-
 146 files changed, 608 insertions(+), 484 deletions(-)
---
