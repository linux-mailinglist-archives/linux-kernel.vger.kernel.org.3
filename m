Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E80493B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354895AbiASNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:44:58 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36432 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbiASNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:44:56 -0500
Received: by mail-oi1-f179.google.com with SMTP id r138so4202987oie.3;
        Wed, 19 Jan 2022 05:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XV9jT834GTvMWeTq6hEN66D6w6Wl6MYdp1wgd9hHuME=;
        b=kjljUgEyc2BIHg45vkjZBA/anRFzuaikmOTp/h+AD/I0zPZR4kKF/7r3SWOCINHz50
         UI66MkTDqQrR6pneP+T3CfIfCa7QjdILXSiULfZVJyj5zX883CCRkC29Gp5W/7vmeQOe
         /Ii4cyJ2pYk7Re+J7UguAUflnF6yggujPKYNk1+vJwoYK/BkHUKIOhzADcsDh8HxH46E
         Crx4PXzOhovScG/+movHXtZ5PpFIVsHq3L3Lu0+265B4u8mRXuCaH+8DUMLxtVkEgX+4
         jkE5jU3P3IPDAh151FZTeRS5WKXRVXO0ILQ4DJh+f8lm1IVASvQv64sztrAjTUija93G
         80KQ==
X-Gm-Message-State: AOAM5333JYLiiS8wrVOkOk9pAmhMosKMkLjZ6XcLeqF06K09jStf40BD
        wv3GMAg6/0bWiyMUKLZX1wNlwyonEw==
X-Google-Smtp-Source: ABdhPJxUUuS7hqkZPCQ8sIm3JLv/JeOvqkPe8W72D50Yil+vhGBPzkLoBuX99vvWBlQ4Q8Xh/tgZFA==
X-Received: by 2002:a05:6808:2018:: with SMTP id q24mr3090344oiw.117.1642599896005;
        Wed, 19 Jan 2022 05:44:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c26sm8539217otr.65.2022.01.19.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:44:54 -0800 (PST)
Received: (nullmailer pid 3448746 invoked by uid 1000);
        Wed, 19 Jan 2022 13:44:53 -0000
Date:   Wed, 19 Jan 2022 07:44:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        angelogioacchino.delregno@collabora.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
Message-ID: <YegV1SQ7V/F3GAFL@robh.at.kernel.org>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
 <20220117120615.21687-4-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117120615.21687-4-irui.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 08:06:08PM +0800, Irui Wang wrote:
> Adds encoder cores dt-bindings for mt8195
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,vcodec-encoder-core.yaml   | 214 ++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
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

'phandle' is already 1 item. Drop.

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

Address should generally not be defined in the node name schema:

'^venc-core0@'

Though I think you should also drop the '0' here. The unit-address is 
enough to distinguish each instance. Then the schemas for each child 
node can be combined.

> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mtk-venc-core0

Is the programming model for each core the same, but just different 
codecs implemented? I'd just add a property to indicate which codec if 
that's not discoverable.

> +
> +      reg:
> +        maxItems: 1
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description: |
> +          List of the hardware port in respective IOMMU block for current Socs.
> +          Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: MT_CG_VENC0

The name is supposed to be local to the instance reflecting what the 
clock drives rather than a top-level or clock controller name. Lowercase 
is also the norm. Given there's only 1 clock, I'd just drop the name.

> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1

These are always allowed and shouldn't be required.

> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - iommus
> +      - interrupts
> +      - clocks
> +      - clock-names
> +      - assigned-clocks
> +      - assigned-clock-parents
> +      - power-domains
> +
> +    additionalProperties: false
> +
> +  "venc_core1@1b020000":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mtk-venc-core1
> +
> +      reg:
> +        maxItems: 1
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32
> +        description: |
> +          List of the hardware port in respective IOMMU block for current Socs.
> +          Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        items:
> +          - const: MT_CG_VENC1
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - iommus
> +      - interrupts
> +      - clocks
> +      - clock-names
> +      - assigned-clocks
> +      - assigned-clock-parents
> +      - power-domains
> +
> +    additionalProperties: false
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
> -- 
> 2.18.0
> 
> 
