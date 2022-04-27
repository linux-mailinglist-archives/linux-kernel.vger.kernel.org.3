Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1A510F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357297AbiD0C7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357298AbiD0C6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:58:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B03912FEF7;
        Tue, 26 Apr 2022 19:55:45 -0700 (PDT)
X-UUID: 249ecca2f6cf4344aa2ff8f903ea6253-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:76a7e497-a93f-46d9-8d7c-6fb136f6bf14,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:59
X-CID-INFO: VERSION:1.1.4,REQID:76a7e497-a93f-46d9-8d7c-6fb136f6bf14,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:59
X-CID-META: VersionHash:faefae9,CLOUDID:521f9bc6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:daa355b14735,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 249ecca2f6cf4344aa2ff8f903ea6253-20220427
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 580416781; Wed, 27 Apr 2022 10:55:39 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 10:55:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 10:55:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 10:55:35 +0800
Message-ID: <693edb35a45abe66e7eae378af6e778eebe01171.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: media: mtk-vcodec: Adds encoder power
 domain property
From:   Irui Wang <irui.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Yunfei Dong" <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 27 Apr 2022 10:55:35 +0800
In-Reply-To: <YmhX89nQjkwt5qb3@robh.at.kernel.org>
References: <20220420073440.31649-1-irui.wang@mediatek.com>
         <YmhX89nQjkwt5qb3@robh.at.kernel.org>
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

Dear Rob,

Thanks for reviewing.

On Tue, 2022-04-26 at 15:37 -0500, Rob Herring wrote:
> On Wed, Apr 20, 2022 at 03:34:39PM +0800, Irui Wang wrote:
> > Adds encoder power domain property
> 
> Why? You can't add new, required properties as that breaks
> compatibility 
> with existing DTs.
We will use the "power-domains" property in new DTs, and we will get a
"make dtbs_check" warning if we don't add the "power-domains" in yaml,
so we add it, but should not be a "required property", we will send a
new version for it.

And another series patch will fix the "dtbs_check"(mediatek,larb) you
mentioned before:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=633993

Thanks
Best Regards

> 
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > index deb5b657a2d5..3c069c965992 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > @@ -41,6 +41,9 @@ properties:
> >  
> >    assigned-clock-parents: true
> >  
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    iommus:
> >      minItems: 1
> >      maxItems: 32
> > @@ -72,6 +75,7 @@ required:
> >    - iommus
> >    - assigned-clocks
> >    - assigned-clock-parents
> > +  - power-domains
> >  
> >  allOf:
> >    - if:
> > @@ -132,6 +136,7 @@ examples:
> >      #include <dt-bindings/clock/mt8173-clk.h>
> >      #include <dt-bindings/memory/mt8173-larb-port.h>
> >      #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/mt8173-power.h>
> >  
> >      vcodec_enc_avc: vcodec@18002000 {
> >        compatible = "mediatek,mt8173-vcodec-enc";
> > @@ -153,6 +158,7 @@ examples:
> >        clock-names = "venc_sel";
> >        assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> >        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
> >      };
> >  
> >      vcodec_enc_vp8: vcodec@19002000 {
> > @@ -173,4 +179,5 @@ examples:
> >        clock-names = "venc_lt_sel";
> >        assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> >        assigned-clock-parents = <&topckgen
> > CLK_TOP_VCODECPLL_370P5>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
> >      };
> > -- 
> > 2.18.0
> > 
> > 

