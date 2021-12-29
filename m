Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E024811F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhL2LTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhL2LTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:19:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED694C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:19:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wz5-0005wR-MC; Wed, 29 Dec 2021 12:19:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wz4-007I0m-P4; Wed, 29 Dec 2021 12:19:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wz2-0003ff-Vl; Wed, 29 Dec 2021 12:19:04 +0100
Date:   Wed, 29 Dec 2021 12:19:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/23] counter: ti-eqep: Convert to counter_priv()
 wrapper
Message-ID: <20211229111902.b2jnbtxah6mvba2k@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-11-u.kleine-koenig@pengutronix.de>
 <YcwSEX//xHtIUnU1@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bl7qtiwyuyfjafdn"
Content-Disposition: inline
In-Reply-To: <YcwSEX//xHtIUnU1@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bl7qtiwyuyfjafdn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 04:45:21PM +0900, William Breathitt Gray wrote:
> On Mon, Dec 27, 2021 at 10:45:13AM +0100, Uwe Kleine-K=F6nig wrote:
> > This is a straight forward conversion to the new counter_priv() wrapper.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This patch conflicts with commit 60f07e74f86b ("counter: ti-eqep: Use
> container_of instead of struct counter_device::priv"). Because that
> commit has a similar purpose as this patchset, I'm going to skip this
> patch for now and continue looking over the rest of the patches in this
> series.

Ah right. I will base v3 on top of v5.16-rc6 + 60f07e74f86b.=20

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bl7qtiwyuyfjafdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMRCIACgkQwfwUeK3K
7AkKOgf/W6+mW7y2b7brUulOPITWZmMdvGG0m4Anjc2Cq0wKLBDUT4oxyGGbSEhX
EeYT4rcwrnttOJmA2/8Mfr0/mIl5eOwM+4uNnQm0Q4srP1mjw6XDbNSgBdLVS+j2
fn2KRVReL9WShZjqXGK7GjXOuyjbf6eR+DsLZtQ7VDOUBBc2JLCoon7D53864gvj
oz1E4gmw7193vtXMYb37Dy40CM3ooXlXHcFX2PvRLZWYS8/ypy/ESGIXIsbb4zV+
USjfIVvfcP8F2sM6bjl6QLpA3PrtvdZoDfDh95tmLWIV4n06dm36pJEy9isXNhFX
4Z1q47X7STBdNd36EfiNVhycVsGZ/Q==
=xu+3
-----END PGP SIGNATURE-----

--bl7qtiwyuyfjafdn--
