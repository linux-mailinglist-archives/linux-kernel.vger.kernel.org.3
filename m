Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741C46507C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhLAOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbhLAOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:55:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98019C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:51:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so52955618wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rsd0sZaVKFaOEXYmdzCz1KewiQ+2QSB9S/EAHYxJNQU=;
        b=b8McuK0z/9dNsmZoBIJDRa2gUABjnO79o4+pfLJQo1wCM5aUScHZvCvFvAYUjIzqd1
         96/FKrTry7F+EKdV5+eEj+UVEKq33FW1k7hR3/yKdcWjGesNcxjmYk0zBWMwJo5tLyEX
         JcYd2aYjOLz8SkWRbH2ecBUIl2M/MxvAkoyJOWAMDN/6yR7rwzZ/pwj7MkFyPbd0KXHJ
         McDoXvDjh90UED2mFy6x2+prUgGy/A6mj5QJsq8UMi8pUVYxRVp8wGEY9JtsBQbN7zXb
         EXStNYEw67cwca15JeNzJ22q60+gmKxE9Gs9ypsr6+ofyk/cWYbDFEEzzE1tVsdrgWrS
         LUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsd0sZaVKFaOEXYmdzCz1KewiQ+2QSB9S/EAHYxJNQU=;
        b=6LcJhqDCVJ3wta127CZStsj97ra4qWUKvw1PpSvf6dtOpbACIGWFMyUaVlDcKStuXz
         9MuzATvmuBcprtNtFyJQaPt1utylkcltSrZG9Y+vfOJw7TKRqTqGddaGRhwFxFrWgLNV
         KVF6/kecDeDbJrkqNXmM7Y/ozUhlFEYZpR5U7qoTTgieVISFS/0D75IDIcpYMTT9vVNH
         xIFrfHWuEtDQ6cYrNX9GQo61kWwW0N2xpZiSyBBsx7NHBI15KK1fHwGMteQKROiquLdJ
         8jU95AFVwI3lRFzMCBnaE4bSx69A7LzwXdhENYmknQ2KY2eIOnnCFKh3Zme4OreDJb9o
         koDw==
X-Gm-Message-State: AOAM533AiRyozsy0TyHzosfi54Xr0B1+z7heE7/yoQ5prsZNuHD01n00
        nTl8SmYHGP7Oo0cb4m5Xc/h4wQ==
X-Google-Smtp-Source: ABdhPJx4iWrtnzeMC7hUe4sTBE8X56FjMetwqDVaZYIrocvaSdi8hPlNfbeYb7HAgYqXgQSki+FuIQ==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr7832974wrs.291.1638370312944;
        Wed, 01 Dec 2021 06:51:52 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o12sm29368wrc.85.2021.12.01.06.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 06:51:52 -0800 (PST)
Subject: Re: [PATCH v6 04/10] ASoC: qcom: Add lpass CPU driver for codec dma
 control
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1637928282-2819-1-git-send-email-srivasam@codeaurora.org>
 <1637928282-2819-5-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a6d7322d-2ac5-c4c1-f13e-d3c73ebc571e@linaro.org>
Date:   Wed, 1 Dec 2021 14:51:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637928282-2819-5-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/11/2021 12:04, Srinivasa Rao Mandadapu wrote:
> Add lpass cpu driver to support audio over codec dma for
> ADSP bypass usecase.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>   sound/soc/qcom/lpass-cdc-dma.c | 275 +++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/lpass.h         |   1 +
>   2 files changed, 276 insertions(+)
>   create mode 100644 sound/soc/qcom/lpass-cdc-dma.c
> 
> diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
> new file mode 100644
> index 0000000..4462178
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-cdc-dma.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021 The Linux Foundation. All rights reserved.
> + *
> + * lpass-cdc-dma.c -- ALSA SoC WCD -CPU DAI driver for QTi LPASS WCD

Can we remove WCD from this comment?

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +
> +#include "lpass-lpaif-reg.h"
> +#include "lpass.h"
> +
> +enum codec_dma_interfaces {
> +	LPASS_CDC_DMA_INTERFACE1 = 1,
> +	LPASS_CDC_DMA_INTERFACE2,
> +	LPASS_CDC_DMA_INTERFACE3,
> +	LPASS_CDC_DMA_INTERFACE4,
> +	LPASS_CDC_DMA_INTERFACE5,
> +	LPASS_CDC_DMA_INTERFACE6,
> +	LPASS_CDC_DMA_INTERFACE7,
> +	LPASS_CDC_DMA_INTERFACE8,
> +	LPASS_CDC_DMA_INTERFACE9,
> +	LPASS_CDC_DMA_INTERFACE10,
> +};
> +
> +static void __lpass_get_dmactl_handle(struct snd_pcm_substream *substream, struct snd_soc_dai *dai,
> +				      struct lpaif_dmactl **dmactl, int *id)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *rt = substream->runtime;
> +	struct lpass_pcm_data *pcm_data = rt->private_data;
> +	struct lpass_variant *v = drvdata->variant;
> +	unsigned int dai_id = cpu_dai->driver->id;
> +
> +	switch (dai_id) {
> +	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +		*dmactl = drvdata->rxtx_rd_dmactl;
> +		*id = pcm_data->dma_ch;
> +		break;
> +	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +		*dmactl = drvdata->rxtx_wr_dmactl;
> +		*id = pcm_data->dma_ch - v->rxtx_wrdma_channel_start;
> +		break;
> +	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +		*dmactl = drvdata->va_wr_dmactl;
> +		*id = pcm_data->dma_ch - v->va_wrdma_channel_start;
> +		break;
> +	default:
> +		dev_err(soc_runtime->dev, "invalid dai id for dma ctl: %d\n", dai_id);
> +		break;
> +	}
> +}

looks much better now,
> +
> +static int __lpass_get_codec_dma_intf_type(int dai_id)
> +{
> +	int ret;
> +
> +	switch (dai_id) {
> +	case LPASS_CDC_DMA_RX0:
> +	case LPASS_CDC_DMA_TX0:
> +	case LPASS_CDC_DMA_VA_TX0:
> +		ret = LPASS_CDC_DMA_INTERFACE1;
> +		break;
> +	case LPASS_CDC_DMA_RX1:
> +	case LPASS_CDC_DMA_TX1:
> +	case LPASS_CDC_DMA_VA_TX1:
> +		ret = LPASS_CDC_DMA_INTERFACE2;
> +		break;
> +	case LPASS_CDC_DMA_RX2:
> +	case LPASS_CDC_DMA_TX2:
> +	case LPASS_CDC_DMA_VA_TX2:
> +		ret = LPASS_CDC_DMA_INTERFACE3;
> +		break;
> +	case LPASS_CDC_DMA_RX3:
> +	case LPASS_CDC_DMA_TX3:
> +	case LPASS_CDC_DMA_VA_TX3:
> +		ret = LPASS_CDC_DMA_INTERFACE4;
> +		break;
> +	case LPASS_CDC_DMA_RX4:
> +	case LPASS_CDC_DMA_TX4:
> +	case LPASS_CDC_DMA_VA_TX4:
> +		ret = LPASS_CDC_DMA_INTERFACE5;
> +		break;
> +	case LPASS_CDC_DMA_RX5:
> +	case LPASS_CDC_DMA_TX5:
> +	case LPASS_CDC_DMA_VA_TX5:
> +		ret = LPASS_CDC_DMA_INTERFACE6;
> +		break;
> +	case LPASS_CDC_DMA_RX6:
> +	case LPASS_CDC_DMA_TX6:
> +	case LPASS_CDC_DMA_VA_TX6:
> +		ret = LPASS_CDC_DMA_INTERFACE7;
> +		break;
> +	case LPASS_CDC_DMA_RX7:
> +	case LPASS_CDC_DMA_TX7:
> +	case LPASS_CDC_DMA_VA_TX7:
> +		ret = LPASS_CDC_DMA_INTERFACE8;
> +		break;
> +	case LPASS_CDC_DMA_RX8:
> +	case LPASS_CDC_DMA_TX8:
> +	case LPASS_CDC_DMA_VA_TX8:
> +		ret = LPASS_CDC_DMA_INTERFACE9;
> +		break;
> +	case LPASS_CDC_DMA_RX9:
> +		ret  = LPASS_CDC_DMA_INTERFACE10;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int __lpass_platform_codec_intf_init(struct snd_soc_dai *dai,
> +					    struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +	struct lpaif_dmactl *dmactl = NULL;
> +	struct device *dev = soc_runtime->dev;
> +	int ret, id, codec_intf;
> +	unsigned int dai_id = cpu_dai->driver->id;
> +
> +	codec_intf = __lpass_get_codec_dma_intf_type(dai_id);
> +	if (codec_intf < 0) {
> +		dev_err(dev, "failed to get codec_intf: %d\n", codec_intf);
> +		return codec_intf;
> +	}
> +
> +	__lpass_get_dmactl_handle(substream, dai, &dmactl, &id);
> +	if (!dmactl) {
> +		dev_err(dev, "failed to get dmactl handle for dai_id: %d\n", dai_id);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_fields_write(dmactl->codec_intf, id, codec_intf);
> +	if (ret) {
> +		dev_err(dev, "error writing to dmactl codec_intf reg field: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regmap_fields_write(dmactl->codec_fs_sel, id, 0x0);
> +	if (ret) {
> +		dev_err(dev, "error writing to dmactl codec_fs_sel reg field: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regmap_fields_write(dmactl->codec_fs_delay, id, 0x0);
> +	if (ret) {
> +		dev_err(dev, "error writing to dmactl codec_fs_delay reg field: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regmap_fields_write(dmactl->codec_pack, id, 0x1);
> +	if (ret) {
> +		dev_err(dev, "error writing to dmactl codec_pack reg field: %d\n", ret);
> +		return ret;
> +	}
> +	ret = regmap_fields_write(dmactl->codec_enable, id, LPAIF_DMACTL_ENABLE_ON);
> +	if (ret) {
> +		dev_err(dev, "error writing to dmactl codec_enable reg field: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int lpass_wcd_daiops_startup(struct snd_pcm_substream *substream,
> +				    struct snd_soc_dai *dai)
> +{
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +
> +	return clk_bulk_prepare_enable(drvdata->cdc_num_clks, drvdata->cdc_clks);
> +}
> +
> +static void lpass_wcd_daiops_shutdown(struct snd_pcm_substream *substream,
> +				      struct snd_soc_dai *dai)
> +{
> +	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +
> +	clk_bulk_disable_unprepare(drvdata->cdc_num_clks, drvdata->cdc_clks);
> +}
> +
> +static int lpass_wcd_daiops_hw_params(struct snd_pcm_substream *substream,
> +				      struct snd_pcm_hw_params *params,
> +				      struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct lpaif_dmactl *dmactl = NULL;
> +	unsigned int ret, regval;
> +	unsigned int channels = params_channels(params);
> +	int id;
> +
> +	switch (channels) {
> +	case 1:
> +		regval = LPASS_CDC_DMA_INTF_ONE_CHANNEL;
> +		break;
> +	case 2:
> +		regval = LPASS_CDC_DMA_INTF_TWO_CHANNEL;
> +		break;
> +	case 4:
> +		regval = LPASS_CDC_DMA_INTF_FOUR_CHANNEL;
> +		break;
> +	case 6:
> +		regval = LPASS_CDC_DMA_INTF_SIX_CHANNEL;
> +		break;
> +	case 8:
> +		regval = LPASS_CDC_DMA_INTF_EIGHT_CHANNEL;
> +		break;
> +	default:
> +		dev_err(soc_runtime->dev, "invalid PCM config\n");
> +		return -EINVAL;
> +	}
> +
> +	__lpass_get_dmactl_handle(substream, dai, &dmactl, &id);
> +	if (!dmactl) {
> +		dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +		return -EINVAL;
> +	}
> +	ret = regmap_fields_write(dmactl->codec_channel, id, regval);
> +	if (ret) {
> +		dev_err(soc_runtime->dev,
> +			"error writing to dmactl codec_channel reg field: %d\n", ret);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int lpass_wcd_daiops_trigger(struct snd_pcm_substream *substream,
> +				    int cmd, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +	struct lpaif_dmactl *dmactl;
> +	int ret = 0, id;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		__lpass_platform_codec_intf_init(dai, substream);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		__lpass_get_dmactl_handle(substream, dai, &dmactl, &id);
> +		if (!dmactl) {
> +			dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +			return -EINVAL;
> +		}
> +		ret = regmap_fields_write(dmactl->codec_enable, id, LPAIF_DMACTL_ENABLE_OFF);
> +		if (ret) {
> +			dev_err(soc_runtime->dev,
> +				"error writing to dmactl codec_enable reg: %d\n", ret);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(soc_runtime->dev, "%s: invalid %d interface\n", __func__, cmd);
> +		break;
> +	}
> +	return ret;
> +}
> +
> +const struct snd_soc_dai_ops asoc_qcom_lpass_wcd_dai_ops = {
> +	.startup	= lpass_wcd_daiops_startup,
> +	.shutdown	= lpass_wcd_daiops_shutdown,
> +	.hw_params	= lpass_wcd_daiops_hw_params,
> +	.trigger	= lpass_wcd_daiops_trigger,
> +};
> +EXPORT_SYMBOL_GPL(asoc_qcom_lpass_wcd_dai_ops);

can we remove the reference to wcd here, this is bascially codec dma 
driver and nothing to do with wcd. lets rename lpass_wcd_* to 
lpass_cdc_dma_* or somthing like that.

--srini
> +
> +MODULE_DESCRIPTION("QTi LPASS CDC DMA Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 4142f12..48602c1 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -403,5 +403,6 @@ int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai);
>   extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
>   int lpass_cpu_pcm_new(struct snd_soc_pcm_runtime *rtd,
>   				struct snd_soc_dai *dai);
> +extern const struct snd_soc_dai_ops asoc_qcom_lpass_wcd_dai_ops;
>   
>   #endif /* __LPASS_H__ */
> 
