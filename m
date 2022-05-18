Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF152AFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiERBNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiERBNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:13:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5A951E4C;
        Tue, 17 May 2022 18:13:28 -0700 (PDT)
X-UUID: 0a14b6a7b94e48adb474547db5e70b92-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:e0c1e221-3d54-4bdd-a806-4867722f3970,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:389f8ce2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 0a14b6a7b94e48adb474547db5e70b92-20220518
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 948408978; Wed, 18 May 2022 09:13:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 18 May 2022 09:13:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 May 2022 09:13:20 +0800
Message-ID: <1614c81e4975c5cfd19c8090d523b16116907389.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10
 M4Us
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <konrad.dybcio@somainline.org>, <marijn.suijten@somainline.org>,
        <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>,
        <yf.wang@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <libo.kang@mediatek.com>, <youlin.pei@mediatek.com>
Date:   Wed, 18 May 2022 09:13:20 +0800
In-Reply-To: <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
         <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
         <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
         <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
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

On Tue, 2022-05-17 at 11:26 +0200, AngeloGioacchino Del Regno wrote:
> Il 17/05/22 11:08, Yong Wu ha scritto:
> > On Fri, 2022-05-13 at 17:14 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > Add support for the M4Us found in the MT6795 Helio X10 SoC.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/iommu/mtk_iommu.c | 20 +++++++++++++++++++-
> > >   1 file changed, 19 insertions(+), 1 deletion(-)

[...]

> > > +static const struct mtk_iommu_plat_data mt6795_data = {
> > > +	.m4u_plat     = M4U_MT6795,
> > > +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> > > +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
> > > +	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> > > +	.banks_num    = 1,
> > > +	.banks_enable = {true},
> > > +	.iova_region  = single_domain,
> > > +	.iova_region_nr = ARRAY_SIZE(single_domain),
> > > +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping.
> > > */
> > > +};
> > 
> > This is nearly same with mt8173_data. mt8173 has one more larb than
> > mt6795, its larbid_remap is also ok for mt6795.
> > 
> 
> I think that we should be explicit about the larbid_remap property,
> since mt6795 has one less larb, we should explicitly say that like
> I did there... that's only for human readability I admit ... but,
> still, I wouldn't want to see people thinking that MT6795 has 6 LARBs
> because they've read that larbid_remap having 6 entries.

In the linear mapping case, It does help. Strictly larbid_remap is two-
dimensional array now, It doesn't indicate how many larbs this SoC
has. If someone would like to know this, he could read the mtxxx-larb-
port.h. We also could document the larb numbers in the binding
for readability.

Anyway, It is not a big problem. A new structure is ok for me. I just
complain there are too many structures, specially in the internal
branch which contains many non-upstream SoCs, and there may be several
IOMMU HWs in one SoC. thus I'd like to group it personally.

> 
> > thus it looks we could use mt8173 as the backward compatible.
> >      compatible = "mediatek,mt6795-m4u",
> >                   "mediatek,mt8173-m4u";
> > 
> > After this, the only thing is about "mediatek,mt6795-infracfg". we
> > have
> > to try again with mediatek,mt6795-infracfg after mediatek,mt8173-
> > infracfg fail. I think we should allow the backward case in 4GB
> > mode
> > judgment if we have.
> > 
> > What's your opinion? or some other suggestion?
> > Thanks.
> 
> I know, I may have a plan for that, but I wanted to have a good
> reason to
> propose such a thing, as if it's just about two SoCs needing that,
> there
> would be no good reason to get things done differently.
> 
> ...so, in order to provide a good cleanup, we have two possible roads
> to
> follow here: either we add a generic "mediatek,infracfg" compatible
> to the
> infra node (but I don't like that), or we can do it like it was
> previously
> done in mtk-pm-domains.c (I prefer that approach):
> 
> iommu: iommu@somewhere {
> 	... something ...
> 	mediatek,infracfg = <&infracfg>;

We like this too. But this was not suggested from Rob long before.

https://lore.kernel.org/linux-mediatek/20200715205120.GA778876@bogus/

> };
> 
> infracfg = syscon_regmap_lookup_by_compatible(node,
> "mediatek,infracfg");
> if (IS_ERR(infracfg)) {
> 	/* try with the older way */
> 	switch (...) {
> 	case .... p = "mediatek,mt2712-infracfg";
> 	... blah blah ...
> 	}
> 	/* legacy also failed, ouch! */
> 	if (IS_ERR(infracfg))
> 		return PTR_ERR(infracfg);
> }
> 
> ret = regmap_read ... etc etc etc
> 
> Cheers,
> Angelo

