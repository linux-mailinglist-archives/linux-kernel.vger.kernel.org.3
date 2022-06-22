Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB155524E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359592AbiFVRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376400AbiFVRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:25:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92286D99
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:25:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o4461-0007le-M0; Wed, 22 Jun 2022 19:24:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o445z-0025Df-Eo; Wed, 22 Jun 2022 19:24:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o445z-000T6k-WB; Wed, 22 Jun 2022 19:24:52 +0200
Date:   Wed, 22 Jun 2022 19:24:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 1/1] clk: Remove never used devm_clk_*unregister()
Message-ID: <20220622172450.shnzbpc2kzkotvdr@pengutronix.de>
References: <20220622171147.85603-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lhr4n5l5cm4qdljv"
Content-Disposition: inline
In-Reply-To: <20220622171147.85603-1-andriy.shevchenko@linux.intel.com>
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


--lhr4n5l5cm4qdljv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 22, 2022 at 08:11:47PM +0300, Andy Shevchenko wrote:
> For the entire history of the devm_clk_*unregister() existence they were
> used only once (*) in 2015. Remove them.
>=20
> *) The commit 264e3b75de4e ("clk: s2mps11: Simplify s2mps11_clk_probe unw=
ind
>    paths") exactly supports the point of the change proposed here.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lhr4n5l5cm4qdljv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKzUF8ACgkQwfwUeK3K
7Ak4mwf/RLhrerB2GQtJ70zxW2ozAVAw5dj8qik2mRtB7clqbJoY24tQXed59Uqt
oHNKNjzRDgcD9DUiqMEUbocNbyH5dSXpuf/kBZlL8uhd3m94AlyA7cAyFr5ABlDR
tp85Eqp5kZXiuCJL+9DWD/dhrRuwTcP86WJyeiGeQ/l9UUbzVm6qAjHArcmuvcSU
4bFVptgkOJln9HQY7Gimb/MeWLeiIaIgELL5gpfK9qw62qh6HPP65+2oTBEfYaxe
xxPNAosltTFyFHjssPyzPV9W/ORZeX9IZVdq1dsONyVDzs/xxk/BmSv7xnqU6fz7
ROT1vKx0PkUw15QV1WPwhujTMhTQQg==
=TPtj
-----END PGP SIGNATURE-----

--lhr4n5l5cm4qdljv--
