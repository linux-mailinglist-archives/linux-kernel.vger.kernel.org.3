Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244235454F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbiFITaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbiFITaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:30:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97682342A8;
        Thu,  9 Jun 2022 12:29:57 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 880C96601606;
        Thu,  9 Jun 2022 20:29:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802996;
        bh=jIKg3D8DJOlIR1nY1tGy/3dvTFvVhUu36vgdLhgBwfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U25b6jRGh3VD+/puEHl45HnreMP8F9hQAtQ4eOdLYvajY4hOGUylCobxm1SjY2DVM
         +jp0IoHAyCTIPd9FIAzxcmTLWo96jFWs8RZ5HVHXvMvlcSTj8Pl/XRzZzrEWjDWEOS
         Ruc0DbYO2rDb4tQFT6wbXriW04DAwIKThICQT6brg3TT0WcUOoesTRo/W/GqxATOwj
         3+6UVrLooJm0FPkK5tZSLK9xYgbstqDGfSghFymPvofd7Ohy2F9memjCHAC8SkHn/0
         J2q8ytMeCsG+wyjlCZ+vrX7L5+oZ49AaSNc17UmNzRXm5neakLnXHg7GdaJC191ldk
         fwgXs6Ek5k35g==
Received: by mercury (Postfix, from userid 1000)
        id E779D10605B9; Thu,  9 Jun 2022 21:29:53 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:29:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: lp8788: fix typo in comment
Message-ID: <20220609192953.kwf5wcyv2qjfnwhj@mercury.elektranox.org>
References: <20220521111145.81697-25-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lymlb2ckzehdom4u"
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-25-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lymlb2ckzehdom4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 21, 2022 at 01:10:35PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/lp8788-charger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 397e5a03b7d9..56c57529c228 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -376,7 +376,7 @@ static int lp8788_update_charger_params(struct platfo=
rm_device *pdev,
>  		return 0;
>  	}
> =20
> -	/* settting charging parameters */
> +	/* setting charging parameters */
>  	for (i =3D 0; i < pdata->num_chg_params; i++) {
>  		param =3D pdata->chg_params + i;
> =20
>=20

--lymlb2ckzehdom4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiSjEACgkQ2O7X88g7
+po7PRAAqNR01HKBfkw69TI0hdhqDRZfRNFVEG4ts0R9jkXYjg4rYy0+jVYf+KAd
q3pM2hvblEz4weQKxY5oJcSg7hLYOyMH4SSOE5xrKaKONolquvW5eHLXRuuM0dOT
9lJThCYf4JLuYVnOQvAUehFJbvQ0R0kriFA45oszNm+8Lt8PK3MpH8gyoWSLRZ/y
q7eyo/DkrBAQ1xD5NVvCFdg+c4qOi61OemxrY0jTY/Gez47Ax1QyWILo2r4rcPts
aImdMbie1wAtZq9Mge8815c8A0H7nX3nnqdO8sxNpkpnnGPtRU5QITwPZbizprYX
7MDNSkb0F3ztAgeFcZgEoGeMvdXwlsTr4shzgbVyoXgtGy/Fd9L89NUWc+x/1Dsz
OMjSqYeGchNb+bqKQ4mrOcXaV99dZhGH85sPi5+lE48nIvVpsGGroQmJv4pqyOkX
yUs+pXrLnx8WzRRbZsP4xuqglokJwfkVHxtBZ8HWQ+EvZpu6PRs/if2KA+Kp8mn1
E2BUr9+mgcPs+MzE4hb5UQ/1d87RjmvOZD2HUjDhUh4Y65pfpteZyv4Dsu21LNPV
BCaTdQbWrlC7E24CIdAURz5VXXTpBAP5ycHVAsC/8Ac0yhGcfepAiYZqYUOBVu/r
9k3R/q7frlbIe9Q3cgrYCuFvOhM1eCiwmFVlsgh7QuUwklsWWjY=
=97dU
-----END PGP SIGNATURE-----

--lymlb2ckzehdom4u--
