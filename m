Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0F514134
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiD2ENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2ENn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:13:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038227B0C;
        Thu, 28 Apr 2022 21:10:19 -0700 (PDT)
X-UUID: 97af7ee49a79401f98805bc78b2b5ada-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:39e446d9-861c-4177-a517-198e241cf7fd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:7eb2e8c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 97af7ee49a79401f98805bc78b2b5ada-20220429
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1756898602; Fri, 29 Apr 2022 12:10:14 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 12:10:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 12:10:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 12:10:13 +0800
Message-ID: <60338c26047f47c77fdc7d4eff6a7dee43853e1b.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: refine power and gce
 properties
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Fabien Parent <fparent@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 29 Apr 2022 12:10:13 +0800
In-Reply-To: <b7bb228f-751c-e7ad-a695-3dc40d889a72@linaro.org>
References: <20220428012715.2619-1-jason-jh.lin@mediatek.com>
         <b7bb228f-751c-e7ad-a695-3dc40d889a72@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the reviews.

On Thu, 2022-04-28 at 09:16 +0200, Krzysztof Kozlowski wrote:
> On 28/04/2022 03:27, jason-jh.lin wrote:
> > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > 
> > Power:
> >   Refine description and add item number for power-domains
> > property.
> > 
> > GCE:
> >   Refine description and add item number for mboxes property and
> >   mediatek,gce-client-reg property.
> > 
> > Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power
> > and gce properties")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 29 +++++++++----
> > ------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > index 6ad023eec193..6722f1b724ef 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > @@ -43,28 +43,27 @@ properties:
> >      maxItems: 1
> >  
> >    power-domains:
> > +    maxItems: 1
> >      description:
> > -      A phandle and PM domain specifier as defined by bindings
> > -      of the power controller specified by phandle. See
> > -      Documentation/devicetree/bindings/power/power-domain.yaml
> > for details.
> > +      Each mmsys belongs to a power-domains. If mmsys wants to use
> > PM
> > +      interface to control the power controller of mmsys, it
> > should have
> > +      this property.
> >  
> >    mboxes:
> > +    minItems: 1
> 
> maxItems, surely you cannot have infinite number of mailboxes to talk
> with?

Yes, we cannot have infinite number for this, but we can use not only
one mbox channel for one mmsys.

Its maximum number is equal to GCE HW thread number.
The maximum number in mt8195 is 24 and mt8173 is 16.

But we currently using 1.
So I'm not sure if I need to set the maxItems for this?

> 
> >      description:
> > -      Using mailbox to communicate with GCE, it should have this
> > -      property and list of phandle, mailbox specifiers. See
> > -      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for
> > details.
> > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +      If using mailbox to communicate with GCE, it should have
> > this
> > +      property. GCE will help configure the hardware settings for
> > the
> > +      current mmsys data pipeline.
> >  
> >    mediatek,gce-client-reg:
> > -    description:
> > -      The register of client driver can be configured by gce with
> > 4 arguments
> > -      defined in this property, such as phandle of gce, subsys id,
> > -      register offset and size.
> > -      Each subsys id is mapping to a base address of display
> > function blocks
> > -      register which is defined in the gce header
> > -      include/dt-bindings/gce/<chip>-gce.h.
> > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Why removing ref? Does your binding work after such change?

I removed it unexpectedly, I'll add it back.
> 
> >      maxItems: 1
> > +    items:
> > +      - items:
> > +          - description: phandle to GCE
> > +          - description: subsys id
> > +          - description: register offset
> > +          - description: register size
> >  
> >    "#clock-cells":
> >      const: 1
> 
> 
> Best regards,
> Krzysztof

Regards,
Jason-JH.Lin
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

