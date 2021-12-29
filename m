Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A404811E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhL2LLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhL2LLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:11:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3CC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:11:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wri-0005Ii-PF; Wed, 29 Dec 2021 12:11:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wrh-007Hzp-Qv; Wed, 29 Dec 2021 12:11:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2Wrg-0003Hm-Qg; Wed, 29 Dec 2021 12:11:28 +0100
Date:   Wed, 29 Dec 2021 12:11:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 05/23] counter: 104-quad-8: Convert to counter_priv()
 wrapper
Message-ID: <20211229111125.y64fajggly2g46qr@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-6-u.kleine-koenig@pengutronix.de>
 <20211228180224.1d214eae@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qchpnmmbl3n7edna"
Content-Disposition: inline
In-Reply-To: <20211228180224.1d214eae@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qchpnmmbl3n7edna
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 28, 2021 at 06:02:24PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Dec 2021 10:45:08 +0100
> Uwe Kleine-K=F6nig         <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > This is a straight forward conversion to the new counter_priv() wrapper.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Looks sane and I'll assume you didn't miss any!

I assume so, too. At least it still compiles after I dropped priv from
struct counter_device :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qchpnmmbl3n7edna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMQloACgkQwfwUeK3K
7AlDpAf/dPCrjfmQtWSlb96uh4ZuEnh6E4SqZmfR2lpMZTF9C4WR4vkvs82pC5f8
XgpI0LHsC3TZQD9DMbRFS7SsuG1492U9+wUMbQG1C/E975PbHit+JeBEZiXu1LJc
bN9h4rWHqrU/G1iI/fZpbmNiG5Qpwhi3QfuYVeWibQJzOTycfkYc0Y0DgCgQnTIP
AaOXA+Qj5LcWZjPxPkWYMOMB82f0BSOQFDnLZTpvJE0Ls/Pr0M2SX2RJ9Daqi7/P
vvL1/1wkFeDZQcvViunejj3q9nSz+ufe0GvP6Lbb6dta+w9M6l9g+BqxogzPvCou
UlpRf8r5XOvAKAVL6YueCo+evY7Geg==
=p8zs
-----END PGP SIGNATURE-----

--qchpnmmbl3n7edna--
