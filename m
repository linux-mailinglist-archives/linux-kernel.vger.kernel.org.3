Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E654859ADA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiHTLvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiHTLvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:51:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9A248DA;
        Sat, 20 Aug 2022 04:51:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 83so729420pfw.6;
        Sat, 20 Aug 2022 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=673WIW76Z1Z00tbIt7+Ez7IqYGsJnXmx9K9copympOk=;
        b=RffZTBmHyruOE6/ViFVFHN5oJdOpbN/TaSCGZdTlMfTowa6Gr4w9P4J/y72dDBONG3
         BpWJ3Y1Zce6KjTMLcCY7vOR/iqkG4aHu2N+U4LSVdxf5ULmVaI6Xx487vPZd1jEACvps
         McqIY+YtzNsJGbBY4h80/1KeMswNLKjlyL407067lR5Xc2WSsUAN0Awn50sgi+NjrYx0
         VrcGj5ibVn+RSE/eYVAaIy0n9trelzaXxB6/xJ2L3h41JYzBfut9ABcS+bggSfV0nZj6
         kU+Noz7vxtczHpCt4wn8DIIwq1Wbxgvq020Vpvz/vYelpIzqkafjzF0i0i63ezcx1yof
         4GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=673WIW76Z1Z00tbIt7+Ez7IqYGsJnXmx9K9copympOk=;
        b=UPvSHiQ5cDrbJok5D1kS1LFMkuh6xNWXMSFKPY2FpNtyirXHuA2Pz+42oS/W8syMTa
         JuRcwYfb6tUlvEIWdbHUMqmq3yQ/+fY6LbujmOPMJhTSu8t5LZXISsHouxhStmQFnIv8
         ztmXaJ1drnEHukeDndO/SK7MuLxbJ7VV/BjwVL0k9TkpRB6QQ3HJqbHIqk9gjVKw3Myr
         /OWV3RZxgi5p8HOpmZAU3uw++XEl5b7KIOhO5WQZqIAWzSF7jE2DYx3bNT7IK3biLqSc
         ucBWbyssUWVv89K7Zbrj0+4Luq9rXf2sTprftdskpqVY0YRG9jYULr+Vkv8hYIw1+Ktf
         0umg==
X-Gm-Message-State: ACgBeo2vAn/0JyXy9BqhFSOKtlRIxgb4vBDI1DEvkLU4Uk4Kpamo8kks
        wXxoggmIWWdKYr7evh6CbWfEs5rHyEk=
X-Google-Smtp-Source: AA6agR6RaRM9Pnlyho6j/lzSbUs/REuPQGmcLF7c9WuuaP87Wpvl93MNaxPeoz2cEYmKetn91Ohhsg==
X-Received: by 2002:a63:d0:0:b0:41b:c075:acb5 with SMTP id 199-20020a6300d0000000b0041bc075acb5mr9718815pga.480.1660996262556;
        Sat, 20 Aug 2022 04:51:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o65-20020a625a44000000b0052d200c8040sm5056635pfb.211.2022.08.20.04.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:51:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 Aug 2022 04:50:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog/hpwdt: Build issue for ARM64 platforms
Message-ID: <20220820115058.GB3958319@roeck-us.net>
References: <20220819231423.1236664-1-jerry.hoemann@hpe.com>
 <20220819231423.1236664-2-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819231423.1236664-2-jerry.hoemann@hpe.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:14:22PM -0600, Jerry Hoemann wrote:
> Fixes commit d48b0e173715 ("x86, nmi, drivers: Fix nmi splitup build bug")
> 
> Include <asm/nmi.h> only if CONFIG_HPWDT_NMI_DECODING is defined.
> 
The descrition doesn't describe the problem (what is the build issue ?),
the fix reference should be a Fixes: tag, and the subject should describe
what is done, not the problem (ie "Fix build issue...")

Thanks,
Guenter

> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index a5006a58e0db..f79f932bca14 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -20,7 +20,9 @@
>  #include <linux/pci_ids.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
> +#ifdef CONFIG_HPWDT_NMI_DECODING
>  #include <asm/nmi.h>
> +#endif
>  #include <linux/crash_dump.h>
>  
>  #define HPWDT_VERSION			"2.0.4"
> -- 
> 2.37.1
> 
