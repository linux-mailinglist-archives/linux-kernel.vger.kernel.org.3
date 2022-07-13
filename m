Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C88572F36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiGMH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiGMH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:28:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF9E3C31
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:27:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 19so12506496ljz.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qvvhomGYxh568AGzjojM/+vjUS/JUjZdwsCQhUeoe+A=;
        b=rAStiLl4BCjScjyYhy8ewWucNU3to99QQsy2c7vbcyTNxQLa5HvG/pJFm+y9/IEhe5
         qx1SaQvjXAkckDC+Wo/BhoXoS2qcebpXitqyJvhcbS/Ry6p9rWuQ3FiHRK+gbIBawScz
         p8CllDp9YyWwEO5/YYsogbQxrqynRxRcJUIvNnA7f9QYqtpigrLOFTDcugiPWP+4Dn/V
         ddIfhj9SKdb7hNr+JIWPSlD9OLFfWA4CSz6Mr6iex3KHAdb6aNFxia13GZRgfLtW/NAe
         aCa/bk/NS56WWt0rVgJMdKlbmm/6Wk694M+95ezfSdrNxYDaQ9ZjtaqYN1Xw1AKRSTYM
         q6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qvvhomGYxh568AGzjojM/+vjUS/JUjZdwsCQhUeoe+A=;
        b=jkOeGW02qUF8P7Tb9vnTFDhEYNrxdmFUp4JYG03yl2dg01/4pc6xrTrUQcAjfY3K7B
         2BMSLhIXLLd0kxohb+72IbLuq95XypCkw5AggsFq/3md4mIlJmXY8BAtXwdherztsFm7
         ZA8Dm7aJMQDvSfmk4azodCtDQvNstjsK9X8NRoP1oi9t5l3zqF20+0qB3lrHdZNuiPTf
         /nl99KYeeataNVF7KpMguHO9GLzqPe6IwQIK987c4AP/VxDJRrDbzAOLMPkXZRRndKHQ
         PBbBs9kmh3dMjeik1D55MEKO6NGXfhAQew6eHfHHyZ00E28wgwjrW6drCjkqs43YJcy3
         VaLw==
X-Gm-Message-State: AJIora+ogASgvJfxtIcyeIqsGC22cQ0y/mT+ubqoOwxO/e6kXjf/qvm6
        ClPczmqscCf7KYVrYvhlEobYLQ==
X-Google-Smtp-Source: AGRyM1surgPeoakhJynXpUFVY0pgRy+1Zm6CBFx6AvxxVm2BvPHnSomshzat3mOu4EUp/tBftgPl1w==
X-Received: by 2002:a05:651c:511:b0:25b:f78e:cb30 with SMTP id o17-20020a05651c051100b0025bf78ecb30mr978208ljp.327.1657697276784;
        Wed, 13 Jul 2022 00:27:56 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm1162960lfr.198.2022.07.13.00.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 00:27:55 -0700 (PDT)
Message-ID: <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
Date:   Wed, 13 Jul 2022 09:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] mfd: Samsung: Add Samsung sysmgr driver
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
 <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:57, Dongjin Yang wrote:
> This driver is used for SoCs produced by Samsung Foundry to provide
> Samsung sysmgr API. The read/write request of sysmgr is delivered to
> Samsung secure monitor call.
> 
> Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
> ---
>  MAINTAINERS                        |   2 +
>  drivers/mfd/Kconfig                |  11 +++
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/samsung-sysmgr.c       | 167 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/samsung-sysmgr.h |  30 +++++++
>  5 files changed, 211 insertions(+)
>  create mode 100644 drivers/mfd/samsung-sysmgr.c
>  create mode 100644 include/linux/mfd/samsung-sysmgr.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55cb8901ccdc..44ad4bd406a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1870,9 +1870,11 @@ F:	arch/arm/mach-artpec
>  F:	drivers/clk/axis
>  F:	drivers/crypto/axis
>  F:	drivers/firmware/samsung-smc-svc.c
> +F:	drivers/mfd/samsung-sysmgr.c
>  F:	drivers/mmc/host/usdhi6rol0.c
>  F:	drivers/pinctrl/pinctrl-artpec*
>  F:	include/linux/firmware/samsung-smc-svc.h
> +F:	include/linux/mfd/samsung-sysmgr.h

Not related to Axis/Artpec SoC.

>  
>  ARM/ASPEED I2C DRIVER
>  M:	Brendan Higgins <brendanhiggins@google.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..ce6ab5842bf0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -51,6 +51,17 @@ config MFD_ACT8945A
>  	  linear regulators, along with a complete ActivePath battery
>  	  charger.
>  
> +config MFD_SAMSUNG_SYSMGR
> +	bool "System Manager for Samsung Foundry platforms"
> +	depends on ARCH_ARTPEC && OF

Samsung Foundry does not match ARTPEC... Artpec 6 is not Samsung Foundry
SoC, is it?

Missing compile test.

> +	select MFD_SYSCON
> +	select SAMSUNG_SECURE_SERVICE
> +	help
> +	  Select this to get System Manager support for SoCs which use
> +	  Samsung Foundry platforms.
> +	  This System Manager has depedency on Samsung Secure Service
> +	  for providing secure service call.

Looking at the driver, it does literally nothing. Looks like workaround
for incomplete bindings and DTS. It's a no-go.

> +
>  config MFD_SUN4I_GPADC
>  	tristate "Allwinner sunxi platforms' GPADC MFD driver"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..490f041d1262 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -248,6 +248,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>  obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
> +obj-$(CONFIG_MFD_SAMSUNG_SYSMGR) += samsung-sysmgr.o
>  obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>  
> diff --git a/drivers/mfd/samsung-sysmgr.c b/drivers/mfd/samsung-sysmgr.c
> new file mode 100644
> index 000000000000..a202e8c4c4f2
> --- /dev/null
> +++ b/drivers/mfd/samsung-sysmgr.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Samsung Electronics, Co. Ltd.
> + * Copyright (C) 2018-2019, Intel Corporation.
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Linaro Ltd.
> + *
> + * Inspired by drivers/mfd/altera-sysmgr.c
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mfd/samsung-sysmgr.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/**
> + * struct samsung_sysmgr - Samsung System Manager
> + * @regmap: the regmap used for System Manager accesses.
> + * @base  : the base address for the System Manager
> + */
> +struct samsung_sysmgr {
> +	struct regmap   *regmap;
> +	resource_size_t *base;
> +};
> +
> +static struct platform_driver samsung_sysmgr_driver;

No, no static variables.

> +
> +static struct regmap_config mmio_regmap_cfg = {
> +	.name = "sysmgr_mmio",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
> +static struct regmap_config samsung_smccc_regmap_cfg = {
> +	.name = "samsung_sysmgr_smccc",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.reg_read = samsung_smc_reg_read,
> +	.reg_write = samsung_smc_reg_write,
> +};
> +
> +/**
> + * samsung_sysmgr_regmap_lookup_by_phandle
> + * Find the sysmgr previous configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.
> + */
> +struct regmap *samsung_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +						       const char *property)
> +{
> +	struct device *dev;
> +	struct samsung_sysmgr *sysmgr;
> +	struct device_node *sysmgr_np;
> +
> +	if (property)
> +		sysmgr_np = of_parse_phandle(np, property, 0);
> +	else
> +		sysmgr_np = np;
> +
> +	if (!sysmgr_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	dev = driver_find_device_by_of_node(&samsung_sysmgr_driver.driver,
> +					    (void *)sysmgr_np);
> +	of_node_put(sysmgr_np);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	sysmgr = dev_get_drvdata(dev);
> +
> +	return sysmgr->regmap;
> +}
> +EXPORT_SYMBOL_GPL(samsung_sysmgr_regmap_lookup_by_phandle);

This breaks layers/encapsulation and looks like a hack for incomplete
bindings/DTS. No, no exporting regmaps.

> +
> +static int sysmgr_probe(struct platform_device *pdev)
> +{
> +	struct samsung_sysmgr *sysmgr;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct regmap_config sysmgr_config =
> +		*((struct regmap_config *)of_device_get_match_data(dev));
> +
> +	sysmgr = devm_kzalloc(dev, sizeof(*sysmgr), GFP_KERNEL);
> +	if (!sysmgr)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
> +	sysmgr_config.max_register = resource_size(res) -
> +				     sysmgr_config.reg_stride;
> +	if (sysmgr_config.reg_read) {
> +		/* Need physical address for SMCC call */
> +		sysmgr->base = (resource_size_t *)res->start;
> +		regmap = devm_regmap_init(dev, NULL, sysmgr->base,
> +					  &sysmgr_config);
> +	} else {
> +		sysmgr->base = devm_ioremap(dev, res->start,
> +					    resource_size(res));
> +		if (!sysmgr->base)
> +			return -ENOMEM;
> +
> +		regmap = devm_regmap_init_mmio(dev, sysmgr->base,
> +					       &sysmgr_config);
> +	}
> +
> +	if (IS_ERR(regmap)) {
> +		pr_err("regmap init failed\n");

dev_err

> +		return PTR_ERR(regmap);
> +	}
> +
> +	sysmgr->regmap = regmap;
> +
> +	platform_set_drvdata(pdev, sysmgr);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id samsung_sysmgr_of_match[] = {
> +	{ .compatible = "samsung,sys-mgr", .data = &mmio_regmap_cfg },
> +	{
> +	  .compatible = "samsung,sys-mgr-smccc",
> +	  .data = &samsung_smccc_regmap_cfg
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, samsung_sysmgr_of_match);
> +
> +static struct platform_driver samsung_sysmgr_driver = {
> +	.probe =  sysmgr_probe,
> +	.driver = {
> +		.name = "samsung,system_manager",
> +		.of_match_table = samsung_sysmgr_of_match,
> +	},
> +};
> +
> +static int __init samsung_sysmgr_init(void)
> +{
> +	return platform_driver_register(&samsung_sysmgr_driver);
> +}
> +core_initcall(samsung_sysmgr_init);

module_platform_driver() instead.

> +
> +static void __exit samsung_sysmgr_exit(void)
> +{
> +	platform_driver_unregister(&samsung_sysmgr_driver);
> +}
> +module_exit(samsung_sysmgr_exit);
> +
> +MODULE_AUTHOR("Dongjin Yang <dj76.yang@samsung.com>");
> +MODULE_DESCRIPTION("Samsung System Manager driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/samsung-sysmgr.h b/include/linux/mfd/samsung-sysmgr.h
> new file mode 100644
> index 000000000000..d6887cb86ea8
> --- /dev/null
> +++ b/include/linux/mfd/samsung-sysmgr.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 Samsung Electronics, Co. Ltd.
> + * Copyright (C) 2018-2019 Intel Corporation
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Linaro Ltd.
> + */
> +
> +#ifndef __LINUX_MFD_SAMSUNG_SYSMGR_H__
> +#define __LINUX_MFD_SAMSUNG_SYSMGR_H__
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/firmware/samsung-smc-svc.h>
> +
> +struct device_node;
> +
> +#if defined(CONFIG_MFD_SAMSUNG_SYSMGR)

No ifdefs, no stubs.



Best regards,
Krzysztof
