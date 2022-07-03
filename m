Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF2D564601
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiGCIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiGCIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:45:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80C871130
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 01:45:44 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT+MtV8FigMQFAA--.17307S2;
        Sun, 03 Jul 2022 16:45:33 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 00/15] irqchip: Add LoongArch-related irqchip drivers
Date:   Sun,  3 Jul 2022 16:45:17 +0800
Message-Id: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxT+MtV8FigMQFAA--.17307S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KF17tF4rAF1kJFy7WryUJrb_yoWDXFy7pF
        43Cr1aqF4UGryYqr1UAw48WFy5JFn3Jw4Dta4xtryxXrn8Ar1DKr18JFykZry3ArW8Xr1U
        ZFWjqw4UG3WUAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the ACPI Specification 6.5(which may be published in
early June this year and the board is reviewing the draft).

Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
work together with LS7A chipsets. The irq chips in LoongArch computers
include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).

CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are
per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
controllers out of CPU (i.e., in chipsets). These controllers (in other
words, irqchips) are linked in a hierarchy, and there are two models of
hierarchy (legacy model and extended model). 

Legacy IRQ model:

In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
gathered by HTVECINTC, and then go to LIOINTC, and then CPUINTC.

 +---------------------------------------------+
 |                                             |
 |    +-----+     +---------+     +-------+    |
 |    | IPI | --> | CPUINTC | <-- | Timer |    |
 |    +-----+     +---------+     +-------+    |
 |                     ^                       |
 |                     |                       |
 |                +---------+     +-------+    |
 |                | LIOINTC | <-- | UARTs |    |
 |                +---------+     +-------+    |
 |                     ^                       |
 |                     |                       |
 |               +-----------+                 |
 |               | HTVECINTC |                 |
 |               +-----------+                 |
 |                ^         ^                  |
 |                |         |                  |
 |          +---------+ +---------+            |
 |          | PCH-PIC | | PCH-MSI |            |
 |          +---------+ +---------+            |
 |            ^     ^           ^              |
 |            |     |           |              |
 |    +---------+ +---------+ +---------+      |
 |    | PCH-LPC | | Devices | | Devices |      |
 |    +---------+ +---------+ +---------+      |
 |         ^                                   |
 |         |                                   |
 |    +---------+                              |
 |    | Devices |                              |
 |    +---------+                              |
 |                                             |
 |                                             |
 +---------------------------------------------+

Extended IRQ model:

In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
gathered by EIOINTC, and then go to to CPUINTC directly.

 +--------------------------------------------------------+
 |                                                        |
 |         +-----+     +---------+     +-------+          |
 |         | IPI | --> | CPUINTC | <-- | Timer |          |
 |         +-----+     +---------+     +-------+          |
 |                      ^       ^                         |
 |                      |       |                         |
 |               +---------+ +---------+     +-------+    |
 |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
 |               +---------+ +---------+     +-------+    |
 |                ^       ^                               |
 |                |       |                               |
 |         +---------+ +---------+                        |
 |         | PCH-PIC | | PCH-MSI |                        |
 |         +---------+ +---------+                        |
 |           ^     ^           ^                          |
 |           |     |           |                          |
 |   +---------+ +---------+ +---------+                  |
 |   | PCH-LPC | | Devices | | Devices |                  |
 |   +---------+ +---------+ +---------+                  |
 |        ^                                               |
 |        |                                               |
 |   +---------+                                          |
 |   | Devices |                                          |
 |   +---------+                                          |
 |                                                        |
 |                                                        |
 +--------------------------------------------------------+

The hierarchy model is constructed by parsing irq contronler structures
in MADT. Some controllers((e.g. LIOINTC, HTVECINTC, EIOINTC and PCH-LPC)
are hardcodingly connected to their parents, so their irqdomins are
separately routed to their parents in a fixed way. Some controllers
(e.g. PCH-PIC and PCH-MSI) could be routed to different parents for different
CPU. The firmware will config EIOINTC for the newer CPU and config HTVECINTC
for old CPU in MADT. By this way, PCH-PIC and PCH-MSI irqdomain can only be
routed one parent irqdomin: HTVECINTC or EIOINTC.


Example of irqchip topology in a system with  two chipsets:

 +------------------------------------------------------------+
 |                                                            |
 |                     +------------------+                   |
 |                     |      CPUINTC     |                   |
 |                     +------------------+                   |
 |                     ^                  ^                   |
 |                     |                  |                   |
 |          +----------+                  +----------+        |
 |          | EIOINTC 0|                  | EIOINTC 1|        |
 |          +----------+                  +----------+        |
 |          ^          ^                  ^          ^        |
 |          |          |                  |          |        |
 | +----------+   +----------+   +----------+    +----------+ |
 | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
 | +----------+   +----------+   +----------+    +----------+ |
 |                                                            |
 |                                                            |
 +------------------------------------------------------------+

For systems with two chipsets, there are tow group(consists of EIOINTC, PCH-PIC and PCH-MSI) irqdomains, 
and each group has same node id. So we defined a structure to mantain the relation of node and it's parent irqdomain.

struct acpi_vector_group {
        int node;
	int pci_segment;
        struct irq_domain *parent;
};

The initialization and use of acpi_vector_group array are following:

1 Entry of struct acpi_vector_group array initialization:

By parsing MCFG, the node id（from bit44-47 of Base Address）and pci segment are extracted. And from MADT, we have the node id of each EIOINTC.

entry.node = node id of pci segment
entry.pci_segment = pci segment (only for msi irqdomain)

By matching node id of entry and EIOINTC to set parent.

entry.parent = EIOINTC irqdomain(node id of EIOINTC == node id of pci segment)

2 Get parent irqdomain for PCH-PIC:

From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base Address).
if (node of entry i == node of PCH-PIC)
	return entrys[i].parent;

3 Get parent irqdomain for PCH-MSI of pci segment:

	return entrys[i].parent; (i is the index of msi irqdomain)

4 How to select a correct irqdomain to map irq for a device?
For devices using legacy irq behind PCH-PIC, GSI is used to select correct PCH-PIC irqdomain.
For devices using msi irq behind PCH-MSI, the pci segmen of the device is used to select correct PCH-MSI irqdomain.

V1 -> V2:
1, Remove queued patches;
2, Move common logic of DT/ACPI probing to common functions;
3, Split .suspend()/.resume() functions to separate patches.

V2 -> V3:
1, Fix a bug for loongson-pch-pic probe;
2, Some minor improvements for LPC controller.

V3 -> V4:
1, Rework the CPU interrupt controller driver;
2, Some minor improvements for other controllers.

V4 -> V5:
1, Add a description of LoonArch's IRQ model;
2, Support multiple EIOINTCs in one system;
3, Some minor improvements for other controllers.

V5 -> V6:
1, Attach a fwnode to CPUINTC irq domain;
2, Use raw spinlock instead of generic spinlock;
3, Improve the method of restoring EIOINTC state;
4, Update documentation, comments and commit messages.

V6 -> V7:
1, Fix build warnings reported by kernel test robot.

V7 -> V8:
1, Add arguments sanity checking for irqchip init functions;
2, Support Loongson-3C5000 (One NUMA Node includes 4 EIOINTC Node).

V8 -> V9:
1, Rebase on 5.17-rc5;
2, Update cover letter;
3, Some small improvements.

V9 -> V10:
1, Rebase on 5.17-rc6;
2, Fix build warnings reported by kernel test robot.

V10 -> V11:
1, Rebase on 5.18-rc4;
2, Fix irq affinity setting for EIOINTC;
3, Fix hwirq allocation failure for EIOINTC.

V11 -> RFC:
1, Refactored the way to build irqchip hierarchy topology.

RFC -> RFC V2:
1, Move all IO-interrupt related code to driver/irqchip from arch directory.
2. Add description for an example of two chipsets system.

RFC V2 -> RFC V3:
1, Add support for multiple GSI domains
2, Use ACPI_GENERIC_GSI for GSI handling
3, Drop suspend-resume stuff
4, Export fwnode handles instead of irq domain handles

RFC V3 -> V12:
1, Address patch attributions of the patch series

V12 -> V13
1 Based on 5.19-rc2
2 Remove arch specified gsi code
3 Split some 'common' code into the various drivers where they belong.
4 Allow acpi_gsi_to_irq() to have an arch-specific fallback

V13 -> V14
1 Add LoongArch-specified APICs definition
2 Use the way in CPUINTC driver to call pch-pic and pch-msi entry
3 Fix compiling and regression issue for OF path

Huacai Chen (8):
  ACPICA: MADT: Add LoongArch APICs support
  irqchip: Add Loongson PCH LPC controller support
  irqchip/loongson-pch-pic: Add ACPI init support
  irqchip/loongson-pch-msi: Add ACPI init support
  irqchip/loongson-htvec: Add ACPI init support
  irqchip/loongson-liointc: Add ACPI init support
  irqchip: Add Loongson Extended I/O interrupt controller support
  irqchip: Add LoongArch CPU interrupt controller support

Jianmin Lv (5):
  genirq/generic_chip: export irq_unmap_generic_chip
  LoongArch: Use ACPI_GENERIC_GSI for gsi handling
  LoongArch: prepare to support multiple pch-pic and pch-msi irqdomain
  irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
  LoongArch: Fix irq number for timer and ipi

Marc Zyngier (2):
  APCI: irq: Add support for multiple GSI domains
  ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

 arch/loongarch/Kconfig                      |   1 +
 arch/loongarch/include/asm/irq.h            |  42 ++-
 arch/loongarch/kernel/acpi.c                |  65 -----
 arch/loongarch/kernel/irq.c                 |  45 ++-
 arch/loongarch/kernel/time.c                |   2 +-
 arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
 drivers/acpi/bus.c                          |   3 +
 drivers/acpi/irq.c                          |  58 ++--
 drivers/irqchip/Kconfig                     |  28 ++
 drivers/irqchip/Makefile                    |   3 +
 drivers/irqchip/irq-gic-v3.c                |  18 +-
 drivers/irqchip/irq-gic.c                   |  18 +-
 drivers/irqchip/irq-loongarch-cpu.c         | 169 ++++++++++++
 drivers/irqchip/irq-loongson-eiointc.c      | 413 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c        | 145 +++++++---
 drivers/irqchip/irq-loongson-liointc.c      | 227 ++++++++++-----
 drivers/irqchip/irq-loongson-pch-lpc.c      | 207 ++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c      | 131 ++++++---
 drivers/irqchip/irq-loongson-pch-pic.c      | 177 +++++++++---
 include/acpi/actbl2.h                       | 127 ++++++++-
 include/linux/acpi.h                        |   4 +-
 include/linux/cpuhotplug.h                  |   1 +
 include/linux/irq.h                         |   1 +
 kernel/irq/generic-chip.c                   |   2 +-
 24 files changed, 1578 insertions(+), 311 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

-- 
1.8.3.1

