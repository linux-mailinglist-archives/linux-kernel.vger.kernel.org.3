Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3F5A205C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbiHZFhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHZFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:37:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151AFCEB2A;
        Thu, 25 Aug 2022 22:36:52 -0700 (PDT)
X-UUID: 40cb4b3af52a4a089a91cbee1026d513-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vr+SHYsQa0ePNCtafTguBsuC9if01uyMQhqyKREu3S8=;
        b=RfUeec6gH6goFXeLfeBg1LHOrv+jbDkOZm5vi8EqcwGjwI/xhLV897O6OMOMuwuPT9xieKqnQdDyq4+kQPTvoRzH5OGH+V2z2nfGGkMW2lNbv3Z+7rcaylkMyRosdssX56wrK+37GpBBO6ys6KDwOxcegmJXHXtHjCVLGgg57qM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:b3e1148c-2d1f-4c76-8ba7-f5d0bc246fbe,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:0245a355-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 40cb4b3af52a4a089a91cbee1026d513-20220826
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1855589256; Fri, 26 Aug 2022 13:36:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 13:36:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Aug 2022 13:36:44 +0800
Message-ID: <1a16cce9fe164bafc06ae193310be71c6f645d75.camel@mediatek.com>
Subject: Re: [PATCH 2/7] dt-bindings: phy: mediatek,tphy: add property to
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
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Fri, 26 Aug 2022 13:36:43 +0800
In-Reply-To: <bee8abe5-0299-d05e-643c-4810aa33f978@linaro.org>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
         <20220819091344.2274-2-chunfeng.yun@mediatek.com>
         <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
         <816ecf6287533137b750c8bde9de5830e4229c56.camel@mediatek.com>
         <bee8abe5-0299-d05e-643c-4810aa33f978@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-23 at 13:24 +0300, Krzysztof Kozlowski wrote:
> On 22/08/2022 10:07, Chunfeng Yun wrote:
> > On Fri, 2022-08-19 at 15:15 +0300, Krzysztof Kozlowski wrote:
> > > On 19/08/2022 12:13, Chunfeng Yun wrote:
> > > > Add a property to set usb2 phy's pre-emphasis.
> > > > 
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7
> > > > +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > > b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > > index 848edfb1f677..aee2f3027371 100644
> > > > --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > > +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > > @@ -219,6 +219,13 @@ patternProperties:
> > > >          minimum: 1
> > > >          maximum: 15
> > > >  
> > > > +      mediatek,pre-emphasis:
> > > > +        description:
> > > > +          The selection of pre-emphasis (U2 phy)
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        minimum: 1
> > > > +        maximum: 3
> > > 
> > > Instead of hard-coding register values in bindings, you should
> > > rather
> > > describe here feature/effect. If it is in units, use unit
> > > suffixes.
> > > If
> > > it is some choice, usually string enum is appropriate.
> > 
> > How about changing description as bellow:
> > 
> > "The level of pre-emphasis, increases one level, boosts the
> > relative
> > amplitudes of signal's higher frequencies components about 4.16%
> > (U2
> > phy)"
> > 
> 
> Still the question is what is the unit. 4.16%?
No unit, it's a level value, like an index of array.

> 
> Best regards,
> Krzysztof

