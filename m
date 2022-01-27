Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039D49ED79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbiA0Vgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiA0Vgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:36:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB95C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:36:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nDCRC-0006Rf-Ku; Thu, 27 Jan 2022 22:36:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nDCRB-00CpYf-FH; Thu, 27 Jan 2022 22:36:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nDCRA-001olD-2d; Thu, 27 Jan 2022 22:36:12 +0100
Date:   Thu, 27 Jan 2022 22:36:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Noralf Tronnes <notro@tronnes.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 2/5] staging: fbtft: Deduplicate driver registration
 macros
Message-ID: <20220127213607.xbggvbm454u7qfid@pengutronix.de>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
 <20220123175201.34839-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67mr4ifnx6prswud"
Content-Disposition: inline
In-Reply-To: <20220123175201.34839-3-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67mr4ifnx6prswud
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Sun, Jan 23, 2022 at 06:51:58PM +0100, Uwe Kleine-K=F6nig wrote:
> The two macros FBTFT_REGISTER_DRIVER and FBTFT_REGISTER_SPI_DRIVER
> contain quite some duplication: Both define an spi driver and an of device
> table and the differences are quite subtle.
>=20
> So create two new macros and use both twice.
>=20
> Link: https://lore.kernel.org/r/20220118181338.207943-2-u.kleine-koenig@p=
engutronix.de
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

You picked this patch into your staging-next branch, I guess from the
original submission. Not sure how Mark wants to continue with the series
=66rom this thread, but at least my plan was that he will create an
immutable branch on top of 5.17-rc2 (assuming 5.17-rc2 will contain
"staging: fbtft: Fix error path in fbtft_driver_module_init()") with the
remaining 4 patches in this series.

In a private mail you agreed to this procedure, but this didn't stop you
taking this patch?! What is your plan here? The obvious (to me) options
are:

 - Delay this series until after the next merge window.
 - You back out this patch from staging-next and ack here for Mark to
   apply it to an immutable branch.
 - You keep this patch in staging-next and still ack here for Mark to
   apply it to an immutable branch. Then the patch would be included
   twice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--67mr4ifnx6prswud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHzEEQACgkQwfwUeK3K
7AkdBQf/QYxLjRjjSpz8FTj3K6vGIxGPAC7hZKjN9Sekvmf8ql2qAJ0veXMox5Hs
AVo6BooWW8n6qnIE6j05wMMcJz16iBdVNo5kOSFo1vt7rP0sXbp/i1UIiU1hBcTT
Mt/oYvsLpnwdh0OyI7h3ZfOdHo05HG8l/fjCBsHMozW1wuGvVIHnbN9zMyLEClyC
58/88JKuKUU0REoLty0vkSjzfwmbQoXTbrkXgGHUkUyzk5g4JekV2R+xIkhmVWp6
49EtKM6Xg8ykJKh51BNltCBDtrvNRuw/oKa5atlrCgKAfhynZv29X/oPNg4jXVPw
k3jTHuwnI9NtkZxvtNMmRylFxVvrtw==
=JziW
-----END PGP SIGNATURE-----

--67mr4ifnx6prswud--
