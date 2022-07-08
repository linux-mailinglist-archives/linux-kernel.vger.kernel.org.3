Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDA56B727
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiGHKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiGHKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:19:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A5186FB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:19:38 -0700 (PDT)
X-UUID: 5ea76bf79d4347eb8ae3e5837ccc9c23-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:72b01edd-371d-4e54-bccb-3147bd92f8f8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:72b01edd-371d-4e54-bccb-3147bd92f8f8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:4fd9e886-57f0-47ca-ba27-fe8c57fbf305,C
        OID:bbab08a824a8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5ea76bf79d4347eb8ae3e5837ccc9c23-20220708
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1902605378; Fri, 08 Jul 2022 18:19:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 8 Jul 2022 18:19:30 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 8 Jul 2022 18:19:29 +0800
Message-ID: <503a71aa95b8e4b75eb7e9e5de03a013f5155036.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Remove condition with no effect
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhongjun Tan <hbut_tan@163.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.c>, <tiwai@suse.com>,
        <matthias.bgg@gmail.com>, <tanzhongjun@coolpad.com>,
        <colin.king@intel.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 8 Jul 2022 18:19:29 +0800
In-Reply-To: <ee0d9788-b742-21bb-9cc5-7b729897408b@collabora.com>
References: <20220708024651.42999-1-hbut_tan@163.com>
         <ee0d9788-b742-21bb-9cc5-7b729897408b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 10:01 +0200, AngeloGioacchino Del Regno wrote:
> Il 08/07/22 04:46, Zhongjun Tan ha scritto:
> > From: Zhongjun Tan <tanzhongjun@coolpad.com>
> > 
> > Remove condition with no effect
> > 
> > Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > index db71b032770d..6be6d4f3b585 100644
> > --- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > +++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> > @@ -295,8 +295,6 @@ static int mtk_adda_pad_top_event(struct
> > snd_soc_dapm_widget *w,
> >   	case SND_SOC_DAPM_PRE_PMU:
> >   		if (afe_priv->mtkaif_protocol ==
> > MTKAIF_PROTOCOL_2_CLK_P2)
> >   			regmap_write(afe->regmap, AFE_AUD_PAD_TOP,
> > 0x39);
> > -		else if (afe_priv->mtkaif_protocol ==
> > MTKAIF_PROTOCOL_2)
> > -			regmap_write(afe->regmap, AFE_AUD_PAD_TOP,
> > 0x31);
> 
> I think that this needs some clarification from MediaTek: was 0x31 a
> typo here?
> 
> Regards,
> Angelo
> 
Hi Angelo,

This patch can be accepted. The 0x31 is not typo, the logic of this
code is not concise enough.

Thanks,
Jiaxin.Yu

> >   		else
> >   			regmap_write(afe->regmap, AFE_AUD_PAD_TOP,
> > 0x31);
> >   		break;
> 
> 

