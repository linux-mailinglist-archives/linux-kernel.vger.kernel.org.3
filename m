Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB24490859
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiAQMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiAQMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:10:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0719C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:10:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9Qpp-0004m0-PZ; Mon, 17 Jan 2022 13:10:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9Qpl-00Aows-QM; Mon, 17 Jan 2022 13:10:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9Qpk-0003SF-I8; Mon, 17 Jan 2022 13:10:00 +0100
Date:   Mon, 17 Jan 2022 13:10:00 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/2] Clock based PWM output driver
Message-ID: <20220117121000.3lgohyenamvwmcur@pengutronix.de>
References: <20211213150335.51888-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nml76c7ahgtmakjm"
Content-Disposition: inline
In-Reply-To: <20211213150335.51888-1-nikita@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nml76c7ahgtmakjm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nikita,

On Mon, Dec 13, 2021 at 08:03:33PM +0500, Nikita Travkin wrote:
> This series introduces an "adapter" driver that allows PWM consumers
> to control clock outputs with duty-cycle control.
>=20
> Some platforms (e.g. some Qualcomm chipsets) have "General Purpose"
> clocks that can be muxed to GPIO outputs and used as PWM outputs.=20
> Those outputs may be connected to various peripherals such as
> leds in display backlight or haptic feedback motor driver.=20
>=20
> To avoid re-implementing every single PWM consumer driver with clk
> support (like in [1]) and don't put the burden of providing the PWM
> sources on the clock drivers (as was proposed in [2]), clk based
> pwm controller driver is introduced.
>=20
> There is an existing driver that provides the opposite function
> in drivers/clk/clk-pwm.c with a compatible "pwm-clock" so the new
> driver uses the opposite naming scheme: drivers/pwm/pwm-clk.c
> and compatible "clk-pwm".=20

You got some feedback on your patches and didn't respond to it. Are you
interested to improve your patch set? If yes, I'm willing to review more
deeply. If not, I'm not.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nml76c7ahgtmakjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHlXJQACgkQwfwUeK3K
7AnEsgf8Cc1DhNXiXv10Wa7eqbQ8ME0UHnhc1KnoclzQOcZQ1PUR6xc1nN/Y6XZi
py30PY413YgPc9fHbTkdtrDNY9/5uInwqsmzReYk00kLRVcwPq+1w1o18cZp0Yyi
1omzLZgMpvUn+mG9NaTnhTP6FwWTufoQ+QHNYm6wcMLrPyFRRq5wOX/hwI2OhTaw
An3Q2HZ8nD/o02Gjs+GhjSPfJTyd/uUHr/sxTktPOzoMqc0mSyjyiTjMgLkmpZlr
/g4I6rhIMzrp8b/oDsH1MOBLlAKaFCskmZnY+RM5NZNoUT/8XN/8DFcgQyUM0Rk/
C83vgqK+etdf2rhhFtfwmpi/23MfjA==
=vPuV
-----END PGP SIGNATURE-----

--nml76c7ahgtmakjm--
