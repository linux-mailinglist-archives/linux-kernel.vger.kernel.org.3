Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9781C4CD5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiCDN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiCDN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:58:37 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A411140;
        Fri,  4 Mar 2022 05:57:45 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 91D7B4000F;
        Fri,  4 Mar 2022 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646402264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbA65nPrAX2xThD9bSY7G2HuvSb6X211QjYjkhktlzg=;
        b=UfQUEWP3rsI6Enh9jhqn5cKpUHchBScrT3T0czYRY+MA1lT46j68Qdk1l74OMvpVPhCSUx
        yOfesq/j7+NW0e1x9b5gQ/AifG7WNlo/z2VmJ92UZc1EGda1RiIGM+AvWSqaP7PxRHRACB
        OdQhd4Z4Bqi9gFX0fmCX6fR9AwYDYHyLqnlaLc+K1QT5RoVZSA/R1wwMfVStVnN9hZj3k2
        RlkrGqNXvw4SxHDSY834928ZM6TxsFfeOK2aX+FmMvqq793JMbHGhz+OGSiY7Y/kct9jaV
        Qe/ek4Zmdq6fzXJd/RxQ8zBIyjScXvjz11ySMoRj1hv0c75ELGuuyKVDa+4Kdg==
Date:   Fri, 4 Mar 2022 14:57:41 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <YiIa1SRFhtvURTbN@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
 <YgqAv2vLimYgRwDS@aptenodytes>
 <YgqM3ZdMfEz+ZKo/@pendragon.ideasonboard.com>
 <Ygt8LF8qx3rnxlgp@aptenodytes>
 <Ygt9j+rwEC+2aUjH@pendragon.ideasonboard.com>
 <Yh4+E9el5NdQ7qJq@aptenodytes>
 <YiH/kLakb/GOaYIT@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WRkj4ua208yWuRhB"
Content-Disposition: inline
In-Reply-To: <YiH/kLakb/GOaYIT@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WRkj4ua208yWuRhB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Fri 04 Mar 22, 14:01, Laurent Pinchart wrote:
> On Tue, Mar 01, 2022 at 04:38:59PM +0100, Paul Kocialkowski wrote:
> > On Tue 15 Feb 22, 12:16, Laurent Pinchart wrote:
> > > On Tue, Feb 15, 2022 at 11:10:52AM +0100, Paul Kocialkowski wrote:
> > > > On Mon 14 Feb 22, 19:09, Laurent Pinchart wrote:
> > > > > On Mon, Feb 14, 2022 at 05:18:07PM +0100, Paul Kocialkowski wrote:
> > > > > > On Mon 07 Feb 22, 17:51, Laurent Pinchart wrote:
> > > > > > > On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski w=
rote:
> > > > > > > > This introduces YAML bindings documentation for the Allwinn=
er A31 Image
> > > > > > > > Signal Processor (ISP).
> > > > > > > >=20
> > > > > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin=
=2Ecom>
> > > > > > > > ---
> > > > > > > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++=
++++++++++++
> > > > > > > >  1 file changed, 117 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/media=
/allwinner,sun6i-a31-isp.yaml
> > > > > > > >=20
> > > > > > > > diff --git a/Documentation/devicetree/bindings/media/allwin=
ner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,=
sun6i-a31-isp.yaml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..2d87022c43ce
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun=
6i-a31-isp.yaml
> > > > > > > > @@ -0,0 +1,117 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a=
31-isp.yaml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Allwinner A31 Image Signal Processor Driver (ISP) D=
evice Tree Bindings
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    enum:
> > > > > > > > +      - allwinner,sun6i-a31-isp
> > > > > > > > +      - allwinner,sun8i-v3s-isp
> > > > > > > > +
> > > > > > > > +  reg:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  interrupts:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  clocks:
> > > > > > > > +    items:
> > > > > > > > +      - description: Bus Clock
> > > > > > > > +      - description: Module Clock
> > > > > > > > +      - description: DRAM Clock
> > > > > > >=20
> > > > > > > That's interesting, does the ISP have a dedicated DRAM ?
> > > > > >=20
> > > > > > It doesn't, it actually uses the main DRAM with the "mbus" inte=
rconnect.
> > > > > > The clock is probably for the DMA engine.
> > > > > >=20
> > > > > > > > +
> > > > > > > > +  clock-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: bus
> > > > > > > > +      - const: mod
> > > > > > > > +      - const: ram
> > > > > > > > +
> > > > > > > > +  resets:
> > > > > > > > +    maxItems: 1
> > > > > > > > +
> > > > > > > > +  ports:
> > > > > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > > > > +
> > > > > > > > +    properties:
> > > > > > > > +      port@0:
> > > > > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > > > > +        description: CSI0 input port
> > > > > > > > +
> > > > > > > > +        properties:
> > > > > > > > +          reg:
> > > > > > > > +            const: 0
> > > > > > > > +
> > > > > > > > +          endpoint:
> > > > > > > > +            $ref: video-interfaces.yaml#
> > > > > > > > +            unevaluatedProperties: false
> > > > > > >=20
> > > > > > > If no other property than remote-endpoint are allowed, I'd wr=
ite
> > > > > > >=20
> > > > > > >           endpoint:
> > > > > > >             $ref: video-interfaces.yaml#
> > > > > > > 	    remote-endpoint: true
> > > > > > >             additionalProperties: false
> > > > > > >=20
> > > > > > > Same below.
> > > > > > >=20
> > > > > > > > +
> > > > > > > > +        additionalProperties: false
> > > > > > > > +
> > > > > > > > +      port@1:
> > > > > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > > > > +        description: CSI1 input port
> > > > > > > > +
> > > > > > > > +        properties:
> > > > > > > > +          reg:
> > > > > > > > +            const: 0
> > > > > > >=20
> > > > > > > This should be 1.
> > > > > >=20
> > > > > > Correct, thanks!
> > > > > >=20
> > > > > > > > +
> > > > > > > > +          endpoint:
> > > > > > > > +            $ref: video-interfaces.yaml#
> > > > > > > > +            unevaluatedProperties: false
> > > > > > > > +
> > > > > > > > +        additionalProperties: false
> > > > > > > > +
> > > > > > > > +    anyOf:
> > > > > > > > +      - required:
> > > > > > > > +        - port@0
> > > > > > > > +      - required:
> > > > > > > > +        - port@1
> > > > > > >=20
> > > > > > > As ports are an intrinsic property of the ISP, both should be=
 required,
> > > > > > > but they don't have to be connected.
> > > > > >=20
> > > > > > Well the ISP does have the ability to source from either CSI0 a=
nd CSI1
> > > > > > but I don't really get the point of declaring both ports when o=
nly one
> > > > > > of the two controllers is present.
> > > > >=20
> > > > > If it's within an SoC I don't mind too much. What I usually insis=
t on is
> > > > > declaring all ports even when no external devices are connected o=
n the
> > > > > board. It may however be easier to implement things on the driver=
 side
> > > > > when all the ports are declared, even for internal devices. I won=
't
> > > > > insist either way here.
> > > > >=20
> > > > > > > By the way, how do you select at runtime which CSI-2 RX the I=
SP gets its
> > > > > > > image stream from ? Is it configured through registers of the=
 ISP ?
> > > > > >=20
> > > > > > Actually what the ISP gets is fully dependent on what is receiv=
ed by the
> > > > > > CSI controller it is connected to (which can be the mipi csi-2 =
controller
> > > > > > or its direct parallel pins), so the configuration happens on t=
he CSI side.
> > > > >=20
> > > > > OK, then how do you select at runtime which CSI the ISP gets its =
image
> > > > > stream from ? :-)
> > > >=20
> > > > What is done in the driver is that all available csi(s) entities pa=
ds are linked
> > > > to a single csi sink media pad, which allows userspace to enable on=
e or the
> > > > other. If there's only one, it's enabled by default.
> > > >=20
> > > > The actual stream source (isp_dev->proc.source) is selected at link=
_validate
> > > > time and the source bit is set in sun6i_isp_proc_enable.
> > > >=20
> > > > I hope this answers your question!
> > >=20
> > > Yes it does, thank you.
> > >=20
> > > While this works, it makes life a bit more complicated for userspace,=
 as
> > > switching between the two sources require disabling the link first and
> > > then enabling the new one. This is something that caused issues in the
> > > libcamera simple pipeline handler, I ended up having to implement a
> > > workaround.
> >=20
> > That surprises me a bit, I thought this was a typical use-case for link=
s.
> > So the fact that it's a two-step process causes issues somehow?
>=20
> It's not so much that the links have to be configured in two steps
> (although it would be nice if that could be fixed), but the fact that
> the order of the operations matter. Userspace has to know what
> combination of links is acceptable in order to determine the order of
> the enable/disable operations, otherwise errors may be returned. That
> makes it more difficult to write generic userspace code.

Ah right, I understand that. Now it's pretty much trial-and-error if usersp=
ace
doesn't have prior knowledge about the hardware. But to be honest I assumed
that it was more or less understood that there cannot be fully generic
userspace for this and that knowedlege about the driver and pipeline flow
is required to do things right.

> > > Could you instead have two sink pads for the ISP, and select the sens=
or
> > > at stream on time instead of link validation time by checking which l=
ink
> > > is enabled ? If no links or both links are enabled, you can then retu=
rn
> > > an error.
> >=20
> > Yes that's totally doable.
> >=20
> > There's a similar situation with the sun6i-csi bridge where the source =
pad
> > has two possible links: one for routing to sun6i-csi capture (video dev=
ice)
> > and one for routing to the isp entity.
> >=20
> > Would that also be best represented as two pads?
>=20
> Are the two outputs mutually exclusive ? Sorry if I've asked before.

I don't think you have. Yes they are mutually exclusive, only one source
can be selected at a time. Same situation as the ISP where the two CSI unit
inputs are mutually exclusive.

> > > Ideally I'd say such internal routing should use the new V4L2 subdev
> > > routing API that is currently being implemented (see [1]), but I don't
> > > know when it will land, and I don't want to delay your patch series.
> > >=20
> > > [1] https://lore.kernel.org/linux-media/20211130141536.891878-28-tomi=
=2Evalkeinen@ideasonboard.com
> >=20
> > I'm still a bit confused what problem this is trying to solve.
> > My understanding was that the current pad/link API allows representing =
complex
> > topologies and switching different paths with link enable/disable.
>=20
> That was the intent of the MEDIA_IOC_SETUP_LINK ioctl, but we ended up
> with something that is fairly ill-defined, and doesn't have the ability
> to set multiple links atomically. It turned out to be less usable for
> userspace than expected. Mistakes happen (and I'll blame myself here,
> having designed that API) when we don't have real test cases during
> kernel development.

Yeah it's hard to predict these kinds of things in advance I suppose.
Thanks for the heads up!

Paul

> > > > > > > > +
> > > > > > > > +required:
> > > > > > > > +  - compatible
> > > > > > > > +  - reg
> > > > > > > > +  - interrupts
> > > > > > > > +  - clocks
> > > > > > > > +  - clock-names
> > > > > > > > +  - resets
> > > > > > > > +
> > > > > > > > +additionalProperties: false
> > > > > > > > +
> > > > > > > > +examples:
> > > > > > > > +  - |
> > > > > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > > > > > > > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > > > > > > > +
> > > > > > > > +    isp: isp@1cb8000 {
> > > > > > > > +        compatible =3D "allwinner,sun8i-v3s-isp";
> > > > > > > > +        reg =3D <0x01cb8000 0x1000>;
> > > > > > > > +        interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > +        clocks =3D <&ccu CLK_BUS_CSI>,
> > > > > > > > +             <&ccu CLK_CSI1_SCLK>,
> > > > > > > > +             <&ccu CLK_DRAM_CSI>;
> > > > > > > > +        clock-names =3D "bus", "mod", "ram";
> > > > > > > > +        resets =3D <&ccu RST_BUS_CSI>;
> > > > > > > > +
> > > > > > > > +        ports {
> > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > +
> > > > > > > > +            port@0 {
> > > > > > > > +                reg =3D <0>;
> > > > > > > > +
> > > > > > > > +                isp_in_csi0: endpoint {
> > > > > > > > +                    remote-endpoint =3D <&csi0_out_isp>;
> > > > > > > > +                };
> > > > > > > > +            };
> > > > > > > > +        };
> > > > > > > > +    };
> > > > > > > > +
> > > > > > > > +...
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--WRkj4ua208yWuRhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIiGtQACgkQ3cLmz3+f
v9E9jAf/UmghrQ9EF6S6cNDU1Lj0fic+6XY05dzxqjGmg3T04ECUKp1s6Nc0HDx2
10h0JjnaOcfDK02/6wA7tFjWUGwyjl0E1VkccNzDjduokwoztFrfxV2Yo1K0CMf3
55lHC2Wzffq9+QJBUMbQBv3ifEuV+WRztXQ2q3jM0+DOr7iuqDHc9qlM6zPoHb8Q
Y4SE1la4b8v7GIHImFHV7JMUTwTRbEBQdD9fh/Zv2UldOBpQb8QaKNkDsgOXF6x1
7xMYkP8kvqy2XwxfsIbvT9U2wORDfVk/9hvkzsMmOmjdBRdEGgC6hz68jm6yL4C7
TrqcH3Lv5542qum8lqmGOTvLPHFeHg==
=VrrZ
-----END PGP SIGNATURE-----

--WRkj4ua208yWuRhB--
