Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E106058AC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiHEOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiHEOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:11:47 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E6FDB;
        Fri,  5 Aug 2022 07:11:45 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1EE0CFF805;
        Fri,  5 Aug 2022 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1659708704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2noyRzn5oYWYwmIMBH9uFDA4P12nprNL0SehkpX2g0=;
        b=ls6MZAjPDMN8Jaa8rk8L36zOyS6t+bADzZqUNsQF2WBt+1H+uZ7ZxFZkTbfDLUznKDwKut
        tbZR3QCTXZJJTq7kab77a0zsEtW1xOJU5jEO5wR5+TC8I9V+MTzQC38eAQzqiy/vcVNO0h
        jwvjEOxCWjfP13j2ykihmJ0bLP77e3myOZYEvV7kODe/sRWFhYcoE6ET4WIk9jQGmA92Xw
        UKRbkIklzNOccHmLFCg/bloroIkuWAfMXu/LA7vtHC7EgKHzd7uKBKMvwesNO2PFhzAhqu
        CD2ces9mAXDxVX+g08PXyVpyERBCt3+hdOTcAjNigtGOrwk9pkH552unpeI0Kg==
Date:   Fri, 5 Aug 2022 16:11:41 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] media: sunxi: Fix some error handling path of
 sun6i_mipi_csi2_probe()
Message-ID: <Yu0lHcp63DwF0DBI@aptenodytes>
References: <62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.1659295329.git.christophe.jaillet@wanadoo.fr>
 <9999a30560d0ab8201734cbab0483c6f840402da.1659295329.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6hGXz6ToMr4OxfZM"
Content-Disposition: inline
In-Reply-To: <9999a30560d0ab8201734cbab0483c6f840402da.1659295329.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6hGXz6ToMr4OxfZM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Sun 31 Jul 22, 21:22, Christophe JAILLET wrote:
> Release some resources in the error handling path of the probe and of
> sun6i_mipi_csi2_resources_setup(), as already done in the remove
> function.

Thanks again, my comments are the same as in the other patch!

> Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 co=
ntroller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c    | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2=
=2Ec b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> index a4e3f9a6b2ff..1ee8501e25f6 100644
> --- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> +++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> @@ -661,7 +661,8 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_csi=
2_device *csi2_dev,
>  	csi2_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi2_dev->reset)) {
>  		dev_err(dev, "failed to get reset controller\n");
> -		return PTR_ERR(csi2_dev->reset);
> +		ret =3D PTR_ERR(csi2_dev->reset);
> +		goto err_put_clk_rate;
>  	}
> =20
>  	/* D-PHY */
> @@ -669,13 +670,14 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_c=
si2_device *csi2_dev,
>  	csi2_dev->dphy =3D devm_phy_get(dev, "dphy");
>  	if (IS_ERR(csi2_dev->dphy)) {
>  		dev_err(dev, "failed to get MIPI D-PHY\n");
> -		return PTR_ERR(csi2_dev->dphy);
> +		ret =3D PTR_ERR(csi2_dev->dphy);
> +		goto err_put_clk_rate;
>  	}
> =20
>  	ret =3D phy_init(csi2_dev->dphy);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize MIPI D-PHY\n");
> -		return ret;
> +		goto err_put_clk_rate;
>  	}
> =20
>  	/* Runtime PM */
> @@ -683,6 +685,10 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_cs=
i2_device *csi2_dev,
>  	pm_runtime_enable(dev);
> =20
>  	return 0;
> +
> +err_put_clk_rate:

Please call this "error_clock_rate_exclusive",

> +	clk_rate_exclusive_put(csi2_dev->clock_mod);

and add a blank line here.

> +	return ret;
>  }
> =20
>  static void
> @@ -712,9 +718,13 @@ static int sun6i_mipi_csi2_probe(struct platform_dev=
ice *platform_dev)
> =20
>  	ret =3D sun6i_mipi_csi2_bridge_setup(csi2_dev);
>  	if (ret)
> -		return ret;
> +		goto err_cleanup_resources;
> =20
>  	return 0;
> +
> +err_cleanup_resources:

Please call this "error_resources",

> +	sun6i_mipi_csi2_resources_cleanup(csi2_dev);

and add a blank line here.

Thanks,

Paul

> +	return ret;
>  }
> =20
>  static int sun6i_mipi_csi2_remove(struct platform_device *platform_dev)
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--6hGXz6ToMr4OxfZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmLtJR0ACgkQ3cLmz3+f
v9HtuAgAjbJFqp2zBhPvBdeCo2uWchkhpw5Kne+JeEllzzEEjA82pkxkJA+Ir6kY
CFHskoQgJTwR48dcvxEVXfKeFuhUxIsqWPn/ip+E2OnSeYx20VtceL1YwTEF/zCN
Gd/tvy4nlAgkGxUpifiXVeoQb/FIJFb87UO+btc/le3xo903O8vJ6mMFUP2nR+3w
rQDf2lc9t6LZldJVGm2fB7mht6KRIu8ytw4ym291tn1dKNlfzpZDr+nsMl6lqfzM
FeVSgMc7tiZy+/jYMI1vpXnGirgsjUB3qsW0im1zpcR8LGjDRTaDHx6EvXn4DF1f
Dm2Ak2aYs6juTAHdxVOJ4aUJyLIGJQ==
=xPvq
-----END PGP SIGNATURE-----

--6hGXz6ToMr4OxfZM--
