Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41A5AE85A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiIFMeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiIFMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:34:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ED5F60E0;
        Tue,  6 Sep 2022 05:34:37 -0700 (PDT)
Received: from [10.20.42.105] (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx5OFRPhdj8bsSAA--.11067S3;
        Tue, 06 Sep 2022 20:34:25 +0800 (CST)
Subject: Re: [PATCH V3 2/2] LoongArch: Remove ARCH_HAS_PHYS_TO_DMA
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     lpieralisi@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        loongarch@lists.linux.dev
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
 <20220830030139.29899-3-lvjianmin@loongson.cn>
 <CAAhV-H4P=MsH2B29U+x4TWJpN4s_2ZYLsX5_rfaapPxx9+UmPQ@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <36d0a38f-86ce-9a7d-8b83-aa7342146ebb@loongson.cn>
Date:   Tue, 6 Sep 2022 20:34:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4P=MsH2B29U+x4TWJpN4s_2ZYLsX5_rfaapPxx9+UmPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx5OFRPhdj8bsSAA--.11067S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW7Ww4xtFy7uF4ftr1DZFb_yoW7uw4xpF
        9rCFs8Gr4xGrn7WrWvyw1rZFn8X34vka42qFWxK34kCrnF9r1DXr1kArykuFyYyFZrKF4I
        vF95WFyavF4UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r
        yrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

Ok, thanks, I'll change title in V4. There is *not* size calculation in
this patch, so the patch does not need resource_size() as in 
acpi_dma_get_range().

On 2022/9/5 下午10:42, Huacai Chen wrote:
> Hi, Jianmin,
> 
> The title can be "LoongArch: Use acpi_arch_dma_setup() and remove
> ARCH_HAS_PHYS_TO_DMA", and please use resource_size() as arm64.
> 
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> 
> Huacai
> 
> 
> On Tue, Aug 30, 2022 at 11:01 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> Use _DMA defined in ACPI spec for translation between
>> DMA address and CPU address, and implement acpi_arch_dma_setup
>> for initializing dev->dma_range_map, where acpi_dma_get_range
>> is called for parsing _DMA.
>>
>> e.g.
>> If we have two dma ranges:
>> cpu address      dma address    size         offset
>> 0x200080000000   0x2080000000   0x400000000  0x1fe000000000
>> 0x400080000000   0x4080000000   0x400000000  0x3fc000000000
>>
>> _DMA for pci devices should be declared in host bridge as
>> flowing:
>>
>> Name (_DMA, ResourceTemplate() {
>>          QWordMemory (ResourceProducer,
>>              PosDecode,
>>              MinFixed,
>>              MaxFixed,
>>              NonCacheable,
>>              ReadWrite,
>>              0x0,
>>              0x4080000000,
>>              0x447fffffff,
>>              0x3fc000000000,
>>              0x400000000,
>>              ,
>>              ,
>>              )
>>
>>          QWordMemory (ResourceProducer,
>>              PosDecode,
>>              MinFixed,
>>              MaxFixed,
>>              NonCacheable,
>>              ReadWrite,
>>              0x0,
>>              0x2080000000,
>>              0x247fffffff,
>>              0x1fe000000000,
>>              0x400000000,
>>              ,
>>              ,
>>              )
>>      })
>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig        |  1 -
>>   arch/loongarch/kernel/dma.c   | 52 +++++++++++++++++--------------------------
>>   arch/loongarch/kernel/setup.c |  2 +-
>>   include/linux/acpi.h          |  9 +++++---
>>   4 files changed, 28 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index b57daee..9dedcf9 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -7,7 +7,6 @@ config LOONGARCH
>>          select ARCH_ENABLE_MEMORY_HOTPLUG
>>          select ARCH_ENABLE_MEMORY_HOTREMOVE
>>          select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
>> -       select ARCH_HAS_PHYS_TO_DMA
>>          select ARCH_HAS_PTE_SPECIAL
>>          select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>          select ARCH_INLINE_READ_LOCK if !PREEMPTION
>> diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
>> index 8c9b531..7a9c6a9 100644
>> --- a/arch/loongarch/kernel/dma.c
>> +++ b/arch/loongarch/kernel/dma.c
>> @@ -2,39 +2,29 @@
>>   /*
>>    * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>>    */
>> -#include <linux/init.h>
>> +#include <linux/acpi.h>
>>   #include <linux/dma-direct.h>
>> -#include <linux/dma-mapping.h>
>> -#include <linux/dma-map-ops.h>
>> -#include <linux/swiotlb.h>
>>
>> -#include <asm/bootinfo.h>
>> -#include <asm/dma.h>
>> -#include <asm/loongson.h>
>> -
>> -/*
>> - * We extract 4bit node id (bit 44~47) from Loongson-3's
>> - * 48bit physical address space and embed it into 40bit.
>> - */
>> -
>> -static int node_id_offset;
>> -
>> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>> -{
>> -       long nid = (paddr >> 44) & 0xf;
>> -
>> -       return ((nid << 44) ^ paddr) | (nid << node_id_offset);
>> -}
>> -
>> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +void acpi_arch_dma_setup(struct device *dev)
>>   {
>> -       long nid = (daddr >> node_id_offset) & 0xf;
>> +       int ret;
>> +       u64 mask, end = 0;
>> +       const struct bus_dma_region *map = NULL;
>> +
>> +       ret = acpi_dma_get_range(dev, &map);
>> +       if (!ret && map) {
>> +               const struct bus_dma_region *r = map;
>> +
>> +               for (end = 0; r->size; r++) {
>> +                       if (r->dma_start + r->size - 1 > end)
>> +                               end = r->dma_start + r->size - 1;
>> +               }
>> +
>> +               mask = DMA_BIT_MASK(ilog2(end) + 1);
>> +               dev->bus_dma_limit = end;
>> +               dev->dma_range_map = map;
>> +               dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
>> +               *dev->dma_mask = min(*dev->dma_mask, mask);
>> +       }
>>
>> -       return ((nid << node_id_offset) ^ daddr) | (nid << 44);
>> -}
>> -
>> -void __init plat_swiotlb_setup(void)
>> -{
>> -       swiotlb_init(true, SWIOTLB_VERBOSE);
>> -       node_id_offset = ((readl(LS7A_DMA_CFG) & LS7A_DMA_NODE_MASK) >> LS7A_DMA_NODE_SHF) + 36;
>>   }
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index c74860b..974f085 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -247,7 +247,7 @@ static void __init arch_mem_init(char **cmdline_p)
>>          sparse_init();
>>          memblock_set_bottom_up(true);
>>
>> -       plat_swiotlb_setup();
>> +       swiotlb_init(true, SWIOTLB_VERBOSE);
>>
>>          dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 34e0545..33977b87 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -278,14 +278,17 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
>>
>>   void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>>
>> +#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>> +void acpi_arch_dma_setup(struct device *dev);
>> +#else
>> +static inline void acpi_arch_dma_setup(struct device *dev) { }
>> +#endif
>> +
>>   #ifdef CONFIG_ARM64
>>   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
>> -void acpi_arch_dma_setup(struct device *dev);
>>   #else
>>   static inline void
>>   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>> -static inline void
>> -acpi_arch_dma_setup(struct device *dev) { }
>>   #endif
>>
>>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>> --
>> 1.8.3.1
>>
>>

