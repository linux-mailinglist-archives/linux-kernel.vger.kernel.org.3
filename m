Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42A5006B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiDNHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiDNHOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:14:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35FB15A24
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:12:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i20so5591194wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dCJ1KboKpQ4PJ5jQsLTtGQGQXlAWxcagYMhUrW9HAic=;
        b=oJ17x9e47tqvew1pe+2e6aGlgBDU8Tkricf6mjcdYk74yZUlzrEvYfFoG69wM6CmR5
         rYr3+oQXjyzokgt4YMmdeEhi63lw3b6VytJg+D7DE/hdkzkzWMur2GYuS9QpXU9yCDOQ
         kYNrCDoEdV/KmtfNk5aOYFPgGao14Epbgm1F/giK5mtQ8NUsLIInmlfonFUwDB9hHzeb
         mQaMTNZ61gNjmyAjruRQXik9uXhwaTOtrenGYTPAdbEmY4+7kd3NC0uoiqc8dwpwQrgL
         nIeaNAIJsFETj3YdF9uahTZJnooBMgBmw3D7UMbBX6ZHtWUq8zYXtn3Y8RJVahW6mPQQ
         qvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dCJ1KboKpQ4PJ5jQsLTtGQGQXlAWxcagYMhUrW9HAic=;
        b=da83kQbbfz02Tk2QZGpjp/BBaUlYpWA3egmsnjupc7P1eXhLAoskebIXsPP9lRGRkn
         3EpUuvtP+88OHEOJV/cIRbfTaIPeT5ieYzHH8mowJfrAPQBJfjhZb7Gfs4T6BNc/0LL2
         qlwRR4goK/RUUC5EMVCtvya0LfcDhup77N2/WqJyppF8RkBw/16C+im6VvX8aW4dg2w8
         RYio5esOPObARzf7s7iretARCxveFtGcX0gNjv8ZuiI4I5GQLTjhZllwWct2f/Bv4R5q
         nTvOMjjeEGlZjZh+HW4SK9isaHQBoAzxk6ak39FjXdfvnNtf8FjoptDBG5Kl0+aPclWg
         pxpw==
X-Gm-Message-State: AOAM531nGVg01Kc3+hih1mKRMaeyYghf0gZBwJsEcDZH1b1RN8W7KqXa
        OhfY3g0mk13XFnMk9UdsPwGf6Q==
X-Google-Smtp-Source: ABdhPJz2T3ggR3EfQcyK8DZzQ70TOwRDF0jFwIKD4Leh6qiISJ4TwbdD+/EurpSgsibrMvFkRCc6nw==
X-Received: by 2002:adf:d1e2:0:b0:204:1a8c:7498 with SMTP id g2-20020adfd1e2000000b002041a8c7498mr979932wrd.530.1649920337169;
        Thu, 14 Apr 2022 00:12:17 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm6267917wmq.27.2022.04.14.00.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:12:16 -0700 (PDT)
Message-ID: <5ddeb940-670f-2eda-6ba0-567c28406a61@linaro.org>
Date:   Thu, 14 Apr 2022 09:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 1/2] thermal: Add thermal driver for Sunplus SP7021
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, krzk@kernel.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1649662002.git.lhjeff911@gmail.com>
 <c59e0a5c53f055b7159bc896083538d1f8ac9ad8.1649662002.git.lhjeff911@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c59e0a5c53f055b7159bc896083538d1f8ac9ad8.1649662002.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 10:52, Li-hao Kuo wrote:
> Add thermal driver for Sunplus SP7021.

Already asked previously : please give a more detailed description of 
the sensor

I've commented again this patch. There are some comments which are not 
taken into account from my previous review on v4


> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v7:
>   - Modify yaml file.
> 
>   MAINTAINERS                       |   6 ++
>   drivers/thermal/Kconfig           |  10 +++
>   drivers/thermal/Makefile          |   1 +
>   drivers/thermal/sunplus_thermal.c | 139 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 156 insertions(+)
>   create mode 100644 drivers/thermal/sunplus_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f11..307570c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18885,6 +18885,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>   F:	drivers/spi/spi-sunplus-sp7021.c
>   
> +SUNPLUS THERMAL DRIVER
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/sunplus_thermal.c
> +
>   SUNPLUS UART DRIVER
>   M:	Hammer Hsieh <hammerh0314@gmail.com>
>   S:	Maintained
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e37691e..66316c3 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config SUNPLUS_THERMAL
> +	tristate "Sunplus thermal drivers"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	help
> +	  This the Sunplus SP7021 thermal driver, which supports the primitive
> +	  temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +	  If you have a Sunplus SP7021 platform say Y here and enable this option
> +	  to have support for thermal management
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1..38a76f9 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
> new file mode 100644
> index 0000000..9a9b348
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>

Already commented, check the headers above.

> +#define DISABLE_THERMAL		(BIT(31) | BIT(15))
> +#define ENABLE_THERMAL		BIT(31)
> +#define SP_THERMAL_MASK		GENMASK(10, 0)
> +#define SP_TCODE_HIGH_MASK	GENMASK(10, 8)
> +#define SP_TCODE_LOW_MASK	GENMASK(7, 0)
> +
> +#define TEMP_RATE		608
> +#define TEMP_BASE		3500
> +#define TEMP_OTP_BASE		1518
> +
> +#define SP_THERMAL_CTL0_REG	0x0000
> +#define SP_THERMAL_STS0_REG	0x0030
> +
> +/* common data structures */
> +struct sp_thermal_data {
> +	struct thermal_zone_device *pcb_tz;

field not used outside of the function checking the return code of 
sensor register

> +	struct platform_device *pdev;

field not used

> +	enum thermal_device_mode mode;

field not used

> +	void __iomem *regs;
> +	int otp_temp0;
> +	u32 id;
> +};
> +
> +static int sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
> +{
> +	struct nvmem_cell *cell;
> +	ssize_t otp_l;
> +	char *otp_v;
> +
> +	cell = nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	otp_v = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);

See my previous comments in v4, this is wrong. Move the nvmem_cell_put() 
after FIELD_PREP() ... below where otp_v is no longer used.

> +	if (otp_l < 3)
> +		return -EINVAL;

Please replace '3' by a macro

Why this check is needed by the way ? Sounds like only 0 and 1 indexes 
are used here.

> +	sp_data->otp_temp0 = FIELD_PREP(SP_TCODE_LOW_MASK, otp_v[0]) |
> +			     FIELD_PREP(SP_TCODE_HIGH_MASK, otp_v[1]);
> +	if (sp_data->otp_temp0 == 0)
> +		sp_data->otp_temp0 = TEMP_OTP_BASE;
> +	return 0;
> +}
> +
> +/*
> + *When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
> + *TEMP_RATE is the SP7021 temperature slope.
> + *T_CODE : 11 digits in total
> + */

nit: space after '*'

Please elaborate the comment, it is still unclear

> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +	struct sp_thermal_data *sp_data = data;
> +	int t_code;
> +
> +	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
> +	*temp = ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
> +	*temp *= 10;
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
> +	.get_temp = sp_thermal_get_sensor_temp,
> +};
> +
> +static int sp_thermal_register_sensor(struct platform_device *pdev,
> +				      struct sp_thermal_data *data, int index)

Adding a function to wrap another function is pointless in this case. It 
is simpler to directly call devm_thermal_zone_of_sensor_register() from 
the probe function

> +{
> +	data->id = index;
> +	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							    data->id,
> +							    data, &sp_of_thermal_ops);
> +	if (IS_ERR_OR_NULL(data->pcb_tz))
> +		return PTR_ERR(data->pcb_tz);
> +	return 0;
> +}
> +
> +static int sp7021_thermal_probe(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data;
> +	struct resource *res;
> +	int ret;
> +
> +	sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
> +	if (!sp_data)
> +		return -ENOMEM;
> +
> +	sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sp_data->regs)) {
> +		dev_err(&pdev->dev, "resource get fail\n");
> +		return PTR_ERR(sp_data->regs);
> +	}
> +
> +	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
> +
> +	platform_set_drvdata(pdev, sp_data);
> +	ret = sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
> +	if (ret)
> +		return ret;

Add some space to let the code easier to read

> +	ret = sp_thermal_register_sensor(pdev, sp_data, 0);
> +	return ret;
> +}
> +
> +static const struct of_device_id of_sp7021_thermal_ids[] = {
> +	{ .compatible = "sunplus,sp7021-thermal" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
> +
> +static struct platform_driver sp7021_thermal_driver = {
> +	.probe	= sp7021_thermal_probe,

and .remove ?

> +	.driver	= {
> +		.name	= "sp7021-thermal",
> +		.of_match_table = of_sp7021_thermal_ids,
> +		},
> +};
> +module_platform_driver(sp7021_thermal_driver);
> +
> +MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
> +MODULE_DESCRIPTION("Thermal driver for SP7021 SoC");
> +MODULE_LICENSE("GPL");


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
