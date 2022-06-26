Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9640855B04E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiFZIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiFZIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:33:19 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10101634A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 01:33:17 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 5NhgocNcnOXCy5NhhoLboN; Sun, 26 Jun 2022 10:33:15 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Jun 2022 10:33:15 +0200
X-ME-IP: 90.11.190.129
Message-ID: <c8b888fc-dff9-c278-da10-6883c4277289@wanadoo.fr>
Date:   Sun, 26 Jun 2022 10:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/8] ASoC: mediatek: mt8186: add platform driver
Content-Language: en-US
To:     jiaxin.yu@mediatek.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        aaronyu@google.com, alsa-devel@alsa-project.org,
        angelogioacchino.delregno@collabora.com, broonie@kernel.org,
        devicetree@vger.kernel.org, julianbraha@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, trevor.wu@mediatek.com, tzungbi@google.com
References: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
 <20220625190852.29130-3-jiaxin.yu@mediatek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220625190852.29130-3-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/06/2022 à 21:08, Jiaxin Yu a écrit :
> Add mt8186 platform and affiliated driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   sound/soc/mediatek/Kconfig                    |   12 +
>   sound/soc/mediatek/Makefile                   |    1 +
>   sound/soc/mediatek/mt8186/Makefile            |   19 +
>   sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
>   .../soc/mediatek/mt8186/mt8186-afe-control.c  |  255 ++
>   sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3011 +++++++++++++++++
>   6 files changed, 3533 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/Makefile
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c

[...]

> +	MT8186_DAI_HOSTLESS_SRC_AAUDIO,
> +	MT8186_DAI_HOSTLESS_SRC_1,	/* just an exmpale */

example?

> +	MT8186_DAI_HOSTLESS_SRC_BARGEIN,
> +	MT8186_DAI_HOSTLESS_UL1,

[...]

> +#define MTK_SPK_I2S_0_STR "MTK_SPK_I2S_0"
> +#define MTK_SPK_I2S_1_STR "MTK_SPK_I2S_1"
> +#define MTK_SPK_I2S_2_STR "MTK_SPK_I2S_2"
> +#define MTK_SPK_I2S_3_STR "MTK_SPK_I2S_3"

Out of curiosity, why no 4?
Or, if related to mtk_spk_i2s_type below, why  6, 7, 8 and 9?

> +#define MTK_SPK_I2S_5_STR "MTK_SPK_I2S_5"
> +#define MTK_SPK_I2S_6_STR "MTK_SPK_I2S_6"
> +#define MTK_SPK_I2S_7_STR "MTK_SPK_I2S_7"
> +#define MTK_SPK_I2S_8_STR "MTK_SPK_I2S_8"
> +#define MTK_SPK_I2S_9_STR "MTK_SPK_I2S_9"
> +

[...]

> +
> +enum mtk_spk_i2s_type {
> +	MTK_SPK_I2S_TYPE_INVALID = -1,
> +	MTK_SPK_I2S_0,
> +	MTK_SPK_I2S_1,
> +	MTK_SPK_I2S_2,
> +	MTK_SPK_I2S_3,
> +	MTK_SPK_I2S_5,
> +	MTK_SPK_I2S_TYPE_NUM
> +};

[...]

> +static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe;
> +	struct mt8186_afe_private *afe_priv;
> +	struct resource *res;
> +	struct reset_control *rstc;
> +	struct device *dev = &pdev->dev;
> +	int i, ret, irq_id;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> +	if (ret)
> +		return ret;
> +
> +	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
> +	if (!afe)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, afe);
> +
> +	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv), GFP_KERNEL);
> +	if (!afe->platform_priv)
> +		return -ENOMEM;
> +
> +	afe_priv = afe->platform_priv;
> +	afe->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(afe->base_addr))
> +		return PTR_ERR(afe->base_addr);
> +
> +	/* init audio related clock */
> +	ret = mt8186_init_clock(afe);
> +	if (ret) {
> +		dev_err(dev, "init clock error, ret %d\n", ret);
> +		return ret;
> +	}

There is a mt8186_deinit_clock() call in the remove function.
Should this also be called in the error handling path below?
Or should a devm_add_action_or_reset() be used to ease error handling?

> +
> +	/* init memif */
> +	afe->memif_32bit_supported = 0;
> +	afe->memif_size = MT8186_MEMIF_NUM;
> +	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
> +				  GFP_KERNEL);
> +

Nit: no need for an empty line here.

> +	if (!afe->memif)
> +		return -ENOMEM;
> +

[...]

> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	return ret;
> +}
> +
> +static int mt8186_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
> +
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		mt8186_afe_runtime_suspend(&pdev->dev);

Out of curiosity, is it normal to have some pm_runtime related code here 
that does not look the same as the one in the error handling of the probe?
(I don't know much about pm, but usually, .remove() functions and error 
handling in the probe look quite close)

> +
> +	mt8186_deinit_clock(afe);
> +
> +	return 0;
> +}
> +

[...]
