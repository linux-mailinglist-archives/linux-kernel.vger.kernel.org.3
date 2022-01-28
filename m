Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDD49FB16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbiA1Nwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiA1Nwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:52:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D9C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:52:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nDRft-000104-Ul; Fri, 28 Jan 2022 14:52:25 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B752525D63;
        Fri, 28 Jan 2022 13:52:23 +0000 (UTC)
Date:   Fri, 28 Jan 2022 14:52:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: imx: imx8mq-mipi_csi2: Remove unneeded code
Message-ID: <20220128135217.ncvjlffzpxxmqbjo@pengutronix.de>
References: <20220128133649.1393201-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dx5rohrd5cck77jd"
Content-Disposition: inline
In-Reply-To: <20220128133649.1393201-1-usama.anjum@collabora.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dx5rohrd5cck77jd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.01.2022 18:36:49, Muhammad Usama Anjum wrote:
> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
> return error. Remove the return variable. Simplify other functions which
> are using this function.
>=20
> Fixes: f0c2ba1ed4ad ("media: imx: imx8mq-mipi_csi2: fix system resume")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/stagi=
ng/media/imx/imx8mq-mipi-csi2.c
> index 3b9fa75efac6b..c992b845e63d1 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
[...]
>  static int imx8mq_mipi_csi_pm_resume(struct device *dev)
> @@ -742,15 +739,12 @@ static int __maybe_unused imx8mq_mipi_csi_suspend(s=
truct device *dev)
>  {
>  	struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
>  	struct csi_state *state =3D mipi_sd_to_csi2_state(sd);
> -	int ret;
> =20
> -	ret =3D imx8mq_mipi_csi_pm_suspend(dev);
> -	if (ret)
> -		return ret;
> +	imx8mq_mipi_csi_pm_suspend(dev);
> =20
>  	state->state |=3D ST_SUSPENDED;


what about this flag?

Marc
> =20
> -	return ret;
> +	return 0;
>  }


--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dx5rohrd5cck77jd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHz9Q4ACgkQqclaivrt
76lVnwf+NtLWUcGwRaQU8qVIfD2JIN5aGN77aOgc7JGPbxiAkgkUykI369EyomLn
oYXYq5vqJBX028EJq7ON0lPwN89keJ0eK/zIUns+iwNq8qeKeiT0tdZEIcF7zSkN
zbwTw8HScw962Js4SOlDqK2HZdnTq27zkI3H4EVxKwu6UWxfHnJjwU0nwDVIt3vQ
o+YOvYGjRqYeDZpGgyBOvbVRVI8Q19wSa9HxSLbYqOkJCQ7LWm3NTuNIZ2dUiuHi
UqjO12a7S4bUnW8u7tOIFh1IxMH8wfoV4icv+EcDFgdM4ucEkkyVD81xChU8PY/P
okLuFoWo4I1iCaTY+Ucelrmx7to+OQ==
=yv42
-----END PGP SIGNATURE-----

--dx5rohrd5cck77jd--
