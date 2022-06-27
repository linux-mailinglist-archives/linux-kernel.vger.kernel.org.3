Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECF55D1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiF0OXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiF0OXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:23:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640413F22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:22:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s1so13288946wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FeV1hNgcIlRD8vtoxkTZySTIebKF1oNgpi73Pm+Sqqw=;
        b=hnVY5/tYmCOiBd+Gqly3Rjz9bsbVA75CKg3xCAgOyaGdffrQzR0Q9lwJB8tDl/9s6y
         TdvCaH2YmBoxcd9PyJZgSi3pjdTwErqECq5Pgm5ivZPdaM50uI9YAAYbF/ZKeCTfQPoN
         VsjziyH0TMtYKJEKVy9dIqQ01VXqhfRcSluv/SGK8H61f6nWLQNAlSaGlFCAv1RZ/cu0
         W48fSZdiGvFkCK2ElrF9nnfD8VeoowhUUdrqVuLSduciVqzfwS3FCq1eZfGdaDw6G/LM
         gZAWmFkjgikMvoOw/SOnDBaGZbuofeFOODU4uJr7eJSm6ofTRvefIySBwjRn8xbKEFCD
         a90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FeV1hNgcIlRD8vtoxkTZySTIebKF1oNgpi73Pm+Sqqw=;
        b=sKPIKXq1oG9c1LG8e9uEmkjiqOp6NGZWz8aSGf8DBygebPJRlMRdbGLkD6wji2w/zh
         iz4EKROMCF6/F55dJsqTXrVlBlh+coSeH9vJTiSShkY6ceJZGoc3rTPlTw0fU+AuVfT7
         s336oFYIUKjd4RsI7SuLCa5FKbulpjFmphTKUACxcmTVsabKD83X8oylgeN9Vq95VhIL
         /Z7Qrpu/E+yomJaQ8aqkWP38GZt45oWwXCkoppkuAgXvWOSaPWhhl4NmMN63O4y6/Ad1
         1h5JA2WjClp+TT3LmfL55wwMjMvqewjuAevXUlcVW435ZHWSIM8HL2llWPyewvyjRmQK
         vkog==
X-Gm-Message-State: AJIora/P6WhP1OTq7PPgaK53bCHGSEbgNKt1pljvrq9ScuWFIHPWfmEq
        0Mq+M4ZmKM27mTOZL5F+Gav/hg==
X-Google-Smtp-Source: AGRyM1sjI6M8T0da+YH6qaHw6hmjwF4LQrCjEPKNsXZM7MhPVYOv+/xv1jHeE9vsMc6PWjZh2kKoKQ==
X-Received: by 2002:adf:d1c2:0:b0:21b:e465:1e36 with SMTP id b2-20020adfd1c2000000b0021be4651e36mr5818287wrd.271.1656339771707;
        Mon, 27 Jun 2022 07:22:51 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003a046549a85sm8120659wmb.37.2022.06.27.07.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:22:51 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:22:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, lgirdwood@gmail.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: rt5120: Add Richtek PMIC support
Message-ID: <Yrm9ObaltUiQUTqS@google.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655892104-10874-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RT5120 PMIC I2C driver.

Why a whole new driver?

How different is this to rt5033?

Looks like this could easily be woven into this existing support?

> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/mfd/Kconfig  |  12 +++++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/rt5120.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
>  create mode 100644 drivers/mfd/rt5120.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456..866619c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1127,6 +1127,18 @@ config MFD_RT5033
>  	  sub-devices like charger, fuel gauge, flash LED, current source,
>  	  LDO and Buck.
>  
> +config MFD_RT5120
> +	tristate "Richtek RT5120 Power Management IC"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  The enables support for Richtek RT5120 PMIC. It includes four high
> +	  efficiency buck converters and one LDO voltage regulator. The device
> +	  is targeted at providing the CPU voltage, memory, I/O and peripheral
> +	  power rails in home entertainment devices.
> +
>  config MFD_RC5T583
>  	bool "Ricoh RC5T583 Power Management system device"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf..27e8add 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -234,6 +234,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> +obj-$(CONFIG_MFD_RT5120)	+= rt5120.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
> new file mode 100644
> index 00000000..e7c5f3c
> --- /dev/null
> +++ b/drivers/mfd/rt5120.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +
> +#define RT5120_REG_INTENABLE	0x1D
> +#define RT5120_REG_INTSTAT	0x1E
> +#define RT5120_REG_FZCMODE	0x44
> +
> +#define RT5120_INT_HOTDIE	0
> +#define RT5120_INT_PWRKEY_REL	5
> +#define RT5120_INT_PWRKEY_PRESS	6
> +
> +static const struct regmap_range rt5120_rd_yes_ranges[] = {
> +	regmap_reg_range(0x03, 0x13),
> +	regmap_reg_range(0x1c, 0x20),
> +	regmap_reg_range(0x44, 0x44)
> +};
> +
> +static const struct regmap_range rt5120_wr_yes_ranges[] = {
> +	regmap_reg_range(0x06, 0x13),
> +	regmap_reg_range(0x1c, 0x20),
> +	regmap_reg_range(0x44, 0x44)
> +};
> +
> +static const struct regmap_access_table rt5120_rd_table = {
> +	.yes_ranges = rt5120_rd_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rt5120_rd_yes_ranges),
> +};
> +
> +static const struct regmap_access_table rt5120_wr_table = {
> +	.yes_ranges = rt5120_wr_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rt5120_wr_yes_ranges),
> +};
> +
> +static const struct regmap_config rt5120_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT5120_REG_FZCMODE,
> +
> +	.wr_table = &rt5120_wr_table,
> +	.rd_table = &rt5120_rd_table,
> +};
> +
> +static const struct regmap_irq rt5120_irqs[] = {
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_HOTDIE, 8),
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_REL, 8),
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_PRESS, 8)
> +};
> +
> +static const struct regmap_irq_chip rt5120_irq_chip = {
> +	.name = "rt5120-pmic",
> +	.status_base = RT5120_REG_INTSTAT,
> +	.mask_base = RT5120_REG_INTENABLE,
> +	.ack_base = RT5120_REG_INTSTAT,
> +	.mask_invert = true,
> +	.use_ack = true,
> +	.num_regs = 1,
> +	.irqs = rt5120_irqs,
> +	.num_irqs = ARRAY_SIZE(rt5120_irqs),
> +};
> +
> +static const struct resource rt5120_regulator_resources[] = {
> +	DEFINE_RES_IRQ(RT5120_INT_HOTDIE)
> +};
> +
> +static const struct resource rt5120_pwrkey_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_PRESS, "pwrkey-press"),
> +	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_REL, "pwrkey-release")
> +};
> +
> +static const struct mfd_cell rt5120_devs[] = {
> +	MFD_CELL_RES("rt5120-regulator", rt5120_regulator_resources),
> +	MFD_CELL_OF("rt5120-pwrkey", rt5120_pwrkey_resources, NULL, 0, 0,
> +		    "richtek,rt5120-pwrkey")
> +};
> +
> +static int rt5120_probe(struct i2c_client *i2c)
> +{
> +	struct regmap *regmap;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &rt5120_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
> +				       IRQF_ONESHOT, 0, &rt5120_irq_chip,
> +				       &irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add irq chip (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, rt5120_devs,
> +				    ARRAY_SIZE(rt5120_devs), NULL, 0,
> +				    regmap_irq_get_domain(irq_data));
> +}
> +
> +static const struct of_device_id rt5120_device_match_table[] = {
> +	{ .compatible = "richtek,rt5120", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt5120_device_match_table);
> +
> +static struct i2c_driver rt5120_driver = {
> +	.driver = {
> +		.name = "rt5120",
> +		.of_match_table = rt5120_device_match_table,
> +	},
> +	.probe_new = rt5120_probe,
> +};
> +module_i2c_driver(rt5120_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT5120 I2C driver");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
