Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC47476353
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhLOUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:31:20 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46296 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhLOUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:31:19 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 590531C0B98; Wed, 15 Dec 2021 21:31:18 +0100 (CET)
Date:   Wed, 15 Dec 2021 21:31:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: omap3-n900: Fix lp5523 for multi color
Message-ID: <20211215203113.GE28336@duo.ucw.cz>
References: <20211212224007.10293-1-merlijn@wizzup.org>
 <20211212224007.10293-2-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20211212224007.10293-2-merlijn@wizzup.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
>=20
> Since the LED multicolor framework support was added in commit
> 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
> LEDs on this platform stopped working.

Does this change names is /sys/class/leds?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbpQkQAKCRAw5/Bqldv6
8vpmAKCmg+y81WeSFmyrK2qvObpFyZI28gCeKQovv1MP1lI3LSdsWLab55DwqFE=
=mEH/
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
