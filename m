Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688A1561058
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiF3Ekg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiF3Ekf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:40:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1086369E9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:40:33 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9c6Kb1i8pNlAA--.12783S3;
        Thu, 30 Jun 2022 12:40:27 +0800 (CST)
Subject: Re: [PATCH V13 05/13] irqchip: Add Loongson PCH LPC controller
 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-6-git-send-email-lvjianmin@loongson.cn>
 <87wncz20st.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <4366e5a0-0ba6-52fe-3f68-ce45c3ad1ea7@loongson.cn>
Date:   Thu, 30 Jun 2022 12:40:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87wncz20st.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX9c6Kb1i8pNlAA--.12783S3
X-Coremail-Antispam: 1UD129KBjvJXoWfXr17WF47ZrWDurWrAw1rCrg_yoWDZF15pF
        W5Za17KF4UXr1jqr1v9a1DZr9xtwn3KFWjka1rGa43Jr9Fvrn2kF1vvFnruF4kAr47KF12
        vF4YyF97uF15CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/29 下午6:58, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 12:39:49 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> PCH-LPC stands for "LPC Interrupts" that described in Section 24.3 of
>> "Loongson 7A1000 Bridge User Manual". For more information please refer
>> Documentation/loongarch/irq-chip-model.rst.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h       |   4 +-
>>   arch/loongarch/kernel/irq.c            |   1 -
>>   drivers/irqchip/Kconfig                |   8 ++
>>   drivers/irqchip/Makefile               |   1 +
>>   drivers/irqchip/irq-loongson-pch-lpc.c | 203 +++++++++++++++++++++++++++++++++
>>   5 files changed, 214 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index ace3ea6..48c0ce4 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -104,7 +104,7 @@ struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
>>   
>>   struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_ht_pic *acpi_htvec);
>> -struct irq_domain *pch_lpc_acpi_init(struct irq_domain *parent,
>> +int pch_lpc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lpc_pic *acpi_pchlpc);
>>   struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_msi_pic *acpi_pchmsi);
>> @@ -121,7 +121,7 @@ struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
>>   
>>   extern struct irq_domain *cpu_domain;
>>   extern struct irq_domain *liointc_domain;
>> -extern struct irq_domain *pch_lpc_domain;
>> +extern struct fwnode_handle *pch_lpc_handle;
>>   extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>   extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>>   
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index b34b8d7..07d6059 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -27,7 +27,6 @@
>>   
>>   struct irq_domain *cpu_domain;
>>   struct irq_domain *liointc_domain;
>> -struct irq_domain *pch_lpc_domain;
>>   struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>   struct irq_domain *pch_pic_domain[MAX_IO_PICS];
>>   
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 1f23a6b..c1d527f 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -591,6 +591,14 @@ config LOONGSON_PCH_MSI
>>   	help
>>   	  Support for the Loongson PCH MSI Controller.
>>   
>> +config LOONGSON_PCH_LPC
>> +	bool "Loongson PCH LPC Controller"
>> +	depends on MACH_LOONGSON64
>> +	default (MACH_LOONGSON64 && LOONGARCH)
>> +	select IRQ_DOMAIN_HIERARCHY
>> +	help
>> +	  Support for the Loongson PCH LPC Controller.
>> +
>>   config MST_IRQ
>>   	bool "MStar Interrupt Controller"
>>   	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 5b67450..242b8b3 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -108,6 +108,7 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
>>   obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>>   obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
>>   obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
>> +obj-$(CONFIG_LOONGSON_PCH_LPC)		+= irq-loongson-pch-lpc.o
>>   obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
>>   obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
>>   obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
>> diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
>> new file mode 100644
>> index 0000000..7e4d89a
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-loongson-pch-lpc.c
>> @@ -0,0 +1,203 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Loongson LPC Interrupt Controller support
>> + *
>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>> + */
>> +
>> +#define pr_fmt(fmt) "lpc: " fmt
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +
>> +/* Registers */
>> +#define LPC_INT_CTL		0x00
>> +#define LPC_INT_ENA		0x04
>> +#define LPC_INT_STS		0x08
>> +#define LPC_INT_CLR		0x0c
>> +#define LPC_INT_POL		0x10
>> +#define LPC_COUNT		16
>> +
>> +struct pch_lpc {
>> +	void __iomem		*base;
>> +	struct irq_domain	*lpc_domain;
>> +	raw_spinlock_t		lpc_lock;
>> +	u32			saved_reg_ctl;
>> +	u32			saved_reg_ena;
>> +	u32			saved_reg_pol;
>> +};
>> +
>> +struct fwnode_handle *pch_lpc_handle;
>> +
>> +static void ack_lpc_irq(struct irq_data *d)
>> +{
>> +	unsigned long flags;
>> +	struct pch_lpc *priv = d->domain->host_data;
>> +
>> +	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
>> +	writel(0x1 << d->hwirq, priv->base + LPC_INT_CLR);
>> +	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
>> +}
>> +static void mask_lpc_irq(struct irq_data *d)
>> +{
>> +	unsigned long flags;
>> +	struct pch_lpc *priv = d->domain->host_data;
>> +
>> +	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
>> +	writel(readl(priv->base + LPC_INT_ENA) & (~(0x1 << (d->hwirq))),
>> +			priv->base + LPC_INT_ENA);
>> +	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
>> +}
>> +
>> +static void unmask_lpc_irq(struct irq_data *d)
>> +{
>> +	unsigned long flags;
>> +	struct pch_lpc *priv = d->domain->host_data;
>> +
>> +	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
>> +	writel(readl(priv->base + LPC_INT_ENA) | (0x1 << (d->hwirq)),
>> +			priv->base + LPC_INT_ENA);
>> +	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
>> +}
>> +
>> +static int lpc_set_type(struct irq_data *d, unsigned int type)
>> +{
>> +	u32 val;
>> +	u32 mask = 0x1 << (d->hwirq);
>> +	struct pch_lpc *priv = d->domain->host_data;
>> +
>> +	if (!(type & IRQ_TYPE_LEVEL_MASK))
>> +		return 0;
>> +
>> +	val = readl(priv->base + LPC_INT_POL);
>> +
>> +	if (type == IRQ_TYPE_LEVEL_HIGH)
>> +		val |= mask;
>> +	else
>> +		val &= ~mask;
>> +
>> +	writel(val, priv->base + LPC_INT_POL);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip pch_lpc_irq_chip = {
> 
> Make this const.
> 

Ok, thanks.


>> +	.name			= "PCH LPC",
>> +	.irq_mask		= mask_lpc_irq,
>> +	.irq_unmask		= unmask_lpc_irq,
>> +	.irq_ack		= ack_lpc_irq,
>> +	.irq_set_type		= lpc_set_type,
> 
> nit: please use the same format for all callbacks: lpc_irq_OPERATION
> (lpc_irq_mask, lpc_irq_set_type...), which makes it much easier to
> read.
> 

Ok.


>> +	.flags			= IRQCHIP_SKIP_SET_WAKE,
>> +};
>> +
>> +static void lpc_irq_dispatch(struct irq_desc *desc)
>> +{
>> +	u32 pending, bit, virq;
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct pch_lpc *priv = irq_desc_get_handler_data(desc);
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	pending = readl(priv->base + LPC_INT_ENA);
>> +	pending &= readl(priv->base + LPC_INT_STS);
>> +	if (!pending)
>> +		spurious_interrupt();
>> +
>> +	while (pending) {
>> +		bit = __ffs(pending);
>> +		virq = irq_linear_revmap(priv->lpc_domain, bit);
>> +
>> +		generic_handle_irq(bit);
> 
> Replace the whole thing with a call to generic_handle_domain_irq(). No
> new code should ever have to use generic_handle_irq().
> 

Ok, thanks, got it.


>> +		pending &= ~BIT(bit);
>> +	}
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static int pch_lpc_map(struct irq_domain *d, unsigned int irq,
>> +			irq_hw_number_t hw)
>> +{
>> +	irq_set_chip_and_handler(irq, &pch_lpc_irq_chip, handle_level_irq);
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops pch_lpc_domain_ops = {
>> +	.map 		= pch_lpc_map,
>> +	.translate	= irq_domain_translate_twocell,
>> +};
>> +
>> +static void pch_lpc_reset(struct pch_lpc *priv)
>> +{
>> +	/* Enable the LPC interrupt, bit31: en  bit30: edge */
>> +	writel(0x80000000, priv->base + LPC_INT_CTL);
> 
> Please don't hardcode numbers. Add the proper bit definitions.
> 

Ok.


>> +	writel(0, priv->base + LPC_INT_ENA);
>> +	/* Clear all 18-bit interrpt bit */
>> +	writel(0x3ffff, priv->base + LPC_INT_CLR);
> 
> If that's just a mask, then use GENMASK(17, 0) instead.
> 

Ok.


>> +}
>> +
>> +static int pch_lpc_disabled(struct pch_lpc *priv)
>> +{
>> +	return (readl(priv->base + LPC_INT_ENA) == 0xffffffff) &&
>> +			(readl(priv->base + LPC_INT_STS) == 0xffffffff);
>> +}
>> +
>> +int __init pch_lpc_acpi_init(struct irq_domain *parent,
>> +					struct acpi_madt_lpc_pic *acpi_pchlpc)
>> +{
>> +	int parent_irq;
>> +	struct pch_lpc *priv;
>> +	struct irq_fwspec fwspec;
>> +	struct fwnode_handle *irq_handle;
>> +
>> +	if (!acpi_pchlpc)
>> +		return -EINVAL;
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	raw_spin_lock_init(&priv->lpc_lock);
>> +
>> +	priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
>> +	if (!priv->base)
>> +		goto free_priv;
>> +
>> +	if (pch_lpc_disabled(priv)) {
>> +		pr_err("Failed to get LPC status\n");
>> +		goto iounmap_base;
>> +	}
>> +
>> +	irq_handle = irq_domain_alloc_named_fwnode("lpcintc");
>> +	if (!irq_handle) {
>> +		pr_err("Unable to allocate domain handle\n");
>> +		goto iounmap_base;
>> +	}
>> +
>> +	priv->lpc_domain = irq_domain_create_linear(irq_handle, LPC_COUNT,
>> +					&pch_lpc_domain_ops, priv);
>> +	if (!priv->lpc_domain) {
>> +		pr_err("Failed to create IRQ domain\n");
>> +		goto iounmap_base;
> 
> You also need to free the fwnode.
> 

Yes, thanks.

>> +	}
>> +	pch_lpc_reset(priv);
>> +
>> +	fwspec.fwnode = parent->fwnode;
>> +	fwspec.param[0] = acpi_pchlpc->cascade;
>> +	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>> +	fwspec.param_count = 2;
>> +	parent_irq = irq_create_fwspec_mapping(&fwspec);
>> +	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
>> +
>> +	pch_lpc_handle = irq_handle;
>> +	return 0;
>> +
>> +iounmap_base:
>> +	iounmap(priv->base);
>> +free_priv:
>> +	kfree(priv);
>> +
>> +	return -ENOMEM;
>> +}
>> -- 
>> 1.8.3.1
>>
>>
> 
> Thanks,
> 
> 	M.
> 

