Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32905467843
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352341AbhLCNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381004AbhLCNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:32:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6286FC061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:29:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4882225wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d5gNPuGMqEBCQOvyEm6d2w9B9HQg14p4mfsi39stRSQ=;
        b=UwYmCKEusdnSzxX/yNE3ZpNqgjr1aWu8Bt/ONbjCh/htpBRx/2muM24pxEF5AGj9n6
         9ejjWPqVUWWuUEld1IE956B9lEr7Cz3w6KgOy2AVsaYBa5gJJk9mmYqE0qoAtj98lp9f
         eu5rp9hnDzwlXldGUKMM1nEA3V2YckdPX5OxiGwiQ3JHEmoLf70oJNc8H62enN9pmHx9
         H4MOnb3+iby7vvlpXoCVFAYWjExccjXltUKjWT9gqIwxuf0F6JKkvYnbaj8OvMJK0JLe
         79vqlZb24VQXx75yQnY3OlxgeJIEZIShZSTJJLnlTHcW67afNyhbdIskfAukTcxUl4AR
         z+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5gNPuGMqEBCQOvyEm6d2w9B9HQg14p4mfsi39stRSQ=;
        b=67IEQLwwlxrjmKQ3rdU8+z08dTddEZhilfeHDAVboxjErXk581SXOLUQeFSp6+uqH0
         bf1zTMyPWgWSt6puUJ3AChF1j5BHuhC5SYDzAsGJGt3wOYP0kAuqiLX1koWj8cFNjpOD
         wjAnf/yDA4q9eRNOSPixdqx7E2wdVQUJpb2cBKRP/HGeZ4xKRcb0WBa4fIG1ujC9LsWO
         dow+s5l0KwjmsXNqnaP+90YlI6uKFsYeqv1+F8B00sb5e3xbrtnMoPLtCs3NFDbtfGld
         c54H00g++6MzFtdVxoQYuob04TxUWJOhoxqtLXvrufP3tMJSAjYbTqofKGHdTh0UQOj9
         X1Jw==
X-Gm-Message-State: AOAM530tOAc2WXQYYiON2NzgUPWqbg8fFiZ260s1aqnxwE/naBD9NWz9
        r7ORjvaZDiN7PSbLU4AG2Oy4rw==
X-Google-Smtp-Source: ABdhPJw2WV1dG3c8ubp8oftVX/VXSPKwfuRdAEDcaFWf5DM693KNQQ6uWF8VEt9MipxgWa1e7Byxsw==
X-Received: by 2002:a05:600c:3ba5:: with SMTP id n37mr14929421wms.168.1638538173898;
        Fri, 03 Dec 2021 05:29:33 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l3sm3183359wmq.46.2021.12.03.05.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:29:33 -0800 (PST)
Subject: Re: [PATCH v7 09/10] ASoC: qcom: lpass-sc7280: Add platform driver
 for lpass audio
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
 <1638459806-27600-10-git-send-email-srivasam@codeaurora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <54d4dd08-f20a-aa3b-4bdb-616340d49349@linaro.org>
Date:   Fri, 3 Dec 2021 13:29:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638459806-27600-10-git-send-email-srivasam@codeaurora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 15:43, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Add platform driver for configuring sc7280 lpass core I2S and
> DMA configuration to support playback & capture to external codecs
> connected over secondary MI2S interface and soundwire interface.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>

overall the patch LGTM, but some indentation seems to be off
once that are addressed you can add my

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/qcom/lpass-sc7280.c | 441 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 441 insertions(+)
>   create mode 100644 sound/soc/qcom/lpass-sc7280.c
> 
> diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
> new file mode 100644
> index 0000000..302a112
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-sc7280.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + *
> + * lpass-sc7180.c -- ALSA SoC platform-machine driver for QTi LPASS
> + */
> +
> +#include <linux/module.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <dt-bindings/sound/sc7180-lpass.h>
> +
> +#include "lpass-lpaif-reg.h"
> +#include "lpass.h"
> +
> +static struct snd_soc_dai_driver sc7280_lpass_cpu_dai_driver[] = {
> +	{
> +		.id = MI2S_PRIMARY,
> +		.name = "Primary MI2S",
> +		.playback = {
> +			.stream_name = "Primary Playback",
> +			.formats	= SNDRV_PCM_FMTBIT_S16,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +		},
> +		.capture = {
> +			.stream_name = "Primary Capture",
> +			.formats = SNDRV_PCM_FMTBIT_S16 |
> +				SNDRV_PCM_FMTBIT_S32,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +		},
> +		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
> +		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
> +	}, {
> +		.id = MI2S_SECONDARY,
> +		.name = "Secondary MI2S",
> +		.playback = {
> +			.stream_name = "Secondary MI2S Playback",
> +			.formats = SNDRV_PCM_FMTBIT_S16,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +		},
> +		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
> +		.ops	= &asoc_qcom_lpass_cpu_dai_ops,
> +	}, {
> +		.id = LPASS_DP_RX,
> +		.name = "Hdmi",
> +		.playback = {
> +			.stream_name = "DP Playback",
> +			.formats = SNDRV_PCM_FMTBIT_S24,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +		},
> +		.ops	= &asoc_qcom_lpass_hdmi_dai_ops,
> +	}, {
> +		.id = LPASS_CDC_DMA_RX0,
> +		.name = "CDC DMA RX",
> +		.playback = {
> +			.stream_name = "WCD Playback",
> +			.formats = SNDRV_PCM_FMTBIT_S16,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +		},
> +		.ops	= &asoc_qcom_lpass_cdc_dma_dai_ops,
> +	}, {
> +		.id = LPASS_CDC_DMA_TX3,
> +		.name = "CDC DMA TX",
> +		.capture = {
> +			.stream_name = "WCD Capture",
> +			.formats = SNDRV_PCM_FMTBIT_S16,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 1,
> +			.channels_max	= 2,
> +		},
> +		.ops	= &asoc_qcom_lpass_cdc_dma_dai_ops,
> +	}, {
> +		.id = LPASS_CDC_DMA_VA_TX0,
> +		.name = "CDC DMA VA",
> +		.capture = {
> +			.stream_name = "DMIC Capture",
> +			.formats = SNDRV_PCM_FMTBIT_S16,
> +			.rates = SNDRV_PCM_RATE_48000,
> +			.rate_min	= 48000,
> +			.rate_max	= 48000,
> +			.channels_min	= 2,
> +			.channels_max	= 4,
> +		},
> +		.ops	= &asoc_qcom_lpass_cdc_dma_dai_ops,
> +	},
> +};
> +
> +static int sc7280_lpass_alloc_dma_channel(struct lpass_data *drvdata,
> +					  int direction, unsigned int dai_id)
> +{
> +	struct lpass_variant *v = drvdata->variant;
> +	int chan = 0;
> +
> +	switch (dai_id) {
> +	case MI2S_PRIMARY ... MI2S_QUINARY:
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +			chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
> +									v->rdma_channels);

Indentation is really off, take some time to fix such instances.


> +
> +			if (chan >= v->rdma_channels)
> +				return -EBUSY;
> +		} else {
> +			chan = find_next_zero_bit(&drvdata->dma_ch_bit_map,
> +							v->wrdma_channel_start +
> +							v->wrdma_channels,
> +							v->wrdma_channel_start);
> +
> +			if (chan >= v->wrdma_channel_start + v->wrdma_channels)
> +				return -EBUSY;
> +		}
> +		set_bit(chan, &drvdata->dma_ch_bit_map);
> +		break;
> +	case LPASS_DP_RX:
> +		chan = find_first_zero_bit(&drvdata->hdmi_dma_ch_bit_map,
> +								v->hdmi_rdma_channels);
> +		if (chan >= v->hdmi_rdma_channels)
> +			return -EBUSY;
> +		set_bit(chan, &drvdata->hdmi_dma_ch_bit_map);
> +		break;
> +	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +		chan = find_first_zero_bit(&drvdata->rxtx_dma_ch_bit_map,
> +									v->rxtx_rdma_channels);
> +		if (chan >= v->rxtx_rdma_channels)
> +			return -EBUSY;
> +		break;
> +	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +		chan = find_next_zero_bit(&drvdata->rxtx_dma_ch_bit_map,
> +						v->rxtx_wrdma_channel_start +
> +						v->rxtx_wrdma_channels,
> +						v->rxtx_wrdma_channel_start);
> +		if (chan >= v->rxtx_wrdma_channel_start + v->rxtx_wrdma_channels)
> +			return -EBUSY;
> +		set_bit(chan, &drvdata->rxtx_dma_ch_bit_map);
> +		break;
> +	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +		chan = find_next_zero_bit(&drvdata->va_dma_ch_bit_map,
> +						v->va_wrdma_channel_start +
> +						v->va_wrdma_channels,
> +						v->va_wrdma_channel_start);
> +		if (chan >= v->va_wrdma_channel_start + v->va_wrdma_channels)
> +			return -EBUSY;
> +		set_bit(chan, &drvdata->va_dma_ch_bit_map);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return chan;
> +}
> +
> +static int sc7280_lpass_free_dma_channel(struct lpass_data *drvdata, int chan, unsigned int dai_id)
> +{
> +	switch (dai_id) {
> +	case MI2S_PRIMARY ... MI2S_QUINARY:
> +		clear_bit(chan, &drvdata->dma_ch_bit_map);
> +		break;
> +	case LPASS_DP_RX:
> +		clear_bit(chan, &drvdata->hdmi_dma_ch_bit_map);
> +		break;
> +	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +		clear_bit(chan, &drvdata->rxtx_dma_ch_bit_map);
> +		break;
> +	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +		clear_bit(chan, &drvdata->va_dma_ch_bit_map);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc7280_lpass_init(struct platform_device *pdev)
> +{
> +	struct lpass_data *drvdata = platform_get_drvdata(pdev);
> +	struct lpass_variant *variant = drvdata->variant;
> +	struct device *dev = &pdev->dev;
> +
> +	drvdata->clks = devm_kcalloc(dev, variant->num_clks,
> +					sizeof(*drvdata->clks), GFP_KERNEL);
> +	if (!drvdata->clks)
> +		return -ENOMEM;
> +
> +	drvdata->num_clks = variant->num_clks;
> +
> +	drvdata->aon_cc_audio_hm_h = devm_clk_get(dev, "lpass_aon_cc_audio_hm_h_clk");
> +	if (IS_ERR(drvdata->aon_cc_audio_hm_h))
> +		return PTR_ERR(drvdata->aon_cc_audio_hm_h);
> +	drvdata->core_cc_sysnoc_mport_core = devm_clk_get(dev,
> +					"lpass_core_cc_sysnoc_mport_core_clk");
> +	if (IS_ERR(drvdata->core_cc_sysnoc_mport_core))
> +		return PTR_ERR(drvdata->core_cc_sysnoc_mport_core);
> +
> +	clk_prepare_enable(drvdata->aon_cc_audio_hm_h);
> +	clk_prepare_enable(drvdata->core_cc_sysnoc_mport_core);
> +	return 0;
> +}
> +
> +static int sc7280_lpass_exit(struct platform_device *pdev)
> +{
> +	struct lpass_data *drvdata = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(drvdata->core_cc_sysnoc_mport_core);
> +	clk_disable_unprepare(drvdata->aon_cc_audio_hm_h);
> +
> +	return 0;
> +}
> +
> +static struct lpass_variant sc7280_data = {
> +	.i2sctrl_reg_base		= 0x1000,
> +	.i2sctrl_reg_stride		= 0x1000,
> +	.i2s_ports			= 3,
> +	.irq_reg_base			= 0x9000,
> +	.irq_reg_stride			= 0x1000,
> +	.irq_ports			= 3,
> +	.rdma_reg_base			= 0xC000,
> +	.rdma_reg_stride		= 0x1000,
> +	.rdma_channels			= 5,
> +	.rxtx_rdma_reg_base		= 0xC000,
> +	.rxtx_rdma_reg_stride		= 0x1000,
> +	.rxtx_rdma_channels		= 8,
> +	.hdmi_rdma_reg_base		= 0x64000,
> +	.hdmi_rdma_reg_stride		= 0x1000,
> +	.hdmi_rdma_channels		= 4,
> +	.dmactl_audif_start		= 1,
> +	.wrdma_reg_base			= 0x18000,
> +	.wrdma_reg_stride		= 0x1000,
> +	.wrdma_channel_start		= 5,
> +	.wrdma_channels			= 4,
> +	.rxtx_irq_reg_base		= 0x9000,
> +	.rxtx_irq_reg_stride		= 0x1000,
> +	.rxtx_irq_ports			= 3,
> +	.rxtx_wrdma_reg_base		= 0x18000,
> +	.rxtx_wrdma_reg_stride		= 0x1000,
> +	.rxtx_wrdma_channel_start	= 5,
> +	.rxtx_wrdma_channels		= 6,
> +	.va_wrdma_reg_base		= 0x18000,
> +	.va_wrdma_reg_stride		= 0x1000,
> +	.va_wrdma_channel_start		= 5,
> +	.va_wrdma_channels		= 3,
> +	.va_irq_reg_base		= 0x9000,
> +	.va_irq_reg_stride		= 0x1000,
> +	.va_irq_ports			= 3,
> +
> +	.loopback			= REG_FIELD_ID(0x1000, 17, 17, 3, 0x1000),
> +	.spken				= REG_FIELD_ID(0x1000, 16, 16, 3, 0x1000),
> +	.spkmode			= REG_FIELD_ID(0x1000, 11, 15, 3, 0x1000),
> +	.spkmono			= REG_FIELD_ID(0x1000, 10, 10, 3, 0x1000),
> +	.micen				= REG_FIELD_ID(0x1000, 9, 9, 3, 0x1000),
> +	.micmode			= REG_FIELD_ID(0x1000, 4, 8, 3, 0x1000),
> +	.micmono			= REG_FIELD_ID(0x1000, 3, 3, 3, 0x1000),
> +	.wssrc				= REG_FIELD_ID(0x1000, 2, 2, 3, 0x1000),
> +	.bitwidth			= REG_FIELD_ID(0x1000, 0, 1, 3, 0x1000),
> +
> +	.rdma_dyncclk			= REG_FIELD_ID(0xC000, 21, 21, 5, 0x1000),
> +	.rdma_bursten			= REG_FIELD_ID(0xC000, 20, 20, 5, 0x1000),
> +	.rdma_wpscnt			= REG_FIELD_ID(0xC000, 16, 19, 5, 0x1000),
> +	.rdma_intf			= REG_FIELD_ID(0xC000, 12, 15, 5, 0x1000),
> +	.rdma_fifowm			= REG_FIELD_ID(0xC000, 1, 5, 5, 0x1000),
> +	.rdma_enable			= REG_FIELD_ID(0xC000, 0, 0, 5, 0x1000),
> +
> +	.wrdma_dyncclk			= REG_FIELD_ID(0x18000, 22, 22, 4, 0x1000),
> +	.wrdma_bursten			= REG_FIELD_ID(0x18000, 21, 21, 4, 0x1000),
> +	.wrdma_wpscnt			= REG_FIELD_ID(0x18000, 17, 20, 4, 0x1000),
> +	.wrdma_intf			= REG_FIELD_ID(0x18000, 12, 16, 4, 0x1000),
> +	.wrdma_fifowm			= REG_FIELD_ID(0x18000, 1, 5, 4, 0x1000),
> +	.wrdma_enable			= REG_FIELD_ID(0x18000, 0, 0, 4, 0x1000),
> +
> +	.rxtx_rdma_enable		= REG_FIELD_ID(0xC000, 0, 0, 7, 0x1000),
> +	.rxtx_rdma_fifowm		= REG_FIELD_ID(0xC000, 1, 11, 7, 0x1000),
> +	.rxtx_rdma_intf			= REG_FIELD_ID(0xC000, 12, 15, 7, 0x1000),
> +	.rxtx_rdma_wpscnt		= REG_FIELD_ID(0xC000, 16, 19, 7, 0x1000),
> +	.rxtx_rdma_bursten		= REG_FIELD_ID(0xC000, 20, 20, 7, 0x1000),
> +	.rxtx_rdma_dyncclk		= REG_FIELD_ID(0xC000, 21, 21, 7, 0x1000),
> +
> +	.rxtx_rdma_codec_ch		= REG_FIELD_ID(0xC050, 0, 7, 7, 0x1000),
> +	.rxtx_rdma_codec_intf		= REG_FIELD_ID(0xC050, 16, 19, 7, 0x1000),
> +	.rxtx_rdma_codec_fs_delay	= REG_FIELD_ID(0xC050, 21, 24, 7, 0x1000),
> +	.rxtx_rdma_codec_fs_sel		= REG_FIELD_ID(0xC050, 25, 27, 7, 0x1000),
> +	.rxtx_rdma_codec_pack		= REG_FIELD_ID(0xC050, 29, 29, 5, 0x1000),
> +	.rxtx_rdma_codec_enable		= REG_FIELD_ID(0xC050, 30, 30, 7, 0x1000),
> +
> +	.rxtx_wrdma_enable		= REG_FIELD_ID(0x18000, 0, 0, 5, 0x1000),
> +	.rxtx_wrdma_fifowm		= REG_FIELD_ID(0x18000, 1, 11, 5, 0x1000),
> +	.rxtx_wrdma_intf		= REG_FIELD_ID(0x18000, 12, 16, 5, 0x1000),
> +	.rxtx_wrdma_wpscnt		= REG_FIELD_ID(0x18000, 17, 20, 5, 0x1000),
> +	.rxtx_wrdma_bursten		= REG_FIELD_ID(0x18000, 21, 21, 5, 0x1000),
> +	.rxtx_wrdma_dyncclk		= REG_FIELD_ID(0x18000, 22, 22, 5, 0x1000),
> +
> +	.rxtx_wrdma_codec_ch		= REG_FIELD_ID(0x18050, 0, 7, 5, 0x1000),
> +	.rxtx_wrdma_codec_intf		= REG_FIELD_ID(0x18050, 16, 19, 5, 0x1000),
> +	.rxtx_wrdma_codec_fs_delay	= REG_FIELD_ID(0x18050, 21, 24, 5, 0x1000),
> +	.rxtx_wrdma_codec_fs_sel	= REG_FIELD_ID(0x18050, 25, 27, 5, 0x1000),
> +	.rxtx_wrdma_codec_pack		= REG_FIELD_ID(0x18050, 29, 29, 5, 0x1000),
> +	.rxtx_wrdma_codec_enable	= REG_FIELD_ID(0x18050, 30, 30, 5, 0x1000),
> +
> +	.va_wrdma_enable		= REG_FIELD_ID(0x18000, 0, 0, 5, 0x1000),
> +	.va_wrdma_fifowm		= REG_FIELD_ID(0x18000, 1, 11, 5, 0x1000),
> +	.va_wrdma_intf			= REG_FIELD_ID(0x18000, 12, 16, 5, 0x1000),
> +	.va_wrdma_wpscnt		= REG_FIELD_ID(0x18000, 17, 20, 5, 0x1000),
> +	.va_wrdma_bursten		= REG_FIELD_ID(0x18000, 21, 21, 5, 0x1000),
> +	.va_wrdma_dyncclk		= REG_FIELD_ID(0x18000, 22, 22, 5, 0x1000),
> +
> +	.va_wrdma_codec_ch		= REG_FIELD_ID(0x18050, 0, 7, 5, 0x1000),
> +	.va_wrdma_codec_intf		= REG_FIELD_ID(0x18050, 16, 19, 5, 0x1000),
> +	.va_wrdma_codec_fs_delay	= REG_FIELD_ID(0x18050, 21, 24, 5, 0x1000),
> +	.va_wrdma_codec_fs_sel		= REG_FIELD_ID(0x18050, 25, 27, 5, 0x1000),
> +	.va_wrdma_codec_pack		= REG_FIELD_ID(0x18050, 29, 29, 5, 0x1000),
> +	.va_wrdma_codec_enable		= REG_FIELD_ID(0x18050, 30, 30, 5, 0x1000),
> +
> +	.hdmi_tx_ctl_addr		= 0x1000,
> +	.hdmi_legacy_addr		= 0x1008,
> +	.hdmi_vbit_addr			= 0x610c0,
> +	.hdmi_ch_lsb_addr		= 0x61048,
> +	.hdmi_ch_msb_addr		= 0x6104c,
> +	.ch_stride			= 0x8,
> +	.hdmi_parity_addr		= 0x61034,
> +	.hdmi_dmactl_addr		= 0x61038,
> +	.hdmi_dma_stride		= 0x4,
> +	.hdmi_DP_addr			= 0x610c8,
> +	.hdmi_sstream_addr		= 0x6101c,
> +	.hdmi_irq_reg_base		= 0x63000,
> +	.hdmi_irq_ports			= 1,
> +
> +	.hdmi_rdma_dyncclk		= REG_FIELD_ID(0x64000, 14, 14, 4, 0x1000),
> +	.hdmi_rdma_bursten		= REG_FIELD_ID(0x64000, 13, 13, 4, 0x1000),
> +	.hdmi_rdma_burst8		= REG_FIELD_ID(0x64000, 15, 15, 4, 0x1000),
> +	.hdmi_rdma_burst16		= REG_FIELD_ID(0x64000, 16, 16, 4, 0x1000),
> +	.hdmi_rdma_dynburst		= REG_FIELD_ID(0x64000, 18, 18, 4, 0x1000),
> +	.hdmi_rdma_wpscnt		= REG_FIELD_ID(0x64000, 10, 12, 4, 0x1000),
> +	.hdmi_rdma_fifowm		= REG_FIELD_ID(0x64000, 1, 5, 4, 0x1000),
> +	.hdmi_rdma_enable		= REG_FIELD_ID(0x64000, 0, 0, 4, 0x1000),
> +
> +	.sstream_en			= REG_FIELD(0x6101c, 0, 0),
> +	.dma_sel			= REG_FIELD(0x6101c, 1, 2),
> +	.auto_bbit_en			= REG_FIELD(0x6101c, 3, 3),
> +	.layout				= REG_FIELD(0x6101c, 4, 4),
> +	.layout_sp			= REG_FIELD(0x6101c, 5, 8),
> +	.set_sp_on_en			= REG_FIELD(0x6101c, 10, 10),
> +	.dp_audio			= REG_FIELD(0x6101c, 11, 11),
> +	.dp_staffing_en			= REG_FIELD(0x6101c, 12, 12),
> +	.dp_sp_b_hw_en			= REG_FIELD(0x6101c, 13, 13),
> +
> +	.mute				= REG_FIELD(0x610c8, 0, 0),
> +	.as_sdp_cc			= REG_FIELD(0x610c8, 1, 3),
> +	.as_sdp_ct			= REG_FIELD(0x610c8, 4, 7),
> +	.aif_db4			= REG_FIELD(0x610c8, 8, 15),
> +	.frequency			= REG_FIELD(0x610c8, 16, 21),
> +	.mst_index			= REG_FIELD(0x610c8, 28, 29),
> +	.dptx_index			= REG_FIELD(0x610c8, 30, 31),
> +
> +	.soft_reset			= REG_FIELD(0x1000, 31, 31),
> +	.force_reset			= REG_FIELD(0x1000, 30, 30),
> +
> +	.use_hw_chs			= REG_FIELD(0x61038, 0, 0),
> +	.use_hw_usr			= REG_FIELD(0x61038, 1, 1),
> +	.hw_chs_sel			= REG_FIELD(0x61038, 2, 4),
> +	.hw_usr_sel			= REG_FIELD(0x61038, 5, 6),
> +
> +	.replace_vbit			= REG_FIELD(0x610c0, 0, 0),
> +	.vbit_stream			= REG_FIELD(0x610c0, 1, 1),
> +
> +	.legacy_en			=  REG_FIELD(0x1008, 0, 0),
> +	.calc_en			=  REG_FIELD(0x61034, 0, 0),
> +	.lsb_bits			=  REG_FIELD(0x61048, 0, 31),
> +	.msb_bits			=  REG_FIELD(0x6104c, 0, 31),
> +
> +
> +	.clk_name			= (const char*[]) {
> +							"lpass_aon_cc_audio_hm_h_clk",
> +							"lpass_core_cc_sysnoc_mport_core_clk"
> +						},
> +	.num_clks			= 2,
> +	.cdc_dma_clk_names		= (const char*[]) {
> +							"lpass_audio_cc_codec_mem0_clk",
> +							"lpass_audio_cc_codec_mem1_clk",
> +							"lpass_audio_cc_codec_mem2_clk",
> +							"lpass_aon_cc_va_mem0_clk"
> +							},
> +	.cdc_dma_num_clks		= 4,
> +	.dai_driver			= sc7280_lpass_cpu_dai_driver,
> +	.num_dai			= ARRAY_SIZE(sc7280_lpass_cpu_dai_driver),
> +	.dai_osr_clk_names		= (const char *[]) {
> +							"null",
> +							"null"
> +							},
> +	.dai_bit_clk_names		= (const char *[]) {
> +							"lpass_core_cc_ext_if0_ibit_clk",
> +							"lpass_core_cc_ext_if1_ibit_clk"
> +							},
> +	.init				= sc7280_lpass_init,
> +	.exit				= sc7280_lpass_exit,
> +	.alloc_dma_channel		= sc7280_lpass_alloc_dma_channel,
> +	.free_dma_channel		= sc7280_lpass_free_dma_channel,
> +};
> +
> +static const struct of_device_id sc7280_lpass_cpu_device_id[] = {
> +	{.compatible = "qcom,sc7280-lpass-cpu", .data = &sc7280_data},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sc7280_lpass_cpu_device_id);
> +
> +static struct platform_driver sc7280_lpass_cpu_platform_driver = {
> +	.driver = {
> +		.name = "sc7280-lpass-cpu",
> +		.of_match_table = of_match_ptr(sc7280_lpass_cpu_device_id),
> +	},
> +	.probe = asoc_qcom_lpass_cpu_platform_probe,
> +	.remove = asoc_qcom_lpass_cpu_platform_remove,
> +	.shutdown = asoc_qcom_lpass_cpu_platform_shutdown,
> +};
> +
> +module_platform_driver(sc7280_lpass_cpu_platform_driver);
> +
> +MODULE_DESCRIPTION("SC7280 LPASS CPU DRIVER");
> +MODULE_LICENSE("GPL");
> 
