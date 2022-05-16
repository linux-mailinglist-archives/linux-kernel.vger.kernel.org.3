Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4550528513
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiEPNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiEPNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:13:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32C92645A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:13:19 -0700 (PDT)
Received: from [10.40.53.182] (unknown [10.40.53.182])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxcNrhTYJiL0MYAA--.20951S3;
        Mon, 16 May 2022 21:13:06 +0800 (CST)
Subject: Re: [PATCH RFC 00/10] irqchip: Add LoongArch-related irqchip drivers
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <9c99241f-6214-8c1c-7d15-7bbbc1b06b85@loongson.cn>
Date:   Mon, 16 May 2022 21:13:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1652585833-22526-1-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxcNrhTYJiL0MYAA--.20951S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyfKry5CryUWF15Jw4xWFg_yoW3ZFyUpa
        13Cr1aqF1UKry3XrnxJw48XFy5Jrn3Jw4DGa1xKryxXr1vyr1DGr1UAF1rXrZrAryxWw1j
        vFW8tw18G3Z8AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/15 上午11:37, Jianmin Lv wrote:
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
> are already added in the ACPI Specification 6.5(which may be published in
> early June this year and the board is reviewing the draft).
> 
> Currently, LoongArch based processors (e.g. Loongson-3A5000) can only
> work together with LS7A chipsets. The irq chips in LoongArch computers
> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> 
> CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC are
> per-package controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are all
> controllers out of CPU (i.e., in chipsets). These controllers (in other
> words, irqchips) are linked in a hierarchy, and there are two models of
> hierarchy (legacy model and extended model).
> 
> Legacy IRQ model:
> 
> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
> gathered by HTVECINTC, and then go to LIOINTC, and then CPUINTC.
> 
>   +---------------------------------------------+
>   |                                             |
>   |    +-----+     +---------+     +-------+    |
>   |    | IPI | --> | CPUINTC | <-- | Timer |    |
>   |    +-----+     +---------+     +-------+    |
>   |                     ^                       |
>   |                     |                       |
>   |                +---------+     +-------+    |
>   |                | LIOINTC | <-- | UARTs |    |
>   |                +---------+     +-------+    |
>   |                     ^                       |
>   |                     |                       |
>   |               +-----------+                 |
>   |               | HTVECINTC |                 |
>   |               +-----------+                 |
>   |                ^         ^                  |
>   |                |         |                  |
>   |          +---------+ +---------+            |
>   |          | PCH-PIC | | PCH-MSI |            |
>   |          +---------+ +---------+            |
>   |            ^     ^           ^              |
>   |            |     |           |              |
>   |    +---------+ +---------+ +---------+      |
>   |    | PCH-LPC | | Devices | | Devices |      |
>   |    +---------+ +---------+ +---------+      |
>   |         ^                                   |
>   |         |                                   |
>   |    +---------+                              |
>   |    | Devices |                              |
>   |    +---------+                              |
>   |                                             |
>   |                                             |
>   +---------------------------------------------+
> 
> Extended IRQ model:
> 
> In this model, the IPI (Inter-Processor Interrupt) and CPU Local Timer
> interrupt go to CPUINTC directly, CPU UARTS interrupts go to LIOINTC,
> while all other devices interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and
> gathered by EIOINTC, and then go to to CPUINTC directly.
> 
>   +--------------------------------------------------------+
>   |                                                        |
>   |         +-----+     +---------+     +-------+          |
>   |         | IPI | --> | CPUINTC | <-- | Timer |          |
>   |         +-----+     +---------+     +-------+          |
>   |                      ^       ^                         |
>   |                      |       |                         |
>   |               +---------+ +---------+     +-------+    |
>   |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
>   |               +---------+ +---------+     +-------+    |
>   |                ^       ^                               |
>   |                |       |                               |
>   |         +---------+ +---------+                        |
>   |         | PCH-PIC | | PCH-MSI |                        |
>   |         +---------+ +---------+                        |
>   |           ^     ^           ^                          |
>   |           |     |           |                          |
>   |   +---------+ +---------+ +---------+                  |
>   |   | PCH-LPC | | Devices | | Devices |                  |
>   |   +---------+ +---------+ +---------+                  |
>   |        ^                                               |
>   |        |                                               |
>   |   +---------+                                          |
>   |   | Devices |                                          |
>   |   +---------+                                          |
>   |                                                        |
>   |                                                        |
>   +--------------------------------------------------------+
> 
> The hierarchy model is constructed by parsing irq contronler structures
> in MADT. Some controllers((e.g. LIOINTC, HTVECINTC, EIOINTC and PCH-LPC)
> are hardcodingly connected to their parents, so their irqdomins are
> separately routed to their parents in a fixed way. Some controllers
> (e.g. PCH-PIC and PCH-MSI) could be routed to different parents for different
> CPU. The firmware will config EIOINTC for the newer CPU and config HTVECINTC
> for old CPU in MADT. By this way, PCH-PIC and PCH-MSI irqdomain can only be
> routed one parent irqdomin: HTVECINTC or EIOINTC.
> 
> Cross-compile tool chain to build kernel:
> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-20211202-cross-tools.tar.xz
> 
> A CLFS-based Linux distro:
> https://github.com/loongson/build-tools/releases/latest/download/loongarch64-clfs-system-2021-12-02.tar.bz2
> 
> Loongson and LoongArch documentations:
> https://github.com/loongson/LoongArch-Documentation
> 
> 
> V1 -> V2:
> 1, Remove queued patches;
> 2, Move common logic of DT/ACPI probing to common functions;
> 3, Split .suspend()/.resume() functions to separate patches.
> 
> V2 -> V3:
> 1, Fix a bug for loongson-pch-pic probe;
> 2, Some minor improvements for LPC controller.
> 
> V3 -> V4:
> 1, Rework the CPU interrupt controller driver;
> 2, Some minor improvements for other controllers.
> 
> V4 -> V5:
> 1, Add a description of LoonArch's IRQ model;
> 2, Support multiple EIOINTCs in one system;
> 3, Some minor improvements for other controllers.
> 
> V5 -> V6:
> 1, Attach a fwnode to CPUINTC irq domain;
> 2, Use raw spinlock instead of generic spinlock;
> 3, Improve the method of restoring EIOINTC state;
> 4, Update documentation, comments and commit messages.
> 
> V6 -> V7:
> 1, Fix build warnings reported by kernel test robot.
> 
> V7 -> V8:
> 1, Add arguments sanity checking for irqchip init functions;
> 2, Support Loongson-3C5000 (One NUMA Node includes 4 EIOINTC Node).
> 
> V8 -> V9:
> 1, Rebase on 5.17-rc5;
> 2, Update cover letter;
> 3, Some small improvements.
> 
> V9 -> V10:
> 1, Rebase on 5.17-rc6;
> 2, Fix build warnings reported by kernel test robot.
> 
> V10 -> V11:
> 1, Rebase on 5.18-rc4;
> 2, Fix irq affinity setting for EIOINTC;
> 3, Fix hwirq allocation failure for EIOINTC.
> 
> V11 -> RFC:
> 1, Refactored the way to build irqchip hierarchy topology.
> 

Hi, Marc

The irqchip topology building is refactored as following way in this RFC 
patches according to my reply in V10, please help to review them if they 
are correct, thanks very much!

- Only call irqchip_init() in arch file.
- Use IRQCHIP_ACPI_DECLARE to declare entry of CORE PIC.
- Initialize irqdomains in fixed way from their parent irqdomain for 
hardcodingly routing irqchips(liointc, htvec, eiointc and pch-lpc) in 
hardware.
- Initialize irqdomains in scaled way for scalable routing 
irqchips(pch-pic and pch-msi).
- For eiointc and htvec, they are exclusive, and only one kind of them 
can be configured in MADT.

> Huacai Chen (1):
>    irqchip: Adjust Kconfig for Loongson
> 
> Jianmin Lv (9):
>    irqchip: Add LoongArch CPU interrupt controller support
>    irqchip/loongson-pch-pic: Add ACPI init support
>    irqchip/loongson-pch-pic: Add suspend/resume support
>    irqchip/loongson-pch-msi: Add ACPI init support
>    irqchip/loongson-htvec: Add ACPI init support
>    irqchip/loongson-htvec: Add suspend/resume support
>    irqchip/loongson-liointc: Add ACPI init support
>    irqchip: Add Loongson Extended I/O interrupt controller  support
>    irqchip: Add Loongson PCH LPC controller support
> 
>   drivers/irqchip/Kconfig                    |  38 ++-
>   drivers/irqchip/Makefile                   |   3 +
>   drivers/irqchip/irq-loongarch-cpu.c        | 134 ++++++++++
>   drivers/irqchip/irq-loongarch-pic-common.c |  66 +++++
>   drivers/irqchip/irq-loongarch-pic-common.h |  22 ++
>   drivers/irqchip/irq-loongson-eiointc.c     | 381 +++++++++++++++++++++++++++++
>   drivers/irqchip/irq-loongson-htvec.c       | 148 ++++++++---
>   drivers/irqchip/irq-loongson-liointc.c     | 215 ++++++++++------
>   drivers/irqchip/irq-loongson-pch-lpc.c     | 225 +++++++++++++++++
>   drivers/irqchip/irq-loongson-pch-msi.c     | 138 +++++++----
>   drivers/irqchip/irq-loongson-pch-pic.c     | 214 ++++++++++++++--
>   include/linux/cpuhotplug.h                 |   1 +
>   12 files changed, 1398 insertions(+), 187 deletions(-)
>   create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h
>   create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
>   create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
> 

