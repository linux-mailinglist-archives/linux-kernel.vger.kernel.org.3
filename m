Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1B358BA44
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiHGIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHGIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:36:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6CB87F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:36:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbm7-0000oT-U0; Sun, 07 Aug 2022 10:36:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbm4-002G3G-Pm; Sun, 07 Aug 2022 10:36:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKbm6-00A6Dl-AK; Sun, 07 Aug 2022 10:36:42 +0200
Date:   Sun, 7 Aug 2022 10:36:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 2/3] pwm: core: Get rid of unused devm_of_pwm_get()
Message-ID: <20220807083642.562ay55v53xrzhtj@pengutronix.de>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220806152517.78159-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="shg7vom746dzt426"
Content-Disposition: inline
In-Reply-To: <20220806152517.78159-2-andriy.shevchenko@linux.intel.com>
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


--shg7vom746dzt426
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Aug 06, 2022 at 06:25:16PM +0300, Andy Shevchenko wrote:
> The devm_of_pwm_get() has recently lost its single user, drop
> the dead API as well.
>=20
> Note, the new code should use either plain pwm_get() or managed
> devm_pwm_get() or devm_fwnode_pwm_get() APIs.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

very nice!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--shg7vom746dzt426
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLveZcACgkQwfwUeK3K
7AmpzAf/V++qlu1jhwwLQcOM1xASpS4QKwfhFDPFgd5KMFetLOoBAXXfCwyT2ivR
SQabCrtOEiRdm5GGs6UOWsmE35ak9yP08+Ih5UGZ7Gq6717qlowfN1Z/7G5nOTCQ
nXkbNo52XSFGhznXdOs8SGPoXyF1uC5rEUB+zWzlbZ+VRdksNywQyA/uhXwF3WW7
RHi34p8XgnCoL1FSunRQhKxSGo17Cu//2aoVtk05KIFH0dAtuX6PyM6rtYBW6CN3
f1U9xDtQ8lI04GEJJFeFgxOQC0xzXCj8q0zeKH8wLymaNKsQGBoFRZsLKwLnLSj1
Tp81G+TQEzVcz9cQXX7TWwaQscynBQ==
=mYM1
-----END PGP SIGNATURE-----

--shg7vom746dzt426--
