Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6CD58B496
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHFIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHFIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:34:34 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C646EE0C;
        Sat,  6 Aug 2022 01:34:32 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oKFGR-0004hW-00; Sat, 06 Aug 2022 10:34:31 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5B07AC01C5; Sat,  6 Aug 2022 10:34:23 +0200 (CEST)
Date:   Sat, 6 Aug 2022 10:34:23 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.0-rc1
Message-ID: <20220806083423.GA3635@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.0

for you to fetch changes up to 74de14fe05dd6b151d73cb0c73c8ec874cbdcde6:

  MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0 (2022-08-04 15:57:32 +0200)

----------------------------------------------------------------
added support for Netgear WNR3500L v2
removed support for VR41xx SoC and platforms based on it
cleanups and fixes

----------------------------------------------------------------
Alexander Sverdlin (2):
      MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
      Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"

Alexandre Belloni (1):
      MIPS: mscc: ocelot: enable FDMA usage

Christophe JAILLET (2):
      MIPS: math-emu: Use the bitmap API to allocate bitmaps
      MIPS: mm: Use the bitmap API to allocate bitmaps

Colin Ian King (1):
      MIPS: PCI: Remove leading space in info message, rename pci

Florian Fainelli (6):
      MIPS: vdso: Utilize __pa() for gic_pfn
      MIPS: Make phys_to_virt utilize __va()
      MIPS: BCM47XX: Add support for Netgear WNR3500L v2
      MIPS: Fixed __debug_virt_addr_valid()
      MIPS: CFE: Add cfe_die()
      MIPS: BMIPS: Utilize cfe_die() for invalid DTB

Huacai Chen (1):
      MIPS: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Jason Wang (1):
      MIPS: Fix comment typo

Jiang Jian (1):
      MIPS: Alchemy: devboards: Remove duplicate 'the' in two places.

Krzysztof Kozlowski (2):
      MIPS: dts: correct gpio-keys names and properties
      MIPS: dts: align gpio-key node names with dtschema

Liang He (1):
      mips: cavium-octeon: Fix missing of_node_put() in octeon2_usb_clocks_start

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/mips to MIPS

Nathan Chancellor (1):
      MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0

Randy Dunlap (1):
      MIPS: msi-octeon: eliminate kernel-doc warnings

Thomas Bogendoerfer (1):
      MIPS: Remove VR41xx support

Tiezhu Yang (1):
      MIPS: Loongson64: Fix section mismatch warning

Uwe Kleine-König (1):
      mips: sgi-ip22: Drop redundant check from .remove()

Zhang Jiaming (1):
      MIPS: Fix some typos

 MAINTAINERS                                        |   1 +
 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  24 +-
 arch/mips/Makefile                                 |   1 -
 arch/mips/alchemy/devboards/pm.c                   |   2 +-
 arch/mips/bcm47xx/board.c                          |   2 +
 arch/mips/bcm47xx/buttons.c                        |  10 +
 arch/mips/bcm47xx/leds.c                           |  11 +
 arch/mips/bcm47xx/prom.c                           |   2 +-
 arch/mips/bcm47xx/workarounds.c                    |   1 +
 arch/mips/bmips/setup.c                            |  14 +-
 arch/mips/boot/dts/img/pistachio_marduk.dts        |   4 +-
 arch/mips/boot/dts/ingenic/ci20.dts                |   2 +-
 arch/mips/boot/dts/ingenic/gcw0.dts                |  31 +-
 arch/mips/boot/dts/ingenic/rs90.dts                |  18 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                |   9 +-
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts          |   9 +-
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |   6 +-
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts       |   4 +-
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts     |   6 +-
 arch/mips/boot/dts/qca/ar9331_omega.dts            |   4 +-
 .../dts/qca/ar9331_openembed_som9331_board.dts     |   4 +-
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts        |   8 +-
 .../dts/ralink/gardena_smart_gateway_mt7688.dts    |   2 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts |   2 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts |   2 +-
 arch/mips/cavium-octeon/Kconfig                    |  12 +
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  21 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |   4 +-
 arch/mips/cavium-octeon/octeon-platform.c          |   3 +-
 arch/mips/cavium-octeon/setup.c                    |  38 +-
 arch/mips/configs/capcella_defconfig               |  91 ---
 arch/mips/configs/e55_defconfig                    |  37 --
 arch/mips/configs/mpc30x_defconfig                 |  53 --
 arch/mips/configs/tb0219_defconfig                 |  76 ---
 arch/mips/configs/tb0226_defconfig                 |  71 --
 arch/mips/configs/tb0287_defconfig                 |  84 ---
 arch/mips/configs/workpad_defconfig                |  67 --
 arch/mips/fw/cfe/cfe_api.c                         |  68 +-
 arch/mips/include/asm/cpu-type.h                   |  11 -
 arch/mips/include/asm/cpu.h                        |   3 +-
 arch/mips/include/asm/fw/cfe/cfe_api.h             |   2 +
 arch/mips/include/asm/io.h                         |   2 +-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |   1 +
 arch/mips/include/asm/mach-vr41xx/irq.h            |   9 -
 arch/mips/include/asm/mipsregs.h                   |  14 -
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  12 +-
 arch/mips/include/asm/pgtable-32.h                 |   5 -
 arch/mips/include/asm/pgtable-64.h                 |   5 -
 arch/mips/include/asm/vermagic.h                   |   2 -
 arch/mips/include/asm/vr41xx/capcella.h            |  30 -
 arch/mips/include/asm/vr41xx/giu.h                 |  41 --
 arch/mips/include/asm/vr41xx/irq.h                 |  97 ---
 arch/mips/include/asm/vr41xx/mpc30x.h              |  24 -
 arch/mips/include/asm/vr41xx/pci.h                 |  77 ---
 arch/mips/include/asm/vr41xx/siu.h                 |  45 --
 arch/mips/include/asm/vr41xx/tb0219.h              |  29 -
 arch/mips/include/asm/vr41xx/tb0226.h              |  30 -
 arch/mips/include/asm/vr41xx/tb0287.h              |  30 -
 arch/mips/include/asm/vr41xx/vr41xx.h              | 148 -----
 arch/mips/kernel/cpu-probe.c                       |  40 --
 arch/mips/kernel/proc.c                            |   2 +-
 arch/mips/kernel/vdso.c                            |   2 +-
 arch/mips/lib/dump_tlb.c                           |   8 -
 arch/mips/loongson64/numa.c                        |   1 -
 arch/mips/math-emu/dsemul.c                        |   9 +-
 arch/mips/mm/c-r4k.c                               |  44 --
 arch/mips/mm/context.c                             |   5 +-
 arch/mips/mm/physaddr.c                            |  14 +-
 arch/mips/mm/tlbex.c                               |  39 +-
 arch/mips/pci/Makefile                             |   6 -
 arch/mips/pci/fixup-capcella.c                     |  37 --
 arch/mips/pci/fixup-lemote2f.c                     |   2 +-
 arch/mips/pci/fixup-mpc30x.c                       |  36 --
 arch/mips/pci/fixup-tb0219.c                       |  38 --
 arch/mips/pci/fixup-tb0226.c                       |  73 ---
 arch/mips/pci/fixup-tb0287.c                       |  52 --
 arch/mips/pci/msi-octeon.c                         |  16 +-
 arch/mips/pci/ops-vr41xx.c                         | 113 ----
 arch/mips/pci/pci-vr41xx.c                         | 309 ---------
 arch/mips/pci/pci-vr41xx.h                         | 141 ----
 arch/mips/sgi-ip22/ip22-gio.c                      |   2 +-
 arch/mips/vr41xx/Kconfig                           | 104 ---
 arch/mips/vr41xx/Makefile                          |   5 -
 arch/mips/vr41xx/Platform                          |  29 -
 arch/mips/vr41xx/casio-e55/Makefile                |   6 -
 arch/mips/vr41xx/casio-e55/setup.c                 |  27 -
 arch/mips/vr41xx/common/Makefile                   |   6 -
 arch/mips/vr41xx/common/bcu.c                      | 210 ------
 arch/mips/vr41xx/common/cmu.c                      | 242 -------
 arch/mips/vr41xx/common/giu.c                      | 110 ----
 arch/mips/vr41xx/common/icu.c                      | 714 ---------------------
 arch/mips/vr41xx/common/init.c                     |  60 --
 arch/mips/vr41xx/common/irq.c                      | 106 ---
 arch/mips/vr41xx/common/pmu.c                      | 123 ----
 arch/mips/vr41xx/common/rtc.c                      | 105 ---
 arch/mips/vr41xx/common/siu.c                      | 142 ----
 arch/mips/vr41xx/common/type.c                     |  11 -
 arch/mips/vr41xx/ibm-workpad/Makefile              |   6 -
 arch/mips/vr41xx/ibm-workpad/setup.c               |  27 -
 100 files changed, 259 insertions(+), 4185 deletions(-)
 delete mode 100644 arch/mips/configs/capcella_defconfig
 delete mode 100644 arch/mips/configs/e55_defconfig
 delete mode 100644 arch/mips/configs/mpc30x_defconfig
 delete mode 100644 arch/mips/configs/tb0219_defconfig
 delete mode 100644 arch/mips/configs/tb0226_defconfig
 delete mode 100644 arch/mips/configs/tb0287_defconfig
 delete mode 100644 arch/mips/configs/workpad_defconfig
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/irq.h
 delete mode 100644 arch/mips/include/asm/vr41xx/capcella.h
 delete mode 100644 arch/mips/include/asm/vr41xx/giu.h
 delete mode 100644 arch/mips/include/asm/vr41xx/irq.h
 delete mode 100644 arch/mips/include/asm/vr41xx/mpc30x.h
 delete mode 100644 arch/mips/include/asm/vr41xx/pci.h
 delete mode 100644 arch/mips/include/asm/vr41xx/siu.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0219.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0226.h
 delete mode 100644 arch/mips/include/asm/vr41xx/tb0287.h
 delete mode 100644 arch/mips/include/asm/vr41xx/vr41xx.h
 delete mode 100644 arch/mips/pci/fixup-capcella.c
 delete mode 100644 arch/mips/pci/fixup-mpc30x.c
 delete mode 100644 arch/mips/pci/fixup-tb0219.c
 delete mode 100644 arch/mips/pci/fixup-tb0226.c
 delete mode 100644 arch/mips/pci/fixup-tb0287.c
 delete mode 100644 arch/mips/pci/ops-vr41xx.c
 delete mode 100644 arch/mips/pci/pci-vr41xx.c
 delete mode 100644 arch/mips/pci/pci-vr41xx.h
 delete mode 100644 arch/mips/vr41xx/Kconfig
 delete mode 100644 arch/mips/vr41xx/Makefile
 delete mode 100644 arch/mips/vr41xx/Platform
 delete mode 100644 arch/mips/vr41xx/casio-e55/Makefile
 delete mode 100644 arch/mips/vr41xx/casio-e55/setup.c
 delete mode 100644 arch/mips/vr41xx/common/Makefile
 delete mode 100644 arch/mips/vr41xx/common/bcu.c
 delete mode 100644 arch/mips/vr41xx/common/cmu.c
 delete mode 100644 arch/mips/vr41xx/common/giu.c
 delete mode 100644 arch/mips/vr41xx/common/icu.c
 delete mode 100644 arch/mips/vr41xx/common/init.c
 delete mode 100644 arch/mips/vr41xx/common/irq.c
 delete mode 100644 arch/mips/vr41xx/common/pmu.c
 delete mode 100644 arch/mips/vr41xx/common/rtc.c
 delete mode 100644 arch/mips/vr41xx/common/siu.c
 delete mode 100644 arch/mips/vr41xx/common/type.c
 delete mode 100644 arch/mips/vr41xx/ibm-workpad/Makefile
 delete mode 100644 arch/mips/vr41xx/ibm-workpad/setup.c
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
