Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFF4811EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhL2LPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhL2LPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:15:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:15:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2WvW-0005mq-MR; Wed, 29 Dec 2021 12:15:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2WvW-007I0H-CJ; Wed, 29 Dec 2021 12:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2WvV-0003UB-BV; Wed, 29 Dec 2021 12:15:25 +0100
Date:   Wed, 29 Dec 2021 12:15:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 05/23] counter: 104-quad-8: Convert to counter_priv()
 wrapper
Message-ID: <20211229111522.eybtnyxabuwtf4r5@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-6-u.kleine-koenig@pengutronix.de>
 <YcwN5e7zjNLANT6d@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rbdmtmosyoyksye4"
Content-Disposition: inline
In-Reply-To: <YcwN5e7zjNLANT6d@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rbdmtmosyoyksye4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Wed, Dec 29, 2021 at 04:27:33PM +0900, William Breathitt Gray wrote:
> On Mon, Dec 27, 2021 at 10:45:08AM +0100, Uwe Kleine-K=F6nig wrote:
> > This is a straight forward conversion to the new counter_priv() wrapper.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This patch results in a minor merge conflict with commit c95cc0d95702
> ("counter: 104-quad-8: Fix persistent enabled events bug") in linux-next
> due to context changes in quad8_events_configure() and
> quad8_watch_validate(). Fixing this after a rebase is trivial so I'll
> give my Ack here.

this raises the question how this patch set is to be merged. My
expectaion up to now was, that this goes via you, so the merge conflict
shouldn't be an issue? What is your expectation who will pick up this
series?

Would a PR helpful, or will the series be picked up from the mailing
list?

I'm about to prepare a v3 adding all the review tags and fixing the few
issues that were pointed out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rbdmtmosyoyksye4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHMQ0YACgkQwfwUeK3K
7AltxQf/V/ZwbibW1Bu47SWroYp9ouc/1mBvuwrmWa1oxxcnaIt7mahaPt6MnQJP
EudhyHb1teS6JYhLZbRwPQglJlsITJNjjJFNbtdE1LLmfKZN2wh8j828bySFn6Ad
XfPp3QGcaGZ4BOBDNzLeMYWAkZ1x4nZcwsLSsoMvM7vkds+J63JF4BHQ9FAcUxra
zhDt6T71pub3i7X4EJ+LOMbajbYF0EiCpJDVZjTmZG8TDW3URZDxgSFQDN2qjWvr
hq8mqvaQL8hPenB7MlycKXFTxpH0DDwgn3ai8l8Cuu3GYRdeg+d15y0kG6tTUzBp
qHXGqawXf65XShZBQ+LAVQP3hoKtrA==
=FzBW
-----END PGP SIGNATURE-----

--rbdmtmosyoyksye4--
