Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080356B27D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiGHGCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGHGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:02:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED4FD7B344
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:02:42 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT9J3yMdiFb0QAA--.4650S3;
        Fri, 08 Jul 2022 14:02:31 +0800 (CST)
Subject: Re: [PATCH V14 01/15] ACPICA: MADT: Add LoongArch APICs support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-2-git-send-email-lvjianmin@loongson.cn>
 <875yk9mdk3.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <d96296d0-0e12-a2e3-7d7f-f04c4c6fb989@loongson.cn>
Date:   Fri, 8 Jul 2022 14:02:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <875yk9mdk3.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxT9J3yMdiFb0QAA--.4650S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43tw1xGF1kAr4DCF1kuFg_yoW8AFyrpr
        WS9a1DGw4DJ3ZYyFsrK3yFqF1a9an3ta4xJw4qkFsru3sxt343JF109F15Wa9xCr95JF12
        vrWUGa1kuF18AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 下午6:18, Marc Zyngier wrote:
> On Sun, 03 Jul 2022 09:45:18 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> LoongArch-specific interrupt controllers (similar to APIC) are added
>> in the next revision of ACPI Specification (current revision is 6.4),
>> which including CORE_PIC (CPUINTC), LIO_PIC (LIOINTC), EIO_PIC (EIOINTC),
>> HT_PIC (HTVECINTC), BIO_PIC (PCHINTC), LPC_PIC (PCHLPC) and MSI_PIC
>> (PCHMSI). This patch add their definition.
>>
>> ACPI changes of LoongArch-specific interrupt controllers have already
>> been approved in the ECRs, and will be public in the next revision of
>> ACPI Specification.
>>
>> Reference: https://mantis.uefi.org/mantis/view.php?id=2203
>> Reference: https://mantis.uefi.org/mantis/view.php?id=2313
> 
> These links are pretty useless without an account on uefi.org (most
> people don't have one, and I certainly don't). Is there a link to
> something *public*?
> 

Sorry for inaccessible links, I take the patch from ACPICA, and the 
links here are intended to provide to ACPI maintainers when the patch 
was submitted to ACPICA.

The ACPI spec 6.5 is not published yet, and I have asked the ACPI spec 
work group, their reply is that I can not share the unpublished spec
draft link to the public, only using for member to review. I think
I can put the ECR(Engineering Change Request) file that described
LoongArch APICs on my github and put the link in the patch.

https://github.com/lvjianmin-loongson/acpica/blob/master/Add%20APIC%20Structures%20for%20Loongarch%20in%20MADT-rev3.pdf

 From mail of the ACPI spec work group , the ACPI spec 6.5 will be 
published in late July or early August.


> Thanks,
> 
> 	M.
> 

