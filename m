Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B464B28D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351271AbiBKPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiBKPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:12:37 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E64C304;
        Fri, 11 Feb 2022 07:12:34 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2B19E1BF209;
        Fri, 11 Feb 2022 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644592353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UtWBObtE4IkrC6h1yUcZW77RKDqVsXLhy4QmmGFNKO4=;
        b=ccsc7k/xzRCiUCIwcH++UiryHmcKwovXKWAbQ0BzGb8gXA7/c8bPP7QQpRxDTUfei/rYsO
        d2zRJkIzW4z/xEJVPa3feg2jB8zwr9sqda3PLMZgq3VJLgdEk06z3RUHSwBXd/OXAxJ2eM
        KlEVy+4ibDVuU1T0dMtE01z5jZ/TCudeLgPpcdB9swBmayu6bLsxSAGhcAxSZys48c74xl
        nL/iFCoeQaOpaTEgxvEpNM3GZbRmrgM9Q8jFSds66zhUkcvuEyHjQFOFZO68n6Y7H9e+Gi
        IAJig+PEZNDNOaCGhfhGel6U1f02I9kEIVUyRv9Rr7uxZ+Jw6iwN7Lvp1nKJ9A==
Date:   Fri, 11 Feb 2022 16:12:29 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/66] dt-bindings: sun6i-a31-mipi-dphy: Add optional
 direction property
Message-ID: <YgZ83To26Dgy+JD4@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-6-paul.kocialkowski@bootlin.com>
 <YgZ6qsdO+SfTemPZ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C0Hx0xaxCNYFUf5H"
Content-Disposition: inline
In-Reply-To: <YgZ6qsdO+SfTemPZ@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C0Hx0xaxCNYFUf5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri 11 Feb 22, 09:03, Rob Herring wrote:
> On Sat, Feb 05, 2022 at 07:53:28PM +0100, Paul Kocialkowski wrote:
> > The Allwinner A31 MIPI D-PHY block supports both tx and rx directions,
> > although each instance of the block is meant to be used in one
> > direction only. There will typically be one instance for MIPI DSI and
> > one for MIPI CSI-2 (it seems unlikely to ever see a shared instance).
> >=20
> > Describe the direction with a new allwinner,direction property.
> > For backwards compatibility, the property is optional and tx mode
> > should be assumed by default.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-=
mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-=
mipi-dphy.yaml
> > index d0b541a461f3..22636c9fdab8 100644
> > --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dp=
hy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dp=
hy.yaml
> > @@ -37,6 +37,18 @@ properties:
> >    resets:
> >      maxItems: 1
> > =20
> > +  allwinner,direction:
> > +    $ref: '/schemas/types.yaml#/definitions/string'
> > +    description: |
> > +      Direction of the D-PHY:
> > +      - "rx" for receiving (e.g. when used with MIPI CSI-2);
> > +      - "tx" for transmitting (e.g. when used with MIPI DSI).
> > +
> > +    enum:
> > +      - tx
> > +      - rx
> > +    default: tx
>=20
> Can you the phy mode to imply the direction?

So there was a first attempt at this which introduced a PHY submode but
it was concluded after discussions that the direction is not really a
mode of operation choice, in the sense that the D-PHY cannot be reconfigured
to behave in Rx or Tx mode: it is instead statically assigned to one role
or the other. This is why it feels more appropriate to describe it in the
device-tree.

See this thread from the previous iteration:
https://patchwork.linuxtv.org/project/linux-media/patch/20210115200141.1397=
785-3-paul.kocialkowski@bootlin.com/#128800

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--C0Hx0xaxCNYFUf5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGfN0ACgkQ3cLmz3+f
v9E7MwgAgb6y0f+35BKNQMY0ApR9vBuccUbtMvfY5MRxfwFygHy+dHC03V+oFXWR
oh9Mb6Wc3RKnI6nyWPgoFzbz7KDXpHf9rubsuw9dZYtytY7cAVla5GHfJxLSZVzj
g7Em8TMkWD86KmX7jl2LtkUyjpuWZ2YWnZnS+s2fOHBMLbUAuc2I+lelXgKxLCTL
gluqLgtLSxn/T6tGheE5exmUTWV5Wq17QWtx+ganNYMEQoG9d0Q2sf1kE1eOocHF
8sSTdFPAzC/f6nhMYoXBiCIpTKtAMZ+1kTuBJDEEhPLTCQ/YKvxu4UfbV2W5EvLa
zi3iRUd2SKPMnAblAuD9zINCfUPEMQ==
=h8WY
-----END PGP SIGNATURE-----

--C0Hx0xaxCNYFUf5H--
