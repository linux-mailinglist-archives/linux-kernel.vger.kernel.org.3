Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75504B55E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356260AbiBNQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:18:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiBNQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:18:21 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62DB42EE7;
        Mon, 14 Feb 2022 08:18:12 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 357821C0011;
        Mon, 14 Feb 2022 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644855491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hM+ru5u7PcluuJvjGqXNk3orFdAMH6kUmIvC7PbQy8Q=;
        b=WFwzXudhLBkE77Y0CtOf41jdfDf5JV5DDOB3ffkcj/wyr/4Ncbh4pSQJ6HP2ANSz1kRloU
        CqfkG4hLSFEfy4X/Juzosr/jE4LXdEfjmYdTKMVJ2YC4yt545fF8D5DxgCagDKSg76NOZ5
        hfbZGwS1aFIbOYrgXkGQklH14eD2AgbJ+u1VOqx25Ci32bdT983bfCcM2Whnuuk6p4Nzvc
        2/xIiltbxk631yzvLSyha67Mwhset3Yslx78eRSxgmRJMJWE5K7GPUMMUbDivlH2YXHHas
        dvyLTRO/Q+6KgNfVpR9lXKcrxDI01hSD3Ds5Q4l6nWxQfoMXbWhLeyCpAhTnIA==
Date:   Mon, 14 Feb 2022 17:18:07 +0100
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
Message-ID: <YgqAv2vLimYgRwDS@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-62-paul.kocialkowski@bootlin.com>
 <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rUIQNSxQhXpZGdlG"
Content-Disposition: inline
In-Reply-To: <YgE/+UmP4nJVxtRT@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rUIQNSxQhXpZGdlG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Thanks for the review and the follow-up questions!

On Mon 07 Feb 22, 17:51, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Sat, Feb 05, 2022 at 07:54:24PM +0100, Paul Kocialkowski wrote:
> > This introduces YAML bindings documentation for the Allwinner A31 Image
> > Signal Processor (ISP).
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,s=
un6i-a31-isp.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-is=
p.yaml
> > new file mode 100644
> > index 000000000000..2d87022c43ce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.y=
aml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree B=
indings
> > +
> > +maintainers:
> > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - allwinner,sun6i-a31-isp
> > +      - allwinner,sun8i-v3s-isp
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Module Clock
> > +      - description: DRAM Clock
>=20
> That's interesting, does the ISP have a dedicated DRAM ?

It doesn't, it actually uses the main DRAM with the "mbus" interconnect.
The clock is probably for the DMA engine.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: mod
> > +      - const: ram
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: CSI0 input port
> > +
> > +        properties:
> > +          reg:
> > +            const: 0
> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
>=20
> If no other property than remote-endpoint are allowed, I'd write
>=20
>           endpoint:
>             $ref: video-interfaces.yaml#
> 	    remote-endpoint: true
>             additionalProperties: false
>=20
> Same below.
>=20
> > +
> > +        additionalProperties: false
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: CSI1 input port
> > +
> > +        properties:
> > +          reg:
> > +            const: 0
>=20
> This should be 1.

Correct, thanks!

> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +        additionalProperties: false
> > +
> > +    anyOf:
> > +      - required:
> > +        - port@0
> > +      - required:
> > +        - port@1
>=20
> As ports are an intrinsic property of the ISP, both should be required,
> but they don't have to be connected.

Well the ISP does have the ability to source from either CSI0 and CSI1
but I don't really get the point of declaring both ports when only one
of the two controllers is present.

> By the way, how do you select at runtime which CSI-2 RX the ISP gets its
> image stream from ? Is it configured through registers of the ISP ?

Actually what the ISP gets is fully dependent on what is received by the
CSI controller it is connected to (which can be the mipi csi-2 controller
or its direct parallel pins), so the configuration happens on the CSI side.

Thanks,

Paul

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
> > +    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
> > +
> > +    isp: isp@1cb8000 {
> > +        compatible =3D "allwinner,sun8i-v3s-isp";
> > +        reg =3D <0x01cb8000 0x1000>;
> > +        interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&ccu CLK_BUS_CSI>,
> > +             <&ccu CLK_CSI1_SCLK>,
> > +             <&ccu CLK_DRAM_CSI>;
> > +        clock-names =3D "bus", "mod", "ram";
> > +        resets =3D <&ccu RST_BUS_CSI>;
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +
> > +                isp_in_csi0: endpoint {
> > +                    remote-endpoint =3D <&csi0_out_isp>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rUIQNSxQhXpZGdlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIKgL8ACgkQ3cLmz3+f
v9GfAQf9FBuxs+1Ss0Fo0P8ubwRTkEC0jBKpZJWIk34Th3r2XNEWFavlQCDxliGR
NMmLEUTj/IWw/wSJ2QthN9bjoV9tg9B3fnS/Bv+bVvks28xJfm7VB2t0G8+MAaYC
B527FNIGywcOjGKrHPqUi08sr/Gkav3EVzbI07zEaoETIGRxkSNRrMAbX3hy3brz
P884skdMilduSSc/wHsmEIVHO0khLSFzTlpls7gean0Htdo/SwkeXmUQxniaDe3U
wczgeahnLFUoH+0IUbhCWNM+Leyq+KVilSgzob9rZsxB4CzNlAvUMS06Ou5wMsW0
tR5r8BmKLHbXkRBU2zvuDdGCoQF/Ow==
=8+HW
-----END PGP SIGNATURE-----

--rUIQNSxQhXpZGdlG--
