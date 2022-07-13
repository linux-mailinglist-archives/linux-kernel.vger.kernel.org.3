Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5193F573A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiGMPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiGMPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:35:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB824F19E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:35:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r6so14571467edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=bF5lMeSAYnrYjSItFrOxNLQLP0b65zhQ4S5LCvO/+RI=;
        b=DSykAu6MZ9nu5Je9PlvoZ80+/eXr4lHrc7ApPvvZ4XcFJWaInzt8w+t4lZU2lyAVXn
         9X91yS9fJy8a7G9uSZTK0DM6G82gJ63UmKIqmWoNyEidIVMptsK/j3khOpJkCE4ETucW
         RxkFt1xhQM56+h1pGMvwzOO9vhiZRjASwi0qiRazXQ1/hq5+WNUmemoybuK/+arNFf2X
         DOr9E8DWDgsY7INWjU4YDhMjlNeMV8qlhphyJFlYom7lGApqlRphxygibJivyK32WNHK
         jeJelEK/W3dL9EJkGOrOSh58V84ZiadEn/A3xqLd/87rdDY42qzVhPcgzLtiYYDnyFcO
         LRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bF5lMeSAYnrYjSItFrOxNLQLP0b65zhQ4S5LCvO/+RI=;
        b=y6DcBP6kDDYNiExEQeoveH8QzuQJcvrzNuwgJhYFGqoTqmv6lcqhuT5DfaDZGFF0cl
         bbCSiSEkOj4ls+nU0G8/YU07QXlzZsJriEV3nanUYBFQxVPpD/otuB7f7cdFmzE8aPrB
         wEz6N3Xtmq67kr8aay8lqW19Z2/aaxOV/pWqokviZ8+nf2kcQ7VT2yODH0GOQsvFjbpu
         /8OUa265uJID1XWb4sd4DEzuSRBR5ozqSqVlgrtXaoQ0Xwg5DG2ZMFs8iBkEI90Agazp
         XwSTaOyp5T8VQn4qNWWYZuCslQ15kSusBJeRHP1uAYp+m8BfTeTESrYTW1aGVDEBEMD1
         VGog==
X-Gm-Message-State: AJIora+jDu8Xm0bE1poKGlnCSrf0/i7w253jCYb4yzytVzhSAAEF/pP9
        nqurNPaltDZ+j7C4f5gxCFQ=
X-Google-Smtp-Source: AGRyM1tl0bKmf11iXnFRUh2objVIoRSXWd8DJg51wH5H8D9VuVx/KICormbvpcSTjXqXlx7b67iSVg==
X-Received: by 2002:a05:6402:2936:b0:43a:711c:7c9b with SMTP id ee54-20020a056402293600b0043a711c7c9bmr5851531edb.144.1657726536590;
        Wed, 13 Jul 2022 08:35:36 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id y22-20020a170906071600b0072aac7446easm5110783ejb.47.2022.07.13.08.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:35:36 -0700 (PDT)
Message-ID: <f00dbaaf-bf92-11db-8a2b-ef78e0a91347@gmail.com>
Date:   Wed, 13 Jul 2022 17:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v2 5/8] arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to
 ARCH_BCMBCA
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20220707070037.261532-1-william.zhang@broadcom.com>
 <20220707070037.261532-6-william.zhang@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220707070037.261532-6-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.07.2022 09:00, William Zhang wrote:
> Remove ARCH_BCM_63XX Kconfig for BCM63138 and merge its selections to
> ARCH_BCMBCA. Delete bcm63xx.c as it is no longer needed.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/mach-bcm/Kconfig   | 26 +++++++++-----------------
>   arch/arm/mach-bcm/Makefile  |  7 +------
>   arch/arm/mach-bcm/bcm63xx.c | 17 -----------------
>   3 files changed, 10 insertions(+), 40 deletions(-)
>   delete mode 100644 arch/arm/mach-bcm/bcm63xx.c
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index f73a056bf560..25aa4ef4db07 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -182,23 +182,6 @@ config ARCH_BCM_53573
>   	  The base chip is BCM53573 and there are some packaging modifications
>   	  like BCM47189 and BCM47452.
>   
> -config ARCH_BCM_63XX
> -	bool "Broadcom BCM63xx DSL SoC"
> -	depends on ARCH_MULTI_V7
> -	select ARCH_HAS_RESET_CONTROLLER
> -	select ARM_ERRATA_754322
> -	select ARM_ERRATA_764369 if SMP
> -	select ARM_GIC
> -	select ARM_GLOBAL_TIMER
> -	select CACHE_L2X0
> -	select HAVE_ARM_ARCH_TIMER
> -	select HAVE_ARM_TWD if SMP
> -	select HAVE_ARM_SCU if SMP
> -	help
> -	  This enables support for systems based on Broadcom DSL SoCs.
> -	  It currently supports the 'BCM63XX' ARM-based family, which includes
> -	  the BCM63138 variant.

Oh, wait a second. This is actually going to totally break builds for
people because there are a lot of Kconfig-s that depend on it!

I don't believe it can't be handled this way.

You need to first introduce a replacement / parent symbol.
Then (in another release if needed) update all Kconfig-s.
Then eventually you can get rid of ARCH_BCM_63XX.
