Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5219A5663D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiGEHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiGEHTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:19:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02134BE1D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:19:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso7007665wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yBMd+QAMBurTUday06tJn1n/zGFmox+wPn3qVPhtdoE=;
        b=B9FMLO2K1AfQ0Yu89f/FDDQwafkTVkDnJjtheSuJXk2i3fGkJAN6Ggh1p4eVoR0pXs
         DPrL04mOpDho3V0enpONlV5jhMGXLCu9vPkiLJsXObhTngIX8PhmiX4oeCG8vyr8MYVd
         F7j8tsPCyaPeETD5wldgpJKQ8HAD0+B5hgDIIVSBuk44JB9fvlbP3ce1qIq8eW8tKN01
         unhWK5n8BGTueCd6+Npy3Z60bgTT7UVP4Qp9G5gsO4qLM4UO2cRGjjWGTxJ85A4kYyqK
         jq0l0iXgAJFigXrvmtVEKqeUf7SJP6ZWsfmtDdlicioxdEHvXgOOd6rVKAdH3yVnpnVz
         JkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yBMd+QAMBurTUday06tJn1n/zGFmox+wPn3qVPhtdoE=;
        b=bmr1se7w9KCHN/ZGp24zC/UEqU/93jcI0Io4lPR0mR2KiJrEJwdFZ7iptkagn0Ju7M
         jg+UE2CZEaFSjPT+U5P8ppce6v+RgCP7Irbmw4AQNRpe2OlgGyB0dwXi6zF42Nqqt6bi
         PJvko6Kxsa41L+1ROtN8e97HyBCOTGLZ8apZD645um6729+pBt+4y1brzIOMpodqWNJK
         h12KbG7bwzL1miIbQaVjv/stt8pTJZfjB3O9fkDPFRAJkUe8MEmfHr2wUsMpft3zTjb8
         R6hXAMHkqxxXd4YF/uJFz3MhExKacehoz4W0Ni6I/ILYz4XUZjnDSB5DwYGKa+Ypkgrq
         hdjg==
X-Gm-Message-State: AJIora9kpzD3pQXGfpkB6WoIhi1wUhfTVhpkkh7WZaaRHlSHa+nf8yUJ
        a1sHsR6zzHXtrop35A9lPtM3IciBa9DbZ5aK
X-Google-Smtp-Source: AGRyM1tmSmQ136glZwFL8MnFX8NzY19FwN6EkYF5SnmCGdCMuL0+ixpR3qPpLgNEm7TC1xL9pB+47w==
X-Received: by 2002:a05:600c:35cf:b0:3a0:49c1:f991 with SMTP id r15-20020a05600c35cf00b003a049c1f991mr35420825wmq.95.1657005581419;
        Tue, 05 Jul 2022 00:19:41 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3c4f:78be:dc90:14f9? ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id m10-20020adff38a000000b0021d6de18f68sm3215032wro.22.2022.07.05.00.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:19:41 -0700 (PDT)
Message-ID: <e2bdb75c-6ff7-09e4-d70c-5fa307282df4@baylibre.com>
Date:   Tue, 5 Jul 2022 09:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/2] phy: amlogic: Add G12A Analog MIPI D-PHY driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220616133811.1674777-1-narmstrong@baylibre.com>
 <20220616133811.1674777-3-narmstrong@baylibre.com> <YsPd5iwTwHOkkSz9@matsya>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YsPd5iwTwHOkkSz9@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/07/2022 08:44, Vinod Koul wrote:
> On 16-06-22, 15:38, Neil Armstrong wrote:
>> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY used to communicate with DSI
>> panels.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/phy/amlogic/Kconfig                   |  12 ++
>>   drivers/phy/amlogic/Makefile                  |   1 +
>>   .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
>>   3 files changed, 190 insertions(+)
>>   create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
>>
>> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
>> index 486ca23aba32..e4d1170efd54 100644
>> --- a/drivers/phy/amlogic/Kconfig
>> +++ b/drivers/phy/amlogic/Kconfig
>> @@ -59,6 +59,18 @@ config PHY_MESON_G12A_USB3_PCIE
>>   	  in Meson G12A SoCs.
>>   	  If unsure, say N.
>>   
>> +config PHY_MESON_G12A_MIPI_DPHY_ANALOG
> 
> this should be sorted alphabetically, so before PHY_MESON_G12A_USB3_PCIE

Ack

> 
>> +	tristate "Meson G12A MIPI Analog DPHY driver"
>> +	default ARCH_MESON
>> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
>> +	select GENERIC_PHY
>> +	select REGMAP_MMIO
>> +	select GENERIC_PHY_MIPI_DPHY
>> +	help
>> +	  Enable this to support the Meson MIPI Analog DPHY found in Meson G12A
>> +	  SoCs.
>> +	  If unsure, say N.
>> +
>>   config PHY_MESON_AXG_PCIE
>>   	tristate "Meson AXG PCIE PHY driver"
>>   	default ARCH_MESON
>> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
>> index c0886c850bb0..91e3b9790c03 100644
>> --- a/drivers/phy/amlogic/Makefile
>> +++ b/drivers/phy/amlogic/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
>>   obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
>>   obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
>>   obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)		+= phy-meson-g12a-usb3-pcie.o
>> +obj-$(CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG)	+= phy-meson-g12a-mipi-dphy-analog.o
>>   obj-$(CONFIG_PHY_MESON_AXG_PCIE)		+= phy-meson-axg-pcie.o
>>   obj-$(CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG)	+= phy-meson-axg-mipi-pcie-analog.o
>>   obj-$(CONFIG_PHY_MESON_AXG_MIPI_DPHY)		+= phy-meson-axg-mipi-dphy.o
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
>> new file mode 100644
>> index 000000000000..adfcca38a952
>> --- /dev/null
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Meson G12A MIPI DSI Analog PHY
>> + *
>> + * Copyright (C) 2018 Amlogic, Inc. All rights reserved
>> + * Copyright (C) 2020 BayLibre, SAS
> 
> 2022 now?

Well it was developed in 2020, but I'll update it anyway

> 
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/module.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/regmap.h>
>> +#include <linux/delay.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +#define HHI_MIPI_CNTL0 0x00
>> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(31, 16)
>> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
>> +
>> +#define HHI_MIPI_CNTL1 0x04
>> +#define		HHI_MIPI_CNTL1_BANDGAP		BIT(16)
>> +#define		HHI_MIPI_CNTL2_DIF_REF_CTL2	GENMASK(15, 0)
>> +
>> +#define HHI_MIPI_CNTL2 0x08
>> +#define		HHI_MIPI_CNTL2_DIF_TX_CTL1	GENMASK(31, 16)
>> +#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
>> +#define		HHI_MIPI_CNTL2_DIF_TX_CTL0	GENMASK(10, 0)
>> +
>> +#define DSI_LANE_0				BIT(4)
>> +#define DSI_LANE_1				BIT(3)
>> +#define DSI_LANE_CLK				BIT(2)
>> +#define DSI_LANE_2				BIT(1)
>> +#define DSI_LANE_3				BIT(0)
>> +
>> +struct phy_g12a_mipi_dphy_analog_priv {
>> +	struct phy *phy;
>> +	struct regmap *regmap;
>> +	struct phy_configure_opts_mipi_dphy config;
>> +};
>> +
>> +static int phy_g12a_mipi_dphy_analog_configure(struct phy *phy,
>> +					       union phy_configure_opts *opts)
>> +{
>> +	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	memcpy(&priv->config, opts, sizeof(priv->config));
>> +
>> +	return 0;
>> +}
>> +
>> +static int phy_g12a_mipi_dphy_analog_power_on(struct phy *phy)
>> +{
>> +	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
>> +	unsigned int reg;
>> +
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL0,
>> +		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8) |
>> +		     FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0xa487));
>> +
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1,
>> +		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_REF_CTL2, 0x2e) |
>> +		     HHI_MIPI_CNTL1_BANDGAP);
>> +
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
>> +		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL0, 0x459) |
>> +		     FIELD_PREP(HHI_MIPI_CNTL2_DIF_TX_CTL1, 0x2680));
>> +
>> +	reg = DSI_LANE_CLK;
>> +	switch (priv->config.lanes) {
>> +	case 4:
>> +		reg |= DSI_LANE_3;
>> +		fallthrough;
>> +	case 3:
>> +		reg |= DSI_LANE_2;
>> +		fallthrough;
>> +	case 2:
>> +		reg |= DSI_LANE_1;
>> +		fallthrough;
>> +	case 1:
>> +		reg |= DSI_LANE_0;
>> +		break;
>> +	default:
>> +		reg = 0;
>> +	}
>> +
>> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
>> +			   HHI_MIPI_CNTL2_CH_EN,
>> +			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
>> +
>> +	return 0;
>> +}
>> +
>> +static int phy_g12a_mipi_dphy_analog_power_off(struct phy *phy)
>> +{
>> +	struct phy_g12a_mipi_dphy_analog_priv *priv = phy_get_drvdata(phy);
>> +
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL0, 0);
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0);
>> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct phy_ops phy_g12a_mipi_dphy_analog_ops = {
>> +	.configure = phy_g12a_mipi_dphy_analog_configure,
>> +	.power_on = phy_g12a_mipi_dphy_analog_power_on,
>> +	.power_off = phy_g12a_mipi_dphy_analog_power_off,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int phy_g12a_mipi_dphy_analog_probe(struct platform_device *pdev)
>> +{
>> +	struct phy_provider *phy;
>> +	struct device *dev = &pdev->dev;
>> +	struct phy_g12a_mipi_dphy_analog_priv *priv;
>> +	struct device_node *np = dev->of_node;
>> +	struct regmap *map;
>> +	int ret;
>> +
>> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	/* Get the hhi system controller node */
>> +	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>> +	if (IS_ERR(map)) {
>> +		dev_err(dev,
>> +			"failed to get HHI regmap\n");
>> +		return PTR_ERR(map);
>> +	}
>> +
>> +	priv->regmap = map;
>> +
>> +	priv->phy = devm_phy_create(dev, np, &phy_g12a_mipi_dphy_analog_ops);
>> +	if (IS_ERR(priv->phy)) {
>> +		ret = PTR_ERR(priv->phy);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to create PHY\n");
> 
> log the error ?

Ack

> 
>> +		return ret;
>> +	}
>> +
>> +	phy_set_drvdata(priv->phy, priv);
>> +	dev_set_drvdata(dev, priv);
>> +
>> +	phy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy);
>> +}
>> +
>> +static const struct of_device_id phy_g12a_mipi_dphy_analog_of_match[] = {
>> +	{
>> +		.compatible = "amlogic,g12a-mipi-dphy-analog",
>> +	},
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, phy_g12a_mipi_dphy_analog_of_match);
>> +
>> +static struct platform_driver phy_g12a_mipi_dphy_analog_driver = {
>> +	.probe = phy_g12a_mipi_dphy_analog_probe,
>> +	.driver = {
>> +		.name = "phy-meson-g12a-mipi-dphy-analog",
>> +		.of_match_table = phy_g12a_mipi_dphy_analog_of_match,
>> +	},
>> +};
>> +module_platform_driver(phy_g12a_mipi_dphy_analog_driver);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_DESCRIPTION("Meson G12A MIPI Analog D-PHY driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.25.1
> 

Thanks for ther review,
Neil
