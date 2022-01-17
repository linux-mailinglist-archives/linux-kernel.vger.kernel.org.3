Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD25A490D59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbiAQRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiAQRBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:01:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6BC06175F;
        Mon, 17 Jan 2022 09:01:20 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so3399498otu.0;
        Mon, 17 Jan 2022 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBGqX//gdJ9dDcyQcFJ1+S8K91sxfz9HwY6Hed4kq/8=;
        b=UuA1oVC7z1sbz8HicmtlVZV62sByxjLCTo9CbQOHcxdtu6HpNBJCU+o2whEj0xf2Yh
         Z8RFPYYPxkjhQOBbkfTBbpPs+H89H3vNmVzg3twiQ5KkHACvIS1ZHYbuO6X6oV5j7Xjy
         r0B1gKDITLihuf/j4+5ixn7Cot1a8CYN46wf6yL9YBahtumUR8yjlaCHaHNGFT6/ghsE
         XRpFGnWg/fEpCi2PILQFLleUoyvKogTGLY+AfoGQ6la6XzD0wefBNxtkFO3SdmNNbFkT
         WwgQ0pmmMgqbdRTw4Iw00urwSqYV2K9/j077tve73Hv7SyJ8x7359Tl7HmvwSmpyDV8I
         woug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBGqX//gdJ9dDcyQcFJ1+S8K91sxfz9HwY6Hed4kq/8=;
        b=b9N33F9KmgmrQbbvcx9EhGdjGvQdRYn+8XTIpKme9C/0OU5R2d3lj2GwCTESA5hxL3
         5GFIvOMrJmkeQ4jJmcUv3LA9/1InVN6M2OgmcOjGnWe5ZVS70RJzzzFac05AMb/r7NuP
         6+RQnArvd1pKAyZlA8n3ee6ilPdTdEZqCYghen5N5I0y4vo3O/VlKBxjUqF2LF+qzKuj
         x4UNXr+ahq+j0MmAx2stg3IAhWIyE1MXTT6GUqs9oRKMsr3oDgMYf8/TOOFpU+BvGyk2
         KbcTslVwmYE9kGaK9qjGgLPGGyelpWVeU9apWwuj9M+kNbihSuSfIJaa6V+ceqDC/WW+
         61jw==
X-Gm-Message-State: AOAM533qdLQuDYeQyfM+lKxjo9ED7xVQkQWkvcAg5th2DsFZBrHytjuF
        dFBz/9Vg4X0X0EXSEpjujEJWQz13qD4=
X-Google-Smtp-Source: ABdhPJwiKeQ2ObSK4DghQ2YRGrtrnfscg7tzal3Mq0R1vRT5apNN48kFo16NeVPWSdDVcSE2vLTThg==
X-Received: by 2002:a05:6830:1d47:: with SMTP id p7mr1755167oth.211.1642438879445;
        Mon, 17 Jan 2022 09:01:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12sm5140476otl.80.2022.01.17.09.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:01:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1642434222.git.sylv@sylv.io>
 <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 4/4] pmbus: Add support for bcm6123 Bus Converter
Message-ID: <c04086b8-7948-c1d9-56ee-e20455e8c92b@roeck-us.net>
Date:   Mon, 17 Jan 2022 09:01:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 8:12 AM, Marcello Sylvester Bauer wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> BCM6123 is an Fixed-Ratio DC-DC Converter.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>   drivers/hwmon/pmbus/Kconfig   |  9 ++++
>   drivers/hwmon/pmbus/Makefile  |  1 +
>   drivers/hwmon/pmbus/bcm6123.c | 90 +++++++++++++++++++++++++++++++++++

Documentation/hwmon/bcm6123 is missing.

>   3 files changed, 100 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/bcm6123.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index c96f7b7338bd..62dac90631c5 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -48,6 +48,15 @@ config SENSORS_ADM1275
>   	  This driver can also be built as a module. If so, the module will
>   	  be called adm1275.
>   
> +config SENSORS_BCM6123
> +	tristate "Vicor BCM6123 Compatible Power Supplies"

Is this a power supply or a chip ? It can't be both.

> +	help
> +	  If you say yes here you get hardware monitoring support for Vicor
> +	  BCM6123 Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called bcm6123.
> +
>   config SENSORS_BEL_PFE
>   	tristate "Bel PFE Compatible Power Supplies"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index e5935f70c9e0..2918c2ea7bc5 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>   obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>   obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>   obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
> +obj-$(CONFIG_SENSORS_BCM6123)	+= bcm6123.o
>   obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>   obj-$(CONFIG_SENSORS_BPA_RS600)	+= bpa-rs600.o
>   obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
> diff --git a/drivers/hwmon/pmbus/bcm6123.c b/drivers/hwmon/pmbus/bcm6123.c
> new file mode 100644
> index 000000000000..78fc259bc40f
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/bcm6123.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon bcm6123
> + *
Infineon ?

> + * Copyright (c) 2021 9elements GmbH
> + *
> + * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
> + * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
> + *

Does it not ? The datasheet doesn't say, and the code below doesn't match
this description.

> + * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
> + * this driver does not currently support them.

Does it ? There is no reference for this in the datasheet.

Overall it seems like there is a lot of cut-and-paste. Please clean this up.

> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_platform_data bcm6123_plat_data = {
> +	.flags = PMBUS_NO_CAPABILITY,
> +};

We should only set this flag if it is really needed.

> +
> +static struct pmbus_driver_info bcm6123_info = {
> +	.pages = 2,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_IN] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.m[PSC_VOLTAGE_IN] = 1,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 1,
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 1,
> +	.m[PSC_CURRENT_IN] = 1,
> +	.b[PSC_CURRENT_IN] = 0,
> +	.R[PSC_CURRENT_IN] = 3,
> +	.m[PSC_CURRENT_OUT] = 1,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 2,
> +	.func[0] = 0, /* Summing page without voltage readings */

This needs further explanation. The public datasheet doesn't say anything
about multiple pages, and it doesn't really make much sense to have an
"empty" page with no information in it.

> +	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +	    | PMBUS_HAVE_IIN | PMBUS_HAVE_POUT,
> +};
> +
> +static int bcm6123_probe(struct i2c_client *client)
> +{
> +	client->dev.platform_data = &bcm6123_plat_data;
> +
> +	return pmbus_do_probe(client, &bcm6123_info);
> +}
> +
> +static const struct i2c_device_id bcm6123_id[] = {
> +	{"bcm6123", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bcm6123_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id bcm6123_of_match[] = {
> +	{ .compatible = "vicor,bcm6123" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm6123_of_match);
> +#endif
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver bcm6123_driver = {
> +	.driver = {
> +		   .name = "bcm6123",
> +		   .of_match_table = of_match_ptr(bcm6123_of_match),
> +		   },
> +	.probe_new = bcm6123_probe,
> +	.id_table = bcm6123_id,
> +};
> +
> +module_i2c_driver(bcm6123_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("PMBus driver for Vicor bcm6123");
> +MODULE_LICENSE("GPL");
> 

