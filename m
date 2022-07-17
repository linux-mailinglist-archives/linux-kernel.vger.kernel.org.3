Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C995772A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 03:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiGQBGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 21:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGQBGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 21:06:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A5E711801
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 18:06:21 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9GFYNNiHRYkAA--.6968S3;
        Sun, 17 Jul 2022 09:06:13 +0800 (CST)
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
Date:   Sun, 17 Jul 2022 09:06:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87less52bx.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn9GFYNNiHRYkAA--.6968S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15XrWxtrWfCF1xKFyrCrg_yoW5JFWUpF
        W7WFW2ka1UArWUAw1kJ3yFqa4Sv3s3Kr97Jan3uw4UCrnxuw1DX347tFs3uFy7Cr4DK3W0
        9ayrtws5Wa1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/17 上午2:39, Marc Zyngier wrote:
> On Fri, 15 Jul 2022 08:05:36 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
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
>> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
>> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Main
>> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Controller
>> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> 
> [...]
> 
> Compiling this series for loongarch with loongson3_defconfig on top of
> 5.19-rc3 results in the following:
> 
> loongarch64-linux-ld: drivers/irqchip/irq-loongson-eiointc.o: in function `.L60':
> irq-loongson-eiointc.c:(.init.text+0x4c): undefined reference to `pch_msi_acpi_init'
> loongarch64-linux-ld: drivers/irqchip/irq-loongson-htvec.o: in function `pch_msi_parse_madt':
> irq-loongson-htvec.c:(.init.text+0x14): undefined reference to `pch_msi_acpi_init'
> make: *** [Makefile:1164: vmlinux] Error 1
> 
> I *really* would have expected this series to be in a better shape
> after over 15 rounds, but it looks like I'm expecting too much. I
> haven't investigated the breakage, but this should (at the very least)
> pass the defconfig test and optional drivers not being selected.
> 
> The corresponding MIPS configuration seems to build fine.
> 
> 	M.
> 

Hi, Marc

Sorry for that first, pch_msi_acpi_init is defined in pch_msi driver 
which is compiled depend on CONFIG_PCI, and I test the patches each time 
with PCI patches and other(or else, kernel can not be boot), so I'm ok 
for testing the patches. The PCI patches has been accepted by PCI 
maintainers and will be merged in this merge window.

I don't know how to deal with this situation. Should I add *#ifdef 
CONFIG_PCI* at position of calling pch_msi_acpi_init or some other way?

Thanks sincerely.

