Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E459E68B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiHWQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiHWQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:03:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A68160D25;
        Tue, 23 Aug 2022 05:16:02 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D0ACA100005;
        Tue, 23 Aug 2022 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661256931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5TmLCHPK5E0nm75VJK+T53tNXdfQmvWnT/uitrfXPg=;
        b=S+wZwphu2ou9BxD3kjR7q0OxtNRyZLlkAJCxtRpwKtFLH8NbsxK2QHE7X0hi48qg9y2zea
        0TVXjYv/cMZkUshBmVBZdXNFcxQtUCTUY4J4yAsH1WUfXXegs/RCJXMAxgOAB3p1QMfs66
        Ydlgg1OBLCeOqlzDM0TLtv/fr+NXbw/mqoIH0NJftiEHftkzvHK8IkR943ar2vF0pWH2MQ
        iNY5Caou6nF83m09APpllDrJdu5L08Rkuy0K/mlvr7HFSNlpOvG9NFE6bsKdBsgTwkcpdy
        AXb8TtsGVjfrhyNKiJbV/NlT5JYyD/Q+OQCkzHwlZnfKWe1POtQB6i7Dt/2obw==
Date:   Tue, 23 Aug 2022 14:15:24 +0200
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
Subject: Re: [PATCH v2 1/2] media: sunxi: Fix some error handling path of
 sun8i_a83t_mipi_csi2_probe()
Message-ID: <YwTE3JhyTpGmgqpU@aptenodytes>
References: <28d04b260acff7eb4416a410d5678cbafb5e2784.1661240416.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zf0Q/oZJQ1a+q7Zj"
Content-Disposition: inline
In-Reply-To: <28d04b260acff7eb4416a410d5678cbafb5e2784.1661240416.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zf0Q/oZJQ1a+q7Zj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Tue 23 Aug 22, 09:42, Christophe JAILLET wrote:
> Release some resources in the error handling path of the probe and of
> sun8i_a83t_mipi_csi2_resources_setup(), as already done in the remove
> function.

Looks good to me, thanks!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

> Fixes: 576d196c522b ("media: sunxi: Add support for the A83T MIPI CSI-2 c=
ontroller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I'm unsure about the phy_exit() call in
> sun8i_a83t_mipi_csi2_resources_cleanup() because no explicit phy_init()
> call is performed.
>=20
> The same code is in sun6i-mipi-csi2/sun6i_mipi_csi2.c, but in this driver
> phy_init() IS called.
>=20
> I leave it as-is because I don't if it is an issue or not.
> My feeling is that it is a copy'n'paste error and that it should be
> removed.

Actually it's a legitimate call. The d-phy is internal on A83T and it's
registered in sun8i_a83t_dphy_register, which is called from
sun8i_a83t_mipi_csi2_resources_setup.

Cheers,

Paul

> Changes in v2:
>   * add some blank line   [Paul Kocialkowski <paul.kocialkowski@bootlin.c=
om>]
>   * rename the new labels   [Paul Kocialkowski <paul.kocialkowski@bootlin=
=2Ecom>]
>=20
> v1:
>   https://lore.kernel.org/all/62c0aef8d3b86d8f290bf6787f1b2b41efbb0b55.16=
59295329.git.christophe.jaillet@wanadoo.fr/
> ---
>  .../sun8i_a83t_mipi_csi2.c                    | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_mipi_csi2.c
> index d052ee77ef0a..b032ec13a683 100644
> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_c=
si2.c
> @@ -719,13 +719,15 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a=
83t_mipi_csi2_device *csi2_de
>  	csi2_dev->clock_mipi =3D devm_clk_get(dev, "mipi");
>  	if (IS_ERR(csi2_dev->clock_mipi)) {
>  		dev_err(dev, "failed to acquire mipi clock\n");
> -		return PTR_ERR(csi2_dev->clock_mipi);
> +		ret =3D PTR_ERR(csi2_dev->clock_mipi);
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	csi2_dev->clock_misc =3D devm_clk_get(dev, "misc");
>  	if (IS_ERR(csi2_dev->clock_misc)) {
>  		dev_err(dev, "failed to acquire misc clock\n");
> -		return PTR_ERR(csi2_dev->clock_misc);
> +		ret =3D PTR_ERR(csi2_dev->clock_misc);
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	/* Reset */
> @@ -733,7 +735,8 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83=
t_mipi_csi2_device *csi2_de
>  	csi2_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi2_dev->reset)) {
>  		dev_err(dev, "failed to get reset controller\n");
> -		return PTR_ERR(csi2_dev->reset);
> +		ret =3D PTR_ERR(csi2_dev->reset);
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	/* D-PHY */
> @@ -741,7 +744,7 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a83=
t_mipi_csi2_device *csi2_de
>  	ret =3D sun8i_a83t_dphy_register(csi2_dev);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize MIPI D-PHY\n");
> -		return ret;
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	/* Runtime PM */
> @@ -749,6 +752,11 @@ sun8i_a83t_mipi_csi2_resources_setup(struct sun8i_a8=
3t_mipi_csi2_device *csi2_de
>  	pm_runtime_enable(dev);
> =20
>  	return 0;
> +
> +error_clock_rate_exclusive:
> +	clk_rate_exclusive_put(csi2_dev->clock_mod);
> +
> +	return ret;
>  }
> =20
>  static void
> @@ -778,9 +786,14 @@ static int sun8i_a83t_mipi_csi2_probe(struct platfor=
m_device *platform_dev)
> =20
>  	ret =3D sun8i_a83t_mipi_csi2_bridge_setup(csi2_dev);
>  	if (ret)
> -		return ret;
> +		goto error_resources;
> =20
>  	return 0;
> +
> +error_resources:
> +	sun8i_a83t_mipi_csi2_resources_cleanup(csi2_dev);
> +
> +	return ret;
>  }
> =20
>  static int sun8i_a83t_mipi_csi2_remove(struct platform_device *platform_=
dev)
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Zf0Q/oZJQ1a+q7Zj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMExNwACgkQ3cLmz3+f
v9Ewtgf/c1Y6CSlgUraQaIpRkX5NzmC9hNvdmu1PVEO0RhsSgMMBbWz9/6l/H5v8
sisSe4S3DJppSbUqG8UbKpuVdVMDPmF9Wozdr1HavIW6api/jdehbjN+1TyWFPkG
ZM2nmlpV3iG6e6Kyu8Qz3+o+wQSMet9/HGoudU3VEN71bCHKJJUB2l2r26nVk6HG
bFAViEIx7YdfhSRdnX5KjZ6GDk4+J+kzAbA/IEEKCY/EQ11B+qwjnueMGzhkacsP
5ZiDm8LcBsAfn3FywDRREMzM+yIZI6UTFG15yyekiW50PRwsxI6jf4Ezfy6+a7XK
XC4i8/5NPVDWmAXcI9HB4zfmeYlYAw==
=HAKz
-----END PGP SIGNATURE-----

--Zf0Q/oZJQ1a+q7Zj--
