Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36EC57B434
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiGTJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGTJy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:54:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4718F54CAF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:54:25 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxaeDG0NdiPlsqAA--.7769S3;
        Wed, 20 Jul 2022 17:54:15 +0800 (CST)
Subject: Re: [PATCH V17 00/13] irqchip: Add LoongArch-related irqchip drivers
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658282461-35489-1-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H4SA4cgncUNgrb=6UzMuq5-5c1XW=ChR6pSCgo5ykxhwg@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <098e4920-f2dc-afc7-824d-bae7d3a260fa@loongson.cn>
Date:   Wed, 20 Jul 2022 17:54:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4SA4cgncUNgrb=6UzMuq5-5c1XW=ChR6pSCgo5ykxhwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxaeDG0NdiPlsqAA--.7769S3
X-Coremail-Antispam: 1UD129KBjvJXoW3tFy7XrWfXrWDGr45Ar4fXwb_yoWDWFy8pF
        43C3WaqF48Jry5Xr1xtw48u34Yqw1fJ39rta4xKryIqr9Y9r1qgF1UJFykZFZ7ArW8Wr1j
        vFWUt3WUGF1UAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai,

I'll address the two issues and submit V18.

Thanks.

On 2022/7/20 上午11:22, Huacai Chen wrote:
> Hi, Marc and Jianmin,
> 
> I have done the integrated test on top of V17, together with PCI code
> and arch code [1]. From my point of view, this series is good enough,
> except two small issues in patch 10 and patch 12.
> 
> [1] https://github.com/loongson/linux/commits/loongarch-next
> 
> Thanks,
> Huacai
> 
> 
> 
> On Wed, Jul 20, 2022 at 10:01 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
>> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
>> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
>> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
>> are already added in the ACPI Specification 6.5(which may be published in
>> early June this year and the board is reviewing the draft).
>>
>> Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
>> work together with LS7A chipsets. The irq chips in LoongArch computers
>> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
>> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller), PCH-PIC
>> (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
>> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
>>
>> CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC are
>> per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
>> controllers out of CPU (i.e., in chipsets). These controllers (in other
>> words, irqchips) are linked in a hierarchy way.
>>
>> The IPI (Inter-Processor Interrupt) and CPU Local Timer
>> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
>> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
>> gathered by EIOINTC, and then go to to CPUINTC directly.
>>
>>   +--------------------------------------------------------+
>>   |                                                        |
>>   |         +-----+     +---------+     +-------+          |
>>   |         | IPI | --> | CPUINTC | <-- | Timer |          |
>>   |         +-----+     +---------+     +-------+          |
>>   |                      ^       ^                         |
>>   |                      |       |                         |
>>   |               +---------+ +---------+     +-------+    |
>>   |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
>>   |               +---------+ +---------+     +-------+    |
>>   |                ^       ^                               |
>>   |                |       |                               |
>>   |         +---------+ +---------+                        |
>>   |         | PCH-PIC | | PCH-MSI |                        |
>>   |         +---------+ +---------+                        |
>>   |           ^     ^           ^                          |
>>   |           |     |           |                          |
>>   |   +---------+ +---------+ +---------+                  |
>>   |   | PCH-LPC | | Devices | | Devices |                  |
>>   |   +---------+ +---------+ +---------+                  |
>>   |        ^                                               |
>>   |        |                                               |
>>   |   +---------+                                          |
>>   |   | Devices |                                          |
>>   |   +---------+                                          |
>>   |                                                        |
>>   |                                                        |
>>   +--------------------------------------------------------+
>>
>> The hierarchy model is constructed by parsing irq contronler structures
>> in MADT.
>>
>> Example of irqchip topology in a system with  two chipsets:
>>
>>   +------------------------------------------------------------+
>>   |                                                            |
>>   |                     +------------------+                   |
>>   |                     |      CPUINTC     |                   |
>>   |                     +------------------+                   |
>>   |                     ^                  ^                   |
>>   |                     |                  |                   |
>>   |          +----------+                  +----------+        |
>>   |          | EIOINTC 0|                  | EIOINTC 1|        |
>>   |          +----------+                  +----------+        |
>>   |          ^          ^                  ^          ^        |
>>   |          |          |                  |          |        |
>>   | +----------+   +----------+   +----------+    +----------+ |
>>   | | PCH-PIC 0|   | PCH-MSI 0|   | PCH-PIC 1|    | PCH-MSI 1| |
>>   | +----------+   +----------+   +----------+    +----------+ |
>>   |                                                            |
>>   |                                                            |
>>   +------------------------------------------------------------+
>>
>> For systems with two chipsets, there are tow group(consists of EIOINTC, PCH-PIC and PCH-MSI) irqdomains,
>> and each group has same node id. So we defined a structure to mantain the relation of node and it's parent irqdomain.
>>
>> struct acpi_vector_group {
>>          int node;
>>          int pci_segment;
>>          struct irq_domain *parent;
>> };
>>
>> The initialization and use of acpi_vector_group array are following:
>>
>> 1 Entry of struct acpi_vector_group array initialization:
>>
>> By parsing MCFG, the node id（from bit44-47 of Base Address）and pci segment are extracted. And from MADT, we have the node id of each EIOINTC.
>>
>> entry.node = node id of pci segment
>> entry.pci_segment = pci segment (only for msi irqdomain)
>>
>> By matching node id of entry and EIOINTC to set parent.
>>
>> entry.parent = EIOINTC irqdomain(node id of EIOINTC == node id of pci segment)
>>
>> 2 Get parent irqdomain for PCH-PIC:
>>
>>  From MADT, we have the node id of each PCH-PIC(from bit44-47 of Base Address).
>> if (node of entry i == node of PCH-PIC)
>>          return entrys[i].parent;
>>
>> 3 Get parent irqdomain for PCH-MSI of pci segment:
>>
>>          return entrys[i].parent; (i is the index of msi irqdomain)
>>
>> 4 How to select a correct irqdomain to map irq for a device?
>> For devices using legacy irq behind PCH-PIC, GSI is used to select correct PCH-PIC irqdomain.
>> For devices using msi irq behind PCH-MSI, the pci segmen of the device is used to select correct PCH-MSI irqdomain.
>>
>> V1 -> V2:
>> 1, Remove queued patches;
>> 2, Move common logic of DT/ACPI probing to common functions;
>> 3, Split .suspend()/.resume() functions to separate patches.
>>
>> V2 -> V3:
>> 1, Fix a bug for loongson-pch-pic probe;
>> 2, Some minor improvements for LPC controller.
>>
>> V3 -> V4:
>> 1, Rework the CPU interrupt controller driver;
>> 2, Some minor improvements for other controllers.
>>
>> V4 -> V5:
>> 1, Add a description of LoonArch's IRQ model;
>> 2, Support multiple EIOINTCs in one system;
>> 3, Some minor improvements for other controllers.
>>
>> V5 -> V6:
>> 1, Attach a fwnode to CPUINTC irq domain;
>> 2, Use raw spinlock instead of generic spinlock;
>> 3, Improve the method of restoring EIOINTC state;
>> 4, Update documentation, comments and commit messages.
>>
>> V6 -> V7:
>> 1, Fix build warnings reported by kernel test robot.
>>
>> V7 -> V8:
>> 1, Add arguments sanity checking for irqchip init functions;
>> 2, Support Loongson-3C5000 (One NUMA Node includes 4 EIOINTC Node).
>>
>> V8 -> V9:
>> 1, Rebase on 5.17-rc5;
>> 2, Update cover letter;
>> 3, Some small improvements.
>>
>> V9 -> V10:
>> 1, Rebase on 5.17-rc6;
>> 2, Fix build warnings reported by kernel test robot.
>>
>> V10 -> V11:
>> 1, Rebase on 5.18-rc4;
>> 2, Fix irq affinity setting for EIOINTC;
>> 3, Fix hwirq allocation failure for EIOINTC.
>>
>> V11 -> RFC:
>> 1, Refactored the way to build irqchip hierarchy topology.
>>
>> RFC -> RFC V2:
>> 1, Move all IO-interrupt related code to driver/irqchip from arch directory.
>> 2. Add description for an example of two chipsets system.
>>
>> RFC V2 -> RFC V3:
>> 1, Add support for multiple GSI domains
>> 2, Use ACPI_GENERIC_GSI for GSI handling
>> 3, Drop suspend-resume stuff
>> 4, Export fwnode handles instead of irq domain handles
>>
>> RFC V3 -> V12:
>> 1, Address patch attributions of the patch series
>>
>> V12 -> V13
>> 1 Based on 5.19-rc2
>> 2 Remove arch specified gsi code
>> 3 Split some 'common' code into the various drivers where they belong.
>> 4 Allow acpi_gsi_to_irq() to have an arch-specific fallback
>>
>> V13 -> V14
>> 1 Add LoongArch-specified APICs definition
>> 2 Use the way in CPUINTC driver to call pch-pic and pch-msi entry
>> 3 Fix compiling and regression issue for OF path
>>
>> V14 -> V15
>> 1 Expose fwnode_handle of CPUINTC domain instead of using get_xxx_irq() for CPUINTC driver
>> 2 Fix EIOINTC driver: delete parent_data referencing and fix set_affinity bug
>> 3 Use acpi_disabled for DT and ACPI runtime code path
>> 4 Fix return type of arch-specific acpi_gsi_to_irq fallback
>> 5 Fix compile bug tested by kernel test robot
>>
>> V15 -> V16
>>
>> 1 Merge entry function to make code simpler for cpuintc driver
>> 2 Provisionally add ACPICA data structures
>> 3 Drop "Legacy" model support
>> 4 Fix compiling error
>>
>> V16 - V17
>>
>> 1 Adjust order of the patch preparing to support multiple bridges
>> 2 Split the patch removing COMPLE_TEST into pch-pic and pch-msi patches
>> 3 Change some function name for consistency and remove a redundant blank
>>
>> Huacai Chen (6):
>>    irqchip: Add Loongson PCH LPC controller support
>>    irqchip/loongson-pch-pic: Add ACPI init support
>>    irqchip/loongson-pch-msi: Add ACPI init support
>>    irqchip/loongson-liointc: Add ACPI init support
>>    irqchip: Add Loongson Extended I/O interrupt controller support
>>    irqchip: Add LoongArch CPU interrupt controller support
>>
>> Jianmin Lv (4):
>>    genirq/generic_chip: export irq_unmap_generic_chip
>>    LoongArch: Use ACPI_GENERIC_GSI for gsi handling
>>    LoongArch: Prepare to support multiple pch-pic and pch-msi irqdomain
>>    irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
>>
>> Marc Zyngier (3):
>>    LoongArch: Provisionally add ACPICA data structures
>>    APCI: irq: Add support for multiple GSI domains
>>    ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
>>
>>   arch/loongarch/Kconfig                      |   1 +
>>   arch/loongarch/include/asm/acpi.h           | 142 ++++++++++
>>   arch/loongarch/include/asm/irq.h            |  51 ++--
>>   arch/loongarch/kernel/acpi.c                |  65 -----
>>   arch/loongarch/kernel/irq.c                 |  58 +++-
>>   arch/loongarch/kernel/time.c                |  14 +-
>>   arch/mips/include/asm/mach-loongson64/irq.h |   2 +-
>>   drivers/acpi/bus.c                          |   3 +
>>   drivers/acpi/irq.c                          |  58 ++--
>>   drivers/irqchip/Kconfig                     |  32 ++-
>>   drivers/irqchip/Makefile                    |   3 +
>>   drivers/irqchip/irq-gic-v3.c                |  18 +-
>>   drivers/irqchip/irq-gic.c                   |  18 +-
>>   drivers/irqchip/irq-loongarch-cpu.c         | 149 +++++++++++
>>   drivers/irqchip/irq-loongson-eiointc.c      | 395 ++++++++++++++++++++++++++++
>>   drivers/irqchip/irq-loongson-liointc.c      | 204 ++++++++------
>>   drivers/irqchip/irq-loongson-pch-lpc.c      | 205 +++++++++++++++
>>   drivers/irqchip/irq-loongson-pch-msi.c      | 127 ++++++---
>>   drivers/irqchip/irq-loongson-pch-pic.c      | 177 ++++++++++---
>>   include/linux/acpi.h                        |   4 +-
>>   include/linux/cpuhotplug.h                  |   1 +
>>   include/linux/irq.h                         |   1 +
>>   kernel/irq/generic-chip.c                   |   2 +-
>>   23 files changed, 1451 insertions(+), 279 deletions(-)
>>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>>   create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
>>   create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
>>
>> --
>> 1.8.3.1
>>
>>

