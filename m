Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5946C24B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhLGSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbhLGSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:06:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4CEC061574;
        Tue,  7 Dec 2021 10:03:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bk14so132995oib.7;
        Tue, 07 Dec 2021 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=diTLKJamV/qQJE0OEkhCUuMGJU+i4EFAO3jEbEaLyBE=;
        b=EZ4Zxj9qGz42lymqHqmzAZqqih67+mnabTwlSK1+A3Rf2oV/Me0LG9EUo/yEkTxz/y
         ZcULX9w2LW6XdmoVIxAvYlSjIyPUacc9H1TEWdf+/WljE6UOal9haO3v9/a3hDHQLk3u
         VFlRdyLwWcWU2yEiYB+WuAmcj2oXoqLNURpRQ3jmm9BHhpja3gBvRXNzarRcNJ4UJEaY
         Wlfczgq+vLCMKV6LCfQlQ9n1t3KpdeNMvvTYX/PNsYndKhLgL5yosWy29wb4d+jJ4yz1
         qa4cFVgmeXywVO70mSvZCdy2EOaAnhCKGItFbdpNduJhp9QO8NqDBUZDhTo6fL3wBuxn
         v5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=diTLKJamV/qQJE0OEkhCUuMGJU+i4EFAO3jEbEaLyBE=;
        b=c8CWbRsHQXELqKc9V/eTZN20kDYZr3Mi/tBnLcAzgUSBIDOff9LSHkli8SfNbV2lLW
         sMX4LKLu1cSttnlKovm1NOtrLFwMaoFGoxHh70dO31WgazeK7KYNZYnnIDmbh/hoA4o2
         ZF4W53nzSqIvIQJ3SKzc7dKJ6Nr/68IGbp9x8KXdkJQwhCF8KD8vg6IYBRK8npYz/WIV
         qkBFy9OCoAPPn94FxTNdEZP4zk9JZYCGXV77eHjANMzTIkDblvNUJpV1zCBr3QOH2GxR
         XOVfeIjRAVCA1MmZCujPChkG/eV0R5FQtPGqo+cSEONpmF0H3TZ3NwMWf31vAL/WDVMf
         bxxw==
X-Gm-Message-State: AOAM532ZlJ+WP1faIkV8awskHZThNJI1JC3k8fvxCHMTndO5te0ELx+/
        hioUl21CKORwTQ4RgUOYA8Q=
X-Google-Smtp-Source: ABdhPJy1E6w/lnDaSv3MeyEElKBb1oxVjyRb0NrfUpP8UG2yS3ZVtyjBNWH8E3jfEkUpLS//hGY8zA==
X-Received: by 2002:aca:110e:: with SMTP id 14mr6630447oir.100.1638900207850;
        Tue, 07 Dec 2021 10:03:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm44661ota.76.2021.12.07.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:03:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Dec 2021 10:03:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Howard Chiu <howard10703049@gmail.com>
Cc:     jdelvare@suse.com, inux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Howard Chiu <howard.chiu@quantatw.com>
Subject: Re: [PATCH v1] hwmon: (pmbus) Add support for MPS Multi-phase mp5023
 controller
Message-ID: <20211207180325.GA1113534@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:43:25PM +0800, Howard Chiu wrote:
> Add support for mp5023 device from Monolithic Power Systems, Inc. (MPS)
> vendor. This is a Hot-Swap Controller.
> 
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>

The sending e-mail address needs to match Signed-off-by:.

Please fix the hwmon mailing list address in your next submission.

> ---
>  Documentation/hwmon/mp5023.rst | 80 ++++++++++++++++++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig    |  9 ++++
>  drivers/hwmon/pmbus/Makefile   |  1 +
>  drivers/hwmon/pmbus/mp5023.c   | 66 ++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+)
>  create mode 100644 Documentation/hwmon/mp5023.rst
>  create mode 100644 drivers/hwmon/pmbus/mp5023.c
> 
> diff --git a/Documentation/hwmon/mp5023.rst b/Documentation/hwmon/mp5023.rst
> new file mode 100644
> index 000000000000..b88506817406
> --- /dev/null
> +++ b/Documentation/hwmon/mp5023.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp5023
> +====================
> +
> +Supported chips:
> +
> +  * MPS MP5023
> +
> +    Prefix: 'mp5023'
> +

Please add a reference to the datasheet.

> +Author:
> +
> +	Howard Chiu <howard.chiu@quantatw.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP5023 Hot-Swap Controller.
> +
> +Device complaint with:
> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct format for reading input voltage, output voltage,
> +output current, input power and temperature.
> +
> +The driver exports the following attributes via the 'sysfs' files
> +for input voltage:
> +
> +**in1_input**
> +
> +**in1_label**
> +
> +**in1_max**
> +
> +**in1_max_alarm**
> +
> +**in1_min**
> +
> +**in1_min_alarm**
> +
> +The driver provides the next attributes for output voltage:

"provides the next attributes" is a bit odd. Do you mean
"provides the following attributes" ?

> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in2_alarm**
> +
> +The driver provides the next attributes for output current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +**curr1_alarm**
> +
> +**curr1_max**
> +
> +The driver provides the next attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power1_alarm**
> +
> +The driver provides the next attributes for temperature:
> +
> +**temp1_input**
> +
> +**temp1_max**
> +
> +**temp1_max_alarm**
> +
> +**temp1_crit**
> +
> +**temp1_crit_alarm**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index ffb609cee3a4..b56bd8542864 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -276,6 +276,15 @@ config SENSORS_MP2975
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp2975.
>  
> +config SENSORS_MP5023
> +	tristate "MPS MP5023"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP5023.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp5023.
> +
>  config SENSORS_PIM4328
>  	tristate "Flex PIM4328 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 0ed4d596a948..61cdc24b1309 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>  obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
> +obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
> diff --git a/drivers/hwmon/pmbus/mp5023.c b/drivers/hwmon/pmbus/mp5023.c
> new file mode 100644
> index 000000000000..2d2048c9765e
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp5023.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MPS MP5023 Hot-Swap Controller
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/of_device.h>

Aplhabeting include file order, please.

> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info mp5023_info = {
> +	.pages = 1,
> +
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +
> +	.m[PSC_VOLTAGE_IN] = 32,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 0,
> +	.m[PSC_VOLTAGE_OUT] = 32,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 0,
> +	.m[PSC_CURRENT_OUT] = 16,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.m[PSC_POWER] = 1,
> +	.b[PSC_POWER] = 0,
> +	.R[PSC_POWER] = 0,
> +	.m[PSC_TEMPERATURE] = 2,
> +	.b[PSC_TEMPERATURE] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +
> +	.func[0] =
> +		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int mp5023_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &mp5023_info);
> +}
> +
> +static const struct of_device_id __maybe_unused mp5023_of_match[] = {
> +	{ .compatible = "mps,mp5023", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, mp5023_of_match);
> +
> +static struct i2c_driver mp5023_driver = {
> +	.driver = {
> +		   .name = "mp5023",
> +		   .of_match_table = of_match_ptr(mp5023_of_match),
> +	},
> +	.probe_new = mp5023_probe,
> +};
> +
> +module_i2c_driver(mp5023_driver);
> +
> +MODULE_AUTHOR("Howard Chiu <howard.chiu@quantatw.com>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP5023 HSC");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
