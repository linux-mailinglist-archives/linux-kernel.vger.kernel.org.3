Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA452588D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359570AbiELXkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359559AbiELXkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:40:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C541116B;
        Thu, 12 May 2022 16:40:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so11815301lfb.0;
        Thu, 12 May 2022 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LDeSEeG6sYN/4I8BLWwVYheQ8YlAvLVklfd9fc7g84c=;
        b=l3OJo2qhUsCbaOlrSzfbmQJJYanAByxF2plXQtkDybX8/5nwgM0xdtjBY2suhls6as
         Ap1Yo00IreihXYoc6JR4QjfeyyeJGnWaoazVyCLYZ5Lbo+9JSv4oRMbVhgGShG2kqzEy
         tycAx7k9t1c5KCOUk3tpquMF9Kwk11Bx/H2bwLnRHaxqf0uCihqZcn0tgqE+SrL1I6Qh
         CAeOLylleLsOjDHXBOTunDICcemQkXNbYFqSgVd9OMVIh+x7bKwTlGzcHCxygszwsCs2
         lm89hyiAXWNiYHSoGHz2Zt+HDWZe0pvW67nLskHwCqgjdw8oMjow2CeA2lGjSCSKCtI5
         No4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LDeSEeG6sYN/4I8BLWwVYheQ8YlAvLVklfd9fc7g84c=;
        b=0FtkXK3nz4i2QCC0VSPpn02NFULUaVfuESKOk8klPaODhAZs3R2FCK7pxHIkAIS8VZ
         WgFwQ7UOpFsysgmkpobfTdIhrWCmSg04YwU0geiQ6OIYmT5oP80BE8nx1fZH9hMPb83D
         crwsqng2+L7gZqc9csY9n9P8Gs75AsesE8do7YOggUD+b8S3O52NzlIP8hHTJa9tq4od
         SaMUFETQIeZzG9s5QtDnZqR4pEYcYlTL7JrnyhGlNuRZ+fnAnBiVowB5iGGvA5McTK+d
         QZmQxkhIHy3rbyTSJ6LrqKg3refjaG8zEn1NpXdzPkq0g9R6tolUIDEcgZPHGPaaoIbm
         MUIw==
X-Gm-Message-State: AOAM5327PIglWdXc5A/Ggx+PJz+H7yNHtUXMP/HmBgHCEIRyD+C7he4I
        9WoUqUZo/xP2s8x3Z2erBTgLz7XVQ2o=
X-Google-Smtp-Source: ABdhPJyVbbw6czcCKG1dstVn1KQi46G5k084v/U00v3ld5aEAkn+ZmEgHbKxtLbiiJwO0FhVf/PCWQ==
X-Received: by 2002:a05:6512:acb:b0:473:c2ad:efe5 with SMTP id n11-20020a0565120acb00b00473c2adefe5mr1453355lfu.290.1652398842909;
        Thu, 12 May 2022 16:40:42 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id h16-20020a05651211d000b0047255d2116dsm132208lfr.156.2022.05.12.16.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:40:42 -0700 (PDT)
Message-ID: <57bfc915-c761-3ba4-93d0-776f9b5f93b3@gmail.com>
Date:   Fri, 13 May 2022 02:40:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220511094024.175994-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shreeya,

...
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>

You may safely remove these includes because module.h always provides them.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/iio/iio.h>
> +#include <asm/unaligned.h>
> +
> +#define LTRF216A_DRV_NAME "ltrf216a"

This define doesn't bring much benefits, you may use "ltrf216a" directly
in the code.

> +#define LTRF216A_MAIN_CTRL		0x00
> +
> +#define LTRF216A_ALS_DATA_STATUS	BIT(3)
> +#define LTRF216A_ALS_ENABLE_MASK	BIT(1)
> +
> +#define LTRF216A_ALS_MEAS_RES		0x04
> +#define LTRF216A_MAIN_STATUS		0x07
> +#define LTRF216A_CLEAR_DATA_0		0x0A
> +

Is any reason for separating these regs with a newline? If no, then you
may remove this newline.

> +#define LTRF216A_ALS_DATA_0		0x0D
> +

...
> +struct ltrf216a_data {
> +	struct i2c_client *client;
> +	u32 int_time;
> +	u16 int_time_fac;
> +	u8 als_gain_fac;
> +	/*
> +	 * Ensure cached value of integration time is consistent
> +	 * with hardware setting and remains constant during a
> +	 * measurement of Lux.
> +	 */
> +	struct mutex mutex;

I'd rename the "mutex" -> "lock".

> +};
> +
> +/* open air. need to update based on TP transmission rate. */
> +#define WIN_FAC	1

Usually all defines are placed before the code. You may move this define
before struct ltrf216a_data.

...
> +static int ltrf216a_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);

Reverse Xmas tree is a common coding style in kernel for the function
variables.

******
****
**

Will be great if you could use the same coding style everywhere in this
source file, i.e. like this:

struct ltrf216a_data *data = iio_priv(indio_dev);
int ret;

> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	/* enable sensor */
> +	ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");

This message doesn't tell us the error code, which usually is very handy
to know.

I'd also change all the error messages in this driver to tell which
action failed, like this:

dev_err(dev, "Failed to enable sensor: %d\n", ret);

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

Please add error code to the message here too and reword it. This is
exactly the same error message as in ltrf216a_init(), so you can't
distinguish whether it's enabling or disabling that failed.

> +	return ret;
> +}
> +
> +static void als_ltrf216a_disable(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	ltrf216a_disable(indio_dev);
> +}
> +
> +static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
> +{
> +	int i, ret, index = -1;
> +	u8 reg_val;
> +
> +	for (i = 0; i < ARRAY_SIZE(ltrf216a_int_time_available); i++) {
> +		if (ltrf216a_int_time_available[i][1] == itime) {
> +			index = i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	reg_val = ltrf216a_int_time_reg[index][1];
> +	data->int_time_fac = ltrf216a_int_time_reg[index][0];
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
> +	if (ret < 0)
> +		return ret;

Won't hurt to add error message here for consistency.

> +	data->int_time = itime;
> +
> +	return 0;
> +}
> +
> +static int ltrf216a_get_int_time(struct ltrf216a_data *data, int *val, int *val2)
> +{
> +	*val = 0;
> +	*val2 = data->int_time;
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> +{
> +	int ret = -1, tries = 25;

No need to initialize the ret variable.

> +	u8 buf[3];
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
> +		if (ret < 0)
> +			return ret;

Need error message

> +		if (ret & LTRF216A_ALS_DATA_STATUS)
> +			break;
> +		msleep(20);
> +	}
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client, addr, sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;

Same here

..
> +MODULE_AUTHOR("Shi Zhigang <Zhigang.Shi@liteon.com>");

Driver could have multiple MODULE_AUTHOR(), you may add yourself here:

MODULE_AUTHOR("Shreeya Patel <shreeya.patel@collabora.com>")
