Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7104AF53E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiBIPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiBIPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:30:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02140C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:30:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHov5-0003JE-JH; Wed, 09 Feb 2022 16:30:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHov5-00FX3x-4S; Wed, 09 Feb 2022 16:30:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHov3-00DMcu-Px; Wed, 09 Feb 2022 16:30:09 +0100
Date:   Wed, 9 Feb 2022 16:30:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Harald Seiler <hws@denx.de>, Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Message-ID: <20220209153008.6qmt2t33ru7lhi6x@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
 <20220119151145.zft47rzebnabiej2@pengutronix.de>
 <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
 <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
 <5cab27cab5a39ef5e19992bc54e57c3f6106dafe.camel@denx.de>
 <YgJADKxWfOZroS35@kroah.com>
 <20220208111203.qi6fpo2l6um6znkz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhegztmaioghtjqo"
Content-Disposition: inline
In-Reply-To: <20220208111203.qi6fpo2l6um6znkz@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhegztmaioghtjqo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Tue, Feb 08, 2022 at 12:12:03PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Feb 08, 2022 at 11:03:56AM +0100, Greg Kroah-Hartman wrote:
> > Uwe, any thoughts about if this patch should be taken or not?
>=20
> I will take a deeper look later today and tell you my thoughts.

It took a bit longer, but after looking again with the driver open in my
editor I agree that patch is fine.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zhegztmaioghtjqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmID3f0ACgkQwfwUeK3K
7AnwFAf/ak9YeP1DkOhL48uqmiyD6N1JIZCpjcPhBVlJEoUgkxH/Qb5ThAb13R4r
tng7DlvdRKS6WHWiaILv6BmEw1rgOh4oyNaYdAI/8L9n8gC/YGDA03S6WI5MYQBj
Q5kKUH34OGSvZGLPkKZ4EkSgjFZkkcwo+Ozr+Cr1knn1nJByTlYRTuzigua1Qu+X
8h6hAeqM0RgBUbynzkmbRFtTU95hADWqDuARQuwHf5sLE6MrewZ0YKRjq0ynS8Ty
TU0dvraeEI+COPFuP0pxCx3TVcCMIKhKA+zXlZf4IHwjQCi25sa6dMfmalAgnxWP
OOdSBC8XMiDMdz5gQ7Xxn6Vz+/P8DQ==
=RMjQ
-----END PGP SIGNATURE-----

--zhegztmaioghtjqo--
