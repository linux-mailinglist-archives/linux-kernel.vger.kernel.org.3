Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514052EF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiETP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiETP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:28:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4641611F3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:28:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso2746731wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5E8x4FVCG4g/RN7rMnV9PFAV1qWnSvWM5QdqIp4Vq7k=;
        b=yB3flR0GH7yb9Y8wc7BfiuVtckbP/9wqbQCRMWsL8b3J6VoBI7GMOeWRlIp6xBiyLr
         AHCFYizo+NTn9wwC2dqspUHYEU/bpHY7suR7Qtzf9G+MchHu3N4KDBNWM9Cog+VJvfbm
         b3wSQpzabSemL9H7CUNuzGZV/iVoAfzFCXTe406MTfQw5fRjDC4Tzi8rx9JntAUEs1La
         Se5jZTnx+dj6dvOBwBwzGygr40w2sRJStTuT/0nluR6xIUQhYUHFfOOKDBrFjbcLsgQ8
         kCApURu3FkaRquEfLF/848NTlsQSkOzyM2CcPmhVxJAoMEvHjUY1UGimjgSdZq3x0AM3
         myWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5E8x4FVCG4g/RN7rMnV9PFAV1qWnSvWM5QdqIp4Vq7k=;
        b=06F4IDmPk37K6uzFpi4frHkFraP7O6aCu8e4PtAjt7VZmof9vA8s3Le7+ATVBY7bY+
         hO2cKJHKaJF9MY9N2GctFI1LSocY+dWtJCp4cup6jD7Lr1d2HmqEpXNPVa/TtR6kiJ+n
         nqsl9NI1w1m8PizXh7CjRkP0RXFfGSJrmg+1d2enGK/39f4FtlAQgFlEsWUGIQfxfmIc
         8Y6Hg+k6RZBanOQJKbnwH21ORvhk5B2FXhGY0HV2Zq16svdBohS1/eBovXh1XDSSr8O9
         KZfhP82F0C17ie7N0kdoP7NC21+jtYWTfSMaTUk8Ly+vlmdBni4HrnFDv1exvI2Buht8
         BOsQ==
X-Gm-Message-State: AOAM531d5pmdRJZkJoVb9dBM8L1BnLAckY8j4aV9Mri1F+Px6UGvDUHF
        3blIU/Z0s+MRb1iJtUZUanC/sw==
X-Google-Smtp-Source: ABdhPJy+Obtd+PPQDqBECWvKM3CYT5IeaUl1xlBHl9ryqy9MFWl/X3Q6zlQcBCBFMyt6vTMS0QrlUQ==
X-Received: by 2002:a7b:c414:0:b0:394:21dd:e24f with SMTP id k20-20020a7bc414000000b0039421dde24fmr8777432wmi.133.1653060492002;
        Fri, 20 May 2022 08:28:12 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b8:a290:ff05:e4c4? ([2a01:e34:ed2f:f020:b8:a290:ff05:e4c4])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c211100b003942a244f4fsm2169682wml.40.2022.05.20.08.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:28:10 -0700 (PDT)
Message-ID: <156a53a2-c33b-7ec5-3584-41ef25cb9cdd@linaro.org>
Date:   Fri, 20 May 2022 17:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] clocksource/drivers/timer-ti-dm: Make timer
 selectable for ARCH_K3
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220408101715.43697-1-tony@atomide.com>
 <20220408101715.43697-3-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220408101715.43697-3-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:17, Tony Lindgren wrote:
> Let's make timer-ti-dm selectable for ARCH_K3, and add a separate option
> for OMAP_DM_SYSTIMER as there should be no need for it on ARCH_K3.
> 
> For older TI SoCs, we are already selecting OMAP_DM_TIMER in
> arch/arm/mach-omap*/Kconfig. For mach-omap2, we need to now also select
> OMAP_DM_SYSTIMER.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/Kconfig  | 2 ++
>   drivers/clocksource/Kconfig  | 8 +++++++-
>   drivers/clocksource/Makefile | 2 +-
>   3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -105,6 +105,7 @@ config ARCH_OMAP2PLUS
>   	select MACH_OMAP_GENERIC
>   	select MEMORY
>   	select MFD_SYSCON
> +	select OMAP_DM_SYSTIMER
>   	select OMAP_DM_TIMER
>   	select OMAP_GPMC
>   	select PINCTRL
> @@ -160,6 +161,7 @@ config SOC_OMAP2420
>   	bool "OMAP2420 support"
>   	depends on ARCH_OMAP2
>   	default y
> +	select OMAP_DM_SYSTIMER
>   	select OMAP_DM_TIMER
>   	select SOC_HAS_OMAP2_SDRC
>   
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -22,7 +22,7 @@ config CLKEVT_I8253
>   config I8253_LOCK
>   	bool
>   
> -config OMAP_DM_TIMER
> +config OMAP_DM_SYSTIMER
>   	bool
>   	select TIMER_OF
>   
> @@ -56,6 +56,12 @@ config DIGICOLOR_TIMER
>   	help
>   	  Enables the support for the digicolor timer driver.
>   
> +config OMAP_DM_TIMER
> +	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST

Actually, I missed this. Could you convert to a 'bool' there is no 
module in the timer drivers ATM.



> +	select TIMER_OF
> +	help
> +	  Enables the support for the TI dual-mode timer driver.
> +
>   config DW_APB_TIMER
>   	bool "DW APB timer driver" if COMPILE_TEST
>   	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
>   obj-$(CONFIG_DAVINCI_TIMER)	+= timer-davinci.o
>   obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
>   obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
> -obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm-systimer.o
> +obj-$(CONFIG_OMAP_DM_SYSTIMER)	+= timer-ti-dm-systimer.o
>   obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
>   obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
>   obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
