Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D23573A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiGMPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGMPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:31:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A19A4D4C6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:31:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g1so14560887edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=v+NbnBpLM8CH3pMiJXhOvbClXtPnzpaTQ3C/Hg2AE08=;
        b=QMqRouXjV6MvWAPTsEWYImTX2GNZoWFT9IIr4z0nE1B7BzUbbwY3uZsnh9+q8ze0/5
         s/2i/PJJOiBADbfKOb+pMCI6acd7AxBmTQOn7XgIns7mfUWYFuyy0dexEPDld702+ouA
         Jzk8kTT6hhHacitx7Kcd2iGHAjPI7eHMclaMpxjRTozinN3NGlkl3b1BQrlGF0qTVcTs
         GXdiKX0L72cACexS3fDMgduEhpCo2Al4MdwOO6UXl+u7ShojohlVmlEsvnOn2aQFAm0Z
         WOgw4qn667tekpHFTgvTQ5uoFwq1Bd01b1B/gKx+F1J0Dx3aRexx7TUonnkpGSUgeHct
         8ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v+NbnBpLM8CH3pMiJXhOvbClXtPnzpaTQ3C/Hg2AE08=;
        b=JcZ9uvr3dXDt1CwsMUX2XFwj/RI9vuBeZPMZAG4TvPOGFO/p5haIFnDm9oDCtxsBIW
         YkLvW8Yp6auqqWJigGtcSeUwoNAVlzNhhX3pXNIauF/raxrXUCMB5XUAV85ilDlkjvO2
         /Ubhk1+IUXih7oVgw7za5+IdzFo28JUW5XECfCn3QWo2npIrV4rJWiWC7JNaznLojBsf
         QmEQO/nh904VWQUtJNqRE9nEDvvkemauRzbO9qqTYxaf9Str9zcIXfXqHxxEKfj9h8ye
         9vySkfnTGhWjewJ9+kaNn9JjQL2Rm8eQ0vtGWPNxwc3nquc4yeBPmqte7z2INw7ELGGf
         zMYg==
X-Gm-Message-State: AJIora+m5MeoB8oQJCEfSVIFI8vpmBmClAGELh+e6NlpryMfzmzghaeW
        G4JDURaFzENo9V0WGG5yjBE=
X-Google-Smtp-Source: AGRyM1vCzHvfZMl/BQ+obD/9D4KXI65SDwrvJ0N1qZHxgtM6A5r2jii3MfvYD2RCkDPUrF+eKw7WCw==
X-Received: by 2002:a05:6402:1bda:b0:43a:55d7:9f2f with SMTP id ch26-20020a0564021bda00b0043a55d79f2fmr5597729edb.360.1657726285955;
        Wed, 13 Jul 2022 08:31:25 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id ee1-20020a056402290100b0043a6df72c11sm7990145edb.63.2022.07.13.08.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:31:25 -0700 (PDT)
Message-ID: <3cc9a340-1403-9a90-0d2b-49f719ca31fd@gmail.com>
Date:   Wed, 13 Jul 2022 17:31:24 +0200
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

What about ARCH_BCM_63XX references in
1. arch/arm/Kconfig.debug
2. arch/arm/configs/multi_v7_defconfig

Did you handle them in some other patchset?


This change is probably going to break "make oldconfig" for users. Is
there any kernel policy for that? Do we care about it? Should we leave
old symbol as hidden and make ARCH_BCMBCA auto-selected if it's set?


Finally it'd probably be more clean to first introduce
ARCH_BCMBCA_CORTEXA9 and then get rid of ARCH_BCM_63XX.


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
> -
>   config ARCH_BRCMSTB
>   	bool "Broadcom BCM7XXX based boards"
>   	depends on ARCH_MULTI_V7
> @@ -224,10 +207,19 @@ config ARCH_BCMBCA
>   	select ARM_AMBA
>   	select ARM_GIC
>   	select HAVE_ARM_ARCH_TIMER
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_764369 if SMP
> +	select ARM_GLOBAL_TIMER
> +	select CACHE_L2X0
> +	select HAVE_ARM_TWD if SMP
> +	select HAVE_ARM_SCU if SMP
> +
>   	help
>   	  Say Y if you intend to run the kernel on a Broadcom Broadband ARM-based
>   	  BCA chipset.
>   
>   	  This enables support for Broadcom BCA ARM-based broadband chipsets,
>   	  including the DSL, PON and Wireless family of chips.
> +
>   endif
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 284ea2f8cbc2..25347d7049b8 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -50,12 +50,6 @@ ifeq ($(CONFIG_ARCH_BCM_5301X),y)
>   obj-$(CONFIG_SMP)		+= platsmp.o
>   endif
>   
> -# BCM63XXx
> -ifeq ($(CONFIG_ARCH_BCM_63XX),y)
> -obj-y				+= bcm63xx.o
> -obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_pmb.o
> -endif
> -
>   ifeq ($(CONFIG_ARCH_BRCMSTB),y)
>   CFLAGS_platsmp-brcmstb.o	+= -march=armv7-a
>   obj-y				+= brcmstb.o
> @@ -64,5 +58,6 @@ endif
>   
>   # BCMBCA
>   ifeq ($(CONFIG_ARCH_BCMBCA),y)
> +obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_pmb.o
>   obj-y				+= bcmbca.o
>   endif
> diff --git a/arch/arm/mach-bcm/bcm63xx.c b/arch/arm/mach-bcm/bcm63xx.c
> deleted file mode 100644
> index f855e361dfba..000000000000
> --- a/arch/arm/mach-bcm/bcm63xx.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -// Copyright (C) 2014 Broadcom Corporation
> -
> -#include <linux/of_platform.h>
> -
> -#include <asm/mach/arch.h>
> -
> -static const char * const bcm63xx_dt_compat[] = {
> -	"brcm,bcm63138",
> -	NULL
> -};
> -
> -DT_MACHINE_START(BCM63XXX_DT, "BCM63xx DSL SoC")
> -	.dt_compat	= bcm63xx_dt_compat,
> -	.l2c_aux_val	= 0,
> -	.l2c_aux_mask	= ~0,
> -MACHINE_END

