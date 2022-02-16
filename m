Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A764B842F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiBPJY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:24:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiBPJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:24:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3B215C1B;
        Wed, 16 Feb 2022 01:24:03 -0800 (PST)
X-UUID: ffdfb0fbf316421c87b5923101cf081a-20220216
X-UUID: ffdfb0fbf316421c87b5923101cf081a-20220216
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1809854372; Wed, 16 Feb 2022 17:23:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 17:23:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 17:23:49 +0800
Message-ID: <3991ff9a505630b90acb4e720a6b73e055347257.camel@mediatek.com>
Subject: Re: [PATCH v3, 2/5] dt-bindings: display: mediatek: add MT8186 SoC
 binding
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <airlied@linux.ie>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <yongqiang.niu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fparent@baylibre.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 16 Feb 2022 17:23:49 +0800
In-Reply-To: <4436154a38bfe7213299a578ff148d9f8223e101.camel@mediatek.com>
References: <20220216084831.14883-1-rex-bc.chen@mediatek.com>
         <20220216084831.14883-3-rex-bc.chen@mediatek.com>
         <4436154a38bfe7213299a578ff148d9f8223e101.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello CK,

Thanks for your review.
I write the reply comments below:

On Wed, 2022-02-16 at 17:17 +0800, CK Hu wrote:
> Hi, Rex:
> 
> On Wed, 2022-02-16 at 16:48 +0800, Rex-BC Chen wrote:
> > Add MT8186 SoC binding to AAL, CCORR, COLOR, DITHER, DPI, DSI,
> > GAMMA, MUTEX, OVL, POSTMASK and RDMA.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml   | 1 +
> >  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 5
> > +++++
> >  .../devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
> >  .../bindings/display/mediatek/mediatek,dither.yaml           | 1 +
> >  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml   | 1 +
> >  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt    | 2
> > +-
> >  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
> >  .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml | 2
> > ++
> >  .../bindings/display/mediatek/mediatek,ovl-2l.yaml           | 5
> > +++++
> >  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml   | 5
> > +++++
> >  .../bindings/display/mediatek/mediatek,postmask.yaml         | 5
> > +++++
> >  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml  | 1 +
> >  12 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > am
> > l
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > am
> > l
> > index 225f9dd726d2..7c27f61f336b 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > am
> > l
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > am
> > l
> > @@ -27,6 +27,7 @@ properties:
> >            - enum:
> >                - mediatek,mt2712-disp-aal
> >                - mediatek,mt8183-disp-aal
> > +              - mediatek,mt8186-disp-aal
> >                - mediatek,mt8192-disp-aal
> >                - mediatek,mt8195-disp-aal
> >            - enum:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr
> > .y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr
> > .y
> > aml
> > index 6894b6999412..8ac87b5896ac 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr
> > .y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr
> > .y
> > aml
> > @@ -30,6 +30,11 @@ properties:
> >                - mediatek,mt8195-disp-ccorr
> >            - enum:
> >                - mediatek,mt8192-disp-ccorr
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8186-disp-ccorr
> > +          - enum:
> > +              - mediatek,mt8183-disp-ccorr
> >  
> >    reg:
> >      maxItems: 1
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,color
> > .y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,color
> > .y
> > aml
> > index bc83155b3b4c..d0a4b9eb71fd 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,color
> > .y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,color
> > .y
> > aml
> > @@ -37,6 +37,7 @@ properties:
> >        - items:
> >            - enum:
> >                - mediatek,mt8183-disp-color
> > +              - mediatek,mt8186-disp-color
> >                - mediatek,mt8192-disp-color
> >                - mediatek,mt8195-disp-color
> >            - enum:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dithe
> > r.
> > yaml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dithe
> > r.
> > yaml
> > index 9d89297f5f1d..9a08514ed909 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dithe
> > r.
> > yaml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dithe
> > r.
> > yaml
> > @@ -26,6 +26,7 @@ properties:
> >            - const: mediatek,mt8183-disp-dither
> >        - items:
> >            - enum:
> > +              - mediatek,mt8186-disp-dither
> >                - mediatek,mt8192-disp-dither
> >                - mediatek,mt8195-disp-dither
> >            - enum:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > am
> > l
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > am
> > l
> > index dd2896a40ff0..a73044c50b5f 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > am
> > l
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > am
> > l
> > @@ -22,6 +22,7 @@ properties:
> >        - mediatek,mt7623-dpi
> >        - mediatek,mt8173-dpi
> >        - mediatek,mt8183-dpi
> > +      - mediatek,mt8186-dpi
> >        - mediatek,mt8192-dpi
> >  
> >    reg:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t
> > xt
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t
> > xt
> > index 36b01458f45c..c82b8b20de15 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t
> > xt
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t
> > xt
> > @@ -7,7 +7,7 @@ channel output.
> >  
> >  Required properties:
> >  - compatible: "mediatek,<chip>-dsi"
> > -- the supported chips are mt2701, mt7623, mt8167, mt8173 and
> > mt8183.
> > +- the supported chips are mt2701, mt7623, mt8167, mt8173, mt8183
> > and
> 
> This is done in [1], and Xinlei has planed to transfer to yaml
> format,
> so I think you could remove this from this patch.
> 
> [1] 
> 
https://patchwork.kernel.org/project/linux-mediatek/patch/1643283773-7081-2-git-send-email-xinlei.lee@mediatek.com/
> 
> Regards,
> CK

OK.
I think Xinlei will also push another series for MT8186 DPI.
I will remove binding of DPI and DSI in next version.

BRs,
Rex
> 
> > mt8186.
> >  - reg: Physical base address and length of the controller's
> > registers
> >  - interrupts: The interrupt signal from the function block.
> >  - clocks: device clocks
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma
> > .y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma
> > .y
> > aml
> > index 247baad147b3..6d96f6736d91 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma
> > .y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma
> > .y
> > aml
> > @@ -27,6 +27,7 @@ properties:
> >            - const: mediatek,mt8183-disp-gamma
> >        - items:
> >            - enum:
> > +              - mediatek,mt8186-disp-gamma
> >                - mediatek,mt8192-disp-gamma
> >                - mediatek,mt8195-disp-gamma
> >            - enum:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex
> > .y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex
> > .y
> > aml
> > index 6eca525eced0..55391b5c08c4 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex
> > .y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex
> > .y
> > aml
> > @@ -34,6 +34,8 @@ properties:
> >            - const: mediatek,mt8173-disp-mutex
> >        - items:
> >            - const: mediatek,mt8183-disp-mutex
> > +      - items:
> > +          - const: mediatek,mt8186-disp-mutex
> >        - items:
> >            - const: mediatek,mt8192-disp-mutex
> >        - items:
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-
> > 2l.yaml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-
> > 2l.yaml
> > index 611a2dbdefa4..f7f89485a5ae 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-
> > 2l.yaml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-
> > 2l.yaml
> > @@ -25,6 +25,11 @@ properties:
> >            - const: mediatek,mt8183-disp-ovl-2l
> >        - items:
> >            - const: mediatek,mt8192-disp-ovl-2l
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8186-disp-ovl-2l
> > +          - enum:
> > +              - mediatek,mt8192-disp-ovl-2l
> >  
> >    reg:
> >      maxItems: 1
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.y
> > am
> > l
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.y
> > am
> > l
> > index e71f79bc2dee..110e6b2747bc 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.y
> > am
> > l
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.y
> > am
> > l
> > @@ -40,6 +40,11 @@ properties:
> >                - mediatek,mt8195-disp-ovl
> >            - enum:
> >                - mediatek,mt8183-disp-ovl
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8186-disp-ovl
> > +          - enum:
> > +              - mediatek,mt8192-disp-ovl
> >  
> >    reg:
> >      maxItems: 1
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,postm
> > as
> > k.yaml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,postm
> > as
> > k.yaml
> > index 6ac1da2e8871..22c333d09465 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,postm
> > as
> > k.yaml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,postm
> > as
> > k.yaml
> > @@ -23,6 +23,11 @@ properties:
> >      oneOf:
> >        - items:
> >            - const: mediatek,mt8192-disp-postmask
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8186-disp-postmask
> > +          - enum:
> > +              - mediatek,mt8192-disp-postmask
> >  
> >    reg:
> >      maxItems: 1
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.
> > ya
> > ml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.
> > ya
> > ml
> > index 8ef821641672..4f1c935cdf70 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.
> > ya
> > ml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.
> > ya
> > ml
> > @@ -39,6 +39,7 @@ properties:
> >                - mediatek,mt2701-disp-rdma
> >        - items:
> >            - enum:
> > +              - mediatek,mt8186-disp-rdma
> >                - mediatek,mt8192-disp-rdma
> >            - enum:
> >                - mediatek,mt8183-disp-rdma
> 
> 

