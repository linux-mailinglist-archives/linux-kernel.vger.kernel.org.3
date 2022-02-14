Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A84B5832
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiBNRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiBNRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:11:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55123652C3;
        Mon, 14 Feb 2022 09:11:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C260047F;
        Mon, 14 Feb 2022 18:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644858665;
        bh=JqS9SbZmHIwxe2/FLymyDTJDOdNjYOqTts4RFlMiVPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4HmDLcjbKBUQUrw/PTFWsJNxR2MlAjuiuUBLVdLeHq0jhX4RXJ9eiT2MDARnTcb9
         4TFOp0VvAH2/vIJQO4AvoyIEb/TicIvf98p5GKBbe7qwgEYRCTW3Y3nU/+YiCZT4Gy
         VubXcY49PpCh4xIOtsYAJYXjxDM5PI2TyecX7SfE=
Date:   Mon, 14 Feb 2022 19:10:58 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-staging@lists.linux.dev, Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Message-ID: <YgqNIihM4OgdBUti@pendragon.ideasonboard.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
 <YgZ9GjgasiPljg9X@robh.at.kernel.org>
 <YgbMmLht/AXb5R1y@pendragon.ideasonboard.com>
 <YgqDQs/GJVxZMB+C@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgqDQs/GJVxZMB+C@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 05:28:50PM +0100, Paul Kocialkowski wrote:
> Hi,
> 
> On Fri 11 Feb 22, 22:52, Laurent Pinchart wrote:
> > Hi Rob,
> > 
> > On Fri, Feb 11, 2022 at 09:13:30AM -0600, Rob Herring wrote:
> > > On Mon, Feb 07, 2022 at 05:51:21PM +0200, Laurent Pinchart wrote:
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
> > > > 
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
> > > 
> > > You just mixed a node and a property...
> > 
> > Yes, I meant
> > 
> >            endpoint:
> >              $ref: video-interfaces.yaml#
> >              properties:
> >                remote-endpoint: true
> > 
> > and actually add
> > 
> >              additionalProperties: false
> > 
> > > 'remote-endpoint' is always allowed, so need to put it here and every 
> > > other user. So 'unevaluatedProperties' is correct. But it would be good 
> > > to define what properties from video-interfaces.yaml are used here.
> > 
> > I've been looking at this recently. The usual pattern is to write
> > 
> >     endpoint:
> >       $ref: video-interfaces.yaml#
> >       unevaluatedProperties: false
> >       properties:
> >         hsync-polarity: true
> >         vsync-polarity: true
> > 
> > to express that the hsync-polarity and vsync-polarity properties are
> > used. However, this will still validate fine if, for instance,
> > data-lanes was specified in the device tree. Shouldn't we use
> > additionalProperties instead of unevaluatedProperties here ? If so,
> > specifying remote-endpoint: true seems needed.
> 
> My understanding is that unevaluatedProperties well allow all properties
> defined in the included video-interfaces.yaml ref but reject others
> while additionalProperties will reject any unspecified local property,
> even if it is declared in the ref.
> 
> In any case with the ISP maybe we don't even want to take the ref from
> video-interfaces.yaml since we are dealing with an internal fifo between
> two devices. Maybe it would be more appropriate to ref
> /schemas/graph.yaml#/$defs/endpoint-base, which already defines
> remote-endpoint too.
> 
> What do you think?

Yes, if no additional property are needed, you can replace port-base
with port, it will simplify the bindings.

-- 
Regards,

Laurent Pinchart
