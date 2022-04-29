Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155D514642
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357062AbiD2KLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356800AbiD2KLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:11:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7CC44CD;
        Fri, 29 Apr 2022 03:07:58 -0700 (PDT)
X-UUID: 045731cb2f5c49ca9f4965c85acaa12a-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:be8b9c79-132d-48e6-a122-55eb691152c0,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:043ef6c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 045731cb2f5c49ca9f4965c85acaa12a-20220429
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 592507732; Fri, 29 Apr 2022 18:07:54 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 18:07:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 18:07:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 18:07:52 +0800
Message-ID: <99c329534a462b39d9b39ba04851318e7823e54c.camel@mediatek.com>
Subject: Re: [v4 13/18] ASoC: mediatek: mt8186: add platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 29 Apr 2022 18:07:52 +0800
In-Reply-To: <YmqCORqp6nYuQJZf@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
         <20220428093355.16172-14-jiaxin.yu@mediatek.com>
         <YmqCORqp6nYuQJZf@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 13:02 +0100, Mark Brown wrote:
> On Thu, Apr 28, 2022 at 05:33:50PM +0800, Jiaxin Yu wrote:
> > Add mt8186 platform and affiliated driver.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >  sound/soc/mediatek/Kconfig                    |   44 +
> >  sound/soc/mediatek/Makefile                   |    1 +
> >  sound/soc/mediatek/mt8186/Makefile            |   22 +
> >  sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
> >  .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
> >  sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3005
> > +++++++++++++++++
> >  .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
> >  .../soc/mediatek/mt8186/mt8186-misc-control.c |  294 ++
> >  .../mediatek/mt8186/mt8186-mt6366-common.c    |   59 +
> >  .../mediatek/mt8186/mt8186-mt6366-common.h    |   17 +
> >  sound/soc/mediatek/mt8186/mt8186-reg.h        | 2913
> > ++++++++++++++++
> >  11 files changed, 6920 insertions(+)
> 
> This looks mostly good though it is enormous so I might've missed
> some
> things.  The patch series is already very large but it might still be
> worth splitting this up a bit more, perhaps split the code and data
> tables/register definitions into separate patches?
> 
Yes, agree with you.

I will spit them into three patches:

PATCH 1: 
  - mt8186-reg.h
  - mt8186-interconnection.h
  - mt8186-misc-control.c

PATCH 2:
  - mt8186-mt6366-common.c
  - mt8186-mt6366-common.h

PATCH 3:
  - sound/soc/mediatek/Kconfig 
  - sound/soc/mediatek/Makefile
  - sound/soc/mediatek/mt8186/Makefile
  - sound/soc/mediatek/mt8186/mt8186-afe-common.h
  - .../soc/mediatek/mt8186/mt8186-afe-control.c
  - sound/soc/mediatek/mt8186/mt8186-afe-pcm.c

> A few relatively minor issues with the controls.
> 
> > +/* this order must match reg bit amp_div_ch1/2 */
> > +static const char * const mt8186_sgen_amp_str[] = {
> > +	"1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1" };
> > +static const char * const mt8186_sgen_mute_str[] = {
> > +	"Off", "On"
> > +};
> 
> On/off controls should be normal Switch controls not enums so
> userspace
> can display things sensibly.
> 
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
> 
> ...
> 
> > +				   0x3f << INNER_LOOP_BACK_MODE_SFT);
> > +	}
> > +
> > +	afe_priv->sgen_mode = mode;
> > +
> > +	return 0;
> > +}
> 
> This should return 1 if the value is different from the previous
> value
> so event generation works, please run mixer-test against a system
> using
> the driver to help spot issues like this.  The same issue applies to
> at
> least some of the other custom controls.
> 
Got it.

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
> > +	dev_dbg(afe->dev, "%s(), kcontrol name %s, mute %d\n",
> > +		__func__, kcontrol->id.name, mute);
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
> 
> I can't tell why some of these are done with custom code rather than
> using a normal SOC_SINGLE()?

Yes, it's better to use SOC_SINGLE. I will fix them in next version.

Thanks,
Jiaxin.yu

