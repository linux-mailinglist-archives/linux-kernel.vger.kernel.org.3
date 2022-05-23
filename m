Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE155307D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiEWC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiEWC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:58:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972913FA0;
        Sun, 22 May 2022 19:58:46 -0700 (PDT)
X-UUID: c07f7d17411b4733afe8c214dde10fd9-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:afcd5b5c-626a-4d66-8561-3fc91e978add,OB:0,LO
        B:20,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:56
X-CID-INFO: VERSION:1.1.5,REQID:afcd5b5c-626a-4d66-8561-3fc91e978add,OB:0,LOB:
        20,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:56
X-CID-META: VersionHash:2a19b09,CLOUDID:9411377a-5ef6-470b-96c9-bdb8ced32786,C
        OID:6b3065758ceb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: c07f7d17411b4733afe8c214dde10fd9-20220523
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 708898458; Mon, 23 May 2022 10:58:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 10:58:38 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 10:58:25 +0800
Message-ID: <bb24ceafc7b1df1b2a5cd1b3662d9cc7af6fce0d.camel@mediatek.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
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
Date:   Mon, 23 May 2022 10:58:23 +0800
In-Reply-To: <79706876349c3670f8831e75f70722f0bca200cb.camel@mediatek.com>
References: <20220520064920.27313-1-jianjun.wang@mediatek.com>
         <20220520064920.27313-2-jianjun.wang@mediatek.com>
         <79706876349c3670f8831e75f70722f0bca200cb.camel@mediatek.com>
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

Hi Chunfeng,

On Mon, 2022-05-23 at 10:23 +0800, Chunfeng Yun wrote:
> On Fri, 2022-05-20 at 14:49 +0800, Jianjun Wang wrote:
> > Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  .../bindings/phy/mediatek,pcie-phy.yaml       | 75
> > +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > 
...snip...
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +  nvmem-cells:
> > +    maxItems: 7
> 
> Seems no need 'maxItems', we can get it from items of 'nvmem-cell-
> names'

Please see the comment by Krzysztof[1], I guess we need to add this
'maxTems'.

[1]:
https://lore.kernel.org/lkml/d48c0023-231c-4011-5548-4b260b3fe172@kernel.org/

Thanks.
> 
> > +    description:
> > +      Phandles to nvmem cell that contains the efuse data, if
> > unspecified,
> > +      default value is used.
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: glb_intr
> > +      - const: tx_ln0_pmos
> > +      - const: tx_ln0_nmos
> > +      - const: rx_ln0
> > +      - const: tx_ln1_pmos
> > +      - const: tx_ln1_nmos
> > +      - const: rx_ln1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@11e80000 {
> > +        compatible = "mediatek,mt8195-pcie-phy";
> > +        #phy-cells = <0>;
> > +        reg = <0x11e80000 0x10000>;
> > +        reg-names = "sif";
> > +        nvmem-cells = <&pciephy_glb_intr>,
> > +                      <&pciephy_tx_ln0_pmos>,
> > +                      <&pciephy_tx_ln0_nmos>,
> > +                      <&pciephy_rx_ln0>,
> > +                      <&pciephy_tx_ln1_pmos>,
> > +                      <&pciephy_tx_ln1_nmos>,
> > +                      <&pciephy_rx_ln1>;
> > +        nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> > +                           "tx_ln0_nmos", "rx_ln0",
> > +                           "tx_ln1_pmos", "tx_ln1_nmos",
> > +                           "rx_ln1";
> > +        power-domains = <&spm 2>;
> > +    };
> 
> 

