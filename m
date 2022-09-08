Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFC5B1EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiIHN3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIHN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:28:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1245E11CD49
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:28:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so15423198lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=doeIJUD+jbYQvgjjpe7u4ffnL59KvvLjqzzYR74mkK4=;
        b=avEu5zd48R1MzFTlnzPIqcMco2yUpeclIORdLdB1h6dIPhw3W9n3hIfKj4vBe6WgX8
         5rFJnL2HA5mXPxj0if1BujlwcgQd4J7FrrDPBDE91rBor7br/WgDZEmg4sUbIkQb72Ja
         HW2OhkohN88xbyNgAY7NUrGdrtn7TtrjWAAOSExKah0Bc79IrkB2/XTPNYCrYS33DHMN
         SBGEcEbqWoVvhcClDYrvxkjV0c/V9exuqZlBI5Vskm4qvQtBX7m15dHQYAykeFmpENNJ
         6q+A2s6G+DaqfzXswG+tvbPl9V/UAae1UcQwJg7YQnmGxyruIttoaSAEINsWLWWCVsXS
         sMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=doeIJUD+jbYQvgjjpe7u4ffnL59KvvLjqzzYR74mkK4=;
        b=hh6myIlyPD5cmEt8SAty1mnA8KtTK8amO0QfIFgesqebM48wj5qJ1H0sSOp12xEUtV
         h53GHV0ggk3hj0VRK0LFPeHHg6tMwQKTeqaRLiACOAlkrJxl1gEilAXk8T3cMDwvR7Tg
         i2i4bD54goPXid17E+PUxHQviBmYb9tI7VyZcocLvqn5JAVaFfGz5lnDDLI4XwPQnFsE
         uGMxEfRaZ8oVNsJ5pf++/TM2XiMhiOHVb2mXt0l9ZlLtjDnEdMHqrby8Cid93zf7hodP
         Yarm7xjrFFiSsCg7JsS4nsXIzgkhD6mVCn+0Q54kVk1K3C9bM9IdmubQ9OJdUZgLo9MF
         afxA==
X-Gm-Message-State: ACgBeo2/uezgI3sH5I4uQUZQ/ggSJCKw2UDGqdQp9oLFPloLbT8xc+e9
        uqr3Is6Ex3KDR7ykGzFBcGOkcA==
X-Google-Smtp-Source: AA6agR5o1oU6A4OKEEHP/k2hlu7V48w9qePdjFGLujZ7qiDXSsH25XhzKTy8J8+/xOIVxvGF3umaag==
X-Received: by 2002:a05:6512:a8e:b0:492:b3e5:adcd with SMTP id m14-20020a0565120a8e00b00492b3e5adcdmr2723240lfu.374.1662643728120;
        Thu, 08 Sep 2022 06:28:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b00492c017de43sm3036675lfe.127.2022.09.08.06.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:28:47 -0700 (PDT)
Message-ID: <7206917a-1250-8669-0b25-fe5c18bbc98f@linaro.org>
Date:   Thu, 8 Sep 2022 15:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/4] ASoC: qcom: add machine driver for sc8280xp
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220906165508.30801-1-srinivas.kandagatla@linaro.org>
 <20220906165508.30801-5-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906165508.30801-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 18:55, Srinivas Kandagatla wrote:
> Add machine driver for sc8280xp SoC.
> 
> This intial supports only includes WSA883x Speakers and WCD938x based headset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/Kconfig    |  11 +++
>  sound/soc/qcom/Makefile   |   2 +
>  sound/soc/qcom/sc8280xp.c | 157 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 sound/soc/qcom/sc8280xp.c
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 750653404ba3..d0e59e07b1fc 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -173,6 +173,17 @@ config SND_SOC_SM8250
>  	  SM8250 SoC-based systems.
>  	  Say Y if you want to use audio device on this SoCs.
>  
> +config SND_SOC_SC8280XP
> +	tristate "SoC Machine driver for SC8280XP boards"
> +	depends on QCOM_APR && SOUNDWIRE

I think APR is not build time dependency, so:
	depends on QCOM_APR || COMPILE_TEST
	depends on SOUNDWIRE

> +	depends on COMMON_CLK
> +	select SND_SOC_QDSP6
> +	select SND_SOC_QCOM_COMMON
> +	help
> +	  To add support for audio on Qualcomm Technologies Inc.
> +	  SC8280XP SoC-based systems.
> +	  Say Y if you want to use audio device on this SoCs.
> +
>  config SND_SOC_SC7180
>  	tristate "SoC Machine driver for SC7180 boards"
>  	depends on I2C && GPIOLIB
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 8b7b876899a8..8b97172cf990 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -26,6 +26,7 @@ snd-soc-sc7180-objs := sc7180.o
>  snd-soc-sc7280-objs := sc7280.o
>  snd-soc-sdm845-objs := sdm845.o
>  snd-soc-sm8250-objs := sm8250.o
> +snd-soc-sc8280xp-objs := sc8280xp.o
>  snd-soc-qcom-common-objs := common.o
>  
>  obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
> @@ -33,6 +34,7 @@ obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>  obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
>  obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
>  obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
> +obj-$(CONFIG_SND_SOC_SC8280XP) += snd-soc-sc8280xp.o
>  obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
>  obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
>  obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> new file mode 100644
> index 000000000000..ade44ad7c585
> --- /dev/null
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2022, Linaro Limited
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <linux/soundwire/sdw.h>
> +#include <sound/jack.h>
> +#include <linux/input-event-codes.h>
> +#include "qdsp6/q6afe.h"
> +#include "common.h"
> +
> +#define DRIVER_NAME		"sc8280xp"
> +
> +struct sc8280xp_snd_data {
> +	bool stream_prepared[AFE_PORT_MAX];
> +	struct snd_soc_card *card;
> +	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
> +	struct snd_soc_jack jack;
> +	bool jack_setup;
> +};
> +
> +static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
> +}
> +
> +static int sc8280xp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> +				     struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	struct snd_interval *rate = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_RATE);
> +	struct snd_interval *channels = hw_param_interval(params,
> +					SNDRV_PCM_HW_PARAM_CHANNELS);
> +
> +	rate->min = rate->max = 48000;
> +	channels->min = 2;
> +	channels->max = 2;
> +	switch (cpu_dai->id) {
> +	case TX_CODEC_DMA_TX_0:
> +	case TX_CODEC_DMA_TX_1:
> +	case TX_CODEC_DMA_TX_2:
> +	case TX_CODEC_DMA_TX_3:
> +		channels->min = 1;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +

Just one blank line.


Best regards,
Krzysztof
