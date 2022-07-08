Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740C556B924
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiGHL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiGHL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:58:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA49A69F;
        Fri,  8 Jul 2022 04:58:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bf9so12728079lfb.13;
        Fri, 08 Jul 2022 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FpBSCA3uZ1qD6QzdKwkZAqZgGkjusbAbzf1QWhDabko=;
        b=Fs/fvFTCVTRQSGhf7mxK921gbeoirfQfyYvyiO3m7JEqDIPkSCh71mIVtFx+ASt2Tq
         f9aUfxWCy2FrppSsAIQuIOVVuY6pcXAYgbvX39SkquNGCktXyf6QNsxDLOmdk7u3tW9K
         07rsgG1icB1AvnxPznHSB/M6xOoAEuLHpXQydH07v3VFwSWyKEjrZ7JtMkaWgZUZEkvy
         I1iQEKSAUNkWfCukat4sOXw3mVd1qxBzHEvPJF5tS6/GvI23962OAg1l0+Os11oqBYNn
         lLZ6EbS4BKuW0pzgITghmG+o8p2quB3hhsDjPQSF2wmsZnGBBAX0dhXYlUlmCbPN9k98
         iHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FpBSCA3uZ1qD6QzdKwkZAqZgGkjusbAbzf1QWhDabko=;
        b=Kw4q9e3Yac2lVDv/yhdUaS9kco9lL6Mvsk05RDGEUUMsRrrIuQzwK3BZ+xNdHUi5NX
         u0PL39kSdnonNUIOBcd2nQ0uVhjjM1p+4iy6h+wT4Y4aOlO2nIaO74VszjvbgZ1RfLJs
         /PeU/+Xrgx/MV3AVJpkP8NmTuCYwGnc7rM6HFDU+KcCzVs7XamlqFXRQhXJ7vjg7M8vM
         ElBWBdi03BcDA+tPDEalomy+n4v3emuWiwsTmjj23rtDqN+GLtA4VU2daGJYjp9wMIg2
         /gYKi5ykEJr1HsZ1sBAxpSs4r6U8k8DjvOxhuwrvVe6cPtE/QQZKmKdn/3JcAcs0Y7BX
         SQDQ==
X-Gm-Message-State: AJIora+B1h68jOQyR0Gk9c3JaEa4h/HzHuvPZByfUnjVjsZbSvtHbc17
        E5Gj7ex8uaUGaqW4g6658ZLy3QVYF354qA==
X-Google-Smtp-Source: AGRyM1sXxLaUp60Rft57xTvCYRK0vwK57cvWbGq2ok6kJsKfghrHamIOijenFM2SM9hE9u3CRHa9jQ==
X-Received: by 2002:a05:6512:3e09:b0:482:bbd4:9657 with SMTP id i9-20020a0565123e0900b00482bbd49657mr2154038lfv.86.1657281533996;
        Fri, 08 Jul 2022 04:58:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9903000000b0025d382331d8sm2027632lji.120.2022.07.08.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:58:53 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:58:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, gerg@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220708115851.ejsooiilxcopkoei@mobilestation>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707215237.1730283-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> It is permissible for kernel code to call virt_to_phys() against virtual
> addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> types. Add a final condition that ensures that the virtual address is
> below KSEG2.
> 
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/mm/physaddr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> index a1ced5e44951..a82f8f57a652 100644
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
> @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
>  	if (x == MAX_DMA_ADDRESS)
>  		return true;
>  

> -	return false;
> +	return KSEGX(x) < KSEG2;

With this do we really need the high_memory-based conditionals in this
method?

If the line above is the only way to take the uncached segment into
account then can we reduce the whole method to:
static inline bool __debug_virt_addr_valid {
	return x >= PAGE_OFFSET && KSEGX(x) < KSEG2;
}
?

Though this still may be invalid for EVA systems, like malta (see
arch/mips/include/asm/mach-malta/spaces.h).

Note AFAICS if EVA is enabled, highmem is implied to be disabled (see
the CPU_MIPS32_3_5_EVA config utilization and HIGHMEM config
dependencies). Thus all the memory is supposed to be linearly mapped
in that case.

-Sergey

>  }
>  
>  phys_addr_t __virt_to_phys(volatile const void *x)
> -- 
> 2.25.1
> 
