Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515F8513DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352336AbiD1Vd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351487AbiD1Vd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:33:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4215C37D;
        Thu, 28 Apr 2022 14:30:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r1so6524755oie.4;
        Thu, 28 Apr 2022 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=q56TpZHTCRTvd29/cbcHhm16MVPwIqkhhrvvXNE0XMI=;
        b=YcEcwWXLdIFdAEnDxTpURXAJ+YwKU/XMp0fYVKnAAN9ywJDK/2pLv4DwBNkqkj+9QX
         crQQaFwE0M3UY+II1Dzve9tRUKp79N+1tj6Sg64t5U+n+jR23VSocqIR+x3s8+lu7Pns
         xLTltKVgIxJq8TwwZLz6q8gvMGJ8WSO1ywyKIA4Hb3iWYyXJy7PtTuAa0Kb+vjOTOEWW
         IOPQXQThL//ps0twOkdpHDRrNtduIBY+locYpPid66j+WCUmjhTsP8gMx9FGVOWrxmjS
         evI3VOtiWXjYb1FaWoBB873YQmlbIPyBtPHFRLH2Y4//53rdpQB8RrQkwpRVwbzGS2Bf
         JJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=q56TpZHTCRTvd29/cbcHhm16MVPwIqkhhrvvXNE0XMI=;
        b=kIhfu6vpFFkaxgnGxQpFfKoZg8r1xhNKItoEztXfKHxZWcdNnXCQwU4OWUBQ/OoFuo
         3cD4D9gwU8tZcgnQl0w9RGNI08eMQ0DCH1V53IhjDCIuIkxgUVw1UD0uSVXaG/qUz9MX
         f3pUit+pB8eaOgRYa5VihwjdSKLLMP7fBm6vUylIBghlFmzvr+rY5lk26ifNKAQqx/Cm
         key52H9HHZhgEngIyECsrbG7q92p0b9zv1WC5Z86Kw/08UPvPDSC9/h3Ivu+rBYiJVhX
         iS8VzE6XKkJQ8CX5O/Jrb4VIm4p3LBdAyfdJ5+O2vyKEEBo5458fyumHuV0SD+aZBvCj
         jlzg==
X-Gm-Message-State: AOAM531gci9GLbEip/94HgA1h/FfKViDlniXlfYdHMnmF9O+kK0KSQKk
        ++D4k4sYv1iHiO+OWkWglkdeHTYug78=
X-Google-Smtp-Source: ABdhPJyoNpkZdVKGNSSbaFPcYcrVbtaurT4qD9qf5zKTlOzZEFkF53u/P3tgYVAjJHHgHB3S0DpQhQ==
X-Received: by 2002:a05:6808:d4f:b0:325:7e09:e540 with SMTP id w15-20020a0568080d4f00b003257e09e540mr92678oik.113.1651181409118;
        Thu, 28 Apr 2022 14:30:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dy40-20020a056870c7a800b000e686d1386asm2281404oab.4.2022.04.28.14.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 14:30:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
Date:   Thu, 28 Apr 2022 14:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <20220428210906.29527-1-rz@fabmicro.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 14:09, Ruslan Zalata wrote:
> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
> low rate (6 bit) ADC that is often used for extra keys. There's a driver
> for that already implementing standard input device, but it has these
> limitations: 1) it cannot be used for general ADC data equisition, and

acquisition

> 2) it uses only one LRADC channel of two available.
> 
> This driver provides basic hwmon interface to both channels of LRADC on
> such Allwinner SoCs.
> 
> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>

Ok, next phase of review.


> ---
>   MAINTAINERS                       |   6 +
>   drivers/hwmon/Kconfig             |  13 ++
>   drivers/hwmon/Makefile            |   1 +
>   drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++

Needs documentation in Documentation/hwmon/sun4i-lradc-hwmon.rst,
and don't forget to add it to Documentation/hwmon/index.rst.

>   4 files changed, 300 insertions(+)
>   create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e8c2f61176..d9c71e94133 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18861,6 +18861,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>   F:	drivers/input/keyboard/sun4i-lradc-keys.c
>   
> +SUN4I LOW RES ADC HWMON DRIVER
> +M:	Ruslan Zalata <rz@fabmicro.ru>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
> +
>   SUNDANCE NETWORK DRIVER
>   M:	Denis Kirjanov <kda@linux-powerpc.org>
>   L:	netdev@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b..86776488a81 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sis5595.
>   
> +config SENSORS_SUN4I_LRADC
> +	tristate "Allwinner A13/A20 LRADC hwmon"
> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
> +	help
> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
> +	  Both channels are supported.
> +
> +	  This driver can also be built as module. If so, the module
> +	  will be called sun4i-lradc-hwmon.
> +
> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one

only one of these

> +	  of these must be used at a time.
> +
>   config SENSORS_SY7636A
>   	tristate "Silergy SY7636A"
>   	help
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8a03289e2aa..3e5dc902acf 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -187,6 +187,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SUN4I_LRADC) += sun4i-lradc-hwmon.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/sun4i-lradc-hwmon.c b/drivers/hwmon/sun4i-lradc-hwmon.c
> new file mode 100644
> index 00000000000..8d5268b037b
> --- /dev/null
> +++ b/drivers/hwmon/sun4i-lradc-hwmon.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Allwinner sun4i (A13/A20) LRADC hwmon driver
> + *
> + * Copyright (C) 2022 Fabmicro, LLC., Tyumen, Russia.
> + * Copyright (C) 2022 Ruslan Zalata <rz@fabmicro.ru>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Should not be needed.

> +
> +#define LRADC_CTRL	0x00
> +#define LRADC_INTC	0x04
> +#define LRADC_INTS	0x08
> +#define LRADC_DATA0	0x0c
> +#define LRADC_DATA1	0x10
> +
> +/* LRADC_CTRL bits */
> +#define FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
> +#define CHAN_SELECT(x)		((x) << 22) /* 2 bits */
> +#define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
> +#define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
> +#define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
> +#define HOLD_KEY_EN(x)		((x) << 7)
> +#define HOLD_EN(x)		((x) << 6)
> +#define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
> +#define SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
> +#define ENABLE(x)		((x) << 0)
> +
> +/* LRADC_INTC and LRADC_INTS bits */
> +#define CHAN1_KEYUP_IRQ		BIT(12)
> +#define CHAN1_ALRDY_HOLD_IRQ	BIT(11)
> +#define CHAN1_HOLD_IRQ		BIT(10)
> +#define CHAN1_KEYDOWN_IRQ	BIT(9)
> +#define CHAN1_DATA_IRQ		BIT(8)
> +#define CHAN0_KEYUP_IRQ		BIT(4)
> +#define CHAN0_ALRDY_HOLD_IRQ	BIT(3)
> +#define CHAN0_HOLD_IRQ		BIT(2)
> +#define CHAN0_KEYDOWN_IRQ	BIT(1)
> +#define CHAN0_DATA_IRQ		BIT(0)
> +
> +struct lradc_variant {
> +	u32 bits;
> +	u32 resolution;
> +	u32 vref;
> +};
> +
> +struct sun4i_lradc_data {
> +	struct device *dev;
> +	void __iomem *base;
> +	const struct lradc_variant *variant;
> +	struct mutex update_lock; /* atomic read and data updates */
> +	u32 in[2];
> +};
> +
> +struct lradc_variant variant_sun4i_a10_lradc = {
> +	.bits = 0x3f,
> +	.resolution = 63,
> +	.vref = 2000000, /* Vref = 2.0V from SoC datasheet */
> +};
> +
> +static int sun4i_lradc_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> +	int in;
> +
> +	if (IS_ERR(lradc))
> +		return PTR_ERR(lradc);

That won't happen. Unnecessary check.

> +
> +	mutex_lock(&lradc->update_lock);
> +	in = lradc->in[channel];


Pointless. Just use

> +	mutex_unlock(&lradc->update_lock);
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		*val = in;

		*val = lradc->in[channel];

here. The operation is atomic.

> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +umode_t sun4i_lradc_is_visible(const void *data, enum hwmon_sensor_types type,
> +			       u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static const u32 sun4i_lradc_chip_config[] = {
> +	HWMON_I_INPUT,

This is wrong. Chip wide attributes are named HWMON_C_XXX.
This generated a reset_history attribute which isn't really
supported or handled. Chip attributes should only be specified
if actually used. Drop this.

> +	0
> +};
> +
> +static const struct hwmon_channel_info sun4i_lradc_chip = {
> +	.type = hwmon_chip,
> +	.config = sun4i_lradc_chip_config,
> +};
> +
> +static const u32 sun4i_lradc_input_config[] = {
> +	HWMON_I_INPUT,
> +	HWMON_I_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info sun4i_lradc_input = {
> +	.type = hwmon_in,
> +	.config = sun4i_lradc_input_config,
> +};
> + > +static const struct hwmon_channel_info *sun4i_lradc_info[] = {
> +	&sun4i_lradc_chip,
> +	&sun4i_lradc_input,
> +	NULL
> +};
> +
Use the HWMON_CHANNEL_INFO macro instead.

> +static const struct hwmon_ops sun4i_lradc_hwmon_ops = {
> +	.is_visible = sun4i_lradc_is_visible,
> +	.read = sun4i_lradc_read,
> +};
> +
> +static const struct hwmon_chip_info sun4i_lradc_chip_info = {
> +	.ops = &sun4i_lradc_hwmon_ops,
> +	.info = sun4i_lradc_info,
> +};
> +
> +static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
> +{
> +	struct sun4i_lradc_data *lradc = dev_id;
> +	u32 ints = readl(lradc->base + LRADC_INTS);
> +
> +	mutex_lock(&lradc->update_lock);
> +
> +	if (ints & CHAN0_DATA_IRQ)
> +		lradc->in[0] = (readl(lradc->base + LRADC_DATA0) & lradc->variant->bits) *
> +			lradc->variant->vref / lradc->variant->resolution / 1000; /* to mV */
> +
> +	if (ints & CHAN1_DATA_IRQ)
> +		lradc->in[1] = (readl(lradc->base + LRADC_DATA1) & lradc->variant->bits) *
> +			lradc->variant->vref / lradc->variant->resolution / 1000; /* to mV */
> +
> +	mutex_unlock(&lradc->update_lock);
> +
> +	writel(ints, lradc->base + LRADC_INTS);
> +
> +	return IRQ_HANDLED;
> +}
> +

You don't explain why the interrupt handler is needed. It is undesirable
to do this for hwnon devices because it results in extra load on the system.
The ADC should be read only when needed and not continuously. If that is not
possible for some reason it needs to be explained in detail.

> +static int sun4i_lradc_start(struct sun4i_lradc_data *lradc)
> +{
> +	writel(FIRST_CONVERT_DLY(2) | CHAN_SELECT(3) | LEVELA_B_CNT(1) |
> +		HOLD_EN(1) | KEY_MODE_SEL(2) | SAMPLE_RATE(3) | ENABLE(1),
> +		lradc->base + LRADC_CTRL);
> +

If the update rate is configurable, it might make sense to support
the update_interval attribute.

> +	writel(CHAN0_DATA_IRQ | CHAN1_DATA_IRQ, lradc->base + LRADC_INTC);
> +
> +	return 0;
> +}
> +
> +static void sun4i_lradc_stop(void *data)
> +{
> +	struct sun4i_lradc_data *lradc = (struct sun4i_lradc_data *)data;
> +
> +	writel(FIRST_CONVERT_DLY(2) | LEVELA_B_CNT(1) | HOLD_EN(1) |
> +		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
> +	writel(0, lradc->base + LRADC_INTC);
> +}
> +
> +static int sun4i_lradc_probe(struct platform_device *pdev)
> +{
> +	struct sun4i_lradc_data *lradc;
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +	struct resource *res;
> +	int hwmon_irq, error;
> +
> +	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
> +	if (!lradc)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, lradc);
> +
> +	lradc->variant = of_device_get_match_data(&pdev->dev);
> +	if (!lradc->variant)
> +		return -EINVAL;
> +
> +	lradc->dev = dev;
> +

I don't immediately see where this is used.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);
> +
> +	lradc->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lradc->base))
> +		return PTR_ERR(lradc->base);
> +
> +	hwmon_irq = platform_get_irq(pdev, 0);
> +	if (hwmon_irq < 0)
> +		return hwmon_irq;
> +
> +	error = devm_request_irq(dev, hwmon_irq, sun4i_lradc_irq, 0, "sun4i-lradc-hwmon", lradc);
> +	if (error) {
> +		dev_err(dev, "sun4i-lradc-hwmon IRQ failed err=%d\n", error);
> +		return error;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "lradc-hwmon", lradc,
> +							 &sun4i_lradc_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		error = PTR_ERR(hwmon_dev);
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(dev, sun4i_lradc_stop, lradc);
> +	if (error)
> +		return error;
> +
> +	error = sun4i_lradc_start(lradc);
> +
> +	return error;
> +}
> +
> +#ifdef CONFIG_PM
> +static int sun4i_lradc_resume(struct device *dev)
> +{
> +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> +
> +	return sun4i_lradc_start(lradc);
> +}
> +
> +static int sun4i_lradc_suspend(struct device *dev)
> +{
> +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> +
> +	sun4i_lradc_stop(lradc);
> +	return 0;
> +}
> +
> +#define SUN4I_LRADC_DEV_PM_OPS	(&sun4i_lradc_dev_pm_ops)
> +#else
> +#define SUN4I_LRADC_DEV_PM_OPS	NULL
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops sun4i_lradc_dev_pm_ops = {
> +	.suspend = sun4i_lradc_suspend,
> +	.resume = sun4i_lradc_resume,
> +};
> +
> +static const struct of_device_id sun4i_lradc_of_match[] = {
> +	{ .compatible = "allwinner,sun4i-a10-lradc-keys", .data = &variant_sun4i_a10_lradc},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
> +
> +static struct platform_driver sun4i_lradc_driver = {
> +	.driver = {
> +		.name	= "sun4i-lradc-hwmon",
> +		.of_match_table = of_match_ptr(sun4i_lradc_of_match),
> +		.pm = SUN4I_LRADC_DEV_PM_OPS,
> +	},
> +	.probe	= sun4i_lradc_probe,
> +};
> +
> +module_platform_driver(sun4i_lradc_driver);
> +
> +MODULE_DESCRIPTION("Allwinner A13/A20 LRADC hwmon driver");
> +MODULE_AUTHOR("Ruslan Zalata <rz@fabmicro.ru>");
> +MODULE_LICENSE("GPL");
> +No empty line at end, please

