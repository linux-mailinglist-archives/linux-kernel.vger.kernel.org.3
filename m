Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2715768C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiGOVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:18:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360AF2B620;
        Fri, 15 Jul 2022 14:18:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w7so4192637ply.12;
        Fri, 15 Jul 2022 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zUmqRRlT3OTuRn9l8Mu2LnCH5PPWFieqtHz/92xaYnE=;
        b=F76BVCheOLBPhMC/ki65FXn1MwQMyXsuhp3iBkE4OuL55ptNmr6tYZUvjQ84Hrw0kv
         Uml5bvQZNLZ4prZHsn/xtFk6W7VpBt19GD4viAih6TUy1HIHzy3CZwkgTzb70eZEJuff
         VNfEMR8z0TeJEcvOaX2rCBj6sdkZTwdPdKlO/ViiR3HT1t8ZbkGqDNwVEzX5wP4PCZkV
         HySrFi8Wn3/NjGd86ehCJYsCirkc2T3/HmApocsaGuvDOldBK9wQlokDMWR0dEi3l3Da
         bxeVYHvls9nLKC2pjhNf9KQkKmc6LZRFPlAd5Up5/nysDMK1aUezgZQiPa1x6ahxGAkN
         G2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zUmqRRlT3OTuRn9l8Mu2LnCH5PPWFieqtHz/92xaYnE=;
        b=Mn3a+2EanL9tAChdZsW5rCw4gLe8SJqDRAzQuPsFuu2viyCMvt3ScUilOhtzsGV7/Q
         Vwc+bJhTRB82Qc2KghGBQ6RnXZf4nZccw6L7szLTIr9W9Sg2mFH2cWdkzTvMyhCLe6pt
         bJ7avT4DaunYdj8k/Q+iCvTPdDfMwH1T2uk0K2/PooYqqV8l4DKdZ26GczvfMkKLeegp
         e/YtIWwibHCjd5JvgA2hP5HsLPKOAHL9YvhtDgCHArYMjIb7MfCGjS6iPMtfl64wGGuT
         I2s4pDPA2XMqXkJhgZ85y/Vfe2tp2TwGuSoVu9ekn33MKDZRawu/jCeCxxjGC/O8wriN
         7c+g==
X-Gm-Message-State: AJIora8IhqZJmyGcMmBmVepU2c4LHalJ710Pt41J+WbrOZkdOPAdYAqr
        38bq868ZkQPTo8E7IJ4O8YhOi96gmtE=
X-Google-Smtp-Source: AGRyM1ubpTmIraGhlalkvIRLqAHd5+iVym9jqH10InCDRKa153Mub67O9h4UXj2Q5AbyYC6m04iqjA==
X-Received: by 2002:a17:902:ecd0:b0:16c:461d:8008 with SMTP id a16-20020a170902ecd000b0016c461d8008mr15481415plh.65.1657919896161;
        Fri, 15 Jul 2022 14:18:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f12-20020a17090a664c00b001eff36b1f2asm3965589pjm.0.2022.07.15.14.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:18:15 -0700 (PDT)
Message-ID: <ed40a657-e2cd-0070-b192-469163f274d2@gmail.com>
Date:   Fri, 15 Jul 2022 14:18:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] MIPS: CFE: Add cfe_die()
Content-Language: en-US
To:     linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220715194737.4174717-1-f.fainelli@gmail.com>
 <20220715194737.4174717-2-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220715194737.4174717-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 12:47, Florian Fainelli wrote:
> Add a cfe_die() implementation which is useful when the kernel does an
> early panic and no console is registered. This allows us to print
> useful diagnostics such as an invalid DTB having been
> configured/selected.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/fw/cfe/cfe_api.c             | 48 +++++++++++++++++++++++++-
>  arch/mips/include/asm/fw/cfe/cfe_api.h |  2 ++
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/fw/cfe/cfe_api.c b/arch/mips/fw/cfe/cfe_api.c
> index 0c9c97ab291e..6e7883f1d47e 100644
> --- a/arch/mips/fw/cfe/cfe_api.c
> +++ b/arch/mips/fw/cfe/cfe_api.c
> @@ -13,10 +13,15 @@
>   *
>   * Authors:  Mitch Lichtenberg, Chris Demetriou
>   */
> -
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <asm/mipsregs.h>
>  #include <asm/fw/cfe/cfe_api.h>
>  #include "cfe_api_int.h"
>  
> +unsigned long __initdata cfe_seal;
> +
>  /* Cast from a native pointer to a cfe_xptr_t and back.	 */
>  #define XPTR_FROM_NATIVE(n)	((cfe_xptr_t) (intptr_t) (n))
>  #define NATIVE_FROM_XPTR(x)	((void *) (intptr_t) (x))
> @@ -412,3 +417,44 @@ int cfe_writeblk(int handle, s64 offset, const char *buffer, int length)
>  		return xiocb.xiocb_status;
>  	return xiocb.plist.xiocb_buffer.buf_retlen;
>  }
> +
> +void __init cfe_die(char *fmt, ...)
> +{
> +	char msg[128];
> +	va_list ap;
> +	int handle;
> +	unsigned int count;
> +
> +	va_start(ap, fmt);
> +	vsprintf(msg, fmt, ap);
> +	strcat(msg, "\r\n");
> +
> +	if (cfe_seal != CFE_EPTSEAL)
> +		goto no_cfe;
> +
> +	/* disable XKS01 so that CFE can access the registers */
> +#if defined(CONFIG_CPU_BMIPS4380)
> +	__write_32bit_c0_register($22, 3,
> +		__read_32bit_c0_register($22, 3) & ~BIT(12));
> +#elif defined(CONFIG_CPU_BMIPS5000)
> +	__write_32bit_c0_register($22, 5,
> +		__read_32bit_c0_register($22, 5) & ~BIT(8));
> +#endif

Need to make this dynamic using read_c0_prid() because we support selecting multiple types of CPU in a single kernel image. V2 coming shortly.
-- 
Florian
