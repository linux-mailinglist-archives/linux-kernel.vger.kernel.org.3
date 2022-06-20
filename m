Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50175518FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiFTMdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiFTMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4080BE9;
        Mon, 20 Jun 2022 05:33:14 -0700 (PDT)
X-UUID: da510f831bb5432c9585aded68ee28db-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2f14da5f-b24a-459f-8e72-514307cb67e7,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:b14ad71,CLOUDID:9a7303ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: da510f831bb5432c9585aded68ee28db-20220620
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1784198173; Mon, 20 Jun 2022 20:33:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 20 Jun 2022 20:33:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 20:33:07 +0800
Message-ID: <d5a74aca024dd38030bb5edd38084d81b65e27fa.camel@mediatek.com>
Subject: Re: [PATCH v12 01/14] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>, <devicetree@vger.kernel.org>,
        <granquet@baylibre.com>, <jitao.shi@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <msp@baylibre.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <wenst@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>
Date:   Mon, 20 Jun 2022 20:33:07 +0800
In-Reply-To: <20220620122500.yfc5vhbuluodoo3d@houat>
References: <20220620121028.29234-1-rex-bc.chen@mediatek.com>
         <20220620121028.29234-2-rex-bc.chen@mediatek.com>
         <20220620122500.yfc5vhbuluodoo3d@houat>
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

On Mon, 2022-06-20 at 14:25 +0200, Maxime Ripard wrote:
> On Mon, Jun 20, 2022 at 08:10:15PM +0800, Bo-Chen Chen wrote:
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
> > [Bo-Chen: Modify reviewers' comments.]
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-
> > ----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > index 77ee1b923991..d72f74632038 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y
> > aml
> > @@ -4,16 +4,16 @@
> >  $id: 
> > http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
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
> 
> Underscores are frowned upon in the compatibles. See Section 2.3.1 of
> the device tree spec:
> 
> > The compatible string should consist only of lowercase letters,
> > digits
> > and dashes, and should start with a letter. A single comma is
> > typically only used following a vendor prefix. Underscores should
> > not
> > be used.
> 
> Maxime

Hello Maxime,

Thanks for review.
I will modify this compatible as "mediatek,mt8195-dp-intf"

BRs,
Bo-Chen

