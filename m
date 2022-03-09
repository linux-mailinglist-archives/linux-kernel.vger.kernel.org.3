Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F54D3D69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiCIXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiCIXMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:12:36 -0500
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F75122218
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:11:35 -0800 (PST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 29AE0A3A20E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:11:35 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id S5Sxn2Khydx86S5Sxn7HLW; Wed, 09 Mar 2022 17:11:35 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i8kFLI+Tm1matLlL1pryUxp07vAmOodnzwuyFagel/M=; b=zhJH2MmiBH6AFaC8wv0loLP2Le
        IGEUzZ+FXOcbE8+bBSgz6UDSIb6YEWWhCdyP+s4WQgfJnafBMAWTYaONRnMsrQsyksM98rFpYPKph
        gZ9W9YJfMal8al9hSFLcIsp3VsKwJYBYlJSLdFDkR3nEGMQpNLRESfd4JCIG2pylFCuMbpNKvyjCZ
        L2CJd/RqKSi5ZvNgjBJbSRlZhoO6Pr9B7BKd+edjZewEjZoGrR53ZyYcWrpmge5ehacAleiVV5nXi
        F19RCor7X7d1w/9L7Z2LUfBUIbmjtzocfjvv+s+AIQfp/s33luqPxa8H2mX1Q93qOK10JiSgVPgjJ
        J/TQbesA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57410 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nS5Sw-000GnA-GH; Wed, 09 Mar 2022 23:11:34 +0000
Date:   Wed, 9 Mar 2022 15:11:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiantao Hu <xt.hu@cqplus1.com>
Cc:     wim@linux-watchdog.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, qinjian@cqplus1.com
Subject: Re: [PATCH v7 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Message-ID: <20220309231133.GA3802268@roeck-us.net>
References: <20220304081209.672-1-xt.hu@cqplus1.com>
 <20220304081209.672-3-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304081209.672-3-xt.hu@cqplus1.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nS5Sw-000GnA-GH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57410
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 68
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:12:09PM +0800, Xiantao Hu wrote:
> Sunplus SP7021 requires watchdog timer support.
> Add watchdog driver to enable this.
> 
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v7:
>  - Addressed all comments from Mr. Guenter Roeck.
>    Fix sp_wdt_ping() and add comment to explain the calculation.
> 
>  MAINTAINERS                    |   1 +
>  drivers/watchdog/Kconfig       |  11 ++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/sunplus_wdt.c | 220 +++++++++++++++++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 drivers/watchdog/sunplus_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe6cc971c..a1b3d76e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18247,6 +18247,7 @@ M:	Xiantao Hu <xt.hu@cqplus1.com>
>  L:	linux-watchdog@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> +F:	drivers/watchdog/sunplus_wdt.c
>  
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9d222ba17..d3dbe8695 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -976,6 +976,17 @@ config MSC313E_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called msc313e_wdt.
>  
> +config SUNPLUS_WATCHDOG
> +	tristate "Sunplus watchdog support"
> +	depends on ARCH_SUNPLUS || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in Sunplus SoCs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunplus_wdt.
> +
>  # X86 (i386 + ia64 + x86_64) Architecture
>  
>  config ACQUIRE_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 2ee970641..0fa548ee6 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
>  obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>  obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
> +obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
>  
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/sunplus_wdt.c b/drivers/watchdog/sunplus_wdt.c
> new file mode 100644
> index 000000000..e2d8c532b
> --- /dev/null
> +++ b/drivers/watchdog/sunplus_wdt.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sunplus Watchdog Driver
> + *
> + * Copyright (C) 2021 Sunplus Technology Co., Ltd.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/watchdog.h>
> +
> +#define WDT_CTRL		0x00
> +#define WDT_CNT			0x04
> +
> +#define WDT_STOP		0x3877
> +#define WDT_RESUME		0x4A4B
> +#define WDT_CLRIRQ		0x7482
> +#define WDT_UNLOCK		0xAB00
> +#define WDT_LOCK		0xAB01
> +#define WDT_CONMAX		0xDEAF
> +
> +/* TIMEOUT_MAX = ffff0/90kHz =11.65, so longer than 11 seconds will time out. */
> +#define SP_WDT_MAX_TIMEOUT	11U
> +#define SP_WDT_DEFAULT_TIMEOUT	10
> +
> +#define STC_CLK			90000
> +
> +#define DEVICE_NAME		"sunplus-wdt"
> +
> +static unsigned int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct sp_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct reset_control *rstc;
> +};
> +
> +static int sp_wdt_restart(struct watchdog_device *wdev,
> +			  unsigned long action, void *data)
> +{
> +	struct sp_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	void __iomem *base = priv->base;
> +
> +	writel(WDT_STOP, base + WDT_CTRL);
> +	writel(WDT_UNLOCK, base + WDT_CTRL);
> +	writel(0x0001, base + WDT_CNT);
> +	writel(WDT_LOCK, base + WDT_CTRL);
> +	writel(WDT_RESUME, base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sp_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct sp_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	void __iomem *base = priv->base;
> +	u32 count;
> +
> +	if (wdev->timeout > SP_WDT_MAX_TIMEOUT) {
> +		/* WDT_CONMAX sets the count to the maximum (down-counting). */
> +		writel(WDT_CONMAX, base + WDT_CTRL);
> +	} else {
> +		writel(WDT_UNLOCK, base + WDT_CTRL);
> +		/*
> +		 * Watchdog timer is a 20-bit down-counting based on STC_CLK.
> +		 * This register bits[16:0] is from bit[19:4] of the watchdog
> +		 * timer counter.
> +		 */
> +		count = (wdev->timeout * STC_CLK) >> 4;
> +		writel(count, base + WDT_CNT);
> +		writel(WDT_LOCK, base + WDT_CTRL);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sp_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct sp_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	void __iomem *base = priv->base;
> +
> +	writel(WDT_STOP, base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sp_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct sp_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	void __iomem *base = priv->base;
> +
> +	writel(WDT_RESUME, base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
> +static unsigned int sp_wdt_get_timeleft(struct watchdog_device *wdev)
> +{
> +	struct sp_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	void __iomem *base = priv->base;
> +	u32 val;
> +
> +	val = readl(base + WDT_CNT);
> +	val &= 0xffff;
> +	val = val << 4;
> +
> +	return val;
> +}
> +
> +static const struct watchdog_info sp_wdt_info = {
> +	.identity	= DEVICE_NAME,
> +	.options	= WDIOF_SETTIMEOUT |
> +			  WDIOF_MAGICCLOSE |
> +			  WDIOF_KEEPALIVEPING,
> +};
> +
> +static const struct watchdog_ops sp_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= sp_wdt_start,
> +	.stop		= sp_wdt_stop,
> +	.ping		= sp_wdt_ping,
> +	.get_timeleft	= sp_wdt_get_timeleft,
> +	.restart	= sp_wdt_restart,
> +};
> +
> +static void sp_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static void sp_reset_control_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int sp_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sp_wdt_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable clock\n");
> +
> +	ret = devm_add_action_or_reset(dev, sp_clk_disable_unprepare, priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	/* The timer and watchdog shared the STC reset */
> +	priv->rstc = devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(priv->rstc))
> +		return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset\n");
> +
> +	reset_control_deassert(priv->rstc);
> +
> +	ret = devm_add_action_or_reset(dev, sp_reset_control_assert, priv->rstc);
> +	if (ret)
> +		return ret;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->wdev.info = &sp_wdt_info;
> +	priv->wdev.ops = &sp_wdt_ops;
> +	priv->wdev.timeout = SP_WDT_DEFAULT_TIMEOUT;
> +	priv->wdev.max_hw_heartbeat_ms = SP_WDT_MAX_TIMEOUT * 1000;
> +	priv->wdev.min_timeout = 1;
> +	priv->wdev.parent = dev;
> +
> +	watchdog_set_drvdata(&priv->wdev, priv);
> +	watchdog_init_timeout(&priv->wdev, timeout, dev);
> +	watchdog_set_nowayout(&priv->wdev, nowayout);
> +	watchdog_stop_on_reboot(&priv->wdev);
> +	watchdog_set_restart_priority(&priv->wdev, 128);
> +
> +	return devm_watchdog_register_device(dev, &priv->wdev);
> +}
> +
> +static const struct of_device_id sp_wdt_of_match[] = {
> +	{.compatible = "sunplus,sp7021-wdt", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sp_wdt_of_match);
> +
> +static struct platform_driver sp_wdt_driver = {
> +	.probe = sp_wdt_probe,
> +	.driver = {
> +		   .name = DEVICE_NAME,
> +		   .of_match_table = sp_wdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(sp_wdt_driver);
> +
> +MODULE_AUTHOR("Xiantao Hu <xt.hu@cqplus1.com>");
> +MODULE_DESCRIPTION("Sunplus Watchdog Timer Driver");
> +MODULE_LICENSE("GPL");
