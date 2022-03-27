Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67AC4E89BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiC0TdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiC0TdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:33:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330374FC5E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:31:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so17457960wru.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hy4/6Wvq0UdELP4aq9Uw/sLZZFUH1KGgaFY/LG2iio0=;
        b=czff9Gb+Oo3rAM3befRdnSu7+cz6Su32EVblvP3PjUnXNbB7F5DQ83ho7gTqDtHkx5
         WA5s9dfStTyxZkW2wh24GqNIApJft43quFXMipiqA9LlqjGp4+0xggMeHU0nyWhvd4Dx
         cQKta/CC/l8YMGXSCymTzQ8B8QXf73spmwSGyVgfLr1HF8bEXEyRSkEqc5SjyLOf3zEM
         0hE52u50i8PSJr/3cIn9J7hnkfHi2jLj3WSDH2wDYQiO7s+1OH7CeGmkbN9OvRnydND3
         wTbhL3OdVgq/YVsmFIPkWTQ+4a4Lx87z0mdleI6la4bsvfwB9Qua/8uzdlVzCpatGF7h
         F3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hy4/6Wvq0UdELP4aq9Uw/sLZZFUH1KGgaFY/LG2iio0=;
        b=UtM7yJ2UJSxW77G29O/xxjMfSe4rH3U35RW34a2Pu5fNFfmYCb1G2o/Z4WQESA5uhn
         UbaZZZUgbB0771IEluWyNACk7t8zFoWL2f16+d3dtbR8AXHJ9F5NUJ9hC+ngo4HQ4juf
         27DvBJ8ndrlLXpOV8EUWv7QGgpW9rIOiBpEbthgutg1SbZHIhB5v7YiproJ99LEF/E5/
         GqJybTxck2A56MdSB0/bsokFCGxnE+CE5TYHKaiNvBnoyv6pkYF0nFewqKWu/q90J3JI
         0515OfXqoxm4RruNupsCQkM17SK9K2AX1AuGzABmaub7PivA3/PaiF9wE/IdRp/MQqbt
         6znw==
X-Gm-Message-State: AOAM531kibfyhIqg9Bh7EsRSvT4jbniPogJXg7dj4iRfT2pcrLtmHQPs
        EyKMFtZrOyg7SduhuIaljzdYUGEQQTNqVg==
X-Google-Smtp-Source: ABdhPJxVxR1HVxiCZyykRZZA3/NUiWyeY/R3JaVGss8sVFwZBSDGe9bcaHjv9C95sUFt8pOUC+AZWA==
X-Received: by 2002:a05:6000:18a8:b0:203:eb58:9733 with SMTP id b8-20020a05600018a800b00203eb589733mr18830162wri.151.1648409492650;
        Sun, 27 Mar 2022 12:31:32 -0700 (PDT)
Received: from radium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm9960240wmh.31.2022.03.27.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 12:31:32 -0700 (PDT)
Date:   Sun, 27 Mar 2022 21:31:29 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
Message-ID: <20220327193129.35udqbeb7dhux2go@radium>
References: <20220327165837.3048639-1-fparent@baylibre.com>
 <20220327165837.3048639-3-fparent@baylibre.com>
 <6ba2ffc8-455d-d689-723e-59a29b23a597@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bxnmf25erbodzaih"
Content-Disposition: inline
In-Reply-To: <6ba2ffc8-455d-d689-723e-59a29b23a597@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bxnmf25erbodzaih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sun, Mar 27, 2022 at 08:52:41PM +0200, Krzysztof Kozlowski wrote:
> On 27/03/2022 18:58, Fabien Parent wrote:
> > Add basic device-tree for the MT8195 Demo board. The
> > Demo board is made by MediaTek and has a MT8195 SoC,
> > associated with the MT6359 and MT6360 PMICs, and
> > the MT7921 connectivity chip.
> >=20
> > The IOs available on that board are:
> > * 1 USB Type-C connector with DP aux mode support
> > * 1 USB Type-A connector
> > * 1 full size HDMI RX and 1 full size HDMI TX connector
> > * 1 uSD slot
> > * 40 pins header
> > * SPI interface header
> > * 1 M.2 slot
> > * 1 audio jack
> > * 1 micro-USB port for serial debug
> > * 2 connectors for DSI displays
> > * 3 connectors for CSI cameras
> > * 1 connector for a eDP panel
> > * 1 MMC storage
> >=20
> > This commit adds basic support in order to be able to boot.
> >=20
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> > This patch depends on the following patches:
> > [0] https://patchwork.kernel.org/project/linux-mediatek/patch/162201192=
7-359-9-git-send-email-hsin-hsiung.wang@mediatek.com/
> > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/202202161=
13131.13145-4-tinghan.shen@mediatek.com/
> >=20
> >  arch/arm64/boot/dts/mediatek/Makefile        |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 539 +++++++++++++++++++
> >  2 files changed, 540 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
> > index 5da29e7223e4..c7d4636a2cb7 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-s=
ku0.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8195-demo.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8195-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8516-pumpkin.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/=
boot/dts/mediatek/mt8195-demo.dts
> > new file mode 100644
> > index 000000000000..f486cdf7e22b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > @@ -0,0 +1,539 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2022 BayLibre, SAS.
> > + * Author: Fabien Parent <fparent@baylibre.com>
> > + */
> > +/dts-v1/;
> > +
> > +#include "mt8195.dtsi"
> > +#include "mt6359.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> > +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> > +
> > +/ {
> > +	model =3D "MediaTek MT8195 demo board";
> > +	compatible =3D "mediatek,mt8195-demo", "mediatek,mt8195";
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:921600n8";
> > +	};
> > +
> > +	memory@40000000 {
> > +		device_type =3D "memory";
> > +		reg =3D <0 0x40000000 0 0x80000000>;
> > +	};
> > +
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		/* 12 MiB reserved for OP-TEE (BL32)
> > +		 * +-----------------------+ 0x43e0_0000
> > +		 * |      SHMEM 2MiB       |
> > +		 * +-----------------------+ 0x43c0_0000
> > +		 * |        | TA_RAM  8MiB |
> > +		 * + TZDRAM +--------------+ 0x4340_0000
> > +		 * |        | TEE_RAM 2MiB |
> > +		 * +-----------------------+ 0x4320_0000
> > +		 */
> > +		optee_reserved: optee@43200000 {
> > +			no-map;
> > +			reg =3D <0 0x43200000 0 0x00c00000>;
> > +		};
> > +
> > +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
> > +		bl31_secmon_reserved: secmon@54600000 {
> > +			no-map;
> > +			reg =3D <0 0x54600000 0x0 0x30000>;
> > +		};
> > +	};
> > +
> > +	firmware {
> > +		optee {
> > +			compatible =3D "linaro,optee-tz";
> > +			method =3D "smc";
> > +		};
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible =3D "gpio-keys";
> > +		input-name =3D "gpio-keys";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&gpio_keys>;
> > +
> > +		volume-up {
>=20
> Generic node names, so "key" or "key-0"
>=20
> > +			gpios =3D <&pio 106 GPIO_ACTIVE_LOW>;
> > +			label =3D "volume_up";
> > +			linux,code =3D <KEY_VOLUMEUP>;
> > +			wakeup-source;
> > +			debounce-interval =3D <15>;
> > +		};
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&uart0_pins>;
> > +	status =3D "okay";
> > +};
> > +
> > +&mmc0 {
> > +	status =3D "okay";
> > +	pinctrl-names =3D "default", "state_uhs";
> > +	pinctrl-0 =3D <&mmc0_pins_default>;
> > +	pinctrl-1 =3D <&mmc0_pins_uhs>;
> > +	bus-width =3D <8>;
> > +	max-frequency =3D <200000000>;
> > +	cap-mmc-highspeed;
> > +	mmc-hs200-1_8v;
> > +	mmc-hs400-1_8v;
> > +	cap-mmc-hw-reset;
> > +	no-sdio;
> > +	no-sd;
> > +	hs400-ds-delay =3D <0x14c11>;
> > +	vmmc-supply =3D <&mt6359_vemc_1_ldo_reg>;
> > +	vqmmc-supply =3D <&mt6359_vufs_ldo_reg>;
> > +	non-removable;
> > +};
> > +
> > +&pmic {
> > +	interrupt-parent =3D <&pio>;
> > +	interrupts =3D <222 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&i2c0 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-0 =3D <&i2c0_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
>=20
> What's attached here? Enabling empty i2c controller?

It is attached to CSI cameras but the CSI IP is not yet supported on MT8195=
=2E I will remove the node for the time being.

>=20
> > +};
> > +
> > +&i2c1 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-0 =3D <&i2c1_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
>=20
> What's attached here? Enabling empty i2c node?

It is also attached to CSI cameras but the CSI IP is not yet supported on M=
T8195. I will remove the node for the time being.
=20
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-0 =3D <&i2c2_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
>=20
> What's attached here? Enabling empty i2c node?

It is attached to an IT5205 chip which is not yet supported upstream. I wil=
l remove the node for the time being.
=20
> > +};
> > +
> > +&i2c6 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-0 =3D <&i2c6_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
> > +
> > +	mt6360: mt6360@34 {
>=20
> Generic node names, so "pmic"?
>=20
> > +		compatible =3D "mediatek,mt6360";
> > +		reg =3D <0x34>;
> > +		interrupt-controller;
> > +		interrupt-parent =3D <&pio>;
> > +		interrupts =3D <101 IRQ_TYPE_EDGE_FALLING>;
> > +		interrupt-names =3D "IRQB";
> > +
> > +		charger {
> > +			compatible =3D "mediatek,mt6360-chg";
> > +			richtek,vinovp-microvolt =3D <14500000>;
> > +
> > +			otg_vbus_regulator: usb-otg-vbus-regulator {
> > +				regulator-compatible =3D "usb-otg-vbus";
> > +				regulator-name =3D "usb-otg-vbus";
> > +				regulator-min-microvolt =3D <4425000>;
> > +				regulator-max-microvolt =3D <5825000>;
> > +			};
> > +		};
> > +
> > +		regulator {
> > +			compatible =3D "mediatek,mt6360-regulator";
> > +			LDO_VIN3-supply =3D <&mt6360_buck2>;
> > +
> > +			mt6360_buck1: buck1 {
> > +				regulator-compatible =3D "BUCK1";
> > +				regulator-name =3D "mt6360,buck1";
> > +				regulator-min-microvolt =3D <300000>;
> > +				regulator-max-microvolt =3D <1300000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP
> > +							   MT6360_OPMODE_ULP>;
> > +				regulator-always-on;
> > +			};
> > +
> > +			mt6360_buck2: buck2 {
> > +				regulator-compatible =3D "BUCK2";
> > +				regulator-name =3D "mt6360,buck2";
> > +				regulator-min-microvolt =3D <300000>;
> > +				regulator-max-microvolt =3D <1300000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP
> > +							   MT6360_OPMODE_ULP>;
> > +				regulator-always-on;
> > +			};
> > +
> > +			mt6360_ldo1: ldo1 {
> > +				regulator-compatible =3D "LDO1";
> > +				regulator-name =3D "mt6360,ldo1";
> > +				regulator-min-microvolt =3D <1200000>;
> > +				regulator-max-microvolt =3D <3600000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +			};
> > +
> > +			mt6360_ldo2: ldo2 {
> > +				regulator-compatible =3D "LDO2";
> > +				regulator-name =3D "mt6360,ldo2";
> > +				regulator-min-microvolt =3D <1200000>;
> > +				regulator-max-microvolt =3D <3600000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +			};
> > +
> > +			mt6360_ldo3: ldo3 {
> > +				regulator-compatible =3D "LDO3";
> > +				regulator-name =3D "mt6360,ldo3";
> > +				regulator-min-microvolt =3D <1200000>;
> > +				regulator-max-microvolt =3D <3600000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +			};
> > +
> > +			mt6360_ldo5: ldo5 {
> > +				regulator-compatible =3D "LDO5";
> > +				regulator-name =3D "mt6360,ldo5";
> > +				regulator-min-microvolt =3D <2700000>;
> > +				regulator-max-microvolt =3D <3600000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +			};
> > +
> > +			mt6360_ldo6: ldo6 {
> > +				regulator-compatible =3D "LDO6";
> > +				regulator-name =3D "mt6360,ldo6";
> > +				regulator-min-microvolt =3D <500000>;
> > +				regulator-max-microvolt =3D <2100000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +			};
> > +
> > +			mt6360_ldo7: ldo7 {
> > +				regulator-compatible =3D "LDO7";
> > +				regulator-name =3D "mt6360,ldo7";
> > +				regulator-min-microvolt =3D <500000>;
> > +				regulator-max-microvolt =3D <2100000>;
> > +				regulator-allowed-modes =3D <MT6360_OPMODE_NORMAL
> > +							   MT6360_OPMODE_LP>;
> > +				regulator-always-on;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&spi2 {
> > +	pinctrl-0 =3D <&spi2_pins>;
> > +	pinctrl-names =3D "default";
> > +	mediatek,pad-select =3D <0>;
> > +	status =3D "okay";
>=20
> What is attached here? Empty SPI?

The SPI lines goes to a connector. Given that it is not really usable as-is=
 without either a specific device node or a spidev node, I will just remove=
 it.

>=20
>=20
> > +};
> > +
> > +&mt6359_vgpu11_buck_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vsram_others_ldo_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vpu_buck_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vcore_buck_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vproc1_buck_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vproc2_buck_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vsram_md_ldo_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vbbck_ldo_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mt6359_vrf12_ldo_reg {
> > +	regulator-always-on;
> > +};
> > +
> > +&mmc1 {
>=20
> Any reasons to have all overrides/labels ordered randomly? I am not
> dreaming about alphabetical order, but at least some logical, so mmc1
> next to mmc0...
>=20
> > +	pinctrl-names =3D "default", "state_uhs";
> > +	pinctrl-0 =3D <&mmc1_pins_default>;
> > +	pinctrl-1 =3D <&mmc1_pins_uhs>;
> > +	cd-gpios =3D <&pio 129 GPIO_ACTIVE_LOW>;
> > +	bus-width =3D <4>;
> > +	max-frequency =3D <200000000>;
> > +	cap-sd-highspeed;
> > +	sd-uhs-sdr50;
> > +	sd-uhs-sdr104;
> > +	vmmc-supply =3D <&mt6360_ldo5>;
> > +	vqmmc-supply =3D <&mt6360_ldo3>;
> > +	status =3D "okay";
> > +};
> > +
> > +&xhci0 {
> > +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +	vbus-supply =3D <&otg_vbus_regulator>;
> > +	status =3D "okay";
> > +};
> > +
> > +&xhci1 {
> > +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +	status =3D "okay";
> > +};
> > +
> > +&xhci2 {
> > +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +	status =3D "okay";
> > +};
> > +
> > +&xhci3 {
> > +	vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> > +	status =3D "okay";
> > +};
> > +
> > +&u3phy0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&u3phy1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&u3phy2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&u3phy3 {
> > +	status =3D "okay";
> > +};
> > +
> > +&pio {
> > +	mmc0_pins_default: mmc0default {
> > +		pins_cmd_dat {
>=20
> No underscores in node names. Hyphens are accepted.
>=20
> Same in all other cases below.
>=20
> > +			pinmux =3D <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> > +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> > +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> > +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> > +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> > +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> > +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> > +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> > +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <MTK_DRIVE_6mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins_clk {
> > +			pinmux =3D <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> > +			drive-strength =3D <MTK_DRIVE_6mA>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins_rst {
> > +			pinmux =3D <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> > +			drive-strength =3D <MTK_DRIVE_6mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +	};
> > +
> > +	mmc0_pins_uhs: mmc0uhs{
> > +		pins_cmd_dat {
> > +			pinmux =3D <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> > +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> > +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> > +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> > +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> > +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> > +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> > +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> > +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> > +			input-enable;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins_clk {
> > +			pinmux =3D <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins_ds {
> > +			pinmux =3D <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins_rst {
> > +			pinmux =3D <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +	};
> > +
> > +	mmc1_pins_default: mmc1-pins-default {
> > +		pins_cmd_dat {
> > +			pinmux =3D <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> > +				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> > +				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> > +				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> > +				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> > +			input-enable;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins_clk {
> > +			pinmux =3D <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +
> > +		pins_insert {
> > +			pinmux =3D <PINMUX_GPIO129__FUNC_GPIO129>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	mmc1_pins_uhs: mmc1-pins-uhs {
>=20
> Any reason keeping it inconsistent with mmc0 about naming? I mean... why
> having one naming pattern for mmc0 and entirely different for mmc1? Why
> i2c ends with "-pins" suffix and these do not?
>=20
> > +		pins_cmd_dat {
> > +			pinmux =3D <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> > +				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> > +				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> > +				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> > +				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> > +			input-enable;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +		};
> > +
> > +		pins_clk {
> > +			pinmux =3D <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > +		};
> > +	};
> > +
> > +	i2c0_pins: i2c0-pins {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO8__FUNC_SDA0>,
> > +				 <PINMUX_GPIO9__FUNC_SCL0>;
> > +			bias-pull-up;
> > +			mediatek,rsel =3D <MTK_PULL_SET_RSEL_111>;
> > +			mediatek,drive-strength-adv =3D <7>;
> > +		};
> > +	};
> > +
> > +	i2c1_pins: i2c1-pins {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO10__FUNC_SDA1>,
> > +				 <PINMUX_GPIO11__FUNC_SCL1>;
> > +			bias-pull-up;
> > +			mediatek,rsel =3D <MTK_PULL_SET_RSEL_111>;
> > +			mediatek,drive-strength-adv =3D <7>;
> > +		};
> > +	};
> > +
> > +	i2c2_pins: i2c2-pins {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO12__FUNC_SDA2>,
> > +				 <PINMUX_GPIO13__FUNC_SCL2>;
> > +			bias-pull-up;
> > +			mediatek,rsel =3D <MTK_PULL_SET_RSEL_111>;
> > +			mediatek,drive-strength-adv =3D <7>;
> > +		};
> > +	};
> > +
> > +	i2c6_pins: i2c6-pin {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO25__FUNC_SDA6>,
> > +				 <PINMUX_GPIO26__FUNC_SCL6>;
> > +			bias-pull-up;
> > +			mediatek,rsel =3D <MTK_PULL_SET_RSEL_111>;
> > +		};
> > +	};
> > +
> > +	spi2_pins: spi-pins {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO140__FUNC_SPIM2_CSB>,
> > +				 <PINMUX_GPIO141__FUNC_SPIM2_CLK>,
> > +				 <PINMUX_GPIO142__FUNC_SPIM2_MO>,
> > +				 <PINMUX_GPIO143__FUNC_SPIM2_MI>;
> > +			bias-disable;
> > +		};
> > +	};
> > +
> > +	pcie0_pins_default: pcie0default {
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO19__FUNC_WAKEN>,
> > +				 <PINMUX_GPIO20__FUNC_PERSTN>,
> > +				 <PINMUX_GPIO21__FUNC_CLKREQN>;
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	pcie1_pins_default: pcie1default {
>=20
> No pins suffix? One more pattern of naming...
>=20
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO22__FUNC_PERSTN_1>,
> > +				 <PINMUX_GPIO23__FUNC_CLKREQN_1>,
> > +				 <PINMUX_GPIO24__FUNC_WAKEN_1>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		mt7921 {
> > +			pinmux =3D <PINMUX_GPIO65__FUNC_GPIO65>,
> > +				 <PINMUX_GPIO67__FUNC_GPIO67>;
> > +			output-high;
> > +		};
> > +	};
> > +
> > +	gpio_keys: gpio-keys {
>=20
> gpio-keys-pins
>=20
> > +		pins {
> > +			pinmux =3D <PINMUX_GPIO106__FUNC_GPIO106>;
> > +			input-enable;
> > +		};
> > +	};
> > +
>=20
> Best regards,
> Krzysztof

Thanks for the review. All these remarks will be fixed in v2.

Fabien

--bxnmf25erbodzaih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmJAu4wACgkQVJKc6g3C
eABTXA//bj5Le/WXuPjgc5J9tCiCdsZyVx9vVY+RXvCq0K7FwOuJTvN745EvwHK4
OGWJ6B+QVxcYAra8pd63gn0mW1e5OGzBAe//XFn0D8aW9KsZhlp6LErgrjVQepTM
/KxPbDk6EfWPfSjeQvc9ZJsiVut8e412tYT0q1Nj71/Dh7dqMCxLwoiHeX/1GpFf
+QboQpBKeZSgkXcJBgj7xQhmHf5x68FGuVIb7fd2xRItoSzQw9g4NT7fJXylUEJl
cC5le4cDWRM5K3+X/el6mFKOZFY5bIU6NymsgS16VQejyIGgyA4zFTSlgtx8JI74
kE0jme0Wo43a+qemk7SX2qmP1XICHGshzNNDBiT9DGP2MwqrY5/cXQe10ZAEFCVa
mvOgcqS0C1E3Ll68oB8UbcIPgckER/9ZLFY97J7K7PW1yH/aMb5P7YUK/rGD6Ven
UuKboLN9KA41/2KBzpz99O/ckzzUbpZkohepMVJ69dv/4NMf6DmniWpkZMc5mjcz
j+tNXs1mQx2TZLW9ZCyPLixTbFJI6XHhy0+It9EJVChPBNDSv/rk43VznP36Cek9
IdA/TR7Et0QRFCwYkYhrFozW0LwFeQbn7RKqkBGkEK7ip9FRXW9TPbNc5Rxg98c/
cwuXzpE8IgigP6QAWHaVSTN9Li4P/4R+kDD9IUfD+59L1Dupo3w=
=FB9G
-----END PGP SIGNATURE-----

--bxnmf25erbodzaih--
