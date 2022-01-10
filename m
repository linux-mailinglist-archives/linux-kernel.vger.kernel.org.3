Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF34893BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiAJIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbiAJIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:36:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A7C06118C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:36:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6qAH-0005bt-1h; Mon, 10 Jan 2022 09:36:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6qAF-009URQ-6A; Mon, 10 Jan 2022 09:36:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n6qAD-0003xw-Rb; Mon, 10 Jan 2022 09:36:25 +0100
Date:   Mon, 10 Jan 2022 09:36:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH] counter: 104-quad-8: Add COMPILE_TEST depends
Message-ID: <20220110083625.5ue7k54h3fcujak6@pengutronix.de>
References: <20220105094137.259111-1-vilhelm.gray@gmail.com>
 <20220109212251.xzwilquctuij5lev@pengutronix.de>
 <YdvF0teoR/ymJJ7e@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyrcota5ecpueb4e"
Content-Disposition: inline
In-Reply-To: <YdvF0teoR/ymJJ7e@shinobu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uyrcota5ecpueb4e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 10, 2022 at 02:36:54PM +0900, William Breathitt Gray wrote:
> On Sun, Jan 09, 2022 at 10:22:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 05, 2022 at 06:41:37PM +0900, William Breathitt Gray wrote:
> > > 104_QUAD_8 depends on X86, but compiles fine on ARCH=3Darm. This patch
> > > adds support for COMPILE_TEST which is useful for compile testing code
> > > changes to the driver and Counter subsystem.
> > >=20
> > > Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---
> > >  drivers/counter/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > > index 3dcdb681c4e4..5edd155f1911 100644
> > > --- a/drivers/counter/Kconfig
> > > +++ b/drivers/counter/Kconfig
> > > @@ -14,7 +14,7 @@ if COUNTER
> > > =20
> > >  config 104_QUAD_8
> > >  	tristate "ACCES 104-QUAD-8 driver"
> > > -	depends on PC104 && X86
> > > +	depends on (PC104 && X86) || COMPILE_TEST
> >=20
> > The driver uses inb and friends. Without looking I wonder if there is
> > something like HAVE_IO or similar this needs to depend on for that?
> >=20
> > Best regards
> > Uwe
> >=20
> > --=20
> > Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
>=20
> If I'm not mistaken, on unsupported architectures include/linux/io.h
> will pull in include/asm-generic/io.h which has default implementations
> for inb and friends if they are not otherwise defined. It doesn't look
> like these default implementations are guarded by a Kconfig setting so
> we should be fine in this case.

Looks right, thanks for checking

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uyrcota5ecpueb4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHb8AYACgkQwfwUeK3K
7AkU0gf/Tou5aDo6o6Ys29KstpcB9cNlDIlSafetB4vgWSlqsbcB/vscAlyIRZIW
fRyfB0stIfYA2uUwIlFv2TgF863ltYoGi9plEPvBeG8dSvZWhEh9p/9d5YSGsV2m
mkprDXAdfqKrCyTBlubobzoSpkPrleRHRcf1K17bBvSKj2zc7Jcq8Rq4pb4s39i6
oWTK9ZgoOycJNREIMgzX9SrETn/CWqVeUv+dSlI0byNEm97sLO8mAs9yFBIhQtRx
eJkmq4TvAuiqW7yXMoL/knuFfmi1G6tDqRLlyeFIEQEi/ygz3tKUStMenJ/tzPov
qp/+xQcmQGbpyuNrnu/jEfTbPUcxmA==
=3/m+
-----END PGP SIGNATURE-----

--uyrcota5ecpueb4e--
