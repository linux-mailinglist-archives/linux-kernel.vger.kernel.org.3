Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF356B0ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiGHDSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiGHDSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:18:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1D57747AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:18:07 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axf+LnocdiXIkQAA--.44347S3;
        Fri, 08 Jul 2022 11:18:00 +0800 (CST)
Subject: Re: [PATCH V14 14/15] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC
 for LoongArch
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-15-git-send-email-lvjianmin@loongson.cn>
 <87y1x5krjd.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <f76927be-8c8c-5bbe-ef5c-a63f4a09b29c@loongson.cn>
Date:   Fri, 8 Jul 2022 11:17:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87y1x5krjd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axf+LnocdiXIkQAA--.44347S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43AFy7KFWfZr17Gw1rJFb_yoW8uFy3pF
        WUu3WYyr47ta47Wr9xGw1UZFy5Za4fKrWIqFWfK3srZr1DGF9ruFy8Ar9FvFWkCr4UCw42
        9F18tF4UCF1DAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9I1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE
        -syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 下午8:59, Marc Zyngier wrote:
> On Sun, 03 Jul 2022 09:45:31 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> For LoongArch, ACPI_IRQ_MODEL_LPIC is introduced, and then the
>> callback acpi_get_gsi_domain_id and acpi_gsi_to_irq_fallback are
>> implemented.
>>
>> The acpi_get_gsi_domain_id callback returns related fwnode handle
>> of irqdomain for different GSI range.
>>
>> The acpi_gsi_to_irq_fallback will create new mapping for gsi when
>> the mapping of it is not found.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/acpi/bus.c                  |  3 +++
>>   drivers/irqchip/irq-loongarch-cpu.c | 37 +++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h                |  1 +
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 86fa61a..63fbf00 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
>>   	case ACPI_IRQ_MODEL_PLATFORM:
>>   		message = "platform specific model";
>>   		break;
>> +	case ACPI_IRQ_MODEL_LPIC:
>> +		message = "LPIC";
>> +		break;
>>   	default:
>>   		pr_info("Unknown interrupt routing model\n");
>>   		return -ENODEV;
>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>> index c2f7411..1b241d7 100644
>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>> @@ -15,6 +15,41 @@
>>   
>>   static struct irq_domain *irq_domain;
>>   
>> +static int lpic_gsi_to_irq(u32 gsi)
>> +{
>> +	/* Only pch irqdomain transferring is required for LoongArch. */
>> +	if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
>> +		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>> +	return -1;
> 
> The expected return value on failure is 0 (which indicates that no
> interrupt was mapped). Here, things will break as acpi_gsi_to_irq()
> stores the result as unsigned, and compares the result to 0.
> 

Ok, thanks, I'll change the return value to 0 on failure and change 
return type to unsigned int.


> 	M.
> 

