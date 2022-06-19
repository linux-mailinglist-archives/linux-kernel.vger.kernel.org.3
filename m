Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434EF550CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiFSUOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFSUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:14:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A3B4BD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:14:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Iy-0000nr-Id; Sun, 19 Jun 2022 22:13:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Iq-001Voq-F1; Sun, 19 Jun 2022 22:13:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31Ir-00HRYt-34; Sun, 19 Jun 2022 22:13:49 +0200
Date:   Sun, 19 Jun 2022 22:13:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        lee.jones@linaro.org, andrew@lunn.ch,
        thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: gpio-mvebu: document offset
 and marvell,pwm-offset
Message-ID: <20220619201341.yus35sjz7z3gedal@pengutronix.de>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
 <20220526012946.3862776-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xvuxeb3qoohuploo"
Content-Disposition: inline
In-Reply-To: <20220526012946.3862776-4-chris.packham@alliedtelesis.co.nz>
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


--xvuxeb3qoohuploo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2022 at 01:29:46PM +1200, Chris Packham wrote:
> The offset and marvell,pwm-offset properties weren't in the old binding.
> Add them based on the existing usage in the driver and board DTS when
> the marvell,armada-8k-gpio compatible is used.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>=20
> Notes:
>     Changes in v4:
>     - Reword commit message slightly
>     - Add review from Krzysztof
>     Changes in v3:
>     - Split off from 1:1 conversion patch
>=20
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> index 459ec35864fe..f1bd1e6b2e1f 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -45,6 +45,10 @@ properties:
>        - const: pwm
>      minItems: 1
> =20
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the gpio registers (in b=
ytes)
> +
>    interrupts:
>      description: |
>        The list of interrupts that are used for all the pins managed by t=
his
> @@ -68,6 +72,10 @@ properties:
>    "#gpio-cells":
>      const: 2
> =20
> +  marvell,pwm-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the pwm registers (in by=
tes)
> +

Seems to match reality (in the driver and some dtsi files).

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xvuxeb3qoohuploo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvg3IACgkQwfwUeK3K
7Alwwgf8CsCHCQGSAfBc8+GQ/QiAhiN6VxkHg/K1L/Ag+Zc3gYNy9xeWMkir7ikv
EhbI3u/MIgvI+xjlomD0cNyuUBhOtglusOp3wpiOcBvvVQn8FwzjZOX0Jnrm1Ke7
xzx29+lyclz/Jr/mBGUYc3+q+6+4yX3vk9BXrIMG8y87V80Go4pXonXl3AZJFinR
YpljwaxgrZ8Sl1DyTQrvIKbV7Y4NHhLf23p4qcbyXscaqwvilDtxDpCo4/auqrQN
Otkbgv7gyJazK9tRbEwD/w8F8eQSjpG6gjJvNZ3JMMmAQWYEWnEbcXgJ2jeHnlKL
f2myqmeDNVra+gKvUZBF5a+ckLbQbg==
=J8FS
-----END PGP SIGNATURE-----

--xvuxeb3qoohuploo--
