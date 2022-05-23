Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28853079F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352586AbiEWCXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352264AbiEWCXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:23:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23D3668E;
        Sun, 22 May 2022 19:23:41 -0700 (PDT)
X-UUID: 2106b57dfb15452ab38b03e275ddf03e-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:82fb58b2-77f8-4c66-ae5f-cec585b30937,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:9b92357a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 2106b57dfb15452ab38b03e275ddf03e-20220523
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 493076538; Mon, 23 May 2022 10:23:36 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 10:23:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 10:23:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 10:23:32 +0800
Message-ID: <79706876349c3670f8831e75f70722f0bca200cb.camel@mediatek.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Mon, 23 May 2022 10:23:31 +0800
In-Reply-To: <20220520064920.27313-2-jianjun.wang@mediatek.com>
References: <20220520064920.27313-1-jianjun.wang@mediatek.com>
         <20220520064920.27313-2-jianjun.wang@mediatek.com>
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

On Fri, 2022-05-20 at 14:49 +0800, Jianjun Wang wrote:
> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/phy/mediatek,pcie-phy.yaml       | 75
> +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,pcie-
> phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,pcie-
> phy.yaml
> new file mode 100644
> index 000000000000..422750cc4121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PCIe PHY
> +
> +maintainers:
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +description: |
> +  The PCIe PHY supports physical layer functionality for PCIe Gen3
> port.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: sif
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    maxItems: 7
Seems no need 'maxItems', we can get it from items of 'nvmem-cell-
names'

> +    description:
> +      Phandles to nvmem cell that contains the efuse data, if
> unspecified,
> +      default value is used.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: glb_intr
> +      - const: tx_ln0_pmos
> +      - const: tx_ln0_nmos
> +      - const: rx_ln0
> +      - const: tx_ln1_pmos
> +      - const: tx_ln1_nmos
> +      - const: rx_ln1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@11e80000 {
> +        compatible = "mediatek,mt8195-pcie-phy";
> +        #phy-cells = <0>;
> +        reg = <0x11e80000 0x10000>;
> +        reg-names = "sif";
> +        nvmem-cells = <&pciephy_glb_intr>,
> +                      <&pciephy_tx_ln0_pmos>,
> +                      <&pciephy_tx_ln0_nmos>,
> +                      <&pciephy_rx_ln0>,
> +                      <&pciephy_tx_ln1_pmos>,
> +                      <&pciephy_tx_ln1_nmos>,
> +                      <&pciephy_rx_ln1>;
> +        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> +                           "tx_ln0_nmos", "rx_ln0",
> +                           "tx_ln1_pmos", "tx_ln1_nmos",
> +                           "rx_ln1";
> +        power-domains = <&spm 2>;
> +    };

