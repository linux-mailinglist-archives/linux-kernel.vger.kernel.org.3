Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1455C153
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbiF1CsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245465AbiF1Cra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:47:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D938BE;
        Mon, 27 Jun 2022 19:42:57 -0700 (PDT)
X-UUID: 1553b68d0833425089c4035f120b5932-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:37f521c1-64e3-4d9e-abf0-405f08e37050,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:87442a2,CLOUDID:b33ef085-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 1553b68d0833425089c4035f120b5932-20220628
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1812030426; Tue, 28 Jun 2022 10:42:54 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Jun 2022 10:42:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jun 2022 10:42:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 28 Jun 2022 10:42:54 +0800
Message-ID: <b025e0ffdedc46df69b08d39c1615d75c09f0774.camel@mediatek.com>
Subject: Re: [PATCH v14 01/15] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 28 Jun 2022 10:42:53 +0800
In-Reply-To: <5a5d11158dd45355e5e6c3b5decbe41495bd19ad.camel@mediatek.com>
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
         <20220624030946.14961-2-rex-bc.chen@mediatek.com>
         <a2612c2628eefbbf909d4847b3d0067746813f33.camel@mediatek.com>
         <5a5d11158dd45355e5e6c3b5decbe41495bd19ad.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-27 at 17:07 +0800, Rex-BC Chen wrote:
> On Mon, 2022-06-27 at 15:50 +0800, CK Hu wrote:
> > Hi, Bo-Chen:
> > 
> > On Fri, 2022-06-24 at 11:09 +0800, Bo-Chen Chen wrote:
> > > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > > 
> > > DP_INTF is similar to DPI but does not have the exact same
> > > feature
> > > set
> > > or register layouts.
> > > 
> > > DP_INTF is the sink of the display pipeline that is connected to
> > > the
> > > DisplayPort controller and encoder unit. It takes the same clocks
> > > as
> > > DPI.
> > > 
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > > [Bo-Chen: Modify reviewers' comments.]
> > 
> > Except this line,
> > 
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > 
> 
> Hello CK,
> 
> What do you mean?
> Do you mean I should drop this line?

Yes, drop this line. I think every patch is reviewed and modified, so
this line is redundant.

Regards,
CK

> 
> BRs,
> Bo-Chen
> > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11
> > > ++++++-
> > > --
> > > --
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > index 77ee1b923991..8e526a4b134e 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > +++
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > @@ -4,16 +4,16 @@
> > >  $id: 
> > > http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
> > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  
> > > -title: mediatek DPI Controller Device Tree Bindings
> > > +title: mediatek DPI and DP_INTF Controller
> > >  
> > >  maintainers:
> > >    - CK Hu <ck.hu@mediatek.com>
> > >    - Jitao shi <jitao.shi@mediatek.com>
> > >  
> > >  description: |
> > > -  The Mediatek DPI function block is a sink of the display
> > > subsystem
> > > and
> > > -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on
> > > a
> > > parallel
> > > -  output bus.
> > > +  The Mediatek DPI and DP_INTF function blocks are a sink of the
> > > display
> > > +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422
> > > pixel data on a
> > > +  parallel output bus.
> > >  
> > >  properties:
> > >    compatible:
> > > @@ -24,6 +24,7 @@ properties:
> > >        - mediatek,mt8183-dpi
> > >        - mediatek,mt8186-dpi
> > >        - mediatek,mt8192-dpi
> > > +      - mediatek,mt8195-dp-intf
> > >  
> > >    reg:
> > >      maxItems: 1
> > > @@ -55,7 +56,7 @@ properties:
> > >      $ref: /schemas/graph.yaml#/properties/port
> > >      description:
> > >        Output port node. This port should be connected to the
> > > input
> > > port of an
> > > -      attached HDMI or LVDS encoder chip.
> > > +      attached HDMI, LVDS or DisplayPort encoder chip.
> > >  
> > >  required:
> > >    - compatible
> > 
> > 
> 
> 

