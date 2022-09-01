Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C445A9B23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiIAPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIAPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:03:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36579832E8;
        Thu,  1 Sep 2022 08:03:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 569522000F;
        Thu,  1 Sep 2022 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662044601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scHOxPLJc2mIdZy+ocLkyQPw2mekrtVBOig7nZ4p7Tc=;
        b=V/VzarijTnZgS3sRdroUnUGr05FAQdZ45PShfkrfxGnnT9zI61ZvoQ6MDf2grtEZ8I0lUn
        g/YBV3l7UflQx+aSKhe19v+mTSzBAr5pFhd/ogFbao/EutQaCBMPLDKMqyqOwv2j3zD7Nd
        APgAzjI/ecDbYmEs31PEo31BCFH2ZNiMmtfOHL0lj9ge0b4vg20t/T+xBo8LtPwVft0FN/
        FY+ImlQJDrxbVaLvYt+DGYjEiMJ7kHYnpYCSIfFEa9E/VhetuZrEUbeGYZ0+ECPE4ftU/e
        PRjOmeBsDKNQ6vNHy3ngLxly8n509kLTvOhHWeq6kxvoFZW5Z8ayfyN4sjxp4Q==
Date:   Thu, 1 Sep 2022 17:03:17 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YxDJtYgW/NYLw77u@aptenodytes>
References: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
 <20220826184144.605605-2-paul.kocialkowski@bootlin.com>
 <Ywk3W6pTOOlzLYVn@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G/X/1fL20N7fVp/v"
Content-Disposition: inline
In-Reply-To: <Ywk3W6pTOOlzLYVn@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G/X/1fL20N7fVp/v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sat 27 Aug 22, 00:12, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.

Thanks for the review!

> On Fri, Aug 26, 2022 at 08:41:39PM +0200, Paul Kocialkowski wrote:
> > This introduces YAML bindings documentation for the Allwinner A31 Image
> > Signal Processor (ISP).
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../media/allwinner,sun6i-a31-isp.yaml        | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,s=
un6i-a31-isp.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-is=
p.yaml
> > new file mode 100644
> > index 000000000000..2fda6e05e16c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.y=
aml
> > @@ -0,0 +1,97 @@
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
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: CSI0 input port
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: CSI1 input port
> > +
> > +    anyOf:
> > +      - required:
> > +          - port@0
> > +      - required:
> > +          - port@1
>=20
> I'd still like to see all ports that exist in the hardware being
> mandatory. I assume at least one of the A31 and V3s has two connected
> ports in the SoC or you wouldn't declare them both here :-)

Some SoCs (e.g. A83T) only have one CSI controller so we can't require both.
This could be a decision based on the compatible but my personal opinion is
that it's not really worth making this binding so complex.

We can always informally enforce that all possible links should be present
when merging changes to the soc dts.

What do you think?

Paul

> Apart from that, this looks good.
>=20
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

--G/X/1fL20N7fVp/v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQybUACgkQ3cLmz3+f
v9FY1Qf+MjlIt9ACVEy5fR7m2aNXvgztFaDP7rND1ypJ61HVqYq5bNCR35e0/rKW
AgN9KbDyvtNRjocFEb9kB/ueg/GF1trZ5hPPoE26sRl/ZeSveWYWAFw1JKONZPxa
j/+CMQbp1JKd6VTvY+T42hp/4TIQ55q9Km4xGsH3uFeQFXWVDTBRJ/KIpmq1bumJ
3CohtIp1XziiuKvW+GwF//VTvbqLP4OnPi2/AOpsKTtgmZu3heW5ykMRPsxkQf2D
Vf3TA/wnv9ehWz98Uxl/d5Sv1YZCJEXWMUeqjOV1ao7vKVcfQ+zJnF4CnJL+3cdy
rk4gNANwhYFpIY8Aip6d8rwnEwkVuQ==
=YcBa
-----END PGP SIGNATURE-----

--G/X/1fL20N7fVp/v--
