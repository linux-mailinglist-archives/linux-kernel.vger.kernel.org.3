Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E94F17AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358349AbiDDO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiDDO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:57:10 -0400
X-Greylist: delayed 1480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 07:55:14 PDT
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.150.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA37165B3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:55:14 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 013721490C7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:30:33 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bNh1ndszsHnotbNh1nOnzE; Mon, 04 Apr 2022 09:28:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I0ejtF0yR/US82f6Xt9NVKMVByQ4/2cDCdichhKuyNE=; b=men7yeV7H17hmZWVRbeQhnZDXR
        azWuPPZjYBX9M+R4MgazGkFvwT/siyOXJxyNKw92RZxLEWSWrsQgTAmIv4pOhgmWa8vmgSymngoOf
        LsMfqhULmwAlfZvIklbyKWMKZs0vy5qQlRajI7OLsSGDyusCOfpOCDI+gh5KIAxbSUF/pyFLSzSIC
        48Y6o10a6Gp/bTwAdN11EC0tLWf1A2+EpAjD0YucNBgvpxYCVg6T9SZTWYUiZhwo08skGMBlifyEK
        GsWzUyl851huky+358/7M0VHE8hJzCMQvggTaIZMxzn09cNarY6heBxvzDk5fOM7IDzJHSbx0CWi7
        POepmEwA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57854 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbNh1-001AMs-Fh; Mon, 04 Apr 2022 14:28:31 +0000
Date:   Mon, 4 Apr 2022 07:28:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
Message-ID: <20220404142830.GA3289074@roeck-us.net>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310195229.109477-3-nick.hawkins@hpe.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbNh1-001AMs-Fh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57854
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 19
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:52:22PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Adding support for the HPE GXP Watchdog. It is new to the linux
> community and this along with several other patches is the first
> support for it. The GXP asic contains a full compliment of
> timers one of which is the watchdog timer. The watchdog timer
> is 16 bit and has 10ms resolution.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  drivers/watchdog/Kconfig   |   8 ++
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/gxp-wdt.c | 191 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+)
>  create mode 100644 drivers/watchdog/gxp-wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c8fa79da23b3..cb210d2978d2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1820,6 +1820,14 @@ config RALINK_WDT
>  	help
>  	  Hardware driver for the Ralink SoC Watchdog Timer.
>  
> +config GXP_WATCHDOG
> +	tristate "HPE GXP watchdog support"
> +	depends on ARCH_HPE_GXP
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in HPE GXP SoCs.
> +
>  config MT7621_WDT
>  	tristate "Mediatek SoC watchdog"
>  	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f7da867e8782..e2acf3a0d0fc 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>  obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>  obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
> +obj-$(CONFIG_GXP_WATCHDOG) += gxp-wdt.o
>  obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>  obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>  obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
> diff --git a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c
> new file mode 100644
> index 000000000000..d2b489cb4774
> --- /dev/null
> +++ b/drivers/watchdog/gxp-wdt.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MASK_WDGCS_ENABLE	0x01
> +#define MASK_WDGCS_RELOAD	0x04
> +#define MASK_WDGCS_NMIEN	0x08
> +#define MASK_WDGCS_WARN		0x80
> +
> +#define WDT_MAX_TIMEOUT_MS	655000
> +#define WDT_DEFAULT_TIMEOUT	30
> +#define SECS_TO_WDOG_TICKS(x) ((x) * 100)
> +#define WDOG_TICKS_TO_SECS(x) ((x) / 100)
> +
> +struct gxp_wdt {
> +	void __iomem	*counter;
> +	void __iomem	*control;
> +	struct watchdog_device	wdd;

Odd variable alignment. Might as well just use spaces before the
variable names.

> +};
> +
> +static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata)
> +{
> +	uint8_t val;
> +
> +	val = readb(drvdata->control);
> +	val |= (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
> +	writeb(val, drvdata->control);
> +}
> +
> +static int gxp_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	writew((SECS_TO_WDOG_TICKS(wdd->timeout)), drvdata->counter);

Unnecessary iand confusing () around SECS_TO_WDOG_TICKS().

> +	gxp_wdt_enable_reload(drvdata);
> +	return 0;
> +}
> +
> +static int gxp_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	uint8_t val;
> +
> +	val = readb_relaxed(drvdata->control);
> +	val &= ~MASK_WDGCS_ENABLE;
> +	writeb(val, drvdata->control);
> +	return 0;
> +}
> +
> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
> +			       unsigned int timeout)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	uint32_t actual;

Please use u32 as suggested by checkpatch. Same everywhere.

> +
> +	wdd->timeout = timeout;
> +	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
> +	writew((SECS_TO_WDOG_TICKS(actual)), drvdata->counter);

Unnecessary ()

> +
> +	return 0;
> +}
> +
> +static unsigned int gxp_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	uint32_t val = readw(drvdata->counter);
> +
> +	return WDOG_TICKS_TO_SECS(val);
> +}
> +
> +static int gxp_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	gxp_wdt_enable_reload(drvdata);
> +	return 0;
> +}
> +
> +static int gxp_restart(struct watchdog_device *wdd, unsigned long action,
> +		       void *data)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	writew(10, drvdata->counter);
> +	gxp_wdt_enable_reload(drvdata);
> +	mdelay(100);
> +	return 0;
> +}
> +
> +static const struct watchdog_ops gxp_wdt_ops = {
> +	.owner =	THIS_MODULE,
> +	.start =	gxp_wdt_start,
> +	.stop =		gxp_wdt_stop,
> +	.ping = gxp_wdt_ping,
> +	.set_timeout	= gxp_wdt_set_timeout,
> +	.get_timeleft =	gxp_wdt_get_timeleft,
> +	.restart =	gxp_restart,

Please be consistent with alignments.

> +};
> +
> +static const struct watchdog_info gxp_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "HPE GXP Watchdog timer",
> +};
> +
> +static int gxp_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct gxp_wdt *drvdata;
> +	int err;
> +	uint8_t val;

Please use u8.

> +
> +	drvdata = devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drvdata->counter = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(drvdata->counter))
> +		return PTR_ERR(drvdata->counter);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	drvdata->control = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(drvdata->control))
> +		return PTR_ERR(drvdata->control);

Please use a single resource and offsets, or explain in a comment
why that does not work for this driver.

> +
> +	drvdata->wdd.info = &gxp_wdt_info;
> +	drvdata->wdd.ops = &gxp_wdt_ops;
> +	drvdata->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> +	drvdata->wdd.parent = &pdev->dev;
> +
> +	watchdog_set_drvdata(&drvdata->wdd, drvdata);
> +	watchdog_init_timeout(&drvdata->wdd, WDT_DEFAULT_TIMEOUT, dev);

That disables setting the watchdog timeout through devicetree, and is thus
mostly pointless. It is better to set the default timeout via variable
assignment above if you don't want to use devicetree to set the timeout,
or pass a timeout value of 0 to get the timeout from devicetree (if
configured).

> +	watchdog_set_nowayout(&drvdata->wdd, WATCHDOG_NOWAYOUT);
> +
> +	val = readb(drvdata->control);
> +	if (val & MASK_WDGCS_ENABLE)
> +		set_bit(WDOG_HW_RUNNING, &drvdata->wdd.status);
> +
> +	watchdog_set_restart_priority(&drvdata->wdd, 128);
> +
> +	watchdog_stop_on_reboot(&drvdata->wdd);
> +	err = devm_watchdog_register_device(dev, &drvdata->wdd);
> +	if (err) {
> +		dev_err(dev, "Failed to register watchdog device");
> +		return err;
> +	}
> +
> +	dev_info(dev, "HPE GXP watchdog timer");
> +	return 0;
> +}
> +
> +static int gxp_wdt_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Pointless remove function.

> +
> +static const struct of_device_id gxp_wdt_of_match[] = {
> +	{ .compatible = "hpe,gxp-wdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_wdt_of_match);
> +
> +static struct platform_driver gxp_wdt_driver = {
> +	.probe		= gxp_wdt_probe,
> +	.remove		= gxp_wdt_remove,
> +	.driver = {
> +		.name =		"gxp-wdt",
> +		.of_match_table = gxp_wdt_of_match,
> +	},
> +};
> +module_platform_driver(gxp_wdt_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");
> +MODULE_DESCRIPTION("Driver for GXP watchdog timer");
