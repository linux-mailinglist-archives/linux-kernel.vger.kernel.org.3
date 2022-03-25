Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84D4E72D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358991AbiCYMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354814AbiCYMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:18:47 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3CBD5549;
        Fri, 25 Mar 2022 05:17:13 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a8so14938472ejc.8;
        Fri, 25 Mar 2022 05:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PIC8HC/+LwwlBOVail2IQ2GxG1/AKglACL1WYm32h8s=;
        b=U49YSOiViCHMiCKahWvfmrw2pOfwVZaVnQ7SQCJL7dMNryNUbOGBEaiDAHrABGlg/d
         okjMLDFHQqx3pP/vNDb+fFjUEEwTIhxJ2qIYZK0l2mkbGwo3jS1RBOxOAD4T45nj7OQX
         SIXu90efRQ/sjMLmd8lfG1QdyeXpsgwk78o8iOwddXN82ndEu3p8H81Cf4oem5csk01P
         m0YuCX0BNfgYXckHRseVUkDaywrBpu1v5VcXYhsKgwcIvjxosVo+dpU6v0rPDNCm6INE
         K4KoVK+1W0NBio34bhggs4yRkqDxhLyY7af7hXrsKyUslvGL5fn9q+YH1jsbJslnptyT
         YhYQ==
X-Gm-Message-State: AOAM532PngOQUNBe+BAMhvm8G7YTbrQWtiZDZF99o3MYuDGBUHD3eEMw
        N5aOH15WJORij6y1cdAydbfHJCyKgEU=
X-Google-Smtp-Source: ABdhPJxYnLbXuyoGJfejyl5MK58btUGPE+Qx+wrluAkCKL2LQF3nvGiN2IhwrzUdH1tl+eUx3ALmsQ==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr11664173ejc.516.1648210631941;
        Fri, 25 Mar 2022 05:17:11 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm2283449ejo.190.2022.03.25.05.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:17:11 -0700 (PDT)
Message-ID: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
Date:   Fri, 25 Mar 2022 13:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648170401-6351-3-git-send-email-u0084500@gmail.com>
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

On 25/03/2022 02:06, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add support for Richtek RT5759 high-performance DCDC converter.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  drivers/regulator/Kconfig            |  10 +
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/rt5759-regulator.c | 372 +++++++++++++++++++++++++++++++++++
>  3 files changed, 383 insertions(+)
>  create mode 100644 drivers/regulator/rt5759-regulator.c
> 

(...)

> +static int rt5759_init_device_property(struct rt5759_priv *priv)
> +{
> +	unsigned int val = 0;
> +	bool wdt_enable;
> +
> +	/*
> +	 * Only RT5759A support external watchdog input
> +	 */
> +	if (priv->chip_type != CHIP_TYPE_RT5759A)
> +		return 0;
> +
> +	wdt_enable = device_property_read_bool(priv->dev,
> +					       "richtek,watchdog-enable");
> +	if (wdt_enable)

No need for separate wdt_enable variable.

> +		val = RT5759A_WDTEN_MASK;
> +
> +	return regmap_update_bits(priv->regmap, RT5759A_REG_WDTEN,
> +				  RT5759A_WDTEN_MASK, val);
> +}
> +
> +static int rt5759_manufacturer_check(struct rt5759_priv *priv)
> +{
> +	unsigned int vendor;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, RT5759_REG_VENDORINFO, &vendor);
> +	if (ret)
> +		return ret;
> +
> +	if (vendor != RT5759_MANUFACTURER_ID) {
> +		dev_err(priv->dev, "vendor info not correct (%d)\n", vendor);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool rt5759_is_accessible_reg(struct device *dev, unsigned int reg)
> +{
> +	struct rt5759_priv *priv = dev_get_drvdata(dev);
> +
> +	if (reg <= RT5759_REG_DCDCSET)
> +		return true;
> +
> +	if (priv->chip_type == CHIP_TYPE_RT5759A && reg == RT5759A_REG_WDTEN)
> +		return true;
> +
> +	return false;
> +}
> +
> +static const struct regmap_config rt5759_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT5759A_REG_WDTEN,
> +	.readable_reg = rt5759_is_accessible_reg,
> +	.writeable_reg = rt5759_is_accessible_reg,
> +};
> +
> +static int rt5759_probe(struct i2c_client *i2c)
> +{
> +	struct rt5759_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &i2c->dev;
> +	priv->chip_type = (unsigned long)of_device_get_match_data(&i2c->dev);
> +	i2c_set_clientdata(i2c, priv);
> +
> +	priv->regmap = devm_regmap_init_i2c(i2c, &rt5759_regmap_config);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(&i2c->dev, "Failed to allocate regmap (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rt5759_manufacturer_check(priv);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to check device (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rt5759_init_device_property(priv);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init device (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return rt5759_regulator_register(priv);
> +}
> +
> +static const struct of_device_id __maybe_unused rt5759_device_table[] = {

I don't think this can be __maybe_unused. It is always referenced via
of_match_table, isn't it?

> +	{ .compatible = "richtek,rt5759", .data = (void *)CHIP_TYPE_RT5759 },
> +	{ .compatible = "richtek,rt5759a", .data = (void *)CHIP_TYPE_RT5759A },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt5759_device_table);
> +
> +static struct i2c_driver rt5759_driver = {
> +	.driver = {
> +		.name = "rt5759",
> +		.of_match_table = rt5759_device_table,
> +	},
> +	.probe_new = rt5759_probe,
> +};
> +module_i2c_driver(rt5759_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT5759 Regulator Driver");
> +MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
