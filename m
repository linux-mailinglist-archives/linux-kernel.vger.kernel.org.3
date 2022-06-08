Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BA25427B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFHHWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbiFHHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:12:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DF1CF93C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:51:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypXY-0000mV-3Y; Wed, 08 Jun 2022 08:51:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypXU-0078Sz-To; Wed, 08 Jun 2022 08:51:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nypXS-00EvGb-Qb; Wed, 08 Jun 2022 08:51:34 +0200
Date:   Wed, 8 Jun 2022 08:51:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stmpe: Deleted extra {}
Message-ID: <20220608065131.svkxcwfgzdd7cs57@pengutronix.de>
References: <20220608010318.18040-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7azeu5p4ver3v3re"
Content-Disposition: inline
In-Reply-To: <20220608010318.18040-1-yuanjilin@cdjrlc.com>
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


--7azeu5p4ver3v3re
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 09:03:18AM +0800, Jilin Yuan wrote:
> Remove unnecessary braces
>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/pwm/pwm-stmpe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
> index 2df526fe9c38..c45fe27859de 100644
> --- a/drivers/pwm/pwm-stmpe.c
> +++ b/drivers/pwm/pwm-stmpe.c
> @@ -78,10 +78,9 @@ static void stmpe_24xx_pwm_disable(struct pwm_chip *ch=
ip,
>  	value =3D ret & ~BIT(pwm->hwpwm);
> =20
>  	ret =3D stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
> -	if (ret) {
> +	if (ret)
>  		dev_err(chip->dev, "error writing PWM#%u control\n",
>  			pwm->hwpwm);
> -	}
>  }

This doesn't apply to neither next nor on the pwm tree nor on Linus
Torvald's tree. Please always mention preconditions of your patches,
preferably using git format-patch's --base option.

In this case it builds on top of a patch that was sent to only some
maintainers, but no public list. Please squash these patches together
and send them to (at least) linux-pwm@vger.kernel.org.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7azeu5p4ver3v3re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKgRvAACgkQwfwUeK3K
7Aly8gf+IsXwM8wK6WR96UUHInicXEyDlpcmhCEbr3j0EI3D8JLbzSBwABVFvzVy
gVCD/rvGtjr5R7jRS3TCshBUoqdSxcf50Rt+aUPvxlUAzs/eqhIVqE0B9kEwI0U/
vAqW/55RtMNlL/eZV40sm/2OJ8SoSxZMZrI9xyh9BAdvUgGLMnKiWIkRy8ofA7pw
aUyoMHGL1zGE8s4STMPIQ+s59D4HCSwTksnYJYxHeu+UCAvVYXWIp2XVek52Dh/a
DyR8PbYvwXIfk26gENsvwXfKg2AQixfVSZukfj3whieoEsEbsfUWHkPdYQAxPnDY
X31yMqD443j/uEeaCDsmicULvIXdGg==
=en01
-----END PGP SIGNATURE-----

--7azeu5p4ver3v3re--
