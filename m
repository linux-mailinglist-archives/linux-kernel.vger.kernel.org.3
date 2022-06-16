Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8654DC41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359074AbiFPHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFPHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:55:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DCE5D5EE;
        Thu, 16 Jun 2022 00:55:21 -0700 (PDT)
X-UUID: e67a4176bfc347868cdedd6f42d8d9c5-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:6f1f3cac-79b5-4396-ab20-ffa9c79d57b5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:2ba2b848-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e67a4176bfc347868cdedd6f42d8d9c5-20220616
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2139800384; Thu, 16 Jun 2022 15:55:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 15:55:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 16 Jun 2022 15:55:13 +0800
Message-ID: <90c2468228499acc88967aa48d9442abb63b5336.camel@mediatek.com>
Subject: Re: [PATCH v11 01/12] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>, <msp@baylibre.com>,
        <granquet@baylibre.com>, <jitao.shi@mediatek.com>,
        <wenst@chromium.org>, <angelogioacchino.delregno@collabora.com>,
        <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 16 Jun 2022 15:55:13 +0800
In-Reply-To: <20220614202455.GA2415891-robh@kernel.org>
References: <20220613064841.10481-1-rex-bc.chen@mediatek.com>
         <20220613064841.10481-2-rex-bc.chen@mediatek.com>
         <20220614202455.GA2415891-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 14:24 -0600, Rob Herring wrote:
> On Mon, Jun 13, 2022 at 02:48:30PM +0800, Bo-Chen Chen wrote:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > 
> > DP_INTF is similar to DPI but does not have the exact same feature
> > set
> > or register layouts.
> > 
> > DP_INTF is the sink of the display pipeline that is connected to
> > the
> > DisplayPort controller and encoder unit. It takes the same clocks
> > as
> > DPI.
> > 
> > In this patch, we also do these string replacement:
> > - s/mediatek/MediaTek/ in title.
> > - s/Mediatek/MediaTek/ in description.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-
> > ----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > index 77ee1b923991..ca1b48e78581 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > @@ -4,16 +4,16 @@
> >  $id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml*__;Iw!!CTRNKA9wMg0ARbw!0wzvKisC8j2vSMbYtNhgV1niXflyQgVHmgSPCVo94UQV-GiFqhMtdoowjpgIYMXH8wDn$
> >  
> >  $schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!0wzvKisC8j2vSMbYtNhgV1niXflyQgVHmgSPCVo94UQV-GiFqhMtdoowjpgIYEfMUrSk$
> >  
> >  
> > -title: mediatek DPI Controller Device Tree Bindings
> > +title: MediaTek DPI and DP_INTF Controller
> >  
> >  maintainers:
> >    - CK Hu <ck.hu@mediatek.com>
> >    - Jitao shi <jitao.shi@mediatek.com>
> >  
> >  description: |
> > -  The Mediatek DPI function block is a sink of the display
> > subsystem and
> > -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
> > parallel
> > -  output bus.
> > +  The MediaTek DPI and DP_INTF function blocks are a sink of the
> > display
> > +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422
> > pixel data on a
> > +  parallel output bus.
> >  
> >  properties:
> >    compatible:
> > @@ -24,6 +24,7 @@ properties:
> >        - mediatek,mt8183-dpi
> >        - mediatek,mt8186-dpi
> >        - mediatek,mt8192-dpi
> > +      - mediatek,mt8195-dp_intf
> >  
> >    reg:
> >      maxItems: 1
> > @@ -36,12 +37,14 @@ properties:
> >        - description: Pixel Clock
> >        - description: Engine Clock
> >        - description: DPI PLL
> > +      - description: Clock gate for PLL
> >  
> >    clock-names:
> >      items:
> >        - const: pixel
> >        - const: engine
> >        - const: pll
> > +      - const: pll_gate
> 
> You just added a new required clock for everyone.
> 

Hello Rob,

We can remove this clock and using clock framework to enable this pll
gate, so I will remove this in next version.

BRs,
Bo-Chen

> >  
> >    pinctrl-0: true
> >    pinctrl-1: true
> > @@ -55,7 +58,7 @@ properties:
> >      $ref: /schemas/graph.yaml#/properties/port
> >      description:
> >        Output port node. This port should be connected to the input
> > port of an
> > -      attached HDMI or LVDS encoder chip.
> > +      attached HDMI, LVDS or DisplayPort encoder chip.
> >  
> >  required:
> >    - compatible
> > -- 
> > 2.18.0
> > 
> > 

