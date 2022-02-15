Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47E4B7575
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiBOSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:25:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBOSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:25:37 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1A119870;
        Tue, 15 Feb 2022 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gpNoHu8xRqK/xgxz/TT1jYehW6gGXstAod8rAWkCZes=; b=dEujVucqTUYLncoJeeh6xGjraG
        sgbMO8nHe8qr8CS4baDInDRKUHiIXtFy64ovXBsmNeP0oi54FV8NoFDDEuMidTiXnTQKlzy0OM7/j
        SnNs+Eq2SEsrr8UD81VC2XO9fd5QMn8fYcaHxeUTX9sibvmTh1T1SrOpg8k6gZEuouug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nK2VY-0066yE-OY; Tue, 15 Feb 2022 19:25:00 +0100
Date:   Tue, 15 Feb 2022 19:25:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
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
Message-ID: <Ygvv/CWUYumhKoCh@lunn.ch>
References: <20220215163926.894-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215163926.894-1-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:39:22PM +0100, Pawel Dembicki wrote:
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
> ---
> v2:
> - removed 2x\n spacing issue
> - removed unused pcie node
> - made information about buzzer more comprehensive

Hi Pawel

Thanks for adding the mvebu Maintainers to the list of recipients.

One more process point. It would be normal to set the To: to whoever
you think should actually accept this patch. There are a lot of
Maintainers listed in Cc: so actually pointing a finger at somebody
can help.

Gregory will be the person to actually take this patch.

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

Thanks for adding a comment. So you need something like a PWM driving
it? Have you tried playing with drivers/input/misc/pwm-beeper.c ?
Some of the mvebu family have a simple PWM functionality as part of
the GPIO controller. I don't remember if kirkwood has this.

    Andrew
