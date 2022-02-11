Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACE4B2994
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiBKQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:03:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349919AbiBKQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:03:16 -0500
X-Greylist: delayed 1157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 08:03:14 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F035BC;
        Fri, 11 Feb 2022 08:03:14 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1762F240004;
        Fri, 11 Feb 2022 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644595393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9lDiPi/tEXd7VcxvvHOcpDWNMks+EpS4Jkm01UCTlRc=;
        b=Njwo0Z/T4I/lpemsH+MzNZOgM7d0zCmXm0S2Vs0CNNuRP7kW/I/FZocPzywZz1XRPLYjDN
        7PL2/kBWbq17PyLzNTbgScLkTgHGh8cSrGC5mFhbH1pEg37umjkj5OMUXhoKVE+X7aPlZe
        5qp4auB3tAAhRZdDkXVUA4WzSlkN2ZjeYJUUjV/ZHc9ybLhBITyrFvVwL3WgNiajsBsp0l
        pgalpyzLFd8TmzjtVL9/NXt3cTvBoWLodSUOx8GxYTIUhKmlgOHPB6zQC5Yu51eU9NSha3
        ZeKb/cbWBzWm1HS7Wegljp9nFB6hRCG4Vu4QwQo52Rz6tLQjmIvOt8uB2w3bDw==
Date:   Fri, 11 Feb 2022 17:03:09 +0100
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/66] dt-bindings: media: Add Allwinner A31 MIPI
 CSI-2 bindings documentation
Message-ID: <YgaIvXr2GfmJUNLD@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-9-paul.kocialkowski@bootlin.com>
 <YgFELcVluEqr9LAH@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DLL0Q03AcECBpu52"
Content-Disposition: inline
In-Reply-To: <YgFELcVluEqr9LAH@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DLL0Q03AcECBpu52
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Thanks for the review!

On Mon 07 Feb 22, 18:09, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Sat, Feb 05, 2022 at 07:53:31PM +0100, Paul Kocialkowski wrote:
> > This introduces YAML bindings documentation for the Allwinner A31 MIPI
> > CSI-2 controller.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../media/allwinner,sun6i-a31-mipi-csi2.yaml  | 142 ++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,s=
un6i-a31-mipi-csi2.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-=
a31-mipi-csi2.yaml
> > new file mode 100644
> > index 000000000000..09207904b6db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-=
csi2.yaml
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-mipi-csi2=
=2Eyaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A31 MIPI CSI-2 Device Tree Bindings
> > +
> > +maintainers:
> > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun6i-a31-mipi-csi2
> > +      - items:
> > +          - const: allwinner,sun8i-v3s-mipi-csi2
> > +          - const: allwinner,sun6i-a31-mipi-csi2
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
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: mod
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description: MIPI D-PHY
> > +
> > +  phy-names:
> > +    items:
> > +      - const: dphy
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
> > +        description: Input port, connect to a MIPI CSI-2 sensor
> > +
> > +        properties:
> > +          reg:
> > +            const: 0
> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              data-lanes:
> > +                minItems: 1
> > +                maxItems: 4
> > +
> > +            required:
> > +              - data-lanes
> > +
> > +        additionalProperties: false
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: Output port, connect to a CSI controller
> > +
> > +        properties:
> > +          reg:
> > +            const: 1
> > +
> > +          endpoint:
> > +            $ref: video-interfaces.yaml#
> > +            unevaluatedProperties: false
> > +
> > +        additionalProperties: false
>=20
> The two ports should be required.

Agreed.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
>=20
> And ports should be required here.

Sure!

Thanks,

Paul

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
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
> > +    mipi_csi2: csi@1cb1000 {
> > +        compatible =3D "allwinner,sun8i-v3s-mipi-csi2",
> > +                     "allwinner,sun6i-a31-mipi-csi2";
> > +        reg =3D <0x01cb1000 0x1000>;
> > +        interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&ccu CLK_BUS_CSI>,
> > +                 <&ccu CLK_CSI1_SCLK>;
> > +        clock-names =3D "bus", "mod";
> > +        resets =3D <&ccu RST_BUS_CSI>;
> > +
> > +        phys =3D <&dphy>;
> > +        phy-names =3D "dphy";
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            mipi_csi2_in: port@0 {
> > +                reg =3D <0>;
> > +
> > +                mipi_csi2_in_ov5648: endpoint {
> > +                    data-lanes =3D <1 2 3 4>;
> > +
> > +                    remote-endpoint =3D <&ov5648_out_mipi_csi2>;
> > +                };
> > +            };
> > +
> > +            mipi_csi2_out: port@1 {
> > +                reg =3D <1>;
> > +
> > +                mipi_csi2_out_csi0: endpoint {
> > +                    remote-endpoint =3D <&csi0_in_mipi_csi2>;
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

--DLL0Q03AcECBpu52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGiL0ACgkQ3cLmz3+f
v9H2kgf/YOpO7HNyL/f7yp3Rt82ZrAhqT1u/hMvsisSPYXG+gdT6t0QV9P8AKXJ6
jVbnmUXI9XnnLjSt1LyskT3j9xBA+2RwdbM/HwvHJy765Z3Dt5R/TBeY2hPltQgG
PBDHT4ZYnQdgd7DB4znvO58QNq8vXZaiD37l/aTLQQdjl5NSnc51GoHDlWNR2eEl
XjWyP7EH4Dwoq68Mx+iRmgJge3sI1Yod6dZ/0++pTMSgW3bqtXLBJLvhD9qBXYry
vfPD14/6JpNS1c2yImYIe266jNLd/+M5tPJhwVdHfnt1gdZLcASuf3I3P4KjXnqB
YueHalxGWSqPrxlcWc4RSW2KTpdl1w==
=8Pob
-----END PGP SIGNATURE-----

--DLL0Q03AcECBpu52--
