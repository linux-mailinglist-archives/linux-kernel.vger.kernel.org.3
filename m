Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E7481D95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhL3PIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhL3PIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:08:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1EC061401
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:08:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2x2e-0002NA-4e; Thu, 30 Dec 2021 16:08:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2x2b-007VMX-5P; Thu, 30 Dec 2021 16:08:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2x2a-00081Q-4e; Thu, 30 Dec 2021 16:08:28 +0100
Date:   Thu, 30 Dec 2021 16:08:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20211230150828.iy7julxbvlcupazx@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211230085351.pywngltvdam25emx@pengutronix.de>
 <20211230145826.7f23becb@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7547pgm5uqxs232y"
Content-Disposition: inline
In-Reply-To: <20211230145826.7f23becb@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7547pgm5uqxs232y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 30, 2021 at 02:58:26PM +0000, Jonathan Cameron wrote:
> On Thu, 30 Dec 2021 09:53:51 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello,
> >=20
> > On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-K=F6nig wrote:
> > > this is v3 of my series to fix device lifetime issues in the counter
> > > framework. This hopefully addresses all things pointed out for v2.
> > >=20
> > > Note this depends on 60f07e74f86b (which is in next) now. Full diffst=
at
> > > below.
> > >=20
> > > Things that could be further improved:
> > >=20
> > > [...]
> > >=20
> > > Uwe Kleine-K=F6nig (23):
> > >   counter: Use container_of instead of drvdata to track counter_device
> > >   counter: ftm-quaddec: Drop unused platform_set_drvdata()
> > >   counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
> > >   counter: Provide a wrapper to access device private data
> > >   counter: 104-quad-8: Convert to counter_priv() wrapper
> > >   counter: interrupt-cnt: Convert to counter_priv() wrapper
> > >   counter: microchip-tcb-capture: Convert to counter_priv() wrapper
> > >   counter: intel-qep: Convert to counter_priv() wrapper
> > >   counter: ftm-quaddec: Convert to counter_priv() wrapper
> > >   counter: ti-eqep: Convert to counter_priv() wrapper
> > >   counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
> > >   counter: stm32-timer-cnt: Convert to counter_priv() wrapper
> > >   counter: Provide alternative counter registration functions
> > >   counter: Update documentation for new counter registration functions
> > >   counter: 104-quad-8: Convert to new counter registration
> > >   counter: interrupt-cnt: Convert to new counter registration
> > >   counter: intel-qep: Convert to new counter registration
> > >   counter: ftm-quaddec: Convert to new counter registration
> > >   counter: microchip-tcb-capture: Convert to new counter registration
> > >   counter: stm32-timer-cnt: Convert to new counter registration
> > >   counter: stm32-lptimer-cnt: Convert to new counter registration
> > >   counter: ti-eqep: Convert to new counter registration
> > >   counter: remove old and now unused registration API
> > >=20
> > >  Documentation/driver-api/generic-counter.rst |  10 +-
> > >  drivers/counter/104-quad-8.c                 |  93 +++++-----
> > >  drivers/counter/counter-core.c               | 186 ++++++++++++++---=
--
> > >  drivers/counter/ftm-quaddec.c                |  36 ++--
> > >  drivers/counter/intel-qep.c                  |  46 ++---
> > >  drivers/counter/interrupt-cnt.c              |  38 ++--
> > >  drivers/counter/microchip-tcb-capture.c      |  44 ++---
> > >  drivers/counter/stm32-lptimer-cnt.c          |  51 ++---
> > >  drivers/counter/stm32-timer-cnt.c            |  48 ++---
> > >  drivers/counter/ti-eqep.c                    |  31 ++--
> > >  include/linux/counter.h                      |  15 +-
> > >  11 files changed, 356 insertions(+), 242 deletions(-)
> > >=20
> > > Range-diff against v2:
> > > [...]
> > >=20
> > > base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
> > > prerequisite-patch-id: 9459ad8bc78190558df9123f8bebe28ca1c396ea =20
> >=20
> > All patches have a blessing by at least one of William and Jonathan.
>=20
> For future reference (may be fine this time) William has final say on cou=
nter
> stuff as the maintainer so treat my input as just another set of eyes.

Yeah, right. William only didn't ack patch 13 but wrote in reply it in v2:

	I agree with the approach taken in this patch, and I don't have much to
	add after the suggestions Lars-Peter and Jonathan have already given. So
	assuming those are addressed in the next version I expect to Ack this
	patch as well.

So I assume it's just that William didn't have the time yet to look into
v3 (or v4 that I just sent out) yet.

Best regards and thanks to all who gave feedback to improve this patch
set,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7547pgm5uqxs232y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHNy2gACgkQwfwUeK3K
7AkVxgf/YEpJYjM3bn0tJoCZm5z1+9HEyxBcCdYvZkrR/r1W76x+QjoTmtqoUkOw
W2dJAKUIPtSZrkPAqUudrsQPnWo7wIBGKtC1tW6E38jCe9o7A/SFFopedwIF9clI
X28pk3rY9kFj9l6WK4yef2abY7hGAyi3eYyorm8QJzkdQF3HuiR2BEFevGKcEGMr
HRvP6V5NZ06+pYkNI4arg0hqFAlJZb9h+LdrhcQjFxYW4HROL+pe4iy1xkEGKVQO
mwbVNjhEfNaLwKUm58fyNr77vebIPhNrTuiRDM/f+gKcu07zThgxiaS/CLH5Tqkw
OoVyfyqM6/6thSXjoor4nmGo/xH2Ew==
=Y3X/
-----END PGP SIGNATURE-----

--7547pgm5uqxs232y--
