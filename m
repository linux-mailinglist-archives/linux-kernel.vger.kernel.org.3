Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8F58C9D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbiHHNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHHNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:55:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A105B97
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:55:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso4529817wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=2KAEru83X/eg6nC6QUrdH5UrQzZjobP7SQajY4nyZcE=;
        b=v6FlkCKmtFTv4HwcXleuRXjO+gyXDNFK9NPGGRfgjJlITlg/4A7aZ9gKIFbdl2Gw7f
         2WRzp3Y903aCQKFzQoQc5gl2rNfxbMhmUwIHu99tewrlce8L5ia52DUep8UysSnBUyyj
         OxPN5Q5oBr4BRGBuFOLIcbdDfxxoyIHgKwYaf0jW5dYia7vqa0y/xez8KmdQ+tUyixBs
         5QNbetd1kFEEAs9ScTTyoNGkcnRmJxi3/xo99z+X1z3yRiOIqrtIoyJT3/2L5d614HLZ
         EzljXz5OOkBKk6h8jIUN3TlqXbXY/P2+RDDmanRZPvPt2w3GLyMdGDqLH2dkbIcaKHq/
         3SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=2KAEru83X/eg6nC6QUrdH5UrQzZjobP7SQajY4nyZcE=;
        b=zxBmRMQA826/lW5kkxG+LV230ipAK1EoX203dXnk3x5DtbMsmDZ6RiZ2V788fyFCMZ
         j+i+QcyKHg7FnMNf/VdMJjBa/6y3D+gK1zK6X3kGQVrpRtzVTGtx9mC5icaMnbpQTsSp
         fl/fIud2MAz7HKdEFW1yjFnBI25lu/tBBUmn7pr1/7Nuex3omNtmSTUNGbZKxzRBjgxQ
         H67MtI+mDKxmO+tmeLaXswi3xOYEs9s9TXip4cLNSXxshvTJtrKNaeimKeOzS6awhpBY
         CqU3gjAcpMmgqaVhjzPNwEu0jwV3CLPq4STHleikkJlOmbTaDFzB0sj4sNkGVQrtab2U
         xwTA==
X-Gm-Message-State: ACgBeo1XVKZ+MlQOtBb5Xdn/52GUAZvMWVUp7xGQRRFVaOTosMeJ6lUn
        XKB7Gn3pkGwIPJOsPloOxzq2N9cuvD/lqw==
X-Google-Smtp-Source: AA6agR6TMyVMTmkgwysLZynE7YDtYf9W78tzwvs6u7ICoPg1zR1chUYS30cluNaV/9MDiK0uveAOtw==
X-Received: by 2002:a05:600c:2282:b0:3a5:502a:892b with SMTP id 2-20020a05600c228200b003a5502a892bmr658421wmf.101.1659966922918;
        Mon, 08 Aug 2022 06:55:22 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003a2e1883a27sm22428103wms.18.2022.08.08.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:55:22 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:55:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <YvEVyBwKFrOT1oFR@google.com>
References: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
 <20220707134141.1172300-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707134141.1172300-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2022, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement a regulator driver with IRQ support for fault management.
> Written against documentation [1] and [2] and tested on real hardware.
> 
> Every channel has it's own regulator supply nammed 'vss1-supply' and

Nit "its" and "supplies"

> 'vss2-supply'. The regulator supply is used to determine the output
> voltage, as the smart switch provides no output regulation.
> The driver requires the 'shunt-resistor-micro-ohms' to be present in

"property to be ..."

> the devicetree to properly calculate current related values.

Drop "the" and it's  "Device Tree"

> You must specify compatible devictree layout:

This doesn't need to be in the commit message.

Save it for the documentation.

> regulator@3a {
>         reg = <0x3a>;
>         vss1-supply = <&p3v3>;
>         compatible = "maxim,max5978";
> 
>         ...
> 
>         regulators {
>                 sw0_ref: SW0 {
>                         regulator-compatible = "SW0";
>                         shunt-resistor-micro-ohms = <12000>;
>                         ...
>                 }
>         }
> }
> 
> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

What is the relationship between all of these people?

What did each of them provide to the patch?

> ---
>  drivers/mfd/Kconfig         |  12 ++++
>  drivers/mfd/Makefile        |   2 +
>  drivers/mfd/max597x.c       | 109 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max597x.h | 100 +++++++++++++++++++++++++++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 drivers/mfd/max597x.c
>  create mode 100644 include/linux/mfd/max597x.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..2422ae155118 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -253,6 +253,18 @@ config MFD_MADERA_SPI
>  	  Support for the Cirrus Logic Madera platform audio SoC
>  	  core functionality controlled via SPI.
>  
> +config MFD_MAX597X
> +	tristate "Maxim 597x power switch and monitor"

Power Switch and Monitor

> +	depends on I2C
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This driver controls a Maxim 5970/5978 switch via I2C bus.
> +	  The MAX5970/5978 is a smart switch with no output regulation, but
> +	  fault protection and voltage and current monitoring capabilities.
> +	  Also it supports upto 4 indication leds.

LEDs

> +
>  config MFD_CS47L15
>  	bool "Cirrus Logic CS47L15"
>  	select PINCTRL_CS47L15
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..f5f46b86401f 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -95,6 +95,8 @@ obj-$(CONFIG_MFD_MADERA)	+= madera.o
>  obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
>  obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
>  
> +obj-$(CONFIG_MFD_MAX597X) += max597x.o

Why don't you put it next to the existing MAX entries?

>  obj-$(CONFIG_TPS6105X)		+= tps6105x.o
>  obj-$(CONFIG_TPS65010)		+= tps65010.o
>  obj-$(CONFIG_TPS6507X)		+= tps6507x.o
> diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
> new file mode 100644
> index 000000000000..b2450e64d3eb
> --- /dev/null
> +++ b/drivers/mfd/max597x.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC

This is not a regulator driver.

Please state what the 2 devices are.

> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/version.h>
> +#include <linux/mfd/max597x.h>

Alphabetical.

Also, are you sure *all* of these are needed?

> +static const struct regmap_config max597x_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX_REGISTERS,
> +};
> +
> +static const struct mfd_cell max597x_devs[] = {

max597x_cells

> +	{
> +	 .name = "max597x-regulator",
> +	 },
> +	{
> +	 .name = "max597x-iio",
> +	 },
> +	{
> +	 .name = "max597x-led",
> +	 },

Like this please:

	{ .name = "max597x-regulator" },
	{ .name = "max597x-iio" },
	{ .name = "max597x-led" },

> +};
> +
> +static int max597x_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
> +{
> +	struct max597x_data *max597x;

"_ddata *ddata"

> +	struct regmap *regmap;
> +	enum max597x_chip_type chip = id->driver_data;
> +
> +	max597x =

No break.

> +	    devm_kzalloc(&i2c->dev, sizeof(struct max597x_data), GFP_KERNEL);

sizeof(*ddata)

'\n'

> +	switch (chip) {
> +	case MAX597x_TYPE_MAX5970:
> +		max597x->num_switches = 2;
> +		break;
> +	case MAX597x_TYPE_MAX5978:
> +		max597x->num_switches = 1;
> +		break;
> +	}

Are you planning on expanding the information in .data?

If not, why not put the number of switches in there instead?

> +	regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "No regmap\n");

Is that really what that means?

"Failed to initialise regmap"

> +		return -EINVAL;
> +	}

'\n'

> +	max597x->regmap = regmap;

Why not put the value straight into max597x->regmap instead of
creating a local variable that's only used once?

> +	max597x->irq = i2c->irq;
> +	max597x->dev = &i2c->dev;

What the reason for saving this?

> +	i2c_set_clientdata(i2c, max597x);
> +
> +	return devm_mfd_add_devices(max597x->dev, PLATFORM_DEVID_AUTO,
> +				    max597x_devs, ARRAY_SIZE(max597x_devs),
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct i2c_device_id max597x_table[] = {
> +	{.name = "max5970", MAX597x_TYPE_MAX5970},
> +	{.name = "max5978", MAX597x_TYPE_MAX5978},

Spaces after the { and before the } please.

> +	{},
> +};
> +

Remove this line.

> +MODULE_DEVICE_TABLE(i2c, max597x_table);
> +
> +static const struct of_device_id max597x_of_match[] = {
> +	{	.compatible = "maxim,max5970",

Needs to be on the line below.

> +		.data = (void *)MAX597x_TYPE_MAX5970
> +	},
> +	{	.compatible = "maxim,max5978",

Line below.

> +		.data = (void *)MAX597x_TYPE_MAX5978
> +	},
> +	{},
> +};
> +

Remove.

> +MODULE_DEVICE_TABLE(of, max597x_of_match);
> +
> +static struct i2c_driver max597x_driver = {
> +	.id_table = max597x_table,
> +	.driver = {
> +		   .name = "max597x",
> +		   .of_match_table = of_match_ptr(max597x_of_match),
> +		   },

Wrong tab spacing.  Should line up with the .driver.

> +	.probe = max597x_probe,
> +};
> +

Remove.

> +module_i2c_driver(max597x_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");

This is not a good description.

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
> new file mode 100644
> index 000000000000..ac7e9c84d06c
> --- /dev/null
> +++ b/include/linux/mfd/max597x.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Device driver for regulators in MAX5970 and MAX5978 IC

As above.

> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#ifndef _MAX597X_H
> +#define _MAX597X_H

MFD_

> +#include <linux/regmap.h>

device.h

> +#define MAX5970_NUM_SWITCHES 2
> +#define MAX5978_NUM_SWITCHES 1
> +#define MAX597X_NUM_LEDS     4
> +
> +struct max597x_data {

Place this at the bottom of the file.

> +	struct device *dev;
> +	int irq;
> +	int num_switches;
> +	struct regmap *regmap;

> +	u32 irng[MAX5970_NUM_SWITCHES];
> +	u32 mon_rng[MAX5970_NUM_SWITCHES];
> +	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];

Why are these here?

> +};
> +
> +enum max597x_chip_type {
> +	MAX597x_TYPE_MAX5978 = 1,
> +	MAX597x_TYPE_MAX5970,
> +};
> +
> +#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> +#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
> +#define MAX5970_REG_MON_RANGE			0x18
> +#define  MAX5970_MON_MASK			0x3
> +#define  MAX5970_MON(reg, ch) \
> +	(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
> +#define  MAX5970_MON_MAX_RANGE_UV		16000000
> +
> +#define MAX5970_REG_CH_UV_WARN_H(ch)		(0x1A + (ch) * 10)
> +#define MAX5970_REG_CH_UV_WARN_L(ch)		(0x1B + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_H(ch)		(0x1C + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_L(ch)		(0x1D + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_H(ch)		(0x1E + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_L(ch)		(0x1F + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_H(ch)		(0x20 + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_L(ch)		(0x21 + (ch) * 10)
> +
> +#define  MAX5970_VAL2REG_H(x)		(((x) >> 2) & 0xFF)
> +#define  MAX5970_VAL2REG_L(x)		((x) & 0x3)
> +
> +#define MAX5970_REG_DAC_FAST(ch)	(0x2E + (ch))
> +
> +#define MAX5970_FAST2SLOW_RATIO		200
> +
> +#define MAX5970_REG_STATUS0		0x31
> +#define  MAX5970_CB_IFAULTF(ch)		(1 << (ch))
> +#define  MAX5970_CB_IFAULTS(ch)		(1 << ((ch) + 4))

BIT()?

Same for the macros below.

> +#define MAX5970_REG_STATUS1		0x32
> +#define  STATUS1_PROT_MASK		0x3
> +#define  STATUS1_PROT(reg) \
> +	(((reg) >> 6) & STATUS1_PROT_MASK)
> +#define  STATUS1_PROT_SHUTDOWN		0
> +#define  STATUS1_PROT_CLEAR_PG		1
> +#define  STATUS1_PROT_ALERT_ONLY	2
> +
> +#define MAX5970_REG_STATUS2		0x33
> +#define  MAX5970_IRNG_MASK		0x3
> +#define  MAX5970_IRNG(reg, ch) \
> +	(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
> +
> +#define MAX5970_REG_STATUS3		0x34
> +#define  MAX5970_STATUS3_ALERT		BIT(4)
> +#define  MAX5970_STATUS3_PG(ch)		BIT(ch)
> +
> +#define MAX5970_REG_FAULT0		0x35
> +#define  UV_STATUS_WARN(ch)		(1 << (ch))
> +#define  UV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_FAULT1		0x36
> +#define  OV_STATUS_WARN(ch)		(1 << (ch))
> +#define  OV_STATUS_CRIT(ch)		(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_FAULT2		0x37
> +#define  OC_STATUS_WARN(ch)		(1 << (ch))
> +
> +#define MAX5970_REG_CHXEN		0x3b
> +#define  CHXEN(ch)			(3 << ((ch) * 2))
> +
> +#define MAX5970_REG_LED_FLASH		0x43
> +
> +#define MAX_REGISTERS			0x49
> +#define ADC_MASK			0x3FF
> +
> +#endif				/* _MAX597X_H */

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
