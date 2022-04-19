Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848B85067FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbiDSJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbiDSJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:48:41 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2DB82;
        Tue, 19 Apr 2022 02:45:54 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D35360007;
        Tue, 19 Apr 2022 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650361553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wa+NcZUIxotnJCsbAXPXeRRPesDDul7PaS9PN5tlpXU=;
        b=F+mu/1+dxtNQUTIo4OGwkL6alHXrO50riI/Oa7w+r9ei3Y70KJdjp/CVl4S5axsfz6oaV0
        ynmmG2B8a4uKIUGZeT7r1ub3VXVTy+5dZKG1UWPUtegyL8LwuLgz6+q/LLhw0f2BApF6LN
        KWcmiTezPV3ATNExhbwvB6khEi2Fwl12bC0BoTTc52vrsikOH19lg080rMSPPlmLFtIeNv
        YZK1w+pxcUJH6TodoSiHrIPCV78MQa4KXzVf0Y+i8AifyhsOw6f6FQuYoDYPfBEmySRW0V
        wOt1M2BH2kq0faBRdHz+R6MV3WSVCopN9dUBGeLlK3Tpn9c8kVGoOc3PORStVw==
Date:   Tue, 19 Apr 2022 11:45:50 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <Yl6Ezm6D7KKbE1Oa@aptenodytes>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
 <19aa74b7-0096-87c5-ef2c-9a135ad5505a@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhS7v+RYfLqvo3sx"
Content-Disposition: inline
In-Reply-To: <19aa74b7-0096-87c5-ef2c-9a135ad5505a@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rhS7v+RYfLqvo3sx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri 15 Apr 22, 20:59, Samuel Holland wrote:
> On 4/15/22 10:37 AM, Paul Kocialkowski wrote:
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
> > index 000000000000..ffca216b841f
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
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
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
> Should be "const: 1".
>=20
> Otherwise,
> Reviewed-by: Samuel Holland <samuel@sholland.org>

Good catch and thanks for the review!

Cheers,

Paul

> > +
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +        additionalProperties: false
> > +
> > +    anyOf:
> > +      - required:
> > +        - port@0
> > +      - required:
> > +        - port@1
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
> >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rhS7v+RYfLqvo3sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJehMkACgkQ3cLmz3+f
v9GvPQf/Qh1TCRnOPD7vlG9p1n3g9h0nqX7tVg2axaXzj+bxHt+FbuOtgno4p5D5
aUPfynnm5Ai3SmfvhfakngamqxbmBOX8kChdsAnebLBXZKUfN5MX3mBzhlLHFuz2
EaDLP9uvvb7AGRwL4F16TQJ061IVIoA6Kcs4luBumWjQkVFdMUolyDglyMo3DLCC
1yVTyejh23bamGUiFw2WmRUGNV/PBS7BiuBEW9XUloLS7jK/ZZZ40RU4BOA8JSkj
HcJ0ekfcrj+ELpRbb63DTYA4VyYcG7OKa9SyaTk4RZN2gb58Rel4ha/Bl0j+p5lc
JFYpm+cfsCLcT84m++Edz86ee856qw==
=XHnk
-----END PGP SIGNATURE-----

--rhS7v+RYfLqvo3sx--
