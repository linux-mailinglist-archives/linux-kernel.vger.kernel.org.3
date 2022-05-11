Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30760522DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiEKHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiEKHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:52:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA73B3D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:52:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noh8j-0006DI-Pe; Wed, 11 May 2022 09:52:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noh8g-001dz6-Ds; Wed, 11 May 2022 09:52:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noh8e-008yob-6o; Wed, 11 May 2022 09:52:04 +0200
Date:   Wed, 11 May 2022 09:52:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: gpio: gpio-mvebu: convert txt binding to
 YAML
Message-ID: <20220511075202.7apknuj4akogbck6@pengutronix.de>
References: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tw3ilu4f5ovextuf"
Content-Disposition: inline
In-Reply-To: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tw3ilu4f5ovextuf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 11, 2022 at 01:37:37PM +1200, Chris Packham wrote:
> +  "#pwm-cells":
> +    description:
> +      The first cell is the GPIO line number. The second cell is the per=
iod
> +      in nanoseconds.
> +    const: 2

I wonder if the binding [cs]hould allow 3, too. After a quick look in
the driver code I think 3 would be supported out of the box.
That's a low prio thing though (the driver doesn't support polarity
anyhow) and this is orthogonal to this 1:1 conversion patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tw3ilu4f5ovextuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ7ax8ACgkQwfwUeK3K
7AlUHAgAhQgz6V4xlZTQp+faj6HQmAaQxuZIS2HsEo++6hf2WJHNSn2cfdBi0sF3
GMGJpF08sdONzDpQURk5MBePB2QXQM/YwuVuYTzOEMW33YBlmxP8WqzmEUcxAXSn
hPNvPzbrhA17X2SMrdq582fK3j+EYaASwj7gfKBI3hOayJJLLdQ7axOyy2JVRVYF
mOdV1TMjjlogoyaccKb1bvaajTxGvIE0ZcuwFPEEYPQnKfMIpIwi0ce5TYuAv0ZZ
LABxHURY3Vl08sYJGGD9rDO+7VTwnxW4ua0RjUR3Wve9K9CbxuASM4Ei8hLPBPju
IZYq6Iyu+Jemj2c5F15Mi5jhxZRHNA==
=S1PG
-----END PGP SIGNATURE-----

--tw3ilu4f5ovextuf--
