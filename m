Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C5467A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381724AbhLCPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381646AbhLCPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:25:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB3C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:21:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so6471122wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWBlTWNs/SDRDxcsHdXQ/DBHT2ACOQuzczNNaBJvbGY=;
        b=n1qKX7CfMzr4yCAZC9iSYNLdp7VBfQxHHj5oZ6QrGM8NZY0WIqd6gHb4vo9dBWkQHi
         +5z53Dr7s7yweBq14ZJShl2FihQ22vaFl+NzBuaGL8MaWAzD7SspZqEnK9eu9kdoHRLu
         Z5Zhu2xayKowcOwCc4CGyMKLaDYhjf0HS8+vZj9yJ+asrzmuXoku1dER4OYK3XVFngpt
         Z6h2vMNQsw8/ztpVi6VubQCgiQcgoPXNsQECwxkcxhwiH1Ga0fkr0gVSc6I/sUPE/h0T
         cZrYaoNapMNsV6uVrgJPS5+ubpY9umj0Mv8L94E6nOkgtPKA3PUdY9d597LNbyvKLZmE
         G1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWBlTWNs/SDRDxcsHdXQ/DBHT2ACOQuzczNNaBJvbGY=;
        b=e9BBUvmJni9ux2+pVtZm1Csxh0HmvoM6vX0C/Pb36D1LhHGjOAy0Wh10mPaq6zdUPs
         32KVxqsjavwtu42DfRGSxun6AvBS5AqWNWlb1WFbyFByHR+DfDXi6PROgqEY2ui0bGBO
         oiTHlrIOocOrN5kzRXUUE4bUOufmw4ktfeU7dLULImx8OKfuKIVISzSpPuhiO7MCOLBG
         MrbGFc4Q8rm18vHOJoUEBXRisFumWu8CGFoN0u8ZE9UjojcInUg6SMaEUZF53EnCBdl9
         UfgZxHXEnupLNFrnhkUQsQZ6hrLGQyUKBagR38mX0cwJ/mwtRusz/E8KQMBT+i6awme6
         aS0Q==
X-Gm-Message-State: AOAM5306idGy4fmARq/VyiLfCHCcRKrQL5HAamiqhRLnqIH9hmLb+rvP
        u51U9GowEf0tD5jOr/9pB+8GNA==
X-Google-Smtp-Source: ABdhPJy1yWegc3CaZOHkauWkJOjTboULhasYlk4AaL+a0tQia5tvbT2eDC/LqcL9NV5yVluiLFeLIg==
X-Received: by 2002:adf:f209:: with SMTP id p9mr21771829wro.191.1638544909324;
        Fri, 03 Dec 2021 07:21:49 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id a1sm3945521wri.89.2021.12.03.07.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 07:21:48 -0800 (PST)
Subject: Re: [PATCH v7 2/2] ASoC: qcom: SC7280: Add machine driver
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
References: <1638533183-19023-1-git-send-email-srivasam@codeaurora.com>
 <1638533183-19023-3-git-send-email-srivasam@codeaurora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a564d5d5-5f31-2005-3546-2390bba3ff9e@linaro.org>
Date:   Fri, 3 Dec 2021 15:21:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638533183-19023-3-git-send-email-srivasam@codeaurora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2021 12:06, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Add new machine driver to register sound card on sc7280 based targets and
> do the required configuration for lpass cpu dai and external codecs
> connected over MI2S and soundwire interfaces.
> Add support for audio jack detection, soundwire init and MBHC.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig  |  14 +++
>   sound/soc/qcom/Makefile |   2 +
>   sound/soc/qcom/lpass.h  |   1 +
>   sound/soc/qcom/sc7280.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 307 insertions(+)
>   create mode 100644 sound/soc/qcom/sc7280.c

Overall it looks good, but few nits below.

> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index cc7c1de..932b082 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -152,4 +152,18 @@ config SND_SOC_SC7180
>   	  SC7180 SoC-based systems.
>   	  Say Y if you want to use audio device on this SoCs.
>   
> +config SND_SOC_SC7280
> +	tristate "SoC Machine driver for SC7280 boards"
> +	depends on I2C && SOUNDWIRE || COMPILE_TEST
> +	select SND_SOC_QCOM_COMMON
> +	select SND_SOC_LPASS_SC7280
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_WCD938X
> +	select SND_SOC_LPASS_RX_MACRO
> +	select SND_SOC_LPASS_TX_MACRO
> +	help
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
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 67ef497..c0f0247 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -16,6 +16,7 @@
>   #include "lpass-hdmi.h"
>   
>   #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
> +#define LPASS_MAX_PORTS			(LPASS_CDC_DMA_VA_TX8 + 1)

This change does not really belong in this patch, can you move this into 
a separate patch?


>   #define LPASS_MAX_MI2S_PORTS			(8)
>   #define LPASS_MAX_DMA_CHANNELS			(8)
>   #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
> new file mode 100644
> index 0000000..31a77eb
> --- /dev/null
> +++ b/sound/soc/qcom/sc7280.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> +//
> +// ALSA SoC Machine driver for sc7280
> +
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/jack.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <linux/soundwire/sdw.h>
> +
...

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

This is not used anywhere in the file.

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
> +MODULE_LICENSE("GPL");
> 
