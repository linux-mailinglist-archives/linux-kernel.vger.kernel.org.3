Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C195A744D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHaDOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiHaDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:14:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE5B248A;
        Tue, 30 Aug 2022 20:14:28 -0700 (PDT)
X-UUID: 8dbefa497c1644e0961e87f2053efd36-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HdLX2cQSyS2w0LK3V/gap2eMhetpaT8GDl7EAbKntjU=;
        b=rS4RLeDKr1jo3gRGYNWCy6XcijPp5+dHKWs1L3rgL1oPgblEnE0I5q2sqaMANJ/4KGqICj9ozWsXf06JiscyABHMPGtGcOlVNOVRY46g7uuDoOXdXQjiisqAPS4LGOe42EEYvaPUps26PFizFqSRLncJH5OUzEWzqyYEO6PqXBM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:5fa23807-a385-4bec-b502-5692ceb1f785,OB:90,
        LOB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:5fa23807-a385-4bec-b502-5692ceb1f785,OB:90,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:1dd620d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:5767c5659b6e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 8dbefa497c1644e0961e87f2053efd36-20220831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1557600996; Wed, 31 Aug 2022 11:14:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 11:14:22 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Aug 2022 11:14:20 +0800
Message-ID: <d30353e4dbb785c3ce31ef54b791bfe3d23df904.camel@mediatek.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Wed, 31 Aug 2022 11:14:19 +0800
In-Reply-To: <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
         <20220829080830.5378-2-chunfeng.yun@mediatek.com>
         <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 20:38 +0300, Krzysztof Kozlowski wrote:
> On 29/08/2022 11:08, Chunfeng Yun wrote:
> > Add a property to set usb2 phy's pre-emphasis, which used to widen
> > eye
> > opening and boost eye swing.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: Add more description suggested by Krzysztof
> > ---
> >  .../devicetree/bindings/phy/mediatek,tphy.yaml         | 10
> > ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > index 848edfb1f677..e0754fb44451 100644
> > --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > @@ -219,6 +219,16 @@ patternProperties:
> >          minimum: 1
> >          maximum: 15
> >  
> > +      mediatek,pre-emphasis:
> > +        description:
> > +          The level of pre-emphasis which used to widen the eye
> > opening and
> > +          boost eye swing, the unit step is about 4.16% increment;
> > e.g. the
> > +          level 1 means amplitude increases about 4.16%, the level
> > 2 is about
> > +          8.3% etc. (U2 phy)
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> As I proposed - use instead common units. 
As explained before, no units for these value.

> Since only three values are
> allowed - make it an enum. 
Ok,

> These bindings are expected to be
> usable/applicable on several devices, so units, not register values
> which can change between devices, are the proper and reliable way to
> describe a feature.
I prefer to use exact level values, but not the inexact values with
units (e.g. -percent, -microvolt).

Thanks a lot

> 
> 
> Best regards,
> Krzysztof

