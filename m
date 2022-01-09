Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950A8488C88
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiAIVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiAIVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:23:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213B6C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:23:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6feZ-0002pa-3W; Sun, 09 Jan 2022 22:23:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6feX-009PIq-Hr; Sun, 09 Jan 2022 22:23:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6feV-00022d-VW; Sun, 09 Jan 2022 22:22:59 +0100
Date:   Sun, 9 Jan 2022 22:22:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH] counter: 104-quad-8: Add COMPILE_TEST depends
Message-ID: <20220109212251.xzwilquctuij5lev@pengutronix.de>
References: <20220105094137.259111-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bkgn73cgzbxbpdam"
Content-Disposition: inline
In-Reply-To: <20220105094137.259111-1-vilhelm.gray@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bkgn73cgzbxbpdam
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2022 at 06:41:37PM +0900, William Breathitt Gray wrote:
> 104_QUAD_8 depends on X86, but compiles fine on ARCH=3Darm. This patch
> adds support for COMPILE_TEST which is useful for compile testing code
> changes to the driver and Counter subsystem.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 3dcdb681c4e4..5edd155f1911 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -14,7 +14,7 @@ if COUNTER
> =20
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
> -	depends on PC104 && X86
> +	depends on (PC104 && X86) || COMPILE_TEST

The driver uses inb and friends. Without looking I wonder if there is
something like HAVE_IO or similar this needs to depend on for that?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bkgn73cgzbxbpdam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHbUhwACgkQwfwUeK3K
7AntkQf8CoKrukB0Gp8iUYseyEAZ1uruINCrIfotxW3JSmkoVM3+9daB+UM2ajWy
ycQ6797YTbMBeXfTedkPrUL8Zkb+BshG6jkAZ7R08GWsWwP5l8Kz4PmgycPSZGj8
DPd3iuZvaAXjJ+A7uq9Tf6rW0CTPq86x8CSnHJ5Z5mrxB1iHrxv+0p+7fPH0Ky8N
PbtVdu/vBdZg3WeGxAOCXrAe9Jqzle35h+D4wOw1SnQu7BDaQDWGj7XB5ZIXwmR0
oYiqxP/XTEpNTfU8ynMGBuct6tbOOLITYgsj7PfICMhezB4DzEKSDBEqYd4JtegO
Y3O9AIp4peR/0tzmWVdYH/ceA+Yndg==
=i/AB
-----END PGP SIGNATURE-----

--bkgn73cgzbxbpdam--
