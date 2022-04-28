Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4C5132C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiD1LrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiD1LrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:47:08 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9DA66F96;
        Thu, 28 Apr 2022 04:43:53 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 83352240007;
        Thu, 28 Apr 2022 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651146230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tn250kJelEl8haaXg6wMumzcA9FUTRhEqD5DE4h8/UI=;
        b=ouqPRGU9fc/m5/qzE9D5GZZ+PasktKbQBiBThrC2hu/67fsNMBnx4U4GN1Ht2r4TKpaM4a
        gZcO4ryXKxyKiCfhmkgn7WZkabT+Gjd/t/awZyJ93HMWUEII3joXwdoHkAbTAwAc9Zw3yx
        2UmejKxDIxEjbd4xaDemNNjoVb1KJ7FiuIYRobZcRcLqcbuuDa36OFVTTq1vIEeY8DFGKD
        6DPty7i90P5XZL4sVWSnIq7cOGvc095fRFDKPvCTTWYEEDZgexg5vWnqXv8akbEJeav/h5
        H9/K0qitg2ER4ZGevjGuidhOKm5/twv9RxlBFhOwdJyDusT1h6SMPlpJI8rOXg==
Date:   Thu, 28 Apr 2022 13:43:44 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
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
Message-ID: <Ymp98LBQySvpz8/j@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
 <2029179.KlZ2vcFHjT@jernej-laptop>
 <YmpIjPe8pw+yvGyL@aptenodytes>
 <20220428081130.6deusqgnrsgqdp3e@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="st8DMu9oF2iUfIiW"
Content-Disposition: inline
In-Reply-To: <20220428081130.6deusqgnrsgqdp3e@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--st8DMu9oF2iUfIiW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu 28 Apr 22, 10:11, Maxime Ripard wrote:
> On Thu, Apr 28, 2022 at 09:55:56AM +0200, Paul Kocialkowski wrote:
> > Hi Jernej,
> >=20
> > Thanks a lot for all your reviews!
> >=20
> > On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> > > Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski napis=
al(a):
> > > > Add a helper to detect whether the ISP is available and connected
> > > > and store the indication in a driver-wide variable.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++=
++++
> > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > > >  2 files changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > > > a88deb8ba1e7..f185cbd113c7 100644
> > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > @@ -25,6 +25,35 @@
> > > >  #include "sun6i_csi_capture.h"
> > > >  #include "sun6i_csi_reg.h"
> > > >=20
> > > > +/* ISP */
> > > > +
> > > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > > > +{
> > > > +	struct device *dev =3D csi_dev->dev;
> > > > +	struct fwnode_handle *handle =3D NULL;
> > > > +
> > > > +	/* ISP is not available if disabled in kernel config. */
> > > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> > >=20
> > > Where is this symbol defined?
> >=20
> > That is defined through Kconfig's auto-generated header, from the assoc=
iated
> > option for the ISP driver. It is defined in the ISP support series so t=
his
> > will effectively always be false for now.
>=20
> Can the ISP be compiled as a module, but the CSI driver built-in?

I think so yes, I don't see any reason why not.

> If so,
> that would create a dependency from the kernel image to a module, which
> won't compile.

I think this would introduce a run-time dependency (sun6i-csi needing sun6i=
-isp
in order to register) but I don't understand why it wouldn't compile though.
Could you ellaborate a bit?

Thanks!

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--st8DMu9oF2iUfIiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmJqffAACgkQ3cLmz3+f
v9Emewf/Zlj04aHtR4cNVwZx04Pnb577X42nR1Wu/aUvkR8yxcNEDJFRoO7VuElK
rACulRMpS4pMBqYPXtieuMirT1VTB0mBD0soOiC7/s9vRzsThpk01c3mY2c0IBZn
sxWqTGkrqI/jDF4uKt60YL8KECEuGulSPkMAdJtjXWp+V8fJqPbzDOpGlILkNY++
2fdyfhcI1Sy60qcdkwAgBNndnGc8Ce894PM5xZikiwwsbAf6XpTZ2QZOHUYTRpdr
7nTk0ibe2TQJmGwnKp2Elzwl+o6oZn+qu8m6FnXnxwB08snRh7qUifMsNu6GqUVB
0J4jx12tfFVhRwePRq1a9sM0Xb5h4Q==
=MHAf
-----END PGP SIGNATURE-----

--st8DMu9oF2iUfIiW--
