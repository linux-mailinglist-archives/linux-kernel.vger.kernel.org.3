Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8803C4DDBDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiCROo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiCROoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:44:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2472E575F;
        Fri, 18 Mar 2022 07:43:33 -0700 (PDT)
X-UUID: 0aada1f8ccfa40db85dcd4a18f53bb02-20220318
X-UUID: 0aada1f8ccfa40db85dcd4a18f53bb02-20220318
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 207238101; Fri, 18 Mar 2022 22:43:18 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Mar 2022 22:43:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Mar
 2022 22:43:16 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 22:43:15 +0800
Message-ID: <27fecdcdeca7dac46f14b7a83ce49c0f8dc3e7e5.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Fri, 18 Mar 2022 22:43:15 +0800
In-Reply-To: <e0adbb4d-aa87-49ea-d79f-11c5f4fc4bdd@collabora.com>
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
         <20220318095417.2016-2-jianjun.wang@mediatek.com>
         <2e0989c3-7132-6091-5c9e-5dc8d9af22e8@collabora.com>
         <319cf016-55fb-dcd4-9157-ad795c8e68ff@kernel.org>
         <e0adbb4d-aa87-49ea-d79f-11c5f4fc4bdd@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-18 at 14:56 +0100, AngeloGioacchino Del Regno wrote:
> Il 18/03/22 14:51, Krzysztof Kozlowski ha scritto:
> > On 18/03/2022 12:12, AngeloGioacchino Del Regno wrote:
> > > Il 18/03/22 10:54, Jianjun Wang ha scritto:
> > > > Add YAML schema documentation for PCIe PHY on MediaTek
> > > > chipsets.
> > > > 
> > > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > > ---
> > > >    .../bindings/phy/mediatek,pcie-phy.yaml       | 75
> > > > +++++++++++++++++++
> > > >    1 file changed, 75 insertions(+)
> > > >    create mode 100644
> > > > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > > > b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > > > new file mode 100644
> > > > index 000000000000..868bf976568b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > > > phy.yaml
> > > > @@ -0,0 +1,75 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: MediaTek PCIe PHY
> > > > +
> > > > +maintainers:
> > > > +  - Jianjun Wang <jianjun.wang@mediatek.com>
> > > > +
> > > > +description: |
> > > > +  The PCIe PHY supports physical layer functionality for PCIe
> > > > Gen3 port.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: mediatek,mt8195-pcie-phy
> > > 
> > > Since I don't expect this driver to be only for MT8195, but to be
> > > extended to
> > > support some more future MediaTek SoCs and, depending on the
> > > number of differences
> > > in the possible future Gen4 PHYs, even different gen's, I propose
> > > to add a generic
> > > compatible as const.
> > > 
> > > So you'll have something like:
> > > 
> > > - enum:
> > >       - mediatek,mt8195-pcie-phy
> > > - const: mediatek,pcie-gen3-phy
> > 
> > I am not sure if this is a good idea. How sure are you that there
> > will
> > be no different PCIe Gen3 PHY not compatible with this one?
> > 
> > 
> 
> Thanks for pointing that out, I have underestimated this option.
> 
> Perhaps Jianjun may be more informed about whether my proposal is
> valid or not.

Many thanks for the suggestions.

Currently, we only have this PCIe Gen3 PHY, and I don't think we are
planning other PCIe Gen3 PHYs with different software interfaces, even
in the next generation, we want to make sure it has a similar interface
to this generation, so I prefer to add a generic ones to support more
SoCs that need this driver.

Thanks.

> 
> Cheers,
> Angelo
> 
> > Best regards,
> > Krzysztof
> 
> 

