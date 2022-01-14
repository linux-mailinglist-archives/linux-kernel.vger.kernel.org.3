Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE548E6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiANIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:39:51 -0500
Received: from elvis.franken.de ([193.175.24.41]:47544 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbiANIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:39:48 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n8I7e-0003a1-01; Fri, 14 Jan 2022 09:39:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 37562C1015; Fri, 14 Jan 2022 09:39:38 +0100 (CET)
Date:   Fri, 14 Jan 2022 09:39:38 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v5.17
Message-ID: <20220114083938.GA4892@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.17

for you to fetch changes up to d3115128bdafb62628ab41861a4f06f6d02ac320:

  MIPS: ath79: drop _machine_restart again (2022-01-11 16:16:52 +0100)

----------------------------------------------------------------
- added support for more BCM47XX based devices
- added MIPS support for brcmstb PCIe controller
- added Loongson 2K1000 reset driver
- removed board support for rbtx4938/rbtx4939
- removed support for TX4939 SoCs
- fixes and cleanups

----------------------------------------------------------------
Florian Fainelli (5):
      MIPS: BCM47XX: Define Linksys WRT310N V2 buttons
      MIPS: BCM47XX: Add board entry for Linksys WRT320N v1
      MIPS: BCM47XX: Add LEDs and buttons for Asus RTN-10U
      MIPS: BCM47XX: Add support for Netgear R6300 v1
      MIPS: BCM47XX: Add support for Netgear WN2500RP v1 & v2

Geert Uytterhoeven (3):
      MIPS: CPC: Use bitfield helpers
      MIPS: CPS: Use bitfield helpers
      MIPS: TXx9: Let MACH_TX49XX select BOOT_ELF32

H. Nikolaus Schaller (2):
      MIPS: defconfig: CI20: configure for DRM_DW_HDMI_JZ4780
      MIPS: DTS: Ingenic: adjust register size to available registers

Huang Pei (3):
      MIPS: fix local_{add,sub}_return on MIPS64
      MIPS: rework local_t operation on MIPS64
      MIPS: retire "asm/llsc.h"

Jason Wang (5):
      MIPS: Remove a repeated word in a comment
      MIPS: Fix typo in a comment
      MIPS: lantiq: Fix typo in a comment
      MIPS: fix typo in a comment
      MIPS: BCM47XX: Replace strlcpy with strscpy

Jim Quinlan (4):
      dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs
      MIPS: bmips: Add support PCIe controller device nodes
      MIPS: bmips: Remove obsolete DMA mapping support
      PCI: brcmstb: Augment driver for MIPs SOCs

Lech Perczak (1):
      MIPS: ath79: drop _machine_restart again

Lukas Bulwahn (8):
      mips: add SYS_HAS_CPU_MIPS64_R5 config for MIPS Release 5 support
      mips: drop selecting non-existing config NR_CPUS_DEFAULT_2
      mips: dec: provide the correctly capitalized config CPU_R4X00 in init error message
      mips: kgdb: adjust the comment to the actual ifdef condition
      mips: remove obsolete selection of CPU_HAS_LOAD_STORE_LR
      mips: alchemy: remove historic comment on gpio build constraints
      mips: txx9: remove left-over for removed TXX9_ACLC configs
      mips: fix Kconfig reference to PHYS_ADDR_T_64BIT

Minghao Chi (1):
      mips/pci: remove redundant ret variable

Nathan Chancellor (2):
      MIPS: Loongson2ef: Remove unnecessary {as,cc}-option calls
      MIPS: Loongson64: Use three arguments for slti

Paul Boddie (2):
      MIPS: DTS: jz4780: Account for Synopsys HDMI driver and LCD controllers
      MIPS: DTS: CI20: Add DT nodes for HDMI setup

Paul Cercueil (1):
      MIPS: compressed: Fix build with ZSTD compression

Qing Zhang (3):
      MIPS: Loongson64: Add Loongson-2K1000 reset platform driver
      MIPS: Loongson64: DTS: Add pm block node for Loongson-2K1000
      dt-bindings: mips: Add Loongson-2K1000 reset support

Randy Dunlap (2):
      mips: lantiq: add support for clk_set_parent()
      mips: bcm63xx: add support for clk_set_parent()

Sander Vanheule (3):
      MIPS: drop selected EARLY_PRINTK configs for MACH_REALTEK_RTL
      MIPS: only register MT SMP ops if MT is supported
      MIPS: generic: enable SMP on SMVP systems

Thomas Bogendoerfer (3):
      MIPS: TXX9: Remove rbtx4938 board support
      MIPS: TXX9: Remove rbtx4939 board support
      MIPS: TXX9: Remove TX4939 SoC support

Tianjia Zhang (1):
      MIPS: Octeon: Fix build errors using clang

Tiezhu Yang (4):
      MIPS: SGI-IP22: Remove unnecessary check of GCC option
      MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
      MIPS: signal: Protect against sigaltstack wraparound
      MIPS: signal: Return immediately if call fails

Wang Qing (1):
      mips: ralink: add missing of_node_put() call in ill_acc_of_setup()

Yang Li (1):
      MIPS: Remove duplicated include in local.h

Yang Yingliang (1):
      MIPS: Loongson64: Add missing of_node_put() in ls2k_reset_init()

Ye Guojin (1):
      MIPS: OCTEON: add put_device() after of_find_device_by_node()

YunQiang Su (2):
      MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
      MIPS: new Kconfig option ZBOOT_LOAD_ADDRESS

 .../bindings/mips/loongson/ls2k-reset.yaml         |  38 ++
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   2 +
 arch/mips/Kconfig                                  |  22 +-
 arch/mips/Makefile                                 |   2 -
 arch/mips/alchemy/common/gpiolib.c                 |   2 -
 arch/mips/ath79/setup.c                            |  10 -
 arch/mips/bcm47xx/Platform                         |   1 -
 arch/mips/bcm47xx/board.c                          |   6 +-
 arch/mips/bcm47xx/buttons.c                        |  44 ++
 arch/mips/bcm47xx/leds.c                           |  21 +
 arch/mips/bcm63xx/clk.c                            |   6 +
 arch/mips/bmips/dma.c                              | 106 +---
 arch/mips/boot/compressed/Makefile                 |   6 +-
 arch/mips/boot/compressed/clz_ctz.c                |   2 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |  30 ++
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |  30 ++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |   9 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |   9 +
 arch/mips/boot/dts/ingenic/ci20.dts                |  72 ++-
 arch/mips/boot/dts/ingenic/jz4725b.dtsi            |   2 +-
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/jz4770.dtsi             |   2 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |   5 +
 arch/mips/cavium-octeon/octeon-platform.c          |   2 +
 arch/mips/cavium-octeon/octeon-usb.c               |   1 +
 arch/mips/configs/ci20_defconfig                   |   6 +
 arch/mips/configs/rbtx49xx_defconfig               |   4 -
 arch/mips/dec/prom/init.c                          |   2 +-
 arch/mips/generic/Platform                         |   3 +-
 arch/mips/generic/init.c                           |  11 +-
 arch/mips/include/asm/asm.h                        |  22 +
 arch/mips/include/asm/atomic.h                     |  11 +-
 arch/mips/include/asm/bitops.h                     |  24 +-
 arch/mips/include/asm/cmpxchg.h                    |   9 +-
 arch/mips/include/asm/kgdb.h                       |   2 +-
 arch/mips/include/asm/kvm_host.h                   |  13 +-
 arch/mips/include/asm/llsc.h                       |  39 --
 arch/mips/include/asm/local.h                      |  63 +--
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |   4 +
 .../asm/mach-loongson64/kernel-entry-init.h        |   4 +-
 arch/mips/include/asm/mach-tx49xx/mangle-port.h    |   8 -
 arch/mips/include/asm/mips-cps.h                   |  19 +-
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |   4 +-
 arch/mips/include/asm/sibyte/sb1250_mc.h           |   2 +-
 arch/mips/include/asm/smp-ops.h                    |   3 +
 arch/mips/include/asm/txx9/boards.h                |   6 -
 arch/mips/include/asm/txx9/rbtx4938.h              | 145 ------
 arch/mips/include/asm/txx9/rbtx4939.h              | 142 ------
 arch/mips/include/asm/txx9/spi.h                   |  34 --
 arch/mips/include/asm/txx9/tx4939.h                | 524 -------------------
 arch/mips/kernel/mips-cpc.c                        |   3 +-
 arch/mips/kernel/signal.c                          |  27 +-
 arch/mips/lantiq/clk.c                             |   6 +
 arch/mips/lantiq/falcon/sysctrl.c                  |   2 +-
 arch/mips/loongson2ef/Platform                     |  19 +-
 arch/mips/mm/c-octeon.c                            |   4 +-
 arch/mips/pci/Makefile                             |   2 -
 arch/mips/pci/fixup-rbtx4938.c                     |  53 --
 arch/mips/pci/pci-rt3883.c                         |   4 +-
 arch/mips/pci/pci-tx4939.c                         | 107 ----
 arch/mips/ralink/ill_acc.c                         |   1 +
 arch/mips/sgi-ip22/Platform                        |   5 -
 arch/mips/txx9/Kconfig                             |  51 +-
 arch/mips/txx9/Makefile                            |   2 -
 arch/mips/txx9/generic/7segled.c                   | 123 -----
 arch/mips/txx9/generic/Makefile                    |   3 -
 arch/mips/txx9/generic/irq_tx4939.c                | 216 --------
 arch/mips/txx9/generic/setup.c                     |  53 --
 arch/mips/txx9/generic/setup_tx4939.c              | 568 ---------------------
 arch/mips/txx9/generic/spi_eeprom.c                | 104 ----
 arch/mips/txx9/rbtx4938/Makefile                   |   2 -
 arch/mips/txx9/rbtx4938/irq.c                      | 157 ------
 arch/mips/txx9/rbtx4938/prom.c                     |  22 -
 arch/mips/txx9/rbtx4938/setup.c                    | 372 --------------
 arch/mips/txx9/rbtx4939/Makefile                   |   2 -
 arch/mips/txx9/rbtx4939/irq.c                      |  95 ----
 arch/mips/txx9/rbtx4939/prom.c                     |  29 --
 arch/mips/txx9/rbtx4939/setup.c                    | 554 --------------------
 drivers/char/hw_random/Kconfig                     |  13 -
 drivers/char/hw_random/Makefile                    |   1 -
 drivers/char/hw_random/tx4939-rng.c                | 157 ------
 drivers/mtd/maps/Kconfig                           |   6 -
 drivers/mtd/maps/Makefile                          |   1 -
 drivers/mtd/maps/rbtx4939-flash.c                  | 133 -----
 drivers/mtd/nand/raw/Kconfig                       |   2 +-
 drivers/pci/controller/Kconfig                     |   2 +-
 drivers/pci/controller/pcie-brcmstb.c              |  82 ++-
 drivers/platform/mips/Kconfig                      |   6 +
 drivers/platform/mips/Makefile                     |   1 +
 drivers/platform/mips/ls2k-reset.c                 |  53 ++
 91 files changed, 614 insertions(+), 4005 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/loongson/ls2k-reset.yaml
 create mode 100644 arch/mips/boot/compressed/clz_ctz.c
 delete mode 100644 arch/mips/include/asm/llsc.h
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4938.h
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4939.h
 delete mode 100644 arch/mips/include/asm/txx9/spi.h
 delete mode 100644 arch/mips/include/asm/txx9/tx4939.h
 delete mode 100644 arch/mips/pci/fixup-rbtx4938.c
 delete mode 100644 arch/mips/pci/pci-tx4939.c
 delete mode 100644 arch/mips/txx9/generic/7segled.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx4939.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx4939.c
 delete mode 100644 arch/mips/txx9/generic/spi_eeprom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4938/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4938/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/setup.c
 delete mode 100644 arch/mips/txx9/rbtx4939/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4939/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4939/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4939/setup.c
 delete mode 100644 drivers/char/hw_random/tx4939-rng.c
 delete mode 100644 drivers/mtd/maps/rbtx4939-flash.c
 create mode 100644 drivers/platform/mips/ls2k-reset.c

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
