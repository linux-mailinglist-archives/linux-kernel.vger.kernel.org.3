Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80D046B4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhLGIEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhLGIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:04:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C25C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:00:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muVOQ-0007PQ-FL; Tue, 07 Dec 2021 09:00:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muVOM-003B7k-DF; Tue, 07 Dec 2021 09:00:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muVOL-00046X-3Z; Tue, 07 Dec 2021 09:00:01 +0100
Date:   Tue, 7 Dec 2021 08:59:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 03/14] dt-bindings: pwm: Convert BCM7038 PWM binding
 to YAML
Message-ID: <20211207075958.fsw6hcvpocnwokot@pengutronix.de>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
 <20211206182616.2089677-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icyezc67xbpvw2hr"
Content-Disposition: inline
In-Reply-To: <20211206182616.2089677-4-f.fainelli@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icyezc67xbpvw2hr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 06, 2021 at 10:26:05AM -0800, Florian Fainelli wrote:
> Convert the Broadcom STB BCM7038 PWM Device Tree binding to YAML to help
> with validation.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume you intend to take these patches all together via the bcm tree?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--icyezc67xbpvw2hr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGvFHsACgkQwfwUeK3K
7Am9zgf9F6D7Bcmxx5leYwqjEfbY0JtJ3JTkZmn3TENEY7kofnBMDZ9DvgsvnamU
9GlECGVZSlUN/w6jWu1AEVpchAWRj7R+rzlwLuACXqZuhAAQIanbu/OUm3hjyODa
EsYa/UNfNYPRtb02YYMeMqSbWWHW7QLNahOTlCs0vPYZqY89qGOK3S4fLtPpxMMT
CXYHUvAxBFFAXV1Vc63YYok++9FYu66Xwx2JAC71ETrejR/OfTQm9ZwHuzu5Fz73
kSCtdWm96QyJFhkgrkHlon+KkZcFAmR3LG2E3Pe/AQeNZ2h4ZvQ6DAKHwgdOjfQD
VY3xAxykgM6YmDnYURchttBrwq9bWw==
=R7jM
-----END PGP SIGNATURE-----

--icyezc67xbpvw2hr--
