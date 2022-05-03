Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9517517BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiECCX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiECCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:23:26 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553324BFA;
        Mon,  2 May 2022 19:19:55 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso5458695fac.1;
        Mon, 02 May 2022 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=hZdel6P6LAHcpmSVNUVU9qVwHqpr1H9vBfMYaY43DBA=;
        b=h8sV0MrNed8TnU0I+1dBnKB2ZNLgbWman54USqNpKXBsPaYErM61OpH5hcnr6zz5al
         cHqJViPucYw3vk4xS0BprxYwOC29JAhwV1Rf9zNZJVNhyPQzBjpNMaoAtLlOagFq2yDd
         8HzA9i86f7pAs2njhjJFy6RV1YiKUPA3LgxvCXZqFWJqdechZKhvdDv6wKHjmfjrey7C
         BcT7JaLKWxBi5dnKpwulWvk6Qn3F++5cXPf8cg+95jDyPaOGxX2pwTrkLXuuKkcdRimR
         /+yZkOVxg/ftXE+S4rWfUzVNUarS8pghzq3obBHoCk6B5cY1c2GK8IHvRVOq+lQMVs90
         f6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=hZdel6P6LAHcpmSVNUVU9qVwHqpr1H9vBfMYaY43DBA=;
        b=wqTqhnUMthbSHHPI8Q3pvIwp3YUS/7Mb3poNR5YxRG2kjbnitndpxD8QygJa11/0va
         mc0St/5u8M+KVFRmOsNYBNtF9MZF8ySokzm5P3OiSD9t0ds/JlUWoyD8/n1EWwWxL+YM
         LaaYZr74JmqWB0rMOtLBKxuSgV1he0s3MCc0GgZy8PTNB3J3gC6s0UOh/xM5kBmb0bui
         itB+IuOaeWeQ0qDbtPon+0Mu4H53uZFR1fsu/f4KO2iJYIyvS4B3fSNuQMM4ho94nBAN
         kIv03bJUFDMaH++MC7gVR82xHn1Ld//87+fA7WHWZtaGqkjOt5Y2QEqmZCQctznHk0rr
         u//w==
X-Gm-Message-State: AOAM5321FhBPY6UUC6tfn3q9DDq5GpF9/Zbi/eIy2bFitejQmcjegYKr
        6jPAor/9ZCpCwYtsXcf5Wvc=
X-Google-Smtp-Source: ABdhPJyetv155oU7c71ckhExmz9lKkm/3ZNfPjojAXd1uC+b92B+bj8k/uTUCQpQHh3jw2uMJND8SA==
X-Received: by 2002:a05:6870:d78d:b0:d4:4b29:7ccc with SMTP id bd13-20020a056870d78d00b000d44b297cccmr952956oab.69.1651544394383;
        Mon, 02 May 2022 19:19:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a056870b25500b000eba4901e57sm4008430oam.17.2022.05.02.19.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 19:19:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
Date:   Mon, 2 May 2022 19:19:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-3-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
In-Reply-To: <20220502204050.88316-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 13:40, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Adding support for the HPE GXP Watchdog. The GXP asic contains a full

Add

> compliment of timers one of which is the watchdog timer. The watchdog

complement ?

> timer is 16 bit and has 10ms resolution. The watchdog is created as a
> child device of timer since the same register range is used.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v6:
> * No code change.
> * Fixed commit subject line to match the ones in log.
> * Adjusted commit message to be closer to 75 chars per line.
> v5:
> * Fixed version log
> * Added details to Kconfig for module support.
> * Adjusted commit messaged
> v4:
> * Made watchdog a child of timer as they share the same register region
>    per change request on dtsi.
> * Removed extra parenthesis
> * Fixed u8 u32 u64 usage
> * Fixed alignment issue
> * Reconfigured conditional statement for interrupt setup
> * Removed unused gxp_wdt_remove function
> v3:
> * Put into proper patchset format
> v2:
> * No change
> ---
>   drivers/watchdog/Kconfig   |  11 +++
>   drivers/watchdog/Makefile  |   1 +
>   drivers/watchdog/gxp-wdt.c | 166 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 178 insertions(+)
>   create mode 100644 drivers/watchdog/gxp-wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c4e82a8d863f..a591cc6aa152 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1820,6 +1820,17 @@ config RALINK_WDT
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
> +	  To compile this driver as a module, choose M here.
> +	  The module will be called gxp-wdt.
> +
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

Where are those of_ includes used ?

> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MASK_WDGCS_ENABLE	0x01
> +#define MASK_WDGCS_RELOAD	0x04
> +#define MASK_WDGCS_NMIEN	0x08
> +#define MASK_WDGCS_WARN		0x80
> +
> +#define WDT_MAX_TIMEOUT_MS	655000

Shouldn't that be 655350 ?

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

First, the accuracy of actual is reduced to 1 second, then SECS_TO_WDOG_TICKS()
multiplies the result with 100, meaning the actual accuracy is 10ms. Why not
just use 10 ms ?

	actual = min(timeout * 100, wdd->max_hw_heartbeat_ms / 10);
	writew(actual, drvdata->base + GXP_WDT_CNT_OFS);

I guess it doesn't matter much since max_hw_heartbeat_ms is really a constant
rounded down to seconds, it just looks odd.

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

Doesn't that translate to 100 ms timeout ? Why such a large reboot delay
instead of writing 1 ?

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

I'd personaly prefer if the address was passed as resource.

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

