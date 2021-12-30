Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7ED481AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhL3Iy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL3IyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:54:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07531C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:54:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2rCN-0001Ho-RK; Thu, 30 Dec 2021 09:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2rCI-007SB9-Oz; Thu, 30 Dec 2021 09:54:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2rCH-00052f-Q5; Thu, 30 Dec 2021 09:54:05 +0100
Date:   Thu, 30 Dec 2021 09:53:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v3 00/23] counter: cleanups and device lifetime fixes
Message-ID: <20211230085351.pywngltvdam25emx@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7z7zb2yi7csslu7s"
Content-Disposition: inline
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7z7zb2yi7csslu7s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 29, 2021 at 04:44:18PM +0100, Uwe Kleine-K=F6nig wrote:
> this is v3 of my series to fix device lifetime issues in the counter
> framework. This hopefully addresses all things pointed out for v2.
>=20
> Note this depends on 60f07e74f86b (which is in next) now. Full diffstat
> below.
>=20
> Things that could be further improved:
>=20
> [...]
>=20
> Uwe Kleine-K=F6nig (23):
>   counter: Use container_of instead of drvdata to track counter_device
>   counter: ftm-quaddec: Drop unused platform_set_drvdata()
>   counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
>   counter: Provide a wrapper to access device private data
>   counter: 104-quad-8: Convert to counter_priv() wrapper
>   counter: interrupt-cnt: Convert to counter_priv() wrapper
>   counter: microchip-tcb-capture: Convert to counter_priv() wrapper
>   counter: intel-qep: Convert to counter_priv() wrapper
>   counter: ftm-quaddec: Convert to counter_priv() wrapper
>   counter: ti-eqep: Convert to counter_priv() wrapper
>   counter: stm32-lptimer-cnt: Convert to counter_priv() wrapper
>   counter: stm32-timer-cnt: Convert to counter_priv() wrapper
>   counter: Provide alternative counter registration functions
>   counter: Update documentation for new counter registration functions
>   counter: 104-quad-8: Convert to new counter registration
>   counter: interrupt-cnt: Convert to new counter registration
>   counter: intel-qep: Convert to new counter registration
>   counter: ftm-quaddec: Convert to new counter registration
>   counter: microchip-tcb-capture: Convert to new counter registration
>   counter: stm32-timer-cnt: Convert to new counter registration
>   counter: stm32-lptimer-cnt: Convert to new counter registration
>   counter: ti-eqep: Convert to new counter registration
>   counter: remove old and now unused registration API
>=20
>  Documentation/driver-api/generic-counter.rst |  10 +-
>  drivers/counter/104-quad-8.c                 |  93 +++++-----
>  drivers/counter/counter-core.c               | 186 ++++++++++++++-----
>  drivers/counter/ftm-quaddec.c                |  36 ++--
>  drivers/counter/intel-qep.c                  |  46 ++---
>  drivers/counter/interrupt-cnt.c              |  38 ++--
>  drivers/counter/microchip-tcb-capture.c      |  44 ++---
>  drivers/counter/stm32-lptimer-cnt.c          |  51 ++---
>  drivers/counter/stm32-timer-cnt.c            |  48 ++---
>  drivers/counter/ti-eqep.c                    |  31 ++--
>  include/linux/counter.h                      |  15 +-
>  11 files changed, 356 insertions(+), 242 deletions(-)
>=20
> Range-diff against v2:
> [...]
>=20
> base-commit: a7904a538933c525096ca2ccde1e60d0ee62c08e
> prerequisite-patch-id: 9459ad8bc78190558df9123f8bebe28ca1c396ea

All patches have a blessing by at least one of William and Jonathan.
The prerequisite commit (60f07e74f86b) is in Greg's char-misc-next branch.

Assuming noone still finds a problem in this series that requires me to
respin I wonder who will pick it up? Greg?

Given that it fixes a possible use-after-free in all counter drivers,
I'd like to see it hit before v5.17-rc1. For 5.16 it's probably too
late.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7z7zb2yi7csslu7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHNc5sACgkQwfwUeK3K
7AmHGwf/cW+uf1nbbMoCP+vuGJBcf8R3c4fj5eEs6StdeeqHl+4a9zmWUm2lRpK/
nP641JA+KRobAEsp6GzoUMT+XZiVK+Vkq5oUl6SzYDi9E7ngcCIHcFX0KGeleAJO
NbucXfodd1UyRSnJxuHAJtgV+SqqWzitl0Bcnk6aEEAvfmxsagEzAWTaEZbtlBpS
qyoUpE7RdVKCS6D7YSTEgvDXizq1LCIouqvlVOQJeSYgtVlMAZhNI5sED9Powoer
qogiBqD/ct96Khptz+zvZgyivhlKY2bOZQj2J7Or+FR7qvTx/unx2IA1j9US6Khx
tsgbEo6PmHqbM2kCu/bkI06NRS7lcw==
=asmE
-----END PGP SIGNATURE-----

--7z7zb2yi7csslu7s--
