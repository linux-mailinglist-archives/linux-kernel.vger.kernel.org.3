Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE54E8C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiC1DbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiC1DbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:31:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C750A1B1;
        Sun, 27 Mar 2022 20:29:32 -0700 (PDT)
X-UUID: ef2f024e960a44cbb8fc45a148b95aea-20220328
X-UUID: ef2f024e960a44cbb8fc45a148b95aea-20220328
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 770176710; Mon, 28 Mar 2022 11:29:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Mar 2022 11:29:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 11:29:24 +0800
Message-ID: <f52fbaec28ae53667ba101a05406b62e5970eec1.camel@mediatek.com>
Subject: Re: [PATCH v16 3/8] dt-bindings: arm: mediatek: mmsys: add mt8195
 SoC binding
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <hsinyi@chromium.org>, <fshao@chromium.org>,
        <moudy.ho@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 28 Mar 2022 11:29:24 +0800
In-Reply-To: <1daa3b8dabb97017d0f92437a81b250f8375544c.camel@mediatek.com>
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
         <20220307032859.3275-4-jason-jh.lin@mediatek.com>
         <1daa3b8dabb97017d0f92437a81b250f8375544c.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Thanks for the reviews.

On Fri, 2022-03-18 at 14:43 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Mon, 2022-03-07 at 11:28 +0800, jason-jh.lin wrote:
> > There are 2 mmsys, namely vdosys0 and vdosys1 in mt8195.
> > Each of them is bound to a display pipeline, so add their
> > definition in mtk-mmsys documentation with 2 compatibles.
> 
> Could one vdosys be union of vdosys0 and vdosys1? In MT8173, one
> mmsys
> support multiple pipeline. Describe more in commit message to support
> that two vdosys are necessary.
> 
> Regards,
> CK
> 

In the SoC before, such as mt8173, it has 2 pipelines binding to one
mmsys with the same clock driver and the same power domain.

In mt8195, 2 pipelines are binding to different mmsys, such as vdosys0
and vdosys1. Each mmsys uses different clock drivers and different
power domain.

Since each mmsys has its own clock, I have tried to differentiate
vppsys0, vppsys1, vdosys0, vdosys1 by the clock names.
Then I can use one mmsys compatible name for all of them.

I'll apply this method at the next version.
And also sync with Nancy(vdosys1) and Roy(vppsys0, vppsys1).

Regards,
Jason-JH.Lin

> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > ---
> >  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        |
> > 2
> > ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > index 6c2c3edcd443..c5ba515cb0d7 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > l
> > @@ -32,6 +32,8 @@ properties:
> >                - mediatek,mt8186-mmsys
> >                - mediatek,mt8192-mmsys
> >                - mediatek,mt8365-mmsys
> > +              - mediatek,mt8195-vdosys0
> > +              - mediatek,mt8195-vdosys1
> >            - const: syscon
> >        - items:
> >            - const: mediatek,mt7623-mmsys
> 
> 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

