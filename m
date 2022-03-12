Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2954D7096
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiCLTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiCLTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:43:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398DD1E95D5;
        Sat, 12 Mar 2022 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647114122;
        bh=gmHjb3GM7NBI5PlcZhbgVcZM3tG+NqIz10+ZQFuyclk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y5ZMg1hw7oFoPr+CFrrvDC+BxdBMDFXWEwaWVzC3693ZoXaEmrDRy1NYOCaN+9ZXZ
         VG6JynJFzjSsrGl2f8Idp6H3l556r2u6lud1XBWmVimr1OfrCVsv7KU/7M4Gexcuqe
         8GWQNbPYpYupuNt0m+IvEqdSBmaabV25D3jKhjIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1oOusc37v1-00wDxs; Sat, 12
 Mar 2022 20:42:01 +0100
Date:   Sat, 12 Mar 2022 20:41:59 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: Re: [RFC PATCH 2/6] drm: Add skeleton for EPDC driver
Message-ID: <Yiz3h0GYcyD/hgX3@latitude>
References: <20220206080016.796556-1-andreas@kemnade.info>
 <20220206080016.796556-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uMoMbLT3WzEqMEI6"
Content-Disposition: inline
In-Reply-To: <20220206080016.796556-3-andreas@kemnade.info>
X-Provags-ID: V03:K1:6RMJz1gIrCwfqHTO27MOtOn8HQvVJNHPrD278kDlI88ZiS+B9m3
 UF2lmuXG+bYI//TpkzX7JnwQKFvghalzTmPLdXNU2fY/oM5ggNuf8zL8xe/RaXAi6qvVAuv
 YuYJ3SE0ehiEdkofwWCTEaTv5U8295/BQ8ukf2DihcYM1ipPxx5jTFHnqeDlDV7p0nlRfK/
 sti09F5JQikBhdv+uzjAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rYTTcnp4vEc=:ev7zb8eTPJRCa5hLFhmiLc
 R1Wyq8I8jy10R5gez+xLFqYBZjlyq7zVTczqIJuCJnXbA8YOgo56dUzUsLBJ74z2E4cqqaNT6
 x7dih/7/vW0/Om83aTsAVfC2wBM9GljkrWlbkYblpx5hALROMTRG93Pbf7mnvabc+cDJlFBqd
 RzuLu4+ovWwivKLMXuhY8pjYgNLSrs38DGJCbnNDM0tDtJrouRM799ufrBBWqvwYzyyxqVFDe
 UwrEyVcvjTbf12FzJo4qXKlOLDBA3sNZpH5mQPoHlCD7xReERbwiawBjndg3qZu/gRh5gDevV
 ZUe2cOhWXDBwFSiEkyeO8F7XNIdZ5Cy5Xj2V+Bv1MxRtfpjRD1gpeSVXb519lReyDN9pW3ciO
 EE2WDNVvBfucquf9g8Yc/CBekHIUSu1cZPRGq9aukZkz+WLB373W71Bel6pyR09TZx/9xsqbC
 +WjbZzHFjUu8x0BsHY12K+4ph1Yk02MrUzmMFmUyivz6jW3Bp2R8t1TkK5MYqhw8E5NqF2xIL
 DDX2Wmr9fbHFxwiZSdS/w6KhLj68W/pXp1uiijP05nbTpjAklK0nZjnVrh3zdAUjeXEEKmMXu
 Nbz3FBYlU/ANdTu+AgxuZQvya/sWxLRNsd7Xf3kxTVQnFnuj1vJDJvdL/8WKDyLfMtuHS2EdD
 9Af0slaGunpRLBQo/8Tq29RVxViCP3OH9DnFNA6BIoaeey3kHU+RAqezExZKMqWEVrJQpRc/N
 Hq/Ug02w1rObaGbrrxLLFqnIM6383qMMwBOzUYmfglChgUoxxNxJLfszwAmJ0j4Epu2j45wmx
 jsvrQzaMcOb6np0t2frENzDfd0g1OjEw+0SU7H4NHWGO9jUKBMH0C5wCnrw/9X/6bAZMUU0JY
 sI9q7Xvh8I7PPZns+3CzV1CRFOXMt7OHeF0mhyB/em9bOFg90nEvqDBxDNi5GnhB6L1nWOxfy
 IHrBH0N8cgh1l7fHblC8WqX659NvScokjXCqiB4LyMejl1XU3q4VN7ErAnXctiIHwc7h/y6SD
 j3kFUP0QYo4Mi4lP9Y+wUcKpbNeVCzjOrca79xLmanRrlp5i327S8DQHYL+gcdGohiGUMwIX+
 5p1WF97sGUGfkc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uMoMbLT3WzEqMEI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 06, 2022 at 09:00:12AM +0100, Andreas Kemnade wrote:
> This driver is for the EPD controller in the i.MX SoCs. Add a skeleton
> and basic things for the driver
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gpu/drm/Kconfig                 |   2 +
>  drivers/gpu/drm/Makefile                |   1 +
>  drivers/gpu/drm/mxc-epdc/Kconfig        |  15 +
>  drivers/gpu/drm/mxc-epdc/Makefile       |   5 +
>  drivers/gpu/drm/mxc-epdc/epdc_regs.h    | 442 ++++++++++++++++++++++++
>  drivers/gpu/drm/mxc-epdc/mxc_epdc.h     |  20 ++
>  drivers/gpu/drm/mxc-epdc/mxc_epdc_drv.c | 248 +++++++++++++
>  7 files changed, 733 insertions(+)
>  create mode 100644 drivers/gpu/drm/mxc-epdc/Kconfig
>  create mode 100644 drivers/gpu/drm/mxc-epdc/Makefile
>  create mode 100644 drivers/gpu/drm/mxc-epdc/epdc_regs.h
>  create mode 100644 drivers/gpu/drm/mxc-epdc/mxc_epdc.h
>  create mode 100644 drivers/gpu/drm/mxc-epdc/mxc_epdc_drv.c
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index b1f22e457fd0..6b6b44ff7556 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -390,6 +390,8 @@ source "drivers/gpu/drm/gud/Kconfig"
> =20
>  source "drivers/gpu/drm/sprd/Kconfig"
> =20
> +source "drivers/gpu/drm/mxc-epdc/Kconfig"

I'd put it under gpu/drm/imx/epdc, perhaps.

> +int mxc_epdc_output(struct drm_device *drm)
> +{
> +	struct mxc_epdc *priv =3D to_mxc_epdc(drm);
> +	int ret;
> +
> +	priv->connector.dpms =3D DRM_MODE_DPMS_OFF;
> +	priv->connector.polled =3D 0;
> +	drm_connector_helper_add(&priv->connector,
> +				 &mxc_epdc_connector_helper_funcs);
> +	ret =3D drm_connector_init(drm, &priv->connector,
> +				 &mxc_epdc_connector_funcs,
> +				 DRM_MODE_CONNECTOR_Unknown);
> +	if (ret)
> +		return ret;
> +	ret =3D of_get_display_timing(drm->dev->of_node, "timing", &priv->timin=
g);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Possible to simplify to:

	return of_get_display_timing(drm->dev->of_node, "timing", &priv->timing);



Jonathan

--uMoMbLT3WzEqMEI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIs91QACgkQCDBEmo7z
X9su8hAApRBwjE74IrtIOWKR416R4XLl1lYHwoeDX5IkWqkKKXQF8nCYB64nSxMf
WVEwd9tp38bm+xZ5Yex8OMlTFtwNzcMcnYAWv8gHSN2dQGOEnGXQfxIOsmoiEaS2
1Oiz8c3rxkw5JUlGXANOeDVgvkiTGaSiXvBze4bAKYU5kpeovfGH8Vd7NlsW+6B4
oudpLG4Cc9VaO8wrN0ch85njP32ctCCphWwR8gfZW76y/1a7lIlZevb+2aIaotPt
BGwk6qOUzArVroHvkdKXmCJg3K1luPA0q3c68GVydewfAR5TBENsLBWjIaQUcTSi
y4Run6OpF7AKOBi8JxpRjSoPDe3MitKMtA9vlL9nlo2CW7DE4ScYb7yxgzLwcOAx
Oz8Ul0qI4e60AKhfEDs1Ugf0FCVF7SK1Kna5sjxOTqL9aeau96H9E44xaKbY+X5a
azx54txrPBQHQxY4h8OS8EOrUNhq/JQzJCMbHZxPSVqcHYruKjQ4poYuRiWlrhaB
RBrkwpfnA77IjjRSjKXEgChVxopS6vYHA+YvFX8QS1u3z7jYvdPx+hIK2WgWGQ9A
D/wsjEjtvBHezCgABsas7pDJJULig5pp89CF9tjIIJWMOHP1bZckzvY+WB7p1gCs
XWfS+v4ZrV/lwVYoKTE160ztJTqyuRLxDvGUfsX5lGS/Pig092s=
=dV4g
-----END PGP SIGNATURE-----

--uMoMbLT3WzEqMEI6--
