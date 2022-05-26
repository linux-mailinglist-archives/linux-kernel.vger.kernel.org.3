Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31757534A41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 07:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbiEZFwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 01:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiEZFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:52:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA0252BF;
        Wed, 25 May 2022 22:52:10 -0700 (PDT)
X-UUID: 3d290de9bbf54c159b15afc1728bac8c-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:548a4f3b-d3a6-4b4b-80e9-1bf1f1813d43,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.5,REQID:548a4f3b-d3a6-4b4b-80e9-1bf1f1813d43,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:2a19b09,CLOUDID:29664db8-3c45-407b-8f66-25095432a27a,C
        OID:05eb4031d4ce,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 3d290de9bbf54c159b15afc1728bac8c-20220526
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 369762117; Thu, 26 May 2022 13:52:01 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 13:52:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 May 2022 13:52:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 May 2022 13:52:00 +0800
Message-ID: <48e3f8a9db7b4fe429ed55440b8fa437f40b12ba.camel@mediatek.com>
Subject: Re: [PATCH v3 2/4] soc: mediatek: svs: add support for mt8186
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Thu, 26 May 2022 13:52:00 +0800
In-Reply-To: <0a1c4797-cfdf-1b45-62f0-18ecf78ed335@collabora.com>
References: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
         <20220523084034.26802-3-jia-wei.chang@mediatek.com>
         <0a1c4797-cfdf-1b45-62f0-18ecf78ed335@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 11:38 +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 10:40, Tim Chang ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > MT8186 svs has a number of banks which used as optimization of opp
> > voltage table for corresponding dvfs drivers.
> > MT8186 svs big core uses 2-line high bank and low bank to optimize
> > the
> > voltage of opp table for higher and lower frequency respectively.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 351
> > ++++++++++++++++++++++++++++++++-
> >   1 file changed, 344 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c
> > b/drivers/soc/mediatek/mtk-svs.c
> > index 606a00a2e57d..656d0361ff7d 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> 
> ..snip..
> 
> > @@ -2245,6 +2569,16 @@ static const struct svs_platform_data
> > svs_mt8192_platform_data = {
> >   	.bank_max = ARRAY_SIZE(svs_mt8192_banks),
> >   };
> >   
> > +static const struct svs_platform_data svs_mt8186_platform_data = {
> > +	.name = "mt8186-svs",
> > +	.banks = svs_mt8186_banks,
> > +	.efuse_parsing = svs_mt8186_efuse_parsing,
> > +	.probe = svs_mt8186_platform_probe,
> > +	.irqflags = IRQF_TRIGGER_HIGH,
> 
> I know I gave you my R-b tag earlier, but I've just noticed that:
> please remove
> irqflags, as this kind of flags are specified in devicetree and it is
> not
> necessary to specify them here.
> 
> Thanks,
> Angelo

Hi Angelo,

Sure, I will remove it in the next version.
Thanks.


