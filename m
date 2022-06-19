Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AD550A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiFSMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiFSMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:15:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE38BC2C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:15:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so16292839ejj.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gF0Gwj/C6L3cvjiNQzt6cTyk+/JhZh42zyr/6Goldgo=;
        b=jk1vJCJ5PJNuNIF31F3TriYuG/cKMk6gSZXn9/46qluGbFdq554Tw30GpVbfYDtlTr
         4SKkenAYbWkGo/VzdrT2ggXlK7vYOW0z9dMzwuBFXHuumftIsv/5nuYdhI7wijet7u/j
         TLOsWQxK9xfV+TJ7oCOVLPDhDTYgBXJfV4E6oDdpIFMjqOZk8KDXX2BPnefVfB8vIi98
         sjTNRdPCpNcoHNr0EJV7Tgsip/zuH49nUkU7vYcpesBBHC7M7e1vpwB5+aiTAuuefK1/
         lFpBI0+3JDjyfI3p1UsqxIClJAztMWj+AZ1FJnUhsGyQLAqTa0cCD+wPIYD6o4k+WZUA
         J+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gF0Gwj/C6L3cvjiNQzt6cTyk+/JhZh42zyr/6Goldgo=;
        b=UoFjo/q/G6Ccnm+Rt7eQHaZZ4oqY2V/V3Fv1cqh4Sd4+SIN/aAky4dQcCA4d2Au+YZ
         CO3jsgH7rU57ZzyeZZmqvNbqhsjMjzGDyARvtQm0j2srNNMQBBH8DZBQ5gs6H6z7paIc
         fIx41ZsEkcs1tG4Nrx68IeYmYYIr+3nJ8i8F0AsuD65zJ0R3qTGiwIOEXOYb4MVBMrLT
         6fDO/KpLUAYguXezig9i/cLkAdXiSQAt/YdR68KZ4q3uDZqvPL8Jjo81CfnroTCu+E7q
         K0BEFVee1LwjeSo9WWQCmo0fTjtHlnh/8+wewkoPfFAUdumD2Qix9klVo3EUSkvghaPW
         I+yA==
X-Gm-Message-State: AJIora9zFcoYfkUjvE5wImJ0S5k6v/+5WoOsgjEPMEstKLFPwcfVE8Li
        cKJ9gIdHhSI9tS0WfmKL8g0SXw==
X-Google-Smtp-Source: AGRyM1vsL+KbYeV1UgaR5Avi+XNA499NYMSUFF6Gtwgp4n16enUFH9kgWZ4YFWACkwFqRYf5XwW5qA==
X-Received: by 2002:a17:907:1dd1:b0:715:73d2:df1f with SMTP id og17-20020a1709071dd100b0071573d2df1fmr17030479ejc.46.1655640906086;
        Sun, 19 Jun 2022 05:15:06 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090778c800b0070e1adff390sm4522943ejc.34.2022.06.19.05.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:15:05 -0700 (PDT)
Message-ID: <8a1d7575-1334-e5ab-5228-f75ae67a3d13@linaro.org>
Date:   Sun, 19 Jun 2022 14:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20220618092201.3837791-1-victor.liu@nxp.com>
 <20220618092201.3837791-3-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220618092201.3837791-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 11:22, Liu Ying wrote:
> This patch adds Freescale i.MX8qm LVDS PHY support.


Don't use "This patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> The PHY IP is from Mixel, Inc.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>



> +static int mixel_lvds_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *phy_provider;
> +	struct mixel_lvds_phy_priv *priv;
> +	struct mixel_lvds_phy *lvds_phy;
> +	struct phy *phy;
> +	int i;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err_probe(dev, ret, "failed to get regmap\n");
> +		return ret;

All such calls are one-liners.

> +	}
> +
> +	priv->phy_ref_clk = devm_clk_get(dev, "phy_ref");
> +	if (IS_ERR(priv->phy_ref_clk)) {
> +		ret = PTR_ERR(priv->phy_ref_clk);
> +		dev_err_probe(dev, ret, "failed to get PHY reference clock\n");
> +		return ret;

Again, one line instead of three.

> +	}
> +
> +	mutex_init(&priv->lock);
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = mixel_lvds_phy_reset(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to do POR reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < PHY_NUM; i++) {
> +		lvds_phy = devm_kzalloc(dev, sizeof(*lvds_phy), GFP_KERNEL);
> +		if (!lvds_phy) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		phy = devm_phy_create(dev, NULL, &mixel_lvds_phy_ops);
> +		if (IS_ERR(phy)) {
> +			ret = PTR_ERR(phy);
> +			dev_err(dev, "failed to create PHY for channel%d: %d\n",
> +				i, ret);
> +			goto err;
> +		}
> +
> +		lvds_phy->phy = phy;
> +		lvds_phy->id = i;
> +		priv->phys[i] = lvds_phy;
> +
> +		phy_set_drvdata(phy, lvds_phy);
> +	}
> +
> +	phy_provider = devm_of_phy_provider_register(dev, mixel_lvds_phy_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret = PTR_ERR(phy_provider);
> +		dev_err(dev, "failed to register PHY provider: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static int mixel_lvds_phy_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mixel_lvds_phy_runtime_suspend(struct device *dev)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +
> +	/* power down */
> +	mutex_lock(&priv->lock);
> +	regmap_write(priv->regmap, PHY_CTRL + REG_SET, PD);
> +	mutex_unlock(&priv->lock);
> +
> +	dev_dbg(dev, "runtime suspended\n");
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mixel_lvds_phy_runtime_resume(struct device *dev)
> +{
> +	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
> +
> +	/* power up + control initialization */
> +	mutex_lock(&priv->lock);
> +	regmap_update_bits(priv->regmap, PHY_CTRL,
> +			   CTRL_INIT_MASK | PD, CTRL_INIT_VAL);
> +	mutex_unlock(&priv->lock);
> +
> +	dev_dbg(dev, "runtime resumed\n");

No such debug messages.


Best regards,
Krzysztof
