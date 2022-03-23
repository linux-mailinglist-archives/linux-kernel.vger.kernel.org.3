Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BC4E4DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiCWIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiCWIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:17:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3474DE3;
        Wed, 23 Mar 2022 01:15:39 -0700 (PDT)
X-UUID: 3edca82acd214e58a28fec002b336d42-20220323
X-UUID: 3edca82acd214e58a28fec002b336d42-20220323
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 129077964; Wed, 23 Mar 2022 16:15:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Mar 2022 16:15:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 16:15:31 +0800
Message-ID: <1d3f9ddc742c8af2e4613e6e1008b4a63b33e244.camel@mediatek.com>
Subject: Re: [PATCH v3 2/6] ASoC: mediatek: mt8195: merge machine driver
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Date:   Wed, 23 Mar 2022 16:15:30 +0800
In-Reply-To: <YjiVySElUQZnJG9C@google.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
         <20220321072312.14972-3-trevor.wu@mediatek.com>
         <YjiVySElUQZnJG9C@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 23:12 +0800, Tzung-Bi Shih wrote:
> On Mon, Mar 21, 2022 at 03:23:08PM +0800, Trevor Wu wrote:
> > -config SND_SOC_MT8195_MT6359_RT1019_RT5682
> > -	tristate "ASoC Audio driver for MT8195 with MT6359 RT1019
> > RT5682 codec"
> > -	depends on I2C && GPIOLIB
> > -	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
> > -	select SND_SOC_MT6359
> > -	select SND_SOC_RT1015P
> > -	select SND_SOC_RT5682_I2C
> > -	select SND_SOC_RT5682S
> > -	select SND_SOC_DMIC
> > -	select SND_SOC_HDMI_CODEC
> > -	help
> > -	  This adds ASoC driver for Mediatek MT8195 boards
> > -	  with the MT6359 RT1019 RT5682 audio codec.
> > -	  Select Y if you have such device.
> > -	  If unsure select "N".
> > -
> > -config SND_SOC_MT8195_MT6359_RT1011_RT5682
> > -	tristate "ASoC Audio driver for MT8195 with MT6359 RT1011
> > RT5682 codec"
> > +config SND_SOC_MT8195_MT6359
> > +	tristate "ASoC Audio driver for MT8195 with MT6359 and I2S
> > codec"
> 
> s/codec/codecs/.

OK.
> 
> >  	help
> > -	  This adds ASoC driver for Mediatek MT8195 boards
> > -	  with the MT6359 RT1011 RT5682 audio codec.
> > +	  This adds support for ASoC machine driver for Mediatek
> > MT8195 
> > +	  boards with the MT6359 and other I2S audio codec.
> 
> s/codec/codecs/.
OK.

> 
> > diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-
> > rt5682.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> 
> [...]
> > +static int mt8195_rt1011_etdm_hw_params(struct snd_pcm_substream
> > *substream,
> > +					struct snd_pcm_hw_params
> > *params)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =
> > asoc_substream_to_rtd(substream);
> > +	struct snd_soc_dai *codec_dai;
> > +	struct snd_soc_card *card = rtd->card;
> > +	int srate, i, ret = 0;
> > +
> > +	srate = params_rate(params);
> > +
> > +	for_each_rtd_codec_dais(rtd, i, codec_dai) {
> > +		ret = snd_soc_dai_set_pll(codec_dai, 0,
> > RT1011_PLL1_S_BCLK,
> > +					  64 * srate, 256 * srate);
> > +		if (ret < 0) {
> > +			dev_err(card->dev, "codec_dai clock not
> > set\n");
> > +			return ret;
> > +		}
> > +
> > +		ret = snd_soc_dai_set_sysclk(codec_dai,
> > +					     RT1011_FS_SYS_PRE_S_PLL1,
> > +					     256 * srate,
> > SND_SOC_CLOCK_IN);
> > +		if (ret < 0) {
> > +			dev_err(card->dev, "codec_dai clock not
> > set\n");
> > +			return ret;
> > +		}
> > +	}
> > +	return ret;
> 
> I guess it may be just copied from mt8195-mt6359-rt1011-
> rt5682.c.  However, it
> is good to turn the code into a better shape.  To be clear, just
> return 0 here
> so that the initialization can be removed.
> 
Yes, I copied it directly.
I will update this in v4.

> > +static int mt8195_rt1011_init(struct snd_soc_pcm_runtime *rtd)
> 
> [...]
> > +	ret = snd_soc_dapm_add_routes(&card->dapm,
> > mt8195_rt1011_routes,
> > +				      ARRAY_SIZE(mt8195_rt1011_routes))
> > ;
> > +
> > +	if (ret)
> 
> Remove the extra blank line.

OK. I didn't notice the blank line.
> 
> > +static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
> 
> [...]
> > +	ret = snd_soc_dapm_add_routes(&card->dapm,
> > mt8195_rt1019_routes,
> > +				      ARRAY_SIZE(mt8195_rt1019_routes))
> > ;
> > +
> > +	if (ret)
> 
> Remove the extra blank line.

OK.

Thanks,
Trevor

