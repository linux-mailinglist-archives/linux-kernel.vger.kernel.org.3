Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E004774D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbhLPOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhLPOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:41:30 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CEBC061574;
        Thu, 16 Dec 2021 06:41:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bf8so36786882oib.6;
        Thu, 16 Dec 2021 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZ+N/PwXt3wNI6OG5bLn4pZBj4OUYNFUcB0Z3kSHDig=;
        b=Lw38O7FzPExocVFNbaQ3IzBDW3/VhI31teq717b4dKOjOBkzmXCvGGn7Z/nSnoxtiy
         xCz2G8tbPjzy+YxAGZaJB2HUbyfHBkBlM+yIOPUADUfGkbULMFZK6eeNeCMAN1ge2d7J
         4tCh63uPutyMLnsatFib40QkSNd5qPMJJzxoOn0w4nukWItLx+QtE5OAmq9a5zid3ghr
         /vqdPznNP9cE0tUVCpvdwndH8MjwWf7wOclZFDB0Kk7Bf2qk6bqMVAhTisZfXFBJO5Ji
         5pgSWtv0h9z9Lkl6M8komHonnNgyND/xtiTaEzsCareDMI5LfUrSKkYJ2a0Rl4nKljoK
         JlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZ+N/PwXt3wNI6OG5bLn4pZBj4OUYNFUcB0Z3kSHDig=;
        b=hMIW7q8WfS9cueSacYOqaBjXGms2kG+zFWvtcyvk3VwqwFkA9AEyxCaiEWxoogeks2
         m3vWwoUiJVWMRTb/5fjqfc78wNfG44OLj/ieZfGi9PfTfyXuVdqaVdEKOclxp/MWRkes
         ru9TEUbUx5ehyQsFe8xwboCVj0eSi1M1NNfkUCpxmtC4Ctodo0LbpmkRFh55NNR899fH
         TgtO1JRGX7rmZKaAyLYe8vt6yjWdEBJ3gbAHFW+5F5c4cWk/YDG97hYDeIEeKsUXMLHF
         3dPIq6G8So1SHdmNryITnaKcCVsS2+7yHj7HsQ9mqIx3LLQeOVhOU64H8Jo5x6sA4KAv
         Joyg==
X-Gm-Message-State: AOAM533emXUwkW60mdjZx80CPcbkoOISjrWIL9TqsQ5KTen4s8sUQJoS
        8FMxlSr2C+S9m6zOIYXxQmc=
X-Google-Smtp-Source: ABdhPJwrIVVWQ2Yp/Wa9pbFM2t5F6WIhXHivHvp3JzvDoica3ex2pMRl3k1bOyoajPA13da0xP3mOQ==
X-Received: by 2002:a54:4614:: with SMTP id p20mr4403488oip.39.1639665689263;
        Thu, 16 Dec 2021 06:41:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm1107029otg.42.2021.12.16.06.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:41:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v17 5/8] hwmon: sy7636a: Add temperature driver for
 sy7636a
To:     Alistair Francis <alistair@alistair23.me>, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com
References: <20211216122525.136139-1-alistair@alistair23.me>
 <20211216122525.136139-6-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d946812e-fb7c-6cf8-df8c-171f0bcd0868@roeck-us.net>
Date:   Thu, 16 Dec 2021 06:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216122525.136139-6-alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 4:25 AM, Alistair Francis wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/hwmon/index.rst         |   1 +
>   Documentation/hwmon/sy7636a-hwmon.rst |  26 +++++++
>   drivers/hwmon/Kconfig                 |   9 +++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/sy7636a-hwmon.c         | 106 ++++++++++++++++++++++++++
>   5 files changed, 143 insertions(+)
>   create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
>   create mode 100644 drivers/hwmon/sy7636a-hwmon.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 7046bf1870d9..a887308850cd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m1
>      sparx5-temp
>      stpddc60
> +   sy7636a-hwmon
>      tc654
>      tc74
>      thmc50
> diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
> new file mode 100644
> index 000000000000..5612079397d5
> --- /dev/null
> +++ b/Documentation/hwmon/sy7636a-hwmon.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver sy7636a-hwmon
> +=========================
> +
> +Supported chips:
> +
> + * Silergy SY7636A PMIC
> +
> +
> +Description
> +-----------
> +
> +This driver adds hardware temperature reading support for
> +the Silergy SY7636A PMIC.
> +
> +The following sensors are supported
> +
> +  * Temperature
> +      - SoC on-die temperature in milli-degree C
> +
> +sysfs-Interface
> +---------------
> +
> +temp0_input
> +	- SoC on-die temperature (milli-degree C)
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 64bd3dfba2c4..3139a286c35a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1662,6 +1662,15 @@ config SENSORS_SIS5595
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sis5595.
>   
> +config SENSORS_SY7636A
> +	tristate "Silergy SY7636A"
> +	help
> +	  If you say yes here you get support for the thermistor readout of
> +	  the Silergy SY7636A PMIC.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sy7636a-hwmon.
> +
>   config SENSORS_DME1737
>   	tristate "SMSC DME1737, SCH311x and compatibles"
>   	depends on I2C && !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index baee6a8d4dd1..8f8da52098d1 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -182,6 +182,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
>   obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> new file mode 100644
> index 000000000000..6dd9c2a0f0e0
> --- /dev/null
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Functions to access SY3686A power management chip temperature
> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + *
> + * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
> + *          Alistair Francis <alistair@alistair23.me>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/machine.h>
> +
> +#include <linux/mfd/sy7636a.h>
> +
> +static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *temp)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	int ret, reg_val;
> +
> +	ret = regmap_read(regmap,
> +			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*temp = reg_val * 1000;
> +
> +	return 0;
> +}
> +
> +static umode_t sy7636a_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	if (attr != hwmon_temp_input)
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static const struct hwmon_ops sy7636a_hwmon_ops = {
> +	.is_visible = sy7636a_is_visible,
> +	.read = sy7636a_read,
> +};
> +
> +static const struct hwmon_channel_info *sy7636a_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info sy7636a_chip_info = {
> +	.ops = &sy7636a_hwmon_ops,
> +	.info = sy7636a_info,
> +};
> +
> +static int sy7636a_sensor_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	struct regulator *regulator;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	regulator = devm_regulator_get(&pdev->dev, "vcom");
> +	if (IS_ERR(regulator))
> +		return PTR_ERR(regulator);
> +
> +	err = regulator_enable(regulator);
> +	if (err)
> +		return err;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +							 "sy7636a_temperature", regmap,
> +							 &sy7636a_chip_info, NULL);
> +
> +	if (IS_ERR(hwmon_dev)) {
> +		err = PTR_ERR(hwmon_dev);
> +		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sy7636a_sensor_driver = {
> +	.probe = sy7636a_sensor_probe,
> +	.driver = {
> +		.name = "sy7636a-temperature",
> +	},
> +};
> +module_platform_driver(sy7636a_sensor_driver);
> +
> +MODULE_DESCRIPTION("SY7636A sensor driver");
> +MODULE_LICENSE("GPL");
> 

