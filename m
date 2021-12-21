Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3347BC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhLUIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbhLUIr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:47:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E9C061574;
        Tue, 21 Dec 2021 00:47:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A57B6881;
        Tue, 21 Dec 2021 09:47:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640076444;
        bh=/VTze/ZagOupEMdJkPudNkGv0WwLpT5c151Qt2p6m+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAl/5clNb9X+HnXbNJ2uQ1dvnDHGKzFcoJ3sm4l2fsQnc+Fz0O0R6XX7fWB4xn0lX
         5M9RFwndXEaEh5OS41bAg6bGL9jxEiZcsgN84lEDAFdE2z3uZwHOMa3/56EKjq+pRT
         rbEdRpfA6OH4md6AU2s/teFv4/3/sCxweiXwgnRI=
Date:   Tue, 21 Dec 2021 10:47:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Document RZ/G2L CRU
 block
Message-ID: <YcGUmvq32fUXOMTo@pendragon.ideasonboard.com>
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211207012351.15754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YbfQIPS270So+jUh@robh.at.kernel.org>
 <CA+V-a8tHL-DwNz3USQwh5NieTRvPhUAjZV-GqFsK67fgU+kF_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8tHL-DwNz3USQwh5NieTRvPhUAjZV-GqFsK67fgU+kF_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Tue, Dec 14, 2021 at 12:07:14PM +0000, Lad, Prabhakar wrote:
> On Mon, Dec 13, 2021 at 10:58 PM Rob Herring wrote:
> > On Tue, Dec 07, 2021 at 01:23:49AM +0000, Lad Prabhakar wrote:
> > > Document the CRU block found on Renesas RZ/G2L SoC's.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  .../bindings/media/renesas,rzg2l-cru.yaml     | 227 ++++++++++++++++++
> > >  1 file changed, 227 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > > new file mode 100644
> > > index 000000000000..7b2835810516
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> > > @@ -0,0 +1,227 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright (C) 2021 Renesas Electronics Corp.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
> > > +
> > > +maintainers:
> > > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > +
> > > +description:
> > > +  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
> > > +  capabilities for the Renesas RZ/G2L family of devices.
> > > +
> > > +  Depending on the instance the Image Processing input is connected to
> > > +  external SoC pins or to a CSI-2 receiver.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> >
> > Don't need oneOf with only 1 entry.
>
> I added this as there will be couple of more SoC's using this driver.

Will that be SoCs not compatible tieh the rzg2l-cru compatible string ?
If so oneOf may be needed, but you can also add it later.

> > > +          - enum:
> > > +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> > > +          - const: renesas,rzg2l-cru
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 4
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: csi2_link_int

I'm not thrilled by this. It looks like the CSI-2 receiver and the image
processing block are separate IP cores. Can we model them as separate DT
nodes ? I expect the CSI-2 receiver to possibly be reused in other SoCs
with a different integration.

> > > +      - const: image_conv_int
> > > +      - const: image_conv_err_int
> > > +      - const: axi_mst_err_int
> >
> > _int is redundant.
>
> Agreed will drop "_int".
> 
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Internal clock for connecting CRU and MIPI
> > > +      - description: CRU Main clock
> > > +      - description: CPU Register access clock
> > > +      - description: CRU image transfer clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: sysclk
> > > +      - const: vclk
> > > +      - const: pclk
> > > +      - const: aclk
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: CRU_CMN_RSTB reset terminal
> > > +      - description: CRU_PRESETN reset terminal
> > > +      - description: CRU_ARESETN reset terminal
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: cmn-rstb
> > > +      - const: presetn
> > > +      - const: aresetn
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +        description:
> > > +          Input port node, single endpoint describing a parallel input source.
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              hsync-active: true
> > > +
> > > +              vsync-active: true
> > > +
> > > +              bus-width: true
> > > +
> > > +              data-shift: true

No need for a blank line between all properties.

> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > > +        description:
> > > +          Input port node, single endpoint describing the CSI-2 transmitter.
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              clock-lanes:
> > > +                maxItems: 1

If lane reordering isn't supported, you could omit this.

> > > +
> > > +              data-lanes:
> > > +                maxItems: 1

Doesn't the CSI-2 receiver support more than one lane ?

> > > +
> > > +            required:
> > > +              - clock-lanes
> > > +              - data-lanes
> > > +
> > > +      port@2:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Output port node, describing the RZ/G2L Image Processing module
> > > +          connected the CSI-2 receiver
> > > +
> > > +        properties:
> > > +          endpoint@0:
> >
> > Unless you have mutiple endpoints to define or endpoint properties to
> > add, you don't need to specify anything more than the port.
>
> Agreed will drop it.
> 
> > > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > > +            description: Endpoint connected to CSI2.
> > > +
> > > +        anyOf:
> > > +          - required:
> > > +              - endpoint@0
> > > +
> > > +      port@3:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description:
> > > +          Input port node, describing the RZ/G2L CSI-2 module connected the
> > > +          Image Processing block.
> > > +
> > > +        properties:
> > > +          endpoint@0:
> > > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > > +            description: Endpoint connected to CSI2.
> > > +
> > > +        anyOf:
> > > +          - required:
> > > +              - endpoint@0
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +  - reset-names
> > > +  - power-domains
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  # Device node example with CSI-2
> > > +  - |
> > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    cru: video@10830000 {
> > > +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> > > +            reg = <0x10830000 0x10000>;
> > > +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "csi2_link_int", "image_conv_int",
> > > +                              "image_conv_err_int", "axi_mst_err_int";
> > > +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> > > +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> > > +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> > > +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> > > +            clock-names = "sysclk", "vclk", "pclk", "aclk";
> > > +            power-domains = <&cpg>;
> > > +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>,
> > > +                     <&cpg R9A07G044_CRU_PRESETN>,
> > > +                     <&cpg R9A07G044_CRU_ARESETN>;
> > > +            reset-names = "cmn-rstb", "presetn", "aresetn";
> > > +
> > > +            ports {
> > > +                    #address-cells = <1>;
> > > +                    #size-cells = <0>;
> > > +
> > > +                    port@1 {
> > > +                            #address-cells = <1>;
> > > +                            #size-cells = <0>;
> > > +
> > > +                            reg = <1>;
> > > +
> > > +                            csi2_in: endpoint@0 {
> > > +                                    reg = <0>;
> > > +                                    clock-lanes = <0>;
> > > +                                    data-lanes = <1 2>;
> > > +                                    remote-endpoint = <&ov5645_ep>;
> > > +                            };
> > > +                    };
> > > +
> > > +                    port@2 {
> > > +                            #address-cells = <1>;
> > > +                            #size-cells = <0>;
> > > +
> > > +                            reg = <2>;
> > > +
> > > +                            csi2cru: endpoint@0 {
> > > +                                    reg = <0>;
> > > +                                    remote-endpoint= <&crucsi2>;
> > > +                            };
> > > +                    };
> > > +
> > > +                    port@3 {
> > > +                            #address-cells = <1>;
> > > +                            #size-cells = <0>;
> > > +
> > > +                            reg = <3>;
> > > +
> > > +                            crucsi2: endpoint@0 {
> > > +                                    reg = <0>;
> > > +                                    remote-endpoint= <&csi2cru>;
> > > +                            };
> > > +                    };
> > > +            };
> > > +    };

-- 
Regards,

Laurent Pinchart
