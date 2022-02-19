Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C14BC796
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiBSKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:11:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBSKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:11:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782F17CC5B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 02:11:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nLMhf-0007Mh-RX; Sat, 19 Feb 2022 11:10:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nLMha-00HaZX-Eg; Sat, 19 Feb 2022 11:10:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nLMhY-004Ay5-5B; Sat, 19 Feb 2022 11:10:52 +0100
Date:   Sat, 19 Feb 2022 11:10:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220219101049.erwzy5mpmsfgcwjy@pengutronix.de>
References: <20220212162342.72646-1-nikita@trvn.ru>
 <20220212162342.72646-3-nikita@trvn.ru>
 <20220214184320.ym36pfvozwdp5nbb@pengutronix.de>
 <425691dbe49115f04dbe89c158bf6d1c@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcsfojf673wfhfx3"
Content-Disposition: inline
In-Reply-To: <425691dbe49115f04dbe89c158bf6d1c@trvn.ru>
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


--xcsfojf673wfhfx3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Feb 19, 2022 at 11:46:31AM +0500, Nikita Travkin wrote:
> Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 14.02.2022 2=
3:43:
> > On Sat, Feb 12, 2022 at 09:23:42PM +0500, Nikita Travkin wrote:
> >> + * Limitations:
> >> + * - Glitches are possible when new pwm state is applied.
> >> + * - Due to the fact that exact behavior depends on the underlying
> >> + *   clock driver, various limitations are possible.
> >> + * - Period depends on the clock and, in general, not guaranteed.
> >=20
> > This sentence is broken.
> >=20
>=20
> Here what I mean is that the clock driver might e.g. have a lookup table
> for some rates and will only set one close to the requested ones.
> (Extreme scenario is that only one rate is allowed in the lookup table,
> which is a real possibility for some platforms that I think this driver
> will be used with, the lookup may need to be changed for those clocks)
>=20
> I will reword this like:
>=20
>   Some clock drivers may only pick the closest available rate
>   and not the exact requested one. Because of this, exact period
>   is not guaranteed.

That there is no exact match is quite normal also for dedicated PWM
HW blocks. So I think the second item in your list is good enough to
cover the non-existing guaranteed for period and glitches.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xcsfojf673wfhfx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIQwiYACgkQwfwUeK3K
7AmwDAgAh+qJOwueaEP6U+zrcuXsruNi3EYhzJmSWcoigyYJK42AI4f0mcayA/JP
GASsrgIrdfvaAnR5uz13Fm3Bd+OClTe9vHP2w7CmzABoXjS6ML4HTkT2oCn4/8Ss
lowe8NdBANsNW2JCi2ELw0k7504L2uGVMCipMR83L/1RVRimDdPtGinsW1bG6yG4
jt/hS50vcEqknViWuzk+MXcPN+rvCaPZK1Mjisdf95+dPVqJUN4g2Bh57Q4vsBN5
68tz9E9FruwEW0yf7EuJdlxEdBTOY5igm7ZPr7+uB5LePHjfG0pthex3pbwkepp6
HDYaqxlQYdQhL6+yMKkiIDCvYgq0tg==
=eD3B
-----END PGP SIGNATURE-----

--xcsfojf673wfhfx3--
