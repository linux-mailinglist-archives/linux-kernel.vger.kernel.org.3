Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011CC4EE58D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiDABHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiDABHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:07:44 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9522452B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:05:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A8F533201D7C;
        Thu, 31 Mar 2022 21:05:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 31 Mar 2022 21:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=JFPUhEjYt2T4y/
        GMkEpZ62RhA982gs20GEDWtE6vuw0=; b=Teg/IxXO072MtZ6w8wqKTQ9jMwRRwb
        JUC32kpiUh4om79WZpOd89UU5CrAZI6eb1EKMnUHlWsJ60pqBUF1PlTOKM9ejmeI
        POc52d8FfoSuYLKw46I+VuE/AWv2N4uIsNMQ9l2mHkj3NOlsLqxcfQ4FvWha0+eG
        r/cAkk2CueW+4ndElt1PrTIPDnyZAKIejtS5MLjfNcbfjhhhEDvUy71+SMcU/iUj
        d4a+OgbtLDYDICUq4/SIzXrbIFLdNWfLQLzlS/QtTuNNzlgJIqJCIR7Kz9unMfXh
        T6Uql2Ut3AngcQ+jGtyvj7JFzu1Ak7TMDhex9z8HFP/G9YGCq2qO9z2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JFPUhEjYt2T4y/GMkEpZ62RhA982gs20GEDWtE6vu
        w0=; b=N5Sw/NgUAzNkar8BRLk7ziFMiwX+6SAXPG3RX9oigAjmMrdgACzZqSX8U
        TEHcgKyuWBzf5kEdhaTz+/7//vDWqhytXsBqDjYGLzL5RF1QZWT+mfcC34qAM9pt
        Yqm0nJ8ASo7avMmCYlqua5QUgZnQtByKau9ZfaIChoVB/eclQQvbA03VYDQwYFFQ
        0/JPOghF7TDl94+8jIQKmV/9AifUUk4QTvMluyGMAXuXSxKonxYSy7lErHF71weJ
        AaJBQ2EFadevYrg9l8E+zQ7vVV6uvgRh9ze/6maPHdwdFm/4K/jNbWyrXOUgbWNE
        FqAmccExgEtD9CBeEJ9ONa/q3GHSQ==
X-ME-Sender: <xms:7k9GYg_v06RsvtEt-tnNH5a3trqEzlHB_VgLWVuy6_80Qh8nD_j5cg>
    <xme:7k9GYotfzkJYN8TW1azCeI0FVT1sUNSw6yxmGlLTuQwpNVlHH-XOeBzelxl92qU_E
    mK8GH1K8W8YrleVKA>
X-ME-Received: <xmr:7k9GYmDoOXEVD3Q0JgRwfRrxTb_WlXUvTC1F98vIaOUQUwFcjh19MKDL5MZDSwbdmmSHgjhmq6jvXgYztUndS2Pw_7eZ9F1a7L3lRKtdeH4m-yvz5hsaKQ4u9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeihedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:7k9GYged0fk-Mm9VRkcAVGZgdqDhwy69nQsl9mAebzlxFytEqdesCA>
    <xmx:7k9GYlPqC8JNO1dQD2MYfLz3CWPDj-DGre8VyZh3rlefGIRL84X4MQ>
    <xmx:7k9GYqnzA9OI5FnFHbTGDE4W4S-RB0HjHCR3lRJvG3Rv1sw1R8SaLg>
    <xmx:709GYmG33Tqsn1PrchZiTVQfdRsYiVXqflubtw5id1SuimpkPRthYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Mar 2022 21:05:49 -0400 (EDT)
Subject: Re: [PATCH 2/2] riscv: implement cache-management errata for T-Head
 SoCs
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
References: <20220307224620.1933061-1-heiko@sntech.de>
 <20220307224620.1933061-3-heiko@sntech.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ab119a0a-3434-dd76-7af1-4e8b296896f6@sholland.org>
Date:   Thu, 31 Mar 2022 20:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307224620.1933061-3-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 4:46 PM, Heiko Stuebner wrote:
> The T-Head C906 and C910 implement a scheme for handling
> cache operations different from the generic Zicbom extension.
> 
> Add an errata for it next to the generic dma coherency ops.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Tested-by: Samuel Holland <samuel@sholland.org>

With this option disabled, MMC and USB are broken on D1 boards:

[    3.021326] Waiting for root device /dev/mmcblk0p1...
[    3.219727] usb 4-1: new full-speed USB device number 2 using ohci-platform
[   18.703736] usb 4-1: device descriptor read/64, error -110

With the option enabled, MMC, USB, and Ethernet all work fine.

> ---
>  arch/riscv/Kconfig.erratas           | 10 +++++++
>  arch/riscv/errata/thead/errata.c     |  5 ++++
>  arch/riscv/include/asm/errata_list.h | 45 ++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index de4002baa1d0..89a6dcb8ac2a 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -50,4 +50,14 @@ config ERRATA_THEAD_PBMT
>  
>  	  If you don't know what to do here, say "Y".
>  
> +config ERRATA_THEAD_CMO
> +	bool "Apply T-Head cache management errata"
> +	depends on ERRATA_THEAD && RISCV_DMA_NONCOHERENT
> +	default y
> +	help
> +	  This will apply the cache management errata to handle the
> +	  non-standard handling on non-coherent operations on T-Head SoCs.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index fd8e0538a3f0..11c26c37425f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -33,6 +33,11 @@ static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
>  		.stage = RISCV_ALTERNATIVES_EARLY_BOOT,
>  		.check_func = errata_mt_check_func
>  	},
> +	{
> +		.name = "cache-management",
> +		.stage = RISCV_ALTERNATIVES_BOOT,
> +		.check_func = errata_mt_check_func
> +	},
>  };
>  
>  static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 7a2dd61af24d..f7c6805daeab 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -16,7 +16,8 @@
>  
>  #ifdef CONFIG_ERRATA_THEAD
>  #define	ERRATA_THEAD_PBMT 0
> -#define	ERRATA_THEAD_NUMBER 1
> +#define	ERRATA_THEAD_CMO 1
> +#define	ERRATA_THEAD_NUMBER 2
>  #endif
>  
>  #define	CPUFEATURE_SVPBMT 0
> @@ -104,8 +105,37 @@ asm volatile(ALTERNATIVE(								\
>  #define CBO_CLEAN_A0	".long 0x25200F"
>  #define CBO_FLUSH_A0	".long 0x05200F"
>  
> +/*
> + * dcache.ipa rs1 (invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01010      rs1       000      00000  0001011
> + * dache.iva rs1 (invalida, virtual address)
> + *   0000001    00110      rs1       000      00000  0001011
> + *
> + * dcache.cpa rs1 (clean, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01001      rs1       000      00000  0001011
> + * dcache.cva rs1 (clean, virtual address)
> + *   0000001    00100      rs1       000      00000  0001011
> + *
> + * dcache.cipa rs1 (clean then invalidate, physical address)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000001    01011      rs1       000      00000  0001011
> + * dcache.civa rs1 (... virtual address)
> + *   0000001    00111      rs1       000      00000  0001011
> + *
> + * sync.s (make sure all cache operations finished)
> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> + *   0000000    11001     00000      000      00000  0001011
> + */
> +#define THEAD_INVAL_A0	".long 0x0265000b"
> +#define THEAD_CLEAN_A0	".long 0x0245000b"
> +#define THEAD_FLUSH_A0	".long 0x0275000b"
> +#define THEAD_SYNC_S	".long 0x0190000b"
> +
>  #define ALT_CMO_OP(_op, _start, _size)							\
> -asm volatile(ALTERNATIVE(								\
> +asm volatile(ALTERNATIVE_2(								\
> +	"nop\n\t"									\
>  	"nop\n\t"									\
>  	"nop\n\t"									\
>  	"nop\n\t"									\
> @@ -117,7 +147,16 @@ asm volatile(ALTERNATIVE(								\
>  	CBO_##_op##_A0 "\n\t"								\
>  	"addi a0, a0, %0\n\t"								\
>  	"2:\n\t"									\
> -	"bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT)		\
> +	"bltu a0, %2, 3b\n\t"								\
> +	"nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT,				\
> +	"mv a0, %1\n\t"									\
> +	"j 2f\n\t"									\
> +	"3:\n\t"									\
> +	THEAD_##_op##_A0 "\n\t"								\
> +	"addi a0, a0, %0\n\t"								\
> +	"2:\n\t"									\
> +	"bltu a0, %2, 3b\n\t"								\
> +	THEAD_SYNC_S, THEAD_VENDOR_ID, ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
>  	: : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),			\
>  	    "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))
>  
> 

