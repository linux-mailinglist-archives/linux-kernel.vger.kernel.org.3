Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5554F82F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380725AbiFQNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiFQNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:09:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD115A3E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:09:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2BjH-0000yZ-Do; Fri, 17 Jun 2022 15:09:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2BjE-0014JM-Uv; Fri, 17 Jun 2022 15:09:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2BjF-00Gy7Y-Gd; Fri, 17 Jun 2022 15:09:37 +0200
Date:   Fri, 17 Jun 2022 15:09:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        Daire.McNamara@microchip.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Add support for Microchip's pwm fpga core
Message-ID: <20220617130931.3rdaj4p3d54p4ynz@pengutronix.de>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
 <a2d97203-dd8a-69ea-fdb5-b25f3937163f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edflhgjjggubtngp"
Content-Disposition: inline
In-Reply-To: <a2d97203-dd8a-69ea-fdb5-b25f3937163f@microchip.com>
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


--edflhgjjggubtngp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 17, 2022 at 11:50:13AM +0000, Conor.Dooley@microchip.com wrote:
> On 17/06/2022 12:44, Conor Dooley wrote:
> > Hey Uwe,
> > Got a ~v2~ v3 for you...
> > I added some comments explaining the calculations and a documentation l=
ink
> > so hopefully things are a bit easier to follow.
> >=20
> > Code wise, I went through and sorted out a bunch of issues that cycling
> > through the different periods/duties threw up. Along the way I found
> > some other problems - especially with the longer periods which I have
> > fixed. I also added a write to the sync register in the apply function,
> > which will resolve to a NOP for channels without "shadow registers".
> >=20
> > Other than that, I managed to ditch the mchp_core_pwm_registers struct
> > entirely but had to add a short delay before reading back the registers
> > in order to compute the duty.
> >=20
> > Thanks,
> > Conor.
>=20
> *sigh* yet again I forgot to mention the potential maintainers conflict
> with spi-next..

I'm not a maintainer of a very active subsystem where MAINTAINER
conflicts are normal, but my expectation up to now was that conflicts in
that file are quite usual and trivial to resolve such that mentioning
these isn't very important.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--edflhgjjggubtngp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKsfPkACgkQwfwUeK3K
7AmwZAf/bWX4n/wcUGqi0wXz0cPwdC7eV7nl4j0QggrsM6in945yGO9U9QC4PJfp
Be5ow4QRp7JFiin3+CaOPTVtYXGT+/TJ4omWpoCG6kCBJh5blOBcsvjscpr830xL
D6a2MAqfS7d1Vf2v2eYPd/UYrdLP0h8kES5oaWZdvfuXaVwgEU9BqpyaS90UPjDk
2YF6HK3fYRTIT5dUGztObqyVmpU35PqmC4daPYBm0o5R2Rm1IANMsB4WxnkytgNf
h0dHtEV36dGKJjZUgRgnoGfWg7fbCaA5PXIbqGj0zSSLcfMm5FmwlTyFhIKaTLIW
0hlJAryHxNoEN0bJWE7RE05omF2Q0Q==
=KrS3
-----END PGP SIGNATURE-----

--edflhgjjggubtngp--
