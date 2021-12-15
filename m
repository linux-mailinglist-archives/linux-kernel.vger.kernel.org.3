Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9678F47635B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhLOUdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:33:05 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46478 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:33:04 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 75A521C0B98; Wed, 15 Dec 2021 21:33:02 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:32:59 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        devicetree@vger.kernel.org, Doug Zobel <dougdev334@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 0/2] Fix RGB status LED and keyboard backlight LEDs on
 Nokia N900
Message-ID: <20211215203259.GF28336@duo.ucw.cz>
References: <20211212224007.10293-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline
In-Reply-To: <20211212224007.10293-1-merlijn@wizzup.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The RGB status LED and keyboard backlight LEDs were broken on the Nokia N=
900
> since the conversion to gpiod descriptors and additionally later on with =
the
> addition of multi color support. There was at least one attempt merged to=
 fix
> the lp5523 driver since the gpiod conversion, but it doesn't honour the d=
evice
> tree, which in the case of the Nokia N900 means that the fix doesn't work.
>=20
> In this series are two patches fix the problems:
>=20
> * One addresses the gpiod change in the device tree as well as the multi
>   color support in the device tree;
> * The other patch fixes the previous attempt at fixing the driver to hono=
ur
>   the device tree;
>=20
> Please let me know if anything seems off, and I'll be glad to make any
> recommended changes, thanks!

Thank you, I took the series. But if it changes the names in
/sys/class/leds, we want to do something else.

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpQ+wAKCRAw5/Bqldv6
8tAtAKCGwht0aPaKEMlZ4zXs/D60Icv3TQCfRL/bIMI2LAnvY0mTztHvcD5BO6M=
=jTvz
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
