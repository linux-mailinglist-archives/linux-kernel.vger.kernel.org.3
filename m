Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C75427F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiFHHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiFHHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:01:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D3D1B9FA8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:45:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypRR-0008Jz-JH; Wed, 08 Jun 2022 08:45:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypRN-0078SQ-Eb; Wed, 08 Jun 2022 08:45:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypRK-00EvFX-RE; Wed, 08 Jun 2022 08:45:14 +0200
Date:   Wed, 8 Jun 2022 08:45:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: use 'unsigned int' instead of 'unsigned'
Message-ID: <20220608064510.23dyydxgwz6imdaw@pengutronix.de>
References: <20220608010607.19469-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcucuprath6clvrf"
Content-Disposition: inline
In-Reply-To: <20220608010607.19469-1-yuanjilin@cdjrlc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mcucuprath6clvrf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 09:06:07AM +0800, Jilin Yuan wrote:
> Replace the 'unsigned' with 'unsigned int' which is more accurate.

What was your motivation? To please checkpatch? Please mention this in
the commit log.

> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 3977a0f9d132..d6977e4e71f3 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -35,9 +35,9 @@
> =20
>  struct atmel_tcb_pwm_device {
>  	enum pwm_polarity polarity;	/* PWM polarity */
> -	unsigned div;			/* PWM clock divider */
> -	unsigned duty;			/* PWM duty expressed in clk cycles */
> -	unsigned period;		/* PWM period expressed in clk cycles */
> +	unsigned int div;			/* PWM clock divider */
> +	unsigned int duty;			/* PWM duty expressed in clk cycles */
> +	unsigned int period;		/* PWM period expressed in clk cycles */

Please reindent the comments such they keep to be aligned.

>  };
> =20
>  struct atmel_tcb_channel {

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mcucuprath6clvrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKgRXQACgkQwfwUeK3K
7AlqFgf+PZnSf3d7O4232yef++gtkMCDcmr132nSH/+V0ZahVxZl5H/m6LFr0FbZ
KsrRIzc+sNJ8EK3WZp4nnvrT1zsiHXzhO87n3n4V6nQNClzzzrxakIKtQevIenHg
xDTbJL23lJY6pI96wt+iQqdkNAZQCIuWsH9T0QcaCYqH1eZUE3zwg9Z6ctS1fw8r
d7Lk5vdSQOCkZTdgeAzYhv9DEvIzNr4T33q9JVVCCzAj6B0JmdSSJshJT/1LwpbJ
uG4NKW9/wbWJFe4BidPyqqn3c5c78sGRKNmgzOVVmCdBveIVV9aEjIRWeSqnG6yt
zIWFknEy7/PSk6I6aZsA72MRYA3D6w==
=Vzcd
-----END PGP SIGNATURE-----

--mcucuprath6clvrf--
