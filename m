Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971B750E7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiDYSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiDYSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:17:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884EC111C9D;
        Mon, 25 Apr 2022 11:14:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6AD461F434BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650910449;
        bh=+vu9o/CZqfUNibXQvmDVF1hJUAxnBrwgimcD4Mba0jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZP6K7KzwXEVNKX2HyZ4QUjuyvzf5FJtDVgmPzM59lSh9nWsbRBHoQRFzmZhJomtvL
         3vzoqEUiOJN2OneraErip2kP0JuEJOAumCMXzhtSeJqgF+OLAWrnnJ3H5MD7otLS05
         gwAxQx+7LLLz311DagC1dLTqdllw1/mdv7PN96fkMaNJt8MyN9V8VESrXH61uMCVz7
         Ag0Cm514lQ8yY2GxR7+2+/YDQL3TvoDZ3unHc1AyWnXJ6D/Ny0KO6KB5BJInKtQWjZ
         DP/15us/pwd7bVI0bs+P1SROGYTG8hbrXLjibw5xymsy5HB5K1/ozkXIgPKdMdfSzy
         Hi0PDIMXyQ3ag==
Received: by mercury (Postfix, from userid 1000)
        id 5A3741060431; Mon, 25 Apr 2022 20:14:07 +0200 (CEST)
Date:   Mon, 25 Apr 2022 20:14:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv1 18/19] arm64: dts: rockchip: Add base DT for rk3588 SoC
Message-ID: <20220425181407.lknemxqooz7yidcz@mercury.elektranox.org>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-19-sebastian.reichel@collabora.com>
 <36551341-60f5-8b61-59d1-176ece8204d6@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mh7nzemffealimob"
Content-Disposition: inline
In-Reply-To: <36551341-60f5-8b61-59d1-176ece8204d6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mh7nzemffealimob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for having a look.

On Fri, Apr 22, 2022 at 07:16:13PM +0100, Robin Murphy wrote:
> On 2022-04-22 18:09, Sebastian Reichel wrote:
> > ...
> > +		cpu_l0: cpu@0 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a55";
> > +			reg =3D <0x0>;
> > +			enable-method =3D "psci";
> > +			capacity-dmips-mhz =3D <530>;
> > +			clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> > +			i-cache-size =3D <32768>;
> > +			i-cache-line-size =3D <64>;
> > +			i-cache-sets =3D <128>;
> > +			d-cache-size =3D <32768>;
> > +			d-cache-line-size =3D <64>;
> > +			d-cache-sets =3D <128>;
> > +			next-level-cache =3D <&l2_cache_l0>;
> > +			#cooling-cells =3D <2>;
> > +			dynamic-power-coefficient =3D <228>;
> > +		};
>=20
> Is there any particular reason for not including more of the CPUs?

Yes, see below.

> > +		its: interrupt-controller@fe640000 {
> > +			compatible =3D "arm,gic-v3-its";
> > +			msi-controller;
> > +			#msi-cells =3D <1>;
> > +			reg =3D <0x0 0xfe640000 0x0 0x20000>;
> > +		};
> > +	};
>=20
> Does the ITS (and other bits related to GIC memory accesses) actually wor=
k,
> or will we have more of the same issues as RK356x?

The GIC in RK3588 is has the same shareability limitation as the RK356x,
but fixed the 32bit limitation. That's why I just added the boot cpu core
for now; adding any other cpu core breaks the boot without the downstream
shareability patch and I'm still investigating.

-- Sebastian

--mh7nzemffealimob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJm5OcACgkQ2O7X88g7
+pomsA//UD8f1YBkOw4gRGQyVzSSA2PqMAMOONSb31R90fNo5c78tg87EkNoxwvg
2iPkn4dnvOSE5zpTt4U579b1wyrlxU3msJBN+pwcyWTAQW8XNLt/Le/9zU3Laafa
4KyT4xJd9rrU4GMEvW+6RrmWJE3tcUYEw59a2BN40LYoQIayi864EwGIgD3z1XG7
MAqdI1on6d4XFD6mGu7uJSvfodEnCqjRIbv1tk/+2UCw9IhyWrhveJsagLEBn8GY
6SRfLMkMU9Ja6oqnDHmoj6WfrTaihFhbx3xS0gm9gErdrfaqxbcG6jsgFTT6nDQ1
xRSenEAPlxMK7EOiejVfE5Fs5Se8Tse/HLseVGSvkJv01wVj1yMO+ex2XUk5cGjW
UecLNiZfWL039S0F2Jaiqw9FrCmGbgpWB7yvg9mczuO2ewG3NORzh//fhSokCjXs
Yl247K8Q9jtsqYJRFBTh0A0mO8EG3PY9lYjzc96FeIWoza5beKSW/t8KU1LXWwb+
fSroO0KBa2oeajwhLvYi/cmZnKaPWr05H18Rsgudq+DmKHi82yWX6YslxXk2JVuN
F2ihbx0Yst3xUD4UIgiD06H2xPo1ufk3ZqdsENgIiVpn284n8VV7lYZyToczMJF2
OzPacQ4N7iJy+KxEcH26FyUhylu29QIf2L8kwKW/xnzYKmidA9A=
=vp9R
-----END PGP SIGNATURE-----

--mh7nzemffealimob--
