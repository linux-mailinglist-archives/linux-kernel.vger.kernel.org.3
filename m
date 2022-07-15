Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A55760C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiGOLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiGOLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:44:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717729C8F;
        Fri, 15 Jul 2022 04:44:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o7so7373384lfq.9;
        Fri, 15 Jul 2022 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KBLDDA2+Sx6MxjI7VX3+/FeVIOWjEinua4fuRLYfv54=;
        b=c8dxC2omamMR0T7nrs/klONn389xq55P5WgJ+SvziRJDK3XgVMsSBjDCqJh4rKx8HN
         dA+9YGYL3pVROeOSpnQwYVL1pXF2PQNRImumAl1bOoQe1LxhNI7xAQWPs5vqnPtV80S0
         85jMZxRCvrrS1w/8qDcaQDUq+L+C39YssXIaoawiTqi+YwVRZfmqQGkd3B5PIHvNgmRU
         SEzccLHrYGYiuWQFUiDQq6mIFXISddMXgMs6kBgitUySSN5sU0nlYaDHgZcd3b4cjBUz
         JaMkR+asrAUItea6d6hlF3IoqdQ2cNw385gOydUb/nvCfRvEkD0d4P3gCtbYR+E8T+0w
         wJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBLDDA2+Sx6MxjI7VX3+/FeVIOWjEinua4fuRLYfv54=;
        b=xB8w5+KaoFdU/nW0AOvXiOBTzeI5HcJvOUSYQKSNTDgpgTaoaV6lZJgzhuwFPV5r7r
         cQ86zzWV8ZP6p2+NcpwHoX0P6Ms0IY9LTIobXb3sImjIRSY45Tt6hLHMyj+o2vD5Zg/P
         fgtkKJ+wQD0p7DLBUh2AMfrweUDOwVoKIuueju+XoRxsdr+r/IzFngaPG9+Buv6Q2V5W
         jVPpUSFq07NOwa3y/h7aIjZ0VU9MCvdlp7U+U54q9EKl3OZkusH0Zy1C8gmLmDdPcUKB
         NtweL9s8BmCsxxru1lQH38GetXYkpHALMNBioItpr1T+a/cJVT4L1bXE4EV8H9xdepDn
         QS9g==
X-Gm-Message-State: AJIora/ajWbpa1YfgWCdxeSHAYHEa/EXsdIuRDX/AkRsN3IBGV0A3a94
        0KRnLz2WIGJcTM5X2/KVlOkMsD8CJdw=
X-Google-Smtp-Source: AGRyM1v38dv4Q6AE+otYdidlt7WRcTaXyy+c3zdUkA7R/HTdE2v5va/OeQltYSMUCYbshjDKV3Uqkw==
X-Received: by 2002:a05:6512:3f84:b0:47f:673c:31b7 with SMTP id x4-20020a0565123f8400b0047f673c31b7mr8270011lfa.473.1657885464140;
        Fri, 15 Jul 2022 04:44:24 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id d8-20020a2eb048000000b0025da65c3b75sm176187ljl.16.2022.07.15.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:44:23 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:44:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220715114421.4uik3bmdyhscgyag@mobilestation>
References: <20220714222514.1570617-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714222514.1570617-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian

On Thu, Jul 14, 2022 at 03:25:12PM -0700, Florian Fainelli wrote:
> It is permissible for kernel code to call virt_to_phys() against virtual
> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> types. Rewrite the test condition to ensure that the kernel virtual
> addresses are above PAGE_OFFSET which they must be, and below KSEG2
> where the non-linear mapping starts.
> 
> For EVA, there is not much that we can do given the linear address range
> that is offered, so just return any virtual address as being valid.
> 
> Finally, when HIGHMEM is not enabled, all virtual addresses are assumed
> to be valid as well.
> 
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

No objections now. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> Changes in v2:
> 
> - handle lack of HIGHMEM and EVA
> 
>  arch/mips/mm/physaddr.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> index a1ced5e44951..f9b8c85e9843 100644
> --- a/arch/mips/mm/physaddr.c
> +++ b/arch/mips/mm/physaddr.c
> @@ -5,6 +5,7 @@
>  #include <linux/mmdebug.h>
>  #include <linux/mm.h>
>  
> +#include <asm/addrspace.h>
>  #include <asm/sections.h>
>  #include <asm/io.h>
>  #include <asm/page.h>
> @@ -12,15 +13,6 @@
>  
>  static inline bool __debug_virt_addr_valid(unsigned long x)
>  {
> -	/* high_memory does not get immediately defined, and there
> -	 * are early callers of __pa() against PAGE_OFFSET
> -	 */
> -	if (!high_memory && x >= PAGE_OFFSET)
> -		return true;
> -
> -	if (high_memory && x >= PAGE_OFFSET && x < (unsigned long)high_memory)
> -		return true;
> -
>  	/*
>  	 * MAX_DMA_ADDRESS is a virtual address that may not correspond to an
>  	 * actual physical address. Enough code relies on
> @@ -30,7 +22,9 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>  	if (x == MAX_DMA_ADDRESS)
>  		return true;
>  
> -	return false;
> +	return x >= PAGE_OFFSET && (KSEGX(x) < KSEG2 ||
> +	       IS_ENABLED(CONFIG_EVA) ||
> +	       !IS_ENABLED(CONFIG_HIGHMEM));
>  }
>  
>  phys_addr_t __virt_to_phys(volatile const void *x)
> -- 
> 2.25.1
> 
