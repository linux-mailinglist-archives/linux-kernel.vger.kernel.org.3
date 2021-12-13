Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B3472BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhLMLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhLMLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639396192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nytQ3XGWUUVQVtpkayZJTh+TZeEvJFpZ6zVUjnASMNk=;
        b=QRtPfdz0ipdjtytJ0x90cZXzEldMkSAjLN1lsMmgrVv936ZjTSIwy4UerLVPfoRL8/QJY5
        xA+M9IdDJk3qiLNX0NxxiAtyfjtYBkRn0T2QPHcPNnEXsOnk1wm3eM29rWB9N9O2yMcVqs
        Oj3+pueT+YWdF3ibB43YGSVYqQhrOkk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-x3zzc3d_Mp66ZKLXS2x11A-1; Mon, 13 Dec 2021 06:49:50 -0500
X-MC-Unique: x3zzc3d_Mp66ZKLXS2x11A-1
Received: by mail-wr1-f69.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso3782744wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nytQ3XGWUUVQVtpkayZJTh+TZeEvJFpZ6zVUjnASMNk=;
        b=mlD7oTAunKLLrZ4b9I/Bl5erFJkGH003s1vCibznQ5DNXPepGaTSbHrxr76FeXdd18
         D3suqlVgDFZ2xta2f0KuyYO4VsimDajT3KkHaXFAQCqvUJ944EMyBClUMlydRpnsNSuJ
         qcC7GtabhXDTxdJ6PnFFHPrvrHfuWi5sTH3WkYRzw2D3b6Qn2bH+DzBiVAx/1wbAgrYh
         ukDgPMBdrTwWg+FUx8uqPLDmcDDfZvrne/MBS8LuD0UTy72vNnSSgjky9lJskWexg8+f
         S4hcsROxuXNQQ2/br+oxZoePvGeBbDAIqd6mw2kIzZ/qVcLJOrYvPLyfmy1lQL7ntyUp
         SQcQ==
X-Gm-Message-State: AOAM532yNh+obmLwzpojh8VIRSetTSruTW3HVM1qpGwQejAUnquPLhM2
        F3RMYfxN6xt0hbVd4+10gRQtULbsAVybMHMYoRRAhLBRGjT4DyJnw7+QB7SBPrdCpNIZJbSBYUS
        /ZxJPhfHJav6b138VvP9iAvS2
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr37144145wmq.191.1639396189663;
        Mon, 13 Dec 2021 03:49:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQx8LjMUq1dveGizpuS1Rkcu+5ss+2hmlwejMnBfOtHB1fRlxHTTMUI27O9z6kliF3EOBBSw==
X-Received: by 2002:a05:600c:a55:: with SMTP id c21mr37144123wmq.191.1639396189418;
        Mon, 13 Dec 2021 03:49:49 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h13sm10761264wrx.82.2021.12.13.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:49:48 -0800 (PST)
Message-ID: <8d84916cbebfdbd4db268b501e1c8adc247d1331.camel@redhat.com>
Subject: Re: [PATCH V5 1/6] drivers/mfd: sensehat: Raspberry Pi Sense HAT
 core driver
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Mon, 13 Dec 2021 12:49:48 +0100
In-Reply-To: <20211210221033.912430-2-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
         <20211210221033.912430-2-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Fri, 2021-12-10 at 17:10 -0500, Charles Mirabile wrote:
> This patch adds the core driver file, containing the regmap configuration
> needed to communicate with the board over I2C. We also add the header
> file shared by all three drivers, containing common data and definitions.
> In addition, we add a config option to toggle compilation of the driver.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  drivers/mfd/Kconfig          |   8 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/sensehat-core.c  | 157 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sensehat.h |  51 ++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 drivers/mfd/sensehat-core.c
>  create mode 100644 include/linux/mfd/sensehat.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3fb480818599..e6de22f98c0e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -11,6 +11,14 @@ config MFD_CORE
>  	select IRQ_DOMAIN
>  	default n
>  
> +config MFD_SENSEHAT_CORE
> +	tristate "Raspberry Pi Sense HAT core functions"
> +	depends on I2C
> +	select MFD_CORE
> +	help
> +	  This is the core driver for the Raspberry Pi Sense HAT. This provides
> +	  the necessary functions to communicate with the hardware.
> +
>  config MFD_CS5535
>  	tristate "AMD CS5535 and CS5536 southbridge core functions"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0b1b629aef3e..2b012e3d497d 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> +obj-$(CONFIG_MFD_SENSEHAT_CORE) += sensehat-core.o
>  obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>  obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
> diff --git a/drivers/mfd/sensehat-core.c b/drivers/mfd/sensehat-core.c
> new file mode 100644
> index 000000000000..c5b6f4648d88
> --- /dev/null
> +++ b/drivers/mfd/sensehat-core.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT core driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * This driver is based on wm8350 implementation and was refactored to use the
> + * misc device subsystem rather than the deprecated framebuffer subsystem.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/sensehat.h>
> +
> +#define SENSEHAT_WAI 0xF0
> +#define SENSEHAT_VER 0xF1
> +
> +#define SENSEHAT_ID 's'
> +
> +static struct platform_device *
> +sensehat_client_dev_register(struct sensehat *sensehat, const char *name);
> +
> +static struct regmap_config sensehat_config;
> +
> +static int sensehat_probe(struct i2c_client *i2c,
> +			  const struct i2c_device_id *id)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	struct sensehat *sensehat =
> +		devm_kzalloc(&i2c->dev, sizeof(*sensehat), GFP_KERNEL);
> +
> +	if (!sensehat)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, sensehat);
> +	sensehat->dev = &i2c->dev;
> +	sensehat->i2c_client = i2c;
> +
> +	sensehat->regmap =
> +		devm_regmap_init_i2c(sensehat->i2c_client, &sensehat_config);
> +
> +	if (IS_ERR(sensehat->regmap)) {
> +		dev_err(sensehat->dev, "Failed to initialize sensehat regmap");
> +		return PTR_ERR(sensehat->regmap);
> +	}
> +
> +	ret = regmap_read(sensehat->regmap, SENSEHAT_WAI, &reg);
> +	if (ret < 0) {
> +		dev_err(sensehat->dev, "failed to read from device");
> +		return ret;
> +	}
> +
> +	if (reg != SENSEHAT_ID) {
> +		dev_err(sensehat->dev, "expected device ID %i, got %i",
> +			SENSEHAT_ID, ret);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(sensehat->regmap, SENSEHAT_VER, &reg);
> +	if (ret < 0) {
> +		dev_err(sensehat->dev,
> +			"Unable to get sensehat firmware version");
> +		return ret;
> +	}
> +
> +	dev_info(sensehat->dev, "Raspberry Pi Sense HAT firmware version %i\n",
> +		 reg);

I think both these sections and sensehat_client_dev_register() could be avoided
with a properly configured struct mfd_cell and a call to
devm_mfd_add_devices(). Actually, you're not making use of the mfd subsystem at
all in this driver, which is odd. For an example see 'drivers/mfd/mp2629.c'.

It's easy to get all these device registration operations wrong, so it's always
perfered to use the subsytem facilities when available.

> +
> +#ifdef CONFIG_JOYSTICK_SENSEHAT
> +	sensehat->joystick.pdev =
> +		sensehat_client_dev_register(sensehat, "sensehat-joystick");
> +
> +	if (IS_ERR(sensehat->joystick.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-joystick");
> +		return PTR_ERR(sensehat->joystick.pdev);
> +	}
> +#endif
> +#ifdef CONFIG_SENSEHAT_DISPLAY
> +
> +	sensehat->display.pdev =
> +		sensehat_client_dev_register(sensehat, "sensehat-display");
> +
> +	if (IS_ERR(sensehat->display.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-display");
> +		return PTR_ERR(sensehat->display.pdev);
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static struct platform_device *
> +sensehat_client_dev_register(struct sensehat *sensehat, const char *name)
> +{
> +	long ret = -ENOMEM;
> +	struct platform_device *pdev =
> +		platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> +
> +	if (!pdev)
> +		goto alloc_fail;
> +
> +	pdev->dev.parent = sensehat->dev;
> +	platform_set_drvdata(pdev, sensehat);
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto add_fail;
> +
> +	ret = devm_add_action_or_reset(
> +		sensehat->dev, (void *)platform_device_unregister, pdev);
> +	if (ret)
> +		goto alloc_fail;
> +
> +	return pdev;
> +
> +add_fail:
> +	platform_device_put(pdev);
> +alloc_fail:
> +	return ERR_PTR(ret);
> +}
> +
> +static struct regmap_config sensehat_config = {
> +	.name = "sensehat",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static const struct i2c_device_id sensehat_i2c_id[] = {
> +	{ .name = "sensehat" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, sensehat_i2c_id);
> +
> +static struct i2c_driver sensehat_driver = {
> +	.driver = { .name = "sensehat" },
> +	.probe = sensehat_probe,
> +	.id_table = sensehat_i2c_id,
> +};
> +
> +module_i2c_driver(sensehat_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT core driver");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
> +MODULE_LICENSE("GPL");

-- 
Nicolás Sáenz

