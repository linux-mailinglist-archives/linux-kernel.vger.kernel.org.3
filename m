Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536DE56D51E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGKHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGKHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:04:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059C17580
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:04:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnSY-0002BA-5C; Mon, 11 Jul 2022 09:03:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnST-000GP7-Tb; Mon, 11 Jul 2022 09:03:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnSS-004Smc-Tl; Mon, 11 Jul 2022 09:03:52 +0200
Date:   Mon, 11 Jul 2022 09:03:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v7 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220711070349.udyej2qxj2hqyowz@pengutronix.de>
References: <20220612132203.290726-1-nikita@trvn.ru>
 <20220612132203.290726-3-nikita@trvn.ru>
 <20220701075012.xpkcd5xk42frevyq@pengutronix.de>
 <ef73636abfc6df26c249863e0288dc48@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4lh4agfmm7fyovv"
Content-Disposition: inline
In-Reply-To: <ef73636abfc6df26c249863e0288dc48@trvn.ru>
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


--t4lh4agfmm7fyovv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 10:55:09AM +0500, Nikita Travkin wrote:
> Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 01.07.2022 1=
2:50:
> > On Sun, Jun 12, 2022 at 06:22:03PM +0500, Nikita Travkin wrote:
> >> Some systems have clocks exposed to external devices. If the clock
> >> controller supports duty-cycle configuration, such clocks can be used =
as
> >> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> >> similar way and an "opposite" driver already exists (clk-pwm). Add a
> >> driver that would enable pwm devices to be used via clk subsystem.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> --
> >>
> >> Changes in v2:
> >>  - Address Uwe's review comments:
> >>    - Round set clk rate up
> >>    - Add a description with limitations of the driver
> >>    - Disable and unprepare clock before removing pwmchip
> >> Changes in v3:
> >>  - Use 64bit version of div round up
> >>  - Address Uwe's review comments:
> >>    - Reword the limitations to avoid incorrect claims
> >>    - Move the clk_enabled flag assignment
> >>    - Drop unnecessary statements
> >> Changes in v5:
> >>  - add missed returns
> >> Changes in v6:
> >>  - Unprepare the clock on error
> >>  - Drop redundant limitations points
> >> Changes in v7:
> >>  - Rename some variables to be in line with common naming
> >>
> >> --
> >> It seems like my mailserver wasn't able to send the last review
> >> response to Uwe's so I'll repeat here that afaict clk.h has all the
> >> methods stubbed out so compiling without HAVE_CLK is possible.
> >> Sorry for a long delay with sending this since v6.

FTR: The only problems I have with mail sending in this thread is to
"devicetree@vger.kernel.or", I added a 'g' for this mail to that address
:-) Otherwise if you diagnose to have problems with the pengutronix
server accepting your mail, I'd like to hear about that.

> >> +	pcchip =3D devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
> >> +	if (!pcchip)
> >> +		return -ENOMEM;
> >> +
> >> +	pcchip->clk =3D devm_clk_get(&pdev->dev, NULL);
> >=20
> > You can use devm_clk_get_prepared() here and drop the clk_prepare()
> > below and the clk_unprepare in .remove().
>=20
> Here I spent a bit of time trying to remember why I thought
> I've already looked at this, but after figuring out that this
> devm helper didn't even exist earlier (I only see it in clk-next)
> I remembered considering a totally different thing (being
> clk_disable_unprepare in the _remove, which doesn't play well)
>=20
> Given that this seems to be absent from 5.19-rc6, I'm afraid adding
> it here will upset the 0day as well as possibly cause issues in case
> both are taken for the same merge window...

Pass --base with a sensible parameter to git-format-patch (or
git-send-email) to make the 0day bots happy.

> On the other hand it takes me quite a while to provide replies for
> this series (the trend I'm not happy with) so maybe 3-4 weeks
> will indeed pass for 5.20-rc1 to have it...

It's not me who merges PWM patches but Thierry. I don't know his plans
and if he would be willing to pick up a new driver for the next cycle.
You might still get lucky with a fast next iteration.

If you want ignore the devm_clk_get_prepared() suggestion, we can still
convert to that once both patches hit Linus Torvald's tree.

> I think I will try to send a new version with just the comment
> added shortly in case it's still not too late for the next merge
> window and you can feel free to nack it if you think it already is :)

I think the driver looks good otherwise, so I don't expect to have more
feedback in the next round.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t4lh4agfmm7fyovv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLLy0sACgkQwfwUeK3K
7AmGFQf+PDPISkxqvBE151Vnru2AG1kpl+mWuXiK0CEkc7RSktmlRobuljq9Vmqr
nQlZbRL0UUgvnJzqCHHDhHyQYcSCrmRgjeUEClk6m8eVSfnPlhDDBbCO2OUG5ijq
ZxJJYPhwVei81ubmdjUI+QEz+tFCC/G+09J2cui0poxDZjsTTx2wlnhqLpvfDLSC
GFnXEr9fGgm00YIWkBTdl1NOWeeUw8XtfXEaJGklPcT5J6DcjrgZ3lNd6jmO8aXU
+aVtY3XINokCxHNIOM8syNzZfXjJooB6qhJRpFs2eOkZCPlGlUcnZZKvIoP22uHV
/I4LRm2EqXinEfMUrLxjRgWHb1xwbA==
=Ji7s
-----END PGP SIGNATURE-----

--t4lh4agfmm7fyovv--
