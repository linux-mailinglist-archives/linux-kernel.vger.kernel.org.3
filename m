Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56074D9891
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbiCOKPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiCOKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:14:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AE13EA0;
        Tue, 15 Mar 2022 03:13:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA90C2A5;
        Tue, 15 Mar 2022 11:13:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647339200;
        bh=TSCI/jlTrreFhvhlF9Uro+LXlPKdR7g2kIaeukooB9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeZeorcDCnIYsfEq/XYQS0hy+pQ1JVfLT6X1/D95RGh0Q88GVELQ3gZg90ZF5OHdz
         v6EbWQ2bGc42W/AlZATWCh83R9YLezE/VwdVOrsr5ow2HvTQVfPZu0ltzsvAakwX24
         rP8wjX5YQ05hMi/VzNQpQqCiku40GjeCeY534dP4=
Date:   Tue, 15 Mar 2022 12:13:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 61/66] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YjBmrzPuN3oqW6Hm@pendragon.ideasonboard.com>
References: <YgqM3ZdMfEz+ZKo/@pendragon.ideasonboard.com>
 <Ygt8LF8qx3rnxlgp@aptenodytes>
 <Ygt9j+rwEC+2aUjH@pendragon.ideasonboard.com>
 <Yh4+E9el5NdQ7qJq@aptenodytes>
 <YiH/kLakb/GOaYIT@pendragon.ideasonboard.com>
 <YiIa1SRFhtvURTbN@aptenodytes>
 <YiIdo4PF/5smLocf@pendragon.ideasonboard.com>
 <YitZ6y2JoNzeHUrp@aptenodytes>
 <Yi4YpnMWguEMWYaA@pendragon.ideasonboard.com>
 <YjBhMNZsJz7crDuX@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjBhMNZsJz7crDuX@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Mar 15, 2022 at 10:49:36AM +0100, Paul Kocialkowski wrote:
> On Sun 13 Mar 22, 18:15, Laurent Pinchart wrote:
> > On Fri, Mar 11, 2022 at 03:17:15PM +0100, Paul Kocialkowski wrote:
> > > On Fri 04 Mar 22, 16:09, Laurent Pinchart wrote:
> > > > On Fri, Mar 04, 2022 at 02:57:41PM +0100, Paul Kocialkowski wrote:
> > > > > On Fri 04 Mar 22, 14:01, Laurent Pinchart wrote:
> > > > > > On Tue, Mar 01, 2022 at 04:38:59PM +0100, Paul Kocialkowski wrote:
> > > > > > > On Tue 15 Feb 22, 12:16, Laurent Pinchart wrote:
> > > > > > > > On Tue, Feb 15, 2022 at 11:10:52AM +0100, Paul Kocialkowski wrote:
> > > > > > > > > On Mon 14 Feb 22, 19:09, Laurent Pinchart wrote:
> > > > > > > > > > On Mon, Feb 14, 2022 at 05:18:07PM +0100, Paul Kocialkowski wrote:
> > > > > > > > > > > On Mon 07 Feb 22, 17:51, Laurent Pinchart wrote:
> > > > > > > > > > > > On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > > > > > > > > > > > > This introduces YAML bindings documentation for the Allwinner A31 Image
> > > > > > > > > > > > > Signal Processor (ISP).
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
> > > > > > > > > > > > >  1 file changed, 117 insertions(+)
> > > > > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > > > > > > > > > new file mode 100644
> > > > > > > > > > > > > index 000000000000..2d87022c43ce
> > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > > > > > > > > > > > @@ -0,0 +1,117 @@
> > > > > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > > > > > > +%YAML 1.2
> > > > > > > > > > > > > +---
> > > > > > > > > > > > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > > > > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +maintainers:
> > > > > > > > > > > > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +properties:
> > > > > > > > > > > > > +  compatible:
> > > > > > > > > > > > > +    enum:
> > > > > > > > > > > > > +      - allwinner,sun6i-a31-isp
> > > > > > > > > > > > > +      - allwinner,sun8i-v3s-isp
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  reg:
> > > > > > > > > > > > > +    maxItems: 1
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  interrupts:
> > > > > > > > > > > > > +    maxItems: 1
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  clocks:
> > > > > > > > > > > > > +    items:
> > > > > > > > > > > > > +      - description: Bus Clock
> > > > > > > > > > > > > +      - description: Module Clock
> > > > > > > > > > > > > +      - description: DRAM Clock
> > > > > > > > > > > > 
> > > > > > > > > > > > That's interesting, does the ISP have a dedicated DRAM ?
> > > > > > > > > > > 
> > > > > > > > > > > It doesn't, it actually uses the main DRAM with the "mbus" interconnect.
> > > > > > > > > > > The clock is probably for the DMA engine.
> > > > > > > > > > > 
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  clock-names:
> > > > > > > > > > > > > +    items:
> > > > > > > > > > > > > +      - const: bus
> > > > > > > > > > > > > +      - const: mod
> > > > > > > > > > > > > +      - const: ram
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  resets:
> > > > > > > > > > > > > +    maxItems: 1
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  ports:
> > > > > > > > > > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > +      port@0:
> > > > > > > > > > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > > > > > > > > > +        description: CSI0 input port
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        properties:
> > > > > > > > > > > > > +          reg:
> > > > > > > > > > > > > +            const: 0
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +          endpoint:
> > > > > > > > > > > > > +            $ref: video-interfaces.yaml#
> > > > > > > > > > > > > +            unevaluatedProperties: false
> > > > > > > > > > > > 
> > > > > > > > > > > > If no other property than remote-endpoint are allowed, I'd write
> > > > > > > > > > > > 
> > > > > > > > > > > >           endpoint:
> > > > > > > > > > > >             $ref: video-interfaces.yaml#
> > > > > > > > > > > > 	    remote-endpoint: true
> > > > > > > > > > > >             additionalProperties: false
> > > > > > > > > > > > 
> > > > > > > > > > > > Same below.
> > > > > > > > > > > > 
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        additionalProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +      port@1:
> > > > > > > > > > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > > > > > > > > > +        description: CSI1 input port
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        properties:
> > > > > > > > > > > > > +          reg:
> > > > > > > > > > > > > +            const: 0
> > > > > > > > > > > > 
> > > > > > > > > > > > This should be 1.
> > > > > > > > > > > 
> > > > > > > > > > > Correct, thanks!
> > > > > > > > > > > 
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +          endpoint:
> > > > > > > > > > > > > +            $ref: video-interfaces.yaml#
> > > > > > > > > > > > > +            unevaluatedProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        additionalProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    anyOf:
> > > > > > > > > > > > > +      - required:
> > > > > > > > > > > > > +        - port@0
> > > > > > > > > > > > > +      - required:
> > > > > > > > > > > > > +        - port@1
> > > > > > > > > > > > 
> > > > > > > > > > > > As ports are an intrinsic property of the ISP, both should be required,
> > > > > > > > > > > > but they don't have to be connected.
> > > > > > > > > > > 
> > > > > > > > > > > Well the ISP does have the ability to source from either CSI0 and CSI1
> > > > > > > > > > > but I don't really get the point of declaring both ports when only one
> > > > > > > > > > > of the two controllers is present.
> > > > > > > > > > 
> > > > > > > > > > If it's within an SoC I don't mind too much. What I usually insist on is
> > > > > > > > > > declaring all ports even when no external devices are connected on the
> > > > > > > > > > board. It may however be easier to implement things on the driver side
> > > > > > > > > > when all the ports are declared, even for internal devices. I won't
> > > > > > > > > > insist either way here.
> > > > > > > > > > 
> > > > > > > > > > > > By the way, how do you select at runtime which CSI-2 RX the ISP gets its
> > > > > > > > > > > > image stream from ? Is it configured through registers of the ISP ?
> > > > > > > > > > > 
> > > > > > > > > > > Actually what the ISP gets is fully dependent on what is received by the
> > > > > > > > > > > CSI controller it is connected to (which can be the mipi csi-2 controller
> > > > > > > > > > > or its direct parallel pins), so the configuration happens on the CSI side.
> > > > > > > > > > 
> > > > > > > > > > OK, then how do you select at runtime which CSI the ISP gets its image
> > > > > > > > > > stream from ? :-)
> > > > > > > > > 
> > > > > > > > > What is done in the driver is that all available csi(s) entities pads are linked
> > > > > > > > > to a single csi sink media pad, which allows userspace to enable one or the
> > > > > > > > > other. If there's only one, it's enabled by default.
> > > > > > > > > 
> > > > > > > > > The actual stream source (isp_dev->proc.source) is selected at link_validate
> > > > > > > > > time and the source bit is set in sun6i_isp_proc_enable.
> > > > > > > > > 
> > > > > > > > > I hope this answers your question!
> > > > > > > > 
> > > > > > > > Yes it does, thank you.
> > > > > > > > 
> > > > > > > > While this works, it makes life a bit more complicated for userspace, as
> > > > > > > > switching between the two sources require disabling the link first and
> > > > > > > > then enabling the new one. This is something that caused issues in the
> > > > > > > > libcamera simple pipeline handler, I ended up having to implement a
> > > > > > > > workaround.
> > > > > > > 
> > > > > > > That surprises me a bit, I thought this was a typical use-case for links.
> > > > > > > So the fact that it's a two-step process causes issues somehow?
> > > > > > 
> > > > > > It's not so much that the links have to be configured in two steps
> > > > > > (although it would be nice if that could be fixed), but the fact that
> > > > > > the order of the operations matter. Userspace has to know what
> > > > > > combination of links is acceptable in order to determine the order of
> > > > > > the enable/disable operations, otherwise errors may be returned. That
> > > > > > makes it more difficult to write generic userspace code.
> > > > > 
> > > > > Ah right, I understand that. Now it's pretty much trial-and-error if userspace
> > > > > doesn't have prior knowledge about the hardware. But to be honest I assumed
> > > > > that it was more or less understood that there cannot be fully generic
> > > > > userspace for this and that knowedlege about the driver and pipeline flow
> > > > > is required to do things right.
> > > > 
> > > > You're right, and that's why we have device-specific code in libcamera.
> > > > However, the more generic-friendly the APIs can be, the more the
> > > > device-specific userspace code will be able to use generic helpers, so
> > > > it still matters.
> > > > 
> > > > > > > > Could you instead have two sink pads for the ISP, and select the sensor
> > > > > > > > at stream on time instead of link validation time by checking which link
> > > > > > > > is enabled ? If no links or both links are enabled, you can then return
> > > > > > > > an error.
> > > > > > > 
> > > > > > > Yes that's totally doable.
> > > > > > > 
> > > > > > > There's a similar situation with the sun6i-csi bridge where the source pad
> > > > > > > has two possible links: one for routing to sun6i-csi capture (video device)
> > > > > > > and one for routing to the isp entity.
> > > > > > > 
> > > > > > > Would that also be best represented as two pads?
> > > > > > 
> > > > > > Are the two outputs mutually exclusive ? Sorry if I've asked before.
> > > > > 
> > > > > I don't think you have. Yes they are mutually exclusive, only one source
> > > > > can be selected at a time. Same situation as the ISP where the two CSI unit
> > > > > inputs are mutually exclusive.
> > > > 
> > > > On the sink (input) side that's quite common, if you have two different
> > > > sources but a single sink, the sink can't (usually) process both sources
> > > > at the same time. I understand that for the sun6i-csi bridge it's the
> > > > other way around, with the bridge can output to either a DMA engine or
> > > > to the ISP, but not both at the same time. That's less common, but can
> > > > certainly happen. I think I'd go for two source pads in that case too.
> > > > Sakari, any opinion ?
> > > 
> > > As I was reading this thread again, I think there might be a misunderstanding
> > > here when you said that "switching between the two sources require disabling
> > > the link first and then enabling the new one".
> > > 
> > > The driver is currently not checking the validity of the setup at link_setup
> > > but at link_validate (which is called at streamon time), so userspace can
> > > effectively disable/enable links in whichever order and a valid setup is only
> > > required when streaming starts. I think that's already the situation that you
> > > want to achieve.
> > 
> > That's right. link_validate is probably not the best place though, as
> > it's meant to validate one link, while here you need to perform
> > validation of the state of multiple links, right ?
> 
> Yeah actually I'm starting to think that unexpected situations may not be
> correctly handled here. I'll have a closer look at it. It feels like the
> best approach would be to keep track each source's enabled state with
> link_setup and check that only one is enabled at streamon time.

You don't even necessarily have to keep track in link_setup, you could
iterate through links at streamon time to ensure one and only one is
enabled. As this is a common use case, a helper function to do that
would be useful.

> > > To summarize, the following pads can have multiple links:
> > > - csi sink (parallel sensor source or mipi csi-2 bridge source)
> > > - csi source (isp sink or video capture sink)
> > > - isp sink (csi0 source or csi1 source)
> > > 
> > > I'll send my next versions without changes (one pad, multiple links)
> > > but we can revisit this if there's an issue with that after all.
> > 
> > OK.
> > 
> > > > > > > > Ideally I'd say such internal routing should use the new V4L2 subdev
> > > > > > > > routing API that is currently being implemented (see [1]), but I don't
> > > > > > > > know when it will land, and I don't want to delay your patch series.
> > > > > > > > 
> > > > > > > > [1] https://lore.kernel.org/linux-media/20211130141536.891878-28-tomi.valkeinen@ideasonboard.com
> > > > > > > 
> > > > > > > I'm still a bit confused what problem this is trying to solve.
> > > > > > > My understanding was that the current pad/link API allows representing complex
> > > > > > > topologies and switching different paths with link enable/disable.
> > > > > > 
> > > > > > That was the intent of the MEDIA_IOC_SETUP_LINK ioctl, but we ended up
> > > > > > with something that is fairly ill-defined, and doesn't have the ability
> > > > > > to set multiple links atomically. It turned out to be less usable for
> > > > > > userspace than expected. Mistakes happen (and I'll blame myself here,
> > > > > > having designed that API) when we don't have real test cases during
> > > > > > kernel development.
> > > > > 
> > > > > Yeah it's hard to predict these kinds of things in advance I suppose.
> > > > > Thanks for the heads up!
> > > > > 
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +required:
> > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > +  - interrupts
> > > > > > > > > > > > > +  - clocks
> > > > > > > > > > > > > +  - clock-names
> > > > > > > > > > > > > +  - resets
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +additionalProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > > > > > > > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > > > > > > > > > > > > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    isp: isp@1cb8000 {
> > > > > > > > > > > > > +        compatible = "allwinner,sun8i-v3s-isp";
> > > > > > > > > > > > > +        reg = <0x01cb8000 0x1000>;
> > > > > > > > > > > > > +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > > > > > > +        clocks = <&ccu CLK_BUS_CSI>,
> > > > > > > > > > > > > +             <&ccu CLK_CSI1_SCLK>,
> > > > > > > > > > > > > +             <&ccu CLK_DRAM_CSI>;
> > > > > > > > > > > > > +        clock-names = "bus", "mod", "ram";
> > > > > > > > > > > > > +        resets = <&ccu RST_BUS_CSI>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        ports {
> > > > > > > > > > > > > +            #address-cells = <1>;
> > > > > > > > > > > > > +            #size-cells = <0>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            port@0 {
> > > > > > > > > > > > > +                reg = <0>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                isp_in_csi0: endpoint {
> > > > > > > > > > > > > +                    remote-endpoint = <&csi0_out_isp>;
> > > > > > > > > > > > > +                };
> > > > > > > > > > > > > +            };
> > > > > > > > > > > > > +        };
> > > > > > > > > > > > > +    };
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +...

-- 
Regards,

Laurent Pinchart
