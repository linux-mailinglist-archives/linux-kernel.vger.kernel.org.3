Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563D14B690C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiBOKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:17:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBOKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:17:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5CE06;
        Tue, 15 Feb 2022 02:16:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D06A315;
        Tue, 15 Feb 2022 11:16:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644920214;
        bh=Vpqo09h7HCFknIrAzLb9ruVe3S9lzDoV2wmtEnovrZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eII97Vsk5rHLoGL50vSPpRjgKdcEdLIKPoDiqNWqZnpU19DJ2/FHprYb5uL5BujWC
         uVo9CFuR8UyB5ZTz3kL1F8LDh8kkXxfdxRtvOxqfHBpsiHJ0IrkH84bnpkqBoRakTO
         ANpGvYa62FTXuMu+HtLom8QKCpwEMGqvZS/C1+4o=
Date:   Tue, 15 Feb 2022 12:16:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 61/66] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <Ygt9j+rwEC+2aUjH@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
 <YgqAv2vLimYgRwDS@aptenodytes>
 <YgqM3ZdMfEz+ZKo/@pendragon.ideasonboard.com>
 <Ygt8LF8qx3rnxlgp@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ygt8LF8qx3rnxlgp@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Feb 15, 2022 at 11:10:52AM +0100, Paul Kocialkowski wrote:
> On Mon 14 Feb 22, 19:09, Laurent Pinchart wrote:
> > On Mon, Feb 14, 2022 at 05:18:07PM +0100, Paul Kocialkowski wrote:
> > > On Mon 07 Feb 22, 17:51, Laurent Pinchart wrote:
> > > > On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > > > > This introduces YAML bindings documentation for the Allwinner A31 Image
> > > > > Signal Processor (ISP).
> > > > > 
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
> > > > >  1 file changed, 117 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..2d87022c43ce
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > @@ -0,0 +1,117 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> > > > > +
> > > > > +maintainers:
> > > > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - allwinner,sun6i-a31-isp
> > > > > +      - allwinner,sun8i-v3s-isp
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupts:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    items:
> > > > > +      - description: Bus Clock
> > > > > +      - description: Module Clock
> > > > > +      - description: DRAM Clock
> > > > 
> > > > That's interesting, does the ISP have a dedicated DRAM ?
> > > 
> > > It doesn't, it actually uses the main DRAM with the "mbus" interconnect.
> > > The clock is probably for the DMA engine.
> > > 
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: bus
> > > > > +      - const: mod
> > > > > +      - const: ram
> > > > > +
> > > > > +  resets:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  ports:
> > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > +
> > > > > +    properties:
> > > > > +      port@0:
> > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > +        description: CSI0 input port
> > > > > +
> > > > > +        properties:
> > > > > +          reg:
> > > > > +            const: 0
> > > > > +
> > > > > +          endpoint:
> > > > > +            $ref: video-interfaces.yaml#
> > > > > +            unevaluatedProperties: false
> > > > 
> > > > If no other property than remote-endpoint are allowed, I'd write
> > > > 
> > > >           endpoint:
> > > >             $ref: video-interfaces.yaml#
> > > > 	    remote-endpoint: true
> > > >             additionalProperties: false
> > > > 
> > > > Same below.
> > > > 
> > > > > +
> > > > > +        additionalProperties: false
> > > > > +
> > > > > +      port@1:
> > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > +        description: CSI1 input port
> > > > > +
> > > > > +        properties:
> > > > > +          reg:
> > > > > +            const: 0
> > > > 
> > > > This should be 1.
> > > 
> > > Correct, thanks!
> > > 
> > > > > +
> > > > > +          endpoint:
> > > > > +            $ref: video-interfaces.yaml#
> > > > > +            unevaluatedProperties: false
> > > > > +
> > > > > +        additionalProperties: false
> > > > > +
> > > > > +    anyOf:
> > > > > +      - required:
> > > > > +        - port@0
> > > > > +      - required:
> > > > > +        - port@1
> > > > 
> > > > As ports are an intrinsic property of the ISP, both should be required,
> > > > but they don't have to be connected.
> > > 
> > > Well the ISP does have the ability to source from either CSI0 and CSI1
> > > but I don't really get the point of declaring both ports when only one
> > > of the two controllers is present.
> > 
> > If it's within an SoC I don't mind too much. What I usually insist on is
> > declaring all ports even when no external devices are connected on the
> > board. It may however be easier to implement things on the driver side
> > when all the ports are declared, even for internal devices. I won't
> > insist either way here.
> > 
> > > > By the way, how do you select at runtime which CSI-2 RX the ISP gets its
> > > > image stream from ? Is it configured through registers of the ISP ?
> > > 
> > > Actually what the ISP gets is fully dependent on what is received by the
> > > CSI controller it is connected to (which can be the mipi csi-2 controller
> > > or its direct parallel pins), so the configuration happens on the CSI side.
> > 
> > OK, then how do you select at runtime which CSI the ISP gets its image
> > stream from ? :-)
> 
> What is done in the driver is that all available csi(s) entities pads are linked
> to a single csi sink media pad, which allows userspace to enable one or the
> other. If there's only one, it's enabled by default.
> 
> The actual stream source (isp_dev->proc.source) is selected at link_validate
> time and the source bit is set in sun6i_isp_proc_enable.
> 
> I hope this answers your question!

Yes it does, thank you.

While this works, it makes life a bit more complicated for userspace, as
switching between the two sources require disabling the link first and
then enabling the new one. This is something that caused issues in the
libcamera simple pipeline handler, I ended up having to implement a
workaround.

Could you instead have two sink pads for the ISP, and select the sensor
at stream on time instead of link validation time by checking which link
is enabled ? If no links or both links are enabled, you can then return
an error.

Ideally I'd say such internal routing should use the new V4L2 subdev
routing API that is currently being implemented (see [1]), but I don't
know when it will land, and I don't want to delay your patch series.

[1] https://lore.kernel.org/linux-media/20211130141536.891878-28-tomi.valkeinen@ideasonboard.com

> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - interrupts
> > > > > +  - clocks
> > > > > +  - clock-names
> > > > > +  - resets
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > > > > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > > > > +
> > > > > +    isp: isp@1cb8000 {
> > > > > +        compatible = "allwinner,sun8i-v3s-isp";
> > > > > +        reg = <0x01cb8000 0x1000>;
> > > > > +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +        clocks = <&ccu CLK_BUS_CSI>,
> > > > > +             <&ccu CLK_CSI1_SCLK>,
> > > > > +             <&ccu CLK_DRAM_CSI>;
> > > > > +        clock-names = "bus", "mod", "ram";
> > > > > +        resets = <&ccu RST_BUS_CSI>;
> > > > > +
> > > > > +        ports {
> > > > > +            #address-cells = <1>;
> > > > > +            #size-cells = <0>;
> > > > > +
> > > > > +            port@0 {
> > > > > +                reg = <0>;
> > > > > +
> > > > > +                isp_in_csi0: endpoint {
> > > > > +                    remote-endpoint = <&csi0_out_isp>;
> > > > > +                };
> > > > > +            };
> > > > > +        };
> > > > > +    };
> > > > > +
> > > > > +...

-- 
Regards,

Laurent Pinchart
