Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503C54652CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350943AbhLAQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbhLAQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:36:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F1C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:33:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1613472wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KW5mSjVo1Mf3f2RnfEi35yNSDBK3dNyjdQRxQcpGMLU=;
        b=n56fiMJrfuYjdJz48mxZfZ21Wc2+BHP+36pi9oADu4tL6ZbCECTNyAEZKMFzsnDb7g
         S+bpacJHPvTY7BmkxkrBCwGFqf9iQZ9rpeptfbodfa3LmZPWYPDS9FeE/jYbLBITvuoA
         g4Fyh4OIufUoOmfmLuyPYcFcVoX7YCWFTIgcUb+oFUBtBCPENsvfSYCtIk3I8cEcBIoW
         H/t2mcJbBGmPW/fr7cNee08yHUPCXWY2ho0ikU3LYnMA+nMrT/fPJQ/SW/2z07GEOoS8
         UTlObiamBiGiO81rF8XqhkXW35Omdy2Fp0Mn9PXZZJFSw+DGkscG/0JvLHsDJ6gQhtKr
         Y/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KW5mSjVo1Mf3f2RnfEi35yNSDBK3dNyjdQRxQcpGMLU=;
        b=jS3yXdh+L8N5BnnHmdITo6gMiHXU8a2/+bmdUAdVRPuuG3zZPeh9nakez9GHatk41O
         0cxfQufgir7tjqdtpm8mQsqyPHeSThRjBItdbjXJ1Q3St5EQ2jHJi5FbkqbH6HuCHAsm
         dBfCkraCF/UwHjxLfftM/LeTRlk8oIVJNXNWF1LTe73yg7jnU4bXsfa/LgBB28KajNFY
         6AI5UA0q/UMalZJ6mPJru5ozzmQ4AFj5sNvM9gwhit+OQGT4bmySdsSDuJ3SmK9LOe15
         /h9+mCZVEWVeNHuWiRHWfVpahUrHBgxc1tEFYq37VD8pI17o9dkBiSXfMmbf9SwYfuKs
         jTXw==
X-Gm-Message-State: AOAM531y8ISTxLoY3k0SrKLK2TJ4//yttL40jxANsTVkW82KojGhYoXD
        JX2iMpLG7D5AViA+UXNuF9Bokw==
X-Google-Smtp-Source: ABdhPJy3I04CM9fy07YceFGjWFJEdE5DNZx5c3e0GLHXORCYzH/NJaSx2H5iFRMUsJcFv2+ggTKwnw==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr8383987wmq.120.1638376384288;
        Wed, 01 Dec 2021 08:33:04 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f19sm1863123wmq.34.2021.12.01.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 08:33:03 -0800 (PST)
Subject: Re: [PATCH v6 2/2] ASoC: qcom: SC7280: Add machine driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <1637239506-9387-1-git-send-email-srivasam@codeaurora.org>
 <1637239506-9387-3-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5d0ca118-2a38-a7cf-ebec-f28f98078583@linaro.org>
Date:   Wed, 1 Dec 2021 16:33:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637239506-9387-3-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2021 12:45, Srinivasa Rao Mandadapu wrote:
> Add new machine driver to register sound card on sc7280 based targets and
> do the required configuration for lpass cpu dai and external codecs
> connected over MI2S and soundwire interfaces.
> Add support for audio jack detection, soundwire init and MBHC.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig  |  12 ++
>   sound/soc/qcom/Makefile |   2 +
>   sound/soc/qcom/sc7280.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 313 insertions(+)
>   create mode 100644 sound/soc/qcom/sc7280.c
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index cc7c1de..530d01f 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -152,4 +152,16 @@ config SND_SOC_SC7180
>   	  SC7180 SoC-based systems.
>   	  Say Y if you want to use audio device on this SoCs.
>   
> +config SND_SOC_SC7280
> +	tristate "SoC Machine driver for SC7280 boards"
> +	depends on I2C && SOUNDWIRE || COMPILE_TEST
> +	select SND_SOC_QCOM_COMMON
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_LPASS_RX_MACRO
> +	select SND_SOC_LPASS_TX_MACRO

Consider adding

+	select SND_SOC_LPASS_SC7280
+	select SND_SOC_WCD938X


and remove them from "[PATCH v6 10/10] ASoC: qcom: SC7280: Update config 
for building codec dma drivers"


> +	  Add support for audio on Qualcomm Technologies Inc.
> +	  SC7280 SoC-based systems.
> +	  Say Y or M if you want to use audio device on this SoCs.
> +
>   endif #SND_SOC_QCOM
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 1600ae5..625aec6 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -19,6 +19,7 @@ snd-soc-storm-objs := storm.o
>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>   snd-soc-apq8096-objs := apq8096.o
>   snd-soc-sc7180-objs := sc7180.o
> +snd-soc-sc7280-objs := sc7280.o
>   snd-soc-sdm845-objs := sdm845.o
>   snd-soc-sm8250-objs := sm8250.o
>   snd-soc-qcom-common-objs := common.o
> @@ -27,6 +28,7 @@ obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>   obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
>   obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
> +obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
>   obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
>   obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
>   obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
> new file mode 100644
> index 0000000..c20d4ab1
> --- /dev/null
> +++ b/sound/soc/qcom/sc7280.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> +//
> +// ALSA SoC Machine driver for sc7280
> +
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
Why do we need this?

> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/jack.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +
> +#include <dt-bindings/sound/sc7180-lpass.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
Why this include?

> +
> +#include "../codecs/wcd938x.h"

Why do we need the codec header file here?

> +#include "common.h"
> +#include "lpass.h"
> +
> +#define LPASS_MAX_PORTS  (LPASS_CDC_DMA_VA_TX8 + 1)

May be add this in lpass.h instead of machine file.

> +
> +struct sc7280_snd_data {
> +	bool stream_prepared[LPASS_MAX_PORTS];
move this to the end of struct.

> +	struct snd_soc_card card;
> +	struct sdw_stream_runtime *sruntime[LPASS_MAX_PORTS];
> +	struct snd_soc_jack hs_jack;
> +	struct snd_soc_jack hdmi_jack;
> +	bool jack_setup;
> +};
> +
> +static void sc7280_jack_free(struct snd_jack *jack)
> +{
> +	struct snd_soc_component *component = jack->private_data;
> +
> +	snd_soc_component_set_jack(component, NULL, NULL);
> +}
> +
> +static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(card);
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct snd_soc_component *component = codec_dai->component;
> +	struct snd_jack *jack;
> +	int rval, i;
> +
> +	if (!pdata->jack_setup) {
> +		rval = snd_soc_card_jack_new(card, "Headset Jack",
> +							SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +							SND_JACK_MECHANICAL |
> +							SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +							SND_JACK_BTN_2 | SND_JACK_BTN_3 |
> +							SND_JACK_BTN_4 | SND_JACK_BTN_5,
> +							&pdata->hs_jack, NULL, 0);
> +
> +		if (rval < 0) {
> +			dev_err(card->dev, "Unable to add Headset Jack\n");
> +			return rval;
> +		}
> +
> +		jack = pdata->hs_jack.jack;
> +
> +		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +
> +		jack->private_data = component;
> +		jack->private_free = sc7280_jack_free;
> +		pdata->jack_setup = true;
> +	}
> +	switch (cpu_dai->id) {
> +	case LPASS_CDC_DMA_RX0:
> +	case LPASS_CDC_DMA_TX3:
> +		for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +			rval = snd_soc_component_set_jack(component, &pdata->hs_jack, NULL);
> +			if (rval != 0 && rval != -ENOTSUPP) {
> +				dev_err(card->dev, "Failed to set jack: %d\n", rval);
> +				return rval;
> +			}
> +		}
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc7280_hdmi_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_card *card = rtd->card;
> +	struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(card);
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> +	struct snd_soc_component *component = codec_dai->component;
> +	struct snd_jack *jack;
> +	int rval;
> +
> +	rval = snd_soc_card_jack_new(
> +			card, "HDMI Jack",
> +			SND_JACK_LINEOUT,
> +			&pdata->hdmi_jack, NULL, 0);

you could probably warp this up to 100 chars

> +
> +	if (rval < 0) {
> +		dev_err(card->dev, "Unable to add HDMI Jack\n");
> +		return rval;
> +	}
> +
> +	jack = pdata->hdmi_jack.jack;
> +	jack->private_data = component;
> +	jack->private_free = sc7280_jack_free;
> +
> +	return snd_soc_component_set_jack(component, &pdata->hdmi_jack, NULL);
> +}
> +
> +static int sc7280_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +	switch (cpu_dai->id) {
> +	case LPASS_CDC_DMA_TX3:
> +		return sc7280_headset_init(rtd);
> +	case LPASS_CDC_DMA_RX0:
> +	case LPASS_CDC_DMA_VA_TX0:
> +	case MI2S_SECONDARY:
> +		return 0;
> +	case LPASS_DP_RX:
> +		return sc7280_hdmi_init(rtd);
> +	default:
> +		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai;
> +	const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
> +	struct sdw_stream_runtime *sruntime;
> +	int i;
> +
> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
> +
> +	switch (cpu_dai->id) {
> +	case LPASS_CDC_DMA_TX3:
> +	case LPASS_CDC_DMA_RX0:
> +		for_each_rtd_codec_dais(rtd, i, codec_dai) {
> +			sruntime = snd_soc_dai_get_sdw_stream(codec_dai, substream->stream);
> +			if (sruntime != ERR_PTR(-ENOTSUPP))
> +				pdata->sruntime[cpu_dai->id] = sruntime;
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc7280_snd_swr_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +	int ret;
> +
> +	if (!sruntime)
> +		return 0;
> +
> +	if (data->stream_prepared[cpu_dai->id]) {
> +		sdw_disable_stream(sruntime);
> +		sdw_deprepare_stream(sruntime);
> +		data->stream_prepared[cpu_dai->id] = false;
> +	}
> +
> +	ret = sdw_prepare_stream(sruntime);
> +	if (ret)
> +		return ret;
> +
> +	ret = sdw_enable_stream(sruntime);
> +	if (ret) {
> +		sdw_deprepare_stream(sruntime);
> +		return ret;
> +	}
> +	data->stream_prepared[cpu_dai->id] = true;
> +
> +	return ret;
> +}
> +
> +static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +	switch (cpu_dai->id) {
> +	case LPASS_CDC_DMA_RX0:
> +	case LPASS_CDC_DMA_TX3:
> +		return sc7280_snd_swr_prepare(substream);
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +	const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
> +
> +	switch (cpu_dai->id) {
> +	case LPASS_CDC_DMA_RX0:
> +	case LPASS_CDC_DMA_TX3:
> +		if (sruntime && data->stream_prepared[cpu_dai->id]) {
> +			sdw_disable_stream(sruntime);
> +			sdw_deprepare_stream(sruntime);
> +			data->stream_prepared[cpu_dai->id] = false;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops sc7280_ops = {
> +	.hw_params = sc7280_snd_hw_params,
> +	.hw_free = sc7280_snd_hw_free,
> +	.prepare = sc7280_snd_prepare,
> +};
> +
> +static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +};
> +
> +static int sc7280_snd_platform_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card;
> +	struct sc7280_snd_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct snd_soc_dai_link *link;
> +	int ret, i;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	card = &data->card;
> +	snd_soc_card_set_drvdata(card, data);
> +
> +	card->owner = THIS_MODULE;
> +	card->driver_name = "SC7280";
> +	card->dev = dev;
> +
> +	ret = qcom_snd_parse_of(card);
> +	if (ret)
> +		return ret;
> +
> +	for_each_card_prelinks(card, i, link) {
> +		link->init = sc7280_init;
> +		link->ops = &sc7280_ops;
> +	}
> +
> +	return devm_snd_soc_register_card(dev, card);
> +}
> +
> +static const struct of_device_id sc7280_snd_device_id[]  = {
> +	{ .compatible = "google,sc7280-herobrine" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sc7280_snd_device_id);
> +
> +static struct platform_driver sc7280_snd_driver = {
> +	.probe = sc7280_snd_platform_probe,
> +	.driver = {
> +		.name = "msm-snd-sc7280",
> +		.of_match_table = sc7280_snd_device_id,
> +		.pm = &snd_soc_pm_ops,
> +	},
> +};
> +module_platform_driver(sc7280_snd_driver);
> +
> +MODULE_DESCRIPTION("sc7280 ASoC Machine Driver");
> +MODULE_LICENSE("GPL v2");
"GPL" should be good enough here.

--srini
> 
