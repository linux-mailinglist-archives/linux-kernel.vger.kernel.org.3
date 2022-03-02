Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020954C9C59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiCBEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCBEIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:08:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8E13DD0;
        Tue,  1 Mar 2022 20:07:48 -0800 (PST)
X-UUID: c5bbf587611e40539296222f6d93108a-20220302
X-UUID: c5bbf587611e40539296222f6d93108a-20220302
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1851172525; Wed, 02 Mar 2022 12:07:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 12:07:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Mar 2022 12:07:39 +0800
Message-ID: <0b8a5c22acb87b49de0380c7cb4e49030f93d715.camel@mediatek.com>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>
Date:   Wed, 2 Mar 2022 12:07:39 +0800
In-Reply-To: <Yh3hcQpLngg8Pnd4@google.com>
References: <20220301072924.24814-1-jiaxin.yu@mediatek.com>
         <20220301072924.24814-3-jiaxin.yu@mediatek.com>
         <Yh3hcQpLngg8Pnd4@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 17:03 +0800, Tzung-Bi Shih wrote:
> On Tue, Mar 01, 2022 at 03:29:24PM +0800, Jiaxin Yu wrote:
> > From: Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>
> 
> The environment didn't configure properly so that the header showed
> up.
> See [1].
> 
> [1]: 
> https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---fromltaddressgt
> 
Ok, I will take a look at the "from: " header.

> > diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-
> > rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> 
> [...]
> > +static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682s_card = {
> > +	.name = "mt8192_mt6359_rt1015p_rt5682s",
> > +	.owner = THIS_MODULE,
> > +	.dai_link = mt8192_mt6359_dai_links,
> > +	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
> > +	.controls = mt8192_mt6359_rt1015p_rt5682_controls,
> > +	.num_controls =
> > ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_controls),
> > +	.dapm_widgets = mt8192_mt6359_rt1015p_rt5682_widgets,
> > +	.num_dapm_widgets =
> > ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_widgets),
> > +	.dapm_routes = mt8192_mt6359_rt1015p_rt5682_routes,
> > +	.num_dapm_routes =
> > ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
> > +};
> 
> Are the two cards only different from names
> (mt8192_mt6359_rt1015p_rt5682_card vs.
> mt8192_mt6359_rt1015p_rt5682s_card)?
> 
Yes, they are only different form names.

> > @@ -1150,6 +1177,52 @@ static int mt8192_mt6359_dev_probe(struct
> > platform_device *pdev)
> >  				dai_link->num_platforms =
> >  					ARRAY_SIZE(i2s3_rt1015p_platfor
> > ms);
> >  			}
> > +		} else if (strcmp(dai_link->name, "I2S8") == 0) {
> > +			if (card == &mt8192_mt6359_rt1015_rt5682_card
> > ||
> > +			    card == &mt8192_mt6359_rt1015p_rt5682_card)
> > {
> > +				dai_link->cpus = i2s8_rt5682_cpus;
> > +				dai_link->num_cpus =
> > +					ARRAY_SIZE(i2s8_rt5682_cpus);
> > +				dai_link->codecs = i2s8_rt5682_codecs;
> > +				dai_link->num_codecs =
> > +					ARRAY_SIZE(i2s8_rt5682_codecs);
> > +				dai_link->platforms =
> > i2s8_rt5682_platforms;
> > +				dai_link->num_platforms =
> > +					ARRAY_SIZE(i2s8_rt5682_platform
> > s);
> > +			} else if (card ==
> > &mt8192_mt6359_rt1015p_rt5682s_card) {
> > +				dai_link->cpus = i2s8_rt5682s_cpus;
> > +				dai_link->num_cpus =
> > +					ARRAY_SIZE(i2s8_rt5682s_cpus);
> > +				dai_link->codecs = i2s8_rt5682s_codecs;
> > +				dai_link->num_codecs =
> > +					ARRAY_SIZE(i2s8_rt5682s_codecs)
> > ;
> > +				dai_link->platforms =
> > i2s8_rt5682s_platforms;
> > +				dai_link->num_platforms =
> > +					ARRAY_SIZE(i2s8_rt5682s_platfor
> > ms);
> > +			}
> > +		} else if (strcmp(dai_link->name, "I2S9") == 0) {
> > +			if (card == &mt8192_mt6359_rt1015_rt5682_card
> > ||
> > +			    card == &mt8192_mt6359_rt1015p_rt5682_card)
> > {
> > +				dai_link->cpus = i2s9_rt5682_cpus;
> > +				dai_link->num_cpus =
> > +					ARRAY_SIZE(i2s9_rt5682_cpus);
> > +				dai_link->codecs = i2s9_rt5682_codecs;
> > +				dai_link->num_codecs =
> > +					ARRAY_SIZE(i2s9_rt5682_codecs);
> > +				dai_link->platforms =
> > i2s9_rt5682_platforms;
> > +				dai_link->num_platforms =
> > +					ARRAY_SIZE(i2s9_rt5682_platform
> > s);
> > +			} else if (card ==
> > &mt8192_mt6359_rt1015p_rt5682s_card) {
> > +				dai_link->cpus = i2s9_rt5682s_cpus;
> > +				dai_link->num_cpus =
> > +					ARRAY_SIZE(i2s9_rt5682s_cpus);
> > +				dai_link->codecs = i2s9_rt5682s_codecs;
> > +				dai_link->num_codecs =
> > +					ARRAY_SIZE(i2s9_rt5682s_codecs)
> > ;
> > +				dai_link->platforms =
> > i2s9_rt5682s_platforms;
> > +				dai_link->num_platforms =
> > +					ARRAY_SIZE(i2s9_rt5682s_platfor
> > ms);
> > +			}
> 
> After seeing the code, I am starting to wonder if the reuse is
> overkill.  If
> they (RT5682 vs. RT5682S) only have some minor differences, probably
> it could
> reuse more by:
> 
> SND_SOC_DAILINK_DEFS(i2s8, ...
> SND_SOC_DAILINK_DEFS(i2s9, ...
> 
> ...
> 
> if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
>         i2s8_codecs.name = RT5682S_DEV0_NAME;
>         i2s8_codecs.dai_name = RT5682S_CODEC_DAI;
>         ...
> }
> 
> Or even uses of_device_is_compatible() if it would like to reuse the
> struct
> snd_soc_card.
If we reuse the struct snd_soc_card, the card .name will be same.
Should I change the card .name through of_device_is_compatible()?

Maybe like below:

Remove rt5682x related words for snd_soc_card.
static struct snd_soc_card mt8192_mt6359_rt1015p_card = {
	.owner = THIS_MODULE,
	.dai_link = mt8192_mt6359_dai_links,
	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
	.controls = mt8192_mt6359_rt1015p_controls,
	.num_controls = ARRAY_SIZE(mt8192_mt6359_rt1015p_controls),
	.dapm_widgets = mt8192_mt6359_rt1015p_widgets,
	.num_dapm_widgets = ARRAY_SIZE(mt8192_mt6359_rt1015p_widgets),
	.dapm_routes = mt8192_mt6359_rt1015p_routes,
	.num_dapm_routes = ARRAY_SIZE(mt8192_mt6359_rt1015p_routes),
};

static const struct of_device_id mt8192_mt6359_dt_match[] = {
	{
		.compatible = "mediatek,mt8192_mt6359_rt1015_rt5682",
		.data = &mt8192_mt6359_rt1015_rt5682_card,
	},
	{
		.compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682",
		.data = &mt8192_mt6359_rt1015p_card,
	},
	{
		.compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682s",
		.data = &mt8192_mt6359_rt1015p_card,
	},
	{}
};

if (of_device_is_compatible(np, "mediatek,
mt8192_mt6359_rt1015p_rt5682")) {
	card.name = "mt8192_mt6359_rt1015p_rt5682";
	...
} else if (of_device_is_compatible(np, "mediatek,
mt8192_mt6359_rt1015p_rt5682s")) {
	card.name = "mt8192_mt6359_rt1015p_rt5682s";
	...
}






