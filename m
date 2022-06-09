Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10B5454D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbiFITV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFITVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:21:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E321F0A7F;
        Thu,  9 Jun 2022 12:21:52 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E417660177B;
        Thu,  9 Jun 2022 20:21:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802511;
        bh=pJnUgqB06r+c4j6TArHnOqEGUTLYzWOpX1/yKBfNaQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3EC0HgpflKPRYfrN6WjjOpBJh95/7bnuOhtTJ1hrvJXvQxx9ljTweF+WHfqw0xlk
         yWShz8GZGbNUlpoZ2ibQiNU77S7dyAOonbQW2ZDbZoac6Ww2wl5mu+xDOSoKONo/20
         QBi6P/hBcHbiBrOpkpuawqLvVWyxnynQpH+5B4+qSgFDfcrV4sgF9CCdK4kENPABNk
         SidWpRKEXm070X4CTIbGdPPE3TwC1ONMVKk9uqKPmbXbRQ3hSUwTvX+mPvfWHJBot+
         oqxTjTDWYok7kUEThBRc9ZyC46Pwo8kbvkHNr2lc9ZqS2rGGKUHNzDIQI08JkRBuSd
         oh+aa9bNv2HWQ==
Received: by mercury (Postfix, from userid 1000)
        id DA84B10605B9; Thu,  9 Jun 2022 21:21:48 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:21:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 5/6] power: supply: max77976: update Luca Ceresoli's
 e-mail address
Message-ID: <20220609192148.vifrjbggixbn7mvi@mercury.elektranox.org>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
 <20220603155727.1232061-5-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jgfr724zbzdzymbh"
Content-Disposition: inline
In-Reply-To: <20220603155727.1232061-5-luca@lucaceresoli.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jgfr724zbzdzymbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 03, 2022 at 05:57:26PM +0200, Luca Ceresoli wrote:
> My Bootlin address is preferred from now on.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max77976_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supp=
ly/max77976_charger.c
> index 8b6c8cfa7503..4fed74511931 100644
> --- a/drivers/power/supply/max77976_charger.c
> +++ b/drivers/power/supply/max77976_charger.c
> @@ -3,7 +3,7 @@
>   * max77976_charger.c - Driver for the Maxim MAX77976 battery charger
>   *
>   * Copyright (C) 2021 Luca Ceresoli
> - * Author: Luca Ceresoli <luca@lucaceresoli.net>
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>   */
> =20
>  #include <linux/i2c.h>
> @@ -504,6 +504,6 @@ static struct i2c_driver max77976_driver =3D {
>  };
>  module_i2c_driver(max77976_driver);
> =20
> -MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
> +MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
>  MODULE_DESCRIPTION("Maxim MAX77976 charger driver");
>  MODULE_LICENSE("GPL v2");
> --=20
> 2.25.1
>=20

--jgfr724zbzdzymbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiSEwACgkQ2O7X88g7
+ppDpxAAjfpEDQfoYU0OfefOmIvmjURQvtNv7YBLr4ogCOf8qHqGGFLzfySKH+eE
4ZVCjXYbmOXKy3eJHRDNCQD/84Fbc+1jq+AWg8BAjC9s1Dmrt7ik2IQcghQi2dqs
8u24+mPus+cds5TBhk+UgoNqp90s9ZUhXxBgTpVa0fdghT9hG/EY2Xo+mKHXXx/z
Vg1VsNgk+1+AlT9ScEZT0dsDVECEGQ6+7nWFGXQa+6fWmckdaBoN9m4ijm8yN1FI
6FwKLJ7yuQliUV40uPgN6TQ2Pd9gz2LZahJFLIHO4I0MpjTOcoBZ3vDLVbqq+MiJ
UXgTXsb9ATqC7HceqyYMKsAQCY4YL7SVDeq/K7ZGOv5R4mouNy0YLRgy2sdx1EPV
v592Lj8KU/+93V+jTNXwwof9cbIVdMJq48tJBnXv8pyh3AX68Xwe/FRU5/WequH/
ErQIv4wFnyJiwpBPbjP/45aoM54NQxt08b+NFGD07xLMTWWIj1XpHTbBPrb/HZ+Z
puAFUk4cIyUjPb8gOuoD33oP714fxZem3l6XpAiXarm2prV1EN96PuiwYyEbCVxQ
i38sRY2epqUpIWnDGWG16sfW9obOwIvJKzHF79EaW2v07j+/2TKp5OGRsLm0MOSA
oI446aN/UILXE8CGiEKRoy3hzlARoT2jdM7Q1wdCPrdg/MNhnU0=
=SZ2i
-----END PGP SIGNATURE-----

--jgfr724zbzdzymbh--
