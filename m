Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5A47D61C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbhLVRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbhLVRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:52:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:52:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n05mK-00038x-DV; Wed, 22 Dec 2021 18:51:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n05mG-0062lA-7p; Wed, 22 Dec 2021 18:51:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n05mF-0002sK-4h; Wed, 22 Dec 2021 18:51:47 +0100
Date:   Wed, 22 Dec 2021 18:51:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
Message-ID: <20211222175139.6smiezanuduod6fm@pengutronix.de>
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
 <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
 <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
 <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="asrj6mdmugq3ovqq"
Content-Disposition: inline
In-Reply-To: <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asrj6mdmugq3ovqq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 21, 2021 at 01:04:50PM +0100, Lars-Peter Clausen wrote:
> On 12/21/21 12:35 PM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Dec 21, 2021 at 12:12:12PM +0100, Lars-Peter Clausen wrote:
> > > On 12/21/21 11:45 AM, Uwe Kleine-K=F6nig wrote:
> > > > similar to patch
> > > > https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.=
1640072891.git.vilhelm.gray@gmail.com
> > > > the usage of struct counter_device::priv can be replaced by
> > > > container_of which improves type safety and code size.
> > > >=20
> > > > This series depends on above patch, converts the remaining drivers =
and
> > > > finally drops struct counter_device::priv.
> > > Not sure if this is such a good idea. struct counter_device should no=
t be
> > > embedded in the drivers state struct in the first place.
> > Just to mention it: My patch series didn't change this, this was already
> > broken before.
> I know, but this series has to be reverted when the framework is fixed.
> >=20
> > > struct counter_device contains a struct device, which is a reference =
counted
> > > object. But by embedding it in the driver state struct the life time =
of both
> > > the struct counter_device and and struct device are bound to the life=
 time
> > > of the driver state struct.
> > >=20
> > > Which means the struct device memory can get freed before the last re=
ference
> > > is dropped, which leads to a use-after-free and undefined behavior.
> > Well, the driver struct is allocated using devm_kzalloc for all drivers.
>=20
> devm_kzalloc() doesn't make a difference. The managed memory is freed when
> the parent device is unbound/removed. There may very well be reference to
> the counter_device at this point.
>=20
> > So I think it's not *very* urgent to fix. Still you're right, this
> > should be addressed.
>=20
> Yes and no, this can trivially be used for privilege escalation, but then
> again on systems with a counter_device probably everything runs as root
> anyway.

I could provoke an oops with the following shell command:


	{ sleep 5; echo bang; } > /dev/counter0 & sleep 1; echo 40000000.timer:cou=
nter > /sys/bus/platform/drivers/stm32-timer-counter/unbind

I have a protype here to split counter_register() into counter_alloc() +
counter_add(), but I didn't convert a driver to it yet. If you want to
take a look, it's currently available from

	https://git.pengutronix.de/git/ukl/linux counter-dev-livetime

(or if you prefer a webif:

	https://git.pengutronix.de/cgit/ukl/linux/log/?h=3Dcounter-dev-livetime

). I planned to just invest a two or so hours to fix this. But the plan
failed (one reason is that v5.16-rc6 failed to boot on the stm32mp1 I
work on and I bisected that first.)

Maybe I find some time between the years to get this forward a bit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--asrj6mdmugq3ovqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHDZagACgkQwfwUeK3K
7AkNqQf/fIe5zz5fAatnqj+QS3OUWmufUxx3MXg1a8ghQ2E3sdiTgIbgICfg94Cq
6OqkCvh4W9HBpMUQbVHPtpaxHBRA6UQqOxfcKYcOvaq4HAY+8roCYKMKbBqMEnIY
CY/7CB2s9xCv3cedWaVwtnpM3pVO862mMvGwv7HEZgVcj6wXDFSYXMCZUcZ2yPXc
UTs25lC4sJ9Y1txUFHHiE767NJ9O8itmTwsZ5tj7zY/SaVKwVKSwl1SCEyK6pCmW
DmxCK83zAZnlBfnEe7hA97x+dd3vtWbmMTAVuaU17gp2I7O6s5jQcCLvWQBPn7XD
4Cl3Ox6CVJcgiHvVgLaL9aXQCqQ7TQ==
=8UkX
-----END PGP SIGNATURE-----

--asrj6mdmugq3ovqq--
