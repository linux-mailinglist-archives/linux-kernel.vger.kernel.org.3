Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507DD547BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiFLTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiFLTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:15:10 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA3222AD;
        Sun, 12 Jun 2022 12:15:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 328733200940;
        Sun, 12 Jun 2022 15:15:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jun 2022 15:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655061303; x=
        1655147703; bh=2AHhgZ9rbq8aZb7LASmmVs+asEkr/6vObTPDYWnvkGg=; b=X
        mCK8PiTixLdiYCEqz5izT8mlk2Da2tQS3+OJqNr0DAbKPTE8+7iw6FuYaxs4Ek9O
        m3TvJ5aqGRpHR0vH0F3dzoShvZzg3YUU/uWMkVxrpqwnbh7tKFle6RkuLJh00+Ju
        78tjPjkxDiF3U48CJcpIDdWv9EHhUx/NN7l7OHLc/4WWAQc8z2gL6YDHnD5G8f+A
        BA8HsyMluVg2cXDzUjlEpzqqJBp4uTEPXrCxw+yZdBiWFj4ztP5Yu55iRhDjeumF
        pOKrjJKT8GnINKvf+UNJK0KMs2KYjfxFs2Czodsq0KEQVBUuXyVrTWht1dbF6Bju
        Qk1y1tN468XR3G6Ce5DhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655061303; x=
        1655147703; bh=2AHhgZ9rbq8aZb7LASmmVs+asEkr/6vObTPDYWnvkGg=; b=w
        ZfTWlKnlDtZgp+0qI03ZRL+WrqosbPeXAE2DkLd4w4MleA2b9TunzD9WLG7/THfX
        3sR4Ce+slcIqo89XDIewm4hxzm4Gf0sB5YUnrtqotHEDCo8UDnVfZCr4iDeGGusn
        9zs+DSdIu8sL4kfmK+p/PRUOOp0ZmspYk97uoJKjU3dsQmxIfsTNI7anNV6TBWwg
        RBiWru40/uWSr3jZa/roFVNemgzFG0FcOVa2ZaRtVLLkc6W0B3KpjGPBn6UW0F0V
        1t/8I1TqOWAk7GftC1/1IVgim28xBnvkKhF7EdiqLqZzmCCQI5Opf8rvHa4hVCAz
        qWo6rsjxI0stqhvRsccog==
X-ME-Sender: <xms:NjumYtQycmvf82WcX7bjKTHfPa1oO3cB4-vLhf7TcOPRYHtDMiUPHw>
    <xme:NjumYmw4sFQK29EEBwqH5oKg3EExslksX_PhiYr_1gPKMRgHcvnMXUAmIYElo9obb
    kJmNKPKeB59TIcgFA>
X-ME-Received: <xmr:NjumYi1mqQRurO5_JYzifSbw9OAX0UeE3bzxCmm456sLkcxQxu_IRvqqCOmY3_XG2D0IJOrXUeh7BHQBtvbNeGjjKmvmDMOKTD1SPnkRsZ4UuPTRl8tTuzFR5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduhedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:NjumYlBbTKp0H76U7dmWnY_9xtNJRPoau2VQ5Vfg-I0QZsSGOzJeLA>
    <xmx:NjumYmiFkOZZMQXUBc-b1eGTAEzo5ocFjpNJqV8c728PnABh_DJhIA>
    <xmx:NjumYprZKrB7hEqxWuMBCBUcQ4suwiRoKHiSdpdjgurnBodplAzo5Q>
    <xmx:NzumYtRHfS8RpZIh1vSojHqxxq8cA_eYPqMKhxrOG9ZFtfXFk-So_A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jun 2022 15:15:01 -0400 (EDT)
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
References: <20220610004308.1903626-1-heiko@sntech.de>
 <20220610004308.1903626-3-heiko@sntech.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <342e3c12-ebb0-badf-7d4c-c444a2b842b2@sholland.org>
Date:   Sun, 12 Jun 2022 14:15:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220610004308.1903626-3-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 7:43 PM, Heiko Stuebner wrote:
> The Zicbom ISA-extension was ratified in november 2021
> and introduces instructions for dcache invalidate, clean
> and flush operations.
> 
> Implement cache management operations based on them.
> 
> Of course not all cores will support this, so implement an
> alternative-based mechanism that replaces empty instructions
> with ones done around Zicbom instructions.
> 
> We're using prebuild instructions for the Zicbom instructions
> for now, to not require a bleeding-edge compiler (gcc-12)
> for these somewhat simple instructions.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                   | 15 +++++
>  arch/riscv/include/asm/cacheflush.h  |  6 ++
>  arch/riscv/include/asm/errata_list.h | 36 ++++++++++-
>  arch/riscv/include/asm/hwcap.h       |  1 +
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 18 ++++++
>  arch/riscv/kernel/setup.c            |  2 +
>  arch/riscv/mm/Makefile               |  1 +
>  arch/riscv/mm/dma-noncoherent.c      | 93 ++++++++++++++++++++++++++++
>  9 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/mm/dma-noncoherent.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 32ffef9f6e5b..384d0c15f2b6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -376,6 +376,21 @@ config RISCV_ISA_SVPBMT
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZICBOM
> +	bool "Zicbom extension support for non-coherent dma operation"
> +	select ARCH_HAS_DMA_PREP_COHERENT
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select ARCH_HAS_SETUP_DMA_OPS

ARCH_HAS_SETUP_DMA_OPS needs to be separate from the non-coherent DMA option,
because iommu_setup_dma_ops() will need to be called from arch_setup_dma_ops()
even on a fully-coherent system. (But this change is not strictly necessary for
this series.)

> +	select DMA_DIRECT_REMAP
> +	select RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZICBOM extension
> +	   (Cache Block Management Operations) and enable its usage.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config FPU
>  	bool "FPU support"
>  	default y
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 23ff70350992..eb12d014b158 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -42,6 +42,12 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>  
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +void riscv_init_cbom_blocksize(void);
> +#else
> +static inline void riscv_init_cbom_blocksize(void) { }
> +#endif
> +
>  /*
>   * Bits in sys_riscv_flush_icache()'s flags argument.
>   */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 398e351e7002..2e80a75b5241 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -20,7 +20,8 @@
>  #endif
>  
>  #define	CPUFEATURE_SVPBMT 0
> -#define	CPUFEATURE_NUMBER 1
> +#define	CPUFEATURE_CMO 1

This seems like it should be CPUFEATURE_ZICBOM for consistency.

> +#define	CPUFEATURE_NUMBER 2
>  
>  #ifdef __ASSEMBLY__
>  
> @@ -87,6 +88,39 @@ asm volatile(ALTERNATIVE(						\
>  #define ALT_THEAD_PMA(_val)
>  #endif
>  
> +/*
> + * cbo.clean rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...01     rs1       010      00000  0001111
> + *
> + * cbo.flush rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...10     rs1       010      00000  0001111
> + *
> + * cbo.inval rs1
> + * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *    0...00     rs1       010      00000  0001111
> + */
> +#define CBO_INVAL_A0	".long 0x15200F"
> +#define CBO_CLEAN_A0	".long 0x25200F"
> +#define CBO_FLUSH_A0	".long 0x05200F"
> +
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> +asm volatile(ALTERNATIVE(						\
> +	__nops(5),							\
> +	"mv a0, %1\n\t"							\
> +	"j 2f\n\t"							\
> +	"3:\n\t"							\
> +	CBO_##_op##_A0 "\n\t"						\
> +	"add a0, a0, %0\n\t"						\
> +	"2:\n\t"							\
> +	"bltu a0, %2, 3b\n\t", 0,					\
> +		CPUFEATURE_CMO, CONFIG_RISCV_ISA_ZICBOM)		\
> +	: : "r"(_cachesize),						\
> +	    "r"(ALIGN((_start), (_cachesize))),				\
> +	    "r"(ALIGN((_start) + (_size), (_cachesize)))		\

Here, the starting address needs to be truncated, not aligned upward. Otherwise,
the first partial cache line will be missed. And since the starting address is
known to be a multiple of the cache line size, the ending address does not need
to be rounded up either:

-           "r"(ALIGN((_start), (_cachesize))),          \
-           "r"(ALIGN((_start) + (_size), (_cachesize))) \
+           "r"((_start) & ~((_cachesize) - 1UL)),       \
+           "r"((_start) + (_size))                      \

Then to prevent causing any collateral damage, you need to make sure slab
allocations can not share a cache block:

--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -11,6 +11,8 @@

 #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)

+#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
+
 /*
  * RISC-V requires the stack pointer to be 16-byte aligned, so ensure that
  * the flat loader aligns it accordingly.

> +	: "a0")
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 4e2486881840..6044e402003d 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>  	RISCV_ISA_EXT_SVPBMT,
> +	RISCV_ISA_EXT_ZICBOM,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..0365557f7122 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 6a40cb8134bd..e956f4d763ec 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> @@ -259,6 +260,20 @@ static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
>  	return false;
>  }
>  
> +static bool __init_or_module cpufeature_probe_cmo(unsigned int stage)
> +{
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +	switch (stage) {
> +	case RISCV_ALTERNATIVES_EARLY_BOOT:
> +		return false;
> +	default:
> +		return riscv_isa_extension_available(NULL, ZICBOM);
> +	}
> +#endif
> +
> +	return false;
> +}
> +
>  /*
>   * Probe presence of individual extensions.
>   *
> @@ -273,6 +288,9 @@ static u32 __init_or_module cpufeature_probe(unsigned int stage)
>  	if (cpufeature_probe_svpbmt(stage))
>  		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
>  
> +	if (cpufeature_probe_cmo(stage))
> +		cpu_req_feature |= (1U << CPUFEATURE_CMO);
> +
>  	return cpu_req_feature;
>  }
>  
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f0f36a4a0e9b..95ef6e2bf45c 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/crash_dump.h>
>  
>  #include <asm/alternative.h>
> +#include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/pgtable.h>
> @@ -296,6 +297,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  
>  	riscv_fill_hwcap();
> +	riscv_init_cbom_blocksize();
>  	apply_boot_alternatives();
>  }
>  
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index ac7a25298a04..548f2f3c00e9 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -30,3 +30,4 @@ endif
>  endif
>  
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> +obj-$(CONFIG_RISCV_ISA_ZICBOM) += dma-noncoherent.o
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> new file mode 100644
> index 000000000000..f77f4c529835
> --- /dev/null
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * RISC-V specific functions to support DMA for non-coherent devices
> + *
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/dma-direct.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/libfdt.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <asm/cacheflush.h>
> +
> +static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
> +
> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	case DMA_FROM_DEVICE:
> +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;

arch_sync_dma_for_device(DMA_FROM_DEVICE) is a no-op from the CPU's perspective.
Invalidating the CPU's cache goes in arch_sync_dma_for_cpu(DMA_FROM_DEVICE).

> +	case DMA_BIDIRECTIONAL:
> +		ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		break;
> +	case DMA_FROM_DEVICE:
> +	case DMA_BIDIRECTIONAL:
> +		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);

For arch_sync_dma_for_cpu(DMA_BIDIRECTIONAL), we expect the CPU to have written
to the buffer, so this should flush, not invalidate.

Regards,
Samuel

> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +	void *flush_addr = page_address(page);
> +
> +	memset(flush_addr, 0, size);
> +	ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size, riscv_cbom_block_size);
> +}
> +
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +		const struct iommu_ops *iommu, bool coherent)
> +{
> +	/* If a specific device is dma-coherent, set it here */
> +	dev->dma_coherent = coherent;
> +}
> +
> +void riscv_init_cbom_blocksize(void)
> +{
> +	struct device_node *node;
> +	int ret;
> +	u32 val;
> +
> +	for_each_of_cpu_node(node) {
> +		int hartid = riscv_of_processor_hartid(node);
> +		int cbom_hartid;
> +
> +		if (hartid < 0)
> +			continue;
> +
> +		/* set block-size for cbom extension if available */
> +		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> +		if (ret)
> +			continue;
> +
> +		if (!riscv_cbom_block_size) {
> +			riscv_cbom_block_size = val;
> +			cbom_hartid = hartid;
> +		} else {
> +			if (riscv_cbom_block_size != val)
> +				pr_warn("cbom-block-size mismatched between harts %d and %d\n",
> +					cbom_hartid, hartid);
> +		}
> +	}
> +}
> 

