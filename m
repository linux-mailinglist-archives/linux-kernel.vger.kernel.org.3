Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37D534A43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 07:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbiEZFy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 01:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiEZFyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:54:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F8AF1EB;
        Wed, 25 May 2022 22:54:52 -0700 (PDT)
X-UUID: f0156b3f023442de83e983fdefdf6daa-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:bca405fb-0a5b-40e5-a557-59b9c45bfe03,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:e9a38947-4fb1-496b-8f1d-39e733fed1ea,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: f0156b3f023442de83e983fdefdf6daa-20220526
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1055895831; Thu, 26 May 2022 13:54:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 26 May 2022 13:54:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 May 2022 13:54:44 +0800
Message-ID: <36568582407c2513028bdd6669b9a6147ebd6132.camel@mediatek.com>
Subject: Re: [PATCH v3 4/4] soc: mediatek: svs: add support for mt8195
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
Date:   Thu, 26 May 2022 13:54:44 +0800
In-Reply-To: <d9563b65-2391-d32c-8a07-ca7a13cae7c7@collabora.com>
References: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
         <20220523084034.26802-5-jia-wei.chang@mediatek.com>
         <d9563b65-2391-d32c-8a07-ca7a13cae7c7@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 11:38 +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 10:40, Tim Chang ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > To support svs on MT8195, add corresponding bank information,
> > platform
> > data, probe and parsing function.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> 
> 
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 151
> > +++++++++++++++++++++++++++++++++
> >   1 file changed, 151 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c
> > b/drivers/soc/mediatek/mtk-svs.c
> > index 656d0361ff7d..bb5021648143 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> > @@ -1680,6 +1680,89 @@ static int svs_bank_resource_setup(struct
> > svs_platform *svsp)
> 
> ..snip..
> 
> > @@ -2559,6 +2697,16 @@ static struct svs_bank svs_mt8183_banks[] =
> > {
> >   	},
> >   };
> >   
> > +static const struct svs_platform_data svs_mt8195_platform_data = {
> > +	.name = "mt8195-svs",
> > +	.banks = svs_mt8195_banks,
> > +	.efuse_parsing = svs_mt8195_efuse_parsing,
> > +	.probe = svs_mt8192_platform_probe,
> > +	.irqflags = IRQF_TRIGGER_HIGH,
> 
> Interrupt flags are specified in devicetree; avoid declaring
> irqflags.
> 
> After that:
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 

Hi Angelo,

Sure, I will remove it in the next version.
Thanks.

