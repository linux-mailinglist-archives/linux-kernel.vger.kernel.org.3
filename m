Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480254F21A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiDEDOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiDEDLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:11:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57C33E34;
        Mon,  4 Apr 2022 20:04:48 -0700 (PDT)
X-UUID: c4b5aafc4076432f8e1a3f4932de0a97-20220405
X-UUID: c4b5aafc4076432f8e1a3f4932de0a97-20220405
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1780051827; Tue, 05 Apr 2022 11:04:43 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Apr 2022 11:04:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Apr
 2022 11:04:41 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Apr 2022 11:04:40 +0800
Message-ID: <808d08a6dbbca1c0f1699643deb52b71b8b74669.camel@mediatek.com>
Subject: Re: [v3 19/19] ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 5 Apr 2022 11:04:33 +0800
In-Reply-To: <a497b403-5b20-9a2f-498e-b43727b26675@collabora.com>
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
         <20220313151023.21229-20-jiaxin.yu@mediatek.com>
         <a497b403-5b20-9a2f-498e-b43727b26675@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-14 at 11:18 +0100, AngeloGioacchino Del Regno wrote:
> Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> > This fixes the following build errors when mt6358 is configured as
> > module:
> > 
> > > > ERROR: modpost: "mt6358_set_mtkaif_protocol"
> > > > [sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.ko]
> > > > undefined!
> > > > ERROR: modpost: "mt6358_set_mtkaif_protocol"
> > > > [sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.ko]
> > > > undefined!
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> 
> Hello Jiaxin,
> 
> Can you please add a Fixes tag to this patch and send it separately
> from
> the MT8186 series?
> 
> After adding the Fixes tag:
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 
> Thanks,
> Angelo
> 

Hello, Angelo

Sorry for the late reply. I've sent this out separately.

Link: 
https://lore.kernel.org/lkml/20220319120325.11882-1-jiaxin.yu@mediatek.com/

> > ---
> >   sound/soc/codecs/mt6358.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
> > index 1fdd2f8cf877..61f2a7632fd4 100644
> > --- a/sound/soc/codecs/mt6358.c
> > +++ b/sound/soc/codecs/mt6358.c
> > @@ -107,6 +107,7 @@ int mt6358_set_mtkaif_protocol(struct
> > snd_soc_component *cmpnt,
> >   	priv->mtkaif_protocol = mtkaif_protocol;
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_protocol);
> >   
> >   static void playback_gpio_set(struct mt6358_priv *priv)
> >   {
> > @@ -273,6 +274,7 @@ int mt6358_mtkaif_calibration_enable(struct
> > snd_soc_component *cmpnt)
> >   			   1 << RG_AUD_PAD_TOP_DAT_MISO_LOOPBACK_SFT);
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_enable);
> >   
> >   int mt6358_mtkaif_calibration_disable(struct snd_soc_component
> > *cmpnt)
> >   {
> > @@ -296,6 +298,7 @@ int mt6358_mtkaif_calibration_disable(struct
> > snd_soc_component *cmpnt)
> >   	capture_gpio_reset(priv);
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(mt6358_mtkaif_calibration_disable);
> >   
> >   int mt6358_set_mtkaif_calibration_phase(struct snd_soc_component
> > *cmpnt,
> >   					int phase_1, int phase_2)
> > @@ -310,6 +313,7 @@ int mt6358_set_mtkaif_calibration_phase(struct
> > snd_soc_component *cmpnt,
> >   			   phase_2 << RG_AUD_PAD_TOP_PHASE_MODE2_SFT);
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(mt6358_set_mtkaif_calibration_phase);
> >   
> >   /* dl pga gain */
> >   enum {
> 
> 

