Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82328542640
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiFHFFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiFHFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:04:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392082F5AB1;
        Tue,  7 Jun 2022 19:01:11 -0700 (PDT)
X-UUID: 615c14f2172546908266de47d8ef9d93-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:2faf8ae7-34bb-4bfa-aed5-1d014ce4d1f1,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:1c0703e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 615c14f2172546908266de47d8ef9d93-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 270279625; Wed, 08 Jun 2022 09:55:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 09:55:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 8 Jun 2022 09:55:40 +0800
Message-ID: <863e4efa275830371dfae5f2597958f4caf0ecfd.camel@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mediatek: add vdosys1 RDMA
 definition for mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>
Date:   Wed, 8 Jun 2022 09:55:40 +0800
In-Reply-To: <cd9b1212-0950-9fd8-7481-e3ef14de2131@linaro.org>
References: <20220606031818.13646-1-rex-bc.chen@mediatek.com>
         <20220606031818.13646-2-rex-bc.chen@mediatek.com>
         <cd9b1212-0950-9fd8-7481-e3ef14de2131@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 01:12 +0800, Krzysztof Kozlowski wrote:
> On 06/06/2022 05:18, Bo-Chen Chen wrote:
> > From: "Nancy.Lin" <nancy.lin@mediatek.com>
> > 
> > Add vdosys1 RDMA definition.
> > 
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Tested-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88
> > +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > rdma.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > rdma.yaml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > rdma.yaml
> > new file mode 100644
> > index 000000000000..678abb321cc2
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
> > rdma.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml*__;Iw!!CTRNKA9wMg0ARbw!xhCYRrVE-1_MTOnoDL_D-oY0zx2GGWns3WktzHKJwbLcdsGoWUhgu2dX0aG9ruZQ6aTU$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xhCYRrVE-1_MTOnoDL_D-oY0zx2GGWns3WktzHKJwbLcdsGoWUhgu2dX0aG9ruLOtx5y$
> >  
> > +
> > +title: MediaTek MDP RDMA
> > +
> > +maintainers:
> > +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > +  - Philipp Zabel <p.zabel@pengutronix.de>
> > +
> > +description:
> > +  The MediaTek MDP RDMA stands for Read Direct Memory Access.
> > +  It provides real time data to the back-end panel driver, such as
> > DSI,
> > +  DPI and DP_INTF.
> > +  It contains one line buffer to store the sufficient pixel data.
> > +  RDMA device node must be siblings to the central MMSYS_CONFIG
> > node.
> > +  For a description of the MMSYS_CONFIG binding, see
> > +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya
> > ml for details.
> > +
> > +properties:
> > +  compatible:
> > +    - const: mediatek,mt8195-vdo1-rdma
> 
> During my review I missed that part. But your testing should not miss
> it
> - please always run `make dt_bindings_check` and do not send code
> which
> fails.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Sorry we did not check again for this.
And also thanks for your review.

I will modify this in next version.

BRs,
Rex

