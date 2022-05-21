Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B032152FD38
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiEUOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiEUOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:20:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06463381
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:20:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsPy0-0007em-SO; Sat, 21 May 2022 16:20:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsPy0-003hyM-58; Sat, 21 May 2022 16:20:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsPxy-00BCXz-4p; Sat, 21 May 2022 16:20:26 +0200
Date:   Sat, 21 May 2022 16:20:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: fix typo in comment
Message-ID: <20220521142023.qbk4s2gydpox7c2w@pengutronix.de>
References: <20220521111145.81697-22-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnsdnebowjixthkb"
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-22-Julia.Lawall@inria.fr>
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


--tnsdnebowjixthkb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 21, 2022 at 01:10:32PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tnsdnebowjixthkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKI9SQACgkQwfwUeK3K
7An1EQf3bDnHc/rwmXW/hxQYgjXTU66lI9Zhkw5vRZWJgMerGFoWG5K5cyNNv/5Y
iq5MHhKURCOHVHyRfICTKuOOzpYrWanJajIbgYEB+N8shtt9dixlkFwDzWhqDIUj
ceBdQQfZInYER2tWakDdkJgt6JndTwdJcQrMEB8NEIS5f+jJZNN22BtiGdqpmgrH
zwinSNDCtnnOID3LPDmKhk3TgHlQZElkesUJtfyX6if55mI+mQbcCUd7TjnFzHIL
0nJ4WwGDwO4hLfYe1iU4whJ63ETLyW5nt9NUZ7f5Wi5qgD5dAv9SawPvOTamGwSs
G1nyZXV+f/OkfBsuepRQHgsYEPYJ
=o9OB
-----END PGP SIGNATURE-----

--tnsdnebowjixthkb--
