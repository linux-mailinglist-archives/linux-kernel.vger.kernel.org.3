Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010A525940
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbiEMBF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376269AbiEMBFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:05:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D87E005
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:05:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CC96F3200258;
        Thu, 12 May 2022 21:05:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 12 May 2022 21:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652403942; x=
        1652490342; bh=Cq7ZSVTwL25kbQxcqdr88pN5c62HIusa24B8zt1PFHs=; b=P
        pvqq19hC3TXRZTaKKn/eiDxVVqXKeW1VOnQHcfegN3HdL9C/y8/lqPl+BpuPlaJE
        zFYnUd26TuFieluiPGOmrMAFDgWgh9Vb4l7eZaob/cyFfdyfDgkq3fwutaoUHjxq
        JWxa3KHSqwsjkN0sMf80fBrDTRxBg1ut/boJKDkOo+fk1d5cTKDDejYwB0rD/NAk
        4IeFaj/XN4rtxc9nqFqSOAKSuZZpy8lNShumqPz2tOTpxc3gDrGYwJmiYztMbdcS
        XvasYohbYqF+Cab9xuaoSH68FXQfEa4ib9xOgQgTz5ORyQePH+CkgqEHa/6gg7TW
        oyF6R0hrmMYm35m+wOYcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652403942; x=1652490342; bh=Cq7ZSVTwL25kb
        Qxcqdr88pN5c62HIusa24B8zt1PFHs=; b=EP2OM0Er9+PSwucTshCSbkCpRE9dj
        fqqe5CSPSNA28kEYOpNOpMC9mw75uCtPA3HLGKhupxFZBxqna+/PxmxHD+NDWQAc
        VEvBuV9UBH9F+jeKdjnUO/7SdWNjyMKjNpwGjXjngih6CIhgRQZdCiP7D8WhMCkf
        JjqciVVXSdJnzILK5JbEQKXKJA3wlLC+b5GHXiXu7SGTg/PPvx/pbtCfErwtMj22
        WPesdBR11bbJYBTu3s5ZrzOHl0aBglo/8zE1xvGcFGZH3qM79WHdZ1TpxWJ3wJVm
        3upQl4HX3EwuXSH1+U8rFuzmmyUOGr5FYUbvRuwahKpysmijnhFE9ZDDw==
X-ME-Sender: <xms:5q59YrDrO0FYnPfqhnm7vq2FrM0Mo6bPQLRlBf_cS_ivrdJqD_jkiQ>
    <xme:5q59YhiWecqWFCoKAFM2rcuMb5OKi5q5AduXLgSScMm2B3xVPyFg5XaSuzN2gIBJS
    BA6_rprm4zkAlGRRg>
X-ME-Received: <xmr:5q59YmnQHphEx478SgeUXyk9XO71E9fW35YbWhwJSSHF_lAwa46nBIZMCHKenxddE7SyroRUXZ4RmhV0kRJDbrRgBzOJ6BiP3cLmhtv1-h-48t3EVjj0wWdScw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeekgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5q59Ytx-DOjfiahj54ZMZ99WAP-RFPHyI2XhCf1JHyIJ8FGG3fYHQg>
    <xmx:5q59YgRwX_4YA2u_DPFThfOIPukrFWLIiu-cWRSob596-5IOI0PSGg>
    <xmx:5q59Ygbm3El4cXhCaTLQxFccI9HoRclm2nVZjzjw_GtEwVqPQlrPUw>
    <xmx:5q59YmOjNY4qcQp7RvxlX8f_Hd_0iwKACpyYbUQyyyQgZUQdyDQq1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 May 2022 21:05:41 -0400 (EDT)
Subject: Re: [PATCH] arch/riscv: Add Zihintpause extension support
To:     Dao Lu <daolu@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
References: <20220512033045.1101909-1-daolu@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <689ad3c4-0365-bd27-4873-bff8dbe6591b@sholland.org>
Date:   Thu, 12 May 2022 20:05:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220512033045.1101909-1-daolu@rivosinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 10:30 PM, Dao Lu wrote:
> This patch:
>   1. Build with _zihintpause if the toolchain has support for it
>   2. Detects if the platform supports the extension

This instruction is a hint, meaning it is a harmless no-op if the extension is
unsupported by the CPU. So we can use it as long as the compiler supports it.
There is no need to probe for it at runtime.

Regards,
Samuel

>   3. Use PAUSE for cpu_relax if both toolchain and the platform support it
> 
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>  arch/riscv/Makefile                     |  4 ++++
>  arch/riscv/include/asm/hwcap.h          |  1 +
>  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
>  arch/riscv/kernel/cpu.c                 |  1 +
>  arch/riscv/kernel/cpufeature.c          |  7 +++++++
>  5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..900a8fda1a2d 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>  
> +# Check if the toolchain supports Zihintpause extension
> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> +
>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>  
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..caa9ee5459b4 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 134388cbaaa1..106b35ba8cac 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -4,15 +4,28 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/jump_label.h>
>  #include <asm/barrier.h>
> +#include <asm/hwcap.h>
>  
> +extern struct static_key_false riscv_pause_available;
>  static inline void cpu_relax(void)
>  {
> +	if (!static_branch_likely(&riscv_pause_available)) {
>  #ifdef __riscv_muldiv
> -	int dummy;
> -	/* In lieu of a halt instruction, induce a long-latency stall. */
> -	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> +		int dummy;
> +		/* In lieu of a halt instruction, induce a long-latency stall. */
> +		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>  #endif
> +	} else {
> +#ifdef __riscv_zihintpause
> +		/*
> +		 * Reduce instruction retirement.
> +		 * This assumes the PC changes.
> +		 */
> +		__asm__ __volatile__ ("pause");
> +#endif
> +	}
>  	barrier();
>  }
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..89e563e9c4cc 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..327c19507dbb 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> +EXPORT_SYMBOL_GPL(riscv_pause_available);
>  
>  /**
>   * riscv_isa_extension_base() - Get base extension word
> @@ -192,6 +194,7 @@ void __init riscv_fill_hwcap(void)
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> +				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> @@ -213,6 +216,10 @@ void __init riscv_fill_hwcap(void)
>  
>  	}
>  
> +	if (__riscv_isa_extension_available(riscv_isa, RISCV_ISA_EXT_ZIHINTPAUSE)) {
> +		static_branch_enable(&riscv_pause_available);
> +	}
> +
>  	/* We don't support systems with F but without D, so mask those out
>  	 * here. */
>  	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> 

