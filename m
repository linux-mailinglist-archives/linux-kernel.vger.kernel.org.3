Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8764CA1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiCBKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiCBKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:14:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6F3BBF7;
        Wed,  2 Mar 2022 02:13:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 262CF1F44C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646216034;
        bh=C6D6VdCgO9fMDC+Gq63slbbHePN146cgfQaNo6alzhU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CemZGLKZJrKXYg3EdTQKRR5h0nLahTHTY4qxlu2kuiwAAjK2xs4cmZKauuJoT7Q0f
         rIjQstDlQkY/xaBHwkBDmQo/WOJw8TvsbmKKrOJkFY1rR+56PfxBaTaKKl4h8kRkRx
         DGljyJIt/OL/Y+EeIOrmPdwiDcsZQWR91i/kfQGjEIcGHx/Iw2On7nviUY2BnjCCEP
         7u/EqQVjI7bFjqbPgRCbmN/aVJ8InXqc/h5K3bJcsAB+0FD8ah28yybR+WjNKQvtQX
         ftc14gmMrZrUfnYgm5B5jy5Q/8NiL2oLVtKdVG0DmQaMthjG+4b8lEVszMyQpy69Ys
         eQh0C94GSkudA==
Message-ID: <243c2a77-6fbf-6afa-b773-de9b58aa4997@collabora.com>
Date:   Wed, 2 Mar 2022 11:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v12 03/23] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20220222100741.30138-1-nancy.lin@mediatek.com>
 <20220222100741.30138-4-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220222100741.30138-4-nancy.lin@mediatek.com>
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

Il 22/02/22 11:07, Nancy.Lin ha scritto:
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   .../display/mediatek/mediatek,ethdr.yaml      | 147 ++++++++++++++++++
>   1 file changed, 147 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> new file mode 100644
> index 000000000000..131eed5eeeb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,ethdr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Ethdr Device Tree Bindings
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
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
> +  mediatek,gce-client-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: The register of display function block to be set by gce.
> +      There are 4 arguments in this property, gce node, subsys id, offset and
> +      register size. The subsys id is defined in the gce header of each chips
> +      include/include/dt-bindings/gce/<chip>-gce.h, mapping to the register of
> +      display function block.
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

Please fix inclusions and address/size cells.

Thanks,
Angelo

> +
> +    disp_ethdr@1c114000 {
> +            compatible = "mediatek,mt8195-disp-ethdr";
> +            reg = <0 0x1c114000 0 0x1000>,
> +                  <0 0x1c115000 0 0x1000>,
> +                  <0 0x1c117000 0 0x1000>,
> +                  <0 0x1c119000 0 0x1000>,
> +                  <0 0x1c11A000 0 0x1000>,
> +                  <0 0x1c11B000 0 0x1000>,
> +                  <0 0x1c11C000 0 0x1000>;
> +            reg-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +                        "vdo_be", "adl_ds";
> +            mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x4000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0x5000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0x7000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0x9000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0xA000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0xB000 0x1000>,
> +                                      <&gce0 SUBSYS_1c11XXXX 0xC000 0x1000>;
> +            clocks = <&vdosys1 CLK_VDO1_DISP_MIXER>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
> +                     <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
> +                     <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
> +                     <&vdosys1 CLK_VDO1_26M_SLOW>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>,
> +                     <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>,
> +                     <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>,
> +                     <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
> +                     <&topckgen CLK_TOP_ETHDR_SEL>;
> +            clock-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
> +                          "vdo_be", "adl_ds", "vdo_fe0_async", "vdo_fe1_async",
> +                          "gfx_fe0_async", "gfx_fe1_async","vdo_be_async",
> +                          "ethdr_top";
> +            power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +            iommus = <&iommu_vpp M4U_PORT_L3_HDR_DS>,
> +                     <&iommu_vpp M4U_PORT_L3_HDR_ADL>;
> +            interrupts = <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0>; /* disp mixer */
> +            resets = <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC>,
> +                     <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE1_DL_ASYNC>,
> +                     <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE0_DL_ASYNC>,
> +                     <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE1_DL_ASYNC>,
> +                     <&vdosys1 MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_BE_DL_ASYNC>;
> +    };
> +
> +...
