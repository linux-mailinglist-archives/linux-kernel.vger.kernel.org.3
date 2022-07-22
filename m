Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6457E2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiGVOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGVOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:19:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE9A6FBB;
        Fri, 22 Jul 2022 07:19:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c6so608041plc.5;
        Fri, 22 Jul 2022 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T1q/5UEvjKnmrGkeFgZRytr5DU5kdabjES1IFoO/gqw=;
        b=N5b2E48s3MFxEm4zDb2HCPhQHt4Urn8emhJOhYSUlZ5Y57Ig163ukqY7GWAh8urYCS
         HoNK8KFmrEWeuERbb5IRJDMLkwGWh8d6gFpumktZTx0iitGevy10Z/qaTUWKsPNCQefi
         tgBpDzACKUqQ3W04Vse8a3Ym5LbgWuccclVvYtR+iXeeBcT8306sbxShnNhR+FkoELQE
         RgJE3w9ydSuqJoeZ5XqQT8lRdGQe7VOQ9EYrs+whGEOfoUv54IzpxHuvLRMOI+Y7qnjJ
         0ZTHyjIGqCWUJ4pDWCaeRp19ymx/h7u0u11UzLCg29nhJyqlZ4YsiPxey1skCyps7Zm9
         f8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T1q/5UEvjKnmrGkeFgZRytr5DU5kdabjES1IFoO/gqw=;
        b=MlfIlU20NUsVVV1N6hgkyh9Zqbxk1/HGNG+MfsJ8GetCLkYOvra05Uk3wah+9eH0eq
         MlYwQMV/hDPQ7TEMNoDc78N+iGfooTBHIa3XbzT1uUhXVorueFkAR9rzPjGviBUV2opX
         /NXM4sstVqwFn2vi3bZgnUDbsB+y5SJaJJdAE3s9Nutc3vk94+RZnrnHdqnFkk/FHvMv
         NGHIHwD75pHig5oHWgHhZ3dAFBlyWndZ8TDO52buo6eOty/1zODzkuEXu2nGnF/wmNyg
         ZZkR6gGFIRS5vgEroNjL8g1GB9hzeGvK9nmgmZ2Z6a3ReW9rw6EpZ4iF1xJpcQtKResS
         YM/g==
X-Gm-Message-State: AJIora+s0aIpMf6y+1h/LZta50HaoWBrjODjZTqD012812gdokdfNfgO
        s5pbW2QkkqyXchirb/qQixw=
X-Google-Smtp-Source: AGRyM1tXVqYNUy+NFgrAHlDcM01iNexAN7CaAL0uAROXCpeeVwkXmKhPFoUuKttLJzcQ4dpaFH8V7g==
X-Received: by 2002:a17:903:120f:b0:15f:99f:9597 with SMTP id l15-20020a170903120f00b0015f099f9597mr651270plh.45.1658499587396;
        Fri, 22 Jul 2022 07:19:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y12-20020aa79aec000000b005252a06750esm3913898pfp.182.2022.07.22.07.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:19:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d0c94078-eec5-5924-a2c1-8c94c06364b8@roeck-us.net>
Date:   Fri, 22 Jul 2022 07:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 08/13] usb: typec: tcpci_mt6370: Add MediaTek MT6370
 tcpci driver
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-9-peterwu.pub@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220722102407.2205-9-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 03:24, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
> 
> Add support for the Type-C & Power Delivery controller in
> MediaTek MT6370 IC.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v6
> - Convert tcpci as device resource managed with 'devm_add_action_or_reset' API.
> - Refine remvoe callback.
> - Refine the commit text from 'This commit add' to 'Add'.
> ---
>   drivers/usb/typec/tcpm/Kconfig        |  11 ++
>   drivers/usb/typec/tcpm/Makefile       |   1 +
>   drivers/usb/typec/tcpm/tcpci_mt6370.c | 208 ++++++++++++++++++++++++++++++++++
>   3 files changed, 220 insertions(+)
>   create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 073fd2e..e6b88ca 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -35,6 +35,17 @@ config TYPEC_MT6360
>   	  USB Type-C. It works with Type-C Port Controller Manager
>   	  to provide USB PD and USB Type-C functionalities.
>   
> +config TYPEC_TCPCI_MT6370
> +	tristate "MediaTek MT6370 Type-C driver"
> +	depends on MFD_MT6370
> +	help
> +	  MediaTek MT6370 is a multi-functional IC that includes
> +	  USB Type-C. It works with Type-C Port Controller Manager
> +	  to provide USB PD and USB Type-C functionalities.
> +
> +	  This driver can also be built as a module. The module
> +	  will be called "tcpci_mt6370".
> +
>   config TYPEC_TCPCI_MAXIM
>   	tristate "Maxim TCPCI based Type-C chip driver"
>   	help
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index 7d499f3..906d9dc 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -6,4 +6,5 @@ typec_wcove-y				:= wcove.o
>   obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
>   obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
>   obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
> +obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
>   obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> new file mode 100644
> index 0000000..4f53319
> --- /dev/null
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/tcpm.h>
> +#include "tcpci.h"
> +
> +#define MT6370_REG_SYSCTRL8	0x9B
> +
> +#define MT6370_AUTOIDLE_MASK	BIT(3)
> +
> +#define MT6370_VENDOR_ID	0x29CF
> +#define MT6370_TCPC_DID_A	0x2170
> +
> +struct mt6370_priv {
> +	struct device *dev;
> +	struct regulator *vbus;
> +	struct tcpci *tcpci;
> +	struct tcpci_data tcpci_data;
> +};
> +
> +static const struct reg_sequence mt6370_reg_init[] = {
> +	REG_SEQ(0xA0, 0x1, 1000),
> +	REG_SEQ(0x81, 0x38, 0),
> +	REG_SEQ(0x82, 0x82, 0),
> +	REG_SEQ(0xBA, 0xFC, 0),
> +	REG_SEQ(0xBB, 0x50, 0),
> +	REG_SEQ(0x9E, 0x8F, 0),
> +	REG_SEQ(0xA1, 0x5, 0),
> +	REG_SEQ(0xA2, 0x4, 0),
> +	REG_SEQ(0xA3, 0x4A, 0),
> +	REG_SEQ(0xA4, 0x01, 0),
> +	REG_SEQ(0x95, 0x01, 0),
> +	REG_SEQ(0x80, 0x71, 0),
> +	REG_SEQ(0x9B, 0x3A, 1000),
> +};
> +
> +static int mt6370_tcpc_init(struct tcpci *tcpci, struct tcpci_data *data)
> +{
> +	u16 did;
> +	int ret;
> +
> +	ret = regmap_register_patch(data->regmap, mt6370_reg_init,
> +				    ARRAY_SIZE(mt6370_reg_init));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_raw_read(data->regmap, TCPC_BCD_DEV, &did, sizeof(u16));
> +	if (ret)
> +		return ret;
> +
> +	if (did == MT6370_TCPC_DID_A)
> +		return regmap_write(data->regmap, TCPC_FAULT_CTRL, 0x80);
> +
> +	return 0;
> +}
> +
> +static int mt6370_tcpc_set_vconn(struct tcpci *tcpci, struct tcpci_data *data,
> +				 bool enable)
> +{
> +	return regmap_update_bits(data->regmap, MT6370_REG_SYSCTRL8,
> +				  MT6370_AUTOIDLE_MASK,
> +				  !enable ? MT6370_AUTOIDLE_MASK : 0);
> +}
> +
> +static int mt6370_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_data *data,
> +				bool source, bool sink)
> +{
> +	struct mt6370_priv *priv = container_of(data, struct mt6370_priv,
> +						tcpci_data);
> +	int ret;
> +
> +	ret = regulator_is_enabled(priv->vbus);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret && !source)
> +		return regulator_disable(priv->vbus);
> +
> +	if (!ret && source)
> +		return regulator_enable(priv->vbus);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t mt6370_irq_handler(int irq, void *dev_id)
> +{
> +	struct mt6370_priv *priv = dev_id;
> +
> +	return tcpci_irq(priv->tcpci);
> +}
> +
> +static int mt6370_check_vendor_info(struct mt6370_priv *priv)
> +{
> +	struct regmap *regmap = priv->tcpci_data.regmap;
> +	u16 vid;
> +	int ret;
> +
> +	ret = regmap_raw_read(regmap, TCPC_VENDOR_ID, &vid, sizeof(u16));
> +	if (ret)
> +		return ret;
> +
> +	if (vid != MT6370_VENDOR_ID)
> +		return dev_err_probe(priv->dev, -ENODEV,
> +				     "Vendor ID not correct 0x%02x\n", vid);
> +
> +	return 0;
> +}
> +
> +static void mt6370_unregister_tcpci_port(void *tcpci)
> +{
> +	tcpci_unregister_port(tcpci);
> +}
> +
> +static int mt6370_tcpc_probe(struct platform_device *pdev)
> +{
> +	struct mt6370_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	priv->tcpci_data.regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!priv->tcpci_data.regmap)
> +		return dev_err_probe(dev, -ENODEV, "Failed to init regmap\n");
> +
> +	ret = mt6370_check_vendor_info(priv);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get irq\n");
> +
> +	/* Assign TCPCI feature and ops */
> +	priv->tcpci_data.auto_discharge_disconnect = 1;
> +	priv->tcpci_data.init = mt6370_tcpc_init;
> +	priv->tcpci_data.set_vconn = mt6370_tcpc_set_vconn;
> +
> +	priv->vbus = devm_regulator_get_optional(dev, "vbus");
> +	if (!IS_ERR(priv->vbus))
> +		priv->tcpci_data.set_vbus = mt6370_tcpc_set_vbus;
> +
> +	priv->tcpci = tcpci_register_port(dev, &priv->tcpci_data);
> +	if (IS_ERR(priv->tcpci))
> +		return dev_err_probe(dev, PTR_ERR(priv->tcpci),
> +				     "Failed to register tcpci port\n");
> +
> +	ret = devm_add_action_or_reset(dev, mt6370_unregister_tcpci_port,
> +				       priv->tcpci);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL, mt6370_irq_handler,
> +					IRQF_ONESHOT, dev_name(dev), priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to allocate irq\n");
> +
> +	device_init_wakeup(dev, true);
> +	dev_pm_set_wake_irq(dev, irq);
> +
> +	return 0;
> +}
> +
> +static int mt6370_tcpc_remove(struct platform_device *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt6370_tcpc_devid_table[] = {
> +	{ .compatible = "mediatek,mt6370-tcpc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mt6370_tcpc_devid_table);
> +
> +static struct platform_driver mt6370_tcpc_driver = {
> +	.driver = {
> +		.name = "mt6370-tcpc",
> +		.of_match_table = mt6370_tcpc_devid_table,
> +	},
> +	.probe = mt6370_tcpc_probe,
> +	.remove = mt6370_tcpc_remove,
> +};
> +module_platform_driver(mt6370_tcpc_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("MT6370 USB Type-C Port Controller Interface Driver");
> +MODULE_LICENSE("GPL v2");

