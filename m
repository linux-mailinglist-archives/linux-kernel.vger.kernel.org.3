Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5034DAAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiCPGxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346570AbiCPGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:53:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A575DA78
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:52:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUNVs-0006dA-FP; Wed, 16 Mar 2022 07:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUNVo-000zbf-Sq; Wed, 16 Mar 2022 07:51:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUNVm-009UG4-Qs; Wed, 16 Mar 2022 07:51:58 +0100
Date:   Wed, 16 Mar 2022 07:51:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mail@conchuod.ie, sboyd@kernel.org, lewis.hanly@microchip.com,
        daire.mcnamara@microchip.com, ivan.griffin@microchip.com,
        Atish Patra <atishp@rivosinc.com>, conor.dooley@microchip.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        krzysztof.kozlowski@canonical.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 00/11] Update the Icicle Kit device tree
Message-ID: <20220316065155.tuuq2k4d5dczwtq2@pengutronix.de>
References: <c94f9c0a-6dbe-c1f4-daff-e4d29f3ace02@conchuod.ie>
 <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bkpwvtdvshkxkizn"
Content-Disposition: inline
In-Reply-To: <mhng-bb42ad9f-5772-4749-97e1-9f6c511654f6@palmer-mbp2014>
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


--bkpwvtdvshkxkizn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2022 at 11:07:03PM -0800, Palmer Dabbelt wrote:
> On Wed, 23 Feb 2022 12:48:16 PST (-0800), mail@conchuod.ie wrote:
> > dt-bindings should be set now, so if you're still happy to take the
> > series via riscv, that'd be great. i2c, spi & usb patches ended going
> > via the sub-system trees (and have been dropped from the series), in
> > case those generate warnings for you.
>=20
> Something went off the rails in email land and #0 and #2 didn't end up in=
 my
> patch queue but the rest did.  Luckily enough made it through that it did=
n't
> get lost, and lore's pretty great so this sort of thing isn't that big of=
 a
> deal these days.  That said, email is a bit of a black box so figured I'd
> give you a heads up.

One of the patches in next now is
df77f7735786ece2fcd8875b036a511ffcadfab6. It would be great if you could
fix your patch application setup to not mangle names. Here it's

	Acked-by: Uwe Kleine-K=3DF6nig <u.kleine-koenig@pengutronix.de>

where my =F6 was recorded as =3DF6. :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bkpwvtdvshkxkizn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIxiQgACgkQwfwUeK3K
7AnaOAf+KYzjoQhzMwQBCvuk5Nuy19InDXSbXr3hGJaP1HavbuLPFGVesC/ny0hy
pYoeu3A8RpcK8VCbPnl3E8baLLrWlzzPEjbPzb0hrbGvu79Bkiire4nM9GmnCBKa
uYWdxrbt8s4NRrvHmeqf3IAaXe3N2T98KWSjklHsqD10/S/QEBNphY6G9mcXi0Aj
28imRZDsWhU2uTpe4UpbEXAq+GP3MzII3K3+gEtJmsRADPmkVcZlHVPzeABY9PWh
TIEcWRwydEsaMDxUpl4tEv+lWTt3DpRp65cMC6ElJk7lWVIpIAQYLUYjhoQSIYsP
XP549wvifCmIMBHY/C7IBeHUgwjl6w==
=t8CP
-----END PGP SIGNATURE-----

--bkpwvtdvshkxkizn--
