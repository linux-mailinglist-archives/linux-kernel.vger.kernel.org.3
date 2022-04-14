Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C1501A83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbiDNRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbiDNRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313FEACAD;
        Thu, 14 Apr 2022 10:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBD060C8A;
        Thu, 14 Apr 2022 17:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A70C385A5;
        Thu, 14 Apr 2022 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649958712;
        bh=/30L5l2odtYOi3S0HqVqkjz/ODW+LxlgQAuoeJjHwE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcL6I9CukDB32MSfHaI30C4KsHDiTbuDTLiwJ8MtFunGgLt2Xn8ua3g0SY/M0FBLq
         M4GvWbu91Rj5P0lf22nFAEoOZ6rIAeSmtK8Z98XKuROOQz41OYZXEvxuE0+Shk4gxY
         ZoYz9Ie+O6t45i/Ix4IqattyBK/RZ22XA4xs5/XT6Tu4lDdOuSmmAq6FIdG5L/wLOr
         USLAuWvyIwDtIXLxsZibwTUfAYEMpVrQiLOyoGSPhCQ6M9wsfL0mEtmw3zJDsHje7O
         JODjxal5BqD4Cyfbz56O8rmjdMn7uZY39NCknncJBB9ZhVU61ISaI0DO68wzICrp8q
         aJlZnmWLh1gTw==
Date:   Thu, 14 Apr 2022 18:51:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator: sm5703-regulator: Add regulators support
 for SM5703 MFD
Message-ID: <YlhfMkBqst87qvtD@sirena.org.uk>
References: <20220414170616.23319-1-markuss.broks@gmail.com>
 <20220414170616.23319-5-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z0LrZJXyjIRCPfH2"
Content-Disposition: inline
In-Reply-To: <20220414170616.23319-5-markuss.broks@gmail.com>
X-Cookie: Available while quantities last.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z0LrZJXyjIRCPfH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 14, 2022 at 08:06:15PM +0300, Markuss Broks wrote:

> +++ b/drivers/regulator/Makefile
> @@ -173,5 +173,6 @@ obj-$(CONFIG_REGULATOR_WM831X) +=3D wm831x-ldo.o
>  obj-$(CONFIG_REGULATOR_WM8350) +=3D wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) +=3D wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) +=3D wm8994-regulator.o
> +obj-$(CONFIG_REGULATOR_SM5703) +=3D sm5703-regulator.o
> =20

Please keep the Kconfig and Makefile sorted.

> +static const int sm5703_buck_voltagemap[] =3D {
> +	1000000, 1000000, 1000000, 1000000,
> +	1000000, 1000000, 1000000, 1000000,
> +	1000000, 1000000, 1000000, 1100000,
> +	1200000, 1300000, 1400000, 1500000,
> +	1600000, 1700000, 1800000, 1900000,
> +	2000000, 2100000, 2200000, 2300000,
> +	2400000, 2500000, 2600000, 2700000,
> +	2800000, 2900000, 3000000, 3000000,
> +};

Are the repeated values at the ends of the array actually valid or do
they indicate the part being driven out of spec?  If it's out of spec
then it's better to exclude them since otherwise we might choose one of
those values when configuring a voltage which may not actually work as
desired.

--Z0LrZJXyjIRCPfH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJYXzIACgkQJNaLcl1U
h9DVtwf+N9TxlnsrmD3gmtxCP88m0egnYv2wkBye2EQazhLNwpw3ir6hRAh54lG6
ZPVc2dhUrXiqYmifTGW0F1AnVyAYXOD31TfaW8MWx+cKO8EHAZuZ/Ft6Z9zlfB/R
polfgdIRTOJO4v8IaMpqkOONxS1LIZydCm1bYE5l62EEq274JjQATq8bdEhA948q
ynBRZqLavYTLhXkY1mCVRcRAQq8XbINOfJZKFq8yMabTNVZcsKQcyv0WiIz4IUUl
UH22eoY865JPFP1X96inbbjc/S4eyoxKCNIb6zh3on2nask54GTsCtinjK5RyjZF
DfhZ7G4GwuUo3vgSAnWJ3uXIHqXXkg==
=Q53Z
-----END PGP SIGNATURE-----

--Z0LrZJXyjIRCPfH2--
