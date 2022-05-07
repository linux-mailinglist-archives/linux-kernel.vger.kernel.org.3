Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612451E50A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445696AbiEGHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbiEGHKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:10:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB354541B5
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:06:22 -0700 (PDT)
Received: from [10.40.53.182] (unknown [10.40.53.182])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxqthlGnZi4O8MAA--.38669S3;
        Sat, 07 May 2022 15:06:13 +0800 (CST)
Subject: Re: [PATCH V11 00/10] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, lvjianmin@loongson.cn
References: <20220430085344.3127346-1-chenhuacai@loongson.cn>
 <87v8uk6kfa.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <763012f8-89c0-26a9-b76f-9cd9d26def7d@loongson.cn>
Date:   Sat, 7 May 2022 15:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v8uk6kfa.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxqthlGnZi4O8MAA--.38669S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW8Zr13Zr1DKFWDZr1DZFb_yoWfAry7pF
        WfGF1aqF4UJFy5X3WDtw4rXFyrJwn3tw1UJ3WrKry8XF1jkr1qgr10qryruFZrCrW8Wr1j
        vFW8t34DJ3W5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/5 下午11:58, Marc Zyngier wrote:
> On Sat, 30 Apr 2022 09:53:34 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
>>
>> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
>> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
>> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
>> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
>> are already added in the next revision of ACPI Specification (current
>> revision is 6.4).
>>
>> Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
>> work together with LS7A chipsets. The irq chips in LoongArch computers
>> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
>> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
>> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
>> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
>> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
>>
>> CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are
>> per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
>> controllers out of CPU (i.e., in chipsets). These controllers (in other
>> words, irqchips) are linked in a hierarchy, and there are two models of
>> hierarchy (legacy model and extended model).
>>
>> Legacy IRQ model:
>>
>> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
>> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
>> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
>> gathered by HTVECINTC, and then go to LIOINTC, and then CPUINTC.
>>
>>   +---------------------------------------------+
>>   |                                             |
>>   |    +-----+     +---------+     +-------+    |
>>   |    | IPI | --> | CPUINTC | <-- | Timer |    |
>>   |    +-----+     +---------+     +-------+    |
>>   |                     ^                       |
>>   |                     |                       |
>>   |                +---------+     +-------+    |
>>   |                | LIOINTC | <-- | UARTs |    |
>>   |                +---------+     +-------+    |
>>   |                     ^                       |
>>   |                     |                       |
>>   |               +-----------+                 |
>>   |               | HTVECINTC |                 |
>>   |               +-----------+                 |
>>   |                ^         ^                  |
>>   |                |         |                  |
>>   |          +---------+ +---------+            |
>>   |          | PCH-PIC | | PCH-MSI |            |
>>   |          +---------+ +---------+            |
>>   |            ^     ^           ^              |
>>   |            |     |           |              |
>>   |    +---------+ +---------+ +---------+      |
>>   |    | PCH-LPC | | Devices | | Devices |      |
>>   |    +---------+ +---------+ +---------+      |
>>   |         ^                                   |
>>   |         |                                   |
>>   |    +---------+                              |
>>   |    | Devices |                              |
>>   |    +---------+                              |
>>   |                                             |
>>   |                                             |
>>   +---------------------------------------------+
>>
>> Extended IRQ model:
>>
>> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
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
>> This patchset adds some irqchip drivers for LoongArch, it is preparing
>> to add LoongArch support in mainline kernel, we can see a snapshot here:
>> https://github.com/loongson/linux/tree/loongarch-next
>>
>> Cross-compile tool chain to build kernel:
>> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-20211202-cross-tools.tar.xz
>>
>> A CLFS-based Linux distro:
>> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-system-2021-12-02.tar.bz2
>>
>> Loongson and LoongArch documentations:
>> https://github.com/loongson/LoongArch-Documentation
>>
>> LoongArch-specific interrupt controllers:
>> https://mantis.uefi.org/mantis/view.php?id=2203
> 
> Nothing to see here, unfortunately (you need a login to access this
> information).
> 

Sorry， the link of mantis needs login， LoongArch-specific interrupt 
controllers related content has been added into ACPI spec 6.5 draft, 
working group review of which has been done, and the board will start a 
30-day legal review period, so spec 6.5 publication will be at some time 
in early Jun.

>>
>> LoongArch use ACPI, but ACPI tables cannot describe the hierarchy of
>> irqchips, so we initilize the irqchip subsystem in this way (from arch
>> code):
>>
>>    cpu_domain = loongarch_cpu_irq_init();
>>    liointc_domain = liointc_acpi_init(cpu_domain, acpi_liointc);
>>    eiointc_domain = eiointc_acpi_init(cpu_domain, acpi_eiointc);
>>    pch_pic_domain = pch_pic_acpi_init(eiointc_domain, acpi_pchpic);
>>    pch_msi_domain = pch_msi_acpi_init(eiointc_domain, acpi_pchmsi);
> 
> I said no to this in the past, and I'm going to reiterate: this is
> *not* acceptable. This obviously doesn't scale and isn't manageable in
> the long run. Hardcoding the topology and the probing order in the
> kernel code has repeatedly proved to be a disaster, and yet you refuse
> to take any input from past experience. This is pretty worrying.
> 

I completely agree with you about topology scaling, and we will change 
this according to LoongArch hardware feature as following:

- Delete fixed hierarchy code in arch file, and only call irqchip_init() 
to init irqchip controllers.
- Use IRQCHIP_ACPI_DECLARE to declare top-level core pic.
- For some controllers(lpc pic, lio pic, eio pic and ht pic) 
hardcodingly casecaded to parent one in LoongArch hardware,  we'll 
initialize them (if they are found in MADT) in their parent directly.
- For some controllers(bio pic and msi pic) cascading to different 
parent for different CPU, we'll initialize them (if they are found in 
MADT) in their candidate parent in term of CPU hardware feature 
information(e.g. support eio pic )

By this way, the irqchip hierarchy topology will be scaled automatically.

>>
>> Upstream irqchip init function return an irqdomain, and this domain
>> will be used by downstream irqchips as their parent domains. For more
>> infomation please refer:
>> https://lore.kernel.org/linux-arch/20210927064300.624279-11-chenhuacai@loongson.cn/T/#u
>>
>> Q: Why we don't declare irqchips in ACPI DSDT where hierarchy is possible?
>> A: This is answered in V8 of this series as below:
>>
>>    - There are several kinds of irq chips(e.g. pchpic、eiointc、cpuintc)
>>    for LoongArch. SCI interrupt (Fixed hardware is implemented for
>>    LoongArch in pch such as LS7A1000, and SCI interrupt is used for fixed
>>    event handling.) is an irq input of pch irq chip which routes
>>    interrupts to cpu as following irq chips path:
>>
>>    sci interrupt->|pchpic| ->|eiointc|->|cpuintc|
>>
>>    sci_interrupt will be transferred from gsi to irq through
>>    acpi_gsi_to_irq in acpi_enable_subsystem called from acpi_bus_init
>>    before acpi_scan_init where acpi device namespace is created, so we
>>    should build pch irq domain and related upstream irq domains before
>>    acpi_bus_init.
>>
>>    - PCI bus enumeration is executed from acpi_scan_init, and
>>    pci_set_msi_domain will be called for setting msi_domain of enumerated
>>    pci device. In pci_set_msi_domain, msi domain may be got through
>>    pcibios_device_add, fdt, iort(used for arm64) or inheriting from host
>>    bridge domain. And in each way, the msi domain needs to be found by
>>    calling irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI) to match
>>    one from the registered msi domain before. So we build the msi domain
>>    as x86 and arm64 before acpi_scan_init. The msi domain is hierarchic
>>    as following:
>>
>>    msi interrupt->|msipic| ->|eiointc|->|cpuintc|
>>
>>    - Yes, a driver can be deferred probed when get -EPROBE_DEFER on
>>    probing, but both sci interrupt transfer and pci bus enumeration are
>>    common code (not private driver for LoongArch).
>>
>>    So, declaring pic devices in DSDT for seems not suitable, we can only
>>    select the X86-like way which is a bit ugly.
> 
> ACPI *can* describe these topologies if you teach it. ARM managed to
> do it with IORT, which is part of the ACPI specification. Given that
> you are starting from scratch and that your bindings aren't even in
> the official ACPI spec, there is zero reason not to do the right
> thing.
> 
> Until then, I'm not interested in reviewing more of these patches.
> 
> Thanks,
> 
> 	M.
> 

I understand your viewpoint, we'll change it and make it to be more 
reasonable, thanks very much for your suggestion again, and please 
checkout if what I said above is in line with your opinion.

