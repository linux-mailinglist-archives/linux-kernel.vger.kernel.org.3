Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0350E257
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiDYNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiDYNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:52:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB2D4A3EC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:49:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1niz5z-0005OC-Ou; Mon, 25 Apr 2022 15:49:43 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-c4ac-ed33-309c-93a8.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c4ac:ed33:309c:93a8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D301B6D38D;
        Mon, 25 Apr 2022 13:49:41 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:49:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 4/4] ARM: dts: stm32: add support for Protonic PRTT1x
 boards
Message-ID: <20220425134941.ja32c4o4gmz2og7v@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2ozjthum5titsva"
Content-Disposition: inline
In-Reply-To: <20220425132844.866743-5-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u2ozjthum5titsva
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.04.2022 15:28:44, Oleksij Rempel wrote:
> This boards are based on STM32MP151AAD3 and use 10BaseT1L for communicati=
on.
>=20
> - PRTT1C - 10BaseT1L switch
> - PRTT1S - 10BaseT1L CO2 sensor board
> - PRTT1A - 10BaseT1L multi functional controller
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile                |   3 +
>  arch/arm/boot/dts/stm32mp151a-prtt1a.dts  |  52 ++++
>  arch/arm/boot/dts/stm32mp151a-prtt1c.dts  | 304 ++++++++++++++++++++++
>  arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi | 229 ++++++++++++++++
>  arch/arm/boot/dts/stm32mp151a-prtt1s.dts  |  63 +++++
>  5 files changed, 651 insertions(+)
>  create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1a.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1c.dts
>  create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
>  create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1s.dts

[...]

> diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1c.dts b/arch/arm/boot/dts=
/stm32mp151a-prtt1c.dts
> new file mode 100644
> index 000000000000..0d542c8ff2c7
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp151a-prtt1c.dts
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright (C) Protonic Holland
> + * Author: David Jander <david@protonic.nl>
> + */
> +/dts-v1/;
> +
> +#include "stm32mp151a-prtt1l.dtsi"
> +
> +/ {
> +	model =3D "Protonic PRTT1C";
> +	compatible =3D "prt,prtt1c", "st,stm32mp151";
> +
> +	clock_ksz9031: clock-ksz9031 {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <25000000>;
> +	};
> +
> +	clock_sja1105: clock-sja1105 {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <25000000>;
> +	};
> +
> +	mdio0: mdio {
> +		compatible =3D "virtual,mdio-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		gpios =3D <&gpioc 1 GPIO_ACTIVE_HIGH
> +			 &gpioa 2 GPIO_ACTIVE_HIGH>;
> +
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&gpiod 8 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&ethernet0 {
> +	fixed-link {
> +		speed =3D <100>;
> +		full-duplex;
> +	};
> +};
> +
> +&gpioa {
> +	gpio-line-names =3D
> +		"", "", "", "PHY0_nRESET", "PHY0_nINT", "", "", "",
> +		"", "", "", "", "", "", "", "SPI1_nSS";
> +};
> +
> +&gpiod {
> +	gpio-line-names =3D
> +		"", "", "", "", "", "", "", "",
> +		"WFM_RESET", "", "", "", "", "", "", "";
> +};
> +
> +&gpioe {
> +	gpio-line-names =3D
> +		"SDMMC2_nRESET", "", "", "", "", "", "SPI1_nRESET", "",
> +		"", "", "", "", "WFM_nIRQ", "", "", "";
> +};
> +
> +&gpiog {
> +	gpio-line-names =3D
> +		"", "", "", "", "", "", "", "PHY3_nINT",
> +		"PHY1_nINT", "PHY3_nRESET", "PHY2_nINT", "PHY2_nRESET",
> +		"PHY1_nRESET", "SPE1_PWR", "SPE0_PWR", "";
> +};
> +
> +&mdio0 {
> +	/* All this DP83TD510E PHYs can't be probed before switch@0 is
> +	 * probed so we need to use compatible with PHYid
> +	 */
> +	/* TI DP83TD510E */
> +	t1l0_phy: ethernet-phy@6 {
> +		compatible =3D "ethernet-phy-id2000.0181";
> +		reg =3D <6>;
> +		interrupts-extended =3D <&gpioa 4 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&gpioa 3 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10>;
> +		reset-deassert-us =3D <35>;
> +	};
> +
> +	/* TI DP83TD510E */
> +	t1l1_phy: ethernet-phy@7 {
> +		compatible =3D "ethernet-phy-id2000.0181";
> +		reg =3D <7>;
> +		interrupts-extended =3D <&gpiog 8 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&gpiog 12 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10>;
> +		reset-deassert-us =3D <35>;
> +	};
> +
> +	/* TI DP83TD510E */
> +	t1l2_phy: ethernet-phy@10 {
> +		compatible =3D "ethernet-phy-id2000.0181";
> +		reg =3D <10>;
> +		interrupts-extended =3D <&gpiog 10 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&gpiog 11 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10>;
> +		reset-deassert-us =3D <35>;
> +	};
> +
> +	/* Micrel KSZ9031 */
> +	rj45_phy: ethernet-phy@2 {
> +		reg =3D <2>;
> +		interrupts-extended =3D <&gpiog 7 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios =3D <&gpiog 9 GPIO_ACTIVE_LOW>;
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <1000>;
> +
> +		clocks =3D <&clock_ksz9031>;
> +	};
> +};
> +
> +&qspi {
> +	status =3D "disabled";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names =3D "default", "opendrain", "sleep";
> +	pinctrl-0 =3D <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-1 =3D <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-2 =3D <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	no-1-8-v;
> +	st,neg-edge;
> +	bus-width =3D <8>;
> +	vmmc-supply =3D <&reg_3v3>;
> +	vqmmc-supply =3D <&reg_3v3>;
> +	status =3D "okay";
> +};
> +
> +&sdmmc2_b4_od_pins_a {
> +	pins1 {
> +		pinmux =3D <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> +			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
> +			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
> +			 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
> +	};
> +};
> +
> +&sdmmc2_b4_pins_a {
> +	pins1 {
> +		pinmux =3D <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
> +			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
> +			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
> +			 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
> +			 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
> +	};
> +};
> +
> +&sdmmc2_b4_sleep_pins_a {
> +	pins {
> +		pinmux =3D <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
> +			 <STM32_PINMUX('B', 7, ANALOG)>, /* SDMMC2_D1 */
> +			 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
> +			 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
> +			 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
> +			 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
> +	};
> +};
> +
> +&sdmmc2_d47_pins_a {
> +	pins {
> +		pinmux =3D <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
> +			 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
> +			 <STM32_PINMUX('C', 6, AF10)>, /* SDMMC2_D6 */
> +			 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
> +	};
> +};
> +
> +&sdmmc2_d47_sleep_pins_a {
> +	pins {
> +		pinmux =3D <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
> +			 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
> +			 <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC2_D6 */
> +			 <STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
> +	};
> +};
> +
> +&sdmmc3 {
> +	pinctrl-names =3D "default", "opendrain", "sleep";
> +	pinctrl-0 =3D <&sdmmc3_b4_pins_b>;
> +	pinctrl-1 =3D <&sdmmc3_b4_od_pins_b>;
> +	pinctrl-2 =3D <&sdmmc3_b4_sleep_pins_b>;
> +	non-removable;
> +	no-1-8-v;
> +	st,neg-edge;
> +	bus-width =3D <4>;
> +	vmmc-supply =3D <&reg_3v3>;
> +	vqmmc-supply =3D <&reg_3v3>;
> +        mmc-pwrseq =3D <&wifi_pwrseq>;

nitpick: use tabs here, too

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u2ozjthum5titsva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJmpvIACgkQrX5LkNig
010KJQf/QmHN00LnSjAnQ1qKZEmZkOIIlSRfbKPVZATT0Ce5Hjio0CJPML5rU9uk
+dooDHku2jtKLmjbltsnaHhr2Vf9U3TOo4gFmYU/hXL8SGreVmzXx7gXOoQ6AsVk
sVi5JYK8BS2Ii36NZxz/ht96gYwGRt82MmXQ7pgc+uku1KK5mFFpKdqNUe/aXSld
7G55b0AdxMNmHHlEnyOYxmoKCXgMBWzz8wNvG6SdRnFjeKys2WVvU0q4Jw4ylQ+s
XHfMGa4oYSgE3kIkN/E6zVmli8XoLoNUtDdGhwc3SG9Kj2sr7OOajh2j4jCA/kz3
tzL6ZAMc2bL2foqhK/UZNVNM0+LEIA==
=7/gx
-----END PGP SIGNATURE-----

--u2ozjthum5titsva--
