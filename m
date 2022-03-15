Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A314D92E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiCODQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCODQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:16:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456A2A711;
        Mon, 14 Mar 2022 20:15:13 -0700 (PDT)
X-UUID: 0bf839b975b74ae2af7fd70c83912443-20220315
X-UUID: 0bf839b975b74ae2af7fd70c83912443-20220315
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1543633687; Tue, 15 Mar 2022 11:15:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Mar 2022 11:15:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 11:15:08 +0800
Message-ID: <5a797c608b6eb29e6fba41fafc5f78f75b4ba1d3.camel@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Tue, 15 Mar 2022 11:15:08 +0800
In-Reply-To: <e7765c888e6fc8eb4b15fa01d19afda335b16c26.camel@mediatek.com>
References: <20220311133527.5914-1-jianjun.wang@mediatek.com>
         <20220311133527.5914-3-jianjun.wang@mediatek.com>
         <0454647b-7aa3-ed70-0b92-1e5c98d0adc0@canonical.com>
         <e7765c888e6fc8eb4b15fa01d19afda335b16c26.camel@mediatek.com>
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

On Mon, 2022-03-14 at 09:42 +0800, Jianjun Wang wrote:
> Hi Krzysztof,
> 
> On Fri, 2022-03-11 at 15:28 +0100, Krzysztof Kozlowski wrote:
> > On 11/03/2022 14:35, Jianjun Wang wrote:
> > > Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> > > 
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  .../bindings/phy/mediatek,pcie-phy.yaml       | 71
> > > +++++++++++++++++++
> > >  1 file changed, 71 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > > phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > > phy.yaml
> > > new file mode 100644
> > > index 000000000000..da15b4bf3117
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-
> > > phy.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek PCIe PHY Device Tree Binding
> > 
> > Title is for hardware, so s/Device Tree Binding//
> > 
> > > +
> > > +maintainers:
> > > +  - Jianjun Wang <jianjun.wang@mediatek.com>
> > > +
> > > +description: |
> > > +  The PCIe PHY supports physical layer functionality for PCIe
> > > Gen3
> > > port.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,pcie-phy
> > 
> > Is it going to be exactly one pcie-phy for all Mediatek chipsets
> > for
> > next years? Are you sure about that? It sounds highly unlikely....
> 
> We have only one pcie-phy for now, but if this is not recommended, I
> will replace it with a specific name in the next version, thanks for
> your review.
Prefer to add specific ones

> 
> Thanks.
> 
> > 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: sif
> > > +
> > > +  "#phy-cells":
> > > +    const: 0
> > > +
> > > +  nvmem-cells:
> > > +    maxItems: 7
> > > +    description:
> > > +      Phandles to nvmem cell that contains the efuse data, if
> > > unspecified,
> > > +      default value is used.
> > > +
> > > +  nvmem-cell-names:
> > > +    items:
> > > +      - const: glb_intr
> > > +      - const: tx_ln0_pmos
> > > +      - const: tx_ln0_nmos
> > > +      - const: rx_ln0
> > > +      - const: tx_ln1_pmos
> > > +      - const: tx_ln1_nmos
> > > +      - const: rx_ln1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - "#phy-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    pciephy: phy@11e80000 {
> > > +        compatible = "mediatek,pcie-phy";
> > > +        #phy-cells = <0>;
> > > +        reg = <0x11e80000 0x10000>;
> > > +        reg-names = "sif";
> > > +        nvmem-cells = <&pciephy_glb_intr>,
> > > +                      <&pciephy_tx_ln0_pmos>,
> > > +                      <&pciephy_tx_ln0_nmos>,
> > > +                      <&pciephy_rx_ln0>,
> > > +                      <&pciephy_tx_ln1_pmos>,
> > > +                      <&pciephy_tx_ln1_nmos>,
> > > +                      <&pciephy_rx_ln1>;
> > > +        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> > > +                           "tx_ln0_nmos", "rx_ln0",
> > > +                           "tx_ln1_pmos", "tx_ln1_nmos",
> > > +                           "rx_ln1";
> > > +    };
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> 

