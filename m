Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11414DCB22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiCQQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiCQQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:22:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B6D215900;
        Thu, 17 Mar 2022 09:21:12 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 01AC0E000E;
        Thu, 17 Mar 2022 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647534070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+cYBkfFFvELqWc9QhQrIx+yztmy6I4JHGArTu/5pHI=;
        b=DTjpkPO+Rd8PPKRBmDgIFf8CocPlPj+9wu7TQwKkH/W0cTGtcxwD+qkLdZ4vVrrK5894tJ
        qjWmm6zNPvtp7WuOoZYPoAABdrfPmfdjfZP5alH9VGaORL5zNcW1tO/qyUMSX6N9AfWvHb
        9FtpA38vZpWNVGuIAL8VAY/jdqsLRy9GRiOiezU+eavHdCHz2CqFaHFQfKAU0Qa3D5f8Xl
        ef2mEmAUL09Sfh6bPrDXj7UogiwjaJWP1CmTH1wXKu32D4wRi1/kLzHE7rWzx9Dm32lTYK
        W0DPmtj0k73bDzoXYiEafY2Qh/JG7P24sh+DGhwDqUxrQlAK6mlG4BGScugF8A==
Date:   Thu, 17 Mar 2022 17:21:07 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 7/9] dt-bindings: media: Add Allwinner A83T MIPI CSI-2
 bindings documentation
Message-ID: <YjNf827KuySLowK1@aptenodytes>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
 <20220302220739.144303-8-paul.kocialkowski@bootlin.com>
 <YjHlisNfdobeAta7@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iiX+RlDO9qayM+ej"
Content-Disposition: inline
In-Reply-To: <YjHlisNfdobeAta7@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iiX+RlDO9qayM+ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Wed 16 Mar 22, 15:26, Sakari Ailus wrote:
> Hi Paul,
>=20
> Thanks for the patch.

And thanks for the review!

> On Wed, Mar 02, 2022 at 11:07:37PM +0100, Paul Kocialkowski wrote:
> > This introduces YAML bindings documentation for the Allwinner A83T
> > MIPI CSI-2 controller.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../media/allwinner,sun8i-a83t-mipi-csi2.yaml | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,s=
un8i-a83t-mipi-csi2.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun8i-a8=
3t-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun8i=
-a83t-mipi-csi2.yaml
> > new file mode 100644
> > index 000000000000..75121b402435
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi=
-csi2.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/allwinner,sun8i-a83t-mipi-csi=
2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner A83T MIPI CSI-2 Device Tree Bindings
> > +
> > +maintainers:
> > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: allwinner,sun8i-a83t-mipi-csi2
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
> > +      - description: MIPI-specific Clock
> > +      - description: Misc CSI Clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: mod
> > +      - const: mipi
> > +      - const: misc
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
> > +              clock-lanes:
> > +                maxItems: 1
>=20
> Does the hardware support lane reordering? If not, the property should be
> omitted here.

I'm not sure what this relates to. Is it about inverting the clock lane with
a data lane? I'm a bit confused about logical vs physical lane in the conte=
xt
of MIPI CSI-2.

The controller has dedicated pins for the clock and data lanes and supports
filtering packets based on virtual channel or data type.

Are the clock-lanes and data-lanes only relevant for reordering?
IIRC they are also necessary to get the lanes count in the driver.

> I can also remove the three lines here while applying the patches.

I think this series will need another iteration anyway, so let's wait.

Paul

> > +
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
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/sun8i-a83t-ccu.h>
> > +    #include <dt-bindings/reset/sun8i-a83t-ccu.h>
> > +
> > +    mipi_csi2: csi@1cb1000 {
> > +        compatible =3D "allwinner,sun8i-a83t-mipi-csi2";
> > +        reg =3D <0x01cb1000 0x1000>;
> > +        interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&ccu CLK_BUS_CSI>,
> > +                 <&ccu CLK_CSI_SCLK>,
> > +                 <&ccu CLK_MIPI_CSI>,
> > +                 <&ccu CLK_CSI_MISC>;
> > +        clock-names =3D "bus", "mod", "mipi", "misc";
> > +        resets =3D <&ccu RST_BUS_CSI>;
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            mipi_csi2_in: port@0 {
> > +                reg =3D <0>;
> > +
> > +                mipi_csi2_in_ov8865: endpoint {
> > +                    data-lanes =3D <1 2 3 4>;
> > +
> > +                    remote-endpoint =3D <&ov8865_out_mipi_csi2>;
> > +                };
> > +            };
> > +
> > +            mipi_csi2_out: port@1 {
> > +                reg =3D <1>;
> > +
> > +                mipi_csi2_out_csi: endpoint {
> > +                    remote-endpoint =3D <&csi_in_mipi_csi2>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
>=20
> --=20
> Kind regards,
>=20
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--iiX+RlDO9qayM+ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIzX/MACgkQ3cLmz3+f
v9E+pQf+IeGzh1lXPZrMZDTECUlOPK5l/zgJtpRtE5Gd7qzKbZm59v2L4YYnaBzC
uT+MIgMHxJtyX90UobiXOilMW/yxilQFh/i00T4HMXEZ+VFxY6wVVUZt0/yZM33n
U3EqJqMWT/cb14jgNFBi9jEX7Y08cRih1u8JZxnDBDnq/1KZL/csvquJ2Ljwczw0
cMOQ+1L8liSsQiq7AlorcZLuFSLttMlbIZg+E2u9FNSBKcoF1iUpsDhSggXEVvs9
rVxpT+YhxM6hNls7XR3LyeE7KdAfdcub5JFhUiq7oTJxQK+K6/0IWv8qBrq35k3u
qcCt2yH9UO9dmAyhBky+qbS06yaJjA==
=IJLv
-----END PGP SIGNATURE-----

--iiX+RlDO9qayM+ej--
