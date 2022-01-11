Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3010B48B8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiAKUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:34:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24439C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:34:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7NqG-0005KV-Gq; Tue, 11 Jan 2022 21:34:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7Nq9-009liu-K5; Tue, 11 Jan 2022 21:33:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n7Nq8-0000bZ-M8; Tue, 11 Jan 2022 21:33:56 +0100
Date:   Tue, 11 Jan 2022 21:33:56 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] counter: fix an IS_ERR() vs NULL bug
Message-ID: <20220111203356.cnzpo4uyhnybm5cp@pengutronix.de>
References: <20220111173243.GA2192@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxuycue2yzjofszy"
Content-Disposition: inline
In-Reply-To: <20220111173243.GA2192@kili>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxuycue2yzjofszy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2022 at 08:32:43PM +0300, Dan Carpenter wrote:
> There are 8 callers for devm_counter_alloc() and they all check for NULL
> instead of error pointers.  I think NULL is the better thing to return
> for allocation functions so update counter_alloc() and devm_counter_alloc=
()
> to return NULL instead of error pointers.
>=20
> Fixes: c18e2760308e ("counter: Provide alternative counter registration f=
unctions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kxuycue2yzjofszy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHd6a8ACgkQwfwUeK3K
7Al9Iwf/WB14l+fGxcxwVADyOlw6ROsynRA+lFE0XfZnX2xqSR6j49wb9axN9LEv
NC55VyFV3gYSX3Hqmeeqt+FzwxY4kuvydtB2olZwr8Tx88OKSKN6I+dByp8zSLql
M42Hw5N+vJCX0eae379VFBzFGO9e5sZHjeUQngy1anRztQYNO2woQhKO+1WintrR
gLgJwnYCcw5W6xQ+e1jAz92rGadfczIwGoANrU/BDqGtBiIixX8LEwc3Q18wdOEs
PQ27vixCeuesXui0wdyRjk5OR8ghMFijTpVXI8OtERU36j7wsy7ou3oFf16AK1kL
CpU/FxpraV8XwIivYLZD6oyS/5sYnA==
=7eoW
-----END PGP SIGNATURE-----

--kxuycue2yzjofszy--
