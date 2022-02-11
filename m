Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE74B29D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbiBKQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:10:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351110AbiBKQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:10:22 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37066E06;
        Fri, 11 Feb 2022 08:10:09 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BDB041BF20E;
        Fri, 11 Feb 2022 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644595808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUSzj3TUbMF7TmKv+bJklm/0kDLCRAw90iHxpF7FAk4=;
        b=oG0Nb1UueRz+/N3muogT9xtwBmkNo0QOCIq29+GWycUIpNnSFeefb4J/MbfnHYuTGx8NNK
        jWvPNJ2WjFEI+sClRGGThmR8P5QGosuLIaQmDikc6BAuoUY32F7klJuNWQnfecNZXaxuop
        8x3A9o9q0baiyhGQx7uxh2TQcR9C9a1i35V25YIjQvv3dHVrxCUjxIRx+KMesaOMmBHpyc
        zxSrQN07BFiopT4jQZCMXyqVl8ulBmNkFWxTp1vpeuAc0CkfPw0Nms7pasztSEwq+TWOtG
        nP+GDVcx5fVQCaw2EwJYMbg/vMEQe6ecyf9EByGBvOM8XVRX4tYJwclzHa7+1g==
Date:   Fri, 11 Feb 2022 17:10:06 +0100
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
Subject: Re: [PATCH v2 07/66] dt-bindings: media: sun6i-a31-csi: Add MIPI
 CSI-2 input port
Message-ID: <YgaKXvP3rLOLR9VR@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
 <YgFCuaf007wd8sJy@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N1FE44kMl1ZRScRS"
Content-Disposition: inline
In-Reply-To: <YgFCuaf007wd8sJy@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N1FE44kMl1ZRScRS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Thanks for the review!

On Mon 07 Feb 22, 18:03, Laurent Pinchart wrote:
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Sat, Feb 05, 2022 at 07:53:30PM +0100, Paul Kocialkowski wrote:
> > The A31 CSI controller supports two distinct input interfaces:
> > parallel and an external MIPI CSI-2 bridge. The parallel interface
> > is often connected to a set of hardware pins while the MIPI CSI-2
> > bridge is an internal FIFO-ish link. As a result, these two inputs
> > are distinguished as two different ports.
> >=20
> > Note that only one of the two may be present on a controller instance.
> > For example, the V3s has one controller dedicated to MIPI-CSI2 and one
> > dedicated to parallel.
>=20
> Is it that only one of the two is present, or only one of the two is
> connected ? In the latter case I'd make both ports required, but with
> only one of them connected.

There are situations where the actual pins for parallel (port@0) are missing
and the controller is dedicated to its mipi csi-2 bridge (port@1), cases wh=
ere
the two are present and cases where the mipi csi-2 bridge doesn't exist.
So all in all it's really legit that only one port may be defined.

> > Update the binding with an explicit ports node that holds two distinct
> > port nodes: one for parallel input and one for MIPI CSI-2.
> >=20
> > This is backward-compatible with the single-port approach that was
> > previously taken for representing the parallel interface port, which
> > stays enumerated as fwnode port 0.
> >=20
> > Note that additional ports may be added in the future, especially to
> > support feeding the CSI controller's output to the ISP.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  .../media/allwinner,sun6i-a31-csi.yaml        | 60 +++++++++++++++----
> >  1 file changed, 47 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-cs=
i.yaml
> > index 8b568072a069..3cc61866ea89 100644
> > --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.y=
aml
> > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.y=
aml
> > @@ -61,6 +61,34 @@ properties:
> > =20
> >      additionalProperties: false
> > =20
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: "#/properties/port"
> > +        unevaluatedProperties: false
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        description: MIPI CSI-2 bridge input port
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
> > +    anyOf:
> > +      - required:
> > +        - port@0
> > +      - required:
> > +        - port@1
> > +
> >  required:
> >    - compatible
> >    - reg
>=20
> Shouldn't you specify that either port or ports is required, but not
> both ? I'd also add a comment in the port node to tell it's deprecated,
> and that ports should be used instead.

Yes I agree on both points. I guess that should be a:

oneOf:
  - required:
    - ports
  - required:
    - port

(but feel free to correct me).

> > @@ -89,19 +117,25 @@ examples:
> >                        "ram";
> >          resets =3D <&ccu RST_BUS_CSI>;
> > =20
> > -        port {
> > -            /* Parallel bus endpoint */
> > -            csi1_ep: endpoint {
> > -                remote-endpoint =3D <&adv7611_ep>;
> > -                bus-width =3D <16>;
> > -
> > -                /*
> > -                 * If hsync-active/vsync-active are missing,
> > -                 * embedded BT.656 sync is used.
> > -                 */
> > -                 hsync-active =3D <0>; /* Active low */
> > -                 vsync-active =3D <0>; /* Active low */
> > -                 pclk-sample =3D <1>;  /* Rising */
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +                /* Parallel bus endpoint */
> > +                csi1_ep: endpoint {
> > +                    remote-endpoint =3D <&adv7611_ep>;
> > +                    bus-width =3D <16>;
> > +
> > +                    /*
> > +                     * If hsync-active/vsync-active are missing,
> > +                     * embedded BT.656 sync is used.
> > +                     */
> > +                     hsync-active =3D <0>; /* Active low */
> > +                     vsync-active =3D <0>; /* Active low */
> > +                     pclk-sample =3D <1>;  /* Rising */
>=20
> Wrong indentation.

The double-space before /* Rising */ or something with the heading indent?

Thanks,

Paul

> > +                };
> >              };
> >          };
> >      };
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--N1FE44kMl1ZRScRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGil4ACgkQ3cLmz3+f
v9E2OAf+M59HqYo3WH2kb71DPc2RBTe6OgFa2D6dEM/0E8JL5wiYWvOSJADrYUh3
ym1oUzOSoUsA8YlBPzSQ3oXMtRN3Hzc9sVL8RDmHw1+JhEqFo0nasFjA3UvgFCMp
frR0s8rvSu4r5bpPQheC1uMcfA0aSHT4W8w8oYJRdGK6nlkPJbQUbg+3jLDvd7pT
HwJoBd0+0oMuqFg6FdGP/vKt89mqIyl6AmZYnTSeofyX7/x40i1Zdtbvd/pMdYtv
C9kXGkP5WrXGVwKa3Mn9CMnOFPjNXmL2D56NHzwSagDzZLbscRablKBDBglxfuGa
dlRvMsPlp7qvlnv9J8aKV9hj/aVIHw==
=8dSa
-----END PGP SIGNATURE-----

--N1FE44kMl1ZRScRS--
