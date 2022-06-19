Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2BC550CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiFSTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiFSTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:47:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9862CB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:47:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30tG-0006Ao-FN; Sun, 19 Jun 2022 21:47:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30tE-001VO6-1I; Sun, 19 Jun 2022 21:47:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30tE-00HR5y-SA; Sun, 19 Jun 2022 21:47:20 +0200
Date:   Sun, 19 Jun 2022 21:47:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/pwm to PWM SUBSYSTEM
Message-ID: <20220619194717.oey6dfhrcs6h4btv@pengutronix.de>
References: <20220613123319.22964-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2g4jtthgkkpixmm2"
Content-Disposition: inline
In-Reply-To: <20220613123319.22964-1-lukas.bulwahn@gmail.com>
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


--2g4jtthgkkpixmm2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 02:33:19PM +0200, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/pwm
> are also the maintainers of the corresponding directory
> include/dt-bindings/pwm.
>=20
> Add the file entry for include/dt-bindings/pwm to the appropriate
> section in MAINTAINERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

LGTM

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2g4jtthgkkpixmm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvfUMACgkQwfwUeK3K
7AkJgAf/T3lLqj8kvK25QYv3SAiiRwrGq1t1sXlWYbCYKqcDP/xDbfw7LW4qwAy4
0aTtEgcdKez76ZcxkE/qWdcjU8GhpWV7HodBDBDNTwFzHWhZiBg7qIoUz1ah1CnV
2PQtUFdnValY41EAClM8EL/V9/EqyLMupeKvkILkeksP2PXbHpL5AK9R9pv5W5sQ
qo5qHWtw42WDj7r/K9DW6idqdJ/USk1SjcRw2+6H2fYvAwaC++INLTOEitUHAMS0
w8DfH0E5uoVl/tWK+6tTJnreaKIo4dqTWcxkc6Vd0uUgfZKIJh40/nFLEsjUYVZL
OXFsHGO3JI1sS7trHtvFculX6zDrGQ==
=dlHo
-----END PGP SIGNATURE-----

--2g4jtthgkkpixmm2--
