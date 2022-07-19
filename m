Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713357A0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiGSOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiGSOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:14:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A315FC65
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:41:45 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9OQtNZi1JMoAA--.12980S3;
        Tue, 19 Jul 2022 21:41:36 +0800 (CST)
Subject: Re: [PATCH V16 14/14] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC
 for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
 <1658153621-40445-15-git-send-email-lvjianmin@loongson.cn>
 <CAAhV-H6sdaVDDifrmD8G-d7zpxC8k3WA_K5w3yp3URsjLTbyfA@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <fa6eebe0-6bf3-ad40-f052-4ae360e99a34@loongson.cn>
Date:   Tue, 19 Jul 2022 21:41:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6sdaVDDifrmD8G-d7zpxC8k3WA_K5w3yp3URsjLTbyfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL9OQtNZi1JMoAA--.12980S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8AF18KrWkuFyDur48Zwb_yoW5tFW5pF
        WjgF45AF4xtFy7Wr9I9w4Uurya9ryFkrW2v3yfKa47Cw1qkrn7WF1kXF129FZ5ArWUWa12
        9F1UXFs8W3ZxZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/19 上午10:25, Huacai Chen wrote:
> Hi, Jianmin,
> 
> On Mon, Jul 18, 2022 at 10:21 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
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
>>   drivers/irqchip/irq-loongarch-cpu.c | 38 +++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h                |  1 +
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 86fa61a..63fbf00 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
>>          case ACPI_IRQ_MODEL_PLATFORM:
>>                  message = "platform specific model";
>>                  break;
>> +       case ACPI_IRQ_MODEL_LPIC:
>> +               message = "LPIC";
>> +               break;
>>          default:
>>                  pr_info("Unknown interrupt routing model\n");
>>                  return -ENODEV;
>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>> index b4db430..a5e0bf0 100644
>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>> @@ -16,6 +16,42 @@
>>   static struct irq_domain *irq_domain;
>>   struct fwnode_handle *cpuintc_handle;
>>
>> +static u32 lpic_gsi_to_irq(u32 gsi)
>> +{
>> +       /* Only pch irqdomain transferring is required for LoongArch. */
>> +       if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
>> +               return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
>> +{
>> +       int id;
>> +       struct fwnode_handle *domain_handle = NULL;
>> +
>> +       switch (gsi) {
>> +       case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
>> +               if (liointc_handle)
>> +                       domain_handle = liointc_handle;
>> +               break;
>> +
>> +       case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
>> +               if (pch_lpc_handle)
>> +                       domain_handle = pch_lpc_handle;
>> +               break;
>> +
>> +       case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
>> +               id = find_pch_pic(gsi);
>> +               if (id >= 0 && pch_pic_handle[id])
>> +                       domain_handle = pch_pic_handle[id];
>> +
> Remove this blank line, please.
> 

Ok, thanks.


> Huacai
>> +               break;
>> +       }
>> +
>> +       return domain_handle;
>> +}
>> +
>>   static void mask_loongarch_irq(struct irq_data *d)
>>   {
>>          clear_csr_ecfg(ECFGF(d->hwirq));
>> @@ -102,6 +138,8 @@ static int __init cpuintc_acpi_init_v1(union acpi_subtable_headers *header,
>>                  panic("Failed to add irqdomain for LoongArch CPU");
>>
>>          set_handle_irq(&handle_cpu_irq);
>> +       acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
>> +       acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
>>          acpi_cascade_irqdomain_init();
>>
>>          return 0;
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index e2b60d5..76520f3 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -105,6 +105,7 @@ enum acpi_irq_model_id {
>>          ACPI_IRQ_MODEL_IOSAPIC,
>>          ACPI_IRQ_MODEL_PLATFORM,
>>          ACPI_IRQ_MODEL_GIC,
>> +       ACPI_IRQ_MODEL_LPIC,
>>          ACPI_IRQ_MODEL_COUNT
>>   };
>>
>> --
>> 1.8.3.1
>>
>>

