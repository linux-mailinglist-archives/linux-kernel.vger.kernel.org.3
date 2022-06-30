Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B97560F57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiF3CwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiF3CwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:52:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19413F335
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:52:01 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxj+bBD71iL2FlAA--.12845S3;
        Thu, 30 Jun 2022 10:51:45 +0800 (CST)
Subject: Re: [PATCH V13 07/13] irqchip/loongson-pch-msi: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-8-git-send-email-lvjianmin@loongson.cn>
 <87sfnn1ui2.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <dd677e76-b215-04fb-b68e-e540cf4d5492@loongson.cn>
Date:   Thu, 30 Jun 2022 10:51:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87sfnn1ui2.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Cxj+bBD71iL2FlAA--.12845S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyfCF1ruF1fXFWxXr4UXFb_yoW3JFyfpF
        W3Ca1DKr45JryUWr9Yqa15ZrySyFySkFZrta1fJa4ftr1q934kKF1DtFnruF15AF4UG3W2
        vr1xtFW5uF4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU921xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE
        -syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/29 下午9:15, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 12:39:51 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> We are preparing to add new Loongson (based on LoongArch, not compatible
>> with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
>> as its boot protocol, so add ACPI init support.
> 
> Same rant about the content-less paragraph, which I asked you to drop
> a few version ago.
> 

Ok, I only dropped it for the patch that you reviewed in previous 
version, without handling other similar patches. I'll drop it for all 
similar patch in next version.


>>
>> PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
>> Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
>> please refer Documentation/loongarch/irq-chip-model.rst.
>>
>> For systems with two chipsets, there are two related msi irqdomains,
>> each of which has the same node id as its parent irqdomain. So we
>> use a structure to mantain the relation of node and it's parent
>> irqdomain as pch irqdomin, and add a pci_segment field to it for
>> matching the pci segment of a pci device when setting msi irqdomain
>> for the device.
>>
>> struct acpi_vector_group {
>>          int node;
>>          int pci_segment;
>>          struct irq_domain *parent;
>> };
>>
>> The field 'pci_segment' and 'node' are initialized from MCFG, and
>> the parent irqdomain will set field 'parent' by matching same
>> 'node'.
>>
>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/irq.h       |   7 +-
>>   arch/loongarch/kernel/irq.c            |  30 ++++++-
>>   drivers/irqchip/irq-loongson-pch-msi.c | 147 +++++++++++++++++++++++----------
>>   3 files changed, 138 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>> index a444dc6..367aa44 100644
>> --- a/arch/loongarch/include/asm/irq.h
>> +++ b/arch/loongarch/include/asm/irq.h
>> @@ -50,9 +50,11 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
>>   
>>   struct acpi_vector_group {
>>   	int node;
>> +	int pci_segment;
>>   	struct irq_domain *parent;
>>   };
>>   extern struct acpi_vector_group pch_group[MAX_IO_PICS];
>> +extern struct acpi_vector_group msi_group[MAX_IO_PICS];
>>   
>>   #define CORES_PER_EIO_NODE	4
>>   
>> @@ -112,9 +114,8 @@ struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_ht_pic *acpi_htvec);
>>   int pch_lpc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lpc_pic *acpi_pchlpc);
>> -struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>> -					struct acpi_madt_msi_pic *acpi_pchmsi);
>>   int find_pch_pic(u32 gsi);
>> +struct fwnode_handle *get_pch_msi_handle(int pci_segment);
>>   
>>   extern struct acpi_madt_lio_pic *acpi_liointc;
>>   extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
>> @@ -127,7 +128,7 @@ struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
>>   extern struct irq_domain *cpu_domain;
>>   extern struct irq_domain *liointc_domain;
>>   extern struct fwnode_handle *pch_lpc_handle;
>> -extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>> +extern struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
>>   extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
>>   
>>   extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
>> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
>> index f2115be..82bc6c7 100644
>> --- a/arch/loongarch/kernel/irq.c
>> +++ b/arch/loongarch/kernel/irq.c
>> @@ -27,8 +27,8 @@
>>   
>>   struct irq_domain *cpu_domain;
>>   struct irq_domain *liointc_domain;
>> -struct irq_domain *pch_msi_domain[MAX_IO_PICS];
>>   struct acpi_vector_group pch_group[MAX_IO_PICS];
>> +struct acpi_vector_group msi_group[MAX_IO_PICS];
>>   
>>   /*
>>    * 'what should we do if we get a hw irq event on an illegal vector'.
>> @@ -55,6 +55,33 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>>   	return 0;
>>   }
>>   
>> +static int early_pci_mcfg_parse(struct acpi_table_header *header)
> 
> Shouldn't this be __init as well?
> 

Yes, thanks, it should be __init too.


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
>> +	for (i = 0; i < n; i++, mptr++) {
>> +		msi_group[i].pci_segment = mptr->pci_segment;
>> +		msi_group[i].node = (mptr->address >> 44) & 0xf;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void __init init_msi_parent_group(void)
>> +{
>> +	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>> +}
>> +
>>   void __init init_IRQ(void)
>>   {
>>   	int i;
>> @@ -68,6 +95,7 @@ void __init init_IRQ(void)
>>   	clear_csr_ecfg(ECFG0_IM);
>>   	clear_csr_estat(ESTATF_IP);
>>   
>> +	init_msi_parent_group();
> 
> The changes in this file should be a separate patch, as it is
> completely independent.
> 

Ok, I'll put it in a separate patch.


>>   	irqchip_init();
>>   #ifdef CONFIG_SMP
>>   	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
>> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
>> index e3801c4..5db4a68 100644
>> --- a/drivers/irqchip/irq-loongson-pch-msi.c
>> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
>> @@ -15,14 +15,30 @@
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   
>> +static int nr_pics;
>> +
>>   struct pch_msi_data {
>>   	struct mutex	msi_map_lock;
>>   	phys_addr_t	doorbell;
>>   	u32		irq_first;	/* The vector number that MSIs starts */
>>   	u32		num_irqs;	/* The number of vectors for MSIs */
>>   	unsigned long	*msi_map;
>> +	struct fwnode_handle *domain_handle;
>>   };
>>   
>> +static struct pch_msi_data *pch_msi_priv[2];
> 
> What is this '2'?
> 

Yes, I should use MAX_IO_PICS, thanks.


>> +
>> +struct fwnode_handle *get_pch_msi_handle(int pci_segment)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_IO_PICS; i++) {
>> +		if (msi_group[i].pci_segment == pci_segment)
> 
> AFAICT, this driver is supposed to compile on MIPS too. Clearly, you
> haven't bothered checking that it was still building:
> 
> drivers/irqchip/irq-loongson-pch-msi.c: In function ‘get_pch_msi_handle’:
> drivers/irqchip/irq-loongson-pch-msi.c:35:18: error: ‘MAX_IO_PICS’ undeclared (first use in this function)
>     35 |  for (i = 0; i < MAX_IO_PICS; i++) {
>        |                  ^~~~~~~~~~~
> drivers/irqchip/irq-loongson-pch-msi.c:35:18: note: each undeclared identifier is reported only once for each function it appears in
> drivers/irqchip/irq-loongson-pch-msi.c:36:7: error: ‘msi_group’ undeclared (first use in this function); did you mean ‘task_group’?
>     36 |   if (msi_group[i].pci_segment == pci_segment)
>        |       ^~~~~~~~~
>        |       task_group
> 
> I've stopped here.


So sorry for that, I got it, I'll fix them and test on both of LoongArch 
and MIPS machine.

> 
> 	M.
> 

