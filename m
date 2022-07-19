Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C857A13B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiGSOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiGSOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E983B954
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:42:14 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9KttNZiHJQoAA--.13177S3;
        Tue, 19 Jul 2022 21:42:06 +0800 (CST)
Subject: Re: [PATCH V16 07/14] irqchip: remove COMPILE_TEST for pch-pic and
 pch-msi
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
 <1658153621-40445-8-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H7VRwAEELp_OrGsk7Rj73Xbwj-4A0yoyaxpMspPV83W3A@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <52d431a0-85d5-faa9-f9d4-4784adabf6b8@loongson.cn>
Date:   Tue, 19 Jul 2022 21:42:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7VRwAEELp_OrGsk7Rj73Xbwj-4A0yoyaxpMspPV83W3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxn9KttNZiHJQoAA--.13177S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1kArWktrWftr4DGry7trb_yoW8XFy5pa
        93Aa1Ik3W2kF45C3s0vry8Gr15Arn3JayDCa15J34UZr9ru34kKr1DAFnFqrWDAr43Kr4I
        vFWv9F40kF43uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUov38UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/19 上午9:06, Huacai Chen wrote:
> Hi, Jianmin,
> 
> This patch can be squashed into "irqchip/loongson-pch-pic: Add ACPI
> init support" and "irqchip/loongson-pch-msi: Add ACPI init support",
> thanks.
> 

Ok, thanks.


> Huacai
> 
> On Mon, Jul 18, 2022 at 10:13 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> Loongson's pch-pic and pch-msi will have some arch-specific
>> code, so we remove the COMPILE_TEST dependency to avoid build
>> warnings.
>>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/irqchip/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index c1d527f..8844e6b 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -574,7 +574,7 @@ config LOONGSON_HTVEC
>>
>>   config LOONGSON_PCH_PIC
>>          bool "Loongson PCH PIC Controller"
>> -       depends on MACH_LOONGSON64 || COMPILE_TEST
>> +       depends on MACH_LOONGSON64
>>          default MACH_LOONGSON64
>>          select IRQ_DOMAIN_HIERARCHY
>>          select IRQ_FASTEOI_HIERARCHY_HANDLERS
>> @@ -583,7 +583,7 @@ config LOONGSON_PCH_PIC
>>
>>   config LOONGSON_PCH_MSI
>>          bool "Loongson PCH MSI Controller"
>> -       depends on MACH_LOONGSON64 || COMPILE_TEST
>> +       depends on MACH_LOONGSON64
>>          depends on PCI
>>          default MACH_LOONGSON64
>>          select IRQ_DOMAIN_HIERARCHY
>> --
>> 1.8.3.1
>>
>>

