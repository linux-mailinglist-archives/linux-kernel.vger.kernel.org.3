Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8A4AD467
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353154AbiBHJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351635AbiBHJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:10:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199EC0401F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:10:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHMWB-00066l-R3; Tue, 08 Feb 2022 10:10:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHMW9-00FGoZ-RX; Tue, 08 Feb 2022 10:10:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHMW8-00BiId-Hq; Tue, 08 Feb 2022 10:10:32 +0100
Date:   Tue, 8 Feb 2022 10:10:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add compatible string for
 MT8183 SoC
Message-ID: <20220208091029.iwnepc343djtcvq5@pengutronix.de>
References: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
 <20220207125158.t5362u2dddccdmsq@pengutronix.de>
 <f6633fc82c4fa899c7f4ca27d9751d9e61fb90ac.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocriqvydtskbnony"
Content-Disposition: inline
In-Reply-To: <f6633fc82c4fa899c7f4ca27d9751d9e61fb90ac.camel@mediatek.com>
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


--ocriqvydtskbnony
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 08, 2022 at 12:28:23PM +0800, allen-kh.cheng wrote:
> Thank you for your suggestions.
> We will send another patch for .yaml format.
>=20
> About the last reminder, sorry, I don=E2=80=99t get that.=20
> Do you mean upper/lower case letters in an email address?

exactly. I don't know how picky Thierry (who is responsible to pick up
this patch or not) is, but a 100% match is the safe bet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ocriqvydtskbnony
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmICM4IACgkQwfwUeK3K
7AkomwgAjyvexLDj4KWf4AnFi96ZKatrTB7IwOyT7pD0vBcRoKsvunPSnHJsjIIP
dK9UYjAorC9HvWd0TkFBxdELweyiX2jalzEFQqmrNh09L7JMyslk0VKeikzxT9kr
/V4YccfXY11ip6iE5zjF2Rr8qQHfHPWzIni3+RFN8S87sR55P3UInnYfq6WFzPwV
in2gAhYdOL0/Wfx+t9CxB7ayyywSMjl/clmr3Bv1gdI9okfu53zF9RTShzLe9Hug
FktAFjXQoUoe/kU6Qll2eKiFSJkIP88amXjOGvPhdekZ14i7qsGRNseyl4pAHTvB
1x+gQ4/a0uoQdNQGr0Rt7TVG7T/VxA==
=FP1F
-----END PGP SIGNATURE-----

--ocriqvydtskbnony--
