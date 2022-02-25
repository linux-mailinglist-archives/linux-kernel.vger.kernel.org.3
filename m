Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1804C440F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiBYL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiBYL6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:58:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7920DB04
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645790285; x=1677326285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jb575qz92N0qttgR0m4lb4u9YIyF2WnFBvxZuO6zb3s=;
  b=MqjQwFkby8RD0prnmO3IcnFfxjhrusqfO0hVPDUNZ1WybDpf3eL7lr6P
   7TH39miEz0EOOgFIBSTmO330nD0dsB8XV8Dy9XT7QSG5g2vCIiK3eHNzg
   +lnCAzyaGhpj5O2u6U2P9+FjJbpwp/Hfs+vg/Zoipjd/I5g+JUG4klGnq
   MAp3t3qzZS6SrS4T8081YQyYRM0SGyJZ5wkase4LhdM3+LbpRgudKebcm
   2bJe8KFC+2NV6TRg+Ze5F3wSZhmXwgPAKjo9lDTyc9f8r2c9MNasrLVxS
   Avq6L7RiMPjH/amA1fyXQ/uZsFVACrvHdjgyZGzIXXJfWhr8DhEzCmuFZ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="150004062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 04:57:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 04:57:54 -0700
Received: from [10.12.72.56] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 04:57:49 -0700
Message-ID: <11bad796-94b8-6b3c-92df-40da19f9eadd@microchip.com>
Date:   Fri, 25 Feb 2022 12:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/1] soc: add microchip polarfire soc system controller
Content-Language: en-US
To:     <conor.dooley@microchip.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <arnd@arndb.de>,
        <olof@lixom.net>, <linux-riscv@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <cyril.jean@microchip.com>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <jassisinghbrar@gmail.com>, <j.neuschaefer@gmx.net>,
        <sfr@canb.auug.org.au>, <damien.lemoal@wdc.com>,
        <atishp@atishpatra.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220217101349.2374873-1-conor.dooley@microchip.com>
 <20220217101349.2374873-2-conor.dooley@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220217101349.2374873-2-conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 at 11:13, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> This driver provides an interface for other drivers to access the
> functions of the system controller on the Microchip PolarFire SoC.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

It looks okay to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

As agreed with Conor, I queue it in my at91-soc branch for 5.18 which 
will be reached via arm-soc.

Best regards,
   Nicolas

> ---
>   drivers/soc/Kconfig                         |   1 +
>   drivers/soc/Makefile                        |   1 +
>   drivers/soc/microchip/Kconfig               |  10 +
>   drivers/soc/microchip/Makefile              |   1 +
>   drivers/soc/microchip/mpfs-sys-controller.c | 194 ++++++++++++++++++++
>   include/soc/microchip/mpfs.h                |   4 +-
>   6 files changed, 209 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/soc/microchip/Kconfig
>   create mode 100644 drivers/soc/microchip/Makefile
>   create mode 100644 drivers/soc/microchip/mpfs-sys-controller.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index a8562678c437..c5aae42673d3 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -13,6 +13,7 @@ source "drivers/soc/imx/Kconfig"
>   source "drivers/soc/ixp4xx/Kconfig"
>   source "drivers/soc/litex/Kconfig"
>   source "drivers/soc/mediatek/Kconfig"
> +source "drivers/soc/microchip/Kconfig"
>   source "drivers/soc/qcom/Kconfig"
>   source "drivers/soc/renesas/Kconfig"
>   source "drivers/soc/rockchip/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index adb30c2d4fea..904eec2a7871 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -18,6 +18,7 @@ obj-y				+= ixp4xx/
>   obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>   obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
>   obj-y				+= mediatek/
> +obj-y				+= microchip/
>   obj-y				+= amlogic/
>   obj-y				+= qcom/
>   obj-y				+= renesas/
> diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
> new file mode 100644
> index 000000000000..eb656b33156b
> --- /dev/null
> +++ b/drivers/soc/microchip/Kconfig
> @@ -0,0 +1,10 @@
> +config POLARFIRE_SOC_SYS_CTRL
> +	tristate "POLARFIRE_SOC_SYS_CTRL"
> +	depends on POLARFIRE_SOC_MAILBOX
> +	help
> +	  This driver adds support for the PolarFire SoC (MPFS) system controller.
> +
> +	  To compile this driver as a module, choose M here. the
> +	  module will be called mpfs_system_controller.
> +
> +	  If unsure, say N.
> diff --git a/drivers/soc/microchip/Makefile b/drivers/soc/microchip/Makefile
> new file mode 100644
> index 000000000000..14489919fe4b
> --- /dev/null
> +++ b/drivers/soc/microchip/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_POLARFIRE_SOC_SYS_CTRL)	+= mpfs-sys-controller.o
> diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
> new file mode 100644
> index 000000000000..2f4535929762
> --- /dev/null
> +++ b/drivers/soc/microchip/mpfs-sys-controller.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip PolarFire SoC (MPFS) system controller driver
> + *
> + * Copyright (c) 2020-2021 Microchip Corporation. All rights reserved.
> + *
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/platform_device.h>
> +#include <soc/microchip/mpfs.h>
> +
> +static DEFINE_MUTEX(transaction_lock);
> +
> +struct mpfs_sys_controller {
> +	struct mbox_client client;
> +	struct mbox_chan *chan;
> +	struct completion c;
> +	struct kref consumers;
> +};
> +
> +int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct mpfs_mss_msg *msg)
> +{
> +	int ret, err;
> +
> +	err = mutex_lock_interruptible(&transaction_lock);
> +	if (err)
> +		return err;
> +
> +	reinit_completion(&sys_controller->c);
> +
> +	ret = mbox_send_message(sys_controller->chan, msg);
> +	if (ret >= 0) {
> +		if (wait_for_completion_timeout(&sys_controller->c, HZ)) {
> +			ret = 0;
> +		} else {
> +			ret = -ETIMEDOUT;
> +			dev_warn(sys_controller->client.dev,
> +				 "MPFS sys controller transaction timeout\n");
> +		}
> +	} else {
> +		dev_err(sys_controller->client.dev,
> +			"mpfs sys controller transaction returned %d\n", ret);
> +	}
> +
> +	mutex_unlock(&transaction_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(mpfs_blocking_transaction);
> +
> +static void rx_callback(struct mbox_client *client, void *msg)
> +{
> +	struct mpfs_sys_controller *sys_controller =
> +		container_of(client, struct mpfs_sys_controller, client);
> +
> +	complete(&sys_controller->c);
> +}
> +
> +static void mpfs_sys_controller_delete(struct kref *kref)
> +{
> +	struct mpfs_sys_controller *sys_controller = container_of(kref, struct mpfs_sys_controller,
> +					       consumers);
> +
> +	mbox_free_channel(sys_controller->chan);
> +	kfree(sys_controller);
> +}
> +
> +void mpfs_sys_controller_put(void *data)
> +{
> +	struct mpfs_sys_controller *sys_controller = data;
> +
> +	kref_put(&sys_controller->consumers, mpfs_sys_controller_delete);
> +}
> +EXPORT_SYMBOL(mpfs_sys_controller_put);
> +
> +static struct platform_device subdevs[] = {
> +	{
> +		.name		= "mpfs-rng",
> +		.id		= -1,
> +	},
> +	{
> +		.name		= "mpfs-generic-service",
> +		.id		= -1,
> +	}
> +};
> +
> +static int mpfs_sys_controller_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mpfs_sys_controller *sys_controller;
> +	int i;
> +
> +	sys_controller = devm_kzalloc(dev, sizeof(*sys_controller), GFP_KERNEL);
> +	if (!sys_controller)
> +		return -ENOMEM;
> +
> +	sys_controller->client.dev = dev;
> +	sys_controller->client.rx_callback = rx_callback;
> +	sys_controller->client.tx_block = 1U;
> +
> +	sys_controller->chan = mbox_request_channel(&sys_controller->client, 0);
> +	if (IS_ERR(sys_controller->chan))
> +		return dev_err_probe(dev, PTR_ERR(sys_controller->chan),
> +				     "Failed to get mbox channel\n");
> +
> +	init_completion(&sys_controller->c);
> +	kref_init(&sys_controller->consumers);
> +
> +	platform_set_drvdata(pdev, sys_controller);
> +
> +	dev_info(&pdev->dev, "Registered MPFS system controller\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(subdevs); i++) {
> +		subdevs[i].dev.parent = dev;
> +		if (platform_device_register(&subdevs[i]))
> +			dev_warn(dev, "Error registering sub device %s\n", subdevs[i].name);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpfs_sys_controller_remove(struct platform_device *pdev)
> +{
> +	struct mpfs_sys_controller *sys_controller = platform_get_drvdata(pdev);
> +
> +	mpfs_sys_controller_put(sys_controller);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpfs_sys_controller_of_match[] = {
> +	{.compatible = "microchip,mpfs-sys-controller", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpfs_sys_controller_of_match);
> +
> +struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev)
> +{
> +	const struct of_device_id *match;
> +	struct mpfs_sys_controller *sys_controller;
> +	int ret;
> +
> +	if (!dev->parent)
> +		goto err_no_device;
> +
> +	match = of_match_node(mpfs_sys_controller_of_match,  dev->parent->of_node);
> +	of_node_put(dev->parent->of_node);
> +	if (!match)
> +		goto err_no_device;
> +
> +	sys_controller = dev_get_drvdata(dev->parent);
> +	if (!sys_controller)
> +		goto err_bad_device;
> +
> +	if (!kref_get_unless_zero(&sys_controller->consumers))
> +		goto err_bad_device;
> +
> +	ret = devm_add_action_or_reset(dev, mpfs_sys_controller_put, sys_controller);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return sys_controller;
> +
> +err_no_device:
> +	dev_dbg(dev, "Parent device was not an MPFS system controller\n");
> +	return ERR_PTR(-ENODEV);
> +
> +err_bad_device:
> +	dev_dbg(dev, "MPFS system controller found but could not register as a sub device\n");
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL(mpfs_sys_controller_get);
> +
> +static struct platform_driver mpfs_sys_controller_driver = {
> +	.driver = {
> +		.name = "mpfs-sys-controller",
> +		.of_match_table = mpfs_sys_controller_of_match,
> +	},
> +	.probe = mpfs_sys_controller_probe,
> +	.remove = mpfs_sys_controller_remove,
> +};
> +module_platform_driver(mpfs_sys_controller_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_DESCRIPTION("MPFS system controller driver");
> diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
> index 2b64c95f3be5..6466515262bd 100644
> --- a/include/soc/microchip/mpfs.h
> +++ b/include/soc/microchip/mpfs.h
> @@ -34,9 +34,9 @@ struct mpfs_mss_response {
>   
>   #if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL)
>   
> -int mpfs_blocking_transaction(struct mpfs_sys_controller *mpfs_client, void *msg);
> +int mpfs_blocking_transaction(struct mpfs_sys_controller *mpfs_client, struct mpfs_mss_msg *msg);
>   
> -struct mpfs_sys_controller *mpfs_sys_controller_get(struct device_node *mailbox_node);
> +struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev);
>   
>   #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
>   


-- 
Nicolas Ferre
