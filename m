Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3853215F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiEXDDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiEXDDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:03:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E389CF35;
        Mon, 23 May 2022 20:02:56 -0700 (PDT)
X-UUID: 83d60a8da88542c1912ccf4f1b894b26-20220524
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a2c89178-509a-4d1f-b0e6-3b9f279a5dc0,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:56
X-CID-INFO: VERSION:1.1.5,REQID:a2c89178-509a-4d1f-b0e6-3b9f279a5dc0,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:56
X-CID-META: VersionHash:2a19b09,CLOUDID:b354607a-5ef6-470b-96c9-bdb8ced32786,C
        OID:90cd12a4af7b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 83d60a8da88542c1912ccf4f1b894b26-20220524
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1262230492; Tue, 24 May 2022 11:02:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 24 May 2022 11:02:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 24 May 2022 11:02:44 +0800
Message-ID: <45e49226ddbe44a5205f015c4c80e49239c5d9aa.camel@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: usb: mtk-xhci: add support 'resets'
 property
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Tue, 24 May 2022 11:02:43 +0800
In-Reply-To: <40eb8f7ed5b5d6dc3aeb5b82e04986049a2e47f3.camel@mediatek.com>
References: <20220523090449.14430-1-chunfeng.yun@mediatek.com>
         <40eb8f7ed5b5d6dc3aeb5b82e04986049a2e47f3.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex-BC,

On Mon, 2022-05-23 at 18:41 +0800, Rex-BC Chen wrote:
> On Mon, 2022-05-23 at 17:04 +0800, Chunfeng Yun wrote:
> > Add 'resets' property to support IP reset usually by top pericfg.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 3
> > +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > xhci.yaml
> > index 084d7135b2d9..892718459d25 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> > @@ -113,6 +113,9 @@ properties:
> >    vbus-supply:
> >      description: Regulator of USB VBUS5v
> >  
> > +  resets:
> > +    maxItems: 1
> > +
> >    usb3-lpm-capable: true
> >  
> >    usb2-lpm-disable: true
> 
> Hello Chunfeng,
> 
> Which soc we will use this reset?
This is common for all SoCs, can use it if there is a reset controller
driver supported.

> I am upstreaming another series for system clock reset.
That's good
> I think you should add how to use for this series base on [1].
Currently I test it on mt8195 based on ti-syscon reset driver, luckly
this is transparent for our usb controller drivers;

I could add patches to use this 'resets' property on mt8195/8186 if the
below series are applied.

Thanks

> 
> [1]: 
> 
https://lore.kernel.org/linux-clk/5067ec46-7a82-6b7b-5b07-3102cfaefbf6@collabora.com/T/#m5b6abb9bd2109e4ed9a1a3eeee6e7976892cb8c2
> 
> BRs,
> Rex
> 

