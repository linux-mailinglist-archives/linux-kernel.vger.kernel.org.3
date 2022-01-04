Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C85484B20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiADXTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiADXTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:19:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A71C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 15:19:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4t5F-0003SH-U3; Wed, 05 Jan 2022 00:19:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4t5E-008UtF-AY; Wed, 05 Jan 2022 00:19:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4t5D-0004Al-Ao; Wed, 05 Jan 2022 00:19:11 +0100
Date:   Wed, 5 Jan 2022 00:19:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Make cros_ec_unregister()
 return return void
Message-ID: <20220104231908.tmcubfbywn5yywpt@pengutronix.de>
References: <20211019203850.3833915-1-u.kleine-koenig@pengutronix.de>
 <CABXOdTeOO=Yf37_p1c8HVigkqqRyR90RqRDaLk5qxxp3jAGgEA@mail.gmail.com>
 <20211020071753.wltjslmimb6wtlp5@pengutronix.de>
 <CABXOdTcgbobZwVarxXt8J+MTB2v4fO5uq+wZWCTwWsg=4mQTzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hy43p6xcc4bai3sm"
Content-Disposition: inline
In-Reply-To: <CABXOdTcgbobZwVarxXt8J+MTB2v4fO5uq+wZWCTwWsg=4mQTzg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hy43p6xcc4bai3sm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 20, 2021 at 05:54:24AM -0700, Guenter Roeck wrote:
> On Wed, Oct 20, 2021 at 12:17 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Up to now cros_ec_unregister() returns zero unconditionally. Make it
> > return void instead which makes it easier to see in the callers that
> > there is no error to handle.
> >
> > Also the return value of i2c, platform and spi remove callbacks is
> > ignored anyway.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

This patch is one of the very few ones that are still required to change
spi_driver::remove to return void.

It doesn't appear in next up to now. Who feels responsible to merge it?
If it's still possible to go in during the next merge window this would
be great. I guess we'll have to prepare an unmutable branch to change
struct spi_driver and the patch can also be included there.

Whatever works best for the involved maintainers ... I just have to know
your preferences.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hy43p6xcc4bai3sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHU1ekACgkQwfwUeK3K
7AmEFQf/b0Q3HCrfq2wCfnvpmLqeInh7OX6tVUomK1t2qmyr1lwEQlaOevsZ3WRx
6moTKWckp5Fq3PUhX2jPBYVfJAPHWG5HT8/v66jPmO0+KW3dASOdGMZllotUJfk0
pTkoR0o61kTu+SijIJFtmO/Wv19Spp23mwfZGPjP+CfZJN7jZMpER8lW82i0vzFi
3ecdTta87grDteKF9ye6WQplfRX7/QdnUjGjd+e8oOgtpRJwTu38la9Q+282138N
gga9ebCROoQgq95wrrM9wl3pX28WYW70/kfqwbYKG6jIJSfEYT/mdFq0WI7kxcVE
nlqADIeexJ/WlBoqSWoEZVNWNwZ97Q==
=PIhq
-----END PGP SIGNATURE-----

--hy43p6xcc4bai3sm--
