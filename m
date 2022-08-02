Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314A587815
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiHBHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiHBHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:43:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBD5FFA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:43:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImYu-0008Am-Fx; Tue, 02 Aug 2022 09:43:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImYt-001Gyn-88; Tue, 02 Aug 2022 09:43:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oImYs-0095Aa-FZ; Tue, 02 Aug 2022 09:43:30 +0200
Date:   Tue, 2 Aug 2022 09:43:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v7 2/4] riscv: dts: fix the icicle's #pwm-cells
Message-ID: <20220802074330.7t2hts2notnkqi4z@pengutronix.de>
References: <20220721172109.941900-1-mail@conchuod.ie>
 <20220721172109.941900-3-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dvf6lqbfzzk3r6w5"
Content-Disposition: inline
In-Reply-To: <20220721172109.941900-3-mail@conchuod.ie>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dvf6lqbfzzk3r6w5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 06:21:08PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> \#pwm-cells for the Icicle kit's fabric PWM was incorrectly set to 2 &
> blindly overridden by the (out of tree) driver anyway. The core can
> support inverted operation, so update the entry to correctly report its
> capabilities.
>=20
> Fixes: 72560c6559b8 ("riscv: dts: microchip: add fpga fabric section to i=
cicle kit")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/=
arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> index 0d28858b83f2..e09a13aef268 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
> @@ -8,7 +8,7 @@ core_pwm0: pwm@41000000 {
>  		compatible =3D "microchip,corepwm-rtl-v4";
>  		reg =3D <0x0 0x41000000 0x0 0xF0>;
>  		microchip,sync-update-mask =3D /bits/ 32 <0>;
> -		#pwm-cells =3D <2>;
> +		#pwm-cells =3D <3>;
>  		clocks =3D <&fabric_clk3>;
>  		status =3D "disabled";
>  	};

I checked there are no consumers that need adaption, so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dvf6lqbfzzk3r6w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLo1Z8ACgkQwfwUeK3K
7AlEFgf/Sta+4b8FYlEd9Z70dBteRo7hbecxnz0Be/nwzu84/H/hxb9OvVTPuLxp
w8HY3d6715d/tLRSUWz7LSYoOR0qY5UpagUXmeM+6rEo4upkTXGUiv9OKPgRexWm
9EOER7LyfpkxKlrwTTAxnm++/0T4i0/jLR8Zhw4bUIAMF1c5G+L47djtfNnM0wR4
XsWYg8w8CdtJAW5aAovncWsqjvErxvnKsvevxlLXcQHix3qnkN6M9nXI7v69xTjF
588x80wMV2cuwIRiikUmT8V56REcfd7z9V6yq5jWUvleSUquiqBRBSpGJOLZvPxV
Kw8T9sirrkNvHV1M5IDNWX4NpOS3xQ==
=6r+x
-----END PGP SIGNATURE-----

--dvf6lqbfzzk3r6w5--
