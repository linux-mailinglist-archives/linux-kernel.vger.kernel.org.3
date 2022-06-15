Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662F54BFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiFOCud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiFOCuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:50:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE96329C88
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:50:30 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL93uSKliVdVCAA--.5387S3;
        Wed, 15 Jun 2022 10:50:22 +0800 (CST)
Subject: Re: [PATCH RFC V3 00/11] irqchip: Add LoongArch-related irqchip
 drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1654956155-936-1-git-send-email-lvjianmin@loongson.cn>
 <87pmjbp5yh.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <2367ae84-9f3f-716b-2172-e2d8e30cb241@loongson.cn>
Date:   Wed, 15 Jun 2022 10:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87pmjbp5yh.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL93uSKliVdVCAA--.5387S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kKr1rGFWDXryrtFWkZwb_yoW5KF1fpF
        s3Wayjkr4DGrWxJwn8uF18Cry8urZxtFZrJayFqry7Cr9Ygr1xGF10kFZ0k39rArn3KFy2
        vrZagaykGa1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/15 上午12:25, Marc Zyngier wrote:
> On Sat, 11 Jun 2022 15:02:35 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
>> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
>> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
>> boot protocol LoongArch-specific interrupt controllers (similar to APIC)
>> are already added in the ACPI Specification 6.5(which may be published in
>> early June this year and the board is reviewing the draft).
> 
> Can you please make an effort to send patches in coherent way? Here's
> what I see in my email reader:
> 
> [PATCH RFC V2 00/10] irqchip: Add LoongArch-related irqchip drivers
> +[PATCH RFC V3 01/11] APCI: irq: Add support for multiple GSI domains
> +[PATCH RFC V3 02/11] genirq/generic_chip: export irq_unmap_generic_chip
> +[PATCH RFC V3 03/11] irqchip: Adjust Kconfig for Loongson
> +[PATCH RFC V3 04/11] irqchip: Add LoongArch CPU interrupt controller support
> \[PATCH RFC V3 05/11] irqchip: create library file for LoongArch irqchip driver
> [PATCH RFC V3 06/11] irqchip/loongson-pch-pic: Add ACPI init support
> +[PATCH RFC V3 07/11] irqchip/loongson-pch-msi: Add ACPI init support
> +[PATCH RFC V3 08/11] irqchip/loongson-htvec: Add ACPI init support
> +[PATCH RFC V3 09/11] irqchip/loongson-liointc: Add ACPI init support
> +[PATCH RFC V3 10/11] irqchip: Add Loongson Extended I/O interrupt controller support
> \[PATCH RFC V3 11/11] irqchip: Add Loongson PCH LPC controller support
> [PATCH RFC V3 00/11] irqchip: Add LoongArch-related irqchip drivers
> 
> Three threads, with inconsistent version numbers, inconsistent patch
> numbering, with a split in the middle, and this final cover letter
> that isn't followed by anything.  If you make a mistake, that's
> fine. Fix it, and resend the series properly, possibly with a new
> version number. Pro tip: you should only use 'git send-email', and
> only once to send all your patches after having written the cover
> letter. If you have to do anything else, you're doing something
> wrong.
> 

Yes, Marc, thanks for your guidance. It's my mistake that I sent an old 
cover letter when sending the patch series， so I sent a correct cover 
letter after I found the mistake. I'll do it carefully in future.

> Also, please drop this 'RFC', as we're way past the RFC stage (to me,
> RFC means "I don't know what I'm doing yet, this is not ready to be
> merged").
> 

Ok, I'll resend the series properly without 'RFC'.


> [...]
> 
>> Jianmin Lv (10):
>>    APCI: irq: Add support for multiple GSI domains
> 
> I'm usually not too attached to authorship, but I definitely wrote
> that one, and that casts some doubt on the authorship of all the
> patches. For example, patch #4 has:
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> but doesn't list Huacai Chen as the author. Either they are, and the
> patch needs a From: line like in patch #3, or this is co-developed,
> and you need the Co-Developed: tag ([1] has all the details).
> 

Thanks for your guidance again, I'm so sorry and please forgive
my ignorance about these rules. I'll do it as your guidance here
in future.


> I'll go and review the actual patches before the end of the week, but
> you definitely need to address the patch attributions in this series.
> 

Ok, I'll address the patch attributions in this series as soon as
possible and resend it.


> Thanks,
> 
> 	M.
> 
> [1] Documentation/process/submitting-patches.rst
> 

