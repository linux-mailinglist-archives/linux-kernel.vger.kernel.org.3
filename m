Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E64E737A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359130AbiCYMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359504AbiCYM2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:28:08 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF506D9E97;
        Fri, 25 Mar 2022 05:25:17 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a8so14980891ejc.8;
        Fri, 25 Mar 2022 05:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=olVkiltawHdnXhEXNKbgr8wPBREkH6kj7x4r7geYywk=;
        b=SahEljtsVCZJCPrMbHnweoTMbhMm2O5FfcN+W0JyBWOrGKu00av5HcXT058dtSH28r
         qm3e4+GMPeOYxxI7qRVUmI3n0OKCfj2tIFdgZP3yPZiBx60gJthgSgv3Y40wR8AgeNG4
         q4AHhrdDf3QYEToOWg4S1s0w2LG7Pf0KgG01BwsyV6S/jq3d9aCo9uWCvJNZfrJOQlRm
         5+uOXCKyptxptHJs52+4s9UXAWkd3MP5WtEeV1VZjzdI4ZiFXjB2wdRzLG1VSzrpqUji
         72QH7C6QXs+VoNoaFbr7VYzWFHmQJQp84OxNKAdkrHbPlmOHaCort/R3GS8Hi+3/Agym
         AJ5g==
X-Gm-Message-State: AOAM532RZdF9Kjlac8vKsp5/Zp0WSg+QVfiRyUWbAYaTTh7Ezpl1m97r
        JTgHYUHEVTdwqEFeUqAlVVY=
X-Google-Smtp-Source: ABdhPJyB0tilidYDYhUj7lGBUIeMPp+wfyIKzzBUxxDQR317d3CQMJ72fhfgZnbX66U6HMAhQxxmrw==
X-Received: by 2002:a17:906:c214:b0:6b3:d0d6:9fe6 with SMTP id d20-20020a170906c21400b006b3d0d69fe6mr11192249ejz.150.1648211116239;
        Fri, 25 Mar 2022 05:25:16 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm2268157ejh.214.2022.03.25.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:25:15 -0700 (PDT)
Message-ID: <6ff0eb26-344d-dd78-9556-a96123b4f056@kernel.org>
Date:   Fri, 25 Mar 2022 13:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
 <20220325103014.6597-4-shreeya.patel@collabora.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325103014.6597-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 11:30, Shreeya Patel wrote:
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
> 
> Add initial support for ltrf216a ambient light sensor.
> 
> Datasheet :-
> https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTR-F216A-QT.pdf
> 
> 
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> ---
>  drivers/iio/light/Kconfig    |  10 ++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/ltrf216a.c | 334 +++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/iio/light/ltrf216a.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a62c7b4b8678..08fa383a8ca7 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -318,6 +318,16 @@ config SENSORS_LM3533
>  	  changes. The ALS-control output values can be set per zone for the
>  	  three current output channels.
>  
> +config LTRF216A
> +        tristate "Liteon LTRF216A Light Sensor"
> +        depends on I2C
> +        help
> +          If you say Y or M here, you get support for Liteon LTRF216A
> +          Ambient Light Sensor.
> +
> +          If built as a dynamically linked module, it will be called
> +          ltrf216a.
> +
>  config LTR501
>  	tristate "LTR-501ALS-01 light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index d10912faf964..8fa91b9fe5b6 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
>  obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
> +obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
>  obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+= max44000.o
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> new file mode 100644
> index 000000000000..99295358a7fe
> --- /dev/null
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LTRF216A Ambient Light Sensor
> + *
> + * Copyright (C) 2021 Lite-On Technology Corp (Singapore)
> + * Author: Shi Zhigang <Zhigang.Shi@liteon.com>
> + *
> + * IIO driver for LTRF216A (7-bit I2C slave address 0x53).
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +
> +#define LTRF216A_DRV_NAME "ltrf216a"
> +
> +#define LTRF216A_MAIN_CTRL		0x00
> +
> +#define LTRF216A_ALS_MEAS_RATE		0x04
> +#define LTRF216A_MAIN_STATUS		0x07
> +#define LTRF216A_CLEAR_DATA_0		0x0A
> +
> +#define LTRF216A_ALS_DATA_0		0x0D
> +
> +static const int int_time_mapping[] = { 400000, 200000, 100000 };
> +
> +struct ltrf216a_data {
> +	struct i2c_client *client;
> +	u32			int_time;
> +	u8			int_time_fac;
> +	u8			als_gain_fac;
> +	struct mutex mutex;
> +};
> +
> +/* open air. need to update based on TP transmission rate. */
> +#define WIN_FAC	1
> +
> +static const struct iio_chan_spec ltrf216a_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.2 0.4");
> +
> +static struct attribute *ltrf216a_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ltrf216a_attribute_group = {
> +	.attrs = ltrf216a_attributes,
> +};
> +
> +static int ltrf216a_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	/* enable sensor */
> +	ret |= 0x02;
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltrf216a_disable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_set_it_time(struct ltrf216a_data *data, int itime)
> +{
> +	int i, ret, index = -1;
> +	u8 reg;
> +
> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
> +		if (int_time_mapping[i] == itime) {
> +			index = i;
> +			break;
> +		}
> +	}
> +	/* Make sure integration time index is valid */
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	if (index == 0) {
> +		reg = 0x03;
> +		data->int_time_fac = 4;
> +	} else if (index == 1) {
> +		reg = 0x13;
> +		data->int_time_fac = 2;
> +	} else {
> +		reg = (index << 4) | 0x02;
> +		data->int_time_fac = 1;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RATE, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->int_time = itime;
> +
> +	return 0;
> +}
> +
> +static int ltrf216a_get_it_time(struct ltrf216a_data *data, int *val, int *val2)
> +{
> +	*val = 0;
> +	*val2 = data->int_time;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> +{
> +	int ret;
> +	int tries = 25;
> +	int val_0, val_1, val_2;
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & 0x08)
> +			break;
> +		msleep(20);
> +	}
> +
> +	val_0 = i2c_smbus_read_byte_data(data->client, addr);
> +	val_1 = i2c_smbus_read_byte_data(data->client, addr + 1);
> +	val_2 = i2c_smbus_read_byte_data(data->client, addr + 2);
> +	ret = (val_2 << 16) + (val_1 << 8) + val_0;
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata, lux;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +	if (greendata < 0 || cleardata < 0)
> +		lux = 0;
> +	else
> +		lux = greendata * 8 * WIN_FAC / data->als_gain_fac / data->int_time_fac / 10;
> +
> +	return lux;
> +}
> +
> +static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = ltrf216a_get_lux(data);
> +		*val = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = ltrf216a_get_it_time(data, val, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int ltrf216a_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +		mutex_lock(&data->mutex);
> +		ret = ltrf216a_set_it_time(data, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ltrf216a_info = {
> +	.read_raw	= ltrf216a_read_raw,
> +	.write_raw	= ltrf216a_write_raw,
> +	.attrs		= &ltrf216a_attribute_group,
> +};
> +
> +static int ltrf216a_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct ltrf216a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->info = &ltrf216a_info;
> +	indio_dev->name = LTRF216A_DRV_NAME;
> +	indio_dev->channels = ltrf216a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ltrf216a_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ltrf216a chip init failed\n");
> +		return ret;
> +	}
> +	data->int_time = 100000;
> +	data->int_time_fac = 1;
> +	data->als_gain_fac = 3;
> +
> +	ret = iio_device_register(indio_dev);

Use devm- function, assuming no issues with removal-steps (disable will
be before iio unregister).

> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to register iio dev\n");
> +		goto err_init;
> +	}
> +
> +	return 0;

Blank line.

> +err_init:
> +	ltrf216a_disable(indio_dev);
> +	return ret;
> +}
> +



Best regards,
Krzysztof
