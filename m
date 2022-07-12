Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917115714BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiGLIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGLIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:35:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB632A942;
        Tue, 12 Jul 2022 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657614950; x=1689150950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMMOHSQnt4pXL7Lap1dzPhshjD8QGIMdroMSwJ1d4Sc=;
  b=ZoQkUlP9Rs0KcsUYsb4ZTjnvo7fwXSP3609ohi7HClyY7/WKTMAEYNuk
   S9fJwcYSS8OGYxVz7hJMgegeAVRG+W+PR4tLd9M1sMWIdmN+tqJLvMYpQ
   OLSTyZ1iZyi+i2SmEhokOQfcYDmV3mMJai4+/wP0GlLger9ZkwLVaW4bo
   L7tR1uCkFwZ6zCCs1x61DSDxA/s9SzsS3NS81cdE7kdU5MwRlEZ+nnb4m
   fgBxdA69ILO5M6M5soJQmX6Ft9G4igxtSd+YFJrbbrlXUMPxUVrfHXeKN
   zoDx22+Q7s64AsG7S5Ujw1YeOZjTgX7U7GwKxGwc2zFaLHQ2FjkEi7DDF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348851804"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="348851804"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="737403368"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Jul 2022 01:35:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Jul 2022 11:35:45 +0300
Date:   Tue, 12 Jul 2022 11:35:45 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
Subject: Re: [PATCH v2 2/4] usb: typec: ucsi: stm32g0: add support for
 stm32g0 i2c controller
Message-ID: <Ys0yYSqcJC4eJ/8A@kuha.fi.intel.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
 <20220711120122.25804-3-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711120122.25804-3-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 11, 2022 at 02:01:20PM +0200, Fabrice Gasnier kirjoitti:
> STM32G0 provides an integrated USB Type-C and power delivery interface.
> It can be programmed with a firmware to handle UCSI protocol over I2C
> interface. A GPIO is used as an interrupt line.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> Christophe's remarks:
> - use kmalloc instead of kzalloc
> - Use-after-free of buf: directly print the offset
> ---
>  drivers/usb/typec/ucsi/Kconfig        |  10 ++
>  drivers/usb/typec/ucsi/Makefile       |   1 +
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 218 ++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 drivers/usb/typec/ucsi/ucsi_stm32g0.c
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 5e9b37b3f25e1..8f9c4b9f31f79 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -48,4 +48,14 @@ config UCSI_ACPI
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_acpi
>  
> +config UCSI_STM32G0
> +	tristate "UCSI Interface Driver for STM32G0"
> +	depends on I2C
> +	help
> +	  This driver enables UCSI support on platforms that expose a STM32G0
> +	  Type-C controller over I2C interface.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_stm32g0.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index 8a8eb5cb8e0f0..480d533d762fe 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -17,3 +17,4 @@ endif
>  
>  obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
>  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
> +obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> new file mode 100644
> index 0000000000000..bb5271bf7cdcf
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +/*
> + * UCSI driver for STMicroelectronics STM32G0 Type-C PD controller
> + *
> + * Copyright (C) 2022, STMicroelectronics - All Rights Reserved
> + * Author: Fabrice Gasnier <fabrice.gasnier@foss.st.com>.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "ucsi.h"
> +
> +struct ucsi_stm32g0 {
> +	struct i2c_client *client;
> +	struct completion complete;
> +	struct device *dev;
> +	unsigned long flags;
> +	struct ucsi *ucsi;
> +};
> +
> +static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t len)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->client;
> +	u8 reg = offset;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = 0,
> +			.len	= 1,
> +			.buf	= &reg,
> +		},
> +		{
> +			.addr	= client->addr,
> +			.flags  = I2C_M_RD,
> +			.len	= len,
> +			.buf	= val,
> +		},
> +	};
> +	int ret;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c read %02x, %02x error: %d\n", client->addr, reg, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
> +				    size_t len)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->client;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = 0,
> +		}
> +	};
> +	unsigned char *buf;
> +	int ret;
> +
> +	buf = kmalloc(len + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = offset;
> +	memcpy(&buf[1], val, len);
> +	msg[0].len = len + 1;
> +	msg[0].buf = buf;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	kfree(buf);
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c write %02x, %02x error: %d\n", client->addr, offset, ret);
> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const void *val,
> +				   size_t len)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	set_bit(COMMAND_PENDING, &g0->flags);
> +
> +	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
> +	if (ret)
> +		goto out_clear_bit;
> +
> +	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
> +		ret = -ETIMEDOUT;
> +
> +out_clear_bit:
> +	clear_bit(COMMAND_PENDING, &g0->flags);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
> +{
> +	struct ucsi_stm32g0 *g0 = data;
> +	u32 cci;
> +	int ret;
> +
> +	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (UCSI_CCI_CONNECTOR(cci))
> +		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
> +
> +	if (test_bit(COMMAND_PENDING, &g0->flags) &&
> +	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
> +		complete(&g0->complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct ucsi_operations ucsi_stm32g0_ops = {
> +	.read = ucsi_stm32g0_read,
> +	.sync_write = ucsi_stm32g0_sync_write,
> +	.async_write = ucsi_stm32g0_async_write,
> +};
> +
> +static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ucsi_stm32g0 *g0;
> +	int ret;
> +
> +	g0 = devm_kzalloc(dev, sizeof(*g0), GFP_KERNEL);
> +	if (!g0)
> +		return -ENOMEM;
> +
> +	g0->dev = dev;
> +	g0->client = client;
> +	init_completion(&g0->complete);
> +	i2c_set_clientdata(client, g0);
> +
> +	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
> +	if (IS_ERR(g0->ucsi))
> +		return PTR_ERR(g0->ucsi);
> +
> +	ucsi_set_drvdata(g0->ucsi, g0);
> +
> +	/* Request alert interrupt */
> +	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
> +				   dev_name(&client->dev), g0);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "request IRQ failed\n");
> +		goto destroy;
> +	}
> +
> +	ret = ucsi_register(g0->ucsi);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "ucsi_register failed\n");
> +		goto freeirq;
> +	}
> +
> +	return 0;
> +
> +freeirq:
> +	free_irq(client->irq, g0);
> +destroy:
> +	ucsi_destroy(g0->ucsi);
> +
> +	return ret;
> +}
> +
> +static int ucsi_stm32g0_remove(struct i2c_client *client)
> +{
> +	struct ucsi_stm32g0 *g0 = i2c_get_clientdata(client);
> +
> +	ucsi_unregister(g0->ucsi);
> +	free_irq(client->irq, g0);
> +	ucsi_destroy(g0->ucsi);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused ucsi_stm32g0_typec_of_match[] = {
> +	{ .compatible = "st,stm32g0-typec" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ucsi_stm32g0_typec_of_match);
> +
> +static const struct i2c_device_id ucsi_stm32g0_typec_i2c_devid[] = {
> +	{"stm32g0-typec", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ucsi_stm32g0_typec_i2c_devid);
> +
> +static struct i2c_driver ucsi_stm32g0_i2c_driver = {
> +	.driver = {
> +		.name = "ucsi-stm32g0-i2c",
> +		.of_match_table = of_match_ptr(ucsi_stm32g0_typec_of_match),
> +	},
> +	.probe = ucsi_stm32g0_probe,
> +	.remove = ucsi_stm32g0_remove,
> +	.id_table = ucsi_stm32g0_typec_i2c_devid
> +};
> +module_i2c_driver(ucsi_stm32g0_i2c_driver);
> +
> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@foss.st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32G0 Type-C controller");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("platform:ucsi-stm32g0");
> -- 
> 2.25.1

-- 
heikki
