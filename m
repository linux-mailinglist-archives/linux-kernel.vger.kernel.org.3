Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A517546307
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348192AbiFJKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347270AbiFJKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:02:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE425B36E6;
        Fri, 10 Jun 2022 03:01:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D14C6601737;
        Fri, 10 Jun 2022 11:01:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654855315;
        bh=ZXnRPfOHyh8XNB3jxvw2h0Jk8FXI9GIuiWMT3+NbAiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LMKBoNBiQXBvYHcNZhRO6scOy0NBtE3k1c0bthm90hSjKTcqw3h13FefFkqr3Lqaz
         lPQoO8jYc51TAleC9oTQD8iMuZftsGMACbdmedMH/AqpBp909a7GKYsYMsgzsK8zfA
         QPyOUQHxBK+lQYjxMCmNiaVWBhR4K+6abJJKEx17lthCdmsNz53hOWmAC9zt3VDQ8Q
         jTa32xG2fOm1bCk7Pg14OMmOtg+rkgmadJWS95InqepagMQvs1s0fo0Mu3Z3LCtPlZ
         L06xRQ8/7PJS5GF7Uf9VatEugkjTkFUHbr93I7v7z/KLObaWBADDvxBYdtrhdB+WPT
         J4GEsxc1m+3UA==
Message-ID: <295c06c1-2cc9-d8f4-2516-b23a99e2542c@collabora.com>
Date:   Fri, 10 Jun 2022 12:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 5/8] ASoC: mediatek: mt8186: add machine driver with
 mt6366, da7219 and max98357
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220610082724.29256-1-jiaxin.yu@mediatek.com>
 <20220610082724.29256-6-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220610082724.29256-6-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/06/22 10:27, Jiaxin Yu ha scritto:
> Add support for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                    |   16 +
>   sound/soc/mediatek/mt8186/Makefile            |    1 +
>   .../mt8186/mt8186-mt6366-da7219-max98357.c    | 1002 +++++++++++++++++
>   3 files changed, 1019 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index f3c3b93226e4..cc93a0d42fe1 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -164,6 +164,22 @@ config SND_SOC_MT8186
>   	  Select Y if you have such device.
>   	  If unsure select "N".
>   
> +config SND_SOC_MT8186_MT6366_DA7219_MAX98357
> +	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A codec"
> +	depends on I2C && GPIOLIB
> +	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
> +	select SND_SOC_MT6358
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_DA7219
> +	select SND_SOC_BT_SCO
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDMI_CODEC
> +	help
> +	  This adds ASoC driver for Mediatek MT8186 boards
> +	  with the MT6366(MT6358) DA7219 MAX98357A codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
>   config SND_SOC_MTK_BTCVSD
>   	tristate "ALSA BT SCO CVSD/MSBC Driver"
>   	help
> diff --git a/sound/soc/mediatek/mt8186/Makefile b/sound/soc/mediatek/mt8186/Makefile
> index bdca1a3b3ff0..e7ddbe74d9d5 100644
> --- a/sound/soc/mediatek/mt8186/Makefile
> +++ b/sound/soc/mediatek/mt8186/Makefile
> @@ -18,3 +18,4 @@ snd-soc-mt8186-afe-objs := \
>   	mt8186-mt6366-common.o
>   
>   obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
> diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> new file mode 100644
> index 000000000000..5123754374b2
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> @@ -0,0 +1,1002 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// mt8186-mt6366-da7219-max98357.c
> +//	--  MT8186-MT6366-DA7219-MAX98357 ALSA SoC machine driver
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +//
> +


...snip...

> +}
> +
> +static int mt8186_da7219_i2s_hw_params(struct snd_pcm_substream *substream,
> +				       struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai;
> +	unsigned int rate = params_rate(params);
> +	unsigned int mclk_fs_ratio = 256;
> +	unsigned int mclk_fs = rate * mclk_fs_ratio;
> +	unsigned int freq;
> +	int ret = 0, j;

Why are you assigning 0 to ret here? You're reassigning just one line under here...

> +
> +	ret = snd_soc_dai_set_sysclk(asoc_rtd_to_cpu(rtd, 0), 0,
> +				     mclk_fs, SND_SOC_CLOCK_OUT);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "failed to set cpu dai sysclk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> +		if (!strcmp(codec_dai->component->name, DA7219_DEV_NAME)) {
> +			ret = snd_soc_dai_set_sysclk(codec_dai,
> +						     DA7219_CLKSRC_MCLK,
> +						     mclk_fs,
> +						     SND_SOC_CLOCK_IN);
> +			if (ret < 0) {
> +				dev_err(rtd->dev, "failed to set sysclk: %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			if ((rate % 8000) == 0)
> +				freq = DA7219_PLL_FREQ_OUT_98304;
> +			else
> +				freq = DA7219_PLL_FREQ_OUT_90316;
> +
> +			ret = snd_soc_dai_set_pll(codec_dai, 0,
> +						  DA7219_SYSCLK_PLL_SRM,
> +						  0, freq);
> +			if (ret) {
> +				dev_err(rtd->dev, "failed to start PLL: %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt8186_da7219_i2s_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *codec_dai;
> +	int ret = 0, j;
> +
> +	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> +		if (!strcmp(codec_dai->component->name, DA7219_DEV_NAME)) {
> +			ret = snd_soc_dai_set_pll(codec_dai,
> +						  0, DA7219_SYSCLK_MCLK, 0, 0);
> +			if (ret < 0) {
> +				dev_err(rtd->dev, "failed to stop PLL: %d\n",
> +					ret);

				return ret;

> +				break;
> +			}
> +		}
> +	}
> +

... and return 0 here.

> +	return ret;
> +}
> +

..snip..

> +
> +static const struct snd_soc_dapm_widget
> +mt8186_mt6366_da7219_max98357_widgets[] = {
> +	SND_SOC_DAPM_SPK("SPK Out", NULL),

In mt8183-da7219-max98357, this widget is called "Speakers": please use the
same name, so that we can (at least partially) reuse ALSA UCM2 configurations.

> +	SND_SOC_DAPM_OUTPUT("HDMI Out"),

...and some Intel boards (bxt_da7219_max98357a and others) are calling these
like "HDMI1", "HDMI2", etc.

We have only one HDMI output, yes, but if we change this to "HDMI1" we can again
increase UCM2 conf reusability.
By the way, these comments are actually valid also for the other card driver
mt6366-rt1019-rt5682s, so please model the names to commonize as much as possible.

Look at https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm2 to
understand what should be the final mixer names to achieve configuration
commonization.


> +};
> +
> +static const struct snd_soc_dapm_route
> +mt8186_mt6366_da7219_max98357_routes[] = {
> +	/* SPK */
> +	{ "SPK Out", NULL, "Speaker" },
> +	/* HDMI */
> +	{ "HDMI Out", NULL, "TX" },
> +};
> +
> +static const struct snd_kcontrol_new
> +mt8186_mt6366_da7219_max98357_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("SPK Out"),
> +	SOC_DAPM_PIN_SWITCH("HDMI Out"),
> +};
> +
> +static struct snd_soc_card mt8186_mt6366_da7219_max98357_soc_card = {
> +	.name = "mt8186_mt6366_da7219_max98357",
> +	.owner = THIS_MODULE,
> +	.dai_link = mt8186_mt6366_da7219_max98357_dai_links,
> +	.num_links = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_dai_links),
> +	.controls = mt8186_mt6366_da7219_max98357_controls,
> +	.num_controls = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_controls),
> +	.dapm_widgets = mt8186_mt6366_da7219_max98357_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_widgets),
> +	.dapm_routes = mt8186_mt6366_da7219_max98357_routes,
> +	.num_dapm_routes = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_routes),
> +	.codec_conf = mt8186_mt6366_da7219_max98357_codec_conf,
> +	.num_configs = ARRAY_SIZE(mt8186_mt6366_da7219_max98357_codec_conf),
> +};
> +
> +static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card;
> +	struct snd_soc_dai_link *dai_link;
> +	struct mt8186_mt6366_da7219_max98357_priv *priv;
> +	struct device_node *platform_node, *headset_codec, *playback_codec;
> +	int ret, i;
> +
> +	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
> +	if (!card)
> +		return -EINVAL;
> +	card->dev = &pdev->dev;
> +
> +	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
> +	if (!platform_node) {
> +		ret = -EINVAL;
> +		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
> +		goto err_platform_node;

You don't need this particular goto, you can just return in here.

> +	}


Regards,
Angelo


