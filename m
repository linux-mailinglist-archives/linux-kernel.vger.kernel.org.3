Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8224E755F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359410AbiCYOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359411AbiCYOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:48:57 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6A3D95E8;
        Fri, 25 Mar 2022 07:47:21 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nXlDj-0003ZS-00; Fri, 25 Mar 2022 15:47:19 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CDE67C2ECE; Fri, 25 Mar 2022 15:47:06 +0100 (CET)
Date:   Fri, 25 Mar 2022 15:47:06 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v5.18
Message-ID: <20220325144706.GA9428@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18

for you to fetch changes up to f8f9f21c7848e63133c16c899f3d84aa54eb79fe:

  MIPS: Fix build error for loongson64 and sgi-ip27 (2022-03-24 09:45:15 +0100)

----------------------------------------------------------------
- added support for QCN550x (ath79)
- enabled KCSAN
- removed TX39XX support
- various cleanups and fixes

----------------------------------------------------------------
Alexander Lobakin (1):
      MIPS: fix fortify panic when copying asm exception handlers

Feiyang Chen (1):
      MIPS: Fix build error for loongson64 and sgi-ip27

Hangyu Hua (1):
      mips: ralink: fix a refcount leak in ill_acc_of_setup()

Kees Cook (4):
      MIPS: Modernize READ_IMPLIES_EXEC
      mips: Implement "current_stack_pointer"
      MIPS: boot/compressed: Use array reference for image bounds
      MIPS: Only use current_stack_pointer on GCC

Krzysztof Kozlowski (1):
      MIPS: ingenic: correct unit node address

Maciej W. Rozycki (2):
      DEC: Limit PMAX memory probing to R3k systems
      MIPS: Sanitise Cavium switch cases in TLB handler synthesizers

Miaoqian Lin (1):
      mips: cdmm: Fix refcount leak in mips_cdmm_phys_base

Nathan Chancellor (3):
      MIPS: Loongson64: Clean up use of cc-ifversion
      MIPS: Loongson{2ef,64}: Wrap -mno-branch-likely with cc-option
      MIPS: Malta: Enable BLK_DEV_INITRD

Nemanja Rakovic (2):
      mips: Enable KCSAN
      mips: Enable KCSAN

Paul Cercueil (1):
      mips: Always permit to build u-boot images

Randy Dunlap (2):
      mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
      MIPS: RB532: fix return value of __setup handler

Rikard Falkeborn (3):
      MIPS: OCTEON: Constify static irq_domain_ops
      MIPS: ath25: Constify static irq_domain_ops
      MIPS: pci-ar2315: Constify static irq_domain_ops

Thomas Bogendoerfer (3):
      MIPS: remove asm/war.h
      MIPS: sibyte: Add missing __user annotations in sb_tbprof.c
      MIPS: Remove TX39XX support

Tiezhu Yang (3):
      MIPS: Remove redundant check in device_tree_init()
      MIPS: Remove redundant definitions of device_tree_init()
      MIPS: Fix wrong comments in asm/prom.h

Wenli Looi (1):
      MIPS: ath79: add support for QCN550x

Xi Ruoyao (1):
      mips: remove reference to "newer Loongson-3"

Yaliang Wang (1):
      MIPS: pgalloc: fix memory leak caused by pgd_free()

 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  82 ++--
 arch/mips/Makefile                                 |   5 -
 arch/mips/ath25/ar2315.c                           |   2 +-
 arch/mips/ath25/ar5312.c                           |   2 +-
 arch/mips/ath79/early_printk.c                     |   1 +
 arch/mips/ath79/setup.c                            |  11 +-
 arch/mips/boot/compressed/Makefile                 |   1 +
 arch/mips/boot/compressed/decompress.c             |  10 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |  10 +-
 arch/mips/configs/jmr3927_defconfig                |  50 ---
 arch/mips/configs/malta_defconfig                  |   1 +
 arch/mips/dec/int-handler.S                        |   6 +-
 arch/mips/dec/prom/Makefile                        |   2 +-
 arch/mips/dec/setup.c                              |   3 +-
 arch/mips/include/asm/cpu-features.h               |   3 -
 arch/mips/include/asm/cpu-type.h                   |   6 -
 arch/mips/include/asm/cpu.h                        |   6 -
 arch/mips/include/asm/dec/prom.h                   |  15 +-
 arch/mips/include/asm/futex.h                      |   1 -
 arch/mips/include/asm/isadep.h                     |   2 +-
 .../include/asm/mach-ath25/cpu-feature-overrides.h |   1 -
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   1 +
 .../include/asm/mach-ath79/cpu-feature-overrides.h |   1 -
 .../asm/mach-au1x00/cpu-feature-overrides.h        |   1 -
 .../asm/mach-bcm47xx/cpu-feature-overrides.h       |   1 -
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   1 -
 .../asm/mach-cobalt/cpu-feature-overrides.h        |   1 -
 .../include/asm/mach-dec/cpu-feature-overrides.h   |   1 -
 .../asm/mach-ingenic/cpu-feature-overrides.h       |   1 -
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   1 -
 .../include/asm/mach-ip30/cpu-feature-overrides.h  |   1 -
 .../asm/mach-lantiq/falcon/cpu-feature-overrides.h |   1 -
 .../asm/mach-loongson2ef/cpu-feature-overrides.h   |   1 -
 .../asm/mach-loongson64/cpu-feature-overrides.h    |   1 -
 .../asm/mach-ralink/mt7620/cpu-feature-overrides.h |   1 -
 .../asm/mach-ralink/mt7621/cpu-feature-overrides.h |   1 -
 .../asm/mach-ralink/rt288x/cpu-feature-overrides.h |   1 -
 .../asm/mach-ralink/rt305x/cpu-feature-overrides.h |   1 -
 .../asm/mach-ralink/rt3883/cpu-feature-overrides.h |   1 -
 .../asm/mach-rc32434/cpu-feature-overrides.h       |   1 -
 arch/mips/include/asm/mach-tx39xx/ioremap.h        |  25 --
 arch/mips/include/asm/mach-tx39xx/mangle-port.h    |  24 --
 arch/mips/include/asm/mach-tx39xx/spaces.h         |  17 -
 arch/mips/include/asm/mipsmtregs.h                 |   1 -
 arch/mips/include/asm/mipsregs.h                   |   1 -
 arch/mips/include/asm/pgalloc.h                    |   6 +
 arch/mips/include/asm/prom.h                       |   4 +-
 arch/mips/include/asm/setup.h                      |   2 +-
 arch/mips/include/asm/stackframe.h                 |   6 +-
 arch/mips/include/asm/thread_info.h                |   4 +
 arch/mips/include/asm/txx9/boards.h                |   3 -
 arch/mips/include/asm/txx9/jmr3927.h               | 179 ---------
 arch/mips/include/asm/txx9/tx3927.h                | 341 -----------------
 arch/mips/include/asm/txx9irq.h                    |   4 -
 arch/mips/include/asm/txx9tmr.h                    |   4 -
 arch/mips/include/asm/vermagic.h                   |   2 -
 arch/mips/include/asm/war.h                        |  73 ----
 arch/mips/kernel/Makefile                          |   1 -
 arch/mips/kernel/cpu-probe.c                       |  23 --
 arch/mips/kernel/cpu-r3k-probe.c                   |  22 --
 arch/mips/kernel/elf.c                             |  16 +-
 arch/mips/kernel/entry.S                           |   3 +-
 arch/mips/kernel/genex.S                           |   5 +-
 arch/mips/kernel/idle.c                            |  10 -
 arch/mips/kernel/irq_txx9.c                        |  13 -
 arch/mips/kernel/proc.c                            |   2 -
 arch/mips/kernel/process.c                         |   2 +-
 arch/mips/kernel/prom.c                            |   5 +
 arch/mips/kernel/r4k-bugs64.c                      |   9 +-
 arch/mips/kernel/scall32-o32.S                     |   1 -
 arch/mips/kernel/scall64-n64.S                     |   1 -
 arch/mips/kernel/signal.c                          |   1 -
 arch/mips/kernel/signal_n32.c                      |   1 -
 arch/mips/kernel/traps.c                           |  22 +-
 arch/mips/lantiq/prom.c                            |   5 -
 arch/mips/lib/Makefile                             |   1 -
 arch/mips/lib/delay.c                              |   1 -
 arch/mips/lib/r3k_dump_tlb.c                       |   4 -
 arch/mips/loongson2ef/Platform                     |   3 +-
 arch/mips/loongson64/Platform                      |  24 +-
 arch/mips/loongson64/numa.c                        |  10 +
 arch/mips/loongson64/setup.c                       |   8 -
 arch/mips/mm/Makefile                              |   1 -
 arch/mips/mm/c-octeon.c                            |   1 -
 arch/mips/mm/c-r4k.c                               |   1 -
 arch/mips/mm/c-tx39.c                              | 414 ---------------------
 arch/mips/mm/cache.c                               |   5 -
 arch/mips/mm/page.c                                |   5 +-
 arch/mips/mm/tlb-r3k.c                             |  40 +-
 arch/mips/mm/tlbex.c                               |  24 +-
 arch/mips/mti-malta/Makefile                       |   1 -
 arch/mips/mti-malta/malta-dt.c                     |  15 -
 arch/mips/pci/Makefile                             |   2 -
 arch/mips/pci/fixup-jmr3927.c                      |  79 ----
 arch/mips/pci/ops-tx3927.c                         | 231 ------------
 arch/mips/pci/pci-ar2315.c                         |   2 +-
 arch/mips/pic32/pic32mzda/init.c                   |   8 -
 arch/mips/ralink/ill_acc.c                         |   1 +
 arch/mips/ralink/of.c                              |   5 -
 arch/mips/rb532/devices.c                          |   6 +-
 arch/mips/sgi-ip27/ip27-memory.c                   |  10 +
 arch/mips/sibyte/common/sb_tbprof.c                |   6 +-
 arch/mips/txx9/Kconfig                             |  18 -
 arch/mips/txx9/Makefile                            |   6 -
 arch/mips/txx9/Platform                            |   3 -
 arch/mips/txx9/generic/Makefile                    |   1 -
 arch/mips/txx9/generic/irq_tx3927.c                |  25 --
 arch/mips/txx9/generic/setup.c                     |  55 ---
 arch/mips/txx9/generic/setup_tx3927.c              | 136 -------
 arch/mips/txx9/jmr3927/Makefile                    |   6 -
 arch/mips/txx9/jmr3927/irq.c                       | 128 -------
 arch/mips/txx9/jmr3927/prom.c                      |  52 ---
 arch/mips/txx9/jmr3927/setup.c                     | 223 -----------
 arch/mips/vdso/Makefile                            |   3 +
 drivers/bus/mips_cdmm.c                            |   1 +
 drivers/dma/Kconfig                                |   2 +-
 drivers/watchdog/Kconfig                           |   2 +-
 119 files changed, 194 insertions(+), 2455 deletions(-)
 delete mode 100644 arch/mips/configs/jmr3927_defconfig
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/ioremap.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/mangle-port.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/spaces.h
 delete mode 100644 arch/mips/include/asm/txx9/jmr3927.h
 delete mode 100644 arch/mips/include/asm/txx9/tx3927.h
 delete mode 100644 arch/mips/include/asm/war.h
 delete mode 100644 arch/mips/mm/c-tx39.c
 delete mode 100644 arch/mips/mti-malta/malta-dt.c
 delete mode 100644 arch/mips/pci/fixup-jmr3927.c
 delete mode 100644 arch/mips/pci/ops-tx3927.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx3927.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx3927.c
 delete mode 100644 arch/mips/txx9/jmr3927/Makefile
 delete mode 100644 arch/mips/txx9/jmr3927/irq.c
 delete mode 100644 arch/mips/txx9/jmr3927/prom.c
 delete mode 100644 arch/mips/txx9/jmr3927/setup.c

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
