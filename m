Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F5522500
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiEJTsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiEJTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:48:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A726865A;
        Tue, 10 May 2022 12:48:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m25so263529oih.2;
        Tue, 10 May 2022 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4uWn3xX+yYUPRQ8nL1v8i617ZlQEmdrlzpv5nxaxZtA=;
        b=PKBorNGAs9x8A8x6njn99kh+CzW7XU0RA52HgdPIEiicHj9rKTgBtLz156QlCrggPc
         1CdH3dmrypGAi92aC+xE2HPDW8zCmKexWKk8gEsKTlp+1f0H42YfohDgXA5qs+1zKBRz
         wZaYM05Agi7V3bwA48CiFvsdD2FbP+4sDhzgPNEf5sDQuuPfc3Z9lO2ZyakLC/eXyGEP
         vpXK90b3YPqc21JjA0PpHgA4tkYr6Td+cu8VgqtCiYs43DFV6X22nCgGNOwQh6hKuIZy
         Wjdn8snn5OujDrcoh99PlKo7/7WMmvEonm509Ri+SHS55wjfe8xF6CcoNOjgAE1dmkss
         o/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4uWn3xX+yYUPRQ8nL1v8i617ZlQEmdrlzpv5nxaxZtA=;
        b=Ti2/J0amv1PPbCcZxzY7TTU1ZfSt5q1CQbQ+AyNLl1GSyVu3TbIjog+LWYaWbGY4FC
         sOWSEQ8xcRUXCJjAgoJUqT48EF4L+0p+tQs3Fn4xZWAECnKokshf48zFnt0spVICaucy
         5R2TpwOswROHBRXxXm0rHV2ZoA5avdlRwo8qZj0GzIYOuy7OBQ613GsMIdMbABYg/Pqs
         lO9RE1vm3to9M5W+HUQVB3at8ErXWsAgSTeEruVhGItr2boXuC7j7iMLCqvTObasfPGc
         8neUrhmI2SwSDAiA7KuXhuhRgfcMqlxOQJPyiQp8Z2Yv3P7LPpMzICGCNSTCZXV+VQte
         uxrw==
X-Gm-Message-State: AOAM531hdRviadvDR0X5qn6IXB8+7Tp5i0C5MVq+ArQUTReZ6cAJJtl4
        TU/L6hWAEM4fAqVAufFFsVE0LkbGZSaooA==
X-Google-Smtp-Source: ABdhPJyfolv39fUcvH1CvpimvK6qk6xG6EABwMeZ8k3A6rTLjLKepS0V/ef0oQA8t6WqDpcPqahuMw==
X-Received: by 2002:a05:6808:7c6:b0:325:d61a:1610 with SMTP id f6-20020a05680807c600b00325d61a1610mr858280oij.84.1652212121040;
        Tue, 10 May 2022 12:48:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020a056870c15200b000e9364288bfsm6052928oad.45.2022.05.10.12.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:48:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8b706f6d-5022-d3a8-3a0f-7b5fc6310308@roeck-us.net>
Date:   Tue, 10 May 2022 12:48:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
 <20220506191339.78617-3-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220506191339.78617-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 12:13, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the HPE GXP Watchdog. The GXP asic contains a full
> complement of timers one of which is the watchdog timer. The watchdog
> timer is 16 bit and has 10ms resolution. The watchdog is created as a
> child device of timer since the same register range is used.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v7:
> * Change commit description to replace Adding with Add and compliment
>    with complement
> * Removed unused include files of_address.h and of_platform.h
> * Fixed the max timeout on watchdog to be 655350
> * Changed time variable computations in gxp_wdt_set_timeout to be clear
> * Decreased reboot delay to 10ms from 100ms
> * Added comment to explain why it is necessary to pass the base address
>    over a private interface from the timer driver.
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
>   drivers/watchdog/gxp-wdt.c | 173 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 185 insertions(+)
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
> index 000000000000..2605249e35d1
> --- /dev/null
> +++ b/drivers/watchdog/gxp-wdt.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define MASK_WDGCS_ENABLE	0x01
> +#define MASK_WDGCS_RELOAD	0x04
> +#define MASK_WDGCS_NMIEN	0x08
> +#define MASK_WDGCS_WARN		0x80
> +
> +#define WDT_MAX_TIMEOUT_MS	655350
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
> +	actual = min(timeout * 100, wdd->max_hw_heartbeat_ms / 10);
> +	writew(actual, drvdata->base + GXP_WDT_CNT_OFS);
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
> +	writew(1, drvdata->base + GXP_WDT_CNT_OFS);
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
> +	/* The register area where the timer and watchdog reside is disarranged.
> +	 * Hence mapping individual register blocks for the timer and watchdog
> +	 * is not recommended as they would have access to each others
> +	 * registers. Based on feedback the watchdog is no longer part of the
> +	 * device tree file and the timer driver now creates the watchdog as a
> +	 * child device. During the watchdogs creation, the timer driver passes
> +	 * the base address to the watchdog over the private interface.
> +	 */

/*
  * Please use standard multi-line comments in the watchdog subsystem.
  */

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

