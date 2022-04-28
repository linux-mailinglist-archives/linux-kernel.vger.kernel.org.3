Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA7512DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiD1IPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiD1IOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:14:49 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF975E5A;
        Thu, 28 Apr 2022 01:11:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4B3DE3200033;
        Thu, 28 Apr 2022 04:11:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 28 Apr 2022 04:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651133493; x=1651219893; bh=zhx4d/dBHT
        pW4W1OKZ4iXHkQAtUQxcXTyp97K6x+HYQ=; b=pFbjr0eXgD79GamR8HiFg2cHKF
        2fl1+6DilEH6u6u7qHnebZo7pX2UBZ9S168D4JI8ryxEpqR2Eha8w66XTsj6D8h/
        wrkCC07e1ULAH34JKLtFodWK+VvJIGZ91R/uc3a1uETArsX+92219SeKbKvGDUep
        8dG5iJhRyqpdI6/Rk0X3dOksQ6POqKQYnmvfsi0qUUhGaQ4im46c/fZwYiKlgY5R
        1WasH7xwGmRFkrXwUTpKJotZZWrQzMEyAPLQnBl1SStvOQ7Ywvbz1+fajHICHUwS
        cWbw1wrBcWA3uhar7Sgm0mgM7mfoncb+0a6QGDnra3ii7+S8YRHFJW/qFhHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651133493; x=
        1651219893; bh=zhx4d/dBHTpW4W1OKZ4iXHkQAtUQxcXTyp97K6x+HYQ=; b=S
        MmOK5aAjnb3bCezwArQMGfxK81ncC8TnKiVwG7b0f+UZ9ehGY0XNOfVDDOblrpYN
        Vr9UaIA/jnpv9WEuC1N6Ido7agp2Dwmls9vVsGItfvGvkx/t8oWaQk5hB5zKc8Ld
        LU+Y1QweFE81HfHHma70jt242Ee1Oq4Vlbmsq7CLmj9bAiqgMYkDRAtn4U1EMHuS
        D/IsZtPSn4dJob5+5LP4BFHA69LdQTHNJsXzlYfPKzdVxZqO8JTjNLAh9wtDu36g
        SydKU2teXFmKD6jScXdlTX2h27JCHP2pkqdSJiEd6Zw+ki8OY+l4jzEQnwSj+gQ9
        TL94D9bVhvhzOqZnsmaKQ==
X-ME-Sender: <xms:NExqYjPLn9DwDeLX-NJnaKti-1gFsIO5F7q2QRitV-QMeiIDV7OreQ>
    <xme:NExqYt9ykznOJ-NoYH6EoLpdWKecUdc_FchCeK8FvHT3Pi4-nPbyBLIY6_90ljLxs
    mpLQ3WQgPxI2Z6d_EM>
X-ME-Received: <xmr:NExqYiSb8Dsg118nHfE118MqPXWXsLjKjqZv6HOuHsjUYcZNweESdw9dGjdy9anUmNPf-aFwzXqBbK3Lz3Y4yS4WrwJTA88dmCo02DM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeejgeeiveevvdfgffeftdevuefhheduveejieefgeejveeuhfetkeelgfevteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NUxqYnvS5zKHWAd0HvS84_T4Gwt7tzsmtBWPnF7hhSCTTjGfeoAVmA>
    <xmx:NUxqYrfkduOkZfuA0L1lvSUdrRLot7Dxloxozo6k6dGtcO1YMspNWg>
    <xmx:NUxqYj1otrb7pIG00XlnQCu9UBnH-OMf1zw56zPu212BNoIBzxoMQg>
    <xmx:NUxqYsUSTIJ9QeSKm1i4W5vRFWL3rNUxlLlzU3AEGcD5u0YRtcNiIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Apr 2022 04:11:32 -0400 (EDT)
Date:   Thu, 28 Apr 2022 10:11:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of
 the ISP
Message-ID: <20220428081130.6deusqgnrsgqdp3e@houat>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
 <2029179.KlZ2vcFHjT@jernej-laptop>
 <YmpIjPe8pw+yvGyL@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vi7rcbrvgeo53dt4"
Content-Disposition: inline
In-Reply-To: <YmpIjPe8pw+yvGyL@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vi7rcbrvgeo53dt4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2022 at 09:55:56AM +0200, Paul Kocialkowski wrote:
> Hi Jernej,
>=20
> Thanks a lot for all your reviews!
>=20
> On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> > Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski napisal=
(a):
> > > Add a helper to detect whether the ISP is available and connected
> > > and store the indication in a driver-wide variable.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++=
++
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > >  2 files changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > > a88deb8ba1e7..f185cbd113c7 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -25,6 +25,35 @@
> > >  #include "sun6i_csi_capture.h"
> > >  #include "sun6i_csi_reg.h"
> > >=20
> > > +/* ISP */
> > > +
> > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > > +{
> > > +	struct device *dev =3D csi_dev->dev;
> > > +	struct fwnode_handle *handle =3D NULL;
> > > +
> > > +	/* ISP is not available if disabled in kernel config. */
> > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> >=20
> > Where is this symbol defined?
>=20
> That is defined through Kconfig's auto-generated header, from the associa=
ted
> option for the ISP driver. It is defined in the ISP support series so this
> will effectively always be false for now.

Can the ISP be compiled as a module, but the CSI driver built-in? If so,
that would create a dependency from the kernel image to a module, which
won't compile.

Maxime

--vi7rcbrvgeo53dt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYmpMMgAKCRDj7w1vZxhR
xR9JAQCzUJ3nSywMzMfmZf2THjuGSWtHrnB1gUI5bzeoJHD/bgD9E0zo+xuSxJ1g
MWMoFbBta8oAjxNxO6BGTkd2mhGgTg4=
=MHSM
-----END PGP SIGNATURE-----

--vi7rcbrvgeo53dt4--
