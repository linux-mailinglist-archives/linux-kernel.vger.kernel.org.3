Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E75804F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGYUE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiGYUEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:04:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608020F5B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:04:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG4Ji-0007t2-9D; Mon, 25 Jul 2022 22:04:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG4Jg-003B0f-S5; Mon, 25 Jul 2022 22:04:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oG4Jg-007Uhh-4S; Mon, 25 Jul 2022 22:04:36 +0200
Date:   Mon, 25 Jul 2022 22:04:17 +0200
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
Message-ID: <20220725200417.nwthxzvdv2bzd5ej@pengutronix.de>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
 <20220716144028.rzwcn4wl5uyxepjd@pengutronix.de>
 <20220716145019.nps3oh4a22fsuzup@pali>
 <20220716150751.6yaknmo3qwusyy5h@pengutronix.de>
 <20220716160916.jp37siznitgzw6qf@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5kkir5uuei4mgh7"
Content-Disposition: inline
In-Reply-To: <20220716160916.jp37siznitgzw6qf@pali>
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


--n5kkir5uuei4mgh7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pali,

On Sat, Jul 16, 2022 at 06:09:16PM +0200, Pali Roh=E1r wrote:
> On Saturday 16 July 2022 17:07:51 Uwe Kleine-K=F6nig wrote:
> > On Sat, Jul 16, 2022 at 04:50:19PM +0200, Pali Roh=E1r wrote:
> > > On Saturday 16 July 2022 16:40:28 Uwe Kleine-K=F6nig wrote:
> > > > On Thu, Jul 14, 2022 at 08:33:27PM +0200, Pali Roh=E1r wrote:
> > > > > Armada 38x supports per CPU interrupts for gpios, like Armada XP.=
 Pre-XP
> > > > > variants like Armada 370 do not support per CPU interrupts for gp=
ios.
> > > > >=20
> > > > > So change compatible string for Armada 38x from "marvell,armada-3=
70-gpio"
> > > > > which indicates pre-XP variant to "marvell,armadaxp-gpio" which i=
ndicates
> > > > > XP variant or new.
> > > > >=20
> > > > > Driver gpio-mvebu.c which handles both pre-XP and XP variants alr=
eady
> > > > > provides support for per CPU interrupts on XP and newer variants.
> > > > >=20
> > > > > Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> > > > > Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for arm=
ada-38x")
> > > > > ---
> > > > >  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dt=
s/armada-38x.dtsi
> > > > > index df3c8d1d8f64..9343de6947b3 100644
> > > > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > > > @@ -292,7 +292,7 @@
> > > > >  			};
> > > > > =20
> > > > >  			gpio0: gpio@18100 {
> > > > > -				compatible =3D "marvell,armada-370-gpio",
> > > > > +				compatible =3D "marvell,armadaxp-gpio",
> > > > >  					     "marvell,orion-gpio";
> > > >=20
> > > > If you can treat the XP variant as 370 and everything that is suppo=
sed
> > > > to work on 370 works then, then maybe the right incarnation is:
> > > >=20
> > > > 	compatible =3D "marvell,armadaxp-gpio", "marvell,armada-370-gpio",=
 "marvell,orion-gpio";
> > > >=20
> > > > ?
> > >=20
> > > For pre-XP variants is "marvell,orion-gpio" enough and for XP + post-=
XP
> > > is needed "marvell,armadaxp-gpio" (with possible "marvell,orion-gpio"
> > > for backward compatibility).
> > >=20
> > > So I do not see reason why to add "marvell,armada-370-gpio" nor what
> > > value it brings.
> >=20
> > If you boot an older kernel (i.e. one that doesn't support
> > marvell,armadaxp-gpio, but does support marvell,armada-370-gpio), it
>=20
> Is there such kernel version?

Ah, I thought you added "marvell,armadaxp-gpio" with this patch series.

> > will work better as there are relevant differences between
> > marvell,orion-gpio and marvell,armada-370-gpio.
>=20
> And if yes, do we really need this in DTS files for new kernel
> versions? I can imagine that such change can be relevant for old LTS
> kernel version, but not for new versions.
>=20
> > For example some
> > registers seem to have a different offset ...
>=20
> armada-370-gpio is mapped to MVEBU_GPIO_SOC_VARIANT_ORION, so it will
> get same offsets as orion-gpio. So no change.

OK, you're right, my assumptions were wrong. I'm convinced your change
is fine now:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n5kkir5uuei4mgh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLe9zUACgkQwfwUeK3K
7Ak/lAf9GbJU03sNT87u8d1+k2z6T3ReV3ntV5ZIhu/vzMB63UPufXkQpYfNC64R
HiMeAfrVBmle3OOiz5SglqkdslWGVjAysLTo4AxaVpvJ323RKQdwzhIqKeXACsC2
cQkbNq3mlbGJ70VZKdw06u0VHmGncSs3vd25mXIN57uvtOxRRqDaOZjuDI17SA0f
87yboq8YS1PRVwK3NoW1uixpkda5qnyQbNvCt89BXrCf8YAi16JBDzFgNFKN1IrQ
fH3ZWuGZL7tA1NkzDcVhATwIsUZtgqTlnVa+ShTFQeskq7OPDdzKSW1HkPm1erC4
2alQnhUNBjI/4nC4OsOIUL+uHRv2Dw==
=rPdh
-----END PGP SIGNATURE-----

--n5kkir5uuei4mgh7--
