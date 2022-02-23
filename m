Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378E44C0C85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiBWGX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiBWGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:23:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11154BC6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:22:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMl2t-0005cM-1S; Wed, 23 Feb 2022 07:22:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMl2s-000lHS-6g; Wed, 23 Feb 2022 07:22:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMl2q-004y0T-ML; Wed, 23 Feb 2022 07:22:36 +0100
Date:   Wed, 23 Feb 2022 07:22:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-mediatek@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org, chrome-platform@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] mfd/pwm: dt-bindings: google, cros-ec:
 include generic pwm schema
Message-ID: <20220223062233.4m2xejozz4d47gmo@pengutronix.de>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <164557235424.1264579.14486504733557463529.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tz6kkjgucct6gsdy"
Content-Disposition: inline
In-Reply-To: <164557235424.1264579.14486504733557463529.b4-ty@sntech.de>
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


--tz6kkjgucct6gsdy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 23, 2022 at 12:27:08AM +0100, Heiko Stuebner wrote:
> On Mon, 14 Feb 2022 09:19:12 +0100, Krzysztof Kozlowski wrote:
> > DTS patches are independent. Not tested, but I really hope no downstrea=
m kernel
> > depends on pwm node naming... If it does, please change it to compatibl=
e. :)
> >=20
> > Best regards,
> > Krzysztof
> >=20
> > Krzysztof Kozlowski (4):
> >   dt-bindings: pwm: google,cros-ec: include generic pwm schema
> >   arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
> >   arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
> >   arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
>       commit: 474a84be692d893f45a54b405dcbc137cbf77949

I expected that all patches in this series go in together via an ARM
tree. Or are there expectations that this goes via PWM?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tz6kkjgucct6gsdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIV0qYACgkQwfwUeK3K
7Al9mQgAhD+Y70LUATDqKKM6Uf5x8vV8s8vkHGeNWj6YC7RgYVH/gsKh2FZTHebB
13Z4Tmc+6U7nbvDhzVU3v+6p4QqjwRJO1dINTZZwkPXYBS1wopfnGkdrjJWcXSWL
i2pFlGJm9Sh/16uLjIUsGMr+/V4ftEHzphi9fAvKUcbLlGmOIVA4KkA1IM3kUUqM
QvrvXSxms4ktaL+IEnjtza+lr8VhuYyeLCnrapNYBQ8qzvlIEy77IQN7xTiaQ5KY
/jsRBUw82H0YuUxCx4pHX3b7Y17mOXBrWJtt5EWwsjNNEjAuGnyE/1WCxC8sht/6
p1Wso+Y/5o80Ph14XipAdR7uEVIEBQ==
=96Gc
-----END PGP SIGNATURE-----

--tz6kkjgucct6gsdy--
