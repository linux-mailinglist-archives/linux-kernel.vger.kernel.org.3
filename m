Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A4511A87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiD0NGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiD0NGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:06:35 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B7DCB;
        Wed, 27 Apr 2022 06:03:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso1013679otk.10;
        Wed, 27 Apr 2022 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=41yunm+lS0x9OKFTJJaFvpJWxmfNu7cbQFvxht2PQ0Y=;
        b=Djs7ebC36uO25LOxqBbY11JXMOwr462SGowSqkea/WVq2ncQmC+Y88YodCIDDpFAk5
         y4wbbdSPYwgpfbPDS/uRTUMa0KsU5ok6ZEmTPhT/DN9/HQFsNUn7fTZZqaPfrV4zxeZr
         tLzfdtQPtJNTUEC/kD6eOqWaaSTEGUfgH0XC1818mgFKPjlhGA3tzxlT+0vVBs1+IMzY
         lVER6qxEdpXCRh9bPRlvtm2YdiMAAXvudlefNzBZdCd2cxqhDxeojLwFLtcTJD9j6yTX
         AOTfo1uwOtQT2v+nTD4KDZbcZvzNWAJuL4bf23Pj6rjXOi8gmA/+Wp8hQH6NEkSszi8/
         WtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=41yunm+lS0x9OKFTJJaFvpJWxmfNu7cbQFvxht2PQ0Y=;
        b=DfMo2tLlKC9+azDYnVBcoCTF2i84j2KTShAX9d+WN02JJe20fZlGeQ8HhVSrNsmf4M
         ffbVCukk+XGs1YoNQm3f5C1q4bg24ABk9U0idE4vo8uTLlP9ane7PKRmLIXkoyj8+PGA
         FodJ2JNanR8SmxN8b8JOARTKAQ4esw0ZTGY3KrBSyMMRegpDNamEFaHOhAaquwZhFvt5
         s+fSMQEzhTz8YvOeUXEj9RIH4jUxPxxy6ojoX+EenUW7nzEMiD+/TTNMsx12ItSvykKq
         2gIJ6diepqDo5uBlgnfJZ7p5sDzBDsQosPmnwf4XGDyOld99mcy2tX1XAOJ+kqgE59Jn
         YOrw==
X-Gm-Message-State: AOAM530ulemjMg7w+keEYWca9hbx/dtlQMLOh8Akjea+hIs2jidQiVxS
        bGGZu6xGrBnYTrAKtzSaCIg=
X-Google-Smtp-Source: ABdhPJzZ0A0wIhQcTXEyYsVLqDGs+FuofT63neIX1W17xL9xJt5oqD/OgzGqWOyz9LH0d3V7yezjTA==
X-Received: by 2002:a9d:57c9:0:b0:605:4ba7:d01f with SMTP id q9-20020a9d57c9000000b006054ba7d01fmr9814358oti.106.1651064603580;
        Wed, 27 Apr 2022 06:03:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a4a80c4000000b0035e62548577sm3974341oog.7.2022.04.27.06.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:03:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <79a5ec82-da71-57c3-d7bb-11607cb71bb4@roeck-us.net>
Date:   Wed, 27 Apr 2022 06:03:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        wim@linux-watchdog.org, geert+renesas@glider.be,
        tzungbi@kernel.org, linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220413082527.155740-1-jjhiblot@traphandler.com>
 <20220413082527.155740-3-jjhiblot@traphandler.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220413082527.155740-3-jjhiblot@traphandler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 01:25, Jean-Jacques Hiblot wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
> very limited timeout capabilities. However, it can reset the device.
> To do so, the corresponding bits in the SysCtrl RSTEN register need to
> be enabled. This is not done by this driver.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>   drivers/watchdog/Kconfig    |   8 ++
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/rzn1_wdt.c | 203 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 212 insertions(+)
>   create mode 100644 drivers/watchdog/rzn1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c4e82a8d863f..4d5e503c8950 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -883,6 +883,14 @@ config RENESAS_RZAWDT
>   	  This driver adds watchdog support for the integrated watchdogs in the
>   	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
>   
> +config RENESAS_RZN1WDT
> +	tristate "Renesas RZ/N1 watchdog"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  This driver adds watchdog support for the integrated watchdogs in the
> +	  Renesas RZ/N1 SoCs. These watchdogs can be used to reset a system.
> +
>   config RENESAS_RZG2LWDT
>   	tristate "Renesas RZ/G2L WDT Watchdog"
>   	depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f7da867e8782..38d38564f47b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>   obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>   obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>   obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
> +obj-$(CONFIG_RENESAS_RZN1WDT) += rzn1_wdt.o
>   obj-$(CONFIG_RENESAS_RZG2LWDT) += rzg2l_wdt.o
>   obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>   obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> new file mode 100644
> index 000000000000..fa32716727b7
> --- /dev/null
> +++ b/drivers/watchdog/rzn1_wdt.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 Watchdog timer.
> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
> + * cope with 2 seconds.
> + *
> + * Copyright 2018 Renesas Electronics Europe Ltd.
> + *
> + * Derived from Ralink RT288x watchdog timer.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT		60
> +
> +#define RZN1_WDT_RETRIGGER			0x0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL		0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK	0xfff
> +#define RZN1_WDT_RETRIGGER_PRESCALE		BIT(12)
> +#define RZN1_WDT_RETRIGGER_ENABLE		BIT(13)
> +#define RZN1_WDT_RETRIGGER_WDSI			(0x2 << 14)
> +
> +#define RZN1_WDT_PRESCALER			16384
> +#define RZN1_WDT_MAX				4095
> +
> +struct rzn1_watchdog {
> +	struct watchdog_device		wdtdev;
> +	void __iomem			*base;
> +	unsigned long			clk_rate;

Nit: Whenever clk_rate is used, it is divided by 1000.
It might be better to store and use clk_rate_khz instead.

Guenter
