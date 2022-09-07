Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0245B001F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIGJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:13:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95A3AF0F5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:13:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr7o-0004DW-F1; Wed, 07 Sep 2022 11:13:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr7l-004PfW-Sp; Wed, 07 Sep 2022 11:13:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr7n-00GfdX-6x; Wed, 07 Sep 2022 11:13:35 +0200
Date:   Wed, 7 Sep 2022 11:13:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 4/9] pwm: lpss: Include headers we are direct user of
Message-ID: <20220907091335.zls4vnacbtyrj5t5@pengutronix.de>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220906195735.87361-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qech4paygatkpfea"
Content-Disposition: inline
In-Reply-To: <20220906195735.87361-4-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qech4paygatkpfea
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 10:57:30PM +0300, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are direct user of.
>=20
> While at it, replace device.h with a forward declaration.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index 5995b6b750a8..832cb86996d7 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -10,11 +10,15 @@
>  #ifndef __PWM_LPSS_H
>  #define __PWM_LPSS_H
> =20
> -#include <linux/device.h>
>  #include <linux/pwm.h>
> +#include <linux/types.h>
> =20
>  #define MAX_PWMS			4
> =20
> +struct device;
> +
> +struct pwm_lpss_boardinfo;

the commit log doesn't explain the pwm_lpss_boardinfo part?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qech4paygatkpfea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMYYLwACgkQwfwUeK3K
7AlJtAf+Mj8VJBKBk0UlTh7Ncot6u/Md5hRPB7pOrLYk7Or2vFCeG3ts8EFVV/wb
3uKyktxKruONUfHSxrgvRr2sjMACX6CSE+xclA/ud+/AWb1OLF9zKWI1COIQElo4
8jYwubDXzwraYtfLjmKqK6fpRYSOdxCKevkU8Fz2N0qO17zlOMfBihJH3YWiGja4
8MzO/rR53OyI0Jd7VPmnAlIZhwuxZCbroIOYFLr6DtloovQOtmg3VrCrgGN6ap9F
BqNNV5d4ghAKPbe94vwsGCFe2LgqduLxuHCleIIOHPD6h5PSW1tHi+4no153jY/1
s9MuQnf06iusOGz5aDaoy/G4exEo1w==
=s4N/
-----END PGP SIGNATURE-----

--qech4paygatkpfea--
