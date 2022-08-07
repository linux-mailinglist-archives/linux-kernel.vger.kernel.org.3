Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7516158BA49
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiHGIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:37:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9783B87F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:37:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbnB-0000pi-AZ; Sun, 07 Aug 2022 10:37:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbn8-002G3R-3x; Sun, 07 Aug 2022 10:37:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbn9-00A6Dy-Ea; Sun, 07 Aug 2022 10:37:47 +0200
Date:   Sun, 7 Aug 2022 10:37:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 3/3] pwm: core: Make of_pwm_get() static
Message-ID: <20220807083747.74wr36uauir7e6h7@pengutronix.de>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220806152517.78159-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zxnn2bqdjr4mmoy"
Content-Disposition: inline
In-Reply-To: <20220806152517.78159-3-andriy.shevchenko@linux.intel.com>
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


--2zxnn2bqdjr4mmoy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Aug 06, 2022 at 06:25:17PM +0300, Andy Shevchenko wrote:
> There are no users outside of PWM core of the of_pwm_get().
> Make it static.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2zxnn2bqdjr4mmoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLvedgACgkQwfwUeK3K
7Ammawf9GLQu/yRvgQOZg/H8aiE+2HbYexnMrSEw/U8hQJkWJ8/ZGE+rHWSesS54
B2iRSCiPkMAd8LyrH+2RUr8BQPwM7/cQ3LcSFSdSCRtBYSoUtGoHCQIUBqKTdOPH
il9XwQXGB4BhX3jDDalLcWPJB3+VT1k0T39ofgYQnxc255VUGECibIQ5s0X62WB3
FGBVI0NRgj3gRxDaDJul645A3plb/BokYlN7lp8OyYJ8GlsQm+7NA8BhFwCdhyQR
OksAEjjDI8A2TdUwDaUmjDPykL4tH383iIxYg+eb2APNvq57D0M8INJfZkt7/ddJ
r95O/1tHoeWQyxXKEVQ9iZhbnGnOWA==
=+4lJ
-----END PGP SIGNATURE-----

--2zxnn2bqdjr4mmoy--
