Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224BD553D82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355866AbiFUVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355243AbiFUVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB2E3E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:11:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3l9n-0006sP-Cg; Tue, 21 Jun 2022 23:11:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3l9i-001uGJ-Gp; Tue, 21 Jun 2022 23:11:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3l9j-000HjR-2B; Tue, 21 Jun 2022 23:11:27 +0200
Date:   Tue, 21 Jun 2022 23:11:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     jic23@kernel.org, lars@metafoo.de, ardeleanalex@gmail.com,
        antoniu.miclaus@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer:hmc5843: Remove duplicate 'the' in two
 places.
Message-ID: <20220621211126.q4crb44djniriqo7@pengutronix.de>
References: <20220621164056.30622-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqnioevnciy4jswy"
Content-Disposition: inline
In-Reply-To: <20220621164056.30622-1-jiangjian@cdjrlc.com>
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


--mqnioevnciy4jswy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 12:40:56AM +0800, Jiang Jian wrote:
> file: drivers/iio/magnetometer/hmc5843_core.c
> line: 3
>   * Device driver for the the HMC5843 multi-chip module designed
> changed to
>   * Device driver for the HMC5843 multi-chip module designed
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

The patch looks good, the commit log however is bad and wrong. There
are no "two places". I'd just write:

	iio:magnetometer:hmc5843: Remove duplicate 'the'

	Fix an obvious typing error, found by spellcheck(1).

	Signed-off-....

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mqnioevnciy4jswy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKyM/wACgkQwfwUeK3K
7AmqQAf+P9c0xZNp/qMaqIIJ8uiAthWDmpGhPJdXnMIaaFFJo9/9trJdEuQG99bK
bsMKGu04PvZ/QcD2nSwLcpY3Hmza7p4SMUOlfi3Ax9ijxqLwdy5St3/dHL60SwDb
S90cUncB6QvuuTKEzSEuIZ0eqC3Nc5ACWMIIA7UMs3P8IqAjzq4bOygunv2ERCrQ
akpJ7deOAr8PdC4a0tvDwz0DFnezsEF3GRl1egna36mbrPvFD5FynwYqKEWwcq06
LiD5rxTgxHpb/6vWubsiqui0TBem1oTPaqg/Iudqo+SB1rVEeYoYi8bh4li7zra2
gB0ZLvxn1A0dp94cPvHVwtbd0pP6qg==
=z/If
-----END PGP SIGNATURE-----

--mqnioevnciy4jswy--
