Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416C54EFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379724AbiFQDtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiFQDtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:49:42 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2D663D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:49:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 18DBD5C00C8;
        Thu, 16 Jun 2022 23:49:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 23:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655437781; x=
        1655524181; bh=Xm4aMYc0ZNtEYl9j1l1e/6xeNVUCElp52aNbQzNgfO0=; b=g
        0RMck67KBi9ll2qjD1r8UgBWVlWgaZAHPJGA8W5su7OsxkxulebkHQZwpYV7NCGm
        GaLu0dj/vUESHj5hGrmu+9Qd7Yd04ZJfv0WIRx1ym4Za17F2fKNQtVCVyC/qgwHr
        Pr2MaA7X+NoiT/7RCN52lVddIrXRZzLJJNiBYFUfPcR4gmurDI/fsJTmLnXOeABK
        9FhPz+m8qd5S4IbGgLWsxitIN0SafForYws+69XsodA13cMgt6pnxk5ncDHDWQcj
        MsBq6UknhEq3C4kGkgMSXCOouZXQ3n6gIEQsOjiBdgiGOHPST8j54irboOluv4OH
        U1HS2mvzY586vzZB8Ys0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655437781; x=
        1655524181; bh=Xm4aMYc0ZNtEYl9j1l1e/6xeNVUCElp52aNbQzNgfO0=; b=c
        p86UOzUBGr+Ss2cJYPpLqodX8rbLMkrt4xDWPtYb7ewv55jB03AcHv3LlX2u0I8M
        b8sLpmnwrYhG5pOuO5LeHnzqkb2sbk3vaoGg/8FI1N7DJFM1OLqT8Ni3IcmvfcC/
        zDB0Nk8xUNQmk5eLPw2Pp2q1nFXsPTZyKVjDBtH5KjtHl7dz8PvQHLaHmQWPgLmI
        XpgQCAqJf5Qyv/VLMLgqaTRWa9D2vkvzShMFCVOqADKnL8z+NJvhA+KnmLwXeRwQ
        540bMEjA93yObFeS3/6fhnRi0m6cbe6iPnpSRXHZxWDmDFkEcyjymY7p0M0/HUXF
        cYTsr86omAz67cuGCq9sg==
X-ME-Sender: <xms:0_mrYv0VVhv-UDPp4flh9hIKuKnebhAq3Y1wNbAc7sDVvSDFcgUWgw>
    <xme:0_mrYuHGmu4wwT3wyLd75xQ6go19WP0o7KECbhujuLrdXeGw9NorZRf1ZyxQhsc5P
    ZLWgTI6Z_oTTTdAmA>
X-ME-Received: <xmr:0_mrYv4rYRNxsxpNTWuhSBRGpr2kZqncvNXMwNXJTjyVvEA6OzfOExGpPHoXO4iahvue4XEt8z6f2tnMQ-fMdgbkDgiQr_Rsc5PxCw6e2wmUMqSBTEQIaYSLyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejleefuddtgeegvedvkeehfeejfeevgfefiefffeegudeiuedt
    heekjeelgeeujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:0_mrYk1b8aRKIad3XD0Djdbqh1OcoXQdxXj8NkgRYphFmL_128gnQQ>
    <xmx:0_mrYiHSCkC_X-qk9A4KCrCpdXQpbuBA0e0ZkeuWHhWytEmQDdy7Ug>
    <xmx:0_mrYl-6t9Kp904tXbkGrb26ch98i05PL8LdHb6OPn4w-kG7FcFnbw>
    <xmx:1fmrYgEGz3hSlrT77P_RUwRF_EeN0Wgge5UGPITuSj942krXxzGLmw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 23:49:38 -0400 (EDT)
Subject: Re: [PATCH v3] arch/riscv: add Zihintpause support
To:     Dao Lu <daolu@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Wei Fu <wefu@redhat.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rob Herring <robh@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Yury Norov <yury.norov@gmail.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
References: <20220615211415.3111271-1-daolu@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6b52cc2c-7bc5-5015-b7a6-4c13bb4789f7@sholland.org>
Date:   Thu, 16 Jun 2022 22:49:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220615211415.3111271-1-daolu@rivosinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 4:14 PM, Dao Lu wrote:
> Implement support for the ZiHintPause extension.
> 
> The PAUSE instruction is a HINT that indicates the current hart’s rate
> of instruction retirement should be temporarily reduced or paused.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
> 
> v1 -> v2:
>  Remove the usage of static branch, use PAUSE if toolchain supports it
> v2 -> v3:
>  Added the static branch back, cpu_relax() behavior is unchanged if either the
> system or the toolchain does not support ZiHintPause
> ---
>  arch/riscv/Makefile                     |  4 ++++
>  arch/riscv/include/asm/hwcap.h          |  1 +
>  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
>  arch/riscv/kernel/cpu.c                 |  1 +
>  arch/riscv/kernel/cpufeature.c          |  8 ++++++++
>  5 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..6ddacc6f44b9 100644
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
> index 4e2486881840..f24f4f8c9144 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>  	RISCV_ISA_EXT_SVPBMT,
> +	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 134388cbaaa1..314ec17c40d8 100644
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
> +#ifdef __riscv_zihintpause
> +	} else {
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
> index fba9e9f46a8c..a123e92b14dd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a6f62a6d1edd..78c284c487e8 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -30,6 +30,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> +EXPORT_SYMBOL_GPL(riscv_pause_available);

This patch should probably be rebased to use the unified static key
mechanism[1], since that patch has now been merged.

Regards,
Samuel

[1]: https://lore.kernel.org/linux-riscv/20220522153543.2656-2-jszhang@kernel.org/
