Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6E52717C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiENOA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiENOAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:00:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8B13F32;
        Sat, 14 May 2022 07:00:50 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id k25-20020a056830169900b00605f215e55dso6920332otr.13;
        Sat, 14 May 2022 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5s+doHcYQWzsPeh1k8QMpiHwn1NutW4RM6Yb0cra0w=;
        b=WonD9bik2i2LWjMSuw+kATdtO63CjkAXmXLKLK1WFKtqk2grZ5M/XKCyFfVHktQRQc
         Cj/epoHbr402sgBhVuwUGg7/QQ9HatLD2I2oe52B8y6ETGoMUVHwv45lCncnopx/kEdJ
         EmjCmjNbXLgCN9OK7qKhpFbofy75pObVsV5EVNoNokzKZukVf6EU4Xmqu2jG6LApJ0s1
         SgoS/vyc5Yitf92vWOWduSNWtl8HdqopVBkY9PFfbEHlZZnLdoJTYbOzUqTa3cAN4iLj
         OBHuvrgP4iz6c0KoO8ZAuTSX3lfdHTX1KDqCmIzw2S07yzmA0lEZIGfoCQgaIGPsBQmM
         kvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=r5s+doHcYQWzsPeh1k8QMpiHwn1NutW4RM6Yb0cra0w=;
        b=4dcU2XkERB5QY/FBR3tY/v6wb8efKplG0a/h+MYt9Cp6/Wyddwdy7n6QToGr8V5iZB
         FX/h/RensifWGj3VIFpfcnOlahmvmPTftcEjMylkqdrsYI0OIOCt5gvVdn3uVIu/Ymf5
         V4DhSppeJRWQTzOgdv7rUHUYpXS1nsyF8g9QknmdK3uah7PlvZsInno3LsMzPeKJ6uPR
         +ZyUq/tR7NId6ixe6Ulm8V7SYS8dTneClkSqUOmCJz+z2lVoQs8ctEn5DC1Lxfb9iO1I
         qIxXUptpHC1YN1Q9kiLe1RdwqalPXunqUkAY+7V58Wb3uf7wRLzp3aLzJftSpHZ77D2H
         RBrg==
X-Gm-Message-State: AOAM531a7ip8tvYpXg3741gICsHSG3JsPZDMQo2aiBgSc8QliiAks9d1
        n16fp/l8OE7+cQ8GpcwZpSpYVHd/ryFJ3w==
X-Google-Smtp-Source: ABdhPJxY98kAGijVKg0vLPBl2mgcf5CmxD8ZncDkfFie3T/F7As56uNYEJjOprbFasvDcBiCNs/LcQ==
X-Received: by 2002:a05:6830:1c65:b0:606:3cc:862 with SMTP id s5-20020a0568301c6500b0060603cc0862mr3434882otg.75.1652536848463;
        Sat, 14 May 2022 07:00:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r196-20020acaa8cd000000b00325cda1ffa5sm2066306oie.36.2022.05.14.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:00:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 May 2022 07:00:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Hari Nagalla <hnagalla@ti.com>, Nishanth Menon <nm@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: rti_wdt: Fix calculation and evaluation of
 preset heartbeat
Message-ID: <20220514140046.GA1244552@roeck-us.net>
References: <6a4b54ac-9588-e172-c4c7-b91d524a851e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4b54ac-9588-e172-c4c7-b91d524a851e@siemens.com>
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

On Mon, Feb 21, 2022 at 05:22:38PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This ensures that the same value is read back as was eventually
> programmed when using seconds as accuracy. Even then, comparing the more
> precise heartbeat_ms against heartbeat in seconds will almost never
> provide a match and will needlessly raise a warning. Fix by comparing
> apples to apples.
> 
> Tested in combination with U-Boot as watchdog starter.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> To fully work, it also needs a U-Boot patch to add the same 10% margin 
> to the clock frequency:
> 
> https://patchwork.ozlabs.org/project/uboot/patch/9b3603a3-1bf4-eb57-c378-20d5c2accc34@siemens.com/
> 
>  drivers/watchdog/rti_wdt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 117bc2a8eb0a..3ecd14e180fb 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -252,6 +252,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
> +		int preset_heartbeat;
>  		u32 time_left_ms;
>  		u64 heartbeat_ms;
>  		u32 wsize;
> @@ -262,11 +263,12 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
>  		heartbeat_ms *= 1000;
>  		do_div(heartbeat_ms, wdt->freq);
> -		if (heartbeat_ms != heartbeat * 1000)
> +		preset_heartbeat = heartbeat_ms + 500;
> +		preset_heartbeat /= 1000;
> +		if (preset_heartbeat != heartbeat)
>  			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>  
> -		heartbeat = heartbeat_ms;
> -		heartbeat /= 1000;
> +		heartbeat = preset_heartbeat;
>  
>  		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>  		ret = rti_wdt_setup_hw_hb(wdd, wsize);
