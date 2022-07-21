Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC557D510
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiGUUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiGUUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:49:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF78FD53
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:49:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd6K-00081W-OX; Thu, 21 Jul 2022 22:48:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd6H-002Nn0-9R; Thu, 21 Jul 2022 22:48:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd6G-006euJ-7j; Thu, 21 Jul 2022 22:48:48 +0200
Date:   Thu, 21 Jul 2022 22:48:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: Re: [PATCH v2 1/3] ads7846: don't report pressure for ads7845
Message-ID: <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
 <20220721083458.6412-2-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5lsgzu4zpvcl76q"
Content-Disposition: inline
In-Reply-To: <20220721083458.6412-2-luca.ellero@brickedbrain.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5lsgzu4zpvcl76q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 10:34:56AM +0200, Luca Ellero wrote:
> From: Luca Ellero <l.ellero@asem.it>
>=20
> ADS7845 doesn't support pressure.
> This patch avoids the following error reported by libinput-list-devices:
> "ADS7845 Touchscreen: kernel bug: device has min =3D=3D max on ABS_PRESSU=
RE".
>=20
> Signed-off-by: Luca Ellero <l.ellero@asem.it>

I don't know how picky Dmitry is, but some maintainers would ask you to
either add a Signed-off-by with the email address you sent this patch
=66rom, or make sure to send it from the asem.it address.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w5lsgzu4zpvcl76q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLZu6AACgkQwfwUeK3K
7Aka9Qf/XMlQ2ClmcylbAAWGWytbtIGqwu4CwJcTG7Pxn4pfXGu8ADg+Vy6uQF6z
2Ut/9XBYLjDl3jPKsSu9jIi30somF5903y82En7SplEisCRSdNUcGS6RZrMJ76yK
W/y9Tee7KPyE7HMI4WsrfhOUSSYed8AO0OhS2BIIYHUcF8285ZS3IaFhzGdasAIl
GQ8Bv7nQjPefBgMKN/tuF6C3iArEhDXm4VyicpEhtqtf3KK5238nNUtdkngJ3y9M
HIrc5gQlogZ2vjppWa5z5DH/y4OqaTtnZOAE0V7jEVE2m7MZdS1cXzcai9dymUKJ
nBu6vY5CfZZIPzpYds/02eqin2KnkQ==
=xW2N
-----END PGP SIGNATURE-----

--w5lsgzu4zpvcl76q--
