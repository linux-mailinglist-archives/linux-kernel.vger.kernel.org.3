Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74557AD83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiGTCBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiGTCBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:01:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F1C4B0F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:01:14 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9DeYddirMYpAA--.14711S2;
        Wed, 20 Jul 2022 10:01:02 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V17 00/13] irqchip: Add LoongArch-related irqchip drivers
Date:   Wed, 20 Jul 2022 10:00:48 +0800
Message-Id: <1658282461-35489-1-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn9DeYddirMYpAA--.14711S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyrWFy5Cr4rWF17CFWUtwb_yoWfArW3pF
        43Cr1aqF4UGry5Xr13Aw48ury3Xrn3J3yDta4xt34xXr90kr1DKr18tFykZry3ArWxGryj
        vFWUtw4UG3WUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
        Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller), PCH-PIC
(Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).

CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC are
per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
controllers out of CPU (i.e., in chipsets). These controllers (in other
words, irqchips) are linked in a hierarchy way.

The IPI (Inter-Processor Interrupt) and CPU Local Timer
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
in MADT.

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

V14 -> V15
1 Expose fwnode_handle of CPUINTC domain instead of using get_xxx_irq() for CPUINTC driver
2 Fix EIOINTC driver: delete parent_data referencing and fix set_affinity bug
3 Use acpi_disabled for DT and ACPI runtime code path
4 Fix return type of arch-specific acpi_gsi_to_irq fallback 
5 Fix compile bug tested by kernel test robot

V15 -> V16

1 Merge entry function to make code simpler for cpuintc driver
2 Provisionally add ACPICA data structures
3 Drop "Legacy" model support
4 Fix compiling error

V16 - V17

1 Adjust order of the patch preparing to support multiple bridges
2 Split the patch removing COMPLE_TEST into pch-pic and pch-msi patches
3 Change some function name for consistency and remove a redundant blank

Huacai Chen (6):
  irqchip: Add Loongson PCH LPC controller support
  irqchip/loongson-pch-pic: Add ACPI init support
  irqchip/loongson-pch-msi: Add ACPI init support
  irqchip/loongson-liointc: Add ACPI init support
  irqchip: Add Loongson Extended I/O interrupt controller support
  irqchip: Add LoongArch CPU interrupt controller support

Jianmin Lv (4):
  genirq/generic_chip: export irq_unmap_generic_chip
  LoongArch: Use ACPI_GENERIC_GSI for gsi handling
  LoongArch: Prepare to support multiple pch-pic and pch-msi irqdomain
  irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch

Marc Zyngier (3):
  LoongArch: Provisionally add ACPICA data structures
  APCI: irq: Add support for multiple GSI domains
  ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

 arch/loongarch/Kconfig                      |   1 +
 arch/loongarch/include/asm/acpi.h           | 142 ++++++++++
 arch/loongarch/include/asm/irq.h            |  51 ++--
 arch/loongarch/kernel/acpi.c                |  65 -----
 arch/loongarch/kernel/irq.c                 |  58 +++-
 arch/loongarch/kernel/time.c                |  14 +-
 arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
 drivers/acpi/bus.c                          |   3 +
 drivers/acpi/irq.c                          |  58 ++--
 drivers/irqchip/Kconfig                     |  32 ++-
 drivers/irqchip/Makefile                    |   3 +
 drivers/irqchip/irq-gic-v3.c                |  18 +-
 drivers/irqchip/irq-gic.c                   |  18 +-
 drivers/irqchip/irq-loongarch-cpu.c         | 149 +++++++++++
 drivers/irqchip/irq-loongson-eiointc.c      | 395 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-liointc.c      | 204 ++++++++------
 drivers/irqchip/irq-loongson-pch-lpc.c      | 205 +++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c      | 127 ++++++---
 drivers/irqchip/irq-loongson-pch-pic.c      | 177 ++++++++++---
 include/linux/acpi.h                        |   4 +-
 include/linux/cpuhotplug.h                  |   1 +
 include/linux/irq.h                         |   1 +
 kernel/irq/generic-chip.c                   |   2 +-
 23 files changed, 1451 insertions(+), 279 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

-- 
1.8.3.1

