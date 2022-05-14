Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFF5271C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiENOOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiENOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:14:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED707140F3;
        Sat, 14 May 2022 07:14:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n24so13426640oie.12;
        Sat, 14 May 2022 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEhPgqQPjv/RUsBOF1AxLqaXyoNhquLKmYEGb+8MUAI=;
        b=eCeYutYMcT6Mn4Wq8kzDbxI06VTQ+dpm3TYNTxJ+vdUTyZjS9Kr8bTyG5h4UgNguXH
         E942CqZjIVDpX7COyxUS24JKBmmpepOhlsCxeUCTWPahrxmpheJNAtEl/2FFTunMsulU
         NMI2e0xUk7vdZqdtPmHkbXDpRHXLSQXgffXwCPYXm7VvURsshhg6VaEhR2mdxnf/qvAc
         2tzInDiFUKOjIBFwfxLhIrt26u2neMLtjOQO7h36iK9IdkQJhxa3wUhm4WMnxuIPACnm
         VP6NZBjEXDrn9aimZvRNfe28f5la9EFamT5u5fxJ9WgWb3Y3kANUZKJ0phpgCiALhV8r
         G7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FEhPgqQPjv/RUsBOF1AxLqaXyoNhquLKmYEGb+8MUAI=;
        b=337ViMbJpADZ+gIWibL++uxGKHz/fq/X//y6dREMrJKp0MI/+FZNEoEGTEY7csTlb3
         UiRjZfSxuHZy6loo1rZhF4oRtABv5P+OmlT80YQFMfFSYXoPtCdBu/BGOcmf8wNUaYrh
         ucjdqiLpg91iQ4S6uBnKrXeOmybc4E5t0LlwFv4IcCdaPG69b76h2qKtkvCP1MJ3JbZn
         CoIVWGpt+2QEf6iKrTXxspb9AzcW4zZGREPgxgnuFsepLMUjIMMA5bM0MDufU33B/8qo
         EndU4v3yyj5y7i297lWPClW2QKTkjvMM2sXsuvxDQO0Z8OD0V4VJ6iBtUVs6SoQawEbX
         eOnQ==
X-Gm-Message-State: AOAM5312fIsozSN/AbNyWQqu/tMu7cZffp5Yh5J8MpdRvTXg327TdpMq
        336HOVombPeDZmyYp2TGwPr0ZBPttUx+MA==
X-Google-Smtp-Source: ABdhPJzDNUY6i4vbR8luuGuFJh+ceCDhBr6P7EuoNHU56u/8ATENuaEaCoqq+JAf4puDwQacT33Xzw==
X-Received: by 2002:a05:6808:1b07:b0:328:ab46:623f with SMTP id bx7-20020a0568081b0700b00328ab46623fmr4658571oib.152.1652537685299;
        Sat, 14 May 2022 07:14:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13-20020a9d588d000000b0060603221258sm2166468otg.40.2022.05.14.07.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:14:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 May 2022 07:14:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     wim@linux-watchdog.org, geert+renesas@glider.be,
        tzungbi@kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v7 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Message-ID: <20220514141443.GA1319155@roeck-us.net>
References: <20220427135531.708279-1-jjhiblot@traphandler.com>
 <20220427135531.708279-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427135531.708279-3-jjhiblot@traphandler.com>
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

On Wed, Apr 27, 2022 at 03:55:31PM +0200, Jean-Jacques Hiblot wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig    |   8 ++
>  drivers/watchdog/Makefile   |   1 +
>  drivers/watchdog/rzn1_wdt.c | 203 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/watchdog/rzn1_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c4e82a8d863f..4d5e503c8950 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -883,6 +883,14 @@ config RENESAS_RZAWDT
>  	  This driver adds watchdog support for the integrated watchdogs in the
>  	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
>  
> +config RENESAS_RZN1WDT
> +	tristate "Renesas RZ/N1 watchdog"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  This driver adds watchdog support for the integrated watchdogs in the
> +	  Renesas RZ/N1 SoCs. These watchdogs can be used to reset a system.
> +
>  config RENESAS_RZG2LWDT
>  	tristate "Renesas RZ/G2L WDT Watchdog"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f7da867e8782..38d38564f47b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
>  obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
>  obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
>  obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
> +obj-$(CONFIG_RENESAS_RZN1WDT) += rzn1_wdt.o
>  obj-$(CONFIG_RENESAS_RZG2LWDT) += rzg2l_wdt.o
>  obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>  obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> new file mode 100644
> index 000000000000..55ab384b9965
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
> +	unsigned long			clk_rate_khz;
> +};
> +
> +static inline uint32_t max_heart_beat_ms(unsigned long clk_rate_khz)
> +{
> +	return (RZN1_WDT_MAX * RZN1_WDT_PRESCALER) / clk_rate_khz;
> +}
> +
> +static inline uint32_t compute_reload_value(uint32_t tick_ms,
> +					    unsigned long clk_rate_khz)
> +{
> +	return (tick_ms * clk_rate_khz) / RZN1_WDT_PRESCALER;
> +}
> +
> +static int rzn1_wdt_ping(struct watchdog_device *w)
> +{
> +	struct rzn1_watchdog *wdt = watchdog_get_drvdata(w);
> +
> +	/* Any value retrigggers the watchdog */
> +	writel(0, wdt->base + RZN1_WDT_RETRIGGER);
> +
> +	return 0;
> +}
> +
> +static int rzn1_wdt_start(struct watchdog_device *w)
> +{
> +	struct rzn1_watchdog *wdt = watchdog_get_drvdata(w);
> +	u32 val;
> +
> +	/*
> +	 * The hardware allows you to write to this reg only once.
> +	 * Since this includes the reload value, there is no way to change the
> +	 * timeout once started. Also note that the WDT clock is half the bus
> +	 * fabric clock rate, so if the bus fabric clock rate is changed after
> +	 * the WDT is started, the WDT interval will be wrong.
> +	 */
> +	val = RZN1_WDT_RETRIGGER_WDSI;
> +	val |= RZN1_WDT_RETRIGGER_ENABLE;
> +	val |= RZN1_WDT_RETRIGGER_PRESCALE;
> +	val |= compute_reload_value(w->max_hw_heartbeat_ms, wdt->clk_rate_khz);
> +	writel(val, wdt->base + RZN1_WDT_RETRIGGER);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rzn1_wdt_irq(int irq, void *_wdt)
> +{
> +	pr_crit("RZN1 Watchdog. Initiating system reboot\n");
> +	emergency_restart();
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct watchdog_info rzn1_wdt_info = {
> +	.identity = "RZ/N1 Watchdog",
> +	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +};
> +
> +static const struct watchdog_ops rzn1_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = rzn1_wdt_start,
> +	.ping = rzn1_wdt_ping,
> +};
> +
> +static void rzn1_wdt_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rzn1_watchdog *wdt;
> +	struct device_node *np = dev->of_node;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +	int ret;
> +	int irq;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->base))
> +		return PTR_ERR(wdt->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
> +			       np->name, wdt);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", irq);
> +		return ret;
> +	}
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get the clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(dev, "failed to prepare/enable the clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
> +				       clk);
> +	if (ret)
> +		return ret;
> +
> +	clk_rate = clk_get_rate(clk);
> +	if (!clk_rate) {
> +		dev_err(dev, "failed to get the clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	wdt->clk_rate_khz = clk_rate / 1000;
> +	wdt->wdtdev.info = &rzn1_wdt_info,
> +	wdt->wdtdev.ops = &rzn1_wdt_ops,
> +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
> +	wdt->wdtdev.parent = dev;
> +	/*
> +	 * The period of the watchdog cannot be changed once set
> +	 * and is limited to a very short period.
> +	 * Configure it for a 1s period once and for all, and
> +	 * rely on the heart-beat provided by the watchdog core
> +	 * to make this usable by the user-space.
> +	 */
> +	wdt->wdtdev.max_hw_heartbeat_ms = max_heart_beat_ms(wdt->clk_rate_khz);
> +	if (wdt->wdtdev.max_hw_heartbeat_ms > 1000)
> +		wdt->wdtdev.max_hw_heartbeat_ms = 1000;
> +
> +	wdt->wdtdev.timeout = DEFAULT_TIMEOUT;
> +	ret = watchdog_init_timeout(&wdt->wdtdev, 0, dev);
> +	if (ret)
> +		return ret;
> +
> +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> +
> +	return devm_watchdog_register_device(dev, &wdt->wdtdev);
> +}
> +
> +
> +static const struct of_device_id rzn1_wdt_match[] = {
> +	{ .compatible = "renesas,rzn1-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
> +
> +static struct platform_driver rzn1_wdt_driver = {
> +	.probe		= rzn1_wdt_probe,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= rzn1_wdt_match,
> +	},
> +};
> +
> +module_platform_driver(rzn1_wdt_driver);
> +
> +MODULE_DESCRIPTION("Renesas RZ/N1 hardware watchdog");
> +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> +MODULE_LICENSE("GPL");
