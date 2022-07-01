Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDC5633EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiGANB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiGANBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:01:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB7D43AE0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:01:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GHF-0002ni-LQ; Fri, 01 Jul 2022 15:01:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GH7-003mvK-2Z; Fri, 01 Jul 2022 15:01:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7GH9-002Jzq-VC; Fri, 01 Jul 2022 15:01:35 +0200
Date:   Fri, 1 Jul 2022 15:01:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: pwm: Document clk based PWM
 controller
Message-ID: <20220701130133.st7zaw4ta4v42fiy@pengutronix.de>
References: <20220612132203.290726-1-nikita@trvn.ru>
 <20220612132203.290726-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kgghnss7vxtqvlnc"
Content-Disposition: inline
In-Reply-To: <20220612132203.290726-2-nikita@trvn.ru>
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


--kgghnss7vxtqvlnc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[fixing the address of the devicetree list]

On Sun, Jun 12, 2022 at 06:22:02PM +0500, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

I'm discarding this patch from the PWM patchwork as I expect it to be
resent when the review comments for patch 2 are addressed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kgghnss7vxtqvlnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+8CoACgkQwfwUeK3K
7AmtdQf9E3zHemlvY2NEH8un1rijwUybR8QZ7J7kEdj4B4ATuXYPwq+N2B+O1MVt
x7q9zbTSLLUFTf+2gM7hxTNdkH+82upf4SaYNncMDcgZyDZMCGBZuvS8lvB9pHxz
rFlB0iDQIfkIT3tTLf1dM+7ZQv+hsP+GV7mstsv8R5ifjGXvihilS2RP1fu8h9mV
/Qi0gIzikwqfGd/5CewNv4XzWvkGiYsdVUchoOUmdk7oCvg4i41K9Um3Pp6JGkcW
A6JSRXCfiawikKUOYda/3BjeynG65HVW+rq/Wy+JEBUKpc0rTmYUbR4Wcy5nZcof
c75IRUFjARv5BWkAfjYqMMyAcCS5ZQ==
=zTYG
-----END PGP SIGNATURE-----

--kgghnss7vxtqvlnc--
