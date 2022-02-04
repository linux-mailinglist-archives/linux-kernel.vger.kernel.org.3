Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93EF4A9758
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358109AbiBDKAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358112AbiBDKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:00:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD97C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:00:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFvOI-00046u-LK; Fri, 04 Feb 2022 11:00:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFvOH-00ESEP-B6; Fri, 04 Feb 2022 11:00:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFvOF-006bvj-IA; Fri, 04 Feb 2022 11:00:27 +0100
Date:   Fri, 4 Feb 2022 11:00:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: Set counter device name
Message-ID: <20220204100027.2gmvmkxyrheb5oqu@pengutronix.de>
References: <20220204084551.16397-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="heuvhq2g5hrqecuj"
Content-Disposition: inline
In-Reply-To: <20220204084551.16397-1-vilhelm.gray@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--heuvhq2g5hrqecuj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 05:45:51PM +0900, William Breathitt Gray wrote:
> Naming the counter device provides a convenient way to identify it in
> devres_log events and similar situations. This patch names the counter
> device by combining the prefix "counter" with the counter device's
> unique ID.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--heuvhq2g5hrqecuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH8+TcACgkQwfwUeK3K
7AneYAf+OX54ufM7pcEPoCY+/Dpy4FpwTabuoAwFMSffDg742+lPEuCtmE8G1X6F
am7RV4JbYKv4RuP9QtbXMLNBCU5GyiWeuN7kov5YaQGNxdKIfGVpXgeGiEwQ0W4c
Hc/2toqbG6JcD4pIaUAHnovg+O9laHCzNuBfckA+lHAQR0SuDuuBw//efb4Dkmvk
zIfTnWmLRm1EHuR8PS+ieCU9rt5JEnXsUYbwHqkn05CxwIxR8HI9XV0iSpTrH5M8
J/lNjl5m8mQl8oYnH9IitqWCjuwgcqavgRoRtJ5+DLjuo3VUqVAgQXH6hC+F7B4B
rHk5t+f3MUd/e29EbN7qRRNGEGwsnA==
=XWbg
-----END PGP SIGNATURE-----

--heuvhq2g5hrqecuj--
