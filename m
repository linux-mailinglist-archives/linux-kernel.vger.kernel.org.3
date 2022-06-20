Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72107550ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiFTDMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiFTDMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:12:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E663DB7C2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:12:22 -0700 (PDT)
Received: from [10.20.42.13] (unknown [10.20.42.13])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9+K5a9i3B5OAA--.20341S3;
        Mon, 20 Jun 2022 11:12:10 +0800 (CST)
Subject: Re: [PATCH V12 04/10] irqchip: create library file for LoongArch
 irqchip driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
 <1655273250-23495-5-git-send-email-lvjianmin@loongson.cn>
 <877d5dga4k.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <7fa780d5-406d-6112-e4b4-b56ad291353f@loongson.cn>
Date:   Mon, 20 Jun 2022 11:12:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877d5dga4k.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxj9+K5a9i3B5OAA--.20341S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy3Ww48ur4DZw13AF13Jwb_yoWxXF4fpF
        W5XFZrtr4UJryjgrnava15WFySyw1fCFWUKayrKa4a9ryq9rykWF1vy3sF9FyrAr48WF12
        vF43tF13u3Z8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267
        AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x07b0a0QUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/19 上午1:22, Marc Zyngier wrote:
> On Wed, 15 Jun 2022 07:07:24 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> The library file contains following content:
>> - Implement acpi_get_gsi_domain_id callback.
>> - Implement initialization of vector group entries and APIs
>>    for building hierachy irqdomains.
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/irqchip/Makefile                   |   2 +-
>>   drivers/irqchip/irq-loongarch-pic-common.c | 122 +++++++++++++++++++++++++++++
>>   drivers/irqchip/irq-loongarch-pic-common.h |  39 +++++++++
>>   3 files changed, 162 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
>>   create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 6894a13..2d0d871 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -103,7 +103,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>>   obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
>> -obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-pic-common.o
>>   obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
>>   obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
>>   obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
>> diff --git a/drivers/irqchip/irq-loongarch-pic-common.c b/drivers/irqchip/irq-loongarch-pic-common.c
>> new file mode 100644
>> index 0000000..2f75362
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-loongarch-pic-common.c
>> @@ -0,0 +1,122 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
>> + */
>> +
>> +#include <linux/irq.h>
>> +#include <linux/pci.h>
>> +#include <linux/acpi.h>
>> +#include "irq-loongarch-pic-common.h"
>> +
>> +static struct acpi_vector_group vector_group[MAX_IO_PICS];
>> +
>> +struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
>> +
>> +struct fwnode_handle *liointc_handle;
>> +struct fwnode_handle *pch_lpc_handle;
>> +struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
>> +struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
> 
> Why aren't these in individual drivers, and then have accessors to
> retrieve them?
> 

Ok, I'll try to put them in individual drivers.


>> +
>> +static int find_pch_pic(u32 gsi)
>> +{
>> +	int i, start, end;
>> +
>> +	/* Find the PCH_PIC that manages this GSI. */
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
>> +
>> +		if (!irq_cfg)
>> +			return -1;
>> +
>> +		start = irq_cfg->gsi_base;
>> +		end   = irq_cfg->gsi_base + irq_cfg->size;
>> +		if (gsi >= start && gsi < end)
>> +			return i;
>> +	}
>> +
>> +	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
>> +	return -1;
>> +}
> 
> Same thing. This really should be in the PCH driver, and be called by
> lpic_get_gsi_domain().
> 

Ok, I'll try to put them in PCH driver.


>> +
>> +struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
>> +{
>> +	int id;
>> +	struct fwnode_handle *domain_handle = NULL;
>> +
>> +	switch (gsi) {
>> +	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
>> +		if (liointc_handle)
>> +			domain_handle = liointc_handle;
>> +		break;
>> +
>> +	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
>> +		if (pch_lpc_handle)
>> +			domain_handle = pch_lpc_handle;
>> +		break;
>> +
>> +	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
>> +		id = find_pch_pic(gsi);
>> +		if (id >= 0 && pch_pic_handle[id])
>> +			domain_handle = pch_pic_handle[id];
>> +
>> +		break;
>> +	}
>> +
>> +	return domain_handle;
>> +}
>> +
>> +static int pci_mcfg_parse(struct acpi_table_header *header)
>> +{
>> +	struct acpi_table_mcfg *mcfg;
>> +	struct acpi_mcfg_allocation *mptr;
>> +	int i, n;
>> +
>> +	if (header->length < sizeof(struct acpi_table_mcfg))
>> +		return -EINVAL;
>> +
>> +	n = (header->length - sizeof(struct acpi_table_mcfg)) /
>> +					sizeof(struct acpi_mcfg_allocation);
>> +	mcfg = (struct acpi_table_mcfg *)header;
>> +	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
>> +
>> +	for (i = 0; i < n; i++, mptr++)
>> +		vector_group[mptr->pci_segment].node = (mptr->address >> 44) & 0xf;
>> +
>> +	return 0;
>> +}
>> +
>> +void __init init_vector_parent_group(void)
>> +{
>> +	acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
>> +}
> 
> I really don't think the PCI code should be anywhere near
> this. Frankly, this file looks like a dumping ground for totally
> unrelated stuff.
> 


For ARM, the msi domain of a pci device is matched by comparing PCI 
segment of it and PCI segment of msi domain's parent domain(its domain).
The PCI segment number here is as in MCFG and as returned by _SEG in the 
namespace.

For LoongArch, a similar way is used, but we don't use
IORT-like table, rather, we directly used PCI segment and Base 
address(node information is in bit44-47 of the address) in MCFG for it, 
so we need to get them by early parsing MCFG before creating MSI and PCH 
irqdomain(MSI and PCH irqdomain have the same node as their parent
irqdomain).

If the related code is not suitable to be here, Maybe I should put them 
in arch/loongarch/kernel/irq.c and call init_vector_parent_group before 
irqchip_init().


>> +
>> +void acpi_set_vector_parent(int node, struct irq_domain *parent)
>> +{
>> +	int i;
>> +
>> +	if (cpu_has_flatmode)
>> +		node = cpu_to_node(node * CORES_PER_EIO_NODE);
>> +
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		if (node == vector_group[i].node) {
>> +			vector_group[i].parent = parent;
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>> +struct irq_domain *acpi_get_msi_parent(int index)
>> +{
>> +	return vector_group[index].parent;
>> +}
>> +
>> +struct irq_domain *acpi_get_pch_parent(int node)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		if (node == vector_group[i].node)
>> +			return vector_group[i].parent;
>> +	}
>> +	return NULL;
>> +}
> 
> Same thing. There is nothing "common" here. All this should be split
> in the various drivers, where they belong.
> 

Ok, I'll try to put them in individual drivers. So the "common" file 
here will be not needed any more.


> 	M.
> 

