Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC4F4CCB98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiCDCNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiCDCNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:13:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4349929;
        Thu,  3 Mar 2022 18:12:53 -0800 (PST)
X-UUID: 9ef0ee03b26f4281b5166ebfa3bf8e22-20220304
X-UUID: 9ef0ee03b26f4281b5166ebfa3bf8e22-20220304
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 515010774; Fri, 04 Mar 2022 10:12:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Mar 2022 10:12:48 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 10:12:47 +0800
Message-ID: <070c86db605e60eafd53520b1d93644b2bdb2d96.camel@mediatek.com>
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
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
Date:   Fri, 4 Mar 2022 10:12:45 +0800
In-Reply-To: <0a867f1c-330b-16ac-6c87-42a181e50e1e@collabora.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
         <20220117120615.21687-4-irui.wang@mediatek.com>
         <0a867f1c-330b-16ac-6c87-42a181e50e1e@collabora.com>
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

Hello, Angelo,

Many thanks for your review.

On Thu, 2022-03-03 at 15:53 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/01/22 13:06, Irui Wang ha scritto:
> > Adds encoder cores dt-bindings for mt8195
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   .../media/mediatek,vcodec-encoder-core.yaml   | 214
> > ++++++++++++++++++
> >   1 file changed, 214 insertions(+)
> >   create mode 100644
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
> This should be a pattern, venc-coreN where N is a number between 0
> and 9,
> and any iostart should be allowed, not just 1a020000; doing it that
> way
> allows you to do a spec for all the core subnodes in one.

I will fix it.
> 
> 
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: mediatek,mtk-venc-core0
> > +
> 
> ..snip..
> 
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
> 
> What about doing instead...
> 
> #address-cells = <2>;
> #size-cells = <2>;
> (or fix your dma-ranges property)

cells=2 may cause some unexpected errors, I will check it again.
> 
> and...
> 
> ranges = <0 0 0 0x1a020000 0 0x1020000>;
>      venc-core0@0 {
>          compatible = "mediatek,mtk-venc-hw";
>          reg = <0 0 0 0x10000>;
>          mediatek,hw-leader;
>           ..... other properties .....
>      };
> 
>      venc-core1@1000000 {
>          compatible = "mediatek,mtk-venc-hw";
>          reg = <0 0x1000000 0 0x10000>;
>           ..... other properties .....
>      }
> 
> Regards,
> Angelo

I will rewrite the examples.

Thanks
Best Regards
> 
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
> 
> 

