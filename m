Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAFC4B1705
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbiBJUhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:37:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiBJUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:37:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69216F23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:37:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nIGBD-0000Z0-4W; Thu, 10 Feb 2022 21:36:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nIGB9-00FmbJ-D5; Thu, 10 Feb 2022 21:36:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nIGB7-00Ew9B-Uw; Thu, 10 Feb 2022 21:36:33 +0100
Date:   Thu, 10 Feb 2022 21:36:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the hwmon-staging
 tree
Message-ID: <20220210203632.e4faql2k5qxq4tmt@pengutronix.de>
References: <20220210132506.051144fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lbpyn66hntiogop"
Content-Disposition: inline
In-Reply-To: <20220210132506.051144fb@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lbpyn66hntiogop
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 10, 2022 at 01:25:06PM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the spi tree got a conflict in:
>=20
>   drivers/hwmon/adt7310.c
>=20
> between commits:
>=20
>   9c950b125f78 ("hwmon: (adt7x10) Remove empty driver removal callback")
>=20
> from the hwmon-staging tree and commit:
>=20
>   a0386bba7093 ("spi: make remove callback a void function")
>=20
> from the spi tree.
>=20
> I fixed it up (I just used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Just for the record: I agree this is the right resolution (i.e. take the
file from the hwmon tree).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3lbpyn66hntiogop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIFd0wACgkQwfwUeK3K
7Ak9jwf9FMZgXyGsfvcXSCF8sZy13mSqbH8OG+kkL/S+glq0kzlEI6Eu1PlH6DtI
SWgiMp+uAI4tgB+w7kFXdui3ps19uch+IzkEmE0Ft96f1qcE2MucgqL+D5fhLz4h
+yFyL5x486aVjQ8qtdwuS5QizHCAKgIIivOLisYLyX7JMeKoYGsqoQu/y8r8X9e3
oC2osEZVhaJ3MSjB3pq93D9mlCdUw9s+GqXe9xBYLC/xqyXSRN3RVQc+XuHLqKRV
x1GZMXbz3pbMakm9ZT3LElt4XijZ1Ev5GlkJuASjhmyIFFz2cem9R2D3oUkHHG2G
roxW6zaoZfOU0WTArTZApIGLsryIYg==
=2JtR
-----END PGP SIGNATURE-----

--3lbpyn66hntiogop--
