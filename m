Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF4B55C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356168AbiBNQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356158AbiBNQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:23 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E855FF0B;
        Mon, 14 Feb 2022 08:10:11 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F24851BF215;
        Mon, 14 Feb 2022 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644855010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5eS9fguaP+pvzR5A1Vwu+pYHyCDBG8CctR4OI6MdrE=;
        b=UCj7f71PmwliZ1ok8P9m8PXiwkU1fLCOpZZ3sk70BvhQuGXFhuBmONFAMuSbUi1XZZ5v6I
        QVpMk7mSQJwKucLTkeer6lOa1TmqXGX7Fc8xvI5zZRCKgrfQO1bJTpwqiOEHuUOkA+FQtG
        B77Afoe4dPbz7hemN4PheVD6azW/7wzrlBdV81+M+Au1E4SdQDIlUw2JI8q945X4WT3Uex
        EzjsmO0+Gws4avZNcm5iT+YhbZCMG1BSYxeAztO1GF0BPVNy4DKCsKgUWKI9yKxNPYZJQW
        4Ipo7H5vQB+UwL/Hry4QvOcnMj2k+7AbuSoEE7ZDWIIHjJL8YVdPDn8JYhE5cA==
Date:   Mon, 14 Feb 2022 17:10:05 +0100
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
Message-ID: <Ygp+3URjxyvRBn/5@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-8-paul.kocialkowski@bootlin.com>
 <YgFCuaf007wd8sJy@pendragon.ideasonboard.com>
 <YgaKXvP3rLOLR9VR@aptenodytes>
 <YgbNfKiNkPmvaT1k@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1K2ddbKyLBZHtd45"
Content-Disposition: inline
In-Reply-To: <YgbNfKiNkPmvaT1k@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1K2ddbKyLBZHtd45
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 11 Feb 22, 22:56, Laurent Pinchart wrote:
> On Fri, Feb 11, 2022 at 05:10:06PM +0100, Paul Kocialkowski wrote:
> > Hi Laurent,
> >=20
> > Thanks for the review!
> >=20
> > On Mon 07 Feb 22, 18:03, Laurent Pinchart wrote:
> > > Hi Paul,
> > >=20
> > > Thank you for the patch.
> > >=20
> > > On Sat, Feb 05, 2022 at 07:53:30PM +0100, Paul Kocialkowski wrote:
> > > > The A31 CSI controller supports two distinct input interfaces:
> > > > parallel and an external MIPI CSI-2 bridge. The parallel interface
> > > > is often connected to a set of hardware pins while the MIPI CSI-2
> > > > bridge is an internal FIFO-ish link. As a result, these two inputs
> > > > are distinguished as two different ports.
> > > >=20
> > > > Note that only one of the two may be present on a controller instan=
ce.
> > > > For example, the V3s has one controller dedicated to MIPI-CSI2 and =
one
> > > > dedicated to parallel.
> > >=20
> > > Is it that only one of the two is present, or only one of the two is
> > > connected ? In the latter case I'd make both ports required, but with
> > > only one of them connected.
> >=20
> > There are situations where the actual pins for parallel (port@0) are mi=
ssing
> > and the controller is dedicated to its mipi csi-2 bridge (port@1), case=
s where
> > the two are present and cases where the mipi csi-2 bridge doesn't exist.
> > So all in all it's really legit that only one port may be defined.
>=20
> The port could still exist internally in the IP core though. Of course
> that's hard to tell.

Yes that's true, the bit to switch input to mipi csi-2 is there in all cases
but I don't think it makes sense to expose the port in situations where
no controller is attached.

> > > > Update the binding with an explicit ports node that holds two disti=
nct
> > > > port nodes: one for parallel input and one for MIPI CSI-2.
> > > >=20
> > > > This is backward-compatible with the single-port approach that was
> > > > previously taken for representing the parallel interface port, which
> > > > stays enumerated as fwnode port 0.
> > > >=20
> > > > Note that additional ports may be added in the future, especially to
> > > > support feeding the CSI controller's output to the ISP.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > > > ---
> > > >  .../media/allwinner,sun6i-a31-csi.yaml        | 60 +++++++++++++++=
----
> > > >  1 file changed, 47 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6=
i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a3=
1-csi.yaml
> > > > index 8b568072a069..3cc61866ea89 100644
> > > > --- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-c=
si.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-c=
si.yaml
> > > > @@ -61,6 +61,34 @@ properties:
> > > > =20
> > > >      additionalProperties: false
> > > > =20
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: "#/properties/port"
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        description: MIPI CSI-2 bridge input port
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            const: 1
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
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > >=20
> > > Shouldn't you specify that either port or ports is required, but not
> > > both ? I'd also add a comment in the port node to tell it's deprecate=
d,
> > > and that ports should be used instead.
> >=20
> > Yes I agree on both points. I guess that should be a:
> >=20
> > oneOf:
> >   - required:
> >     - ports
> >   - required:
> >     - port
> >=20
> > (but feel free to correct me).
> >=20
> > > > @@ -89,19 +117,25 @@ examples:
> > > >                        "ram";
> > > >          resets =3D <&ccu RST_BUS_CSI>;
> > > > =20
> > > > -        port {
> > > > -            /* Parallel bus endpoint */
> > > > -            csi1_ep: endpoint {
> > > > -                remote-endpoint =3D <&adv7611_ep>;
> > > > -                bus-width =3D <16>;
> > > > -
> > > > -                /*
> > > > -                 * If hsync-active/vsync-active are missing,
> > > > -                 * embedded BT.656 sync is used.
> > > > -                 */
> > > > -                 hsync-active =3D <0>; /* Active low */
> > > > -                 vsync-active =3D <0>; /* Active low */
> > > > -                 pclk-sample =3D <1>;  /* Rising */
> > > > +        ports {
> > > > +            #address-cells =3D <1>;
> > > > +            #size-cells =3D <0>;
> > > > +
> > > > +            port@0 {
> > > > +                reg =3D <0>;
> > > > +                /* Parallel bus endpoint */
> > > > +                csi1_ep: endpoint {
> > > > +                    remote-endpoint =3D <&adv7611_ep>;
> > > > +                    bus-width =3D <16>;
> > > > +
> > > > +                    /*
> > > > +                     * If hsync-active/vsync-active are missing,
> > > > +                     * embedded BT.656 sync is used.
> > > > +                     */
> > > > +                     hsync-active =3D <0>; /* Active low */
> > > > +                     vsync-active =3D <0>; /* Active low */
> > > > +                     pclk-sample =3D <1>;  /* Rising */
> > >=20
> > > Wrong indentation.
> >=20
> > The double-space before /* Rising */ or something with the heading inde=
nt?
>=20
> The heading has one extra space for all three lines, they should be
> aligned to the / of /*, not to the *.

Oh that's true, good catch thanks!

Paul

> > > > +                };
> > > >              };
> > > >          };
> > > >      };
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--1K2ddbKyLBZHtd45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIKft0ACgkQ3cLmz3+f
v9GBzQf4ykgosl0x6xfMvLDDLl0cFnB2eK0Bdp9ZhcxVv+4V0W9kcIZ/NnN4FJ+5
2NODVUSkvCLd8E5R/z8MT4ngVlKnvd26GV3Uiog3yhoQ1SpjkTQT2dZMXOMhPARi
mzNpeUfkBY76pRMdDQzmOnwAAj4Iqlizkar0a3su1o/zKAwYJ1k//32QHc5RVF9X
i9kE1FldlInxg0HNAuE0SOU0k0DYSbHI0xNugH8Wf5DszFeWTFdMUseOdB3iNaT3
eQRBKtfrzjIrYFSE4LLZTtydLTDyxh1N4udg/t0DMQpjF5vFZWW/Im4iMXwD0IAI
WbWJgCPQNoul4HI9EK2vEWjUyDsh
=ShHP
-----END PGP SIGNATURE-----

--1K2ddbKyLBZHtd45--
