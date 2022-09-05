Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81725AD561
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiIEOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiIEOn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:43:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8712766;
        Mon,  5 Sep 2022 07:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C053CB811E1;
        Mon,  5 Sep 2022 14:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D008C433D7;
        Mon,  5 Sep 2022 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662388943;
        bh=NlStXV7wed6wVtep3wZsd1cQTElbxZKc0QNhM8aDIIc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uvG1+XkIDZiThWQpsvnEX5k7bxs9uQACJiHfklgXMBg2ORQYwHVNChUmJM5Cz+UWk
         Re82+7o7zJIE+aXzZk4Taax4nFYPEQuEJSRIQu71sIHzp+Kn+POsN10dKFJ/393d3I
         lswwdEUGQADCeSeclJrLsodf0EIrAX+WfItAu5+HLBb9ZuVPAKbASMQ/nb8gYSlkbq
         dKMtrKrGSriNmPQddIaz/AJC9hDYQ3amEpR/AJrn5cAAuwCZ2/tdTH69+N5lmoTQEv
         8tXFu3G3TDyTOl2E5OtPXmJyy18qqucVBINYg/Ao5RvGG5icJvwp2R5QdWSy1DkANh
         gK5Xevt92mNqQ==
Received: by mail-vs1-f42.google.com with SMTP id o123so9042187vsc.3;
        Mon, 05 Sep 2022 07:42:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo3NOkR5kr7RXV2jM/Mbe0+fjWmFX5hHhvezyJQy8uZKHDqmmXj2
        c1/SghUH4qJQxj5NGIlJ/UoVJfLgjEy/go0HGZI=
X-Google-Smtp-Source: AA6agR7sqaivV1IawE/7cTWY9j7vY23902xeea9967TaCk0gJUQNpNzQlk3v8WRDNV+1c2oX7k52hU/kKvkvQ1PUAGc=
X-Received: by 2002:a67:d582:0:b0:390:d6dd:5612 with SMTP id
 m2-20020a67d582000000b00390d6dd5612mr13853625vsj.78.1662388942430; Mon, 05
 Sep 2022 07:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830030139.29899-1-lvjianmin@loongson.cn> <20220830030139.29899-3-lvjianmin@loongson.cn>
In-Reply-To: <20220830030139.29899-3-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 5 Sep 2022 22:42:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4P=MsH2B29U+x4TWJpN4s_2ZYLsX5_rfaapPxx9+UmPQ@mail.gmail.com>
Message-ID: <CAAhV-H4P=MsH2B29U+x4TWJpN4s_2ZYLsX5_rfaapPxx9+UmPQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] LoongArch: Remove ARCH_HAS_PHYS_TO_DMA
To:     Jianmin Lv <lvjianmin@loongson.cn>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin,

The title can be "LoongArch: Use acpi_arch_dma_setup() and remove
ARCH_HAS_PHYS_TO_DMA", and please use resource_size() as arm64.

Acked-by: Huacai Chen <chenhuacai@loongson.cn>


Huacai


On Tue, Aug 30, 2022 at 11:01 AM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> Use _DMA defined in ACPI spec for translation between
> DMA address and CPU address, and implement acpi_arch_dma_setup
> for initializing dev->dma_range_map, where acpi_dma_get_range
> is called for parsing _DMA.
>
> e.g.
> If we have two dma ranges:
> cpu address      dma address    size         offset
> 0x200080000000   0x2080000000   0x400000000  0x1fe000000000
> 0x400080000000   0x4080000000   0x400000000  0x3fc000000000
>
> _DMA for pci devices should be declared in host bridge as
> flowing:
>
> Name (_DMA, ResourceTemplate() {
>         QWordMemory (ResourceProducer,
>             PosDecode,
>             MinFixed,
>             MaxFixed,
>             NonCacheable,
>             ReadWrite,
>             0x0,
>             0x4080000000,
>             0x447fffffff,
>             0x3fc000000000,
>             0x400000000,
>             ,
>             ,
>             )
>
>         QWordMemory (ResourceProducer,
>             PosDecode,
>             MinFixed,
>             MaxFixed,
>             NonCacheable,
>             ReadWrite,
>             0x0,
>             0x2080000000,
>             0x247fffffff,
>             0x1fe000000000,
>             0x400000000,
>             ,
>             ,
>             )
>     })
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  arch/loongarch/Kconfig        |  1 -
>  arch/loongarch/kernel/dma.c   | 52 +++++++++++++++++--------------------------
>  arch/loongarch/kernel/setup.c |  2 +-
>  include/linux/acpi.h          |  9 +++++---
>  4 files changed, 28 insertions(+), 36 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index b57daee..9dedcf9 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -7,7 +7,6 @@ config LOONGARCH
>         select ARCH_ENABLE_MEMORY_HOTPLUG
>         select ARCH_ENABLE_MEMORY_HOTREMOVE
>         select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
> -       select ARCH_HAS_PHYS_TO_DMA
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_INLINE_READ_LOCK if !PREEMPTION
> diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
> index 8c9b531..7a9c6a9 100644
> --- a/arch/loongarch/kernel/dma.c
> +++ b/arch/loongarch/kernel/dma.c
> @@ -2,39 +2,29 @@
>  /*
>   * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>   */
> -#include <linux/init.h>
> +#include <linux/acpi.h>
>  #include <linux/dma-direct.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/dma-map-ops.h>
> -#include <linux/swiotlb.h>
>
> -#include <asm/bootinfo.h>
> -#include <asm/dma.h>
> -#include <asm/loongson.h>
> -
> -/*
> - * We extract 4bit node id (bit 44~47) from Loongson-3's
> - * 48bit physical address space and embed it into 40bit.
> - */
> -
> -static int node_id_offset;
> -
> -dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> -{
> -       long nid = (paddr >> 44) & 0xf;
> -
> -       return ((nid << 44) ^ paddr) | (nid << node_id_offset);
> -}
> -
> -phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +void acpi_arch_dma_setup(struct device *dev)
>  {
> -       long nid = (daddr >> node_id_offset) & 0xf;
> +       int ret;
> +       u64 mask, end = 0;
> +       const struct bus_dma_region *map = NULL;
> +
> +       ret = acpi_dma_get_range(dev, &map);
> +       if (!ret && map) {
> +               const struct bus_dma_region *r = map;
> +
> +               for (end = 0; r->size; r++) {
> +                       if (r->dma_start + r->size - 1 > end)
> +                               end = r->dma_start + r->size - 1;
> +               }
> +
> +               mask = DMA_BIT_MASK(ilog2(end) + 1);
> +               dev->bus_dma_limit = end;
> +               dev->dma_range_map = map;
> +               dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> +               *dev->dma_mask = min(*dev->dma_mask, mask);
> +       }
>
> -       return ((nid << node_id_offset) ^ daddr) | (nid << 44);
> -}
> -
> -void __init plat_swiotlb_setup(void)
> -{
> -       swiotlb_init(true, SWIOTLB_VERBOSE);
> -       node_id_offset = ((readl(LS7A_DMA_CFG) & LS7A_DMA_NODE_MASK) >> LS7A_DMA_NODE_SHF) + 36;
>  }
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index c74860b..974f085 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -247,7 +247,7 @@ static void __init arch_mem_init(char **cmdline_p)
>         sparse_init();
>         memblock_set_bottom_up(true);
>
> -       plat_swiotlb_setup();
> +       swiotlb_init(true, SWIOTLB_VERBOSE);
>
>         dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34e0545..33977b87 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -278,14 +278,17 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
>
>  void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
>
> +#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
> +void acpi_arch_dma_setup(struct device *dev);
> +#else
> +static inline void acpi_arch_dma_setup(struct device *dev) { }
> +#endif
> +
>  #ifdef CONFIG_ARM64
>  void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> -void acpi_arch_dma_setup(struct device *dev);
>  #else
>  static inline void
>  acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> -static inline void
> -acpi_arch_dma_setup(struct device *dev) { }
>  #endif
>
>  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> --
> 1.8.3.1
>
>
