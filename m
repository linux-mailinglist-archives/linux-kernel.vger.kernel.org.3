Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59C54EFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379783AbiFQCpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:45:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72BA6540C;
        Thu, 16 Jun 2022 19:45:10 -0700 (PDT)
X-UUID: 91633a5d752a45f18f98ce0cc04b95a0-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:10bce423-1e76-48f9-8b67-89e3e316ca23,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.6,REQID:10bce423-1e76-48f9-8b67-89e3e316ca23,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:b14ad71,CLOUDID:f5b7d448-4c92-421c-ad91-b806c0f58b2a,C
        OID:ebb5ecc694ff,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 91633a5d752a45f18f98ce0cc04b95a0-20220617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 282833897; Fri, 17 Jun 2022 10:45:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 10:45:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 17 Jun 2022 10:45:04 +0800
Message-ID: <08f09092a778507004509818dbe4075840b73f6e.camel@mediatek.com>
Subject: Re: [PATCH v11 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <krzysztof.kozlowski+dt@linaro.org>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <matthias.bgg@gmail.com>, <deller@gmx.de>, <airlied@linux.ie>,
        <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 17 Jun 2022 10:45:03 +0800
In-Reply-To: <20220616212813.GA3991754-robh@kernel.org>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
         <20220610105522.13449-2-rex-bc.chen@mediatek.com>
         <20220614202336.GA2400714-robh@kernel.org>
         <aeebb6879d62865f8baf037e541c568eb9310f23.camel@mediatek.com>
         <20220616212813.GA3991754-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 15:28 -0600, Rob Herring wrote:
> On Thu, Jun 16, 2022 at 09:22:16PM +0800, Rex-BC Chen wrote:
> > On Tue, 2022-06-14 at 14:23 -0600, Rob Herring wrote:
> > > On Fri, Jun 10, 2022 at 06:55:13PM +0800, Bo-Chen Chen wrote:
> > > > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > > > 
> > > > This controller is present on several mediatek hardware.
> > > > Currently
> > > > mt8195 and mt8395 have this controller without a functional
> > > > difference,
> > > > so only one compatible field is added.
> > > > 
> > > > The controller can have two forms, as a normal display port and
> > > > as
> > > > an
> > > > embedded display port.
> > > > 
> > > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > > > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > > > [Bo-Chen: Fix reviewers' comment]
> > > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > > ---
> > > >  .../display/mediatek/mediatek,dp.yaml         | 101
> > > > ++++++++++++++++++
> > > >  1 file changed, 101 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/display/mediatek/mediatek,dp.
> > > > yaml
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,d
> > > > p.ya
> > > > ml
> > > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,d
> > > > p.ya
> > > > ml
> > > > new file mode 100644
> > > > index 000000000000..10f50a0dcf49
> > > > --- /dev/null
> > > > +++
> > > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,d
> > > > p.ya
> > > > ml
> > > > @@ -0,0 +1,101 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: 
> > > > 
https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml*__;Iw!!CTRNKA9wMg0ARbw!yqAl1KhfbHqHN7-5aeqhzqeOVhPU_Z5beko5q-y-s5pcfp1WL5oVGvY5UF4EfWm4PWjc5mjBwyBUMsr_RI45ipbhsw$
> > > >  
> > > > +$schema: 
> > > > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yqAl1KhfbHqHN7-5aeqhzqeOVhPU_Z5beko5q-y-s5pcfp1WL5oVGvY5UF4EfWm4PWjc5mjBwyBUMsr_RI5WzYKENQ$
> > > >  
> > > > +
> > > > +title: MediaTek Display Port Controller
> > > > +
> > > > +maintainers:
> > > > +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > > +  - Jitao shi <jitao.shi@mediatek.com>
> > > > +
> > > > +description: |
> > > > +  Device tree bindings for the MediaTek display port and
> > > > +  embedded display port controller present on some MediaTek
> > > > SoCs.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - mediatek,mt8195-dp-tx
> > > > +      - mediatek,mt8195-edp-tx
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  nvmem-cells:
> > > > +    maxItems: 1
> > > > +    description: efuse data for display port calibration
> > > > +
> > > > +  nvmem-cell-names:
> > > > +    const: dp_calibration_data
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Input endpoint of the controller, usually
> > > > dp_intf
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Output endpoint of the controller
> > > > +
> > > > +    required:
> > > > +      - port@0
> > > > +      - port@1
> > > > +
> > > > +  max-lanes:
> > > > +    maxItems: 1
> > > > +    description: maximum number of lanes supported by the
> > > > hardware.
> > > 
> > > We already have a 'data-lanes' property defined in 
> > > 'video-interfaces.yaml' that can serve this purpose.
> > > 
> > 
> > Hello Rob,
> > 
> > Thanks for review.
> > From the description of video-interfaces.yaml, I think it's not
> > quite
> > match what we need. We only need this value be one of "1,2,4".
> 
> data-lanes = <0>;
> data-lanes = <0 1>;
> data-lanes = <0 1 2 3>;
> 
> Limiting the number of lanes to something less than the max is
> exactly 
> how this property is used in addition to being able to show the
> mapping 
> of lanes.
> 
> Rob

Hello Rob,

I modify like this:
  data-lanes:
    $ref: /schemas/media/video-interfaces.yaml#
    description: |
      number of lanes supported by the hardware.
      The possible values:
      1     - For 1 lane enabled in IP.
      1 2   - For 2 lanes enabled in IP.
      1 2 4 - For 4 lanes enabled in IP.
    minItems: 1
    maxItems: 3

example:
data-lanes = <1 2 4>;

But I encounter errorr:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.
dtb: dp_tx@1c600000: data-lanes: [[1, 2, 4]] is not of type 'object'
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.
dtb: dp_tx@1c600000: data-lanes: [[1, 2, 4]] is not of type 'object'

can you kindly give me some hint for this?

Thanks

BRs,
Bo-Chen

