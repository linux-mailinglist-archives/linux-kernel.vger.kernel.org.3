Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5031457974A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiGSKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiGSKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:05:01 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00F3A491;
        Tue, 19 Jul 2022 03:04:36 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 59EF6E000E;
        Tue, 19 Jul 2022 10:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658225075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwzRrHTBlq6/GPcoprPr/yVYl2AllY/DC/t0CGrDf+A=;
        b=e7f3TXzS3kV6ulJEA/Lge79POr4lJvgvaIo82298rbQnPih9xt0d9sckb/7/J6nV+87uyc
        v+ib1i6xG+odNmUoJoPIbHNLCNz/+Go/D5ocGreEvWWqpMnkkYHgIKrfMNhKfyNSE2c9Dj
        Gf9qk1lXvZRJK4+RuGVQLnulDML1DL5TGuAWxVqaDvuAs5foWN2Xek1xJT9u5UGo00uHAD
        RtFMg1Kq8Y831tdSQ6DQhdLpA0NPjiTdsXqwEJxC0IzHbKMeYN6Rw0KwiNnw65tAOClIIw
        mPamOXd6BbCLTEKjR4dslHJTbEeMMi8Qaz+6DQWoqc0G/z+p5kozXsWst8yeKA==
Date:   Tue, 19 Jul 2022 12:04:31 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YtaBr3B5JMrdFVgV@aptenodytes>
References: <20220704173523.76729-1-paul.kocialkowski@bootlin.com>
 <20220704173523.76729-2-paul.kocialkowski@bootlin.com>
 <YtP0YfPteyzsBWn3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3I9kBemjOHRithZP"
Content-Disposition: inline
In-Reply-To: <YtP0YfPteyzsBWn3@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3I9kBemjOHRithZP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Sun 17 Jul 22, 11:37, Sakari Ailus wrote:
> Hi Paul,
>=20
> On Mon, Jul 04, 2022 at 07:35:18PM +0200, Paul Kocialkowski wrote:
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
>=20
> Do both support a single PHY with a single data only? If multiple data la=
nes
> are supported, please require data-lanes property (on endpoint).

There's actually no PHY involved here: the ISP drivers gets its video stream
=66rom these CSI controllers which are the ones interfacing with a MIPI CSI=
-2
receiver (on A31/V3 it uses an external D-PHY, on A83T the D-PHY is colloca=
ted
with the controller).

So I think the data-lanes property is not relevant here.

What do you think?

Cheers,

Paul

> > +
> > +    anyOf:
> > +      - required:
> > +          - port@0
> > +      - required:
> > +          - port@1
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
> Sakari Ailus

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--3I9kBemjOHRithZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmLWga8ACgkQ3cLmz3+f
v9EUlAf8DYEIQLUQoXOrMlsqRDJSzDzjYJfAHBgm/q9wjI7fvxHf4yHlFuSVReSH
O42woPwdpBWLkW8Nkd710Ln/xK0bp9yBmTxJ10yWCUKdeSDrzrX0WDzU62NQIjbB
Ue0cNaQaCXTsgdY0xP/MgkDVPp13MfebobbyM4tqLwcEZyj3yCWR3skLd47htQoq
O1I8TAi+7j5ssrk3hSyZdS1yPsQt2a02IoZ9iA4ItXDRw0yhN+Ak6dd/VTumaA9N
l7sn1HQZTYsAb5wodKw5sroZBQV8dtJtPuvfwXSJbwuD8pfEJlmq8J0M6tRwDZs8
kc/jaPT0DQF4oYt8l6tpHEff5vpixA==
=IQ69
-----END PGP SIGNATURE-----

--3I9kBemjOHRithZP--
