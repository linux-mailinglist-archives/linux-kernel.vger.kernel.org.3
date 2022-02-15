Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA84B68E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiBOKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiBOKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:11:07 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B988B1D;
        Tue, 15 Feb 2022 02:10:56 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D0DD31BF214;
        Tue, 15 Feb 2022 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644919855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFSUgnMPM4RIULavl5LQNMn3BXMoJoSSok2BuLvqbxI=;
        b=f9e5T1eT9Sf20+5ubeUYInS9hRyyBcQ9k/EUA0vFe1tMUFPUuUH2kLPtEXrY1jRXt/ZKQi
        gKTDAsm6GMOdkmDuC7JCOqwsVXBT8+ciuqGc5tWJD4aYgSEdzMbGrK9YQCjto+hoILiWTe
        TxMbnz/nAbcsaXcfDRhpk60zu+nldhcPTql01RJqzVKtc4Id7dTmqFrK+2JC1Ee2XClYp2
        3AUfkxcNdaRHfMHKdo/NrGhNIgyqeWWbKV0FH+jjcSWosC9GzFXQUlBk9+hJ9PGLYxixkS
        BHKj5HL8a2/okirgTSubL2TXmuHkqyG3MNdl4zd6rDr3wnb1cQtiVO4X07wg/g==
Date:   Tue, 15 Feb 2022 11:10:52 +0100
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
Message-ID: <Ygt8LF8qx3rnxlgp@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
 <YgqAv2vLimYgRwDS@aptenodytes>
 <YgqM3ZdMfEz+ZKo/@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZfQyJZmLCE9mH4eu"
Content-Disposition: inline
In-Reply-To: <YgqM3ZdMfEz+ZKo/@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfQyJZmLCE9mH4eu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Mon 14 Feb 22, 19:09, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Mon, Feb 14, 2022 at 05:18:07PM +0100, Paul Kocialkowski wrote:
> > On Mon 07 Feb 22, 17:51, Laurent Pinchart wrote:
> > > On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > > > This introduces YAML bindings documentation for the Allwinner A31 I=
mage
> > > > Signal Processor (ISP).
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++=
++++
> > > >  1 file changed, 117 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/allwinn=
er,sun6i-a31-isp.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6=
i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-isp.yaml
> > > > new file mode 100644
> > > > index 000000000000..2d87022c43ce
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-i=
sp.yaml
> > > > @@ -0,0 +1,117 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.y=
aml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tr=
ee Bindings
> > > > +
> > > > +maintainers:
> > > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - allwinner,sun6i-a31-isp
> > > > +      - allwinner,sun8i-v3s-isp
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Bus Clock
> > > > +      - description: Module Clock
> > > > +      - description: DRAM Clock
> > >=20
> > > That's interesting, does the ISP have a dedicated DRAM ?
> >=20
> > It doesn't, it actually uses the main DRAM with the "mbus" interconnect.
> > The clock is probably for the DMA engine.
> >=20
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: bus
> > > > +      - const: mod
> > > > +      - const: ram
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        description: CSI0 input port
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            const: 0
> > > > +
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > >=20
> > > If no other property than remote-endpoint are allowed, I'd write
> > >=20
> > >           endpoint:
> > >             $ref: video-interfaces.yaml#
> > > 	    remote-endpoint: true
> > >             additionalProperties: false
> > >=20
> > > Same below.
> > >=20
> > > > +
> > > > +        additionalProperties: false
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        description: CSI1 input port
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            const: 0
> > >=20
> > > This should be 1.
> >=20
> > Correct, thanks!
> >=20
> > > > +
> > > > +          endpoint:
> > > > +            $ref: video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > > > +
> > > > +        additionalProperties: false
> > > > +
> > > > +    anyOf:
> > > > +      - required:
> > > > +        - port@0
> > > > +      - required:
> > > > +        - port@1
> > >=20
> > > As ports are an intrinsic property of the ISP, both should be require=
d,
> > > but they don't have to be connected.
> >=20
> > Well the ISP does have the ability to source from either CSI0 and CSI1
> > but I don't really get the point of declaring both ports when only one
> > of the two controllers is present.
>=20
> If it's within an SoC I don't mind too much. What I usually insist on is
> declaring all ports even when no external devices are connected on the
> board. It may however be easier to implement things on the driver side
> when all the ports are declared, even for internal devices. I won't
> insist either way here.
>=20
> > > By the way, how do you select at runtime which CSI-2 RX the ISP gets =
its
> > > image stream from ? Is it configured through registers of the ISP ?
> >=20
> > Actually what the ISP gets is fully dependent on what is received by the
> > CSI controller it is connected to (which can be the mipi csi-2 controll=
er
> > or its direct parallel pins), so the configuration happens on the CSI s=
ide.
>=20
> OK, then how do you select at runtime which CSI the ISP gets its image
> stream from ? :-)

What is done in the driver is that all available csi(s) entities pads are l=
inked
to a single csi sink media pad, which allows userspace to enable one or the
other. If there's only one, it's enabled by default.

The actual stream source (isp_dev->proc.source) is selected at link_validate
time and the source bit is set in sun6i_isp_proc_enable.

I hope this answers your question!

Thanks,

Paul

> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - resets
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > > > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > > > +
> > > > +    isp: isp@1cb8000 {
> > > > +        compatible =3D "allwinner,sun8i-v3s-isp";
> > > > +        reg =3D <0x01cb8000 0x1000>;
> > > > +        interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > > +        clocks =3D <&ccu CLK_BUS_CSI>,
> > > > +             <&ccu CLK_CSI1_SCLK>,
> > > > +             <&ccu CLK_DRAM_CSI>;
> > > > +        clock-names =3D "bus", "mod", "ram";
> > > > +        resets =3D <&ccu RST_BUS_CSI>;
> > > > +
> > > > +        ports {
> > > > +            #address-cells =3D <1>;
> > > > +            #size-cells =3D <0>;
> > > > +
> > > > +            port@0 {
> > > > +                reg =3D <0>;
> > > > +
> > > > +                isp_in_csi0: endpoint {
> > > > +                    remote-endpoint =3D <&csi0_out_isp>;
> > > > +                };
> > > > +            };
> > > > +        };
> > > > +    };
> > > > +
> > > > +...
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ZfQyJZmLCE9mH4eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmILfCwACgkQ3cLmz3+f
v9EwQwgAk/o403dFH/O+AgvwfNTZjkSOYhLmE9/4on9gCn/kX5el2y/KJ7C4m+K2
Cqp0BfXfUVqmv8k1Qpw4V6BJlDcJQQcrMS2RIoJts5lTnSNEN3D1aGGOrGZg4P9Z
zDY5FjhkWSBVKfbKtDQ1TIwtchj7R+N7sK+t8smxXtUwei80ZrvoMaCmFd8uNIow
v9tYf9pQtWJpB/uYEVu1MEikGizoVK3aZ7ZaAYBdwOuX9kfL4Q7trcIoSBVaEBre
Glk2JTBXXIL5qAYW9T0iM6L00JdqBTcM5dZYeXn3gxu4qlpmORCzbFAW09ec9utj
gFyqQy4XnnZ9VLpRpnClpgVP9T+I6A==
=dzzP
-----END PGP SIGNATURE-----

--ZfQyJZmLCE9mH4eu--
