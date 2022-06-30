Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13966562608
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiF3WYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiF3WYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:24:20 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BE2873F;
        Thu, 30 Jun 2022 15:24:19 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id p14so319492ile.1;
        Thu, 30 Jun 2022 15:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCIN9X+au2FWfJK4vD7gv31EP7AOrK4M9CuPs1cmp3w=;
        b=Qc/+i4oBp5ffKAgWYwt3LY36/kINbsJiS4E0RTwIfV4VtuZch+NJX1daCndX3aEjTk
         jtpErd44L9jqDkipWwz22nYYF/4qMPJ5mtGdVIOlQzbgHtl8aL2R8JpEdFhxVTiLFxO2
         gK/CVxFtpVbe0OkBgqzBL/KY2YTr3SbkWXzvSzU+Cs6Ey68JGMutkqFps/zxqfPGEVB4
         L/3jnPULgC2+EoDfwqj4pTzsjymQQUTngW38SP0yV9rvogQRmbeVogHCfGLDxRb5QAae
         MvCVjwH90lia1vw9lek7Vyj3UBe5xVK0h2YaS6PR1cuQ+TA8n2QljnzwrD786vKhjnob
         3oog==
X-Gm-Message-State: AJIora+SKtynfqCpavgshasgzxbgIZYs/OSbNNI+lAAShqkqACHsBnF0
        xFb9CjmvrOmg7ljgADVYXA==
X-Google-Smtp-Source: AGRyM1vuc7JqudR/4gKzjExLt1n+/E0hzumEYFNUOrWm+0+DOzzs3jZYqzgptf8ybdjqJZ1rz6Cqyg==
X-Received: by 2002:a92:c567:0:b0:2d1:6268:2fd5 with SMTP id b7-20020a92c567000000b002d162682fd5mr6456227ilj.255.1656627858397;
        Thu, 30 Jun 2022 15:24:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k16-20020a023350000000b00339cb105ae7sm9241387jak.92.2022.06.30.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:24:18 -0700 (PDT)
Received: (nullmailer pid 3431797 invoked by uid 1000);
        Thu, 30 Jun 2022 22:24:14 -0000
Date:   Thu, 30 Jun 2022 16:24:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4, 1/8] dt-bindings: media: mediatek: vcodec: Adds
 encoder cores dt-bindings for mt8195
Message-ID: <20220630222414.GA3419242-robh@kernel.org>
References: <20220624082335.10165-1-irui.wang@mediatek.com>
 <20220624082335.10165-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624082335.10165-2-irui.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 04:23:28PM +0800, Irui Wang wrote:
> mt8195 has two H264 encoder hardware, which are named core0 and core1.
> The two encoder cores are independent, we can just enable one core to
> do encoding or enable both of them to achieve higher performance. We
> pick core0 as main device and core1 as its subdevice, it just a way to
> to manage the two encoder hardware, because they are two equal encoder
> hardware with the same function.

If the h/w is symmetrical, why did you do this?

> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,vcodec-encoder-core.yaml   | 225 ++++++++++++++++++
>  .../media/mediatek,vcodec-encoder.yaml        |   1 -
>  2 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> new file mode 100644
> index 000000000000..afd7d645aa80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
> @@ -0,0 +1,225 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Video Encoder Accelerator With Multi Core
> +
> +maintainers:
> +  - Irui Wang <irui.wang@mediatek.com>
> +
> +description: |
> +  MediaTek Video Encoder is the video encoder hardware present in MediaTek
> +  SoCs which supports high resolution encoding functionalities. To meet higher
> +  encoder performance, there will be one or more encoder hardware inside SoC,
> +  which named core0, core1, etc.. For example, mt8195 has two encoder hardware,
> +  the two encoder cores block diagram, can check below.
> +  --------------------------------------------------------------
> +  Input frame  0     1     2     3     4     5     6
> +               |     |     |     |     |     |     |
> +               v     |     v     |     v     |     v
> +           +-------+ | +-------+ | +-------+ | +-------+
> +           | core0 | | | core0 | | | core0 | | | core0 |
> +           +-------+ | +-------+ | +-------+ | +-------+
> +               |     |     |     |     |     |     |
> +               |     v     |     v     |     v     |
> +               | +-------+ | +-------+ | +-------+ |
> +               | | core1 | | | core1 | | | core1 | |
> +               | +-------+ | +-------+ | +-------+ |
> +               |     |     |     |     |     |     |
> +               v     v     v     v     v     v     v    <parent>
> +  --------------------------------------------------------------
> +                            core || index               <child>
> +                                 \/
> +       +--------------------------------------------------+
> +       |                     core0/core1                  |
> +       |             enable/disable power/clk/irq         |
> +       +--------------------------------------------------+
> +  --------------------------------------------------------------
> +  As above, there are two cores child devices, they are two encoder hardware
> +  which can encode input frames in order. When start encoding, input frame 0
> +  will be encoded by core0, and input frame 1 can be encoded by core1 even if
> +  frame 0 has not been encoded done yet, after frame 0 encoded done, frame 2
> +  will be encoded by core0, even input frames are encoded by core0 and odd
> +  input frames are encoded by core1, these two encoder cores encode ench input
> +  frames in this overlapping manner.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8195-vcodec-enc
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,scp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      The node of system control processor (SCP), using
> +      the remoteproc & rpmsg framework.
> +
> +  mediatek,venc-multi-core:

Can't you detect this with presence of child nodes?

> +    type: boolean
> +    description: |
> +      Indicates whether the encoder has multiple cores or not. We use this
> +      to probe additional encoder cores device.
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 32
> +    description: |
> +      List of the hardware port in respective IOMMU block for current Socs.
> +      Refer to bindings/iommu/mediatek,iommu.yaml.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dma-ranges:
> +    maxItems: 1
> +    description: |
> +      Describes the physical address space of IOMMU maps to memory.
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +# Required child node:
> +patternProperties:
> +  "^venc-core@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      The video encoder core device node which should be added as subnodes to
> +      the main venc node, it represents a encoder hardware.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: mediatek,mtk-venc-hw
> +
> +      reg:
> +        maxItems: 1
> +
> +      mediatek,hw-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Current encoder core id. We use it to pick which one encoder core
> +          will be used to encoding current input frame.
> +
> +      iommus:
> +        minItems: 1
> +        maxItems: 32

It looks like there are 9 iommus. How does this vary on an mt8195 SoC?

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
> +        maxItems: 1
> +
> +      power-domains:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - mediatek,hw-id
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
> +  - reg
> +  - mediatek,scp
> +  - iommus
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dma-ranges
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
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        venc: venc@1a020000 {
> +            compatible = "mediatek,mt8195-vcodec-enc";
> +            reg = <0 0x1a020000 0 0x10000>;
> +            mediatek,scp = <&scp>;
> +            mediatek,venc-multi-core;
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
> +            clock-names = "clk_venc";
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
> +            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            venc-core@1b020000 {
> +                compatible = "mediatek,mtk-venc-hw";
> +                reg = <0 0x1b020000 0 0x10000>;
> +                mediatek,hw-id = <1>;
> +                iommus = <&iommu_vpp M4U_PORT_L20_VENC_RCPU>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_REC>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_BSDMA>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_SV_COMV>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_RD_COMV>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_LUMA>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_CUR_CHROMA>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_REF_LUMA>,
> +                         <&iommu_vpp M4U_PORT_L20_VENC_REF_CHROMA>;
> +                interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH 0>;
> +                clocks = <&vencsys_core1 CLK_VENC_CORE1_VENC>;
> +                clock-names = "clk_venc_core1";
> +                assigned-clocks = <&topckgen CLK_TOP_VENC>;
> +                assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index d36fcca04cbc..11682659c4c4 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -21,7 +21,6 @@ properties:
>        - mediatek,mt8173-vcodec-enc
>        - mediatek,mt8183-vcodec-enc
>        - mediatek,mt8192-vcodec-enc
> -      - mediatek,mt8195-vcodec-enc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.18.0
> 
> 
