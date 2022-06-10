Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F14545A15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiFJC3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiFJC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:29:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD74161F;
        Thu,  9 Jun 2022 19:29:46 -0700 (PDT)
X-UUID: d5575e0451fc4c5e9796486f5c70b842-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ae7b9115-0a13-4a52-8fc8-fbb8df3819b7,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:302dde7e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: d5575e0451fc4c5e9796486f5c70b842-20220610
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1420429129; Fri, 10 Jun 2022 10:29:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 10:29:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 10 Jun 2022 10:29:28 +0800
Message-ID: <92f634007cbdba37bf7c672e03814bdad53fa4de.camel@mediatek.com>
Subject: Re: [PATCH v10 02/21] dt-bindings: mediatek,dp: Add Display Port
 binding
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, "Helge Deller" <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
CC:     Markus Schneider-Pargmann <msp@baylibre.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Fri, 10 Jun 2022 10:29:27 +0800
In-Reply-To: <f2856b8f-9465-2638-aabf-d2dda842766b@collabora.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-3-granquet@baylibre.com>
         <f2856b8f-9465-2638-aabf-d2dda842766b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 17:30 +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 12:47, Guillaume Ranquet ha scritto:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > 
> > This controller is present on several mediatek hardware. Currently
> > mt8195 and mt8395 have this controller without a functional
> > difference,
> > so only one compatible field is added.
> > 
> > The controller can have two forms, as a normal display port and as
> > an
> > embedded display port.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> >   .../display/mediatek/mediatek,dp.yaml         | 99
> > +++++++++++++++++++
> >   1 file changed, 99 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > ml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > ml
> > new file mode 100644
> > index 000000000000..36ae0a6df299
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > ml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek Display Port Controller
> > +
> > +maintainers:
> > +  - CK Hu <ck.hu@mediatek.com>
> > +  - Jitao shi <jitao.shi@mediatek.com>
> > +
> > +description: |
> > +  Device tree bindings for the MediaTek (embedded) Display Port
> > controller
> > +  present on some MediaTek SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8195-dp-tx
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: faxi clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: faxi
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Input endpoint of the controller, usually
> > dp_intf
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Output endpoint of the controller
> > +
> 
> You should add port@0 (and port@1, probably) as required... with what
> you've done
> here, you're saying that "ports" is required, but you're allowing it
> to be empty..
> 
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Input endpoint of the controller, usually
> dp_intf
> 
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: Output endpoint of the controller
> 
>      required:
>        - port@0
>        - port@1
> 
> ^^^ that's how it should look.
> 

Hello Angelo,

ok, I will add this.

> > +  max-lanes:
> > +    maxItems: 1
> > +    description: maximum number of lanes supported by the hardware
> > +
> > +  max-linkrate:
> > +    maxItems: 1
> > +    description: maximum link rate supported by the hardware
> 
> As you've put it (in the example below), the max-linkrate property
> wants a value
> that corresponds to what you find in the HW registers... this is
> wrong.
> 
> Devicetree bindings should be generic and devicetrees shouldn't have
> hardware
> specific bits inside, hence, please change this property to accept a
> link rate
> specified in Mbps and also specify that in the description.
> 
> Thanks,
> Angelo
> 

ok, I will change it to real linkrate value.

BRs,
Bo-Chen

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - ports
> > +  - max-lanes
> > +  - max-linkrate
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/mt8195-power.h>
> > +    edp_tx: edp_tx@1c500000 {
> > +        compatible = "mediatek,mt8195-dp-tx";
> > +        reg = <0 0x1c500000 0 0x8000>;
> > +        interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
> > +        power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&edp_pin>;
> > +        max-lanes = /bits/ 8 <4>;
> > +        max-linkrate = /bits/ 8 <0x1e>;
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            port@0 {
> > +                reg = <0>;
> > +                edp_in: endpoint {
> > +                    remote-endpoint = <&dp_intf0_out>;
> > +                };
> > +            };
> > +            port@1 {
> > +                reg = <1>;
> > +                edp_out: endpoint {
> > +                	remote-endpoint = <&panel_in>;
> > +                };
> > +            };
> > +        };
> > +    };
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

