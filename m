Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE73C464BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbhLAKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhLAKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:54:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86503C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:50:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t9so34253731wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iaRWBZ6wVn64G1eYkYsgJ4iKQtxS+t5xqE+mjeZLe9c=;
        b=LjOJIErsYA3H5R/SQ3MD0negXvGCfLzN7pYzmbRI9icpQz6ov+X3wjjzpbSp4pqnko
         pD1xP83AEpwysggEIadi2K24Tft1s86g/mSUuCA9d/EfpZrr7aDhCPEXwV4VwAzg9Spj
         9M4Qya3M8XGahlRBFlyBp+oG0hWjyZ1JLUftiNsKgkGkgyU0y/Z5oOga0mJQU3Q4xzri
         CPA/Z1FFGRhDjJCg2ApbPw9jHL/GJDgPlI2jCPMl/KPZlmHw1zBWQppm75vtf5dQBYfG
         6FV9+D2Jy8jucyR7nkc+Dp2VgTa5xP9E+0IvUHXQGhbIE+r8RbkIfyhwU8ol8hze8rV7
         v8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaRWBZ6wVn64G1eYkYsgJ4iKQtxS+t5xqE+mjeZLe9c=;
        b=qirHhbvdKUwvkLeEhZp5CVwt9e7/wXWncH0fW2PNp6ctPwQR6UTcu0JFXLi91o6p8M
         efIqDUqqqY1Bawst2Le7d0bx/ky8pjM4FGBAJHmxj+rrIrE8XBck7KIKEWmlArfTgnRx
         YykjvVaA+5Pl/RnCt8srXh2AHYwSSKI0q34hBp0Niiw+rHUmWVVuQPX/gtP8kmvbPcR8
         REaWPhuwbNB4iCM8sFFVddol7ogpT354d0xmtvAnw7gSwVsQVFSj5m9sFKEybBnvj/D7
         EBkK/e8kdlNoCuKGv7VNO1zyi/gslIMETTnCA/5cIRFHQIIfZ29Dh3g8Q9tWIsmmMRPA
         Zswg==
X-Gm-Message-State: AOAM530JYfSldD5AiGUQlvGxtu1AP9LLxmCL/tmrvjjBvsmEBTGLD/GL
        zZeMWzcU31sEEaCgtexblzTiuQ==
X-Google-Smtp-Source: ABdhPJzUoU308MNHGmdz4H3mCfq+Qg4jBYUexDHukpCokTgVqQC15BFqy/Uc3KNflk686Ows/ubGPA==
X-Received: by 2002:adf:ab53:: with SMTP id r19mr5827984wrc.584.1638355847050;
        Wed, 01 Dec 2021 02:50:47 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g18sm853449wmq.4.2021.12.01.02.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:50:46 -0800 (PST)
Subject: Re: [PATCH v6 10/10] ASoC: qcom: SC7280: Update config for building
 codec dma drivers
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
 <1637928282-2819-11-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0d51b0fd-61a9-e68f-6ab8-27708667d787@linaro.org>
Date:   Wed, 1 Dec 2021 10:50:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637928282-2819-11-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/11/2021 12:04, Srinivasa Rao Mandadapu wrote:
> Add configuration for building SC7280 audio codec dma drivers.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
> This patch set depends on:
>      -- https://patchwork.kernel.org/project/alsa-devel/list/?series=582321
> 
>   sound/soc/qcom/Kconfig  | 13 +++++++++++++
>   sound/soc/qcom/Makefile |  4 ++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 530d01f..b46a2e7 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -20,6 +20,10 @@ config SND_SOC_LPASS_PLATFORM
>   	tristate
>   	select REGMAP_MMIO
>   
> +config SND_SOC_LPASS_CDC_DMA
> +	tristate
> +	select REGMAP_MMIO
> +
>   config SND_SOC_LPASS_IPQ806X
>   	tristate
>   	select SND_SOC_LPASS_CPU
> @@ -36,6 +40,13 @@ config SND_SOC_LPASS_SC7180
>   	select SND_SOC_LPASS_PLATFORM
>   	select SND_SOC_LPASS_HDMI
>   
> +config SND_SOC_LPASS_SC7280
> +	tristate
> +	select SND_SOC_LPASS_CPU
> +	select SND_SOC_LPASS_PLATFORM
> +	select SND_SOC_LPASS_HDMI
> +	select SND_SOC_LPASS_CDC_DMA
> +
>   config SND_SOC_STORM
>   	tristate "ASoC I2S support for Storm boards"
>   	select SND_SOC_LPASS_IPQ806X
> @@ -156,7 +167,9 @@ config SND_SOC_SC7280
>   	tristate "SoC Machine driver for SC7280 boards"
>   	depends on I2C && SOUNDWIRE || COMPILE_TEST
>   	select SND_SOC_QCOM_COMMON
> +	select SND_SOC_LPASS_SC7280
>   	select SND_SOC_MAX98357A
> +	select SND_SOC_WCD938X

Why are we updating machine Kconfigs in this patch, should that be not 
in your machine driver patch series?

I think I did point this out in previous versions too.


--srini


>   	select SND_SOC_LPASS_RX_MACRO
>   	select SND_SOC_LPASS_TX_MACRO
>   	help
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 625aec6..8b7b876 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -1,18 +1,22 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # Platform
>   snd-soc-lpass-cpu-objs := lpass-cpu.o
> +snd-soc-lpass-cdc-dma-objs := lpass-cdc-dma.o
>   snd-soc-lpass-hdmi-objs := lpass-hdmi.o
>   snd-soc-lpass-platform-objs := lpass-platform.o
>   snd-soc-lpass-ipq806x-objs := lpass-ipq806x.o
>   snd-soc-lpass-apq8016-objs := lpass-apq8016.o
>   snd-soc-lpass-sc7180-objs := lpass-sc7180.o
> +snd-soc-lpass-sc7280-objs := lpass-sc7280.o
>   
>   obj-$(CONFIG_SND_SOC_LPASS_CPU) += snd-soc-lpass-cpu.o
> +obj-$(CONFIG_SND_SOC_LPASS_CDC_DMA) += snd-soc-lpass-cdc-dma.o
>   obj-$(CONFIG_SND_SOC_LPASS_HDMI) += snd-soc-lpass-hdmi.o
>   obj-$(CONFIG_SND_SOC_LPASS_PLATFORM) += snd-soc-lpass-platform.o
>   obj-$(CONFIG_SND_SOC_LPASS_IPQ806X) += snd-soc-lpass-ipq806x.o
>   obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
>   obj-$(CONFIG_SND_SOC_LPASS_SC7180) += snd-soc-lpass-sc7180.o
> +obj-$(CONFIG_SND_SOC_LPASS_SC7280) += snd-soc-lpass-sc7280.o
>   
>   # Machine
>   snd-soc-storm-objs := storm.o
> 
