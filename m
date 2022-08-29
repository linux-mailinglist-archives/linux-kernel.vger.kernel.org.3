Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F45A57BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiH2XmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH2XmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:42:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E249832DE;
        Mon, 29 Aug 2022 16:42:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E947481;
        Tue, 30 Aug 2022 01:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661816536;
        bh=ngFFZ6dOmWMcFpZ3IKwPW1v4ZbMsWtMoV3OBJVEtv+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlno3YaeDukmu2MSL5qYBY5uEvaJGMEG8W580K5sxVOZ7LhvaH7XvzImKh2oPLLq0
         uP/2NXzr1IKTDAbY1TQlFJOlSUEmJnD1sY6+u2A8sFrlcBThNbE+e0AR8QF7kVvZrw
         OiJohc4h23aFg/LbadFnqPnNeOT9QVUY/nc/g8bk=
Date:   Tue, 30 Aug 2022 02:42:07 +0300
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
Subject: Re: [PATCH 2/4] media: dt-bindings: media: Document RZ/G2L CRU
Message-ID: <Yw1Oz5Zcwgig8/Xy@pendragon.ideasonboard.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, Aug 01, 2022 at 10:47:16PM +0100, Lad Prabhakar wrote:
> Document the CRU block found on Renesas RZ/G2L SoC's.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1
> * Dropped endpoint stuff from port1 as suggested by Rob
> * Updated description for endpoint
> 
> RFC v1 -> RFC v2
> * Dropped CSI
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..d7389693dae9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The CRU image processing module is a data conversion module equipped with pixel
> +  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
> +  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
> +
> +properties:
> +  compatible:
> +    oneOf:

No oneOf here either.

> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> +              - renesas,r9a07g054-cru     # RZ/V2L
> +          - const: renesas,rzg2l-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: image_conv
> +      - const: image_conv_err
> +      - const: axi_mst_err
> +
> +  clocks:
> +    items:
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +      - description: CRU image transfer clock
> +
> +  clock-names:
> +    items:
> +      - const: vclk
> +      - const: pclk
> +      - const: aclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_PRESETN reset terminal
> +      - description: CRU_ARESETN reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: aresetn
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing a parallel input source.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              hsync-active: true
> +              vsync-active: true
> +              bus-width: true
> +              data-shift: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port node, describing the Image Processing module connected to the
> +          CSI-2 receiver.

Both ports should be mandatory as they exist at the hardware level.
Connections (through endpoints) are optional.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  # Device node example with CSI-2
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cru: video@10830000 {
> +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> +            reg = <0x10830000 0x400>;
> +            interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> +            clock-names = "vclk", "pclk", "aclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_PRESETN>,
> +                     <&cpg R9A07G044_CRU_ARESETN>;
> +            reset-names = "presetn", "aresetn";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            crucsi2: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint= <&csi2cru>;
> +                            };
> +                    };
> +            };
> +    };

-- 
Regards,

Laurent Pinchart
