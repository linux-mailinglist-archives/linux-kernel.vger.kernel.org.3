Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662A537802
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiE3I5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiE3I51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:57:27 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 258567220E;
        Mon, 30 May 2022 01:57:24 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nvbDG-0006tr-00; Mon, 30 May 2022 10:57:22 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 20EE0C0327; Mon, 30 May 2022 10:57:13 +0200 (CEST)
Date:   Mon, 30 May 2022 10:57:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v5.19
Message-ID: <20220530085713.GA4761@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.19

for you to fetch changes up to 7e4fd16b38923028b01d3dbadf4ca973d885c53e:

  MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC (2022-05-26 10:12:11 +0200)

----------------------------------------------------------------
Cleanups and fixes

----------------------------------------------------------------
Aidan MacDonald (1):
      mips: dts: ingenic: x1000: Add PWM device tree node

Arınç ÜNAL (3):
      mips: dts: ralink: mt7621: add mdio label to mdio-bus
      mips: dts: ralink: mt7621: mux phy4 to gmac1 for GB-PC1
      mips: dts: ralink: mt7621: remove defining gpio function for pin groups

Christophe JAILLET (2):
      MIPS: SGI-IP27: Free some unused memory
      MIPS: SGI-IP30: Free some unused memory

Gong Yuanjun (1):
      mips: cpc: Fix refcount leak in mips_cpc_default_phys_base

Guenter Roeck (1):
      MIPS: Loongson: Use hwmon_device_register_with_groups() to register hwmon

Guilherme G. Piccoli (1):
      mips: ip22: Reword PANICED to PANICKED and remove useless header

Guo Zhengkui (1):
      MIPS: Sibyte: remove unnecessary return variable

Haowen Bai (1):
      MIPS: VR41xx: Drop redundant spinlock initialization

Jason Wang (1):
      MIPS: tools: no need to initialise statics to 0

Jim Quinlan (1):
      MIPS: bmips: Fix compiler warning observed on W=1 build

Juerg Haefliger (2):
      MIPS: loongson32: Kconfig: Remove extra space
      MIPS: Kconfig: Fix indentation and add endif comment

Julia Lawall (2):
      MIPS: fix typos in comments
      MIPS: Octeon: fix typo in comment

Krzysztof Kozlowski (1):
      MIPS: dts: align SPI NOR node name with dtschema

Maciej W. Rozycki (3):
      MIPS: IP27: Remove incorrect `cpu_has_fpu' override
      MIPS: IP30: Remove incorrect `cpu_has_fpu' override
      MIPS: Rewrite `csum_tcpudp_nofold' in plain C

Mao Bibo (1):
      MIPS: smp: optimization for flush_tlb_mm when exiting

Michael Walle (3):
      MIPS: mscc: jaguar2: rename pinctrl nodes
      MIPS: mscc: ocelot: rename pinctrl nodes
      MIPS: mscc: serval: rename pinctrl nodes

Shida Zhang (1):
      MIPS: adding a safety check for cpu_has_fpu

Stijn Tintel (3):
      MIPS: Octeon: fix CN6640 hang on XAUI init
      MIPS: Octeon: support all interfaces on CN66XX
      MIPS: Octeon: add SNIC10E board

Tiezhu Yang (5):
      selftests/ftrace: Save kprobe_events to test log
      MIPS: Use NOKPROBE_SYMBOL() instead of __kprobes annotation
      MIPS: Return -EINVAL if mem parameter is empty in early_parse_mem()
      MIPS: Use memblock_add_node() in early_parse_mem() under CONFIG_NUMA
      MIPS: RALINK: Define pci_remap_iospace under CONFIG_PCI_DRIVERS_GENERIC

周琰杰 (Zhou Yanjie) (3):
      MIPS: Ingenic: Add PWM nodes for X1830.
      MIPS: Ingenic: Refresh device tree for Ingenic SoCs and boards.
      MIPS: Ingenic: Refresh defconfig for CU1000-Neo and CU1830-Neo.

陈学兵 (1):
      mips: setup: use strscpy to replace strlcpy

 arch/mips/Kconfig                                  |  12 +-
 arch/mips/alchemy/common/dbdma.c                   |   2 +-
 arch/mips/bmips/dma.c                              |   1 +
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |   2 +-
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |   2 +-
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |   2 +-
 arch/mips/boot/dts/ingenic/cu1000-neo.dts          |  77 +++++++------
 arch/mips/boot/dts/ingenic/cu1830-neo.dts          |  76 ++++++------
 arch/mips/boot/dts/ingenic/x1000.dtsi              |  32 ++++++
 arch/mips/boot/dts/ingenic/x1830.dtsi              |  53 +++++++++
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts         |  10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb111.dts         |  10 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb118.dts         |   6 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi                |   4 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts          |   6 +-
 arch/mips/boot/dts/mscc/serval_common.dtsi         |  14 +--
 .../dts/ralink/gardena_smart_gateway_mt7688.dts    |   2 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts |  26 ++---
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts |  30 ++---
 arch/mips/boot/dts/ralink/mt7621.dtsi              |   2 +-
 arch/mips/boot/tools/relocs.c                      |   2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |   2 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   5 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   6 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   2 +-
 arch/mips/cavium-octeon/octeon-usb.c               |   2 +-
 arch/mips/configs/cu1000-neo_defconfig             |   2 +-
 arch/mips/configs/cu1830-neo_defconfig             |   2 +-
 arch/mips/dec/ioasic-irq.c                         |   4 +-
 arch/mips/dec/setup.c                              |   2 +-
 arch/mips/fw/arc/memory.c                          |   2 +-
 arch/mips/include/asm/checksum.h                   |  79 ++++++-------
 arch/mips/include/asm/cpu-features.h               |   3 +
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   1 -
 .../include/asm/mach-ip30/cpu-feature-overrides.h  |   1 -
 arch/mips/include/asm/mach-ralink/spaces.h         |   2 +
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |   2 +
 arch/mips/jazz/irq.c                               |   2 +-
 arch/mips/kernel/cmpxchg.c                         |   2 +-
 arch/mips/kernel/cpu-probe.c                       |   2 +-
 arch/mips/kernel/idle.c                            |   2 +-
 arch/mips/kernel/kprobes.c                         |  36 ++++--
 arch/mips/kernel/mips-cpc.c                        |   1 +
 arch/mips/kernel/perf_event_mipsxx.c               |   2 +-
 arch/mips/kernel/setup.c                           |  17 ++-
 arch/mips/kernel/smp.c                             |   6 +
 arch/mips/kvm/tlb.c                                |   2 +-
 arch/mips/loongson32/Kconfig                       |   2 +-
 arch/mips/mm/fault.c                               |   6 +-
 arch/mips/net/bpf_jit_comp32.c                     |   2 +-
 arch/mips/pci/pcie-octeon.c                        |   4 +-
 arch/mips/pic32/pic32mzda/config.c                 |   2 +-
 arch/mips/sgi-ip22/ip22-reset.c                    |  11 +-
 arch/mips/sgi-ip27/ip27-xtalk.c                    |   4 +
 arch/mips/sgi-ip30/ip30-xtalk.c                    |   4 +
 arch/mips/sibyte/bcm1480/setup.c                   |   4 +-
 arch/mips/tools/loongson3-llsc-check.c             |   2 +-
 arch/mips/txx9/generic/pci.c                       |   2 +-
 arch/mips/vr41xx/common/cmu.c                      |   2 -
 drivers/platform/mips/cpu_hwmon.c                  | 127 +++++++--------------
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |   2 +
 62 files changed, 401 insertions(+), 335 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
