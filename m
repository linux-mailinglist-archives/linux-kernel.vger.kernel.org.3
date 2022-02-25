Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD34C46A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiBYNgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiBYNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:36:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C81DB3D6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:36:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so4534392wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZatkCkH0tiJuMD2zO/1+/ITUO0H0CuZ8bVACIi8yJfU=;
        b=KU3qOow9ALEILnaJcAHCAV2hs8j29RJhbpsuqTe6/TM3JDkvknNRTZICSH1ZVKohi5
         cq2V2dtIrA7uvHvbkEndpj257TnwW9hsX+CSGUzKg5iXFDpjd12S8v5Cn2fItflPFL0k
         RKJV1xlOyilxleTSJYSK4QMsx0kC9DqaCFdpWKfwddoHuUpK4wMpMJenuMlPRat+wdvV
         cSXTpcSfmB5Ynqfjto+RRs9vK0ziuPdK5/MczK1Px8uI7Dsxs2rjYrqNE7QtHS1p6d/k
         XxsvTl4Ak7Yy+8CCB1FMBYm0e2jxSIK77hsMdLU9IGTJHx2uQZlFvxXi+APClId41PPW
         z/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZatkCkH0tiJuMD2zO/1+/ITUO0H0CuZ8bVACIi8yJfU=;
        b=LGnxsg+7V1EU0oSt6n91szEYCaJh5o19p/AnIQ+RbRmnLn8e4hl/9rkEt/NOY5qugM
         xJJCIRijoR42tGGUPBSi47urV43v15a4Wnd9DL1rIPEY4XAO3cTGBlILCID0xzV1XpSE
         VgBZtHPGmiG/DGh+GG/9gO0RAL0Xe+cn6yEm8Q88RHsJ2HwOxZiSEvFJ3UkFt1X9Ty4x
         3DmMKihX8ubZx9eGTJkZDZ0GUnmyF6ig4avvTmgyvL3+Jrw90g7WYAsjH+TVZVzcS4C7
         Y2GhvGowwTiWUqjpng3zPC6nsiF9MAShOgqqlw+orgUCpoCVf8f10IrpK1PeRKY19KpZ
         WmCA==
X-Gm-Message-State: AOAM533f1ju2Twct3YvL1gyMevfRM5oL7WvglSqBPwZ5WtR6Xyc+hLpO
        e6/9ycj1POSJRcqg3r4GvEiuPA==
X-Google-Smtp-Source: ABdhPJzbz7fAy9NilvFpC5CCxvjjUiKAaI6E1HnpMUUEKICWrBb7YnVFFjgbrN4X1GhxtSvqW7DhSQ==
X-Received: by 2002:a05:6000:184d:b0:1ea:78a5:f9c8 with SMTP id c13-20020a056000184d00b001ea78a5f9c8mr6261272wri.439.1645796163603;
        Fri, 25 Feb 2022 05:36:03 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d550a000000b001e30e81afd1sm2379527wrv.2.2022.02.25.05.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:36:02 -0800 (PST)
Message-ID: <48c9fecc-67eb-891c-fb07-30ae4691031c@linaro.org>
Date:   Fri, 25 Feb 2022 14:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] thermal: Add thermal driver for Sunplus SP7021
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1642127137.git.lhjeff911@gmail.com>
 <2847f96335da1c74dfbee7ba67939bdc474ba2a4.1642127137.git.lhjeff911@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2847f96335da1c74dfbee7ba67939bdc474ba2a4.1642127137.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 03:46, Li-hao Kuo wrote:
> Add thermal driver for Sunplus SP7021.

Please give a detailed description of the sensor so we can refer to the 
changelog to understand the code below.


> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v4:
>   - Modify yaml file remove reg name and change nvmem name
> 
>   MAINTAINERS                       |   6 ++
>   drivers/thermal/Kconfig           |  10 +++
>   drivers/thermal/Makefile          |   1 +
>   drivers/thermal/sunplus_thermal.c | 157 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 174 insertions(+)
>   create mode 100644 drivers/thermal/sunplus_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc4a137..e41b265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18423,6 +18423,12 @@ L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/ethernet/dlink/sundance.c
>   
> +SUNPLUS THERMAL DRIVER
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/sunplus_thermal.c
> +
>   SUPERH
>   M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>   M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e37691e..98647c7 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config SUNPLUS_THERMAL
> +	tristate "Sunplus thermal drivers"
> +	depends on SOC_SP7021
> +	help
> +	  This the Sunplus SP7021 thermal driver, which supports the primitive
> +	  temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +	  If you have a Sunplus SP7021 platform say Y here and enable this option
> +	  to have support for thermal management
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1..2f7417a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
> \ No newline at end of file
> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
> new file mode 100644
> index 0000000..460c41d
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/rtc.h>
> +#include <linux/thermal.h>


Please check the headers above. Some are not necessary (eg cpufreq, 
delay, rtc ...) AFAICT

> +#define DISABLE_THREMAL		(BIT(31) | BIT(15))
> +#define ENABLE_THREMAL		BIT(31)
> +#define SP_THREMAL_MASK		GENMASK(10, 0)

THREMAL ?

s/THREMAL/THERMAL/ ?

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
> +	struct platform_device *pdev;
> +	enum thermal_device_mode mode;
> +	long sensor_temp;
> +	void __iomem *regs;
> +	int otp_temp0;
> +	int otp_temp1;
> +	u32 id;
> +};
> +
> +static char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
> +{
> +	char *ret = NULL;
> +	struct nvmem_cell *c = nvmem_cell_get(dev, "calib");
> +
> +	if (IS_ERR_OR_NULL(c))
> +		return NULL;
> +
> +	ret = nvmem_cell_read(c, len);
> +	nvmem_cell_put(c);

That is wrong. Please refer to the documentation driver-api/nvmem.rst

nvmem_cell_put() must be called when the pointer returned by 
nvmem_cell_read() is no longer used.


> +	return ret;
> +}
> +
> +static void sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *_d)
> +{
> +	ssize_t otp_l = 0;
> +	char *otp_v;
> +
> +	otp_v = sp7021_otp_coef_read(_d, &otp_l);
> +	if (otp_l < 3)
> +		return;
> +	if (IS_ERR_OR_NULL(otp_v))
> +		return;
> +	sp_data->otp_temp0 = otp_v[0] | (otp_v[1] << 8);

What do you expect by 8bits shifting a char here ?

> +	sp_data->otp_temp0 = otp_v[0] | (otp_v[1] << 8);

duplicate line

> +	sp_data->otp_temp0 = FIELD_GET(SP_THREMAL_MASK, sp_data->otp_temp0);
> +	sp_data->otp_temp1 = (otp_v[1] >> 3) | (otp_v[2] << 5);
> +	sp_data->otp_temp1 = FIELD_GET(SP_THREMAL_MASK, sp_data->otp_temp1);
> +	if (sp_data->otp_temp0 == 0)
> +		sp_data->otp_temp0 = TEMP_OTP_BASE;

Can you add a comment explaining how is stored the coef in the nvcell, 
so we can understand the above actions ?


> +}
> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +	struct sp_thermal_data *sp_data = data;
> +	int t_code;
> +
> +	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +	t_code = FIELD_GET(SP_THREMAL_MASK, t_code);
> +	*temp = ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
> +	*temp *= 10;

A comment would be welcome here also

> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops sp_of_thermal_ops = {
> +	.get_temp = sp_thermal_get_sensor_temp,
> +};
> +
> +static int sp_thermal_register_sensor(struct platform_device *pdev, struct sp_thermal_data *data,
> +				       int index)
> +{
> +	int ret;
> +
> +	data->id = index;
> +	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +					data->id, data, &sp_of_thermal_ops);
> +	if (!IS_ERR_OR_NULL(data->pcb_tz))
> +		return 0;
> +	ret = PTR_ERR(data->pcb_tz);
> +	data->pcb_tz = NULL;
> +	return ret;

Usually the logic is inverted

	data->pcb_tz = devm_thermal_zone_of_sensor_register();
	if (IS_ERR_OR_NULL(data->pcb_tz))
		return PTR_ERR(data->pcb_tz);

	return 0;

No need to set pcb_tz to NULL

> +}
> +
> +static int sp7021_thermal_probe(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data;
> +	struct resource *res;
> +	int ret;
> +
> +	sp_data = devm_kzalloc(&(pdev->dev), sizeof(*sp_data), GFP_KERNEL);
> +	if (!sp_data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res))
> +		return dev_err_probe(&(pdev->dev), PTR_ERR(res), "resource get fail\n");

Use an intermediate 'dev' variable to shorten the line

> +	sp_data->regs = devm_ioremap(&(pdev->dev), res->start, resource_size(res));
> +	if (IS_ERR(sp_data->regs))
> +		return dev_err_probe(&(pdev->dev), PTR_ERR(sp_data->regs), "mas_base get fail\n");

typo: mas_base -> ioremap

> +	writel(ENABLE_THREMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
> +
> +	platform_set_drvdata(pdev, sp_data);
> +	sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
> +	ret = sp_thermal_register_sensor(pdev, sp_data, 0);

	return sp_thermal_register_sensor(...);
> +

> +	return ret;
> +}
> +
> +static int sp7021_thermal_remove(struct platform_device *_pd)
> +{
> +	return 0;
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
> +	.remove	= sp7021_thermal_remove,
> +	.driver	= {
> +		.name	= "sp7021-thermal",
> +		.of_match_table = of_match_ptr(of_sp7021_thermal_ids),
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
