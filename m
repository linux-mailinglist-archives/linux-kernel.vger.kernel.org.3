Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1ED4E2EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351711AbiCURPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiCURPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:15:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA31EEE0;
        Mon, 21 Mar 2022 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647882810;
        bh=514yCqBt9YIkWc17kdwF2tfB3GhQiz/IBxYH5kyKNho=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=CBSakBpgwHkh/n0km3I3JnCuh0tP46aYfGS8586beG1Tn3HVZAlgb8rvlyJOsGdXx
         KBAHQD8nC6Wm1FsLvGWJ53xBj2/IDjhgbwrQmTbEwQVNjg4wFuW7iD1/ABuDVmGDdZ
         BUMV4/uQ2tYmOaroZgwXt3JYCb9luSI8TLatw75M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.171.242]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1oF49J3CBX-010gE5; Mon, 21
 Mar 2022 18:13:30 +0100
Date:   Mon, 21 Mar 2022 18:13:28 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture updates for v5.18-rc1
Message-ID: <YjiyOIc71r53GME+@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:ctT6yXFmvgp8eSc8nDMezAyMb5yxgAH4RoS2eNeumiq0VNJE3Tf
 bRuiWwhtdt+D79Mh5AoX2rCMJTNm0spf0Df71D/LN8P4xhAD7cdYurf1iQpFq2GYj3RaB1n
 4SYaOvLOtpVCJEYsWPrZk0ajoDA3fQnPT+xcYZLf7q7uJ7dz5lM3upbhAT/wTPTZO5oVGbR
 CfrO8NiZ8bWDnCzRez+bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:875aeV5KhRE=:5VpYrkf2WQlSrmYIJMK4Kw
 bU9EFfEw+OOAEOWGpe3IIfDQMLHTl6NX/s6i8vc5+09pLLnbSnUviwqpnKQXuYzj3wwcCG76D
 Iwhgd5/EAh9xH9bwgqtXruJu9p8Ql+XEcfRE8LOJshRk5k/UnfPtp0zt+X1MTTsY0ySZSRWzP
 ea3NVvfOiRcPe6JWPXSvayCBfhXyajEMdywM2/cXfPX5zxs1GpfoBgCrMHMsz6My4y1m44LOq
 7k0KfvGQKzmPjIHKPxQnTgeVc8D2SBT187r+RQfbRqVQ8ukDkIxX/ebkKnho4Xfj7ovYmmXrc
 VqXdwN0PCTxN9HHJfcfAqXQxQTI/7dAhJcmo5gpe5xR0QbQREy5mOGVIDZdGdlstxSUimlg4r
 oLfPQaNjBJsM/fYa5SfsGCTGAwLNOGU9RoNenNp0p8o0lBr/NypGQepd+xuW1Yr+pLwYVnyY4
 g3GIEnZGv1pOBbGSrmeuv6G3Kn//idbrjdX1Qlm1TW55SvE21kQmhVP1c6x6mo8RJ6M7uDUQj
 qMPb+uw/b/cGQx/fVJUc9PyiSc5nRrquwthh3vMw+6Z2KO0mMYt+GeeKn7Ytmv5UbmqGo6rZv
 3rxokL0/wnlvVAdL/IcgNbIj3zTmrrFQ8Gahs+LJAsYcsjlRf7EYmonix/dhheCNNV5PpqJze
 VclNom8Scx1Y6h84h0e7ZxPMMKPSWUjqCFsBlkY+Tiwd6eLUq7pfSfu2FqVMXZpIA5mvqphIU
 iLu/xZlPZ14XPBbIy/Dlgu+5DUA4CIFlzDBb8KWgqJH5aCQflDA+wQnpHuuw3QEjSX8BYH9DF
 ZteALXkh7PXoei5Wm1vvI62dz/nZ8xsyBrKJPZfp+WdRTzCmWvnReL1Y0DBTCmG/YnUj8V0bN
 yehdXfYZV7gWcTT9ZQvwaGS1Gvp3hQY4l3t95VoN5r0mE2W2goHWL0I2piN1KwaJVCqcvjIlf
 W7y0dBRZhJSBcERwR5ulwTsDc9dgSVNj5HZaEdp4Zm87tkWVlplEKSRiFpgSMNdKH3N+0MBuh
 LqspHigK/qoZe/r0jwA7qUaMNLHBbS2DrkblxssIJ5ugPkh2OnY6NM29nVD/Fuf7Mg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-1

for you to fetch changes up to 53d862fac4a09b9c56cca0433fa9de5732fd05a1:

  parisc: Fix invalidate/flush vmap routines (2022-03-21 13:30:54 +0100)

----------------------------------------------------------------
parisc architecture updates for kernel v5.18-rc1

- add vDSO support (allows us to use read-only stacks)
- many TLB and cache flush optimizations (by Dave Anglin)
- fix handling of probe non-access faults (by Dave Anglin)
- fix invalidate/flush vmap routines (by Dave Anglin)
- avoid using hardware single-step in kprobes
- enable ARCH_HAS_DEBUG_VM_PGTABLE
- many cleanups in unaligned handlers, e.g. rewrite of existing assembly code
- always use the self-extracting kernel feature
- big refacturing and code reductions regarding space-register usage in get_user() and put_user()
- add fillrect() support to stifb graphics driver

----------------------------------------------------------------
Helge Deller (18):
      parisc: Add vDSO support
      video/fbdev/stifb: Implement the stifb_fillrect() function
      parisc: Always use the self-extracting kernel feature
      parisc: Add defines for various space register
      parisc: Use SR_USER and SR_KERNEL in get_user() and put_user()
      parisc: Use constants to encode the space registers like SR_KERNEL
      parisc: Reduce code size by optimizing get_current() function calls
      parisc/unaligned: Use EFAULT fixup handler in unaligned handlers
      parisc/unaligned: Rewrite inline assembly of emulate_ldh()
      parisc/unaligned: Rewrite inline assembly of emulate_ldw()
      parisc/unaligned: Rewrite 32-bit inline assembly of emulate_ldd()
      parisc/unaligned: Rewrite 32-bit inline assembly of emulate_sth()
      parisc/unaligned: Enhance user-space visible output
      parisc: Avoid calling SMP cache flush functions on cache-less machines
      parisc: Enable ARCH_HAS_DEBUG_VM_PGTABLE
      parisc: Improve CPU socket and core bootup info text
      parisc: Avoid using hardware single-step in kprobes
      parisc: Avoid flushing cache on cache-less machines

John David Anglin (5):
      parisc: Fix non-access data TLB cache flush faults
      parisc: Fix handling off probe non-access faults
      parisc: Simplify fast path for non-access data TLB faults
      parisc: Increase parisc_cache_flush_threshold setting
      parisc: Fix invalidate/flush vmap routines

 arch/parisc/Kconfig                           |  14 +-
 arch/parisc/Makefile                          |  37 +++-
 arch/parisc/include/asm/assembly.h            |   6 +
 arch/parisc/include/asm/cache.h               |  11 +-
 arch/parisc/include/asm/cacheflush.h          |  15 +-
 arch/parisc/include/asm/current.h             |   8 +-
 arch/parisc/include/asm/elf.h                 |  15 ++
 arch/parisc/include/asm/kprobes.h             |   5 +-
 arch/parisc/include/asm/mmu.h                 |   6 +-
 arch/parisc/include/asm/mmu_context.h         |  16 +-
 arch/parisc/include/asm/pgtable.h             |  11 +-
 arch/parisc/include/asm/processor.h           |   2 +-
 arch/parisc/include/asm/rt_sigframe.h         |  10 +-
 arch/parisc/include/asm/special_insns.h       |   4 +-
 arch/parisc/include/asm/tlbflush.h            |   2 +-
 arch/parisc/include/asm/traps.h               |   1 +
 arch/parisc/include/asm/uaccess.h             |  28 +--
 arch/parisc/include/asm/unistd.h              |   4 -
 arch/parisc/include/asm/vdso.h                |  24 +++
 arch/parisc/include/uapi/asm/auxvec.h         |   8 +
 arch/parisc/kernel/Makefile                   |   5 +
 arch/parisc/kernel/alternative.c              |  10 +
 arch/parisc/kernel/asm-offsets.c              |   9 +
 arch/parisc/kernel/cache.c                    | 137 +++++++-------
 arch/parisc/kernel/entry.S                    |  72 +-------
 arch/parisc/kernel/kprobes.c                  |  28 +--
 arch/parisc/kernel/pci-dma.c                  |   4 +-
 arch/parisc/kernel/signal.c                   | 225 +++++++++++-----------
 arch/parisc/kernel/signal32.h                 |  19 +-
 arch/parisc/kernel/topology.c                 |   4 +-
 arch/parisc/kernel/traps.c                    |  12 +-
 arch/parisc/kernel/unaligned.c                | 257 ++++++++++----------------
 arch/parisc/kernel/vdso.c                     | 122 ++++++++++++
 arch/parisc/kernel/vdso32/Makefile            |  53 ++++++
 arch/parisc/kernel/vdso32/gen_vdso_offsets.sh |  15 ++
 arch/parisc/kernel/vdso32/note.S              |  26 +++
 arch/parisc/kernel/vdso32/restart_syscall.S   |  32 ++++
 arch/parisc/kernel/vdso32/sigtramp.S          | 195 +++++++++++++++++++
 arch/parisc/kernel/vdso32/vdso32.lds.S        | 111 +++++++++++
 arch/parisc/kernel/vdso32/vdso32_wrapper.S    |  14 ++
 arch/parisc/kernel/vdso64/Makefile            |  48 +++++
 arch/parisc/kernel/vdso64/gen_vdso_offsets.sh |  15 ++
 arch/parisc/kernel/vdso64/note.S              |   2 +
 arch/parisc/kernel/vdso64/restart_syscall.S   |   3 +
 arch/parisc/kernel/vdso64/sigtramp.S          | 166 +++++++++++++++++
 arch/parisc/kernel/vdso64/vdso64.lds.S        | 109 +++++++++++
 arch/parisc/kernel/vdso64/vdso64_wrapper.S    |  14 ++
 arch/parisc/lib/memcpy.c                      |  16 +-
 arch/parisc/mm/fault.c                        |  89 +++++++++
 drivers/video/fbdev/stifb.c                   |  45 ++++-
 50 files changed, 1534 insertions(+), 550 deletions(-)
 create mode 100644 arch/parisc/include/asm/vdso.h
 create mode 100644 arch/parisc/include/uapi/asm/auxvec.h
 create mode 100644 arch/parisc/kernel/vdso.c
 create mode 100644 arch/parisc/kernel/vdso32/Makefile
 create mode 100755 arch/parisc/kernel/vdso32/gen_vdso_offsets.sh
 create mode 100644 arch/parisc/kernel/vdso32/note.S
 create mode 100644 arch/parisc/kernel/vdso32/restart_syscall.S
 create mode 100644 arch/parisc/kernel/vdso32/sigtramp.S
 create mode 100644 arch/parisc/kernel/vdso32/vdso32.lds.S
 create mode 100644 arch/parisc/kernel/vdso32/vdso32_wrapper.S
 create mode 100644 arch/parisc/kernel/vdso64/Makefile
 create mode 100755 arch/parisc/kernel/vdso64/gen_vdso_offsets.sh
 create mode 100644 arch/parisc/kernel/vdso64/note.S
 create mode 100644 arch/parisc/kernel/vdso64/restart_syscall.S
 create mode 100644 arch/parisc/kernel/vdso64/sigtramp.S
 create mode 100644 arch/parisc/kernel/vdso64/vdso64.lds.S
 create mode 100644 arch/parisc/kernel/vdso64/vdso64_wrapper.S
