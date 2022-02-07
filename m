Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999E4AB62F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiBGIGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbiBGIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:01:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E9C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:01:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGyxw-0003Oz-Pw; Mon, 07 Feb 2022 09:01:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGyxo-00F3Bq-Ev; Mon, 07 Feb 2022 09:01:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGyxn-00AMWQ-2y; Mon, 07 Feb 2022 09:01:31 +0100
Date:   Mon, 7 Feb 2022 09:01:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid open coded arithmetic in memory
 allocation
Message-ID: <20220207080128.xmvommcddjfgz7ey@pengutronix.de>
References: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uk5prupw6c7p3eyw"
Content-Disposition: inline
In-Reply-To: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uk5prupw6c7p3eyw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 08:40:48AM +0100, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
>=20
> So turn a kzalloc()+explicit size computation into an equivalent kcalloc(=
).
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

LGTM

Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uk5prupw6c7p3eyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIA0dUACgkQwfwUeK3K
7Akisgf+KATEEZW9EvLtoWYOICsrIUedN6ABItVv/WiMhk+x+Eba9XEgyus6wzIc
/pEpQB/9sngfUC7oZDdM7xZVmAn2c7CZOoQzYQKAdusOeXUSLwD+5PMS1WYfjIoK
WGwZB6/Ghy/7TtpsljHKHei7DdwMsTz4l5N3e0pdjqpk106LPmcNXAL9QwmQzWKU
IHkz9zPH+2KS0XtB4/kgHfCL8hz+gBMyCnC8spbzs1gGdXsqaldoAQmCFOPDxVTf
V+3qfJITYq3tbUDjQpSHVMjJlhrg2CBbicAa0IYZHOGtsoQn+nGkmF5pA7TRX0m4
aEiCFiUcqsd4F3sKg+tZMD8bJMMbSA==
=iwgW
-----END PGP SIGNATURE-----

--uk5prupw6c7p3eyw--
