Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9185A57A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiH2XdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH2XdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:33:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1F39C21F;
        Mon, 29 Aug 2022 16:32:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B3A9481;
        Tue, 30 Aug 2022 01:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661815972;
        bh=W6sZ99MZm0WJIysDCG+qS83r+KGY/z25whL5L+DCuIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxBEPtywKPcBGK9e1hRcGy/5dl5DGK5YUvK3K3cSouY1gf1x1s1fJhWZTzfkEtitK
         sqQOPrQUPLH081pQJZFcfnNZFJdJotLrWd+lCOhwp3xU6eyJrhVoUKZt3VAQ2MPf5o
         zsCCZzV8YuxOhyqjBY+uYfVMhDf9/TMX/UGAZ9ZU=
Date:   Tue, 30 Aug 2022 02:32:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2
 block
Message-ID: <Yw1MmyFxnWNpQx8q@pendragon.ideasonboard.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Mon, Aug 01, 2022 at 10:47:15PM +0100, Lad Prabhakar wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1
> * Fixed review comments pointed by Rob and Jacopo.
> 
> RFC v1 -> RFC v2
> * New patch
> ---
>  .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> new file mode 100644
> index 000000000000..f82f88c096df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
> +  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
> +  with the Image Processing module, which provides the video capture capabilities.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

You can drop the oneOf and write

    items:
      - enum:
          - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
          - renesas,r9a07g054-csi2       # RZ/V2L
      - const: renesas,rzg2l-csi2

> +          - enum:
> +              - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
> +              - renesas,r9a07g054-csi2       # RZ/V2L
> +          - const: renesas,rzg2l-csi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: csi2_link

If there's a single interrupt you can drop the name.

> +
> +  clocks:
> +    items:
> +      - description: Internal clock for connecting CRU and MIPI
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: vclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_CMN_RSTB reset terminal
> +
> +  reset-names:
> +    const: cmn-rstb

Same here.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, Image Processing block connected to the CSI-2 receiver.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    csi20: csi2@10830400 {
> +            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
> +            reg = <0x10830400 0xfc00>;
> +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
> +            clock-names = "sysclk", "vclk", "pclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>;
> +            reset-names = "cmn-rstb";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                            reg = <0>;
> +
> +                            csi2_in: endpoint {
> +                                    clock-lanes = <0>;
> +                                    data-lanes = <1 2>;
> +                                    remote-endpoint = <&ov5645_ep>;
> +                            };
> +                    };
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            csi2cru: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint = <&crucsi2>;
> +                            };
> +                    };
> +            };
> +    };

-- 
Regards,

Laurent Pinchart
