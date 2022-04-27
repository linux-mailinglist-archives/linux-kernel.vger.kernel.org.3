Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F017510EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357248AbiD0Cuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiD0Cut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:50:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF4D3998;
        Tue, 26 Apr 2022 19:47:39 -0700 (PDT)
X-UUID: ef712cf26dde4d43bbb73ab6da977215-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:da72a8a6-318d-4d08-81ad-13708525bc0c,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:3cccd22e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ef712cf26dde4d43bbb73ab6da977215-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1458618100; Wed, 27 Apr 2022 10:47:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 10:47:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 10:47:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 10:47:28 +0800
Message-ID: <2fe82b5743786744432c44115122b60b762561de.camel@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: add power and
 gce properties
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nancy.lin@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 27 Apr 2022 10:47:28 +0800
In-Reply-To: <Ymg6dn3PotTeWbqF@robh.at.kernel.org>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
         <20220419033237.23405-2-rex-bc.chen@mediatek.com>
         <Ymg6dn3PotTeWbqF@robh.at.kernel.org>
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

Hi Rob,

Thanks for the reviews.
Since this patch has already applied in:

https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.18-next/soc&id=1da90b8a7bae09358569dba26e784d1f471b4aa0

I'll send a fixup-patch for your commnet.

On Tue, 2022-04-26 at 13:31 -0500, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 11:32:33AM +0800, Rex-BC Chen wrote:
> > From: "jason-jh.lin" <jason-jh.lin@mediatek.com>
> > 
> > Power:
> > 1. Add description for power-domains property.
> > 
> > GCE:
> > 1. Add description for mboxes property.
> > 2. Add description for mediatek,gce-client-reg property.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 31
> > +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > index b31d90dc9eb4..6c2c3edcd443 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > @@ -41,6 +41,30 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  power-domains:
> 
> How many and what are they.
> 
maxItems: 1
description:
  Each mmsys belongs to a power-domains, so we can add the power-
  domains property to make it clearer, and also bind to the power
  controller.

> > +    description:
> > +      A phandle and PM domain specifier as defined by bindings
> > +      of the power controller specified by phandle. See
> > +      Documentation/devicetree/bindings/power/power-domain.yaml
> > for details.
> 
> Drop. Don't need generic descriptions of common properties.
> 
OK, I'll drop this.

> > +
> > +  mboxes:
> 
> How many?
> 
minItems: 1

> > +    description:
> > +      Using mailbox to communicate with GCE, it should have this
> 
> If using?
> 
description:
  If using mailbox to communicate with GCE, it should have this
  property. GCE will help configure the hardware settings for the
  current mmsys data pipeline.

> > +      property and list of phandle, mailbox specifiers. See
> > +      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for
> > details.
> 
> Drop
> 
OK, I'll drop this.

> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Already has a type.
> 
OK, I'll drop this.

> > +
> > +  mediatek,gce-client-reg:
> > +    description:
> > +      The register of client driver can be configured by gce with
> > 4 arguments
> > +      defined in this property, such as phandle of gce, subsys id,
> > +      register offset and size.
> > +      Each subsys id is mapping to a base address of display
> > function blocks
> > +      register which is defined in the gce header
> > +      include/dt-bindings/gce/<chip>-gce.h.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    maxItems: 1
> 
> This needs to define exact sizes.
> 
> items:
>   - items:
>       - description: phandle to GCE
>       - description: subsy id
>       - description: register offset
>       - description: register size
> 
OK, I'll fix it like this:

mediatek,gce-client-reg:
  minItems: 1
  items:
    - items:
        - description: phandle to GCE
        - description: subsys id
        - description: register offset
        - description: register size


Regards,
Jason-JH.Lin

> > +
> >    "#clock-cells":
> >      const: 1
> >  
> > @@ -56,9 +80,16 @@ additionalProperties: false
> >  
> >  examples:
> >    - |
> > +    #include <dt-bindings/power/mt8173-power.h>
> > +    #include <dt-bindings/gce/mt8173-gce.h>
> > +
> >      mmsys: syscon@14000000 {
> >          compatible = "mediatek,mt8173-mmsys", "syscon";
> >          reg = <0x14000000 0x1000>;
> > +        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
> >          #clock-cells = <1>;
> >          #reset-cells = <1>;
> > +        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> > +                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> > +        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
> >      };
> > -- 
> > 2.18.0
> > 
> > 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

