Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0729E576F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGPOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:40:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E6175B2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:40:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCiy9-0001mp-Lg; Sat, 16 Jul 2022 16:40:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCiy7-001Kfv-TI; Sat, 16 Jul 2022 16:40:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCiy6-005ZA4-Rm; Sat, 16 Jul 2022 16:40:30 +0200
Date:   Sat, 16 Jul 2022 16:40:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Message-ID: <20220716144028.rzwcn4wl5uyxepjd@pengutronix.de>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zalewdgjudxxklrt"
Content-Disposition: inline
In-Reply-To: <20220714183328.4137-3-pali@kernel.org>
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


--zalewdgjudxxklrt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 08:33:27PM +0200, Pali Roh=E1r wrote:
> Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> variants like Armada 370 do not support per CPU interrupts for gpios.
>=20
> So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> XP variant or new.
>=20
> Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> provides support for per CPU interrupts on XP and newer variants.
>=20
> Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada=
-38x.dtsi
> index df3c8d1d8f64..9343de6947b3 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -292,7 +292,7 @@
>  			};
> =20
>  			gpio0: gpio@18100 {
> -				compatible =3D "marvell,armada-370-gpio",
> +				compatible =3D "marvell,armadaxp-gpio",
>  					     "marvell,orion-gpio";

If you can treat the XP variant as 370 and everything that is supposed
to work on 370 works then, then maybe the right incarnation is:

	compatible =3D "marvell,armadaxp-gpio", "marvell,armada-370-gpio", "marvel=
l,orion-gpio";

?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zalewdgjudxxklrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLSzdkACgkQwfwUeK3K
7Akz2wf+JF6UmqztBz7omhK1mGfW33SmnWY7c88XTanbchqiMR/xEQSaimY4mLAo
zad+Y0rz8FY7GhVlnp76zFnGkXKKBDy6PR/RUw4BA0PJPYi1UkYPXINES3PW5Hzj
P1/i9jC6IGdcWTkwIl+wLWTXcLm4XaJuJEq63zDtPDEifeYIKpF7dcmh7py2Jd3l
7V71pUvjMLBBGLHpHCMtn3EOfAjpHczxS6krmkadFLbG9YjDKH2t4Fdzn5n1HOUc
ofA4Ei4OVgRiQ+pN0YdxEFxeJeW1ipk1DiFHZwhOUQWQV+LuWKHksHGme+w9xX6y
C1ZEwTuTRFizN2nkb+imT79hdtgg2g==
=XF96
-----END PGP SIGNATURE-----

--zalewdgjudxxklrt--
