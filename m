Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE774CC065
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiCCOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiCCOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:54:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C70DD967;
        Thu,  3 Mar 2022 06:53:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2F2FF1F45955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646319201;
        bh=Ble5iVaMAvjHc5tgrSsMsD/4kzoBi7xNbSaUci+2wB8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0Ed+P8XT1vXh3m1n2h9wBeTHTpkQKT8hUqV8vU1oYMq50V87MsDZBRIanrCILBuF
         p2YPYRVIRrBY1SMksTjLIjHY67WygNK6qz5lOltemQpBqAJo2UxYbe050d5nwikxv2
         BNLc/13yRP3Br0iGVcwjvnXQ+WwXwhQX0jAZrud4FocrjSA7NfqWYn+QBZEEr6kop5
         F64ftokrxp7gBfZaSO0NApSwwrk0J5QbhHyadyDhoT//uSe85Sy2rEj6/Qyx6i21Zp
         oyKI9bzP23JPC8x2pIuGoHo5uqXKKMFdmTrzTU1UOol0ufPcEvmLv+kzySBbJ5UKod
         UR8KihXcNj5NQ==
Message-ID: <0a867f1c-330b-16ac-6c87-42a181e50e1e@collabora.com>
Date:   Thu, 3 Mar 2022 15:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220117120615.21687-1-irui.wang@mediatek.com>
 <20220117120615.21687-4-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220117120615.21687-4-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/01/22 13:06, Irui Wang ha scritto:
> Adds encoder cores dt-bindings for mt8195
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>   .../media/mediatek,vcodec-encoder-core.yaml   | 214 ++++++++++++++++++
>   1 file changed, 214 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> new file mode 100644
> index 000000000000..d1e7bfa50bce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> @@ -0,0 +1,214 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek Video Encoder Accelerator With Multi Core
> +
> +maintainers:
> +  - Irui Wang <irui.wang@mediatek.com>
> +
> +description: |
> +  Mediatek Video Encode is the video encode hardware present in Mediatek
> +  SoCs which supports high resolution encoding functionalities. Required
> +  parent and child device node.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-vcodec-enc
> +
> +  mediatek,scp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
> +    description: |
> +      The node of system control processor (SCP), using
> +      the remoteproc & rpmsg framework.
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 32
> +    description: |
> +      List of the hardware port in respective IOMMU block for current Socs.
> +      Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +  dma-ranges:
> +    maxItems: 1
> +    description: |
> +      Describes the physical address space of IOMMU maps to memory.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +# Required child node:
> +patternProperties:
> +  "venc_core0@1a020000":

This should be a pattern, venc-coreN where N is a number between 0 and 9,
and any iostart should be allowed, not just 1a020000; doing it that way
allows you to do a spec for all the core subnodes in one.


> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mtk-venc-core0
> +

..snip..

> +
> +required:
> +  - compatible
> +  - mediatek,scp
> +  - iommus
> +  - dma-ranges
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    venc {
> +        compatible = "mediatek,mt8195-vcodec-enc";
> +        mediatek,scp = <&scp>;
> +        iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>;
> +        dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;

What about doing instead...

#address-cells = <2>;
#size-cells = <2>;
(or fix your dma-ranges property)

and...

ranges = <0 0 0 0x1a020000 0 0x1020000>;
     venc-core0@0 {
         compatible = "mediatek,mtk-venc-hw";
         reg = <0 0 0 0x10000>;
         mediatek,hw-leader;
          ..... other properties .....
     };

     venc-core1@1000000 {
         compatible = "mediatek,mtk-venc-hw";
         reg = <0 0x1000000 0 0x10000>;
          ..... other properties .....
     }

Regards,
Angelo

> +
> +        venc_core0@1a020000 {
> +            compatible = "mediatek,mtk-venc-core0";
> +            reg = <0x1a020000 0x10000>;
> +            iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_REC>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
> +                     <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
> +            interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks = <&vencsys CLK_VENC_VENC>;
> +            clock-names = "MT_CG_VENC0";
> +            assigned-clocks = <&topckgen CLK_TOP_VENC>;
> +            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
> +        };
> +
> +        venc_core1@1b020000 {
> +            compatible = "mediatek,mtk-venc-core1";
> +            reg = <0x1b020000 0x10000>;
> +            iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_REC>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
> +                     <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
> +            interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
> +            clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
> +            clock-names = "MT_CG_VENC1";
> +            assigned-clocks = <&topckgen CLK_TOP_VENC>;
> +            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +        };
> +    };

