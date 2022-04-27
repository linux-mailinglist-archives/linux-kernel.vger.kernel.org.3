Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB751131C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359222AbiD0IDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359203AbiD0ID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:03:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F99A13F91;
        Wed, 27 Apr 2022 01:00:14 -0700 (PDT)
X-UUID: e5a4726522b74573a51c0f3c7dcb237e-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:53aad087-300b-419b-ba44-baeba704f0c7,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:159aa7c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: e5a4726522b74573a51c0f3c7dcb237e-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 206080323; Wed, 27 Apr 2022 16:00:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 16:00:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 16:00:06 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 16:00:05 +0800
Message-ID: <ec53cb218ab313cc6bd76660c9bd5c0ac46ad5d9.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: media: mtk-vcodec: Adds encoder power
 domain property
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 27 Apr 2022 16:00:05 +0800
In-Reply-To: <98a01f46-7fb0-6201-c9db-14e15d7e30c4@xs4all.nl>
References: <20220427033130.18497-1-irui.wang@mediatek.com>
         <98a01f46-7fb0-6201-c9db-14e15d7e30c4@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,

On Wed, 2022-04-27 at 09:43 +0200, Hans Verkuil wrote:
> Hi Irui,
> 
> I'm merging this patch from Nícolas F. R. A. Prado, which has already
> been Acked by Rob:
> 
> 
https://patchwork.linuxtv.org/project/linux-media/patch/20220225225854.81038-4-nfraprado@collabora.com/
> 
> If you still want the other changes you made in this patch merged,
> then please make
> a v3 on top of Nícolas' patch.

Thanks for your information and Nícolas' patch, we will check it and
would send a v3 patch if needed.

Thanks
Best Regards.
> 
> Regards,
> 
> 	Hans
> 
> On 27/04/2022 05:31, Irui Wang wrote:
> > Adds encoder power domain property.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> > changes compared with v1:
> > - set "power-domains" as a non-required property
> > 
> > The 'make dtbs_check' warnings('mediatek,larb') can be fixed by
> > patch:
> > 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=633993
> > ---
> >  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml  | 6
> > ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder.yaml
> > index deb5b657a2d5..2d1e0c9bd6ee 100644
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
> > @@ -132,6 +135,7 @@ examples:
> >      #include <dt-bindings/clock/mt8173-clk.h>
> >      #include <dt-bindings/memory/mt8173-larb-port.h>
> >      #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/mt8173-power.h>
> >  
> >      vcodec_enc_avc: vcodec@18002000 {
> >        compatible = "mediatek,mt8173-vcodec-enc";
> > @@ -153,6 +157,7 @@ examples:
> >        clock-names = "venc_sel";
> >        assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> >        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
> >      };
> >  
> >      vcodec_enc_vp8: vcodec@19002000 {
> > @@ -173,4 +178,5 @@ examples:
> >        clock-names = "venc_lt_sel";
> >        assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> >        assigned-clock-parents = <&topckgen
> > CLK_TOP_VCODECPLL_370P5>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
> >      };
> 
> 

