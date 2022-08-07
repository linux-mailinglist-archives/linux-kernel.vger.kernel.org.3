Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6658BA54
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiHGI6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHGI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:57:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3CDE81
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:57:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc6X-0002RI-Dn; Sun, 07 Aug 2022 10:57:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc6U-002G5i-Dd; Sun, 07 Aug 2022 10:57:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc6V-00A6H9-U1; Sun, 07 Aug 2022 10:57:47 +0200
Date:   Sun, 7 Aug 2022 10:57:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/4] pwm: sysfs: Return directly from the for-loop in
 PM callbacks
Message-ID: <20220807085747.snndywtlriprryyd@pengutronix.de>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
 <20220806212331.40086-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i772q74vrymelstj"
Content-Disposition: inline
In-Reply-To: <20220806212331.40086-2-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i772q74vrymelstj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2022 at 12:23:29AM +0300, Andy Shevchenko wrote:
> There is no need to assign ret to 0 and then break the loop just
> for returning the error to the caller. Instead, return directly
> from the for-loop, and 0 otherwise.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i772q74vrymelstj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLvfokACgkQwfwUeK3K
7AlqMgf9EN/WZq0KnGtRBFkApNcLvoZfzmSoVOc+N75LeAaQjIYapq+4WprJleuR
Kz6SOG1S0W0b3tCmExzdfbMsGqPs3d3XMGm8X5lTS5vkFSek5X/mRfnXBBM11xoB
eV3/kbWPzZLY0BeL5I3e9ddYCcaBVl8KWdXqrNHoZCwRF5h//uvfZkQOI5wVn+/V
RD10rnZOQDdeDFekBHgvikA4TncAz13pJ0tpvwhUZ6Vj7JSYZBGpAB/y7QGTqq42
mOzrTqDuDIKJKxLFGXuaMWy2r4VgIKCSdcPUDwF8IPCWypeUuPupeCDqtT0aJjvO
5ks5LKeLp9uifCllcsHCU64UWdx3gw==
=C4IA
-----END PGP SIGNATURE-----

--i772q74vrymelstj--
