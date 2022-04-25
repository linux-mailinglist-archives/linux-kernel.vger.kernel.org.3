Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29B50E5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiDYQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiDYQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:37:16 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9ADE92F;
        Mon, 25 Apr 2022 09:34:11 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id x22-20020a4aca96000000b00338fbaf797bso2884396ooq.10;
        Mon, 25 Apr 2022 09:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1loEjRTP/Q6tR950lkPpHaLcFJYgRPsFYzQY0su75F8=;
        b=ALsyO5G0xdI9zR41jbhvGKtYcsXvj/e15vOg7NjVF2Dgt2C9R/0+z7M8BzqD0qfsM2
         eVUI2Nytc5npkKkEdQWbCZJaTzY57Qpv4LjcEtM8DKy3DeF8dPZCsBuGFd9s3lI3w+X+
         RdX5Xfin1mqosJKI07UvFwPpCHU7sZzCsc3KRp5hMoLmgBDGH4Ttz37VCDvoAuqCQN2c
         M9kBFITX2Rm+Ji+uPLiXV0PE3ai64DZQLP43bKhZZx76RAQQycXz+kSA8AYn6JSJegtn
         BOWmMdWLYe5wa3HY8NM429JGtkjRDZ5ZqV0h08ao11KRzaYmk/4S76N7ea1VE7NAQW4e
         e13g==
X-Gm-Message-State: AOAM531Ven9Zy+I0n2HI4EeJldAse71q609xlftQN5e0efcKi5iYsUk4
        280wlGRXG0U+jupSOx+wXA==
X-Google-Smtp-Source: ABdhPJzPAsEnmHRb12a7tBkVVEyHXJ2dEIu3UFJdjKhTaOJtwR20kd5qtparR6MVwRfloGCKxeNKgg==
X-Received: by 2002:a4a:92d4:0:b0:33a:3d7d:fe5 with SMTP id j20-20020a4a92d4000000b0033a3d7d0fe5mr6675192ooh.83.1650904450714;
        Mon, 25 Apr 2022 09:34:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk35-20020a0568081a2300b003226178fe7bsm3964854oib.33.2022.04.25.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:34:10 -0700 (PDT)
Received: (nullmailer pid 4018960 invoked by uid 1000);
        Mon, 25 Apr 2022 16:34:09 -0000
Date:   Mon, 25 Apr 2022 11:34:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: add ethdr definition for
 mt8195
Message-ID: <YmbNgQ+t/mUrLhis@robh.at.kernel.org>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-6-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419033237.23405-6-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:32:37AM +0800, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> new file mode 100644
> index 000000000000..e8303c28a361
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,ethdr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Ethdr Device Tree Bindings
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |

No need for '|' unless you have formatting to preserve.

> +  ETHDR is designed for HDR video and graphics conversion in the external display path.
> +  It handles multiple HDR input types and performs tone mapping, color space/color
> +  format conversion, and then combine different layers, output the required HDR or
> +  SDR signal to the subsequent display path. This engine is composed of two video
> +  frontends, two graphic frontends, one video backend and a mixer. ETHDR has two
> +  DMA function blocks, DS and ADL. These two function blocks read the pre-programmed
> +  registers from DRAM and set them to HW in the v-blanking period.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-disp-ethdr

blank line between DT properties.

> +  reg:
> +    maxItems: 7
> +  reg-names:
> +    items:
> +      - const: mixer
> +      - const: vdo_fe0
> +      - const: vdo_fe1
> +      - const: gfx_fe0
> +      - const: gfx_fe1
> +      - const: vdo_be
> +      - const: adl_ds
> +  interrupts:
> +    minItems: 1

maxItems: 1

> +  iommus:
> +    description: The compatible property is DMA function blocks.
> +      Should point to the respective IOMMU block with master port as argument,
> +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for
> +      details.
> +    minItems: 1
> +    maxItems: 2
> +  clocks:
> +    items:
> +      - description: mixer clock
> +      - description: video frontend 0 clock
> +      - description: video frontend 1 clock
> +      - description: graphic frontend 0 clock
> +      - description: graphic frontend 1 clock
> +      - description: video backend clock
> +      - description: autodownload and menuload clock
> +      - description: video frontend 0 async clock
> +      - description: video frontend 1 async clock
> +      - description: graphic frontend 0 async clock
> +      - description: graphic frontend 1 async clock
> +      - description: video backend async clock
> +      - description: ethdr top clock
> +  clock-names:
> +    items:
> +      - const: mixer
> +      - const: vdo_fe0
> +      - const: vdo_fe1
> +      - const: gfx_fe0
> +      - const: gfx_fe1
> +      - const: vdo_be
> +      - const: adl_ds
> +      - const: vdo_fe0_async
> +      - const: vdo_fe1_async
> +      - const: gfx_fe0_async
> +      - const: gfx_fe1_async
> +      - const: vdo_be_async
> +      - const: ethdr_top
> +  power-domains:
> +    maxItems: 1
> +  resets:
> +    maxItems: 5

Need to define what they are and order.

> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: The register of display function block to be set by gce.
> +      There are 4 arguments in this property, gce node, subsys id, offset and
> +      register size. The subsys id is defined in the gce header of each chips
> +      include/include/dt-bindings/gce/<chip>-gce.h, mapping to the register of
> +      display function block.

Need to define each cell:

minItems: ??
maxItems: ??
items:
  items:
    - description: gce node
    - description: ...
    ...

Seems odd this property is optional...

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/gce/mt8195-gce.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +    #include <dt-bindings/reset/mt8195-resets.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        disp_ethdr@1c114000 {
> +                compatible = "mediatek,mt8195-disp-ethdr";
> +                reg = <0 0x1c114000 0 0x1000>,
> +                      <0 0x1c115000 0 0x1000>,
> +                      <0 0x1c117000 0 0x1000>,
> +                      <0 0x1c119000 0 0x1000>,
> +                      <0 0x1c11a000 0 0x1000>,
> +                      <0 0x1c11b000 0 0x1000>,
> +                      <0 0x1c11b000 0 0x1000>;
> +                reg-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +                            "vdo_be", "adl_ds";
> +                mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x4000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0x5000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0x7000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0x9000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0xa000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0xb000 0x1000>,
> +                                          <&gce0 SUBSYS_1c11XXXX 0xc000 0x1000>;
> +                clocks = <&vdosys1 CLK_VDO1_DISP_MIXER>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
> +                         <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
> +                         <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
> +                         <&vdosys1 CLK_VDO1_26M_SLOW>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>,
> +                         <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>,
> +                         <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>,
> +                         <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
> +                         <&topckgen CLK_TOP_ETHDR>;
> +                clock-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +                              "vdo_be", "adl_ds", "vdo_fe0_async", "vdo_fe1_async",
> +                              "gfx_fe0_async", "gfx_fe1_async","vdo_be_async",
> +                              "ethdr_top";
> +                power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +                iommus = <&iommu_vpp M4U_PORT_L3_HDR_DS>,
> +                         <&iommu_vpp M4U_PORT_L3_HDR_ADL>;
> +                interrupts = <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0>; /* disp mixer */
> +                resets = <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC>,
> +                         <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE1_DL_ASYNC>,
> +                         <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE0_DL_ASYNC>,
> +                         <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE1_DL_ASYNC>,
> +                         <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_BE_DL_ASYNC>;
> +        };
> +    };
> +
> +...
> -- 
> 2.18.0
> 
> 
