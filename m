Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2065A743A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiHaDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaDBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:01:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BBAD9B9;
        Tue, 30 Aug 2022 20:01:05 -0700 (PDT)
X-UUID: 8cd6c7c6880e441da4b3921136548305-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gV2SyRTcZm810DhGZ3x0mIBFqGbS1GVUpw4cZ3uMVFw=;
        b=hGqJ1hS7dOKFrcPQ19oy3iz47p9MPxpmS56VXqwzUM/wcWEgWTrQn352oQsbN5oxeXFUYkcRQZ2brKLHEqbYnHZFBbdICT+1l+7Ls0QTxs7x2+wn3Qep6zaqncSNE0T8qRaKgV0K0CsP/oh7M8eXAss6K5nCMqDnlFNvMs71Hno=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:14504397-b03c-4d95-b408-d597ef46da37,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:5d679f20-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8cd6c7c6880e441da4b3921136548305-20220831
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 488940980; Wed, 31 Aug 2022 11:01:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 31 Aug 2022 11:00:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Aug 2022 11:00:57 +0800
Message-ID: <8dcb4de53a52ab44d40f490099b6ed13e5ef7fe0.camel@mediatek.com>
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
Date:   Wed, 31 Aug 2022 11:00:57 +0800
In-Reply-To: <0a82842d-283c-e266-84f4-6306f29b61da@linaro.org>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
         <20220819091344.2274-2-chunfeng.yun@mediatek.com>
         <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
         <816ecf6287533137b750c8bde9de5830e4229c56.camel@mediatek.com>
         <bee8abe5-0299-d05e-643c-4810aa33f978@linaro.org>
         <1a16cce9fe164bafc06ae193310be71c6f645d75.camel@mediatek.com>
         <000babd8-5980-3d77-f156-324b3442cbe7@linaro.org>
         <114c357f8d7f049d21ede789a292a8e2d45f4c61.camel@mediatek.com>
         <0a82842d-283c-e266-84f4-6306f29b61da@linaro.org>
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

On Tue, 2022-08-30 at 13:08 +0300, Krzysztof Kozlowski wrote:
> On 29/08/2022 05:37, Chunfeng Yun wrote:
> > On Fri, 2022-08-26 at 09:36 +0300, Krzysztof Kozlowski wrote:
> > > On 26/08/2022 08:36, Chunfeng Yun wrote:
> > > > On Tue, 2022-08-23 at 13:24 +0300, Krzysztof Kozlowski wrote:
> > > > > On 22/08/2022 10:07, Chunfeng Yun wrote:
> > > > > > On Fri, 2022-08-19 at 15:15 +0300, Krzysztof Kozlowski
> > > > > > wrote:
> > > > > > > On 19/08/2022 12:13, Chunfeng Yun wrote:
> > > > > > > > Add a property to set usb2 phy's pre-emphasis.
> > > > > > > > 
> > > > > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > > > > ---
> > > > > > > >  Documentation/devicetree/bindings/phy/mediatek,tphy.ya
> > > > > > > > ml |
> > > > > > > > 7
> > > > > > > > +++++++
> > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/phy/mediatek,tphy.y
> > > > > > > > aml
> > > > > > > > b/Documentation/devicetree/bindings/phy/mediatek,tphy.y
> > > > > > > > aml
> > > > > > > > index 848edfb1f677..aee2f3027371 100644
> > > > > > > > ---
> > > > > > > > a/Documentation/devicetree/bindings/phy/mediatek,tphy.y
> > > > > > > > aml
> > > > > > > > +++
> > > > > > > > b/Documentation/devicetree/bindings/phy/mediatek,tphy.y
> > > > > > > > aml
> > > > > > > > @@ -219,6 +219,13 @@ patternProperties:
> > > > > > > >          minimum: 1
> > > > > > > >          maximum: 15
> > > > > > > >  
> > > > > > > > +      mediatek,pre-emphasis:
> > > > > > > > +        description:
> > > > > > > > +          The selection of pre-emphasis (U2 phy)
> > > > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > +        minimum: 1
> > > > > > > > +        maximum: 3
> > > > > > > 
> > > > > > > Instead of hard-coding register values in bindings, you
> > > > > > > should
> > > > > > > rather
> > > > > > > describe here feature/effect. If it is in units, use unit
> > > > > > > suffixes.
> > > > > > > If
> > > > > > > it is some choice, usually string enum is appropriate.
> > > > > > 
> > > > > > How about changing description as bellow:
> > > > > > 
> > > > > > "The level of pre-emphasis, increases one level, boosts the
> > > > > > relative
> > > > > > amplitudes of signal's higher frequencies components about
> > > > > > 4.16%
> > > > > > (U2
> > > > > > phy)"
> > > > > > 
> > > > > 
> > > > > Still the question is what is the unit. 4.16%?
> > > > 
> > > > No unit, it's a level value, like an index of array.
> > > > 
> > > 
> > > So a value from register/device programming? 
> > 
> > Yes
> > > Rather a regular units
> > > should be used if that's possible. If not, this should be clearly
> > > described here, not some magical number which you encode into
> > > DTS...
> > 
> > Ok, I'll add more descriptions.
> 
> Better use logical value, e.g.
> 
https://urldefense.com/v3/__https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml*L38__;Iw!!CTRNKA9wMg0ARbw!1e-h0R_uwcaHKfKC9qYfaRWYeuWRq1sLCGy3yupNmkFyuW5s1nmRotL7Y0vFG9ETLLTA$
>  
Optional unit may be -percent or -bp, but the value 4.16% * X
(X=1,2,3...)is not an exact value, they are variable in a range and
dependent more factors.
So I think use level value is simple enough.

> 
> Best regards,
> Krzysztof

