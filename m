Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291F546309
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbiFJKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348125AbiFJKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:02:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA257B0A6E;
        Fri, 10 Jun 2022 03:02:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9780660173B;
        Fri, 10 Jun 2022 11:02:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654855325;
        bh=4RmeL8OoRvwTRPjcy9R34dIdSFR4j/KUysjnhoDR5tM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MdWfEoWRLnqD/8GdzQ6y1S1xEOLCa4BxGoMaNEFIGobL2tWvAQi5xrZREl+FcXuJo
         vsWGJJzcnkqZxyhmotmK+fjtHyXsinJtGcprszocVFjJUwlHNkfKCkQ+VGHxc3tLW6
         dTtQvLNLKD3s1WAfFzSdNuHyEGKTsr2cKTE40nNdiX9B28++KpmSBeS6vq5KkZSL/X
         2khpxy0asninbBhVqIl03LvKYHm7ZIVv8ISgsecO7+O2Bb3fxZStohAxkPsFjrQpaU
         Tr/XV7Jh1GUQ7CPuoY9M4QTdoFsV3LnFl6/TReW+CFpp18xyi8/T4q6j4Do7ib3+nT
         iApa2/7txVaEg==
Message-ID: <af063ee7-fcd2-c3c8-8889-8d5a34baeb3c@collabora.com>
Date:   Fri, 10 Jun 2022 12:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/8] ASoC: mediatek: mt8186: add platform driver
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
 <20220610082724.29256-3-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220610082724.29256-3-jiaxin.yu@mediatek.com>
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
> Add mt8186 platform and affiliated driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                    |   12 +
>   sound/soc/mediatek/Makefile                   |    1 +
>   sound/soc/mediatek/mt8186/Makefile            |   19 +
>   sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
>   .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
>   sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3009 +++++++++++++++++
>   6 files changed, 3537 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/Makefile
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> 

..snip..

> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-control.c b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> new file mode 100644
> index 000000000000..2d78212c3c3f
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

..snip..

> +
> +static unsigned int pcm_rate_transform(struct device *dev,
> +				       unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_AFE_PCM_RATE_8K;
> +	case 16000:
> +		return MTK_AFE_PCM_RATE_16K;
> +	case 32000:
> +		return MTK_AFE_PCM_RATE_32K;
> +	case 48000:
> +		return MTK_AFE_PCM_RATE_48K;
> +	default:
> +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> +			 __func__,
> +			 rate, MTK_AFE_PCM_RATE_32K);
> +		return MTK_AFE_PCM_RATE_32K;

This return statement should go outside of the switch, and that print
should be a dev_err() instead.

> +	}
> +}
> +
> +unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev,
> +					       unsigned int rate)
> +{
> +	switch (rate) {
> +	case 8000:
> +		return MTK_AFE_TDM_RELATCH_RATE_8K;
> +	case 11025:
> +		return MTK_AFE_TDM_RELATCH_RATE_11K;
> +	case 12000:
> +		return MTK_AFE_TDM_RELATCH_RATE_12K;
> +	case 16000:
> +		return MTK_AFE_TDM_RELATCH_RATE_16K;
> +	case 22050:
> +		return MTK_AFE_TDM_RELATCH_RATE_22K;
> +	case 24000:
> +		return MTK_AFE_TDM_RELATCH_RATE_24K;
> +	case 32000:
> +		return MTK_AFE_TDM_RELATCH_RATE_32K;
> +	case 44100:
> +		return MTK_AFE_TDM_RELATCH_RATE_44K;
> +	case 48000:
> +		return MTK_AFE_TDM_RELATCH_RATE_48K;
> +	case 88200:
> +		return MTK_AFE_TDM_RELATCH_RATE_88K;
> +	case 96000:
> +		return MTK_AFE_TDM_RELATCH_RATE_96K;
> +	case 176400:
> +		return MTK_AFE_TDM_RELATCH_RATE_176K;
> +	case 192000:
> +		return MTK_AFE_TDM_RELATCH_RATE_192K;
> +	case 352800:
> +		return MTK_AFE_TDM_RELATCH_RATE_352K;
> +	case 384000:
> +		return MTK_AFE_TDM_RELATCH_RATE_384K;
> +	default:
> +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> +			 __func__,
> +			 rate, MTK_AFE_TDM_RELATCH_RATE_48K);
> +		return MTK_AFE_TDM_RELATCH_RATE_48K;

Same here.

> +	}
> +}
> +
> +unsigned int mt8186_rate_transform(struct device *dev,
> +				   unsigned int rate, int aud_blk)
> +{
> +	switch (aud_blk) {
> +	case MT8186_DAI_PCM:
> +		return pcm_rate_transform(dev, rate);
> +	case MT8186_DAI_TDM_IN:
> +		return tdm_rate_transform(dev, rate);
> +	default:
> +		return mt8186_general_rate_transform(dev, rate);
> +	}
> +}
> +
> +int mt8186_dai_set_priv(struct mtk_base_afe *afe, int id,
> +			int priv_size, const void *priv_data)
> +{
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	void *temp_data;
> +
> +	temp_data = devm_kzalloc(afe->dev,
> +				 priv_size,
> +				 GFP_KERNEL);
> +	if (!temp_data)
> +		return -ENOMEM;
> +
> +	if (priv_data)
> +		memcpy(temp_data, priv_data, priv_size);
> +
> +	afe_priv->dai_priv[id] = temp_data;
> +
> +	return 0;
> +}
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> new file mode 100644
> index 000000000000..aaba8627d9e1
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> @@ -0,0 +1,3009 @@
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

..snip..

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

This comment says that we should wait for "some platform related operation":
it's not describing what kind of operation we would wait for... and we are
not waiting for anything at all and just returning.

Are you implementing this wait mechanism?
...otherwise, there's no need for that goto at all.

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

You're assigning a value to 'counter' here and you may or may not use it,
because if we look down there...

> +	unsigned int rate = runtime->rate;
> +	int fs;
> +	int ret;
> +
> +	dev_dbg(afe->dev, "%s(), %s cmd %d, irq_id %d\n",
> +		__func__, memif->data->name, cmd, irq_id);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = mtk_memif_set_enable(afe, id);
> +		if (ret) {
> +			dev_err(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
> +				__func__, id, ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * for small latency record
> +		 * ul memif need read some data before irq enable
> +		 */
> +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
> +		    ((runtime->period_size * 1000) / rate <= 10))
> +			udelay(300);
> +
> +		/* set irq counter */
> +		if (afe_priv->irq_cnt[id] > 0)
> +			counter = afe_priv->irq_cnt[id];

...you're reassigning the counter if irq_cnt > 0, so you can as well avoid a
reassignment if you simply do it like

		if (afe_priv->irq_cnt[id] > 0)
			counter = afe_priv->irq_cnt[id];
		else
			counter = runtime->period_size;

> +
> +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> +				   irq_data->irq_cnt_maskbit
> +				   << irq_data->irq_cnt_shift,
> +				   counter << irq_data->irq_cnt_shift);
> +
> +		/* set irq fs */
> +		fs = afe->irq_fs(substream, runtime->rate);
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
> +					dev_err(afe->dev, "%s(), id %d, xrun assert\n",
> +						__func__, id);

You're printing an error here, but not returning an error state related to
this one at the end of this case... why?

(if this is intended, add a comment in the code explaining the reason)

> +				}
> +			}
> +		} > +
> +		ret = mtk_memif_set_disable(afe, id);
> +		if (ret)
> +			dev_err(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
> +				__func__, id, ret);
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

..snip..

> +
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
> +	dev_dbg(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
> +		__func__, irq_id, irq_cnt, ucontrol->value.integer.value[0]);
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

This should probably be a dev_dbg, as that's not supposed to normally happen.
Besides, since the expected flow for this function is to write to registers,
I think that for readability purposes it's best to invert this conditional:

	if (!pm_runtime_status_suspended(afe->dev) && irq_id >= 0) {
		.....
	} else {
		dev_dbg(.....)
	}

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
> +	return 1;
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
> +
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
> +	dev_dbg(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
> +		__func__, irq_id, irq_cnt, ucontrol->value.integer.value[0]);
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

same here.

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
> +	return 1;
> +}
> +

..snip..

> +
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
> +	/* request irq */
> +	irq_id = platform_get_irq(pdev, 0);
> +	if (irq_id <= 0)
> +		return dev_err_probe(dev, irq_id < 0 ? irq_id : -ENXIO,
> +				     "no irq found");
> +
> +	ret = devm_request_irq(dev, irq_id, mt8186_afe_irq_handler,
> +			       IRQF_TRIGGER_NONE,
> +			       "Afe_ISR_Handle", (void *)afe);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
> +
> +	ret = enable_irq_wake(irq_id);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "enable_irq_wake %d\n", irq_id);
> +
> +	/* init sub_dais */
> +	INIT_LIST_HEAD(&afe->sub_dais);
> +
> +	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
> +		ret = dai_register_cbs[i](afe);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "dai register i %d fail\n", i);
> +	}
> +
> +	/* init dai_driver and component_driver */
> +	ret = mtk_afe_combine_sub_dai(afe);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "mtk_afe_combine_sub_dai fail\n");
> +
> +	/* reset controller to reset audio regs before regmap cache */
> +	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
> +
> +	ret = reset_control_reset(rstc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
> +
> +	/* enable clock for regcache get default value from hw */
> +	afe_priv->pm_runtime_bypass_reg_ctl = true;


> +	pm_runtime_enable(dev);

What about....

	ret = devm_pm_runtime_enable(dev);
	if (ret)
		return ret;

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return dev_err_probe(dev, ret, "failed to resume device\n");

> +	ret = pm_runtime_get_sync(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to resume device: %d\n", ret);
> +		goto err_pm_disable;
> +	}
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

This should be dev_dbg().

> +
> +	ret = devm_snd_soc_register_component(dev,
> +					      &mt8186_afe_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret) {
> +		dev_err(dev, "err_dai_component\n");
> +		goto err_pm_disable;
> +	}
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret) {
> +		pm_runtime_get_noresume(dev);
> +		dev_err(dev, "failed to suspend device: %d\n", ret);
> +		goto err_pm_disable;
> +	}
> +	afe_priv->pm_runtime_bypass_reg_ctl = false;
> +
> +	regcache_cache_only(afe->regmap, true);
> +	regcache_mark_dirty(afe->regmap);
> +
> +	return 0;
> +
> +err_pm_disable:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_disable(dev);

...and then, since we're using devm_pm_runtime_enable, this call to
pm_runtime_disable() can be removed.

> +
> +	return ret;
> +}
> +
> +static int mt8186_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);

Here too.


Regards,
Angelo
