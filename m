Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5F4E5758
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiCWRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiCWRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:23:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710675BD03
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:21:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so3083734wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6sXiDJvv69n8sHq+JRwL0P1DmaR1Tz5cYXPQWGXC/Qo=;
        b=1g7KaD85BOYVRTcTLkv82FEI1SnFXurp/HCBpDNBoifcWmL2FLh94HOkNvc+yM5TYk
         HzIxMTbi1Lo41Av8/q50o2zOggWUXcv1owiCnBBRVeUtxuTgaBHylbAhoay1NGLhY+mF
         J+U+kqC2lkNKQ0KKTpzB328D/LBABX+dLfuyeR69bix7E3f+eMtS60wTRBDNtWcqFhwY
         vUoEgoleh0sfr33THUkiwo2gGYYznwdMAxcIkDvLjYvvV5XJas1vIt/FRfy9k8v1HBCE
         uepBzEQr/9nuiC4jt6H4JjqzfkDyVN6ame6htBFrJ9+VrxZADd0lYQD8AoT0MiQgHTLj
         jN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6sXiDJvv69n8sHq+JRwL0P1DmaR1Tz5cYXPQWGXC/Qo=;
        b=4HPkskSxQbQt9WwcFN//SGn7p9ajN++xwpiV9eidEAEJLPzDGeRv6gLqlICC+IGB0p
         AOBdwA1NNBCpJ5Rgt0YVuNdoh8mIUVQR+Bg0GYU04rsrm7vDFwPvajufIc7ch9C75Iz3
         OwzshKMZsseYwxcyRbxPa8xmsNZzmn/lfJDbybKlNnTOpjnHndRju3Q4VEAKRk8Bob1e
         aoS+cfeZYQxPU0l3RgFap3Q5t5YP1leOI0yJdZ4F3KKaGgxr8YzqTEk6Z6nf56Qvxxn6
         AYkljDDGlVJVWE1NgcpAFCpL0//Eg3BO/AWHgXVgjTTVWjs44oVogJo1lkaI2qt7shgi
         o+Pw==
X-Gm-Message-State: AOAM531W+FKioggLPfm8d3jJnaOBHVU7Mi6oIGmxhFeONWUOBlPNhxFh
        VOwEvaVxI1ggOOj16Vse1+ECmg==
X-Google-Smtp-Source: ABdhPJxBjkif7aQVExZrGrjt/c8OcfPCG2t36WRW88q14eWB1N0M36x34ibCL3UHx+Bv6adSvS7GPQ==
X-Received: by 2002:a05:6000:15c2:b0:205:922e:3aa2 with SMTP id y2-20020a05600015c200b00205922e3aa2mr436873wry.411.1648056112963;
        Wed, 23 Mar 2022 10:21:52 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.4.19])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b002058148822bsm487374wrw.63.2022.03.23.10.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:21:52 -0700 (PDT)
Message-ID: <329d26b2-14d1-d8c7-ccbd-ddbb0c011370@conchuod.ie>
Date:   Wed, 23 Mar 2022 17:21:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Content-Language: en-US
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
References: <20220322132839.3653682-1-mick@ics.forth.gr>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220322132839.3653682-1-mick@ics.forth.gr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 13:28, Nick Kossifidis wrote:
> In case the DTB provided by the bootloader/BootROM is before the kernel
> image or outside /memory, we won't be able to access it through the
> linear mapping, and get a segfault on setup_arch(). Currently OpenSBI
> relocates DTB but that's not always the case (e.g. if FW_JUMP_FDT_ADDR
> is not specified), and it's also not the most portable approach since
> the default FW_JUMP_FDT_ADDR of the generic platform relocates the DTB
> at a specific offset that may not be available. To avoid this situation
> copy DTB so that it's visible through the linear mapping.

Ran into the same issue & have been carrying a hack for it, this looks 
*a lot* cleaner. I'll dig out the offending configuration tomorrow and 
try to give you a tested-by.
Thanks,
Conor.

> 
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>   arch/riscv/mm/init.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0d588032d..697a9aed4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -206,8 +206,25 @@ static void __init setup_bootmem(void)
>   	 * early_init_fdt_reserve_self() since __pa() does
>   	 * not work for DTB pointers that are fixmap addresses
>   	 */
> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> -		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> +		/*
> +		 * In case the DTB is not located in a memory region we won't
> +		 * be able to locate it later on via the linear mapping and
> +		 * get a segfault when accessing it via __va(dtb_early_pa).
> +		 * To avoid this situation copy DTB to a memory region.
> +		 * Note that memblock_phys_alloc will also reserve DTB region.
> +		 */
> +		if (!memblock_is_memory(dtb_early_pa)) {
> +			size_t fdt_size = fdt_totalsize(dtb_early_va);
> +			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
> +			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
> +
> +			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
> +			early_memunmap(new_dtb_early_va, fdt_size);
> +			_dtb_early_pa = new_dtb_early_pa;
> +		} else
> +			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +	}
>   
>   	early_init_fdt_scan_reserved_mem();
>   	dma_contiguous_reserve(dma32_phys_limit);
