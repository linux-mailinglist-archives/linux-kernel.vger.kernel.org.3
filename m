Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EBD4DDBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiCROq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiCROq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:46:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C209105055;
        Fri, 18 Mar 2022 07:45:38 -0700 (PDT)
X-UUID: b5813db762b547ae878ca40cd9238779-20220318
X-UUID: b5813db762b547ae878ca40cd9238779-20220318
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 206030604; Fri, 18 Mar 2022 22:45:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 22:45:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 22:45:23 +0800
Message-ID: <da5eec2a0f96c882f79d124ecefcd357fe0d6b63.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
Date:   Fri, 18 Mar 2022 22:45:23 +0800
In-Reply-To: <d48c0023-231c-4011-5548-4b260b3fe172@kernel.org>
References: <20220318095417.2016-1-jianjun.wang@mediatek.com>
         <20220318095417.2016-2-jianjun.wang@mediatek.com>
         <d48c0023-231c-4011-5548-4b260b3fe172@kernel.org>
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

Hi Krzysztof,

On Fri, 2022-03-18 at 14:55 +0100, Krzysztof Kozlowski wrote:
> On 18/03/2022 10:54, Jianjun Wang wrote:
> > Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >  .../bindings/phy/mediatek,pcie-phy.yaml       | 75
> > +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > phy.yaml
> > new file mode 100644
> > index 000000000000..868bf976568b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek PCIe PHY
> > +
> > +maintainers:
> > +  - Jianjun Wang <jianjun.wang@mediatek.com>
> > +
> > +description: |
> > +  The PCIe PHY supports physical layer functionality for PCIe Gen3
> > port.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8195-pcie-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reg-names:
> > +    items:
> > +      - const: sif
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  nvmem-cells:
> > +    description:
> > +      Phandles to nvmem cell that contains the efuse data, if
> > unspecified,
> > +      default value is used.
> 
> maxItems: 7

Thanks for your review, I'll fix it in the next version.

> 
> Best regards,
> Krzysztof

