Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412C6508C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380355AbiDTPz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiDTPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:55:26 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27642EC6;
        Wed, 20 Apr 2022 08:52:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e656032735so1108146fac.0;
        Wed, 20 Apr 2022 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=S0Y+0UT+7f6lERv3TdG5Ai4gbifQsP7CueENIDn6iDI=;
        b=HHDcTfqtKJJlOYnA3RbW39Sf73Tg4OWL6Gx9TkWyDBUvQDCIy9jQwrjbkRNYkiJ960
         2RpG8pJ2ljU+wA1dbWb0bxqNkUVCzCOaHp7BYugalpEajtNdVGIw/i/DJ5QMXzlPAUCi
         dFnplebdE3J4SkMu9+SeuGhJvvcsz4nB/t4RikzvutGM8wjO8y2F+avjL+P2fCQddmr/
         mKkZeM/X/pUxXy94Iq4Ti75aYhwKqg6PX/Q+b0nhmuGTCpgGeo4YfHSwvGTr2hiGN6j/
         TqbFRHkWpTAoPUMBv9eyceyih77w7w3K8s4wAPpmS2lkImcDPBmz6WBkAr7Wzm+30y9W
         Tv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=S0Y+0UT+7f6lERv3TdG5Ai4gbifQsP7CueENIDn6iDI=;
        b=X8WZYM2mPY5iEtnGrkmaOf4ipb3+jFtg+NT9P6J16+961fgWjpwz+nA6STp+Q8vBTw
         AA4KUZpse/LBnk6eJ9jS+EST6YQ/ElcvQGOl+hb2wf71S/vr5jqKDCSj8H02SYeWlmT4
         U0EguD6v8GQ++ih8fjeWNEDg9wP7p39Z747Hn52AJIjcYT4KHKwCNlzlmoD8PKYz9T2e
         /1dQrtQBSuONM3bM+ZebD01mh27/ZmFJDMm6C0y2ThzzHyNQeN2/r/ntdYM64K6ZOVei
         u7O2/4qjKNWThbvJnl3J4uRXGVeXOaaCRvQlQ2F3yErx2xa+4/6FNg1Kepx0A2DSM9US
         EdRQ==
X-Gm-Message-State: AOAM531saY/RRx6RTXcRoTIipWAdptx+m++btHTGWIuLMYwUR/as5kb0
        oNgFe2kzu1Hw+QcYb8RoSD0=
X-Google-Smtp-Source: ABdhPJwz/Up2CY8UTFI4JWLbKvaAjU97j9CdzJksLTSDtq3YrVYm/ZBpR2T5FUzLnC7/CHjXXyKkXw==
X-Received: by 2002:a05:6870:2184:b0:e5:ee28:d858 with SMTP id l4-20020a056870218400b000e5ee28d858mr1879597oae.211.1650469959467;
        Wed, 20 Apr 2022 08:52:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8-20020a056830264800b006056d7c27absm346901otu.77.2022.04.20.08.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 08:52:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <565f92d7-78d1-7623-4c13-70d49eed5821@roeck-us.net>
Date:   Wed, 20 Apr 2022 08:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-3-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 03/11] drivers: wdt: Introduce HPE GXP SoC Watchdog
In-Reply-To: <20220420150156.47405-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 08:01, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Adding support for the HPE GXP Watchdog. It is new to the linux
> community and this along with several other patches is the first
> support for it. The GXP asic contains a full compliment of
> timers one of which is the watchdog timer. The watchdog timer
> is 16 bit and has 10ms resolution. The watchdog is now

Drop "now".

> created as a child device of timer since the same register
> range is used. This was done due to changes requested with
> the device tree.
> 

Drop last sentence; it is part of the change log and should stay there.

> ---

Changes made in v3 and v4 are missing.

> v2:
> *Made watchdog a child of timer as they share the same register
> region per change request on dtsi.
> *Removed extra parenthesis
> *Fixed u8 u32 u64 usage
> *Fixed alignment issue
> *Removed unused gxp_wdt_remove function
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>   drivers/watchdog/Kconfig   |   8 ++
>   drivers/watchdog/Makefile  |   1 +
>   drivers/watchdog/gxp-wdt.c | 166 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 175 insertions(+)
>   create mode 100644 drivers/watchdog/gxp-wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c8fa79da23b3..cb210d2978d2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1820,6 +1820,14 @@ config RALINK_WDT
>   	help
>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>   
> +config GXP_WATCHDOG
> +	tristate "HPE GXP watchdog support"
> +	depends on ARCH_HPE_GXP
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  in HPE GXP SoCs.
> +

Add something like:

To compile this driver as a module, choose M here: the
module will be calledgxp_wdt.

>   config MT7621_WDT
>   	tristate "Mediatek SoC watchdog"
>   	select WATCHDOG_CORE
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f7da867e8782..e2acf3a0d0fc 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>   obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>   obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>   obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
> +obj-$(CONFIG_GXP_WATCHDOG) += gxp-wdt.o
>   obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>   obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>   obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
> diff --git a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c
> new file mode 100644
> index 000000000000..f45ab9a826d6
> --- /dev/null
> +++ b/drivers/watchdog/gxp-wdt.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
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
> +#define GXP_WDT_CNT_OFS		0x10
> +#define GXP_WDT_CTRL_OFS	0x16
> +
> +struct gxp_wdt {
> +	void __iomem *base;
> +	struct watchdog_device wdd;
> +};
> +
> +static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata)
> +{
> +	u8 val;
> +
> +	val = readb(drvdata->base + GXP_WDT_CTRL_OFS);
> +	val |= (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
> +	writeb(val, drvdata->base + GXP_WDT_CTRL_OFS);
> +}
> +
> +static int gxp_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +
> +	writew(SECS_TO_WDOG_TICKS(wdd->timeout), drvdata->base + GXP_WDT_CNT_OFS);
> +	gxp_wdt_enable_reload(drvdata);
> +	return 0;
> +}
> +
> +static int gxp_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u8 val;
> +
> +	val = readb_relaxed(drvdata->base + GXP_WDT_CTRL_OFS);
> +	val &= ~MASK_WDGCS_ENABLE;
> +	writeb(val, drvdata->base + GXP_WDT_CTRL_OFS);
> +	return 0;
> +}
> +
> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
> +			       unsigned int timeout)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u32 actual;
> +
> +	wdd->timeout = timeout;
> +	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
> +	writew(SECS_TO_WDOG_TICKS(actual), drvdata->base + GXP_WDT_CNT_OFS);
> +
> +	return 0;
> +}
> +
> +static unsigned int gxp_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
> +	u32 val = readw(drvdata->base + GXP_WDT_CNT_OFS);
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
> +	writew(10, drvdata->base + GXP_WDT_CNT_OFS);
> +	gxp_wdt_enable_reload(drvdata);
> +	mdelay(100);
> +	return 0;
> +}
> +
> +static const struct watchdog_ops gxp_wdt_ops = {
> +	.owner =	THIS_MODULE,
> +	.start =	gxp_wdt_start,
> +	.stop =		gxp_wdt_stop,
> +	.ping =		gxp_wdt_ping,
> +	.set_timeout =	gxp_wdt_set_timeout,
> +	.get_timeleft =	gxp_wdt_get_timeleft,
> +	.restart =	gxp_restart,
> +};
> +
> +static const struct watchdog_info gxp_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "HPE GXP Watchdog timer",
> +};
> +
> +static int gxp_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gxp_wdt *drvdata;
> +	int err;
> +	u8 val;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->base = (void __iomem *)dev->platform_data;
> +
> +	drvdata->wdd.info = &gxp_wdt_info;
> +	drvdata->wdd.ops = &gxp_wdt_ops;
> +	drvdata->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> +	drvdata->wdd.parent = dev;
> +	drvdata->wdd.timeout = WDT_DEFAULT_TIMEOUT;
> +
> +	watchdog_set_drvdata(&drvdata->wdd, drvdata);
> +	watchdog_set_nowayout(&drvdata->wdd, WATCHDOG_NOWAYOUT);
> +
> +	val = readb(drvdata->base + GXP_WDT_CTRL_OFS);
> +
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
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gxp_wdt_driver = {
> +	.probe = gxp_wdt_probe,
> +	.driver = {
> +		.name =	"gxp-wdt",
> +	},
> +};
> +module_platform_driver(gxp_wdt_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_AUTHOR("Jean-Marie Verdun <verdun@hpe.com>");
> +MODULE_DESCRIPTION("Driver for GXP watchdog timer");

