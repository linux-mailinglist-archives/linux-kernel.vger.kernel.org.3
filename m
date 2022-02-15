Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E44B6AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiBOLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiBOLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:32:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519A1A390;
        Tue, 15 Feb 2022 03:31:47 -0800 (PST)
X-UUID: 8ffda993c6364c41a243f333761a5d93-20220215
X-UUID: 8ffda993c6364c41a243f333761a5d93-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1880578445; Tue, 15 Feb 2022 19:31:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 19:31:41 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 19:31:40 +0800
Message-ID: <421013a38c3bb4452fefe83ffdcb4cbdb4c1e0e6.camel@mediatek.com>
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 15 Feb 2022 19:31:40 +0800
In-Reply-To: <YegV1SQ7V/F3GAFL@robh.at.kernel.org>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
         <20220117120615.21687-4-irui.wang@mediatek.com>
         <YegV1SQ7V/F3GAFL@robh.at.kernel.org>
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

Dear Rob,

Many thanks for your review comments.

On Wed, 2022-01-19 at 07:44 -0600, Rob Herring wrote:
> On Mon, Jan 17, 2022 at 08:06:08PM +0800, Irui Wang wrote:
> > Adds encoder cores dt-bindings for mt8195
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  .../media/mediatek,vcodec-encoder-core.yaml   | 214
> > ++++++++++++++++++
> >  1 file changed, 214 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > core.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > core.yaml
> > b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > core.yaml
> > new file mode 100644
> > index 000000000000..d1e7bfa50bce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > encoder-core.yaml
> > @@ -0,0 +1,214 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: "
> > http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#
> > "
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Mediatek Video Encoder Accelerator With Multi Core
> > +
> > +maintainers:
> > +  - Irui Wang <irui.wang@mediatek.com>
> > +
> > +description: |
> > +  Mediatek Video Encode is the video encode hardware present in
> > Mediatek
> > +  SoCs which supports high resolution encoding functionalities.
> > Required
> > +  parent and child device node.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8195-vcodec-enc
> > +
> > +  mediatek,scp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    maxItems: 1
> 
> 'phandle' is already 1 item. Drop.

Do you mean delete "maxItems: 1"? we will delete in next version.
>  
> > +    description: |
> > +      The node of system control processor (SCP), using
> > +      the remoteproc & rpmsg framework.
> > +
> > +  iommus:
> > +    minItems: 1
> > +    maxItems: 32
> > +    description: |
> > +      List of the hardware port in respective IOMMU block for
> > current Socs.
> > +      Refer to bindings/iommu/mediatek,iommu.yaml.
> > +
> > +  dma-ranges:
> > +    maxItems: 1
> > +    description: |
> > +      Describes the physical address space of IOMMU maps to
> > memory.
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +# Required child node:
> > +patternProperties:
> > +  "venc_core0@1a020000":
> 
> Address should generally not be defined in the node name schema:
> 
> '^venc-core0@'
> 
> Though I think you should also drop the '0' here. The unit-address
> is 
> enough to distinguish each instance. Then the schemas for each child 
> node can be combined.

Thanks, we will rename it in next version.
> 
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: mediatek,mtk-venc-core0
> 
> Is the programming model for each core the same, but just different 
> codecs implemented? I'd just add a property to indicate which codec
> if 
> that's not discoverable.
> 
Core-0 and Core-1 are two different encoder hardware, they have their
own hardware, used irq/clock/power...So, we need add two model nodes, a
"property" may not distinguish the two encoder hardware.
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      iommus:
> > +        minItems: 1
> > +        maxItems: 32
> > +        description: |
> > +          List of the hardware port in respective IOMMU block for
> > current Socs.
> > +          Refer to bindings/iommu/mediatek,iommu.yaml.
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +      clock-names:
> > +        items:
> > +          - const: MT_CG_VENC0
> 
> The name is supposed to be local to the instance reflecting what the 
> clock drives rather than a top-level or clock controller name.
> Lowercase 
> is also the norm. Given there's only 1 clock, I'd just drop the name.
Thanks, we will rename it in next version, but we need parse clock info
by "clock-names"(of_property_count_strings), so maybe we can't drop it.
> 
> > +
> > +      assigned-clocks:
> > +        maxItems: 1
> > +
> > +      assigned-clock-parents:
> > +        maxItems: 1
> 
> These are always allowed and shouldn't be required.
Do you mean we can not write this two properties here? we will try to
delete them in next version.

Thanks
BRs
> 
> > +
> > +      power-domains:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - iommus
> > +      - interrupts
> > +      - clocks
> > +      - clock-names
> > +      - assigned-clocks
> > +      - assigned-clock-parents
> > +      - power-domains
> > +
> > +    additionalProperties: false
> > +
> > +  "venc_core1@1b020000":
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: mediatek,mtk-venc-core1
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      iommus:
> > +        minItems: 1
> > +        maxItems: 32
> > +        description: |
> > +          List of the hardware port in respective IOMMU block for
> > current Socs.
> > +          Refer to bindings/iommu/mediatek,iommu.yaml.
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +      clock-names:
> > +        items:
> > +          - const: MT_CG_VENC1
> > +
> > +      assigned-clocks:
> > +        maxItems: 1
> > +
> > +      assigned-clock-parents:
> > +        maxItems: 1
> > +
> > +      power-domains:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - iommus
> > +      - interrupts
> > +      - clocks
> > +      - clock-names
> > +      - assigned-clocks
> > +      - assigned-clock-parents
> > +      - power-domains
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - mediatek,scp
> > +  - iommus
> > +  - dma-ranges
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/memory/mt8195-memory-port.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/mt8195-clk.h>
> > +    #include <dt-bindings/power/mt8195-power.h>
> > +
> > +    venc {
> > +        compatible = "mediatek,mt8195-vcodec-enc";
> > +        mediatek,scp = <&scp>;
> > +        iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>;
> > +        dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +
> > +        venc_core0@1a020000 {
> > +            compatible = "mediatek,mtk-venc-core0";
> > +            reg = <0x1a020000 0x10000>;
> > +            iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_REC>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
> > +                     <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
> > +            interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
> > +            clocks = <&vencsys CLK_VENC_VENC>;
> > +            clock-names = "MT_CG_VENC0";
> > +            assigned-clocks = <&topckgen CLK_TOP_VENC>;
> > +            assigned-clock-parents = <&topckgen
> > CLK_TOP_UNIVPLL_D4>;
> > +            power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
> > +        };
> > +
> > +        venc_core1@1b020000 {
> > +            compatible = "mediatek,mtk-venc-core1";
> > +            reg = <0x1b020000 0x10000>;
> > +            iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_REC>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
> > +                     <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
> > +            interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
> > +            clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
> > +            clock-names = "MT_CG_VENC1";
> > +            assigned-clocks = <&topckgen CLK_TOP_VENC>;
> > +            assigned-clock-parents = <&topckgen
> > CLK_TOP_UNIVPLL_D4>;
> > +            power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> > +        };
> > +    };
> > -- 
> > 2.18.0
> > 
> > 

