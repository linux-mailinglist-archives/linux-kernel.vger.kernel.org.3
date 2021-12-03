Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A7467627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380375AbhLCLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:24:37 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:32694 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380366AbhLCLYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:24:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638530472; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: Cc: From: References: To:
 Subject: Sender; bh=pDtEZWS5YSI3FoY4bVEoYtx82qBri66Tr+JZ7waSoZg=; b=eN1ft/pCbMp9Z7zOulyk+sOmqfKmGg+2RDKLA8+LFIHcucwJ24VzXmilOppN4wp9/8WfLxPM
 SEvhuQUwm5ta7eeF4pKUVYg9RHSQOeMR4WkhpFlP87918aO1C4OJJna+wfF1w9egO3BI0CRX
 sGZSbfGrmEWZMOjueN0YUyEZByI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61a9fda8db3ac5552aa565c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 11:21:12
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D636C43616; Fri,  3 Dec 2021 11:21:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.242.143.72] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E33E8C4338F;
        Fri,  3 Dec 2021 11:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E33E8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v6 2/2] ASoC: qcom: SC7280: Add machine driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <1637239506-9387-1-git-send-email-srivasam@codeaurora.org>
 <1637239506-9387-3-git-send-email-srivasam@codeaurora.org>
 <5d0ca118-2a38-a7cf-ebec-f28f98078583@linaro.org>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Cc:     "Venkata Prasad Potturu (Temp)" <potturu@codeaurora.org>
Message-ID: <c68f85f1-b4a8-6abe-35c8-afa2ae373a77@codeaurora.org>
Date:   Fri, 3 Dec 2021 16:51:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5d0ca118-2a38-a7cf-ebec-f28f98078583@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2021 10:03 PM, Srinivas Kandagatla wrote:
Thanks for Your time Srini!!!
>
> On 18/11/2021 12:45, Srinivasa Rao Mandadapu wrote:
>> Add new machine driver to register sound card on sc7280 based targets 
>> and
>> do the required configuration for lpass cpu dai and external codecs
>> connected over MI2S and soundwire interfaces.
>> Add support for audio jack detection, soundwire init and MBHC.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> ---
>>   sound/soc/qcom/Kconfig  |  12 ++
>>   sound/soc/qcom/Makefile |   2 +
>>   sound/soc/qcom/sc7280.c | 299 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 313 insertions(+)
>>   create mode 100644 sound/soc/qcom/sc7280.c
>>
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index cc7c1de..530d01f 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -152,4 +152,16 @@ config SND_SOC_SC7180
>>         SC7180 SoC-based systems.
>>         Say Y if you want to use audio device on this SoCs.
>>   +config SND_SOC_SC7280
>> +    tristate "SoC Machine driver for SC7280 boards"
>> +    depends on I2C && SOUNDWIRE || COMPILE_TEST
>> +    select SND_SOC_QCOM_COMMON
>> +    select SND_SOC_MAX98357A
>> +    select SND_SOC_LPASS_RX_MACRO
>> +    select SND_SOC_LPASS_TX_MACRO
>
> Consider adding
>
> +    select SND_SOC_LPASS_SC7280
> +    select SND_SOC_WCD938X
>
>
> and remove them from "[PATCH v6 10/10] ASoC: qcom: SC7280: Update 
> config for building codec dma drivers"
>
Okay.. Will do accordingly.
>
>> +      Add support for audio on Qualcomm Technologies Inc.
>> +      SC7280 SoC-based systems.
>> +      Say Y or M if you want to use audio device on this SoCs.
>> +
>>   endif #SND_SOC_QCOM
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index 1600ae5..625aec6 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -19,6 +19,7 @@ snd-soc-storm-objs := storm.o
>>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>>   snd-soc-apq8096-objs := apq8096.o
>>   snd-soc-sc7180-objs := sc7180.o
>> +snd-soc-sc7280-objs := sc7280.o
>>   snd-soc-sdm845-objs := sdm845.o
>>   snd-soc-sm8250-objs := sm8250.o
>>   snd-soc-qcom-common-objs := common.o
>> @@ -27,6 +28,7 @@ obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>>   obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
>>   obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
>> +obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
>>   obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
>>   obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
>>   obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
>> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
>> new file mode 100644
>> index 0000000..c20d4ab1
>> --- /dev/null
>> +++ b/sound/soc/qcom/sc7280.c
>> @@ -0,0 +1,299 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> +//
>> +// ALSA SoC Machine driver for sc7280
>> +
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
> Why do we need this?
Will remove it.
>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <sound/core.h>
>> +#include <sound/jack.h>
>> +#include <sound/pcm.h>
>> +#include <sound/soc.h>
>> +
>> +#include <dt-bindings/sound/sc7180-lpass.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
> Why this include?
>
Okay. Will remove it.
>> +
>> +#include "../codecs/wcd938x.h"
>
> Why do we need the codec header file here?
Okay. will replace with #include <linux/soundwire/sdw.h> for sound wire 
stream init functions.
>
>> +#include "common.h"
>> +#include "lpass.h"
>> +
>> +#define LPASS_MAX_PORTS  (LPASS_CDC_DMA_VA_TX8 + 1)
>
> May be add this in lpass.h instead of machine file.
Okay. Will change accordingly.
>
>> +
>> +struct sc7280_snd_data {
>> +    bool stream_prepared[LPASS_MAX_PORTS];
> move this to the end of struct.
Okay.
>
>> +    struct snd_soc_card card;
>> +    struct sdw_stream_runtime *sruntime[LPASS_MAX_PORTS];
>> +    struct snd_soc_jack hs_jack;
>> +    struct snd_soc_jack hdmi_jack;
>> +    bool jack_setup;
>> +};
>> +
>> +static void sc7280_jack_free(struct snd_jack *jack)
>> +{
>> +    struct snd_soc_component *component = jack->private_data;
>> +
>> +    snd_soc_component_set_jack(component, NULL, NULL);
>> +}
>> +
>> +static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_soc_card *card = rtd->card;
>> +    struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(card);
>> +    struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>> +    struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +    struct snd_soc_component *component = codec_dai->component;
>> +    struct snd_jack *jack;
>> +    int rval, i;
>> +
>> +    if (!pdata->jack_setup) {
>> +        rval = snd_soc_card_jack_new(card, "Headset Jack",
>> +                            SND_JACK_HEADSET | SND_JACK_LINEOUT |
>> +                            SND_JACK_MECHANICAL |
>> +                            SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>> +                            SND_JACK_BTN_2 | SND_JACK_BTN_3 |
>> +                            SND_JACK_BTN_4 | SND_JACK_BTN_5,
>> +                            &pdata->hs_jack, NULL, 0);
>> +
>> +        if (rval < 0) {
>> +            dev_err(card->dev, "Unable to add Headset Jack\n");
>> +            return rval;
>> +        }
>> +
>> +        jack = pdata->hs_jack.jack;
>> +
>> +        snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>> +        snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
>> +        snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
>> +        snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
>> +
>> +        jack->private_data = component;
>> +        jack->private_free = sc7280_jack_free;
>> +        pdata->jack_setup = true;
>> +    }
>> +    switch (cpu_dai->id) {
>> +    case LPASS_CDC_DMA_RX0:
>> +    case LPASS_CDC_DMA_TX3:
>> +        for_each_rtd_codec_dais(rtd, i, codec_dai) {
>> +            rval = snd_soc_component_set_jack(component, 
>> &pdata->hs_jack, NULL);
>> +            if (rval != 0 && rval != -ENOTSUPP) {
>> +                dev_err(card->dev, "Failed to set jack: %d\n", rval);
>> +                return rval;
>> +            }
>> +        }
>> +
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int sc7280_hdmi_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_soc_card *card = rtd->card;
>> +    struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(card);
>> +    struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>> +    struct snd_soc_component *component = codec_dai->component;
>> +    struct snd_jack *jack;
>> +    int rval;
>> +
>> +    rval = snd_soc_card_jack_new(
>> +            card, "HDMI Jack",
>> +            SND_JACK_LINEOUT,
>> +            &pdata->hdmi_jack, NULL, 0);
>
> you could probably warp this up to 100 chars
Okay.
>
>> +
>> +    if (rval < 0) {
>> +        dev_err(card->dev, "Unable to add HDMI Jack\n");
>> +        return rval;
>> +    }
>> +
>> +    jack = pdata->hdmi_jack.jack;
>> +    jack->private_data = component;
>> +    jack->private_free = sc7280_jack_free;
>> +
>> +    return snd_soc_component_set_jack(component, &pdata->hdmi_jack, 
>> NULL);
>> +}
>> +
>> +static int sc7280_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +
>> +    switch (cpu_dai->id) {
>> +    case LPASS_CDC_DMA_TX3:
>> +        return sc7280_headset_init(rtd);
>> +    case LPASS_CDC_DMA_RX0:
>> +    case LPASS_CDC_DMA_VA_TX0:
>> +    case MI2S_SECONDARY:
>> +        return 0;
>> +    case LPASS_DP_RX:
>> +        return sc7280_hdmi_init(rtd);
>> +    default:
>> +        dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__, 
>> cpu_dai->id);
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
>> +                struct snd_pcm_hw_params *params)
>> +{
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct snd_soc_dai *codec_dai;
>> +    const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +    struct sc7280_snd_data *pdata = 
>> snd_soc_card_get_drvdata(rtd->card);
>> +    struct sdw_stream_runtime *sruntime;
>> +    int i;
>> +
>> +    snd_pcm_hw_constraint_minmax(runtime, 
>> SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
>> +    snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 
>> 48000, 48000);
>> +
>> +    switch (cpu_dai->id) {
>> +    case LPASS_CDC_DMA_TX3:
>> +    case LPASS_CDC_DMA_RX0:
>> +        for_each_rtd_codec_dais(rtd, i, codec_dai) {
>> +            sruntime = snd_soc_dai_get_sdw_stream(codec_dai, 
>> substream->stream);
>> +            if (sruntime != ERR_PTR(-ENOTSUPP))
>> +                pdata->sruntime[cpu_dai->id] = sruntime;
>> +        }
>> +        break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int sc7280_snd_swr_prepare(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +    struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>> +    struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
>> +    int ret;
>> +
>> +    if (!sruntime)
>> +        return 0;
>> +
>> +    if (data->stream_prepared[cpu_dai->id]) {
>> +        sdw_disable_stream(sruntime);
>> +        sdw_deprepare_stream(sruntime);
>> +        data->stream_prepared[cpu_dai->id] = false;
>> +    }
>> +
>> +    ret = sdw_prepare_stream(sruntime);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = sdw_enable_stream(sruntime);
>> +    if (ret) {
>> +        sdw_deprepare_stream(sruntime);
>> +        return ret;
>> +    }
>> +    data->stream_prepared[cpu_dai->id] = true;
>> +
>> +    return ret;
>> +}
>> +
>> +static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +
>> +    switch (cpu_dai->id) {
>> +    case LPASS_CDC_DMA_RX0:
>> +    case LPASS_CDC_DMA_TX3:
>> +        return sc7280_snd_swr_prepare(substream);
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>> +    const struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +    struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
>> +
>> +    switch (cpu_dai->id) {
>> +    case LPASS_CDC_DMA_RX0:
>> +    case LPASS_CDC_DMA_TX3:
>> +        if (sruntime && data->stream_prepared[cpu_dai->id]) {
>> +            sdw_disable_stream(sruntime);
>> +            sdw_deprepare_stream(sruntime);
>> +            data->stream_prepared[cpu_dai->id] = false;
>> +        }
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static const struct snd_soc_ops sc7280_ops = {
>> +    .hw_params = sc7280_snd_hw_params,
>> +    .hw_free = sc7280_snd_hw_free,
>> +    .prepare = sc7280_snd_prepare,
>> +};
>> +
>> +static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
>> +    SND_SOC_DAPM_HP("Headphone Jack", NULL),
>> +    SND_SOC_DAPM_MIC("Headset Mic", NULL),
>> +};
>> +
>> +static int sc7280_snd_platform_probe(struct platform_device *pdev)
>> +{
>> +    struct snd_soc_card *card;
>> +    struct sc7280_snd_data *data;
>> +    struct device *dev = &pdev->dev;
>> +    struct snd_soc_dai_link *link;
>> +    int ret, i;
>> +
>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    card = &data->card;
>> +    snd_soc_card_set_drvdata(card, data);
>> +
>> +    card->owner = THIS_MODULE;
>> +    card->driver_name = "SC7280";
>> +    card->dev = dev;
>> +
>> +    ret = qcom_snd_parse_of(card);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for_each_card_prelinks(card, i, link) {
>> +        link->init = sc7280_init;
>> +        link->ops = &sc7280_ops;
>> +    }
>> +
>> +    return devm_snd_soc_register_card(dev, card);
>> +}
>> +
>> +static const struct of_device_id sc7280_snd_device_id[]  = {
>> +    { .compatible = "google,sc7280-herobrine" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, sc7280_snd_device_id);
>> +
>> +static struct platform_driver sc7280_snd_driver = {
>> +    .probe = sc7280_snd_platform_probe,
>> +    .driver = {
>> +        .name = "msm-snd-sc7280",
>> +        .of_match_table = sc7280_snd_device_id,
>> +        .pm = &snd_soc_pm_ops,
>> +    },
>> +};
>> +module_platform_driver(sc7280_snd_driver);
>> +
>> +MODULE_DESCRIPTION("sc7280 ASoC Machine Driver");
>> +MODULE_LICENSE("GPL v2");
> "GPL" should be good enough here.
Okay.
>
> --srini
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

