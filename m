Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25B46B3D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhLGH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhLGH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:27:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A3C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:23:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUoy-0002tU-KX; Tue, 07 Dec 2021 08:23:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUow-003B4K-Aa; Tue, 07 Dec 2021 08:23:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUov-0002Ab-Ah; Tue, 07 Dec 2021 08:23:25 +0100
Date:   Tue, 7 Dec 2021 08:23:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>
Cc:     ulf.hansson@linaro.org, srinivas.pandruvada@linux.intel.com,
        pali@kernel.org, TheSven73@gmail.com, lznuaa@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] drivers/mmc/core/bus: Delete redundant match function
Message-ID: <20211207072322.37dljknm24nk5vk4@pengutronix.de>
References: <20211206165038.123107-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ysum2g76sywc3bhf"
Content-Disposition: inline
In-Reply-To: <20211206165038.123107-1-sensor1010@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ysum2g76sywc3bhf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 06, 2021 at 08:50:38AM -0800, lizhe wrote:
> 	When the device and device driver are matching,
> 	if the device or the bus to which the device driver belongs
> 	does not provide a match function,
> 	then the device and device driver arae matched by default.

s/arae/are/, but maybe the overall wording could be improved. Something
like:

	drivers/mmc/core/bus: Remove redundant driver match function

	If there is no driver match function, the driver core assumes
	that each candidate pair (driver, device) matches. See function
	driver_match_device().

	Drop the mmc bus's match function that always returned 1 and
	so implements the same behaviour as when there is no match
	function.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ysum2g76sywc3bhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGvC+cACgkQwfwUeK3K
7AncNggAhFfG/OPMU7Ubjd4aVJOPRjEgjSGBTTl90a2W0W/FtcvxU0CkA27A0Qjj
fkQfnrZ+1uvZtqi1sEUK8VPZ99GZPAbGNEkByyKiD33X1Pm9fypuDqURZzKPn5hz
8x1hoqCXz3IrW6lfdXgaCQBTJ3qjUPDD3ZSbORXsI+6cjYGtrSwtjmnRHEbUyCsM
7JuAfFKUuJd57nXBJaSizesFB3q+A3IcfTRFYehymcdHRjiFPqCN9SEoKudFHISs
yKN4reE9kDSs17fqay88rb29tP/dnCT2F5FcZyG+DMvUz4cf7EoQZPQbEwsTzabQ
VGm+h4sBSiWDp0Paf4xrmkEZlLO66Q==
=BwLS
-----END PGP SIGNATURE-----

--ysum2g76sywc3bhf--
