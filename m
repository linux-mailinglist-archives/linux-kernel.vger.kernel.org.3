Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567F74CE3E7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 10:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiCEJLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 04:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCEJLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 04:11:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757A2108574;
        Sat,  5 Mar 2022 01:10:29 -0800 (PST)
X-UUID: f60cf775a5cd49218584a9cc0e667467-20220305
X-UUID: f60cf775a5cd49218584a9cc0e667467-20220305
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 104353305; Sat, 05 Mar 2022 17:10:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 5 Mar 2022 17:10:22 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 17:10:21 +0800
Message-ID: <79480f2d8904faa0cfcc731b79a8da57121e4f09.camel@mediatek.com>
Subject: Re: [v2 12/17] ASoC: mediatek: mt8186: add platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <aaronyu@google.com>, <zhangqilong3@huawei.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 5 Mar 2022 17:10:21 +0800
In-Reply-To: <58cc2df8-5503-b38f-2a6d-9bbef809a60f@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-13-jiaxin.yu@mediatek.com>
         <58cc2df8-5503-b38f-2a6d-9bbef809a60f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/02/22 14:42, Jiaxin Yu ha scritto:
> > This patch adds mt8186 platform and affiliated driver.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/Kconfig                    |   44 +
> >   sound/soc/mediatek/Makefile                   |    1 +
> >   sound/soc/mediatek/mt8186/Makefile            |   21 +
> >   sound/soc/mediatek/mt8186/mt8186-afe-common.h |  245 ++
> >   .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
> >   sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3029
> > +++++++++++++++
> >   .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
> >   .../soc/mediatek/mt8186/mt8186-misc-control.c | 1728 +++++++++
> >   sound/soc/mediatek/mt8186/mt8186-reg.h        | 3433
> > +++++++++++++++++
> >   9 files changed, 8831 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/Makefile
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-
> > interconnection.h
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-misc-
> > control.c
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-reg.h
> > 
> > diff --git a/sound/soc/mediatek/Kconfig
> > b/sound/soc/mediatek/Kconfig
> > index 3b1ddea26a9e..d3528bdbb00a 100644
> > --- a/sound/soc/mediatek/Kconfig
> > +++ b/sound/soc/mediatek/Kconfig
> > @@ -152,6 +152,50 @@ config SND_SOC_MT8183_DA7219_MAX98357A
> >   	  Select Y if you have such device.
> >   	  If unsure select "N".
> >   
> > +config SND_SOC_MT8186
> > +	tristate "ASoC support for Mediatek MT8186 chip"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	depends on COMMON_CLK
> > +	select SND_SOC_MEDIATEK
> > +	select MFD_SYSCON if SND_SOC_MT6366
> > +	help
> > +	  This adds ASoC driver for Mediatek MT8186 boards
> > +	  that can be used with other codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> > +
> > +config SND_SOC_MT8186_MT6366_DA7219_MAX98357
> > +	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A
> > codec"
> > +	depends on I2C && GPIOLIB
> > +	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
> > +	select SND_SOC_MT6366
> > +	select SND_SOC_MAX98357A
> > +	select SND_SOC_DA7219
> > +	select SND_SOC_BT_SCO
> > +	select SND_SOC_DMIC
> > +	select SND_SOC_HDMI_CODEC
> > +	help
> > +	  This adds ASoC driver for Mediatek MT8186 boards
> > +	  with the MT6366 DA7219 MAX98357A codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> > +
> > +config SND_SOC_MT8186_MT6366_RT1019_RT5682S
> > +	tristate "ASoC Audio driver for MT8186 with RT1019 RT5682S
> > codec"
> > +	depends on I2C && GPIOLIB
> > +	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
> > +	select SND_SOC_MT6366
> > +	select SND_SOC_RT1015P
> > +	select SND_SOC_RT5682S
> > +	select SND_SOC_BT_SCO
> > +	select SND_SOC_DMIC
> > +	select SND_SOC_HDMI_CODEC
> > +	help
> > +	  This adds ASoC driver for Mediatek MT8186 boards
> > +	  with the MT6366 RT1019 RT5682S codecs.
> > +	  Select Y if you have such device.
> > +	  If unsure select "N".
> > +
> >   config SND_SOC_MTK_BTCVSD
> >   	tristate "ALSA BT SCO CVSD/MSBC Driver"
> >   	help
> > diff --git a/sound/soc/mediatek/Makefile
> > b/sound/soc/mediatek/Makefile
> > index 34778ca12106..5571c640a288 100644
> > --- a/sound/soc/mediatek/Makefile
> > +++ b/sound/soc/mediatek/Makefile
> > @@ -4,5 +4,6 @@ obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
> >   obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
> >   obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
> >   obj-$(CONFIG_SND_SOC_MT8183) += mt8183/
> > +obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
> >   obj-$(CONFIG_SND_SOC_MT8192) += mt8192/
> >   obj-$(CONFIG_SND_SOC_MT8195) += mt8195/
> > diff --git a/sound/soc/mediatek/mt8186/Makefile
> > b/sound/soc/mediatek/mt8186/Makefile
> > new file mode 100644
> > index 000000000000..9f3bead9cdf8
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/Makefile
> > @@ -0,0 +1,21 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# platform driver
> > +snd-soc-mt8186-afe-objs := \
> > +	mt8186-afe-pcm.o \
> > +	mt8186-audsys-clk.o \
> > +	mt8186-afe-clk.o \
> > +	mt8186-afe-gpio.o \
> > +	mt8186-dai-adda.o \
> > +	mt8186-afe-control.o \
> > +	mt8186-dai-i2s.o \
> > +	mt8186-dai-hw-gain.o \
> > +	mt8186-dai-pcm.o \
> > +	mt8186-dai-src.o \
> > +	mt8186-dai-hostless.o \
> > +	mt8186-dai-tdm.o \
> > +	mt8186-misc-control.o
> > +
> > +obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
> > +obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-
> > mt6366-da7219-max98357.o
> > +obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-
> > mt6366-rt1019-rt5682s.o
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-common.h
> > b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
> > new file mode 100644
> > index 000000000000..b2b50faa3887
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
> > @@ -0,0 +1,245 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * mt8186-afe-common.h  --  Mediatek 8186 audio driver definitions
> > + *
> > + * Copyright (c) 2022 MediaTek Inc.
> > + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > + */
> > +
> > +#ifndef _MT_8186_AFE_COMMON_H_
> > +#define _MT_8186_AFE_COMMON_H_
> > +#include <sound/soc.h>
> > +#include <linux/list.h>
> > +#include <linux/regmap.h>
> > +#include "mt8186-reg.h"
> > +#include "../common/mtk-base-afe.h"
> > +
> > +#if IS_ENABLED(CONFIG_MTK_AEE_FEATURE)
> > +#define AUDIO_AEE(message) \
> > +	(aee_kernel_exception_api(__FILE__, \
> > +				  __LINE__, \
> > +				  DB_OPT_FTRACE, message, \
> > +				  "audio assert"))
> > +#else
> > +#define AUDIO_AEE(message) WARN_ON(true)
> > +#endif
> 
> There is no such AEE upstream, please remove this block entirely.
> 
Ok, got it.

> ...snip...
> 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> > b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> > new file mode 100644
> > index 000000000000..cb863716a74b
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
> > @@ -0,0 +1,261 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// MediaTek ALSA SoC Audio Control
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include "mt8186-afe-common.h"
> > +#include <linux/pm_runtime.h>
> > +
> > +enum {
> > +	MTK_AFE_RATE_8K = 0,
> 
> You just need to define the first one as zero and you don't need to
> assign numbers to the others, since they are sequential.
> Please fix.
> 
Ok, got it.

> > +	MTK_AFE_RATE_11K = 1,
> > +	MTK_AFE_RATE_12K = 2,
> > +	MTK_AFE_RATE_384K = 3,
> > +	MTK_AFE_RATE_16K = 4,
> > +	MTK_AFE_RATE_22K = 5,
> > +	MTK_AFE_RATE_24K = 6,
> > +	MTK_AFE_RATE_352K = 7,
> > +	MTK_AFE_RATE_32K = 8,
> > +	MTK_AFE_RATE_44K = 9,
> > +	MTK_AFE_RATE_48K = 10,
> > +	MTK_AFE_RATE_88K = 11,
> > +	MTK_AFE_RATE_96K = 12,
> > +	MTK_AFE_RATE_176K = 13,
> > +	MTK_AFE_RATE_192K = 14,
> > +	MTK_AFE_RATE_260K = 15,
> > +};
> > +
> > +enum {
> > +	MTK_AFE_PCM_RATE_8K = 0,
> > +	MTK_AFE_PCM_RATE_16K = 1,
> > +	MTK_AFE_PCM_RATE_32K = 2,
> > +	MTK_AFE_PCM_RATE_48K = 3,
> 
> same here
> 
> > +};
> > +
> > +enum {
> > +	MTK_AFE_TDM_RATE_8K = 0,
> > +	MTK_AFE_TDM_RATE_12K = 1,
> > +	MTK_AFE_TDM_RATE_16K = 2,
> > +	MTK_AFE_TDM_RATE_24K = 3,
> > +	MTK_AFE_TDM_RATE_32K = 4,
> > +	MTK_AFE_TDM_RATE_48K = 5,
> > +	MTK_AFE_TDM_RATE_64K = 6,
> > +	MTK_AFE_TDM_RATE_96K = 7,
> > +	MTK_AFE_TDM_RATE_128K = 8,
> > +	MTK_AFE_TDM_RATE_192K = 9,
> > +	MTK_AFE_TDM_RATE_256K = 10,
> > +	MTK_AFE_TDM_RATE_384K = 11,
> > +	MTK_AFE_TDM_RATE_11K = 16,
> > +	MTK_AFE_TDM_RATE_22K = 17,
> > +	MTK_AFE_TDM_RATE_44K = 18,
> > +	MTK_AFE_TDM_RATE_88K = 19,
> > +	MTK_AFE_TDM_RATE_176K = 20,
> > +	MTK_AFE_TDM_RATE_352K = 21, > +};
> > +
> > +enum {
> > +	MTK_AFE_TDM_RELATCH_RATE_8K = 0,
> > +	MTK_AFE_TDM_RELATCH_RATE_11K = 1,
> > +	MTK_AFE_TDM_RELATCH_RATE_12K = 2,
> > +	MTK_AFE_TDM_RELATCH_RATE_16K = 4,
> > +	MTK_AFE_TDM_RELATCH_RATE_22K = 5,
> > +	MTK_AFE_TDM_RELATCH_RATE_24K = 6,
> > +	MTK_AFE_TDM_RELATCH_RATE_32K = 8,
> > +	MTK_AFE_TDM_RELATCH_RATE_44K = 9,
> > +	MTK_AFE_TDM_RELATCH_RATE_48K = 10,
> > +	MTK_AFE_TDM_RELATCH_RATE_88K = 13,
> > +	MTK_AFE_TDM_RELATCH_RATE_96K = 14,
> > +	MTK_AFE_TDM_RELATCH_RATE_176K = 17,
> > +	MTK_AFE_TDM_RELATCH_RATE_192K = 18,
> > +	MTK_AFE_TDM_RELATCH_RATE_352K = 21,
> > +	MTK_AFE_TDM_RELATCH_RATE_384K = 22,
> > +};
> > +
> > +unsigned int mt8186_general_rate_transform(struct device *dev,
> > +					   unsigned int rate)
> > +{
> > +	switch (rate) {
> > +	case 8000:
> > +		return MTK_AFE_RATE_8K;
> > +	case 11025:
> > +		return MTK_AFE_RATE_11K;
> > +	case 12000:
> > +		return MTK_AFE_RATE_12K;
> > +	case 16000:
> > +		return MTK_AFE_RATE_16K;
> > +	case 22050:
> > +		return MTK_AFE_RATE_22K;
> > +	case 24000:
> > +		return MTK_AFE_RATE_24K;
> > +	case 32000:
> > +		return MTK_AFE_RATE_32K;
> > +	case 44100:
> > +		return MTK_AFE_RATE_44K;
> > +	case 48000:
> > +		return MTK_AFE_RATE_48K;
> > +	case 88200:
> > +		return MTK_AFE_RATE_88K;
> > +	case 96000:
> > +		return MTK_AFE_RATE_96K;
> > +	case 176400:
> > +		return MTK_AFE_RATE_176K;
> > +	case 192000:
> > +		return MTK_AFE_RATE_192K;
> > +	case 260000:
> > +		return MTK_AFE_RATE_260K;
> > +	case 352800:
> > +		return MTK_AFE_RATE_352K;
> > +	case 384000:
> > +		return MTK_AFE_RATE_384K;
> > +	default:
> > +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> > +			 __func__,
> > +			 rate, MTK_AFE_RATE_48K);
> 
> dev_err(); ... and don't return here, but...
> 
> > +		return MTK_AFE_RATE_48K;
> > +	}
> 
> 
> ... return here, outside of the switch.
> 
> > +}
> > +
> > +static unsigned int tdm_rate_transform(struct device *dev,
> > +				       unsigned int rate)
> > +{
> > +	switch (rate) {
> > +	case 8000:
> > +		return MTK_AFE_TDM_RATE_8K;
> > +	case 11025:
> > +		return MTK_AFE_TDM_RATE_11K;
> > +	case 12000:
> > +		return MTK_AFE_TDM_RATE_12K;
> > +	case 16000:
> > +		return MTK_AFE_TDM_RATE_16K;
> > +	case 22050:
> > +		return MTK_AFE_TDM_RATE_22K;
> > +	case 24000:
> > +		return MTK_AFE_TDM_RATE_24K;
> > +	case 32000:
> > +		return MTK_AFE_TDM_RATE_32K;
> > +	case 44100:
> > +		return MTK_AFE_TDM_RATE_44K;
> > +	case 48000:
> > +		return MTK_AFE_TDM_RATE_48K;
> > +	case 64000:
> > +		return MTK_AFE_TDM_RATE_64K;
> > +	case 88200:
> > +		return MTK_AFE_TDM_RATE_88K;
> > +	case 96000:
> > +		return MTK_AFE_TDM_RATE_96K;
> > +	case 128000:
> > +		return MTK_AFE_TDM_RATE_128K;
> > +	case 176400:
> > +		return MTK_AFE_TDM_RATE_176K;
> > +	case 192000:
> > +		return MTK_AFE_TDM_RATE_192K;
> > +	case 256000:
> > +		return MTK_AFE_TDM_RATE_256K;
> > +	case 352800:
> > +		return MTK_AFE_TDM_RATE_352K;
> > +	case 384000:
> > +		return MTK_AFE_TDM_RATE_384K;
> > +	default:
> > +		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
> > +			 __func__,
> > +			 rate, MTK_AFE_TDM_RATE_48K);
> > +		return MTK_AFE_TDM_RATE_48K;
> 
> ditto.
> here and for all the other instances.
> 
> > +	}
> > +}
> > +
> 
> ...snip...
> 
> > +}
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> > b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> > new file mode 100644
> > index 000000000000..e1e17a934245
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> > @@ -0,0 +1,3029 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Mediatek ALSA SoC AFE platform driver for 8186
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <sound/soc.h>
> > +
> > +#include "../common/mtk-afe-platform-driver.h"
> > +#include "../common/mtk-afe-fe-dai.h"
> > +
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-clk.h"
> > +#include "mt8186-afe-gpio.h"
> > +#include "mt8186-interconnection.h"
> > +
> > +static const struct snd_pcm_hardware mt8186_afe_hardware = {
> > +	.info = (SNDRV_PCM_INFO_MMAP |
> > +		 SNDRV_PCM_INFO_INTERLEAVED |
> > +		 SNDRV_PCM_INFO_MMAP_VALID),
> > +	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
> > +		    SNDRV_PCM_FMTBIT_S24_LE |
> > +		    SNDRV_PCM_FMTBIT_S32_LE),
> > +	.period_bytes_min = 96,
> > +	.period_bytes_max = 4 * 48 * 1024,
> > +	.periods_min = 2,
> > +	.periods_max = 256,
> > +	.buffer_bytes_max = 4 * 48 * 1024,
> > +	.fifo_size = 0,
> > +};
> > +
> > +static int mt8186_fe_startup(struct snd_pcm_substream *substream,
> > +			     struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> > +	const struct snd_pcm_hardware *mtk_afe_hardware = afe-
> > >mtk_afe_hardware;
> > +	int ret;
> > +
> > +	memif->substream = substream;
> > +
> > +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> > +				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
> > 16);
> > +
> > +	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
> > +
> > +	ret = snd_pcm_hw_constraint_integer(runtime,
> > +					    SNDRV_PCM_HW_PARAM_PERIODS)
> > ;
> > +	if (ret < 0)
> > +		dev_info(afe->dev, "snd_pcm_hw_constraint_integer
> > failed\n");
> 
> 	if (ret < 0) {
> 		dev_err .....
> 		return ret;
> 	}
> 
> > +
> > +	/* dynamic allocate irq to memif */
> > +	if (memif->irq_usage < 0) {
> > +		int irq_id = mtk_dynamic_irq_acquire(afe);
> > +
> > +		if (irq_id != afe->irqs_size) {
> > +			/* link */
> > +			memif->irq_usage = irq_id;
> > +		} else {
> > +			dev_info(afe->dev, "%s() error: no more asys
> > irq\n",
> > +				 __func__);
> > +			ret = -EBUSY;
> 
> 			return -EBUSY;
> > +		}
> > +	}
> > +
> 
> 	return 0;
> 
> > +	return ret;
> > +}
> > +
> > +static void mt8186_fe_shutdown(struct snd_pcm_substream
> > *substream,
> > +			       struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> > +	int irq_id = memif->irq_usage;
> > +
> > +	memif->substream = NULL;
> > +	afe_priv->irq_cnt[id] = 0;
> > +	afe_priv->xrun_assert[id] = 0;
> > +
> > +	if (!memif->const_irq) {
> > +		mtk_dynamic_irq_release(afe, irq_id);
> > +		memif->irq_usage = -1;
> > +		memif->substream = NULL;
> > +	}
> > +}
> > +
> > +static int mt8186_fe_hw_params(struct snd_pcm_substream
> > *substream,
> > +			       struct snd_pcm_hw_params *params,
> > +			       struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +	unsigned int channels = params_channels(params);
> > +	unsigned int rate = params_rate(params);
> > +	int ret;
> > +
> > +	ret = mtk_afe_fe_hw_params(substream, params, dai);
> > +	if (ret)
> 
> 		return ret;
> > +		goto exit;
> > +
> > +	/* channel merge configuration, enable control is in UL5_IN_MUX
> > */
> > +	if (id == MT8186_MEMIF_VUL3) {
> > +		int update_cnt = 8;
> > +		unsigned int val = 0;
> > +		unsigned int mask = 0;
> > +		int fs_mode = mt8186_rate_transform(afe->dev, rate,
> > id);
> > +
> > +		/* set rate, channel, update cnt, disable sgen */
> > +		val = fs_mode << CM1_FS_SELECT_SFT |
> > +			(channels - 1) << CHANNEL_MERGE0_CHNUM_SFT |
> > +			update_cnt << CHANNEL_MERGE0_UPDATE_CNT_SFT |
> > +			0 << CHANNEL_MERGE0_DEBUG_MODE_SFT |
> > +			0 << CM1_DEBUG_MODE_SEL_SFT;
> 
> 0 << number == 0!!!
> 
> > +		mask = CM1_FS_SELECT_MASK_SFT |
> > +			CHANNEL_MERGE0_CHNUM_MASK_SFT |
> > +			CHANNEL_MERGE0_UPDATE_CNT_MASK_SFT |
> > +			CHANNEL_MERGE0_DEBUG_MODE_MASK_SFT |
> > +			CM1_DEBUG_MODE_SEL_MASK_SFT;
> > +		regmap_update_bits(afe->regmap, AFE_CM1_CON, mask,
> > val);
> > +	}
> > +
> 
> 	return 0;
> 
> ... and remove the label, as it's not needed
> > +exit:
> > +	return ret;
> > +}
> > +
> > +static int mt8186_fe_hw_free(struct snd_pcm_substream *substream,
> > +			     struct snd_soc_dai *dai)
> > +{
> > +	int ret;
> > +
> > +	ret = mtk_afe_fe_hw_free(substream, dai);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	/* wait for some platform related operation */
> > +exit:
> > +	return ret;
> > +}
> > +
> > +static int mt8186_fe_trigger(struct snd_pcm_substream *substream,
> > int cmd,
> > +			     struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_pcm_runtime * const runtime = substream->runtime;
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> > +	int irq_id = memif->irq_usage;
> > +	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> > +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> > +	unsigned int counter = runtime->period_size;
> > +	unsigned int rate = runtime->rate;
> > +	int fs;
> > +	int ret;
> > +
> > +	dev_info(afe->dev, "%s(), %s cmd %d, irq_id %d\n",
> > +		 __func__, memif->data->name, cmd, irq_id);
> 
> 
> dev_dbg()
> 
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +		ret = mtk_memif_set_enable(afe, id);
> 
> 		if (ret) {
> 			dev_err ........
> 			return ret;
> 		}
> 
> 		/*
> 		 * for small latency record
> 		 * ul memif need read some data before irq enable
> 		 */
> 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
> 		    ((runtime->period_size * 1000) / rate) <= 10)
> 				usleep_range(300, 310);
> 
> 
> > +		/*
> > +		 * for small latency record
> > +		 * ul memif need read some data before irq enable
> > +		 */
> > +		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> > +			if ((runtime->period_size * 1000) / rate <= 10)
> > +				usleep_range(300, 310);
> > +		}
> > +
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s(), error, id %d, memif
> > enable, ret %d\n",
> > +				 __func__, id, ret);
> > +			return ret;
> > +		}
> > +
> > +		/* set irq counter */
> > +		if (afe_priv->irq_cnt[id] > 0)
> > +			counter = afe_priv->irq_cnt[id];
> > +
> > +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> > +				   irq_data->irq_cnt_maskbit
> > +				   << irq_data->irq_cnt_shift,
> > +				   counter << irq_data->irq_cnt_shift);
> > +
> > +		/* set irq fs */
> > +		fs = afe->irq_fs(substream, runtime->rate);
> > +
> 
> empty line: remove.
> 
> > +		if (fs < 0)
> > +			return -EINVAL;
> > +
> > +		regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
> > +				   irq_data->irq_fs_maskbit
> > +				   << irq_data->irq_fs_shift,
> > +				   fs << irq_data->irq_fs_shift);
> > +
> > +		/* enable interrupt */
> > +		if (runtime->stop_threshold != ~(0U))
> > +			regmap_update_bits(afe->regmap,
> > +					   irq_data->irq_en_reg,
> > +					   1 << irq_data->irq_en_shift,
> > +					   1 << irq_data-
> > >irq_en_shift);
> > +		return 0;
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +	case SNDRV_PCM_TRIGGER_SUSPEND:
> > +		if (afe_priv->xrun_assert[id] > 0) {
> > +			if (substream->stream ==
> > SNDRV_PCM_STREAM_CAPTURE) {
> > +				int avail =
> > snd_pcm_capture_avail(runtime);
> > +
> > +				if (avail >= runtime->buffer_size) {
> > +					dev_info(afe->dev, "%s(), id
> > %d, xrun assert\n",
> > +						 __func__, id);
> > +				}
> > +			}
> > +		}
> > +
> > +		ret = mtk_memif_set_disable(afe, id);
> > +		if (ret) {
> > +			dev_info(afe->dev, "%s(), error, id %d, memif
> > enable, ret %d\n",
> > +				 __func__, id, ret);
> 
> dev_err()
> 
> > +		}
> > +
> > +		/* disable interrupt */
> > +		if (runtime->stop_threshold != ~(0U))
> > +			regmap_update_bits(afe->regmap,
> > +					   irq_data->irq_en_reg,
> > +					   1 << irq_data->irq_en_shift,
> > +					   0 << irq_data-
> > >irq_en_shift);
> > +
> > +		/* clear pending IRQ */
> > +		regmap_write(afe->regmap, irq_data->irq_clr_reg,
> > +			     1 << irq_data->irq_clr_shift);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mt8186_memif_fs(struct snd_pcm_substream *substream,
> > +			   unsigned int rate)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_component *component =
> > +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(component);
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +
> > +	return mt8186_rate_transform(afe->dev, rate, id);
> > +}
> > +
> > +static int mt8186_get_dai_fs(struct mtk_base_afe *afe,
> > +			     int dai_id, unsigned int rate)
> > +{
> > +	return mt8186_rate_transform(afe->dev, rate, dai_id);
> > +}
> > +
> > +static int mt8186_irq_fs(struct snd_pcm_substream *substream,
> > unsigned int rate)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_component *component =
> > +		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(component);
> > +
> > +	return mt8186_general_rate_transform(afe->dev, rate);
> > +}
> > +
> > +static int mt8186_get_memif_pbuf_size(struct snd_pcm_substream
> > *substream)
> > +{
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +
> > +	if ((runtime->period_size * 1000) / runtime->rate > 10)
> > +		return MT8186_MEMIF_PBUF_SIZE_256_BYTES;
> > +	else
> 
> drop "else"... and just return MT8186_MEMIF_PBUF_SIZE_32_BYTES
> 
> > +		return MT8186_MEMIF_PBUF_SIZE_32_BYTES;
> > +}
> > +
> > +static int mt8186_fe_prepare(struct snd_pcm_substream *substream,
> > +			     struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_pcm_runtime * const runtime = substream->runtime;
> > +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> > +	int id = asoc_rtd_to_cpu(rtd, 0)->id;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[id];
> > +	int irq_id = memif->irq_usage;
> > +	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> > +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> > +	unsigned int counter = runtime->period_size;
> > +	int fs;
> > +	int ret;
> > +
> > +	ret = mtk_afe_fe_prepare(substream, dai);
> > +	if (ret)
> 
> 		return ret;
> 
> > +		goto exit;
> > +
> > +	/* set irq counter */
> > +	regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> > +			   irq_data->irq_cnt_maskbit
> > +			   << irq_data->irq_cnt_shift,
> > +			   counter << irq_data->irq_cnt_shift);
> > +
> > +	/* set irq fs */
> > +	fs = afe->irq_fs(substream, runtime->rate);
> > +
> > +	if (fs < 0)
> > +		return -EINVAL;
> > +
> > +	regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
> > +			   irq_data->irq_fs_maskbit
> > +			   << irq_data->irq_fs_shift,
> > +			   fs << irq_data->irq_fs_shift);
> > +exit:
> 
> unneeded label, and return 0;
> 
> > +	return ret;
> > +}
> > +
> 
> ..snip..
> 
> > +static int mt8186_irq_cnt1_set(struct snd_kcontrol *kcontrol,
> > +			       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int memif_num = MT8186_PRIMARY_MEMIF;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
> > +	int irq_id = memif->irq_usage;
> > +	int irq_cnt = afe_priv->irq_cnt[memif_num];
> > +
> > +	dev_info(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value =
> > %ld\n",
> > +		 __func__,
> > +		 irq_id, irq_cnt,
> > +		 ucontrol->value.integer.value[0]);
> 
> dev_dbg() - and fits in less lines.
> 
> > +
> > +	if (irq_cnt == ucontrol->value.integer.value[0])
> > +		return 0;
> > +
> > +	irq_cnt = ucontrol->value.integer.value[0];
> > +	afe_priv->irq_cnt[memif_num] = irq_cnt;
> > +
> > +	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
> > +		dev_info(afe->dev, "%s(), suspended || irq_id %d, not
> > set\n",
> > +			 __func__, irq_id);
> > +	} else {
> > +		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> > +		const struct mtk_base_irq_data *irq_data = irqs-
> > >irq_data;
> > +
> > +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> > +				   irq_data->irq_cnt_maskbit
> > +				   << irq_data->irq_cnt_shift,
> > +				   irq_cnt << irq_data->irq_cnt_shift);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_irq_cnt2_get(struct snd_kcontrol *kcontrol,
> > +			       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	ucontrol->value.integer.value[0] =
> > +		afe_priv->irq_cnt[MT8186_RECORD_MEMIF];
> > +	return 0;
> > +}
> > +
> > +static int mt8186_irq_cnt2_set(struct snd_kcontrol *kcontrol,
> > +			       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int memif_num = MT8186_RECORD_MEMIF;
> > +	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
> > +	int irq_id = memif->irq_usage;
> > +	int irq_cnt = afe_priv->irq_cnt[memif_num];
> > +
> > +	dev_info(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value =
> > %ld\n",
> > +		 __func__,
> > +		 irq_id, irq_cnt,
> > +		 ucontrol->value.integer.value[0]);
> 
> dev_dbg() - and fits in less lines.
> 
> > +
> > +	if (irq_cnt == ucontrol->value.integer.value[0])
> > +		return 0;
> > +
> > +	irq_cnt = ucontrol->value.integer.value[0];
> > +	afe_priv->irq_cnt[memif_num] = irq_cnt;
> > +
> > +	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
> > +		dev_info(afe->dev, "%s(), suspended || irq_id %d, not
> > set\n",
> > +			 __func__, irq_id);
> > +	} else {
> > +		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
> > +		const struct mtk_base_irq_data *irq_data = irqs-
> > >irq_data;
> > +
> > +		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
> > +				   irq_data->irq_cnt_maskbit
> > +				   << irq_data->irq_cnt_shift,
> > +				   irq_cnt << irq_data->irq_cnt_shift);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> 
> 
> > +
> > +static irqreturn_t mt8186_afe_irq_handler(int irq_id, void *dev)
> > +{
> > +	struct mtk_base_afe *afe = dev;
> > +	struct mtk_base_afe_irq *irq;
> > +	unsigned int status;
> > +	unsigned int status_mcu;
> > +	unsigned int mcu_en;
> > +	int ret;
> > +	int i;
> > +
> > +	/* get irq that is sent to MCU */
> > +	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
> 
> ret = regmap_read ....
> if (ret) ....
> 
> > +
> > +	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
> > +	/* only care IRQ which is sent to MCU */
> > +	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
> > +
> > +	if (ret || status_mcu == 0) {
> > +		dev_info(afe->dev, "%s(), irq status err, ret %d,
> > status 0x%x, mcu_en 0x%x\n",
> > +			 __func__, ret, status, mcu_en);
> 
> dev_err()
> 
> > +
> > +		goto err_irq;
> > +	}
> > +
> > +	for (i = 0; i < MT8186_MEMIF_NUM; i++) {
> > +		struct mtk_base_afe_memif *memif = &afe->memif[i];
> > +
> > +		if (!memif->substream)
> > +			continue;
> > +
> > +		if (memif->irq_usage < 0)
> > +			continue;
> > +
> > +		irq = &afe->irqs[memif->irq_usage];
> > +
> > +		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
> > +			snd_pcm_period_elapsed(memif->substream);
> > +	}
> > +
> > +err_irq:
> > +	/* clear irq */
> > +	regmap_write(afe->regmap,
> > +		     AFE_IRQ_MCU_CLR,
> > +		     status_mcu);
> 
> fits in a single line.
> 
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mt8186_afe_runtime_suspend(struct device *dev)
> > +{
> > +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	unsigned int value = 0;
> > +	int ret;
> > +
> > +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> > +		goto skip_regmap;
> > +
> > +	/* disable AFE */
> > +	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x0);
> > +
> > +	ret = regmap_read_poll_timeout(afe->regmap,
> > +				       AFE_DAC_MON,
> > +				       value,
> > +				       (value & AFE_ON_RETM_MASK_SFT)
> > == 0,
> > +				       20,
> > +				       1 * 1000 * 1000);
> > +	if (ret)
> > +		dev_info(afe->dev, "%s(), ret %d\n", __func__, ret);
> 
> dev_err()!!
> P.S.: Are you sure that we shouldn't return here?

No, this should return error, I will correct here.

> 
> > +
> > +	/* make sure all irq status are cleared */
> > +	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
> > +	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
> > +
> > +	/* reset sgen */
> > +	regmap_write(afe->regmap, AFE_SINEGEN_CON0, 0x0);
> > +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> > +			   INNER_LOOP_BACK_MODE_MASK_SFT,
> > +			   0x3f << INNER_LOOP_BACK_MODE_SFT);
> > +
> > +	/* cache only */
> > +	regcache_cache_only(afe->regmap, true);
> > +	regcache_mark_dirty(afe->regmap);
> > +
> > +skip_regmap:
> > +	mt8186_afe_disable_cgs(afe);
> > +	mt8186_afe_disable_clock(afe);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_afe_runtime_resume(struct device *dev)
> > +{
> > +	struct mtk_base_afe *afe = dev_get_drvdata(dev);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	int ret;
> > +
> > +	ret = mt8186_afe_enable_clock(afe);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mt8186_afe_enable_cgs(afe);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> > +		goto skip_regmap;
> > +
> > +	regcache_cache_only(afe->regmap, false);
> > +	regcache_sync(afe->regmap);
> > +
> > +	/* enable audio sys DCM for power saving */
> > +	regmap_update_bits(afe_priv->infracfg,
> > +			   PERI_BUS_DCM_CTRL, 0x1 << 29, 0x1 << 29);
> 
> BIT(29)
> 
> > +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0, 0x1 << 29, 0x1
> > << 29);
> > +
> > +	/* force cpu use 8_24 format when writing 32bit data */
> > +	regmap_update_bits(afe->regmap, AFE_MEMIF_CON0,
> > +			   CPU_HD_ALIGN_MASK_SFT, 0 <<
> > CPU_HD_ALIGN_SFT);
> 
> 0 << number == 0, so write 0
> 
> > +
> > +	/* set all output port to 24bit */
> > +	regmap_write(afe->regmap, AFE_CONN_24BIT, 0xffffffff);
> > +	regmap_write(afe->regmap, AFE_CONN_24BIT_1, 0xffffffff);
> > +
> > +	/* enable AFE */
> > +	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
> > +
> > +skip_regmap:
> > +	return 0;
> > +}
> 
> ..snip..
> 
> > +static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
> > +{
> > +	struct mtk_base_afe *afe;
> > +	struct mt8186_afe_private *afe_priv;
> > +	struct resource *res;
> > +	struct reset_control *rstc;
> > +	struct device *dev = &pdev->dev;
> > +	int i, ret, irq_id;
> > +
> > +	dev_info(dev, "%s(), ++\n", __func__);
> 
> Drop this print.
> 
> > +
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
> > +	if (ret)
> > +		return ret;
> > +
> > +	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
> > +	if (!afe)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, afe);
> > +
> > +	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv),
> > GFP_KERNEL);
> > +	if (!afe->platform_priv)
> > +		return -ENOMEM;
> > +
> > +	afe_priv = afe->platform_priv;
> > +	afe->dev = &pdev->dev;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(afe->base_addr))
> > +		return PTR_ERR(afe->base_addr);
> > +
> > +	dev_info(dev, "%s(), mt8186_init_clock\n", __func__);
> 
> Drop this print.
> 
> > +	/* init audio related clock */
> > +	ret = mt8186_init_clock(afe);
> > +	if (ret) {
> > +		dev_info(dev, "init clock error\n");
> 
> dev_err()
> 
> > +		return ret;
> > +	}
> > +
> > +	/* init memif */
> > +	afe->memif_32bit_supported = 0;
> > +	afe->memif_size = MT8186_MEMIF_NUM;
> > +	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe-
> > >memif),
> > +				  GFP_KERNEL);
> > +
> > +	if (!afe->memif)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < afe->memif_size; i++) {
> > +		afe->memif[i].data = &memif_data[i];
> > +		afe->memif[i].irq_usage = memif_irq_usage[i];
> > +		afe->memif[i].const_irq = 1;
> > +	}
> > +
> > +	mutex_init(&afe->irq_alloc_lock);	/* needed when dynamic irq
> > */
> > +
> > +	dev_info(dev, "%s(), init irq\n", __func__);
> 
> Drop this print.
> 
> > +
> > +	/* init irq */
> > +	afe->irqs_size = MT8186_IRQ_NUM;
> > +	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe-
> > >irqs),
> > +				 GFP_KERNEL);
> > +
> > +	if (!afe->irqs)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < afe->irqs_size; i++)
> > +		afe->irqs[i].irq_data = &irq_data[i];
> > +
> > +	dev_info(dev, "%s(), devm_request_irq\n", __func__);
> 
> Drop.
> 
> > +
> > +	/* request irq */
> > +	irq_id = platform_get_irq(pdev, 0);
> > +	if (irq_id <= 0) {
> > +		dev_info(dev, "%pOFn no irq found\n", dev->of_node);
> 
> 		return dev_err_probe(dev, irq_id < 0 ? irq_id : -ENXIO,
> 				     "no irq found");
> 
> > +		return irq_id < 0 ? irq_id : -ENXIO;
> > +	}
> > +	ret = devm_request_irq(dev, irq_id, mt8186_afe_irq_handler,
> > +			       IRQF_TRIGGER_NONE,
> > +			       "Afe_ISR_Handle", (void *)afe);
> > +	if (ret) {
> > +		dev_info(dev, "could not request_irq for
> > Afe_ISR_Handle\n");
> 
> return dev_err_probe(dev, ret, "could not request Afe_ISR_Handle
> irq\n");
> 
> > +		return ret;
> > +	}
> > +
> > +	ret = enable_irq_wake(irq_id);
> > +	if (ret < 0)
> > +		dev_info(dev, "enable_irq_wake %d err: %d\n", irq_id,
> > ret);
> 
> Isn't this a critical error?
> 		return dev_err_probe(.......
Yes it is, I will correct here that return dev_err_probe(...).

> 
> > +
> > +	/* init sub_dais */
> > +	INIT_LIST_HEAD(&afe->sub_dais);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
> > +		ret = dai_register_cbs[i](afe);
> > +		if (ret) {
> > +			dev_info(dev, "dai register i %d fail, ret
> > %d\n",
> > +				 i, ret);
> > +			return ret;
> 
> return dev_err_probe()
> 
> > +		}
> > +	}
> > +
> > +	dev_info(dev, "%s(), mtk_afe_combine_sub_dai\n", __func__);
> 
> drop this.
> 
> > +
> > +	/* init dai_driver and component_driver */
> > +	ret = mtk_afe_combine_sub_dai(afe);
> > +	if (ret) {
> > +		dev_info(dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
> > +			 ret);
> > +		return ret;
> 
> return dev_err_probe()
> 
> > +	}
> > +
> > +	/* reset controller to reset audio regs before regmap cache */
> > +	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
> > +	if (IS_ERR(rstc)) {
> > +		ret = PTR_ERR(rstc);
> > +		dev_info(dev, "could not get audiosys reset:%d\n",
> > ret);
> > +		return ret;
> 
> return dev_err_probe(dev, PTR_ERR(rstc), "Could not get audiosys
> reset\n");
> 
> > +	}
> > +
> > +	ret = reset_control_reset(rstc);
> > +	if (ret) {
> > +		dev_info(dev, "failed to trigger audio reset:%d\n",
> > ret);
> > +		return ret;
> 
> dev_err_probe()
> 
> > +	}
> > +
> > +	/* enable clock for regcache get default value from hw */
> > +	afe_priv->pm_runtime_bypass_reg_ctl = true;
> > +	pm_runtime_enable(dev);
> > +	ret = pm_runtime_get_sync(dev);
> > +	if (ret)
> > +		dev_info(dev, "get_ret:%d, rpm_error:%d\n",
> > +			 ret, dev->power.runtime_error);
> 
> You should also return the error here.
> 
> > +
> > +	afe->regmap = devm_regmap_init_mmio(dev, afe->base_addr,
> > +					    &mt8186_afe_regmap_config);
> > +	if (IS_ERR(afe->regmap)) {
> > +		ret = PTR_ERR(afe->regmap);
> > +		goto err_pm_disable;
> > +	}
> > +
> > +	/* others */
> > +	afe->mtk_afe_hardware = &mt8186_afe_hardware;
> > +	afe->memif_fs = mt8186_memif_fs;
> > +	afe->irq_fs = mt8186_irq_fs;
> > +	afe->get_dai_fs = mt8186_get_dai_fs;
> > +	afe->get_memif_pbuf_size = mt8186_get_memif_pbuf_size;
> > +
> > +	afe->runtime_resume = mt8186_afe_runtime_resume;
> > +	afe->runtime_suspend = mt8186_afe_runtime_suspend;
> > +
> > +	/* register platform */
> > +	dev_info(dev, "%s(), devm_snd_soc_register_component\n",
> > __func__);
> > +
> > +	ret = devm_snd_soc_register_component(dev,
> > +					      &mt8186_afe_component,
> > +					      afe->dai_drivers,
> > +					      afe->num_dai_drivers);
> > +	if (ret) {
> > +		dev_info(dev, "err_dai_component\n");
> 
> dev_err()
> 
> > +		goto err_pm_disable;
> > +	}
> > +
> > +	ret = pm_runtime_put_sync(dev);
> > +	if (ret)
> > +		dev_info(dev, "put_ret:%d, rpm_error:%d\n",
> > +			 ret, dev->power.runtime_error);
> 
> dev_err()
> 
> > +	afe_priv->pm_runtime_bypass_reg_ctl = false;
> > +
> > +	regcache_cache_only(afe->regmap, true);
> > +	regcache_mark_dirty(afe->regmap);
> > +
> > +	dev_info(dev, "%s(), --\n", __func__);
> > +
> > +	return 0;
> > +
> > +err_pm_disable:
> > +	pm_runtime_put_sync(dev);
> > +	pm_runtime_disable(dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mt8186_afe_pcm_dev_remove(struct platform_device *pdev)
> > +{
> > +	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
> > +
> > +	pm_runtime_disable(&pdev->dev);
> > +	if (!pm_runtime_status_suspended(&pdev->dev))
> > +		mt8186_afe_runtime_suspend(&pdev->dev);
> > +
> > +	mt8186_deinit_clock(afe);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mt8186_afe_pcm_dt_match[] = {
> > +	{ .compatible = "mediatek,mt8186-sound", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt8186_afe_pcm_dt_match);
> > +
> > +static const struct dev_pm_ops mt8186_afe_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(mt8186_afe_runtime_suspend,
> > +			   mt8186_afe_runtime_resume, NULL)
> > +};
> > +
> > +static struct platform_driver mt8186_afe_pcm_driver = {
> > +	.driver = {
> > +		   .name = "mt8186-audio",
> > +		   .of_match_table = mt8186_afe_pcm_dt_match,
> > +		   .pm = &mt8186_afe_pm_ops,
> > +	},
> > +	.probe = mt8186_afe_pcm_dev_probe,
> > +	.remove = mt8186_afe_pcm_dev_remove,
> > +};
> > +
> > +module_platform_driver(mt8186_afe_pcm_driver);
> > +
> > +MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver for
> > 8186");
> > +MODULE_AUTHOR("Jiaxin Yu <jiaxin.yu@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-interconnection.h
> > b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
> > new file mode 100644
> > index 000000000000..5b188d93ebd3
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Mediatek MT8186 audio driver interconnection definition
> > + *
> > + * Copyright (c) 2022 MediaTek Inc.
> > + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > + */
> > +
> > +#ifndef _MT8186_INTERCONNECTION_H_
> > +#define _MT8186_INTERCONNECTION_H_
> > +
> > +/* in port define */
> > +#define I_I2S0_CH1 0
> > +#define I_I2S0_CH2 1
> > +#define I_ADDA_UL_CH1 3
> > +#define I_ADDA_UL_CH2 4
> > +#define I_DL1_CH1 5
> > +#define I_DL1_CH2 6
> > +#define I_DL2_CH1 7
> > +#define I_DL2_CH2 8
> > +#define I_PCM_1_CAP_CH1 9
> > +#define I_GAIN1_OUT_CH1 10
> > +#define I_GAIN1_OUT_CH2 11
> > +#define I_GAIN2_OUT_CH1 12
> > +#define I_GAIN2_OUT_CH2 13
> > +#define I_PCM_2_CAP_CH1 14
> > +#define I_ADDA_UL_CH3 17
> > +#define I_ADDA_UL_CH4 18
> > +#define I_DL12_CH1 19
> > +#define I_DL12_CH2 20
> > +#define I_DL12_CH3 5
> > +#define I_DL12_CH4 6
> > +#define I_PCM_2_CAP_CH2 21
> > +#define I_PCM_1_CAP_CH2 22
> > +#define I_DL3_CH1 23
> > +#define I_DL3_CH2 24
> > +#define I_I2S2_CH1 25
> > +#define I_I2S2_CH2 26
> > +#define I_I2S2_CH3 27
> > +#define I_I2S2_CH4 28
> > +
> > +/* in port define >= 32 */
> > +#define I_32_OFFSET 32
> > +#define I_CONNSYS_I2S_CH1 (34 - I_32_OFFSET)
> > +#define I_CONNSYS_I2S_CH2 (35 - I_32_OFFSET)
> > +#define I_SRC_1_OUT_CH1 (36 - I_32_OFFSET)
> > +#define I_SRC_1_OUT_CH2 (37 - I_32_OFFSET)
> > +#define I_SRC_2_OUT_CH1 (38 - I_32_OFFSET)
> > +#define I_SRC_2_OUT_CH2 (39 - I_32_OFFSET)
> > +#define I_DL4_CH1 (40 - I_32_OFFSET)
> > +#define I_DL4_CH2 (41 - I_32_OFFSET)
> > +#define I_DL5_CH1 (42 - I_32_OFFSET)
> > +#define I_DL5_CH2 (43 - I_32_OFFSET)
> > +#define I_DL6_CH1 (44 - I_32_OFFSET)
> > +#define I_DL6_CH2 (45 - I_32_OFFSET)
> > +#define I_DL7_CH1 (46 - I_32_OFFSET)
> > +#define I_DL7_CH2 (47 - I_32_OFFSET)
> > +#define I_DL8_CH1 (48 - I_32_OFFSET)
> > +#define I_DL8_CH2 (49 - I_32_OFFSET)
> > +#define I_TDM_IN_CH1 (56 - I_32_OFFSET)
> > +#define I_TDM_IN_CH2 (57 - I_32_OFFSET)
> > +#define I_TDM_IN_CH3 (58 - I_32_OFFSET)
> > +#define I_TDM_IN_CH4 (59 - I_32_OFFSET)
> > +#define I_TDM_IN_CH5 (60 - I_32_OFFSET)
> > +#define I_TDM_IN_CH6 (61 - I_32_OFFSET)
> > +#define I_TDM_IN_CH7 (62 - I_32_OFFSET)
> > +#define I_TDM_IN_CH8 (63 - I_32_OFFSET)
> > +
> > +#endif
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-misc-control.c
> > b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
> > new file mode 100644
> > index 000000000000..c097248b37b6
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
> > @@ -0,0 +1,1728 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// MediaTek ALSA SoC Audio Misc Control
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/io.h>
> > +#include <linux/regmap.h>
> > +#include <sound/soc.h>
> > +
> > +#include "../common/mtk-afe-fe-dai.h"
> > +#include "../common/mtk-afe-platform-driver.h"
> > +#include "mt8186-afe-common.h"
> > +
> > +#define SGEN_MUTE_CH1_KCONTROL_NAME "Audio_SineGen_Mute_Ch1"
> > +#define SGEN_MUTE_CH2_KCONTROL_NAME "Audio_SineGen_Mute_Ch2"
> > +
> > +static const char * const mt8186_sgen_mode_str[] = {
> > +	"I0I1",   "I2",     "I3I4",   "I5I6",
> > +	"I7I8",   "I9I22",  "I10I11", "I12I13",
> > +	"I14I21", "I15I16", "I17I18", "I19I20",
> > +	"I23I24", "I25I26", "I27I28", "I33",
> > +	"I34I35", "I36I37", "I38I39", "I40I41",
> > +	"I42I43", "I44I45", "I46I47", "I48I49",
> > +	"I56I57", "I58I59", "I60I61", "I62I63",
> > +	"O0O1",   "O2",     "O3O4",   "O5O6",
> > +	"O7O8",   "O9O10",  "O11",    "O12",
> > +	"O13O14", "O15O16", "O17O18", "O19O20",
> > +	"O21O22", "O23O24", "O25",    "O28O29",
> > +	"O34",    "O35",    "O32O33", "O36O37",
> > +	"O38O39", "O30O31", "O40O41", "O42O43",
> > +	"O44O45", "O46O47", "O48O49", "O50O51",
> > +	"O58O59", "O60O61", "O62O63", "O64O65",
> > +	"O66O67", "O68O69", "O26O27", "OFF",
> > +};
> > +
> > +static const int mt8186_sgen_mode_idx[] = {
> > +	0, 2, 4, 6,
> > +	8, 22, 10, 12,
> > +	14, -1, 18, 20,
> > +	24, 26, 28, 33,
> > +	34, 36, 38, 40,
> > +	42, 44, 46, 48,
> > +	56, 58, 60, 62,
> > +	128, 130, 132, 134,
> > +	135, 138, 139, 140,
> > +	142, 144, 166, 148,
> > +	150, 152, 153, 156,
> > +	162, 163, 160, 164,
> > +	166, -1, 168, 170,
> > +	172, 174, 176, 178,
> > +	186, 188, 190, 192,
> > +	194, 196, -1, -1,
> > +};
> > +
> > +static const char * const mt8186_sgen_rate_str[] = {
> > +	"8K", "11K", "12K", "16K",
> > +	"22K", "24K", "32K", "44K",
> > +	"48K", "88k", "96k", "176k",
> > +	"192k"
> > +};
> > +
> > +static const int mt8186_sgen_rate_idx[] = {
> > +	0, 1, 2, 4,
> > +	5, 6, 8, 9,
> > +	10, 11, 12, 13,
> > +	14
> > +};
> > +
> > +/* this order must match reg bit amp_div_ch1/2 */
> > +static const char * const mt8186_sgen_amp_str[] = {
> > +	"1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1" };
> > +static const char * const mt8186_sgen_mute_str[] = {
> > +	"Off", "On"
> > +};
> > +
> > +static int mt8186_sgen_get(struct snd_kcontrol *kcontrol,
> > +			   struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	ucontrol->value.integer.value[0] = afe_priv->sgen_mode;
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_set(struct snd_kcontrol *kcontrol,
> > +			   struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct soc_enum *e = (struct soc_enum *)kcontrol-
> > >private_value;
> > +	int mode;
> > +	int mode_idx;
> > +
> > +	if (ucontrol->value.enumerated.item[0] >= e->items)
> > +		return -EINVAL;
> > +
> > +	mode = ucontrol->value.integer.value[0];
> > +	mode_idx = mt8186_sgen_mode_idx[mode];
> > +
> > +	dev_info(afe->dev, "%s(), mode %d, mode_idx %d\n",
> > +		 __func__, mode, mode_idx);
> > +
> > +	if (mode_idx >= 0) {
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> > +				   INNER_LOOP_BACK_MODE_MASK_SFT,
> > +				   mode_idx <<
> > INNER_LOOP_BACK_MODE_SFT);
> > +		//regmap_write(afe->regmap, AFE_SINEGEN_CON0,
> > 0x04ac2ac1);
> 
> Why is this commented out?
> Either remove the comment, or remove the line entirely.
> 
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +				   DAC_EN_MASK_SFT,
> > +				   0x1 << DAC_EN_SFT);
> 
> BIT()
> 
> > +	} else {
> > +		/* disable sgen */
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +				   DAC_EN_MASK_SFT,
> > +				   0x0);
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
> > +				   INNER_LOOP_BACK_MODE_MASK_SFT,
> > +				   0x3f << INNER_LOOP_BACK_MODE_SFT);
> > +	}
> > +
> > +	afe_priv->sgen_mode = mode;
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_rate_get(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	ucontrol->value.integer.value[0] = afe_priv->sgen_rate;
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_rate_set(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct soc_enum *e = (struct soc_enum *)kcontrol-
> > >private_value;
> > +	int rate;
> > +
> > +	if (ucontrol->value.enumerated.item[0] >= e->items)
> > +		return -EINVAL;
> > +
> > +	rate = ucontrol->value.integer.value[0];
> > +
> > +	dev_info(afe->dev, "%s(), rate %d\n", __func__, rate);
> 
> dev_dbg()
> 
> > +
> > +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +			   SINE_MODE_CH1_MASK_SFT,
> > +			   mt8186_sgen_rate_idx[rate] <<
> > SINE_MODE_CH1_SFT);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +			   SINE_MODE_CH2_MASK_SFT,
> > +			   mt8186_sgen_rate_idx[rate] <<
> > SINE_MODE_CH2_SFT);
> > +
> > +	afe_priv->sgen_rate = rate;
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_amplitude_get(struct snd_kcontrol
> > *kcontrol,
> > +				     struct snd_ctl_elem_value
> > *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +
> > +	ucontrol->value.integer.value[0] = afe_priv->sgen_amplitude;
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_amplitude_set(struct snd_kcontrol
> > *kcontrol,
> > +				     struct snd_ctl_elem_value
> > *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> > +	struct soc_enum *e = (struct soc_enum *)kcontrol-
> > >private_value;
> > +	int amplitude;
> > +
> > +	if (ucontrol->value.enumerated.item[0] >= e->items)
> > +		return -EINVAL;
> > +
> > +	amplitude = ucontrol->value.integer.value[0];
> > +	if (amplitude > AMP_DIV_CH1_MASK) {
> > +		dev_info(afe->dev, "%s(), amplitude %d invalid\n",
> > +			 __func__, amplitude);
> 
> dev_err()
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_info(afe->dev, "%s(), amplitude %d\n", __func__,
> > amplitude);
> > +
> > +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +			   AMP_DIV_CH1_MASK_SFT,
> > +			   amplitude << AMP_DIV_CH1_SFT);
> > +	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +			   AMP_DIV_CH2_MASK_SFT,
> > +			   amplitude << AMP_DIV_CH2_SFT);
> > +
> > +	afe_priv->sgen_amplitude = amplitude;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_sgen_mute_get(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	int mute;
> > +
> > +	regmap_read(afe->regmap, AFE_SINEGEN_CON0, &mute);
> > +
> > +	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) ==
> > 0)
> > +		return (mute >> MUTE_SW_CH1_SFT) & MUTE_SW_CH1_MASK;
> > +	else
> > +		return (mute >> MUTE_SW_CH2_SFT) & MUTE_SW_CH2_MASK;
> 
> 	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) ==
> 0)
> 		return (mute >> MUTE_SW_CH1_SFT) & MUTE_SW_CH1_MASK;
> 
> 	return (mute >> MUTE_SW_CH2_SFT) & MUTE_SW_CH2_MASK;
> 
> > +}
> > +
> > +static int mt8186_sgen_mute_set(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	struct soc_enum *e = (struct soc_enum *)kcontrol-
> > >private_value;
> > +	int mute;
> > +
> > +	if (ucontrol->value.enumerated.item[0] >= e->items)
> > +		return -EINVAL;
> > +
> > +	mute = ucontrol->value.integer.value[0];
> > +
> > +	dev_info(afe->dev, "%s(), kcontrol name %s, mute %d\n",
> > +		 __func__, kcontrol->id.name, mute);
> 
> dev_dbg()
> 
> > +
> > +	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) ==
> > 0) {
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +				   MUTE_SW_CH1_MASK_SFT,
> > +				   mute << MUTE_SW_CH1_SFT);
> > +	} else {
> > +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> > +				   MUTE_SW_CH2_MASK_SFT,
> > +				   mute << MUTE_SW_CH2_SFT);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct soc_enum mt8186_afe_sgen_enum[] = {
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mode_str),
> > +			    mt8186_sgen_mode_str),
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_rate_str),
> > +			    mt8186_sgen_rate_str),
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_amp_str),
> > +			    mt8186_sgen_amp_str),
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mute_str),
> > +			    mt8186_sgen_mute_str),
> > +};
> > +
> > +static const struct snd_kcontrol_new mt8186_afe_sgen_controls[] =
> > {
> > +	SOC_ENUM_EXT("Audio_SineGen_Switch", mt8186_afe_sgen_enum[0],
> > +		     mt8186_sgen_get, mt8186_sgen_set),
> > +	SOC_ENUM_EXT("Audio_SineGen_SampleRate",
> > mt8186_afe_sgen_enum[1],
> > +		     mt8186_sgen_rate_get, mt8186_sgen_rate_set),
> > +	SOC_ENUM_EXT("Audio_SineGen_Amplitude",
> > mt8186_afe_sgen_enum[2],
> > +		     mt8186_sgen_amplitude_get,
> > mt8186_sgen_amplitude_set),
> > +	SOC_ENUM_EXT(SGEN_MUTE_CH1_KCONTROL_NAME,
> > mt8186_afe_sgen_enum[3],
> > +		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
> > +	SOC_ENUM_EXT(SGEN_MUTE_CH2_KCONTROL_NAME,
> > mt8186_afe_sgen_enum[3],
> > +		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
> > +	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch1", AFE_SINEGEN_CON0,
> > +		   FREQ_DIV_CH1_SFT, FREQ_DIV_CH1_MASK, 0),
> > +	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch2", AFE_SINEGEN_CON0,
> > +		   FREQ_DIV_CH2_SFT, FREQ_DIV_CH2_MASK, 0),
> > +};
> > +
> > +/* audio debug log */
> > +static const char * const mt8186_afe_off_on_str[] = {
> > +	"Off", "On"
> > +};
> > +
> > +static int mt8186_afe_debug_get(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int mt8186_afe_debug_set(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *cmpnt =
> > snd_soc_kcontrol_component(kcontrol);
> > +	struct mtk_base_afe *afe =
> > snd_soc_component_get_drvdata(cmpnt);
> > +	unsigned int value;
> > +
> 
> This should be debugfs, instead of spitting a full register dump in
> the kmsg:
> doing so is horrible (sorry).
Yes, I will remove them in next version.

> 
> > +	regmap_read(afe->regmap, AUDIO_TOP_CON0, &value);
> > +	dev_info(afe->dev, "AUDIO_TOP_CON0 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AUDIO_TOP_CON1, &value);
> > +	dev_info(afe->dev, "AUDIO_TOP_CON1 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AUDIO_TOP_CON2, &value);
> > +	dev_info(afe->dev, "AUDIO_TOP_CON2 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AUDIO_TOP_CON3, &value);
> > +	dev_info(afe->dev, "AUDIO_TOP_CON3 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AFE_DAC_CON0, &value);
> > +	dev_info(afe->dev, "AFE_DAC_CON0 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AFE_I2S_CON, &value);
> > +	dev_info(afe->dev, "AFE_I2S_CON = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AFE_CONN0, &value);
> > +	dev_info(afe->dev, "AFE_CONN0 = 0x%x\n", value);
> > 
snip ...

> > +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN54_1, &value);
> > +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN54_1 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN55_1, &value);
> > +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN55_1 = 0x%x\n", value);
> > +	regmap_read(afe->regmap, AFE_SECURE_MASK_CONN56_1, &value);
> > +	dev_info(afe->dev, "AFE_SECURE_MASK_CONN56_1 = 0x%x\n", value);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct soc_enum mt8186_afe_misc_enum[] = {
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_afe_off_on_str),
> > +			    mt8186_afe_off_on_str),
> > +};
> > +
> > +static const struct snd_kcontrol_new mt8186_afe_debug_controls[] =
> > {
> > +	SOC_ENUM_EXT("Audio_Debug_Setting", mt8186_afe_misc_enum[0],
> > +		     mt8186_afe_debug_get, mt8186_afe_debug_set),
> > +};
> > +
> > +int mt8186_add_misc_control(struct snd_soc_component *component)
> > +{
> > +	snd_soc_add_component_controls(component,
> > +				       mt8186_afe_sgen_controls,
> > +				       ARRAY_SIZE(mt8186_afe_sgen_contr
> > ols));
> > +
> > +	snd_soc_add_component_controls(component,
> > +				       mt8186_afe_debug_controls,
> > +				       ARRAY_SIZE(mt8186_afe_debug_cont
> > rols));
> > +
> > +	return 0;
> > +}


