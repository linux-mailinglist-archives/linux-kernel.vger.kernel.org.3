Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4916D531DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiEWVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEWVZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:25:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818568335
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:25:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntFXw-0007Ww-4T; Mon, 23 May 2022 23:25:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntFXw-0049Tq-GB; Mon, 23 May 2022 23:24:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ntFXt-00BgXU-U7; Mon, 23 May 2022 23:24:57 +0200
Date:   Mon, 23 May 2022 23:24:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] mfd: twl6030: Make twl6030_exit_irq() return void
Message-ID: <20220523212457.3cd5f5afwla2ahxi@pengutronix.de>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
 <20220113101430.12869-2-u.kleine-koenig@pengutronix.de>
 <Ymq/tVTo2JIEDEQa@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqbvmdiboxepjnhz"
Content-Disposition: inline
In-Reply-To: <Ymq/tVTo2JIEDEQa@google.com>
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


--fqbvmdiboxepjnhz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, Apr 28, 2022 at 05:24:21PM +0100, Lee Jones wrote:
> On Thu, 13 Jan 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > This function returns 0 unconditionally, so there is no benefit in
> > returning a value at all and make the caller do error checking.
> >=20
> > Also the caller (twl_remove()) cannot do anything sensible with an error
> > code. Passing it up the call stack isn't a good option because the i2c =
core
> > ignores error codes (apart from emitting an error message).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/mfd/twl-core.c    | 4 ++--
> >  drivers/mfd/twl-core.h    | 2 +-
> >  drivers/mfd/twl6030-irq.c | 3 +--
> >  3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> Applied, thanks.

I would have expected these to appear in next since you wrote to have
applied this series. But they have not though your claim to have applied
them is over three weeks old now?! :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fqbvmdiboxepjnhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKL+6YACgkQwfwUeK3K
7Alx3wf+Pgvhe1l5WLnaEBEGjKDphT/lEXXiucONwPGZm8+iSs3zSCZSsO9+DSMp
86EA9qc4rFval3zw4YnxxWQRDp1Hp3rAjduP/N6BhEizKdfaPEq4ZyZZwLctt20o
KAt3oXT07jrpn1ZRH8Np6OBUhVBIUFZaVTVjRZ8LyyxZpqwHq9XqBiPv5f2WB4Tz
Dv1Fs1UMv7fSDStJyyfryHlMijn1cUGhbh/jm/WG/ODI/VoB6xK/G2+xGcpSO5ec
ju9iKw5h24KRm6eupEnIjsKryi4+DUYVRtCeZBwCJRtbXnBVAQx4FxRANOmGSz8V
tVemjWWCMFsc68dNiPPSh7mc7uQmVg==
=AN+o
-----END PGP SIGNATURE-----

--fqbvmdiboxepjnhz--
