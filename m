Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007564C8F47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiCAPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCAPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:40:39 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3120AA005;
        Tue,  1 Mar 2022 07:39:56 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EED5AE0004;
        Tue,  1 Mar 2022 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646149194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJF9kAqLBTCdNu/B3TIrFaAsnuyFBGYGgqC92Y3NAM0=;
        b=Y05qjqbzZSgUzSFtyXv108CqpvaVY1qm/a531dKA6A0FhzHSqxjBh5DbS86a6x9vC2Y2/x
        Aq+0wKYGdpdWgjgajh60qb2icanAjKm3qxzsDzDlIYvdJL4tqa9VwW4/Ok++BQzRdZWtxt
        sfzzvxOfHYX6cI59Eg1YzfxwuXLoIyZL455fKdibhspODeOczs30oxUrqHRpeHqa5eAHGe
        MtxQsPeTUBbH2xQfOl8WwGt4rNnXf08yeJkexzw4aTswiCfPp10RFz8fCt9KMPMM5BYQkG
        e/xTvUR889osw0kQ42PhukS0IY8c7iEVxx0Pdjh3bT2qpN1t0gCz9Hm3eskFhQ==
Date:   Tue, 1 Mar 2022 16:39:51 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 21/66] media: sun6i-csi: Always set exclusive module
 clock rate
Message-ID: <Yh4+R+a2cFSKw/M5@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
 <YgqDxWwUeVQu+05O@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dPa+vTgjzzFmrD6g"
Content-Disposition: inline
In-Reply-To: <YgqDxWwUeVQu+05O@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dPa+vTgjzzFmrD6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon 14 Feb 22, 18:31, Sakari Ailus wrote:
> Hi Paul,
>=20
> Thanks for the patchbomb.

I'll split it in the next revision.
=20
> On Sat, Feb 05, 2022 at 07:53:44PM +0100, Paul Kocialkowski wrote:
> > In some situations the default rate of the module clock is not the
> > required one for operation (for example when reconfiguring the clock
> > tree to use a different parent). As a result, always set the correct
> > rate for the clock (and take care of cleanup).
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
> >  1 file changed, 41 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drive=
rs/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 8155e9560164..2355088fdc37 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct sun6i=
_csi_device *csi_dev,
> >  		return PTR_ERR(csi_dev->clk_ram);
> >  	}
> > =20
> > +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> > +		clk_mod_rate =3D 300000000;
> > +	else
> > +		clk_mod_rate =3D 297000000;
>=20
> This would be nice to put in OF match data.
>=20
> Of course the driver did this already before the patch. The approach still
> scales badly.

Agreed, that could be another follow-up patch in the sun6i-csi rework serie=
s.

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--dPa+vTgjzzFmrD6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIePkcACgkQ3cLmz3+f
v9FlRQgAk+JPQei0UznXbFdxf9qgDlmo3OhqPLByuYqEJBTZxk6eozFrNB7Z96WV
XxR9/+oKrTXORQ9M4M/p1Taz95Bi/+yKrAHmNKXVFxN8YpZ+7ESTGPEXIqa7qqmb
L48LCTlrsqmJYG+FxZZBXlQ3hFyOttRd5mIeM6Ch3ZefGXQmPncLih6RT28jI9+a
qEhe64aNwMmsFyFltOLjDozCovN6THI6KCrejtL7+82OgquuQQEWh6nyxEDBmD67
UwGx82FwXVsjh+Krg1rYVcUKeWLcUcZIIBvF9io1fO/dlITJRUYbQeXGJNRAURbd
pByuB20nu4MZjDqILDfwnExEaV0Ncw==
=NP6t
-----END PGP SIGNATURE-----

--dPa+vTgjzzFmrD6g--
