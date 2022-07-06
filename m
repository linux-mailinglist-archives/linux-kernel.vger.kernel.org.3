Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBB567CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGFEDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGFED2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:03:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A79D96;
        Tue,  5 Jul 2022 21:03:27 -0700 (PDT)
X-UUID: 18eea4dd7bf84249a9b9bebb3bcdeca7-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:27eb5d56-54ae-4fd7-b544-b0014f961ffb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:ff85b8d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 18eea4dd7bf84249a9b9bebb3bcdeca7-20220706
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 793912462; Wed, 06 Jul 2022 12:03:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 6 Jul 2022 12:03:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 12:03:18 +0800
Message-ID: <4138b6eff8b83eb5954e84452bb84f77d42bd558.camel@mediatek.com>
Subject: Re: [PATCH v1 01/16] dt-bindings: iommu: mediatek: Increase max
 interrupt number
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 6 Jul 2022 12:03:18 +0800
In-Reply-To: <20220705204902.GA2596733-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
         <20220704100028.19932-2-tinghan.shen@mediatek.com>
         <20220705204902.GA2596733-robh@kernel.org>
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

On Tue, 2022-07-05 at 14:49 -0600, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 06:00:13PM +0800, Tinghan Shen wrote:
> > mt8195 infra iommu has max 5 interrupts.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > index 2ae3bbad7f1a..27eb9f6aa3ce 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > @@ -91,7 +91,8 @@ properties:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 5
> >  
> >    clocks:
> >      items:
> > @@ -175,9 +176,18 @@ allOf:
> >                const: mediatek,mt8195-iommu-infra
> >  
> >      then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +
> >        required:
> >          - mediatek,larbs
> >  
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 5
> 
> 5 is already the max.
> 
> minItems: 5
> 

Ok, I'll update in the next version.

Thanks,
TingHan

