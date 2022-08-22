Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7EF59BA01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiHVHHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:07:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99971571A;
        Mon, 22 Aug 2022 00:07:44 -0700 (PDT)
X-UUID: 50fc1ce3795b4be489394a37efba0651-20220822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CJugcxX+eOv/HfKlyYUWU1xq3Wn9o4AB7EJIdNcHq8s=;
        b=L4nWy9VxoGQHC/NJGrG++HhulEfCnS9PIJJUJHMv2Yb/km6Ou2i/q3ABgKmgit6sLwqqS5hPMqIth2ylxKT4sr9e7X/Dg2WDz8VK80aX8nAAlV67kMdA4U6qfAtddoilBb2k2bGN7xIz2AQotEpZxaHziFaYvuGDJ+LEJHvI9Vs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:caa3ca08-8164-4377-bca8-79cef37653a1,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:63e3e667-a9d9-4672-a3c8-12721739a220,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 50fc1ce3795b4be489394a37efba0651-20220822
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 628881890; Mon, 22 Aug 2022 15:07:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 22 Aug 2022 15:07:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Aug 2022 15:07:35 +0800
Message-ID: <816ecf6287533137b750c8bde9de5830e4229c56.camel@mediatek.com>
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
Date:   Mon, 22 Aug 2022 15:07:35 +0800
In-Reply-To: <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
         <20220819091344.2274-2-chunfeng.yun@mediatek.com>
         <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 15:15 +0300, Krzysztof Kozlowski wrote:
> On 19/08/2022 12:13, Chunfeng Yun wrote:
> > Add a property to set usb2 phy's pre-emphasis.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > index 848edfb1f677..aee2f3027371 100644
> > --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > @@ -219,6 +219,13 @@ patternProperties:
> >          minimum: 1
> >          maximum: 15
> >  
> > +      mediatek,pre-emphasis:
> > +        description:
> > +          The selection of pre-emphasis (U2 phy)
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 1
> > +        maximum: 3
> 
> Instead of hard-coding register values in bindings, you should rather
> describe here feature/effect. If it is in units, use unit suffixes.
> If
> it is some choice, usually string enum is appropriate.
How about changing description as bellow:

"The level of pre-emphasis, increases one level, boosts the relative
amplitudes of signal's higher frequencies components about 4.16% (U2
phy)"

Thanks

> 
> Best regards,
> Krzysztof

