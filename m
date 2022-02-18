Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9475A4BBB29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiBROzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:55:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiBROzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:55:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FB2B2FC8;
        Fri, 18 Feb 2022 06:54:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4AE881F46BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196087;
        bh=ZDwX6EvqSvc2MQX6I4hpOm7qYRLjcwyWMVCDxQ26Cus=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=lZTQ35oR/g7MMB78237hz8Htnhs4vnkklPiZR4MErPR32qAVEiI21bCxq/V7FF9Ks
         dQa/bM0n76vhIx2Nw/mUU/CoyZYbINP/zhdlBU7brnE71xk+zSPCaavY7LK8jqT3NQ
         /dr6z32xc+s4n02sbe+kTVkfL8EOojOLfXRvzbwL9iT1urMI2c/hpvYGeqklOuq9Sd
         GXSzQvb2Y0z62GgcljL5ImU5SGgk1R2m3Nb2Ka8MV4UFxFSIPlP3Z92wi4Xaqf3ClU
         vs8LgJSi69ZGR1QwwfaFFqQaDEQvxex87jrihuvJ47FEARH2L/Uq7AAIIzXp+m8IGL
         g06XoY26l1Mqg==
Message-ID: <58cc2df8-5503-b38f-2a6d-9bbef809a60f@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [v2 12/17] ASoC: mediatek: mt8186: add platform driver
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-13-jiaxin.yu@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220217134205.15400-13-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 14:42, Jiaxin Yu ha scritto:
> This patch adds mt8186 platform and affiliated driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                    |   44 +
>   sound/soc/mediatek/Makefile                   |    1 +
>   sound/soc/mediatek/mt8186/Makefile            |   21 +
>   sound/soc/mediatek/mt8186/mt8186-afe-common.h |  245 ++
>   .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
>   sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3029 +++++++++++++++
>   .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
>   .../soc/mediatek/mt8186/mt8186-misc-control.c | 1728 +++++++++
>   sound/soc/mediatek/mt8186/mt8186-reg.h        | 3433 +++++++++++++++++
>   9 files changed, 8831 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/Makefile
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-interconnection.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-misc-control.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-reg.h
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index 3b1ddea26a9e..d3528bdbb00a 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -152,6 +152,50 @@ config SND_SOC_MT8183_DA7219_MAX98357A
>   	  Select Y if you have such device.
>   	  If unsure select "N".
>   
> +config SND_SOC_MT8186
> +	tristate "ASoC support for Mediatek MT8186 chip"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on COMMON_CLK
> +	select SND_SOC_MEDIATEK
> +	select MFD_SYSCON if SND_SOC_MT6366
> +	help
> +	  This adds ASoC driver for Mediatek MT8186 boards
> +	  that can be used with other codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
> +config SND_SOC_MT8186_MT6366_DA7219_MAX98357
> +	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A codec"
> +	depends on I2C && GPIOLIB
> +	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
> +	select SND_SOC_MT6366
> +	select SND_SOC_MAX98357A
> +	select SND_SOC_DA7219
> +	select SND_SOC_BT_SCO
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDMI_CODEC
> +	help
> +	  This adds ASoC driver for Mediatek MT8186 boards
> +	  with the MT6366 DA7219 MAX98357A codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
> +config SND_SOC_MT8186_MT6366_RT1019_RT5682S
> +	tristate "ASoC Audio driver for MT8186 with RT1019 RT5682S codec"
> +	depends on I2C && GPIOLIB
> +	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
> +	select SND_SOC_MT6366
> +	select SND_SOC_RT1015P
> +	select SND_SOC_RT5682S
> +	select SND_SOC_BT_SCO
> +	select SND_SOC_DMIC
> +	select SND_SOC_HDMI_CODEC
> +	help
> +	  This adds ASoC driver for Mediatek MT8186 boards
> +	  with the MT6366 RT1019 RT5682S codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
>   config SND_SOC_MTK_BTCVSD
>   	tristate "ALSA BT SCO CVSD/MSBC Driver"
>   	help
> diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
> index 34778ca12106..5571c640a288 100644
> --- a/sound/soc/mediatek/Makefile
> +++ b/sound/soc/mediatek/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
>   obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
>   obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
>   obj-$(CONFIG_SND_SOC_MT8183) += mt8183/
> +obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
>   obj-$(CONFIG_SND_SOC_MT8192) += mt8192/
>   obj-$(CONFIG_SND_SOC_MT8195) += mt8195/
> diff --git a/sound/soc/mediatek/mt8186/Makefile b/sound/soc/mediatek/mt8186/Makefile
> new file mode 100644
> index 000000000000..9f3bead9cdf8
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# platform driver
> +snd-soc-mt8186-afe-objs := \
> +	mt8186-afe-pcm.o \
> +	mt8186-audsys-clk.o \
> +	mt8186-afe-clk.o \
> +	mt8186-afe-gpio.o \
> +	mt8186-dai-adda.o \
> +	mt8186-afe-control.o \
> +	mt8186-dai-i2s.o \
> +	mt8186-dai-hw-gain.o \
> +	mt8186-dai-pcm.o \
> +	mt8186-dai-src.o \
> +	mt8186-dai-hostless.o \
> +	mt8186-dai-tdm.o \
> +	mt8186-misc-control.o
> +
> +obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
> +obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-mt6366-rt1019-rt5682s.o
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-common.h b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
> new file mode 100644
> index 000000000000..b2b50faa3887
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
> @@ -0,0 +1,245 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * mt8186-afe-common.h  --  Mediatek 8186 audio driver definitions
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> + */
> +
> +#ifndef _MT_8186_AFE_COMMON_H_
> +#define _MT_8186_AFE_COMMON_H_
> +#include <sound/soc.h>
> +#include <linux/list.h>
> +#include <linux/regmap.h>
> +#include "mt8186-reg.h"
> +#include "../common/mtk-base-afe.h"
> +
> +#if IS_ENABLED(CONFIG_MTK_AEE_FEATURE)
> +#define AUDIO_AEE(message) \
> +	(aee_kernel_exception_api(__FILE__, \
> +				  __LINE__, \
> +				  DB_OPT_FTRACE, message, \
> +				  "audio assert"))
> +#else
> +#define AUDIO_AEE(message) WARN_ON(true)
> +#endif

There is no such AEE upstream, please remove this block entirely.

...snip...

> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-control.c b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> new file mode 100644
> index 000000000000..cb863716a74b
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include "mt8186-afe-common.h"
> +#include <linux/pm_runtime.h>
> +
> +enum {
> +	MTK_AFE_RATE_8K = 0,

You just need to define the first one as zero and you don't need to
assign numbers to the others, since they are sequential.
Please fix.

> +	MTK_AFE_RATE_11K = 1,
> +	MTK_AFE_RATE_12K = 2,
> +	MTK_AFE_RATE_384K = 3,
> +	MTK_AFE_RATE_16K = 4,
> +	MTK_AFE_RATE_22K = 5,
> +	MTK_AFE_RATE_24K = 6,
> +	MTK_AFE_RATE_352K = 7,
> +	MTK_AFE_RATE_32K = 8,
> +	MTK_AFE_RATE_44K = 9,
> +	MTK_AFE_RATE_48K = 10,
> +	MTK_AFE_RATE_88K = 11,
> +	MTK_AFE_RATE_96K = 12,
> +	MTK_AFE_RATE_176K = 13,
> +	MTK_AFE_RATE_192K = 14,
> +	MTK_AFE_RATE_260K = 15,
> +};
> +
> +enum {
> +	MTK_AFE_PCM_RATE_8K = 0,
> +	MTK_AFE_PCM_RATE_16K = 1,
> +	MTK_AFE_PCM_RATE_32K = 2,
> +	MTK_AFE_PCM_RATE_48K = 3,

same here

> +};
> +
> +enum {
> +	MTK_AFE_TDM_RATE_8K = 0,
> +	MTK_AFE_TDM_RATE_12K = 1,
> +	MTK_AFE_TDM_RATE_16K = 2,
> +	MTK_AFE_TDM_RATE_24K = 3,
> +	MTK_AFE_TDM_RATE_32K = 4,
> +	MTK_AFE_TDM_RATE_48K = 5,
> +	MTK_AFE_TDM_RATE_64K = 6,
> +	MTK_AFE_TDM_RATE_96K = 7,
> +	MTK_AFE_TDM_RATE_128K = 8,
> +	MTK_AFE_TDM_RATE_192K = 9,
> +	MTK_AFE_TDM_RATE_256K = 10,
> +	MTK_AFE_TDM_RATE_384K = 11,
> +	MTK_AFE_TDM_RATE_11K = 16,
> +	MTK_AFE_TDM_RATE_22K = 17,
> +	MTK_AFE_TDM_RATE_44K = 18,
> +	MTK_AFE_TDM_RATE_88K = 19,
> +	MTK_AFE_TDM_RATE_176K = 20,
> +	MTK_AFE_TDM_RATE_352K = 21, > +};
> +
> +enum {
> +	MTK_AFE_TDM_RELATCH_RATE_8K = 0,
> +	MTK_AFE_TDM_RELATCH_RATE_11K = 1,
> +	MTK_AFE_TDM_RELATCH_RATE_12K = 2,
> +	MTK_AFE_TDM_RELATCH_RATE_16K = 4,
> +	MTK_AFE_TDM_RELATCH_RATE_22K = 5,
> +	MTK_AFE_TDM_RELATCH_RATE_24K = 6,
> +	MTK_AFE_TDM_RELATCH_RATE_32K = 8,
> +	MTK_AFE_TDM_RELATCH_RATE_44K = 9,
> +	MTK_AFE_TDM_RELATCH_RATE_48K = 10,
> +	MTK_AFE_TDM_RELATCH_RATE_88K = 13,
> +	MTK_AFE_TDM_RELATCH_RATE_96K = 14,
> +	MTK_AFE_TDM_RELATCH_RATE_176K = 17,
> +	MTK_AFE_TDM_RELATCH_RATE_192K = 18,
> +	MTK_AFE_TDM_RELATCH_RATE_352K = 21,
> +	MTK_AFE_TDM_RELATCH_RATE_384K = 22,
> +};
> +
> +unsigned int mt8186_general_rate_transform(struct device *dev,
> +					   unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_AFE_RATE_8K;
> +	case 11025:
> +		return MTK_AFE_RATE_11K;
> +	case 12000:
> +		return MTK_AFE_RATE_12K;
> +	case 16000:
> +		return MTK_AFE_RATE_16K;
> +	case 22050:
> +		return MTK_AFE_RATE_22K;
> +	case 24000:
> +		return MTK_AFE_RATE_24K;
> +	case 32000:
> +		return MTK_AFE_RATE_32K;
> +	case 44100:
> +		return MTK_AFE_RATE_44K;
> +	case 48000:
> +		return MTK_AFE_RATE_48K;
> +	case 88200:
> +		return MTK_AFE_RATE_88K;
> +	case 96000:
> +		return MTK_AFE_RATE_96K;
> +	case 176400:
> +		return MTK_AFE_RATE_176K;
> +	case 192000:
> +		return MTK_AFE_RATE_192K;
> +	case 260000:
> +		return MTK_AFE_RATE_260K;
> +	case 352800:
> +		return MTK_AFE_RATE_352K;
> +	case 384000:
> +		return MTK_AFE_RATE_384K;
> +	default:
> +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> +			 __func__,
> +			 rate, MTK_AFE_RATE_48K);

dev_err(); ... and don't return here, but...

> +		return MTK_AFE_RATE_48K;
> +	}


... return here, outside of the switch.

> +}
> +
> +static unsigned int tdm_rate_transform(struct device *dev,
> +				       unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_AFE_TDM_RATE_8K;
> +	case 11025:
> +		return MTK_AFE_TDM_RATE_11K;
> +	case 12000:
> +		return MTK_AFE_TDM_RATE_12K;
> +	case 16000:
> +		return MTK_AFE_TDM_RATE_16K;
> +	case 22050:
> +		return MTK_AFE_TDM_RATE_22K;
> +	case 24000:
> +		return MTK_AFE_TDM_RATE_24K;
> +	case 32000:
> +		return MTK_AFE_TDM_RATE_32K;
> +	case 44100:
> +		return MTK_AFE_TDM_RATE_44K;
> +	case 48000:
> +		return MTK_AFE_TDM_RATE_48K;
> +	case 64000:
> +		return MTK_AFE_TDM_RATE_64K;
> +	case 88200:
> +		return MTK_AFE_TDM_RATE_88K;
> +	case 96000:
> +		return MTK_AFE_TDM_RATE_96K;
> +	case 128000:
> +		return MTK_AFE_TDM_RATE_128K;
> +	case 176400:
> +		return MTK_AFE_TDM_RATE_176K;
> +	case 192000:
> +		return MTK_AFE_TDM_RATE_192K;
> +	case 256000:
> +		return MTK_AFE_TDM_RATE_256K;
> +	case 352800:
> +		return MTK_AFE_TDM_RATE_352K;
> +	case 384000:
> +		return MTK_AFE_TDM_RATE_384K;
> +	default:
> +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> +			 __func__,
> +			 rate, MTK_AFE_TDM_RATE_48K);
> +		return MTK_AFE_TDM_RATE_48K;

ditto.
here and for all the other instances.

> +	}
> +}
> +

...snip...

> +}
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> new file mode 100644
> index 000000000000..e1e17a934245
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> @@ -0,0 +1,3029 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Mediatek ALSA SoC AFE platform driver for 8186
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <sound/soc.h>
> +
> +#include "../common/mtk-afe-platform-driver.h"
> +#include "../common/mtk-afe-fe-dai.h"
> +
> +#include "mt8186-afe-common.h"
> +#include "mt8186-afe-clk.h"
> +#include "mt8186-afe-gpio.h"
> +#include "mt8186-interconnection.h"
> +
> +static const struct snd_pcm_hardware mt8186_afe_hardware = {
> +	.info = (SNDRV_PCM_INFO_MMAP |
> +		 SNDRV_PCM_INFO_INTERLEAVED |
> +		 SNDRV_PCM_INFO_MMAP_VALID),
> +	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
> +		    SNDRV_PCM_FMTBIT_S24_LE |
> +		    SNDRV_PCM_FMTBIT_S32_LE),
> +	.period_bytes_min = 96,
> +	.period_bytes_max = 4 * 48 * 1024,
> +	.periods_min = 2,
> +	.periods_max = 256,
> +	.buffer_bytes_max = 4 * 48 * 1024,
> +	.fifo_size = 0,
> +};
> +
> +static int mt8186_fe_startup(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> +	const struct snd_pcm_hardware *mtk_afe_hardware = afe->mtk_afe_hardware;
> +	int ret;
> +
> +	memif->substream = substream;
> +
> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
> +
> +	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		dev_info(afe->dev, "snd_pcm_hw_constraint_integer failed\n");

	if (ret < 0) {
		dev_err .....
		return ret;
	}

> +
> +	/* dynamic allocate irq to memif */
> +	if (memif->irq_usage < 0) {
> +		int irq_id = mtk_dynamic_irq_acquire(afe);
> +
> +		if (irq_id != afe->irqs_size) {
> +			/* link */
> +			memif->irq_usage = irq_id;
> +		} else {
> +			dev_info(afe->dev, "%s() error: no more asys irq\n",
> +				 __func__);
> +			ret = -EBUSY;
			return -EBUSY;
> +		}
> +	}
> +

	return 0;

> +	return ret;
> +}
> +
> +static void mt8186_fe_shutdown(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> +	int irq_id = memif->irq_usage;
> +
> +	memif->substream = NULL;
> +	afe_priv->irq_cnt[id] = 0;
> +	afe_priv->xrun_assert[id] = 0;
> +
> +	if (!memif->const_irq) {
> +		mtk_dynamic_irq_release(afe, irq_id);
> +		memif->irq_usage = -1;
> +		memif->substream = NULL;
> +	}
> +}
> +
> +static int mt8186_fe_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +	unsigned int channels = params_channels(params);
> +	unsigned int rate = params_rate(params);
> +	int ret;
> +
> +	ret = mtk_afe_fe_hw_params(substream, params, dai);
> +	if (ret)
		return ret;
> +		goto exit;
> +
> +	/* channel merge configuration, enable control is in UL5_IN_MUX */
> +	if (id == MT8186_MEMIF_VUL3) {
> +		int update_cnt = 8;
> +		unsigned int val = 0;
> +		unsigned int mask = 0;
> +		int fs_mode = mt8186_rate_transform(afe->dev, rate, id);
> +
> +		/* set rate, channel, update cnt, disable sgen */
> +		val = fs_mode << CM1_FS_SELECT_SFT |
> +			(channels - 1) << CHANNEL_MERGE0_CHNUM_SFT |
> +			update_cnt << CHANNEL_MERGE0_UPDATE_CNT_SFT |
> +			0 << CHANNEL_MERGE0_DEBUG_MODE_SFT |
> +			0 << CM1_DEBUG_MODE_SEL_SFT;

0 << number == 0!!!

> +		mask = CM1_FS_SELECT_MASK_SFT |
> +			CHANNEL_MERGE0_CHNUM_MASK_SFT |
> +			CHANNEL_MERGE0_UPDATE_CNT_MASK_SFT |
> +			CHANNEL_MERGE0_DEBUG_MODE_MASK_SFT |
> +			CM1_DEBUG_MODE_SEL_MASK_SFT;
> +		regmap_update_bits(afe->regmap, AFE_CM1_CON, mask, val);
> +	}
> +

	return 0;

... and remove the label, as it's not needed
> +exit:
> +	return ret;
> +}
> +
> +static int mt8186_fe_hw_free(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	int ret;
> +
> +	ret = mtk_afe_fe_hw_free(substream, dai);
> +	if (ret)
> +		goto exit;
> +
> +	/* wait for some platform related operation */
> +exit:
> +	return ret;
> +}
> +
> +static int mt8186_fe_trigger(struct snd_pcm_substream *substream, int cmd,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime * const runtime = substream->runtime;
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> +	int irq_id = memif->irq_usage;
> +	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +	unsigned int counter = runtime->period_size;
> +	unsigned int rate = runtime->rate;
> +	int fs;
> +	int ret;
> +
> +	dev_info(afe->dev, "%s(), %s cmd %d, irq_id %d\n",
> +		 __func__, memif->data->name, cmd, irq_id);


dev_dbg()

> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = mtk_memif_set_enable(afe, id);
		if (ret) {
			dev_err ........
			return ret;
		}

		/*
		 * for small latency record
		 * ul memif need read some data before irq enable
		 */
		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
		    ((runtime->period_size * 1000) / rate) <= 10)
				usleep_range(300, 310);


> +		/*
> +		 * for small latency record
> +		 * ul memif need read some data before irq enable
> +		 */
> +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +			if ((runtime->period_size * 1000) / rate <= 10)
> +				usleep_range(300, 310);
> +		}
> +
> +		if (ret) {
> +			dev_info(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
> +				 __func__, id, ret);
> +			return ret;
> +		}
> +
> +		/* set irq counter */
> +		if (afe_priv->irq_cnt[id] > 0)
> +			counter = afe_priv->irq_cnt[id];
> +
> +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> +				   irq_data->irq_cnt_maskbit
> +				   << irq_data->irq_cnt_shift,
> +				   counter << irq_data->irq_cnt_shift);
> +
> +		/* set irq fs */
> +		fs = afe->irq_fs(substream, runtime->rate);
> +

empty line: remove.

> +		if (fs < 0)
> +			return -EINVAL;
> +
> +		regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
> +				   irq_data->irq_fs_maskbit
> +				   << irq_data->irq_fs_shift,
> +				   fs << irq_data->irq_fs_shift);
> +
> +		/* enable interrupt */
> +		if (runtime->stop_threshold != ~(0U))
> +			regmap_update_bits(afe->regmap,
> +					   irq_data->irq_en_reg,
> +					   1 << irq_data->irq_en_shift,
> +					   1 << irq_data->irq_en_shift);
> +		return 0;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +		if (afe_priv->xrun_assert[id] > 0) {
> +			if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +				int avail = snd_pcm_capture_avail(runtime);
> +
> +				if (avail >= runtime->buffer_size) {
> +					dev_info(afe->dev, "%s(), id %d, xrun assert\n",
> +						 __func__, id);
> +				}
> +			}
> +		}
> +
> +		ret = mtk_memif_set_disable(afe, id);
> +		if (ret) {
> +			dev_info(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
> +				 __func__, id, ret);

dev_err()

> +		}
> +
> +		/* disable interrupt */
> +		if (runtime->stop_threshold != ~(0U))
> +			regmap_update_bits(afe->regmap,
> +					   irq_data->irq_en_reg,
> +					   1 << irq_data->irq_en_shift,
> +					   0 << irq_data->irq_en_shift);
> +
> +		/* clear pending IRQ */
> +		regmap_write(afe->regmap, irq_data->irq_clr_reg,
> +			     1 << irq_data->irq_clr_shift);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mt8186_memif_fs(struct snd_pcm_substream *substream,
> +			   unsigned int rate)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_component *component =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +
> +	return mt8186_rate_transform(afe->dev, rate, id);
> +}
> +
> +static int mt8186_get_dai_fs(struct mtk_base_afe *afe,
> +			     int dai_id, unsigned int rate)
> +{
> +	return mt8186_rate_transform(afe->dev, rate, dai_id);
> +}
> +
> +static int mt8186_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_component *component =
> +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +
> +	return mt8186_general_rate_transform(afe->dev, rate);
> +}
> +
> +static int mt8186_get_memif_pbuf_size(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	if ((runtime->period_size * 1000) / runtime->rate > 10)
> +		return MT8186_MEMIF_PBUF_SIZE_256_BYTES;
> +	else

drop "else"... and just return MT8186_MEMIF_PBUF_SIZE_32_BYTES

> +		return MT8186_MEMIF_PBUF_SIZE_32_BYTES;
> +}
> +
> +static int mt8186_fe_prepare(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime * const runtime = substream->runtime;
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> +	int irq_id = memif->irq_usage;
> +	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +	unsigned int counter = runtime->period_size;
> +	int fs;
> +	int ret;
> +
> +	ret = mtk_afe_fe_prepare(substream, dai);
> +	if (ret)

		return ret;

> +		goto exit;
> +
> +	/* set irq counter */
> +	regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> +			   irq_data->irq_cnt_maskbit
> +			   << irq_data->irq_cnt_shift,
> +			   counter << irq_data->irq_cnt_shift);
> +
> +	/* set irq fs */
> +	fs = afe->irq_fs(substream, runtime->rate);
> +
> +	if (fs < 0)
> +		return -EINVAL;
> +
> +	regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
> +			   irq_data->irq_fs_maskbit
> +			   << irq_data->irq_fs_shift,
> +			   fs << irq_data->irq_fs_shift);
> +exit:

unneeded label, and return 0;

> +	return ret;
> +}
> +

..snip..

> +static int mt8186_irq_cnt1_set(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int memif_num = MT8186_PRIMARY_MEMIF;
> +	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
> +	int irq_id = memif->irq_usage;
> +	int irq_cnt = afe_priv->irq_cnt[memif_num];
> +
> +	dev_info(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
> +		 __func__,
> +		 irq_id, irq_cnt,
> +		 ucontrol->value.integer.value[0]);

dev_dbg() - and fits in less lines.

> +
> +	if (irq_cnt == ucontrol->value.integer.value[0])
> +		return 0;
> +
> +	irq_cnt = ucontrol->value.integer.value[0];
> +	afe_priv->irq_cnt[memif_num] = irq_cnt;
> +
> +	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
> +		dev_info(afe->dev, "%s(), suspended || irq_id %d, not set\n",
> +			 __func__, irq_id);
> +	} else {
> +		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> +		const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +
> +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> +				   irq_data->irq_cnt_maskbit
> +				   << irq_data->irq_cnt_shift,
> +				   irq_cnt << irq_data->irq_cnt_shift);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt8186_irq_cnt2_get(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +
> +	ucontrol->value.integer.value[0] =
> +		afe_priv->irq_cnt[MT8186_RECORD_MEMIF];
> +	return 0;
> +}
> +
> +static int mt8186_irq_cnt2_set(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int memif_num = MT8186_RECORD_MEMIF;
> +	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
> +	int irq_id = memif->irq_usage;
> +	int irq_cnt = afe_priv->irq_cnt[memif_num];
> +
> +	dev_info(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
> +		 __func__,
> +		 irq_id, irq_cnt,
> +		 ucontrol->value.integer.value[0]);

dev_dbg() - and fits in less lines.

> +
> +	if (irq_cnt == ucontrol->value.integer.value[0])
> +		return 0;
> +
> +	irq_cnt = ucontrol->value.integer.value[0];
> +	afe_priv->irq_cnt[memif_num] = irq_cnt;
> +
> +	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
> +		dev_info(afe->dev, "%s(), suspended || irq_id %d, not set\n",
> +			 __func__, irq_id);
> +	} else {
> +		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> +		const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +
> +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> +				   irq_data->irq_cnt_maskbit
> +				   << irq_data->irq_cnt_shift,
> +				   irq_cnt << irq_data->irq_cnt_shift);
> +	}
> +
> +	return 0;
> +}
> +



> +
> +static irqreturn_t mt8186_afe_irq_handler(int irq_id, void *dev)
> +{
> +	struct mtk_base_afe *afe = dev;
> +	struct mtk_base_afe_irq *irq;
> +	unsigned int status;
> +	unsigned int status_mcu;
> +	unsigned int mcu_en;
> +	int ret;
> +	int i;
> +
> +	/* get irq that is sent to MCU */
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);

ret = regmap_read ....
if (ret) ....

> +
> +	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
> +	/* only care IRQ which is sent to MCU */
> +	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
> +
> +	if (ret || status_mcu == 0) {
> +		dev_info(afe->dev, "%s(), irq status err, ret %d, status 0x%x, mcu_en 0x%x\n",
> +			 __func__, ret, status, mcu_en);

dev_err()

> +
> +		goto err_irq;
> +	}
> +
> +	for (i = 0; i < MT8186_MEMIF_NUM; i++) {
> +		struct mtk_base_afe_memif *memif = &afe->memif[i];
> +
> +		if (!memif->substream)
> +			continue;
> +
> +		if (memif->irq_usage < 0)
> +			continue;
> +
> +		irq = &afe->irqs[memif->irq_usage];
> +
> +		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
> +			snd_pcm_period_elapsed(memif->substream);
> +	}
> +
> +err_irq:
> +	/* clear irq */
> +	regmap_write(afe->regmap,
> +		     AFE_IRQ_MCU_CLR,
> +		     status_mcu);

fits in a single line.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mt8186_afe_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	unsigned int value = 0;
> +	int ret;
> +
> +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> +		goto skip_regmap;
> +
> +	/* disable AFE */
> +	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x0);
> +
> +	ret = regmap_read_poll_timeout(afe->regmap,
> +				       AFE_DAC_MON,
> +				       value,
> +				       (value & AFE_ON_RETM_MASK_SFT) == 0,
> +				       20,
> +				       1 * 1000 * 1000);
> +	if (ret)
> +		dev_info(afe->dev, "%s(), ret %d\n", __func__, ret);

dev_err()!!
P.S.: Are you sure that we shouldn't return here?

> +
> +	/* make sure all irq status are cleared */
> +	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
> +	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
> +
> +	/* reset sgen */
> +	regmap_write(afe->regmap, AFE_SINEGEN_CON0, 0x0);
> +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> +			   INNER_LOOP_BACK_MODE_MASK_SFT,
> +			   0x3f << INNER_LOOP_BACK_MODE_SFT);
> +
> +	/* cache only */
> +	regcache_cache_only(afe->regmap, true);
> +	regcache_mark_dirty(afe->regmap);
> +
> +skip_regmap:
> +	mt8186_afe_disable_cgs(afe);
> +	mt8186_afe_disable_clock(afe);
> +
> +	return 0;
> +}
> +
> +static int mt8186_afe_runtime_resume(struct device *dev)
> +{
> +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int ret;
> +
> +	ret = mt8186_afe_enable_clock(afe);
> +	if (ret)
> +		return ret;
> +
> +	ret = mt8186_afe_enable_cgs(afe);
> +	if (ret)
> +		return ret;
> +
> +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> +		goto skip_regmap;
> +
> +	regcache_cache_only(afe->regmap, false);
> +	regcache_sync(afe->regmap);
> +
> +	/* enable audio sys DCM for power saving */
> +	regmap_update_bits(afe_priv->infracfg,
> +			   PERI_BUS_DCM_CTRL, 0x1 << 29, 0x1 << 29);

BIT(29)

> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0, 0x1 << 29, 0x1 << 29);
> +
> +	/* force cpu use 8_24 format when writing 32bit data */
> +	regmap_update_bits(afe->regmap, AFE_MEMIF_CON0,
> +			   CPU_HD_ALIGN_MASK_SFT, 0 << CPU_HD_ALIGN_SFT);

0 << number == 0, so write 0

> +
> +	/* set all output port to 24bit */
> +	regmap_write(afe->regmap, AFE_CONN_24BIT, 0xffffffff);
> +	regmap_write(afe->regmap, AFE_CONN_24BIT_1, 0xffffffff);
> +
> +	/* enable AFE */
> +	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
> +
> +skip_regmap:
> +	return 0;
> +}

..snip..

> +static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe;
> +	struct mt8186_afe_private *afe_priv;
> +	struct resource *res;
> +	struct reset_control *rstc;
> +	struct device *dev = &pdev->dev;
> +	int i, ret, irq_id;
> +
> +	dev_info(dev, "%s(), ++\n", __func__);

Drop this print.

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
> +	dev_info(dev, "%s(), mt8186_init_clock\n", __func__);

Drop this print.

> +	/* init audio related clock */
> +	ret = mt8186_init_clock(afe);
> +	if (ret) {
> +		dev_info(dev, "init clock error\n");

dev_err()

> +		return ret;
> +	}
> +
> +	/* init memif */
> +	afe->memif_32bit_supported = 0;
> +	afe->memif_size = MT8186_MEMIF_NUM;
> +	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
> +				  GFP_KERNEL);
> +
> +	if (!afe->memif)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < afe->memif_size; i++) {
> +		afe->memif[i].data = &memif_data[i];
> +		afe->memif[i].irq_usage = memif_irq_usage[i];
> +		afe->memif[i].const_irq = 1;
> +	}
> +
> +	mutex_init(&afe->irq_alloc_lock);	/* needed when dynamic irq */
> +
> +	dev_info(dev, "%s(), init irq\n", __func__);

Drop this print.

> +
> +	/* init irq */
> +	afe->irqs_size = MT8186_IRQ_NUM;
> +	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
> +				 GFP_KERNEL);
> +
> +	if (!afe->irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < afe->irqs_size; i++)
> +		afe->irqs[i].irq_data = &irq_data[i];
> +
> +	dev_info(dev, "%s(), devm_request_irq\n", __func__);

Drop.

> +
> +	/* request irq */
> +	irq_id = platform_get_irq(pdev, 0);
> +	if (irq_id <= 0) {
> +		dev_info(dev, "%pOFn no irq found\n", dev->of_node);

		return dev_err_probe(dev, irq_id < 0 ? irq_id : -ENXIO,
				     "no irq found");

> +		return irq_id < 0 ? irq_id : -ENXIO;
> +	}
> +	ret = devm_request_irq(dev, irq_id, mt8186_afe_irq_handler,
> +			       IRQF_TRIGGER_NONE,
> +			       "Afe_ISR_Handle", (void *)afe);
> +	if (ret) {
> +		dev_info(dev, "could not request_irq for Afe_ISR_Handle\n");

return dev_err_probe(dev, ret, "could not request Afe_ISR_Handle irq\n");

> +		return ret;
> +	}
> +
> +	ret = enable_irq_wake(irq_id);
> +	if (ret < 0)
> +		dev_info(dev, "enable_irq_wake %d err: %d\n", irq_id, ret);

Isn't this a critical error?
		return dev_err_probe(.......

> +
> +	/* init sub_dais */
> +	INIT_LIST_HEAD(&afe->sub_dais);
> +
> +	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
> +		ret = dai_register_cbs[i](afe);
> +		if (ret) {
> +			dev_info(dev, "dai register i %d fail, ret %d\n",
> +				 i, ret);
> +			return ret;

return dev_err_probe()

> +		}
> +	}
> +
> +	dev_info(dev, "%s(), mtk_afe_combine_sub_dai\n", __func__);

drop this.

> +
> +	/* init dai_driver and component_driver */
> +	ret = mtk_afe_combine_sub_dai(afe);
> +	if (ret) {
> +		dev_info(dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
> +			 ret);
> +		return ret;

return dev_err_probe()

> +	}
> +
> +	/* reset controller to reset audio regs before regmap cache */
> +	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
> +	if (IS_ERR(rstc)) {
> +		ret = PTR_ERR(rstc);
> +		dev_info(dev, "could not get audiosys reset:%d\n", ret);
> +		return ret;

return dev_err_probe(dev, PTR_ERR(rstc), "Could not get audiosys reset\n");

> +	}
> +
> +	ret = reset_control_reset(rstc);
> +	if (ret) {
> +		dev_info(dev, "failed to trigger audio reset:%d\n", ret);
> +		return ret;

dev_err_probe()

> +	}
> +
> +	/* enable clock for regcache get default value from hw */
> +	afe_priv->pm_runtime_bypass_reg_ctl = true;
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret)
> +		dev_info(dev, "get_ret:%d, rpm_error:%d\n",
> +			 ret, dev->power.runtime_error);

You should also return the error here.

> +
> +	afe->regmap = devm_regmap_init_mmio(dev, afe->base_addr,
> +					    &mt8186_afe_regmap_config);
> +	if (IS_ERR(afe->regmap)) {
> +		ret = PTR_ERR(afe->regmap);
> +		goto err_pm_disable;
> +	}
> +
> +	/* others */
> +	afe->mtk_afe_hardware = &mt8186_afe_hardware;
> +	afe->memif_fs = mt8186_memif_fs;
> +	afe->irq_fs = mt8186_irq_fs;
> +	afe->get_dai_fs = mt8186_get_dai_fs;
> +	afe->get_memif_pbuf_size = mt8186_get_memif_pbuf_size;
> +
> +	afe->runtime_resume = mt8186_afe_runtime_resume;
> +	afe->runtime_suspend = mt8186_afe_runtime_suspend;
> +
> +	/* register platform */
> +	dev_info(dev, "%s(), devm_snd_soc_register_component\n", __func__);
> +
> +	ret = devm_snd_soc_register_component(dev,
> +					      &mt8186_afe_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret) {
> +		dev_info(dev, "err_dai_component\n");

dev_err()

> +		goto err_pm_disable;
> +	}
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret)
> +		dev_info(dev, "put_ret:%d, rpm_error:%d\n",
> +			 ret, dev->power.runtime_error);

dev_err()

> +	afe_priv->pm_runtime_bypass_reg_ctl = false;
> +
> +	regcache_cache_only(afe->regmap, true);
> +	regcache_mark_dirty(afe->regmap);
> +
> +	dev_info(dev, "%s(), --\n", __func__);
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static int mt8186_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		mt8186_afe_runtime_suspend(&pdev->dev);
> +
> +	mt8186_deinit_clock(afe);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt8186_afe_pcm_dt_match[] = {
> +	{ .compatible = "mediatek,mt8186-sound", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt8186_afe_pcm_dt_match);
> +
> +static const struct dev_pm_ops mt8186_afe_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mt8186_afe_runtime_suspend,
> +			   mt8186_afe_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mt8186_afe_pcm_driver = {
> +	.driver = {
> +		   .name = "mt8186-audio",
> +		   .of_match_table = mt8186_afe_pcm_dt_match,
> +		   .pm = &mt8186_afe_pm_ops,
> +	},
> +	.probe = mt8186_afe_pcm_dev_probe,
> +	.remove = mt8186_afe_pcm_dev_remove,
> +};
> +
> +module_platform_driver(mt8186_afe_pcm_driver);
> +
> +MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver for 8186");
> +MODULE_AUTHOR("Jiaxin Yu <jiaxin.yu@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/mediatek/mt8186/mt8186-interconnection.h b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
> new file mode 100644
> index 000000000000..5b188d93ebd3
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Mediatek MT8186 audio driver interconnection definition
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> + */
> +
> +#ifndef _MT8186_INTERCONNECTION_H_
> +#define _MT8186_INTERCONNECTION_H_
> +
> +/* in port define */
> +#define I_I2S0_CH1 0
> +#define I_I2S0_CH2 1
> +#define I_ADDA_UL_CH1 3
> +#define I_ADDA_UL_CH2 4
> +#define I_DL1_CH1 5
> +#define I_DL1_CH2 6
> +#define I_DL2_CH1 7
> +#define I_DL2_CH2 8
> +#define I_PCM_1_CAP_CH1 9
> +#define I_GAIN1_OUT_CH1 10
> +#define I_GAIN1_OUT_CH2 11
> +#define I_GAIN2_OUT_CH1 12
> +#define I_GAIN2_OUT_CH2 13
> +#define I_PCM_2_CAP_CH1 14
> +#define I_ADDA_UL_CH3 17
> +#define I_ADDA_UL_CH4 18
> +#define I_DL12_CH1 19
> +#define I_DL12_CH2 20
> +#define I_DL12_CH3 5
> +#define I_DL12_CH4 6
> +#define I_PCM_2_CAP_CH2 21
> +#define I_PCM_1_CAP_CH2 22
> +#define I_DL3_CH1 23
> +#define I_DL3_CH2 24
> +#define I_I2S2_CH1 25
> +#define I_I2S2_CH2 26
> +#define I_I2S2_CH3 27
> +#define I_I2S2_CH4 28
> +
> +/* in port define >= 32 */
> +#define I_32_OFFSET 32
> +#define I_CONNSYS_I2S_CH1 (34 - I_32_OFFSET)
> +#define I_CONNSYS_I2S_CH2 (35 - I_32_OFFSET)
> +#define I_SRC_1_OUT_CH1 (36 - I_32_OFFSET)
> +#define I_SRC_1_OUT_CH2 (37 - I_32_OFFSET)
> +#define I_SRC_2_OUT_CH1 (38 - I_32_OFFSET)
> +#define I_SRC_2_OUT_CH2 (39 - I_32_OFFSET)
> +#define I_DL4_CH1 (40 - I_32_OFFSET)
> +#define I_DL4_CH2 (41 - I_32_OFFSET)
> +#define I_DL5_CH1 (42 - I_32_OFFSET)
> +#define I_DL5_CH2 (43 - I_32_OFFSET)
> +#define I_DL6_CH1 (44 - I_32_OFFSET)
> +#define I_DL6_CH2 (45 - I_32_OFFSET)
> +#define I_DL7_CH1 (46 - I_32_OFFSET)
> +#define I_DL7_CH2 (47 - I_32_OFFSET)
> +#define I_DL8_CH1 (48 - I_32_OFFSET)
> +#define I_DL8_CH2 (49 - I_32_OFFSET)
> +#define I_TDM_IN_CH1 (56 - I_32_OFFSET)
> +#define I_TDM_IN_CH2 (57 - I_32_OFFSET)
> +#define I_TDM_IN_CH3 (58 - I_32_OFFSET)
> +#define I_TDM_IN_CH4 (59 - I_32_OFFSET)
> +#define I_TDM_IN_CH5 (60 - I_32_OFFSET)
> +#define I_TDM_IN_CH6 (61 - I_32_OFFSET)
> +#define I_TDM_IN_CH7 (62 - I_32_OFFSET)
> +#define I_TDM_IN_CH8 (63 - I_32_OFFSET)
> +
> +#endif
> diff --git a/sound/soc/mediatek/mt8186/mt8186-misc-control.c b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
> new file mode 100644
> index 000000000000..c097248b37b6
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
> @@ -0,0 +1,1728 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio Misc Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +#include <sound/soc.h>
> +
> +#include "../common/mtk-afe-fe-dai.h"
> +#include "../common/mtk-afe-platform-driver.h"
> +#include "mt8186-afe-common.h"
> +
> +#define SGEN_MUTE_CH1_KCONTROL_NAME "Audio_SineGen_Mute_Ch1"
> +#define SGEN_MUTE_CH2_KCONTROL_NAME "Audio_SineGen_Mute_Ch2"
> +
> +static const char * const mt8186_sgen_mode_str[] = {
> +	"I0I1",   "I2",     "I3I4",   "I5I6",
> +	"I7I8",   "I9I22",  "I10I11", "I12I13",
> +	"I14I21", "I15I16", "I17I18", "I19I20",
> +	"I23I24", "I25I26", "I27I28", "I33",
> +	"I34I35", "I36I37", "I38I39", "I40I41",
> +	"I42I43", "I44I45", "I46I47", "I48I49",
> +	"I56I57", "I58I59", "I60I61", "I62I63",
> +	"O0O1",   "O2",     "O3O4",   "O5O6",
> +	"O7O8",   "O9O10",  "O11",    "O12",
> +	"O13O14", "O15O16", "O17O18", "O19O20",
> +	"O21O22", "O23O24", "O25",    "O28O29",
> +	"O34",    "O35",    "O32O33", "O36O37",
> +	"O38O39", "O30O31", "O40O41", "O42O43",
> +	"O44O45", "O46O47", "O48O49", "O50O51",
> +	"O58O59", "O60O61", "O62O63", "O64O65",
> +	"O66O67", "O68O69", "O26O27", "OFF",
> +};
> +
> +static const int mt8186_sgen_mode_idx[] = {
> +	0, 2, 4, 6,
> +	8, 22, 10, 12,
> +	14, -1, 18, 20,
> +	24, 26, 28, 33,
> +	34, 36, 38, 40,
> +	42, 44, 46, 48,
> +	56, 58, 60, 62,
> +	128, 130, 132, 134,
> +	135, 138, 139, 140,
> +	142, 144, 166, 148,
> +	150, 152, 153, 156,
> +	162, 163, 160, 164,
> +	166, -1, 168, 170,
> +	172, 174, 176, 178,
> +	186, 188, 190, 192,
> +	194, 196, -1, -1,
> +};
> +
> +static const char * const mt8186_sgen_rate_str[] = {
> +	"8K", "11K", "12K", "16K",
> +	"22K", "24K", "32K", "44K",
> +	"48K", "88k", "96k", "176k",
> +	"192k"
> +};
> +
> +static const int mt8186_sgen_rate_idx[] = {
> +	0, 1, 2, 4,
> +	5, 6, 8, 9,
> +	10, 11, 12, 13,
> +	14
> +};
> +
> +/* this order must match reg bit amp_div_ch1/2 */
> +static const char * const mt8186_sgen_amp_str[] = {
> +	"1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1" };
> +static const char * const mt8186_sgen_mute_str[] = {
> +	"Off", "On"
> +};
> +
> +static int mt8186_sgen_get(struct snd_kcontrol *kcontrol,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +
> +	ucontrol->value.integer.value[0] = afe_priv->sgen_mode;
> +	return 0;
> +}
> +
> +static int mt8186_sgen_set(struct snd_kcontrol *kcontrol,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int mode;
> +	int mode_idx;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	mode = ucontrol->value.integer.value[0];
> +	mode_idx = mt8186_sgen_mode_idx[mode];
> +
> +	dev_info(afe->dev, "%s(), mode %d, mode_idx %d\n",
> +		 __func__, mode, mode_idx);
> +
> +	if (mode_idx >= 0) {
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> +				   INNER_LOOP_BACK_MODE_MASK_SFT,
> +				   mode_idx << INNER_LOOP_BACK_MODE_SFT);
> +		//regmap_write(afe->regmap, AFE_SINEGEN_CON0, 0x04ac2ac1);

Why is this commented out?
Either remove the comment, or remove the line entirely.

> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   DAC_EN_MASK_SFT,
> +				   0x1 << DAC_EN_SFT);

BIT()

> +	} else {
> +		/* disable sgen */
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   DAC_EN_MASK_SFT,
> +				   0x0);
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> +				   INNER_LOOP_BACK_MODE_MASK_SFT,
> +				   0x3f << INNER_LOOP_BACK_MODE_SFT);
> +	}
> +
> +	afe_priv->sgen_mode = mode;
> +	return 0;
> +}
> +
> +static int mt8186_sgen_rate_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +
> +	ucontrol->value.integer.value[0] = afe_priv->sgen_rate;
> +	return 0;
> +}
> +
> +static int mt8186_sgen_rate_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int rate;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	rate = ucontrol->value.integer.value[0];
> +
> +	dev_info(afe->dev, "%s(), rate %d\n", __func__, rate);

dev_dbg()

> +
> +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +			   SINE_MODE_CH1_MASK_SFT,
> +			   mt8186_sgen_rate_idx[rate] << SINE_MODE_CH1_SFT);
> +
> +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +			   SINE_MODE_CH2_MASK_SFT,
> +			   mt8186_sgen_rate_idx[rate] << SINE_MODE_CH2_SFT);
> +
> +	afe_priv->sgen_rate = rate;
> +	return 0;
> +}
> +
> +static int mt8186_sgen_amplitude_get(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +
> +	ucontrol->value.integer.value[0] = afe_priv->sgen_amplitude;
> +	return 0;
> +}
> +
> +static int mt8186_sgen_amplitude_set(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int amplitude;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	amplitude = ucontrol->value.integer.value[0];
> +	if (amplitude > AMP_DIV_CH1_MASK) {
> +		dev_info(afe->dev, "%s(), amplitude %d invalid\n",
> +			 __func__, amplitude);

dev_err()

> +		return -EINVAL;
> +	}
> +
> +	dev_info(afe->dev, "%s(), amplitude %d\n", __func__, amplitude);
> +
> +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +			   AMP_DIV_CH1_MASK_SFT,
> +			   amplitude << AMP_DIV_CH1_SFT);
> +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +			   AMP_DIV_CH2_MASK_SFT,
> +			   amplitude << AMP_DIV_CH2_SFT);
> +
> +	afe_priv->sgen_amplitude = amplitude;
> +
> +	return 0;
> +}
> +
> +static int mt8186_sgen_mute_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	int mute;
> +
> +	regmap_read(afe->regmap, AFE_SINEGEN_CON0, &mute);
> +
> +	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) == 0)
> +		return (mute >> MUTE_SW_CH1_SFT) & MUTE_SW_CH1_MASK;
> +	else
> +		return (mute >> MUTE_SW_CH2_SFT) & MUTE_SW_CH2_MASK;

	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) == 0)
		return (mute >> MUTE_SW_CH1_SFT) & MUTE_SW_CH1_MASK;

	return (mute >> MUTE_SW_CH2_SFT) & MUTE_SW_CH2_MASK;

> +}
> +
> +static int mt8186_sgen_mute_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int mute;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	mute = ucontrol->value.integer.value[0];
> +
> +	dev_info(afe->dev, "%s(), kcontrol name %s, mute %d\n",
> +		 __func__, kcontrol->id.name, mute);

dev_dbg()

> +
> +	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) == 0) {
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   MUTE_SW_CH1_MASK_SFT,
> +				   mute << MUTE_SW_CH1_SFT);
> +	} else {
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   MUTE_SW_CH2_MASK_SFT,
> +				   mute << MUTE_SW_CH2_SFT);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct soc_enum mt8186_afe_sgen_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mode_str),
> +			    mt8186_sgen_mode_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_rate_str),
> +			    mt8186_sgen_rate_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_amp_str),
> +			    mt8186_sgen_amp_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mute_str),
> +			    mt8186_sgen_mute_str),
> +};
> +
> +static const struct snd_kcontrol_new mt8186_afe_sgen_controls[] = {
> +	SOC_ENUM_EXT("Audio_SineGen_Switch", mt8186_afe_sgen_enum[0],
> +		     mt8186_sgen_get, mt8186_sgen_set),
> +	SOC_ENUM_EXT("Audio_SineGen_SampleRate", mt8186_afe_sgen_enum[1],
> +		     mt8186_sgen_rate_get, mt8186_sgen_rate_set),
> +	SOC_ENUM_EXT("Audio_SineGen_Amplitude", mt8186_afe_sgen_enum[2],
> +		     mt8186_sgen_amplitude_get, mt8186_sgen_amplitude_set),
> +	SOC_ENUM_EXT(SGEN_MUTE_CH1_KCONTROL_NAME, mt8186_afe_sgen_enum[3],
> +		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
> +	SOC_ENUM_EXT(SGEN_MUTE_CH2_KCONTROL_NAME, mt8186_afe_sgen_enum[3],
> +		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
> +	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch1", AFE_SINEGEN_CON0,
> +		   FREQ_DIV_CH1_SFT, FREQ_DIV_CH1_MASK, 0),
> +	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch2", AFE_SINEGEN_CON0,
> +		   FREQ_DIV_CH2_SFT, FREQ_DIV_CH2_MASK, 0),
> +};
> +
> +/* audio debug log */
> +static const char * const mt8186_afe_off_on_str[] = {
> +	"Off", "On"
> +};
> +
> +static int mt8186_afe_debug_get(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	return 0;
> +}
> +
> +static int mt8186_afe_debug_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	unsigned int value;
> +

This should be debugfs, instead of spitting a full register dump in the kmsg:
doing so is horrible (sorry).

> +	regmap_read(afe->regmap, AUDIO_TOP_CON0, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_CON1, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_CON2, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_CON3, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAC_CON0, &value);
> +	dev_info(afe->dev, "AFE_DAC_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_CON, &value);
> +	dev_info(afe->dev, "AFE_I2S_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN0, &value);
> +	dev_info(afe->dev, "AFE_CONN0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN1, &value);
> +	dev_info(afe->dev, "AFE_CONN1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN2, &value);
> +	dev_info(afe->dev, "AFE_CONN2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN3, &value);
> +	dev_info(afe->dev, "AFE_CONN3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN4, &value);
> +	dev_info(afe->dev, "AFE_CONN4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_CON1, &value);
> +	dev_info(afe->dev, "AFE_I2S_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_CON2, &value);
> +	dev_info(afe->dev, "AFE_I2S_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_CON3, &value);
> +	dev_info(afe->dev, "AFE_I2S_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN5, &value);
> +	dev_info(afe->dev, "AFE_CONN5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_24BIT, &value);
> +	dev_info(afe->dev, "AFE_CONN_24BIT = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL1_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL1_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL1_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL1_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL1_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL1_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_END, &value);
> +	dev_info(afe->dev, "AFE_DL1_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL2_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL2_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL2_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL2_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL2_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_END, &value);
> +	dev_info(afe->dev, "AFE_DL2_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL3_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL3_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL3_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL3_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL3_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL3_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_END, &value);
> +	dev_info(afe->dev, "AFE_DL3_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN6, &value);
> +	dev_info(afe->dev, "AFE_CONN6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL4_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL4_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL4_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL4_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL4_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL4_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_END, &value);
> +	dev_info(afe->dev, "AFE_DL4_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL12_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL12_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL12_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL12_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL12_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL12_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_END, &value);
> +	dev_info(afe->dev, "AFE_DL12_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SRC2_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SRC2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SRC2_CON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SRC2_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_UL_SRC_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_UL_SRC_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_UL_SRC_CON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_UL_SRC_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_TOP_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_TOP_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_UL_DL_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_UL_DL_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_SRC_DEBUG, &value);
> +	dev_info(afe->dev, "AFE_ADDA_SRC_DEBUG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_SRC_DEBUG_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_SRC_DEBUG_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_SRC_DEBUG_MON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_SRC_DEBUG_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_UL_SRC_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_UL_SRC_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_UL_SRC_MON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_UL_SRC_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_CON0, &value);
> +	dev_info(afe->dev, "AFE_SECURE_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SRAM_BOUND, &value);
> +	dev_info(afe->dev, "AFE_SRAM_BOUND = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_CON1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_CONN0, &value);
> +	dev_info(afe->dev, "AFE_SECURE_CONN0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_END, &value);
> +	dev_info(afe->dev, "AFE_VUL_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_DEBUG, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_DEBUG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_MON, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SINEGEN_CON2, &value);
> +	dev_info(afe->dev, "AFE_SINEGEN_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_CON0, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_COEFF, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_COEFF = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_CON1, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SIDETONE_GAIN, &value);
> +	dev_info(afe->dev, "AFE_SIDETONE_GAIN = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SINEGEN_CON0, &value);
> +	dev_info(afe->dev, "AFE_SINEGEN_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_TOP_CON0, &value);
> +	dev_info(afe->dev, "AFE_TOP_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL2_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL2_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL2_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL2_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL2_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_END, &value);
> +	dev_info(afe->dev, "AFE_VUL2_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL3_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL3_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL3_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL3_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL3_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL3_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_END, &value);
> +	dev_info(afe->dev, "AFE_VUL3_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_BUSY, &value);
> +	dev_info(afe->dev, "AFE_BUSY = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_BUS_CFG, &value);
> +	dev_info(afe->dev, "AFE_BUS_CFG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_PREDIS_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_PREDIS_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_PREDIS_CON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_PREDIS_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_MON, &value);
> +	dev_info(afe->dev, "AFE_I2S_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_IIR_COEF_02_01, &value);
> +	dev_info(afe->dev, "AFE_ADDA_IIR_COEF_02_01 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_IIR_COEF_04_03, &value);
> +	dev_info(afe->dev, "AFE_ADDA_IIR_COEF_04_03 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_IIR_COEF_06_05, &value);
> +	dev_info(afe->dev, "AFE_ADDA_IIR_COEF_06_05 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_IIR_COEF_08_07, &value);
> +	dev_info(afe->dev, "AFE_ADDA_IIR_COEF_08_07 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_IIR_COEF_10_09, &value);
> +	dev_info(afe->dev, "AFE_ADDA_IIR_COEF_10_09 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CON1, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CON2, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAC_MON, &value);
> +	dev_info(afe->dev, "AFE_DAC_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CON3, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CON4, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CON4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT0, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT6, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT8, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_DSP2_EN, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_DSP2_EN = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ0_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ0_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ6_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ6_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL4_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL4_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL4_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL4_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL4_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL4_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_END, &value);
> +	dev_info(afe->dev, "AFE_VUL4_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL12_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL12_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL12_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL12_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL12_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL12_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_END, &value);
> +	dev_info(afe->dev, "AFE_VUL12_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ3_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ3_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ4_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ4_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CON0, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_STATUS = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CLR, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CLR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT1, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT2, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_EN = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_MON2, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_MON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT5, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ1_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ1_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ2_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ2_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ5_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ5_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_DSP_EN, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_DSP_EN = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_SCP_EN, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_SCP_EN = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT7, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ7_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ7_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT3, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT4, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT11, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT11 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_APLL1_TUNER_CFG, &value);
> +	dev_info(afe->dev, "AFE_APLL1_TUNER_CFG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_APLL2_TUNER_CFG, &value);
> +	dev_info(afe->dev, "AFE_APLL2_TUNER_CFG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_MISS_CLR, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_MISS_CLR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN33, &value);
> +	dev_info(afe->dev, "AFE_CONN33 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT12, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN1_CON0, &value);
> +	dev_info(afe->dev, "AFE_GAIN1_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN1_CON1, &value);
> +	dev_info(afe->dev, "AFE_GAIN1_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN1_CON2, &value);
> +	dev_info(afe->dev, "AFE_GAIN1_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN1_CON3, &value);
> +	dev_info(afe->dev, "AFE_GAIN1_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN7, &value);
> +	dev_info(afe->dev, "AFE_CONN7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN1_CUR, &value);
> +	dev_info(afe->dev, "AFE_GAIN1_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN2_CON0, &value);
> +	dev_info(afe->dev, "AFE_GAIN2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN2_CON1, &value);
> +	dev_info(afe->dev, "AFE_GAIN2_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN2_CON2, &value);
> +	dev_info(afe->dev, "AFE_GAIN2_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN2_CON3, &value);
> +	dev_info(afe->dev, "AFE_GAIN2_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN8, &value);
> +	dev_info(afe->dev, "AFE_CONN8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GAIN2_CUR, &value);
> +	dev_info(afe->dev, "AFE_GAIN2_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN9, &value);
> +	dev_info(afe->dev, "AFE_CONN9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN10, &value);
> +	dev_info(afe->dev, "AFE_CONN10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN11, &value);
> +	dev_info(afe->dev, "AFE_CONN11 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN12, &value);
> +	dev_info(afe->dev, "AFE_CONN12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN13, &value);
> +	dev_info(afe->dev, "AFE_CONN13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN14, &value);
> +	dev_info(afe->dev, "AFE_CONN14 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN15, &value);
> +	dev_info(afe->dev, "AFE_CONN15 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN16, &value);
> +	dev_info(afe->dev, "AFE_CONN16 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN17, &value);
> +	dev_info(afe->dev, "AFE_CONN17 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN18, &value);
> +	dev_info(afe->dev, "AFE_CONN18 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN19, &value);
> +	dev_info(afe->dev, "AFE_CONN19 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN20, &value);
> +	dev_info(afe->dev, "AFE_CONN20 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN21, &value);
> +	dev_info(afe->dev, "AFE_CONN21 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN22, &value);
> +	dev_info(afe->dev, "AFE_CONN22 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN23, &value);
> +	dev_info(afe->dev, "AFE_CONN23 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN24, &value);
> +	dev_info(afe->dev, "AFE_CONN24 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_RS, &value);
> +	dev_info(afe->dev, "AFE_CONN_RS = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_DI, &value);
> +	dev_info(afe->dev, "AFE_CONN_DI = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN25, &value);
> +	dev_info(afe->dev, "AFE_CONN25 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN26, &value);
> +	dev_info(afe->dev, "AFE_CONN26 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN27, &value);
> +	dev_info(afe->dev, "AFE_CONN27 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN28, &value);
> +	dev_info(afe->dev, "AFE_CONN28 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN29, &value);
> +	dev_info(afe->dev, "AFE_CONN29 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN30, &value);
> +	dev_info(afe->dev, "AFE_CONN30 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN31, &value);
> +	dev_info(afe->dev, "AFE_CONN31 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN32, &value);
> +	dev_info(afe->dev, "AFE_CONN32 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SRAM_DELSEL_CON1, &value);
> +	dev_info(afe->dev, "AFE_SRAM_DELSEL_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN56, &value);
> +	dev_info(afe->dev, "AFE_CONN56 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN57, &value);
> +	dev_info(afe->dev, "AFE_CONN57 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN56_1, &value);
> +	dev_info(afe->dev, "AFE_CONN56_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN57_1, &value);
> +	dev_info(afe->dev, "AFE_CONN57_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, PCM_INTF_CON1, &value);
> +	dev_info(afe->dev, "PCM_INTF_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, PCM_INTF_CON2, &value);
> +	dev_info(afe->dev, "PCM_INTF_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, PCM2_INTF_CON, &value);
> +	dev_info(afe->dev, "PCM2_INTF_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN34, &value);
> +	dev_info(afe->dev, "AFE_CONN34 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_DBG_CON, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_DBG_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_DBG_MON0, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_DBG_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AUDIO_TOP_DBG_MON1, &value);
> +	dev_info(afe->dev, "AUDIO_TOP_DBG_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ8_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ8_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ11_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ11_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ12_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ12_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT9, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT10, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT13, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT14, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT14 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT15, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT15 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT16, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT16 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT17, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT17 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT18, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT18 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT19, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT19 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT20, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT20 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT21, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT21 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT22, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT22 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT23, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT23 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT24, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT24 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT25, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT25 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ_MCU_CNT26, &value);
> +	dev_info(afe->dev, "AFE_IRQ_MCU_CNT26 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ9_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ9_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ10_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ10_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ13_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ13_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ14_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ14_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ15_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ15_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ16_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ16_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ17_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ17_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ18_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ18_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ19_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ19_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ20_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ20_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ21_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ21_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ22_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ22_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ23_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ23_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ24_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ24_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ25_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ25_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ26_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ26_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_IRQ31_MCU_CNT_MON, &value);
> +	dev_info(afe->dev, "AFE_IRQ31_MCU_CNT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG0, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG1, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG2, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG3, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG4, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG5, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG6, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG7, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG8, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG9, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG10, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG11, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG11 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG12, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG13, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG14, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG14 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL_REG15, &value);
> +	dev_info(afe->dev, "AFE_GENERAL_REG15 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CBIP_CFG0, &value);
> +	dev_info(afe->dev, "AFE_CBIP_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CBIP_MON0, &value);
> +	dev_info(afe->dev, "AFE_CBIP_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CBIP_SLV_MUX_MON0, &value);
> +	dev_info(afe->dev, "AFE_CBIP_SLV_MUX_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CBIP_SLV_DECODER_MON0, &value);
> +	dev_info(afe->dev, "AFE_CBIP_SLV_DECODER_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_MON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_CON0, &value);
> +	dev_info(afe->dev, "AFE_AWB_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_BASE, &value);
> +	dev_info(afe->dev, "AFE_AWB_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_CUR, &value);
> +	dev_info(afe->dev, "AFE_AWB_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_END, &value);
> +	dev_info(afe->dev, "AFE_AWB_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_CON0, &value);
> +	dev_info(afe->dev, "AFE_AWB2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB2_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_BASE, &value);
> +	dev_info(afe->dev, "AFE_AWB2_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB2_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_CUR, &value);
> +	dev_info(afe->dev, "AFE_AWB2_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_AWB2_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_END, &value);
> +	dev_info(afe->dev, "AFE_AWB2_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_CON0, &value);
> +	dev_info(afe->dev, "AFE_DAI_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_BASE, &value);
> +	dev_info(afe->dev, "AFE_DAI_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_CUR, &value);
> +	dev_info(afe->dev, "AFE_DAI_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_END, &value);
> +	dev_info(afe->dev, "AFE_DAI_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_CON0, &value);
> +	dev_info(afe->dev, "AFE_DAI2_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI2_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_BASE, &value);
> +	dev_info(afe->dev, "AFE_DAI2_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI2_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_CUR, &value);
> +	dev_info(afe->dev, "AFE_DAI2_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DAI2_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_END, &value);
> +	dev_info(afe->dev, "AFE_DAI2_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MEMIF_CON0, &value);
> +	dev_info(afe->dev, "AFE_MEMIF_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN0_1, &value);
> +	dev_info(afe->dev, "AFE_CONN0_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN1_1, &value);
> +	dev_info(afe->dev, "AFE_CONN1_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN2_1, &value);
> +	dev_info(afe->dev, "AFE_CONN2_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN3_1, &value);
> +	dev_info(afe->dev, "AFE_CONN3_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN4_1, &value);
> +	dev_info(afe->dev, "AFE_CONN4_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN5_1, &value);
> +	dev_info(afe->dev, "AFE_CONN5_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN6_1, &value);
> +	dev_info(afe->dev, "AFE_CONN6_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN7_1, &value);
> +	dev_info(afe->dev, "AFE_CONN7_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN8_1, &value);
> +	dev_info(afe->dev, "AFE_CONN8_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN9_1, &value);
> +	dev_info(afe->dev, "AFE_CONN9_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN10_1, &value);
> +	dev_info(afe->dev, "AFE_CONN10_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN11_1, &value);
> +	dev_info(afe->dev, "AFE_CONN11_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN12_1, &value);
> +	dev_info(afe->dev, "AFE_CONN12_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN13_1, &value);
> +	dev_info(afe->dev, "AFE_CONN13_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN14_1, &value);
> +	dev_info(afe->dev, "AFE_CONN14_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN15_1, &value);
> +	dev_info(afe->dev, "AFE_CONN15_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN16_1, &value);
> +	dev_info(afe->dev, "AFE_CONN16_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN17_1, &value);
> +	dev_info(afe->dev, "AFE_CONN17_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN18_1, &value);
> +	dev_info(afe->dev, "AFE_CONN18_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN19_1, &value);
> +	dev_info(afe->dev, "AFE_CONN19_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN20_1, &value);
> +	dev_info(afe->dev, "AFE_CONN20_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN21_1, &value);
> +	dev_info(afe->dev, "AFE_CONN21_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN22_1, &value);
> +	dev_info(afe->dev, "AFE_CONN22_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN23_1, &value);
> +	dev_info(afe->dev, "AFE_CONN23_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN24_1, &value);
> +	dev_info(afe->dev, "AFE_CONN24_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN25_1, &value);
> +	dev_info(afe->dev, "AFE_CONN25_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN26_1, &value);
> +	dev_info(afe->dev, "AFE_CONN26_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN27_1, &value);
> +	dev_info(afe->dev, "AFE_CONN27_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN28_1, &value);
> +	dev_info(afe->dev, "AFE_CONN28_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN29_1, &value);
> +	dev_info(afe->dev, "AFE_CONN29_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN30_1, &value);
> +	dev_info(afe->dev, "AFE_CONN30_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN31_1, &value);
> +	dev_info(afe->dev, "AFE_CONN31_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN32_1, &value);
> +	dev_info(afe->dev, "AFE_CONN32_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN33_1, &value);
> +	dev_info(afe->dev, "AFE_CONN33_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN34_1, &value);
> +	dev_info(afe->dev, "AFE_CONN34_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_RS_1, &value);
> +	dev_info(afe->dev, "AFE_CONN_RS_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_DI_1, &value);
> +	dev_info(afe->dev, "AFE_CONN_DI_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_24BIT_1, &value);
> +	dev_info(afe->dev, "AFE_CONN_24BIT_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN_REG, &value);
> +	dev_info(afe->dev, "AFE_CONN_REG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN35, &value);
> +	dev_info(afe->dev, "AFE_CONN35 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN36, &value);
> +	dev_info(afe->dev, "AFE_CONN36 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN37, &value);
> +	dev_info(afe->dev, "AFE_CONN37 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN38, &value);
> +	dev_info(afe->dev, "AFE_CONN38 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN35_1, &value);
> +	dev_info(afe->dev, "AFE_CONN35_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN36_1, &value);
> +	dev_info(afe->dev, "AFE_CONN36_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN37_1, &value);
> +	dev_info(afe->dev, "AFE_CONN37_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN38_1, &value);
> +	dev_info(afe->dev, "AFE_CONN38_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN39, &value);
> +	dev_info(afe->dev, "AFE_CONN39 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN40, &value);
> +	dev_info(afe->dev, "AFE_CONN40 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN41, &value);
> +	dev_info(afe->dev, "AFE_CONN41 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN42, &value);
> +	dev_info(afe->dev, "AFE_CONN42 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN39_1, &value);
> +	dev_info(afe->dev, "AFE_CONN39_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN40_1, &value);
> +	dev_info(afe->dev, "AFE_CONN40_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN41_1, &value);
> +	dev_info(afe->dev, "AFE_CONN41_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN42_1, &value);
> +	dev_info(afe->dev, "AFE_CONN42_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_I2S_CON4, &value);
> +	dev_info(afe->dev, "AFE_I2S_CON4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_TOP_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_TOP_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_UL_SRC_CON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_UL_SRC_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_UL_SRC_CON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_UL_SRC_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_SRC_DEBUG, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_SRC_DEBUG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_SRC_DEBUG_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_SRC_DEBUG_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_02_01, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_02_01 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_04_03, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_04_03 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_06_05, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_06_05 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_08_07, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_08_07 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_10_09, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_10_09 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_12_11, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_12_11 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_14_13, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_14_13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_16_15, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_16_15 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_18_17, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_18_17 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_20_19, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_20_19 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_22_21, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_22_21 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_24_23, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_24_23 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_26_25, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_26_25 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_28_27, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_28_27 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_ULCF_CFG_30_29, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_ULCF_CFG_30_29 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADD6A_UL_SRC_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADD6A_UL_SRC_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_UL_SRC_MON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_UL_SRC_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN43, &value);
> +	dev_info(afe->dev, "AFE_CONN43 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN43_1, &value);
> +	dev_info(afe->dev, "AFE_CONN43_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_CON0, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_BASE, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_CUR, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_END, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_AWB_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_AWB_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL12_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL12_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL12_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL2_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL2_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL2_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI_DATA_MON, &value);
> +	dev_info(afe->dev, "AFE_DAI_DATA_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_MOD_DAI_DATA_MON, &value);
> +	dev_info(afe->dev, "AFE_MOD_DAI_DATA_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DAI2_DATA_MON, &value);
> +	dev_info(afe->dev, "AFE_DAI2_DATA_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_AWB2_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AWB2_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_AWB2_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL3_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL3_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL3_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL4_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL4_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL4_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL5_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL5_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL6_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_VUL6_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL1_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL1_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL1_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL2_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL2_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL2_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_RCH1_MON, &value);
> +	dev_info(afe->dev, "AFE_DL12_RCH1_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_LCH1_MON, &value);
> +	dev_info(afe->dev, "AFE_DL12_LCH1_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_RCH2_MON, &value);
> +	dev_info(afe->dev, "AFE_DL12_RCH2_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL12_LCH2_MON, &value);
> +	dev_info(afe->dev, "AFE_DL12_LCH2_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL3_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL3_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL3_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL4_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL4_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL4_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL5_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL5_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL6_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL6_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL7_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL7_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL8_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_DL8_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL5_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL5_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL5_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL5_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL5_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL5_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL5_END, &value);
> +	dev_info(afe->dev, "AFE_VUL5_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_CON0, &value);
> +	dev_info(afe->dev, "AFE_VUL6_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL6_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_BASE, &value);
> +	dev_info(afe->dev, "AFE_VUL6_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL6_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_CUR, &value);
> +	dev_info(afe->dev, "AFE_VUL6_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_VUL6_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_VUL6_END, &value);
> +	dev_info(afe->dev, "AFE_VUL6_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_DCCOMP_CON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_DCCOMP_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_TEST, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_TEST = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_DC_COMP_CFG0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_DC_COMP_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_DC_COMP_CFG1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_DC_COMP_CFG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_FIFO_MON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_FIFO_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SRC_LCH_MON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SRC_LCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SRC_RCH_MON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SRC_RCH_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_OUT_MON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_OUT_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_DITHER_CON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_DITHER_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_SDM_AUTO_RESET_CON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_SDM_AUTO_RESET_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONNSYS_I2S_CON, &value);
> +	dev_info(afe->dev, "AFE_CONNSYS_I2S_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONNSYS_I2S_MON, &value);
> +	dev_info(afe->dev, "AFE_CONNSYS_I2S_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON0, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON1, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON2, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON3, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON4, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON5, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON6, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON7, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON8, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON9, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON10, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON12, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ASRC_2CH_CON13, &value);
> +	dev_info(afe->dev, "AFE_ASRC_2CH_CON13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_IIR_COEF_02_01, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_IIR_COEF_02_01 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_IIR_COEF_04_03, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_IIR_COEF_04_03 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_IIR_COEF_06_05, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_IIR_COEF_06_05 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_IIR_COEF_08_07, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_IIR_COEF_08_07 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_IIR_COEF_10_09, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_IIR_COEF_10_09 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_PROT_SIDEBAND, &value);
> +	dev_info(afe->dev, "AFE_SE_PROT_SIDEBAND = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_DOMAIN_SIDEBAND0, &value);
> +	dev_info(afe->dev, "AFE_SE_DOMAIN_SIDEBAND0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_PREDIS_CON2, &value);
> +	dev_info(afe->dev, "AFE_ADDA_PREDIS_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_PREDIS_CON3, &value);
> +	dev_info(afe->dev, "AFE_ADDA_PREDIS_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_DOMAIN_SIDEBAND1, &value);
> +	dev_info(afe->dev, "AFE_SE_DOMAIN_SIDEBAND1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_DOMAIN_SIDEBAND2, &value);
> +	dev_info(afe->dev, "AFE_SE_DOMAIN_SIDEBAND2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_DOMAIN_SIDEBAND3, &value);
> +	dev_info(afe->dev, "AFE_SE_DOMAIN_SIDEBAND3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN44, &value);
> +	dev_info(afe->dev, "AFE_CONN44 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN45, &value);
> +	dev_info(afe->dev, "AFE_CONN45 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN46, &value);
> +	dev_info(afe->dev, "AFE_CONN46 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN47, &value);
> +	dev_info(afe->dev, "AFE_CONN47 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN44_1, &value);
> +	dev_info(afe->dev, "AFE_CONN44_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN45_1, &value);
> +	dev_info(afe->dev, "AFE_CONN45_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN46_1, &value);
> +	dev_info(afe->dev, "AFE_CONN46_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN47_1, &value);
> +	dev_info(afe->dev, "AFE_CONN47_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_HD_ENGEN_ENABLE, &value);
> +	dev_info(afe->dev, "AFE_HD_ENGEN_ENABLE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_DL_NLE_FIFO_MON, &value);
> +	dev_info(afe->dev, "AFE_ADDA_DL_NLE_FIFO_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_CFG0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_SYNCWORD_CFG, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_SYNCWORD_CFG = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_RX_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_RX_CFG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG2, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_RX_CFG2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_MON0, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA_MTKAIF_MON1, &value);
> +	dev_info(afe->dev, "AFE_ADDA_MTKAIF_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_AUD_PAD_TOP, &value);
> +	dev_info(afe->dev, "AFE_AUD_PAD_TOP = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_R_CFG0, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_R_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_R_CFG1, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_R_CFG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_L_CFG0, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_L_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_L_CFG1, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_L_CFG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_R_MON0, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_R_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_R_MON1, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_R_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_R_MON2, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_R_MON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_L_MON0, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_L_MON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_L_MON1, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_L_MON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_L_MON2, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_L_MON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL_NLE_GAIN_CFG0, &value);
> +	dev_info(afe->dev, "AFE_DL_NLE_GAIN_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_CFG0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_RX_CFG0, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_RX_CFG0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_RX_CFG1, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_RX_CFG1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_ADDA6_MTKAIF_RX_CFG2, &value);
> +	dev_info(afe->dev, "AFE_ADDA6_MTKAIF_RX_CFG2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON0, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON1, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON2, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON3, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON4, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON5, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON6, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON7, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON8, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON9, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON10, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON12, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL1_ASRC_2CH_CON13, &value);
> +	dev_info(afe->dev, "AFE_GENERAL1_ASRC_2CH_CON13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, GENERAL_ASRC_MODE, &value);
> +	dev_info(afe->dev, "GENERAL_ASRC_MODE = 0x%x\n", value);
> +	regmap_read(afe->regmap, GENERAL_ASRC_EN_ON, &value);
> +	dev_info(afe->dev, "GENERAL_ASRC_EN_ON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN48, &value);
> +	dev_info(afe->dev, "AFE_CONN48 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN49, &value);
> +	dev_info(afe->dev, "AFE_CONN49 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN50, &value);
> +	dev_info(afe->dev, "AFE_CONN50 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN51, &value);
> +	dev_info(afe->dev, "AFE_CONN51 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN52, &value);
> +	dev_info(afe->dev, "AFE_CONN52 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN53, &value);
> +	dev_info(afe->dev, "AFE_CONN53 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN54, &value);
> +	dev_info(afe->dev, "AFE_CONN54 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN55, &value);
> +	dev_info(afe->dev, "AFE_CONN55 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN48_1, &value);
> +	dev_info(afe->dev, "AFE_CONN48_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN49_1, &value);
> +	dev_info(afe->dev, "AFE_CONN49_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN50_1, &value);
> +	dev_info(afe->dev, "AFE_CONN50_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN51_1, &value);
> +	dev_info(afe->dev, "AFE_CONN51_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN52_1, &value);
> +	dev_info(afe->dev, "AFE_CONN52_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN53_1, &value);
> +	dev_info(afe->dev, "AFE_CONN53_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN54_1, &value);
> +	dev_info(afe->dev, "AFE_CONN54_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_CONN55_1, &value);
> +	dev_info(afe->dev, "AFE_CONN55_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON0, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON1, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON2, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON3, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON4, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON5, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON6, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON7, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON8, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON9, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON10, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON12, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_GENERAL2_ASRC_2CH_CON13, &value);
> +	dev_info(afe->dev, "AFE_GENERAL2_ASRC_2CH_CON13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL5_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL5_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL5_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL5_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL5_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL5_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL5_END, &value);
> +	dev_info(afe->dev, "AFE_DL5_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL6_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL6_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL6_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL6_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL6_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL6_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL6_END, &value);
> +	dev_info(afe->dev, "AFE_DL6_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL7_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL7_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL7_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL7_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL7_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL7_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL7_END, &value);
> +	dev_info(afe->dev, "AFE_DL7_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_CON0, &value);
> +	dev_info(afe->dev, "AFE_DL8_CON0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_BASE_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL8_BASE_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_BASE, &value);
> +	dev_info(afe->dev, "AFE_DL8_BASE = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_CUR_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL8_CUR_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_CUR, &value);
> +	dev_info(afe->dev, "AFE_DL8_CUR = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_END_MSB, &value);
> +	dev_info(afe->dev, "AFE_DL8_END_MSB = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DL8_END, &value);
> +	dev_info(afe->dev, "AFE_DL8_END = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SE_SECURE_CON, &value);
> +	dev_info(afe->dev, "AFE_SE_SECURE_CON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_PROT_SIDEBAND_MON, &value);
> +	dev_info(afe->dev, "AFE_PROT_SIDEBAND_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DOMAIN_SIDEBAND0_MON, &value);
> +	dev_info(afe->dev, "AFE_DOMAIN_SIDEBAND0_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DOMAIN_SIDEBAND1_MON, &value);
> +	dev_info(afe->dev, "AFE_DOMAIN_SIDEBAND1_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DOMAIN_SIDEBAND2_MON, &value);
> +	dev_info(afe->dev, "AFE_DOMAIN_SIDEBAND2_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_DOMAIN_SIDEBAND3_MON, &value);
> +	dev_info(afe->dev, "AFE_DOMAIN_SIDEBAND3_MON = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN0, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN0 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN2, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN2 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN3, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN3 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN4, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN4 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN5, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN5 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN6, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN6 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN7, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN7 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN8, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN8 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN9, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN9 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN10, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN10 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN11, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN11 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN12, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN12 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN13, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN13 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN14, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN14 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN15, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN15 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN16, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN16 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN17, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN17 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN18, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN18 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN19, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN19 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN20, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN20 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN21, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN21 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN22, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN22 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN23, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN23 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN24, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN24 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN25, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN25 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN26, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN26 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN27, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN27 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN28, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN28 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN29, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN29 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN30, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN30 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN31, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN31 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN32, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN32 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN33, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN33 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN34, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN34 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN35, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN35 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN36, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN36 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN37, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN37 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN38, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN38 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN39, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN39 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN40, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN40 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN41, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN41 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN42, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN42 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN43, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN43 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN44, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN44 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN45, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN45 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN46, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN46 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN47, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN47 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN48, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN48 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN49, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN49 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN50, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN50 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN51, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN51 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN52, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN52 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN53, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN53 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN54, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN54 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN55, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN55 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN56, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN56 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN57, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN57 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN0_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN0_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN1_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN1_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN2_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN2_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN3_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN3_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN4_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN4_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN5_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN5_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN6_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN6_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN7_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN7_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN8_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN8_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN9_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN9_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN10_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN10_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN11_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN11_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN12_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN12_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN13_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN13_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN14_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN14_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN15_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN15_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN16_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN16_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN17_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN17_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN18_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN18_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN19_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN19_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN20_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN20_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN21_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN21_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN22_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN22_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN23_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN23_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN24_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN24_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN25_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN25_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN26_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN26_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN27_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN27_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN28_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN28_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN29_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN29_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN30_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN30_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN31_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN31_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN32_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN32_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN33_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN33_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN34_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN34_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN35_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN35_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN36_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN36_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN37_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN37_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN38_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN38_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN39_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN39_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN40_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN40_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN41_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN41_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN42_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN42_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN43_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN43_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN44_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN44_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN45_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN45_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN46_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN46_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN47_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN47_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN48_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN48_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN49_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN49_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN50_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN50_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN51_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN51_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN52_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN52_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN53_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN53_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN54_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN54_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN55_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN55_1 = 0x%x\n", value);
> +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN56_1, &value);
> +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN56_1 = 0x%x\n", value);
> +
> +	return 0;
> +}
> +
> +static const struct soc_enum mt8186_afe_misc_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_afe_off_on_str),
> +			    mt8186_afe_off_on_str),
> +};
> +
> +static const struct snd_kcontrol_new mt8186_afe_debug_controls[] = {
> +	SOC_ENUM_EXT("Audio_Debug_Setting", mt8186_afe_misc_enum[0],
> +		     mt8186_afe_debug_get, mt8186_afe_debug_set),
> +};
> +
> +int mt8186_add_misc_control(struct snd_soc_component *component)
> +{
> +	snd_soc_add_component_controls(component,
> +				       mt8186_afe_sgen_controls,
> +				       ARRAY_SIZE(mt8186_afe_sgen_controls));
> +
> +	snd_soc_add_component_controls(component,
> +				       mt8186_afe_debug_controls,
> +				       ARRAY_SIZE(mt8186_afe_debug_controls));
> +
> +	return 0;
> +}
> diff --git a/sound/soc/mediatek/mt8186/mt8186-reg.h b/sound/soc/mediatek/mt8186/mt8186-reg.h
> new file mode 100644
> index 000000000000..34bb28188fca
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-reg.h
> @@ -0,0 +1,3433 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * mt8186-reg.h  --  Mediatek 8186 audio driver reg definition
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> + */
> +
> +#ifndef _MT8186_REG_H_
> +#define _MT8186_REG_H_
> +
> +/* reg bit enum */
> +enum {
> +	MT8186_MEMIF_PBUF_SIZE_32_BYTES,
> +	MT8186_MEMIF_PBUF_SIZE_64_BYTES,
> +	MT8186_MEMIF_PBUF_SIZE_128_BYTES,
> +	MT8186_MEMIF_PBUF_SIZE_256_BYTES,
> +	MT8186_MEMIF_PBUF_SIZE_NUM,
> +};
> +
> +/*****************************************************************************
> + *                  R E G I S T E R       D E F I N I T I O N
> + *****************************************************************************/
> +/* AUDIO_TOP_CON0 */
> +#define RESERVED_SFT					31
> +#define RESERVED_MASK					0x1
> +#define RESERVED_MASK_SFT				(0x1 << 31)

BIT() and GENMASK() macros please!

Regards,
Angelo

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
