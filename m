Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD947C0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhLUNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLUNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:23:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:23:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzf6e-0001mV-M1; Tue, 21 Dec 2021 14:23:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzf6Z-005pOs-Vx; Tue, 21 Dec 2021 14:22:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzf6Y-0004cW-MI; Tue, 21 Dec 2021 14:22:58 +0100
Date:   Tue, 21 Dec 2021 14:22:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
Message-ID: <20211221132258.472t537373vto7bz@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
 <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
 <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
 <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzpyvvyijl5eeftp"
Content-Disposition: inline
In-Reply-To: <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vzpyvvyijl5eeftp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 21, 2021 at 01:04:50PM +0100, Lars-Peter Clausen wrote:
> On 12/21/21 12:35 PM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Dec 21, 2021 at 12:12:12PM +0100, Lars-Peter Clausen wrote:
> > > On 12/21/21 11:45 AM, Uwe Kleine-K=F6nig wrote:
> > > > similar to patch
> > > > https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.=
1640072891.git.vilhelm.gray@gmail.com
> > > > the usage of struct counter_device::priv can be replaced by
> > > > container_of which improves type safety and code size.
> > > >=20
> > > > This series depends on above patch, converts the remaining drivers =
and
> > > > finally drops struct counter_device::priv.
> > > Not sure if this is such a good idea. struct counter_device should no=
t be
> > > embedded in the drivers state struct in the first place.
> > Just to mention it: My patch series didn't change this, this was already
> > broken before.
>=20
> I know, but this series has to be reverted when the framework is fixed.

All drivers have to be touched. With my patch series you have to modify
one function in each driver, without my patch you have touch nearly
every function.

*shrug*

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vzpyvvyijl5eeftp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHB1S8ACgkQwfwUeK3K
7AmdXwf8C/nqQs80YpTkc4NkxCBn5t8pVGv+QO/f/a3ZRQJQhBqVXCT9t21L2/Qn
qhAyte5adQCclwmGbNBF6yCbeaOcpPUnOKTLkGFSRwZmegufiplQ22mC0jPbR0En
kQ0/Gbipbw/bIpUqDfCF7FE+0n5dY/Vbb6vlaiqnKhAGS0mxC/9BKVEaK/m4OJ+Z
vybjLOuICI1O/c+NW67/y2yuzktrpAE4i8mOl/yRxV5WbRGB7qVJR6veB0weU4+v
c2lzI/l9AZGDGX6tzon+SYHrKg8FFzFlU9ivITHC6orIAuwj4Dx0nraqycQI94wu
vG9kWmiQUwVgW5zv0R3jDOsksS3lOg==
=xdQv
-----END PGP SIGNATURE-----

--vzpyvvyijl5eeftp--
