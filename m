Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B64C71A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiB1QY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiB1QYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:24:55 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE357B04;
        Mon, 28 Feb 2022 08:24:14 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 958ED240009;
        Mon, 28 Feb 2022 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646065453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yi9ZfPMOEyTeVpU8spZvuPWD3mx/s/KYTcIN/Bbr0g=;
        b=i9s8+jnvU0oIsuTwFiSwqlnfES0ZRvxQx1CCkP0P/6cCInQdlQAOxukYH3N4fhMe/QYRYy
        ET3PNmoVEtQwK0xAw7tLRhiVmUCqweOOj8+14p6UoJ5AD/20ytecX7R4dFN0kM5oCj6BSZ
        Mo7zAAYGqs626q+eYI0J7gFeAY7X/ILkskNluAtyXEnop6ZbOyVOo0YBcmvAzF80DnQXe9
        NQnEQK2Yx0ss6+cooViOnuLdNnMLfcaoHI5pSVSNIcYV5ijnioNVWVj75v2juFC6j9601M
        evf4dgsbq8l6EgZn344WlJglkeBpu9fcSNfh2m/rokFFdT/7Q2voKngpjaMSkw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
In-Reply-To: <20220215163926.894-1-paweldembicki@gmail.com>
References: <20220215163926.894-1-paweldembicki@gmail.com>
Date:   Mon, 28 Feb 2022 17:24:10 +0100
Message-ID: <87bkyr0xjp.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Dembicki <paweldembicki@gmail.com> writes:

> Ctera C200 V1 is kirkwood-based 2-Bay NAS.
>
> Hardware:
>   - SoC: Marvell 88F6281-A1 ARMv5TE Processor 1.2GHz
>   - Ram: 512MB (4x Nanya NT5TU128M8GE-AC)
>   - NAND Flash: 256MB (Samsung 216 K9F2G08U0C)
>   - Lan: 1x GBE (Marvell 88E1116R-NNC1)
>   - Storage: 2x SATA HDD 3.5" Slot
>   - USB: 2x USB 2.0 port
>   - Console: Internal J3 connector (1: Vcc, 2: Rx, 3: Tx, 4: GND)
>   - LEDs: 13x GPIO controlled
>   - Buttons: 2x GPIO controlled
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory
> ---
> v2:
> - removed 2x\n spacing issue
> - removed unused pcie node
> - made information about buzzer more comprehensive
>
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/kirkwood-c200-v1.dts | 310 +++++++++++++++++++++++++
>  2 files changed, 311 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-c200-v1.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 235ad559acb2..31616f6ae173 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -281,6 +281,7 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += \
>  dtb-$(CONFIG_MACH_KIRKWOOD) += \
>  	kirkwood-b3.dtb \
>  	kirkwood-blackarmor-nas220.dtb \
> +	kirkwood-c200-v1.dtb \
>  	kirkwood-cloudbox.dtb \
>  	kirkwood-d2net.dtb \
>  	kirkwood-db-88f6281.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-c200-v1.dts b/arch/arm/boot/dts/kirkwood-c200-v1.dts
> new file mode 100644
> index 000000000000..f59ff7578dfc
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-c200-v1.dts
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Ctera C200 V1 Board Description
> + * Copyright 2021-2022 Pawel Dembicki <paweldembicki@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Ctera C200 V1";
> +	compatible = "ctera,c200-v1", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +		stdout-path = &uart0;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_buttons>;
> +		pinctrl-names = "default";
> +
> +		power {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		reset {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		usb1 {
> +			label = "USB1 Button";
> +			linux,code = <BTN_0>;
> +			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		usb2 {
> +			label = "USB2 Button";
> +			linux,code = <BTN_1>;
> +			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_leds>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			function = LED_FUNCTION_DISK;
> +			function-enumerator = <2>;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_DISK;
> +			function-enumerator = <1>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			function = LED_FUNCTION_DISK;
> +			function-enumerator = <2>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			function = LED_FUNCTION_DISK;
> +			function-enumerator = <1>;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-5 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-6 {
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-7 {
> +			function = LED_FUNCTION_DISK_ERR;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-8 {
> +			function = LED_FUNCTION_DISK_ERR;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-9 {
> +			function = LED_FUNCTION_USB;
> +			function-enumerator = <1>;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-10 {
> +			function = LED_FUNCTION_USB;
> +			function-enumerator = <1>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "usbport";
> +			trigger-sources = <&hub_port2>;
> +		};
> +
> +		led-11 {
> +			function = LED_FUNCTION_USB;
> +			function-enumerator = <2>;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-12 {
> +			function = LED_FUNCTION_USB;
> +			function-enumerator = <2>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "usbport";
> +			trigger-sources = <&hub_port1>;
> +		};
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +};
> +
> +&eth0port {
> +	phy-handle = <&ethphy9>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rtc@30 {
> +		compatible = "s35390a";
> +		reg = <0x30>;
> +	};
> +
> +	lm63@4c {
> +		compatible = "national,lm63";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy9: ethernet-phy@9 {
> +		reg = <9>;
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	chip-delay = <40>;
> +
> +	partition@0 {
> +		label = "uboot";
> +		reg = <0x0000000 0x200000>;
> +	};
> +
> +	partition@200000 {
> +		label = "certificate";
> +		reg = <0x0200000 0x100000>;
> +	};
> +
> +	partition@300000 {
> +		label = "preset_cfg";
> +		reg = <0x0300000 0x100000>;
> +	};
> +
> +	partition@400000 {
> +		label = "dev_params";
> +		reg = <0x0400000 0x100000>;
> +	};
> +
> +	partition@500000 {
> +		label = "active_bank";
> +		reg = <0x0500000 0x0100000>;
> +	};
> +
> +	partition@600000 {
> +		label = "magic";
> +		reg = <0x0600000 0x0100000>;
> +	};
> +
> +	partition@700000 {
> +		label = "bank1";
> +		reg = <0x0700000 0x2800000>;
> +	};
> +
> +	partition@2f00000 {
> +		label = "bank2";
> +		reg = <0x2f00000 0x2800000>;
> +	};
> +
> +	/* 0x5700000-0x5a00000 undefined in vendor firmware */
> +
> +	partition@5a00000 {
> +		label = "reserved";
> +		reg = <0x5a00000 0x2000000>;
> +	};
> +
> +	partition@7a00000 {
> +		label = "rootfs";
> +		reg = <0x7a00000 0x8600000>;
> +	};
> +};
> +
> +&pinctrl {
> +	/* Buzzer gpios are connected to two pins of buzzer.
> +	 * This buzzer require a modulated signal from gpio.
> +	 * Leave it as is due lack of proper driver.
> +	 */
> +	pmx_buzzer: pmx-buzzer {
> +		marvell,pins = "mpp12", "mpp13";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_leds: pmx-leds {
> +		marvell,pins = "mpp14", "mpp15", "mpp16", "mpp17", "mpp38",
> +			       "mpp39", "mpp40", "mpp42", "mpp43", "mpp44",
> +			       "mpp45", "mpp46", "mpp47";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_buttons: pmx-buttons {
> +		marvell,pins = "mpp28", "mpp29", "mpp48", "mpp49";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_poweroff: pmx-poweroff {
> +		marvell,pins = "mpp34";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&rtc {
> +	status = "disabled";
> +};
> +
> +&sata {
> +	status = "okay";
> +	nr-ports = <2>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	port@1 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;
> +		#trigger-source-cells = <0>;
> +
> +		hub_port1: port@1 {
> +			reg = <1>;
> +			#trigger-source-cells = <0>;
> +		};
> +
> +		hub_port2: port@2 {
> +			reg = <2>;
> +			#trigger-source-cells = <0>;
> +		};
> +	};
> +};
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
