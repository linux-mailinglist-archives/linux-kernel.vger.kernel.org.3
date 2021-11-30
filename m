Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29634462D39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhK3HCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhK3HCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:02:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9038C061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:59:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx6X-00082P-G4; Tue, 30 Nov 2021 07:59:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx6L-001sGA-Hp; Tue, 30 Nov 2021 07:58:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mrx6K-0002RV-MZ; Tue, 30 Nov 2021 07:58:52 +0100
Date:   Tue, 30 Nov 2021 07:58:52 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v14 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20211130065852.2o3zez5kdymu2meo@pengutronix.de>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
 <20211130055933.32708-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v25c5nweijfvjqpi"
Content-Disposition: inline
In-Reply-To: <20211130055933.32708-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v25c5nweijfvjqpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Tue, Nov 30, 2021 at 01:59:33PM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v25c5nweijfvjqpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGly6kACgkQwfwUeK3K
7AkBAQgAmFiWgiLI1T/jQZ62iVsXCI31JeT0xUXbuppZucPF2DaAoNtJKeDRkOpK
UCDVHW8+ASm0SND1eOdoRjAXJ7HC2mzBSKG2xMnPh2sl1tB44t6iiILDZVg92FYt
qbGoxZAPG1InfS3YyIQScz6IJ2NOXvWIRmkTVDNfdOehEPrlS18bR3G5IF/jkPt3
Icidmy5/nmOD3fA5GxBWYG7AGe6M0QBClkZlWv6FPMJ/U2IaGqe21B2UiIGqmtu2
cH2hjyY7jPEzY9PbzLPKAzqILSGJVfcfi+9UIHYITAu0RqSo6cvCueQtD0qmgBt5
6OFu2EEYpsIBlVlxpGNwcDd5UEUxCg==
=r4Sz
-----END PGP SIGNATURE-----

--v25c5nweijfvjqpi--
