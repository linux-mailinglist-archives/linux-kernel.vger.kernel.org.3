Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF759E695
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbiHWQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbiHWQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:04:08 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F151E0C4A;
        Tue, 23 Aug 2022 05:16:11 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDF0440008;
        Tue, 23 Aug 2022 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661256969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etPKwelbA+tTlRYYdrHTtYLe08SrSj0mjH5eb5hJOEo=;
        b=EcLUICxWmL3GxUpjFUhfExprDuK1skDWZXJGnScRsI6HP5ULN2w9+NZ8YMIS9OFyq/l94X
        shMqLJqioe+hY3441wZ4QTVwjqRjFdwWr9Vv/Gd9Qc1T4kM9/rLAY2R0RmQg+oeQq+Ter/
        Y88/CaLJeYMRh5rd5yQPjCr1PaLx2uyHyYvpmwPiAkAXQjIFEbuAktxWMAGIRM23DT4rwG
        91iZbgFnhaxeKfnRITkx7SMYg+Xs7ASb4+D+jGKUi6J4CQOLpi7nUVb/K04btf4wRUm4wK
        a2rF4snOc8bHl3/TcUdGIN4MJ5GZ0qoPaon1LQapBpjxtYKMbllBBIr5HGODoQ==
Date:   Tue, 23 Aug 2022 14:16:02 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/2] media: sunxi: Fix some error handling path of
 sun6i_mipi_csi2_probe()
Message-ID: <YwTFApDoY0c/LH45@aptenodytes>
References: <28d04b260acff7eb4416a410d5678cbafb5e2784.1661240416.git.christophe.jaillet@wanadoo.fr>
 <69f418936bf0060287d237824a677192343b91ab.1661240416.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aPxKs6zDsOLiGtPt"
Content-Disposition: inline
In-Reply-To: <69f418936bf0060287d237824a677192343b91ab.1661240416.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPxKs6zDsOLiGtPt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Tue 23 Aug 22, 09:42, Christophe JAILLET wrote:
> Release some resources in the error handling path of the probe and of
> sun6i_mipi_csi2_resources_setup(), as already done in the remove
> function.

Looks good to me, thanks!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul
=20
> Fixes: af54b4f4c17f ("media: sunxi: Add support for the A31 MIPI CSI-2 co=
ntroller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in v2:
>   * add some blank line   [Paul Kocialkowski <paul.kocialkowski@bootlin.c=
om>]
>   * rename the new labels   [Paul Kocialkowski <paul.kocialkowski@bootlin=
=2Ecom>]
>=20
> v1:
>   https://lore.kernel.org/all/9999a30560d0ab8201734cbab0483c6f840402da.16=
59295329.git.christophe.jaillet@wanadoo.fr/
> ---
>  .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c   | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2=
=2Ec b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> index a4e3f9a6b2ff..30d6c0c5161f 100644
> --- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> +++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> @@ -661,7 +661,8 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_csi=
2_device *csi2_dev,
>  	csi2_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi2_dev->reset)) {
>  		dev_err(dev, "failed to get reset controller\n");
> -		return PTR_ERR(csi2_dev->reset);
> +		ret =3D PTR_ERR(csi2_dev->reset);
> +		goto error_clock_rate_exclusive;
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
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	ret =3D phy_init(csi2_dev->dphy);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize MIPI D-PHY\n");
> -		return ret;
> +		goto error_clock_rate_exclusive;
>  	}
> =20
>  	/* Runtime PM */
> @@ -683,6 +685,11 @@ sun6i_mipi_csi2_resources_setup(struct sun6i_mipi_cs=
i2_device *csi2_dev,
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
> @@ -712,9 +719,14 @@ static int sun6i_mipi_csi2_probe(struct platform_dev=
ice *platform_dev)
> =20
>  	ret =3D sun6i_mipi_csi2_bridge_setup(csi2_dev);
>  	if (ret)
> -		return ret;
> +		goto error_resources;
> =20
>  	return 0;
> +
> +error_resources:
> +	sun6i_mipi_csi2_resources_cleanup(csi2_dev);
> +
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

--aPxKs6zDsOLiGtPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMExQIACgkQ3cLmz3+f
v9HgnAf+NpBFcCGKtldzFOK2iXMmRJoDixDIpBBvqdDqGMnyn7JII4kfn+kGbUhI
ScdBPKYWdj5cJ2QRawxmQsQccXjq7ixywdrroxJqScfsRJosWsVXVGz0XngrFEuB
JoF4MyLo63l63X0ht9fVgpkxHr2uMDfdUXMyxCY123Fd1JuarllEWmZlMks5gPTW
B1aKYEu5izRREnLf/PEnf6Y1HNYJyg5tbyDy2MGP/0cp3REfdn8ss4l2T1Z1/A2a
YE+2XzZwi8ck4yrmSJgYBLPdqDuM0oLrW8R5L+Qm0qArVlRVwB+ryc3bDHPjPoRA
pIj3Mc/xpvAVXgBZKIh+bBR/neqPHg==
=Q5/R
-----END PGP SIGNATURE-----

--aPxKs6zDsOLiGtPt--
