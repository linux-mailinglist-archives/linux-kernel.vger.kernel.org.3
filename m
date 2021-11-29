Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467E46125A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbhK2K1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344127AbhK2KZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:25:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F8C061373
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:56:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so14044972wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JoYsHU+XJpC5AlXMYy6dlFDTBWZmry/p4RloOev9FFw=;
        b=sS+elfRruvzi6wtAMsU/s+WNTxXW1bfySN8LfJ8IUQMovxXGfHp9ghpNCYglOmE0Hu
         xk1H8EfBzfdEBJiqAydhcxEQ6tJrUEJzefpPyEfZHcP1BVxp3BaMW1wFf67lzKa8CMXT
         5GGMta5RdyaT9oVWaKWF4X0e/AjTRIcbjku5JEJqOvFHkxeydPm9VllvVPBHARsKFwLl
         1pNe1UuiL82xffXYJybUDewoFZFQWd/dlEVKNNWBRDQ7fgYHwUz9YbWh2069Oflv9Qz/
         AcQL0olLD980D9eQsZqTG61PYVjCgw3BPx4h+5f0AEyHedPS7SVZirBysQtqzQWXmsIp
         Ldyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JoYsHU+XJpC5AlXMYy6dlFDTBWZmry/p4RloOev9FFw=;
        b=xsQXcHHQL8yfjmcpFzS3X6GzZJyOizc5mmrbFtunm5Hz0Nob9J9NJkDs0Rf2rW9alI
         L3yQSZZpRTKzJlN1dKHHyCj+3cloqwDZBq5UZSbvvgG2VrgxUUGqQS06LuXdGc0g1j9E
         O+lQDNTn9vxGkThsp+bsxI/yJhqE0lqTeeU9kwIZMEW8oVXxXlw6eNiNarn/yRDK4+GT
         UqKJm24kLLJimVsL+ziil2c5+Fok93vk4lmrSuZfweXufK/lx5VPAaQunOtpXKcq2Llb
         4Fym0/jTWK8kiWT3H5MNkNbxOGIZ3v1APMwSbduqgFmPWNhVxnRs41nktcmZ59+xEvtZ
         c1gg==
X-Gm-Message-State: AOAM532y4LM7WKs4A7PVRL50VfI+d90HpJbqFg/TjVfTP9NhCjcQnj/w
        adb49cmmWsQM4PiY5E+Usa09Hw==
X-Google-Smtp-Source: ABdhPJx/wqUhMKyU8qOU/313Add1TM/BvSiew6HbDgIqgaQwkq+sPRs6LA2xh9cQDneaokaPe1CSbA==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr35644457wmq.53.1638179784955;
        Mon, 29 Nov 2021 01:56:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd? ([2a01:e34:ed2f:f020:8236:a2e5:8d62:e9cd])
        by smtp.googlemail.com with ESMTPSA id h13sm13642392wrx.82.2021.11.29.01.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 01:56:24 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: Fix timer regression for beagleboard revision c
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
References: <20211125144834.52457-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6ce29c03-03ce-8e65-76e1-40fe2bf23caa@linaro.org>
Date:   Mon, 29 Nov 2021 10:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211125144834.52457-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony,

On 25/11/2021 15:48, Tony Lindgren wrote:
> Commit e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> caused a timer regression for beagleboard revision c where the system
> clockevent stops working if omap3isp module is unloaded.
> 
> Turns out we still have beagleboard revisions a-b4 capacitor c70 quirks
> applied that limit the usable timers for no good reason. This also affects
> the power management as we use the system clock instead of the 32k clock
> source.
> 
> Let's fix the issue by adding a new omap3-beagle-ab4.dts for the old timer
> quirks. This allows us to remove the timer quirks for later beagleboard
> revisions. We also need to update the related timer quirk check for the
> correct compatible property.
> 
> Fixes: e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> Cc: linux-kernel@vger.kernel.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reported-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt     |  3 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/omap3-beagle-ab4.dts        | 47 +++++++++++++++++++
>  arch/arm/boot/dts/omap3-beagle.dts            | 33 -------------
>  drivers/clocksource/timer-ti-dm-systimer.c    |  2 +-
>  5 files changed, 52 insertions(+), 34 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-beagle-ab4.dts

Usually, bindings DT and driver changes are separate patches


> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -119,6 +119,9 @@ Boards (incomplete list of examples):
>  - OMAP3 BeagleBoard : Low cost community board
>    compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
>  
> +- OMAP3 BeagleBoard A to B4 : Early BeagleBoard revisions A to B4 with a timer quirk
> +  compatible = "ti,omap3-beagle-ab4", "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
> +
>  - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
>    compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -794,6 +794,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
>  	logicpd-som-lv-37xx-devkit.dtb \
>  	omap3430-sdp.dtb \
>  	omap3-beagle.dtb \
> +	omap3-beagle-ab4.dtb \
>  	omap3-beagle-xm.dtb \
>  	omap3-beagle-xm-ab.dtb \
>  	omap3-cm-t3517.dtb \
> diff --git a/arch/arm/boot/dts/omap3-beagle-ab4.dts b/arch/arm/boot/dts/omap3-beagle-ab4.dts
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-beagle-ab4.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +#include "omap3-beagle.dts"
> +
> +/ {
> +	model = "TI OMAP3 BeagleBoard A to B4";
> +	compatible = "ti,omap3-beagle-ab4", "ti,omap3-beagle", "ti,omap3430", "ti,omap3";
> +};
> +
> +/*
> + * Workaround for capacitor C70 issue, see "Boards revision A and < B5"
> + * section at https://elinux.org/BeagleBoard_Community
> + */
> +
> +/* Unusable as clocksource because of unreliable oscillator */
> +&counter32k {
> +	status = "disabled";
> +};
> +
> +/* Unusable as clockevent because of unreliable oscillator, allow to idle */
> +&timer1_target {
> +	/delete-property/ti,no-reset-on-init;
> +	/delete-property/ti,no-idle;
> +	timer@0 {
> +		/delete-property/ti,timer-alwon;
> +	};
> +};
> +
> +/* Preferred always-on timer for clocksource */
> +&timer12_target {
> +	ti,no-reset-on-init;
> +	ti,no-idle;
> +	timer@0 {
> +		/* Always clocked by secure_32k_fck */
> +	};
> +};
> +
> +/* Preferred timer for clockevent */
> +&timer2_target {
> +	ti,no-reset-on-init;
> +	ti,no-idle;
> +	timer@0 {
> +		assigned-clocks = <&gpt2_fck>;
> +		assigned-clock-parents = <&sys_ck>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -308,39 +308,6 @@ &usbhsehci {
>  	phys = <0 &hsusb2_phy>;
>  };
>  
> -/* Unusable as clocksource because of unreliable oscillator */
> -&counter32k {
> -	status = "disabled";
> -};
> -
> -/* Unusable as clockevent because if unreliable oscillator, allow to idle */
> -&timer1_target {
> -	/delete-property/ti,no-reset-on-init;
> -	/delete-property/ti,no-idle;
> -	timer@0 {
> -		/delete-property/ti,timer-alwon;
> -	};
> -};
> -
> -/* Preferred always-on timer for clocksource */
> -&timer12_target {
> -	ti,no-reset-on-init;
> -	ti,no-idle;
> -	timer@0 {
> -		/* Always clocked by secure_32k_fck */
> -	};
> -};
> -
> -/* Preferred timer for clockevent */
> -&timer2_target {
> -	ti,no-reset-on-init;
> -	ti,no-idle;
> -	timer@0 {
> -		assigned-clocks = <&gpt2_fck>;
> -		assigned-clock-parents = <&sys_ck>;
> -	};
> -};
> -
>  &twl_gpio {
>  	ti,use-leds;
>  	/* pullups: BIT(1) */
> diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
> --- a/drivers/clocksource/timer-ti-dm-systimer.c
> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
> @@ -241,7 +241,7 @@ static void __init dmtimer_systimer_assign_alwon(void)
>  	bool quirk_unreliable_oscillator = false;
>  
>  	/* Quirk unreliable 32 KiHz oscillator with incomplete dts */
> -	if (of_machine_is_compatible("ti,omap3-beagle") ||
> +	if (of_machine_is_compatible("ti,omap3-beagle-ab4") ||
>  	    of_machine_is_compatible("timll,omap3-devkit8000")) {
>  		quirk_unreliable_oscillator = true;
>  		counter_32k = -ENODEV;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
