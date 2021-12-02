Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A646659D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358737AbhLBOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhLBOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:47:08 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9BC06175A;
        Thu,  2 Dec 2021 06:43:45 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso40197223otj.11;
        Thu, 02 Dec 2021 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jz5z/VBzAfCkCcuAKYKAqK4uGjBmi+OIGK5V2IPdh+M=;
        b=jlZZYetgMXl9/US+kowTQ9ElJniv800/jUGko7NJvmjVd8G8EEVTlmecCQWPL2nOOP
         dOEZbqhc7sUsCBHAcYijonEfiIHjH3sdOEeOErP20MyqlWKl3qf1VgQe6Mqf6Hj8Hw0B
         4/zv5PPIXrnG42li4XtNklX5OEi+QBfUlxEf08iZ3wKFlG3pov3ngzJTBwv9F3/hWF7S
         QQvb4HOxoC6KBG0LfSOKw1nCjhvs1I4eNL2FZtpGRu4NdN2A/pQhU+FLofT+j9lRn+ye
         7MEgfv35D/0qRSR3wF3TvdUGkcpw5l+pM5hfEyIXraibdXIYYEGFBo/r+4vY0pGOG5Zl
         Wn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Jz5z/VBzAfCkCcuAKYKAqK4uGjBmi+OIGK5V2IPdh+M=;
        b=PQj6waaGygYI2Rmo1pwZGyNFwbvZWc4v7wd2lwQU8ZjDW+hDSTzRykOyFiuu/Laknz
         7Y19b3B5UW71bsf+92s1niO9WywOONYQv7ZccKMTKeK6eVTD6YV+vPn+Uh7AdpCyILYr
         +rdPUhMs9cpVz5nhSoZEMH+b0Bhxmayt9JJhLj/kPL3bjnXMPtb4+HtemOXZl9HPho2P
         li9dIttSv+3QT5EOvShQ10XDQx5P7iUT60QFxn9PNGVrJl8ROfOmI/RDZT/D8IYbUYbW
         9rxbJLc7cZG75WU8XZTS/vBXRBk8g5SdB4nzfflCfxMSLL1eam/h/JxTyqDY/SLqdX2E
         w4YA==
X-Gm-Message-State: AOAM531icSAdR303zBmQ+7Ch6FiezCZoRpsJm21AT2NwQ0tbKey4gAM3
        O0OIHMnQbjkhciMhClZ3swY=
X-Google-Smtp-Source: ABdhPJxiEJuKfAFe9gPhIqKjObKA2CqRVnxERZDVS1Eh0L6Hz2Jct9Qk/QucqI9XwQYiMZIwQIw74g==
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr11720849otq.173.1638456224945;
        Thu, 02 Dec 2021 06:43:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19sm28785oiw.22.2021.12.02.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:43:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Dec 2021 06:43:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 2/2] watchdog: Add Apple SoC watchdog driver
Message-ID: <20211202144343.GB829000@roeck-us.net>
References: <20211130161809.64591-1-sven@svenpeter.dev>
 <20211130161809.64591-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130161809.64591-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:18:09PM +0100, Sven Peter wrote:
> Add support for the watchdog timer found in Apple SoCs. This driver is
> also required to reboot these machines.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v1 -> v2:
>  - set the default timeout to 30s and call watchdog_init_timeout
>    to allow the device tree to override it
>  - set WDOG_HW_RUNNING if the watchdog is enabled at boot
>  - check that the clock rate is not zero
>  - use unsigned long instead of u32 for clk_rate
>  - use devm_add_action_or_reset instead of manually calling
>    clk_disable_unprepare
>  - explain the magic number in apple_wdt_restart
> 
>  MAINTAINERS                  |   1 +
>  drivers/watchdog/Kconfig     |  12 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/apple_wdt.c | 226 +++++++++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/watchdog/apple_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 859201bbd4e8..6190f0b40983 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1757,6 +1757,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	drivers/mailbox/apple-mailbox.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
> +F:	drivers/watchdog/apple_wdt.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  F:	include/dt-bindings/pinctrl/apple.h
>  F:	include/linux/apple-mailbox.h
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9d222ba17ec6..170dec880c8f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -976,6 +976,18 @@ config MSC313E_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called msc313e_wdt.
>  
> +config APPLE_WATCHDOG
> +	tristate "Apple SoC watchdog"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the Watchdog found in Apple
> +	  SoCs such as the M1. Next to the common watchdog features this
> +	  driver is also required in order to reboot these SoCs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apple_wdt.
> +
>  # X86 (i386 + ia64 + x86_64) Architecture
>  
>  config ACQUIRE_WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 2ee97064145b..270a518bd8f3 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>  obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
>  obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>  obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
> +obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
>  
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> new file mode 100644
> index 000000000000..76e5bedd50d1
> --- /dev/null
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SoC Watchdog driver
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * Apple Watchdog MMIO registers
> + *
> + * This HW block has three separate watchdogs. WD0 resets the machine
> + * to recovery mode and is not very useful for us. WD1 and WD2 trigger a normal
> + * machine reset. WD0 additionally supports a configurable interrupt.
> + * This information can be used to implement pretimeout support at a later time.
> + *
> + * APPLE_WDT_WDx_CUR_TIME is a simple counter incremented for each tick of the
> + * reference clock. It can also be overwritten to any value.
> + * Whenever APPLE_WDT_CTRL_RESET_EN is set in APPLE_WDT_WDx_CTRL and
> + * APPLE_WDTx_WD1_CUR_TIME >= APPLE_WDTx_WD1_BITE_TIME the entire machine is
> + * reset.
> + * Whenever APPLE_WDT_CTRL_IRQ_EN is set and APPLE_WDTx_WD1_CUR_TIME >=
> + * APPLE_WDTx_WD1_BARK_TIME an interrupt is triggered and
> + * APPLE_WDT_CTRL_IRQ_STATUS is set. The interrupt can be cleared by writing
> + * 1 to APPLE_WDT_CTRL_IRQ_STATUS.
> + */
> +#define APPLE_WDT_WD0_CUR_TIME		0x00
> +#define APPLE_WDT_WD0_BITE_TIME		0x04
> +#define APPLE_WDT_WD0_BARK_TIME		0x08
> +#define APPLE_WDT_WD0_CTRL		0x0c
> +
> +#define APPLE_WDT_WD1_CUR_TIME		0x10
> +#define APPLE_WDT_WD1_BITE_TIME		0x14
> +#define APPLE_WDT_WD1_CTRL		0x1c
> +
> +#define APPLE_WDT_WD2_CUR_TIME		0x20
> +#define APPLE_WDT_WD2_BITE_TIME		0x24
> +#define APPLE_WDT_WD2_CTRL		0x2c
> +
> +#define APPLE_WDT_CTRL_IRQ_EN		BIT(0)
> +#define APPLE_WDT_CTRL_IRQ_STATUS	BIT(1)
> +#define APPLE_WDT_CTRL_RESET_EN		BIT(2)
> +
> +#define APPLE_WDT_TIMEOUT_DEFAULT	30
> +
> +struct apple_wdt {
> +	struct watchdog_device wdd;
> +	void __iomem *regs;
> +	unsigned long clk_rate;
> +};
> +
> +static struct apple_wdt *to_apple_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct apple_wdt, wdd);
> +}
> +
> +static int apple_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +	writel_relaxed(APPLE_WDT_CTRL_RESET_EN, wdt->regs + APPLE_WDT_WD1_CTRL);
> +
> +	return 0;
> +}
> +
> +static int apple_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CTRL);
> +
> +	return 0;
> +}
> +
> +static int apple_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +
> +	return 0;
> +}
> +
> +static int apple_wdt_set_timeout(struct watchdog_device *wdd, unsigned int s)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +	writel_relaxed(wdt->clk_rate * s, wdt->regs + APPLE_WDT_WD1_BITE_TIME);
> +
> +	wdd->timeout = s;
> +
> +	return 0;
> +}
> +
> +static unsigned int apple_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +	u32 cur_time, reset_time;
> +
> +	cur_time = readl_relaxed(wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +	reset_time = readl_relaxed(wdt->regs + APPLE_WDT_WD1_BITE_TIME);
> +
> +	return (reset_time - cur_time) / wdt->clk_rate;
> +}
> +
> +static int apple_wdt_restart(struct watchdog_device *wdd, unsigned long mode,
> +			     void *cmd)
> +{
> +	struct apple_wdt *wdt = to_apple_wdt(wdd);
> +
> +	writel_relaxed(APPLE_WDT_CTRL_RESET_EN, wdt->regs + APPLE_WDT_WD1_CTRL);
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_BITE_TIME);
> +	writel_relaxed(0, wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +
> +	/*
> +	 * Flush writes and then wait for the SoC to reset. Even though the
> +	 * reset is queued almost immediately experiments have shown that it
> +	 * can take up to ~20-25ms until the SoC is actually reset. Just wait
> +	 * 50ms here to be safe.
> +	 */
> +	(void)readl_relaxed(wdt->regs + APPLE_WDT_WD1_CUR_TIME);
> +	mdelay(50);
> +
> +	return 0;
> +}
> +
> +static void apple_wdt_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static struct watchdog_ops apple_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = apple_wdt_start,
> +	.stop = apple_wdt_stop,
> +	.ping = apple_wdt_ping,
> +	.set_timeout = apple_wdt_set_timeout,
> +	.get_timeleft = apple_wdt_get_timeleft,
> +	.restart = apple_wdt_restart,
> +};
> +
> +static struct watchdog_info apple_wdt_info = {
> +	.identity = "Apple SoC Watchdog",
> +	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +};
> +
> +static int apple_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct apple_wdt *wdt;
> +	struct clk *clk;
> +	u32 wdt_ctrl;
> +	int ret;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(wdt->regs))
> +		return PTR_ERR(wdt->regs);
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, apple_wdt_clk_disable_unprepare,
> +				       clk);
> +	if (ret)
> +		return ret;
> +
> +	wdt->clk_rate = clk_get_rate(clk);
> +	if (!wdt->clk_rate)
> +		return -EINVAL;
> +
> +	wdt->wdd.ops = &apple_wdt_ops;
> +	wdt->wdd.info = &apple_wdt_info;
> +	wdt->wdd.max_timeout = U32_MAX / wdt->clk_rate;
> +	wdt->wdd.timeout = APPLE_WDT_TIMEOUT_DEFAULT;
> +
> +	wdt_ctrl = readl_relaxed(wdt->regs + APPLE_WDT_WD1_CTRL);
> +	if (wdt_ctrl & APPLE_WDT_CTRL_RESET_EN)
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +
> +	watchdog_init_timeout(&wdt->wdd, 0, dev);
> +	apple_wdt_set_timeout(&wdt->wdd, wdt->wdd.timeout);
> +	watchdog_stop_on_unregister(&wdt->wdd);
> +	watchdog_set_restart_priority(&wdt->wdd, 128);
> +
> +	return devm_watchdog_register_device(dev, &wdt->wdd);
> +}
> +
> +static const struct of_device_id apple_wdt_of_match[] = {
> +	{ .compatible = "apple,wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, apple_wdt_of_match);
> +
> +static struct platform_driver apple_wdt_driver = {
> +	.driver = {
> +		.name = "apple-watchdog",
> +		.of_match_table = apple_wdt_of_match,
> +	},
> +	.probe = apple_wdt_probe,
> +};
> +module_platform_driver(apple_wdt_driver);
> +
> +MODULE_DESCRIPTION("Apple SoC watchdog driver");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_LICENSE("Dual MIT/GPL");
> -- 
> 2.25.1
> 
