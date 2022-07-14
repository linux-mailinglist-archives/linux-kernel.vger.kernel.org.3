Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169E5746CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiGNIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGNIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:34:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E839BB8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:34:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so1622164lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4xLuY/mZht9aKaSfaW7ySnskcmQPZjuuzdZlfu3JUC8=;
        b=VUIicD2RrM7dbWi3Gln7WDU1ep7l2BsylgCovpjeJ/dA5YHH3cP/JJJOBQvKoGk2qJ
         H48O3tbH0I9zefs9cVz4swqyUEadkel1MuKesqXXSozqGgdE1OKAQNzM+mRpd7uF2maq
         Q7l5KajA+Qe9MGPe4aZSz+asvjpKVwNgvEPUp43Auk2atxeBFyXCQy9i1FdNVpUzs3Iv
         HwVlT5PkMcRw31/4rEa1ZrYeERYxbcy19YUaVnUF49UAytYQB/GbF1s188PoduXNnUJO
         ByxE3mAE/h6TI/3kwR/DmkLvNjqFvqR1t/GCdgXUjlTSjNeWQH6eob8yrssGwU08eKQi
         43BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4xLuY/mZht9aKaSfaW7ySnskcmQPZjuuzdZlfu3JUC8=;
        b=pM58l/uAvpxn+ok4wFGJRoLE6WFTvRPftSTa8X1QbDIUyLbv/mfxJ84RLbrJEf5Bf2
         X4pH7ObMx4W1yj4NJKDn/l60aU3MwLHfQEbJDNtvCzHeI/t4aVEGGM6GbHKUs4Zl5i9I
         dQu3EWYjUfeZMvGYGAVRstv+7LaOqTQF1YfzHXqAz7UzZ9kEcXj1eRUOmnKlwaNh5YlD
         tgd9HS+YzeAiGFZKGJdGyfOfYcCciuY+lCJINiMP1LPh3nsiUzCz4ntkL23Pai3HjlU5
         8mL4N4Fd12JYW/IE9y5Q+z4B333rC1HkCcpiUD39gGYeiea6OFE7SdWvGZ4uGoIu/Dok
         lxRw==
X-Gm-Message-State: AJIora8PiaVwcsUWcjVeHdikZrHzGmAFLH9XPza+hWfNPwlWgK4xr0NR
        evNEqqmKaZN/fyWFSJ2fuxq9fA==
X-Google-Smtp-Source: AGRyM1vIe0xKKz3SZWmQJ1qbbarr9RLQfkSvN/6wjKO2qq/EjZqCsPZpHf4M8rOWhpL1Yr0b7TeP9g==
X-Received: by 2002:a05:6512:1319:b0:482:b8ce:a278 with SMTP id x25-20020a056512131900b00482b8cea278mr4618250lfu.8.1657787653830;
        Thu, 14 Jul 2022 01:34:13 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z6-20020a195046000000b0047f59336d6asm236289lfj.179.2022.07.14.01.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:34:06 -0700 (PDT)
Message-ID: <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
Date:   Thu, 14 Jul 2022 10:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
Content-Language: en-US
To:     Kris Bahnsen <kris@embeddedTS.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
References: <20220713221233.8486-1-kris@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713221233.8486-1-kris@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 00:12, Kris Bahnsen wrote:
> Add initial support of the i.MX6UL based TS-7553-V2 platform.

Use subject prefix matching the subsystem. git log --oneline --

> 
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
> 
> V1->V2: Implement changes recommended by Rob Herring and dtbs_check
> 
> RFC only, not yet ready to merge, more testing needed and we're working on
> SPI LCD support for this platform.
> 
> Specifically, I have a few questions on some paradigms and dtbs_check output:
> 
> imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ... \
> 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], 'reg': [[12]]}}}} \
> is not of type 'array'
>   I'm not sure what this error is referring to as I've copied the example in
>   invensense,mpu6050.yaml almost verbatim. Is this an issue with our patch
>   or a false positive from dtbs_check?

You would need to paste entire error, maybe with checker flags -v.

> 
> 
> imx6ul-ts7553v2.dtb: spi@2010000: spidev@1: 'compatible' is a required property
>   Many of our devices have open-ended I2C and SPI ports that may or may not be
>   used in customer applications. With "spidev" compatible string no longer
>   supported, there is no easy way we know of to leave a placeholder or
>   indication that the interface is present, usable, and either needs specific
>   support enabled in kernel or userspace access via /dev/. We would love
>   feedback on how to handle this situation when submitting platforms upstream.

No empty devices, especially for spidev in DTS. There is really no
single need to add fake spidev... really, why? The customer cannot read
hardware manual and cannot see the header on the board? You can give him
a tutorial/howto guide, but don't embed dead or non-real code in DTS.

> 
> 
> imx6ul-ts7553v2.dtb: wifi@0: compatible:0: 'microchip,wilc1000' was expected
> imx6ul-ts7553v2.dtb: wifi@0: compatible: ['microchip,wilc3000'...] is too long
> imx6ul-ts7553v2.dtb: wifi@0: 'chip_en-gpios' does not match any of the \
> regexes: pinctrl-[0-9]+'
>   As noted in the comments in the dts, the WILC1000 in-kernel driver doesn't
>   support the BLE features of the WILC3000. We maintain an external module
>   tree that lets us build Microchip's official driver with WILC3000 support.
>   Would the extraneous compatible string and property be accepted upstream
>   in light of this?

No. No undocumented comaptibles with some wrong properties. chip_en is
clearly wrong, so it cannot go to DTS. Upstream driver or remove the node.

> 
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml |    1 +

This is a separate patch.

>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/boot/dts/imx6ul-ts7553v2.dts          |  693 ++++++++++
>  arch/arm/configs/ts7970_defconfig              | 1627 ++++++++++++++++++++++++
>  arch/arm/configs/tsimx6ul_defconfig            |  967 ++++++++++++++

This as well (and won't be accepted - no new defconfigs).

>  5 files changed, 3289 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ts7553v2.dts
>  create mode 100644 arch/arm/configs/ts7970_defconfig
>  create mode 100644 arch/arm/configs/tsimx6ul_defconfig
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ef524378d449..05a4e5b39835 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -559,6 +559,7 @@ properties:
>                - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
>                - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
>                - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
> +              - technologic,ts7553v2      # embeddedTS TS-7553-V2
>            - const: fsl,imx6ul
>  
>        - description: i.MX6UL Armadeus Systems OPOS6UL SoM Board
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..72a26abafaa9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -709,6 +709,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-phytec-segin-ff-rdk-emmc.dtb \
>  	imx6ul-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ul-prti6g.dtb \
> +	imx6ul-ts7553v2.dtb \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-ts7553v2.dts b/arch/arm/boot/dts/imx6ul-ts7553v2.dts
> new file mode 100644
> index 000000000000..8ed201f58137
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ts7553v2.dts
> @@ -0,0 +1,693 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Technologic Systems, Inc. dba embeddedTS
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include "imx6ul.dtsi"
> +
> +/ {
> +	model = "embeddedTS i.MX6UL TS-7553-V2";
> +	compatible = "technologic,ts7553v2", "fsl,imx6ul";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0>;
> +	};
> +
> +	leds {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +		compatible = "gpio-leds";
> +
> +		green-led {

led-0

> +			label = "green-led";

Rather use color and function, then labels.

> +			gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
> +			default-state = "on";
> +		};
> +
> +		red-led {

led-1

> +			label = "red-led";
> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		left {

This fails on dtbs_check. Generic node names, so "key-0" or "key-left"

> +			label = "Left";
> +			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_LEFT>;
> +			debounce-interval = <20>;
> +			gpio-key,wakeup;
> +		};
> +
> +		up {

Same problem... and so on...

> +			label = "Up";
> +			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_UP>;
> +			debounce-interval = <20>;
> +			gpio-key,wakeup;
> +		};

Missing blank line.

> +		down {
> +			label = "Down";
> +			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_DOWN>;
> +			debounce-interval = <20>;
> +			gpio-key,wakeup;
> +		};

Missing blank line.

> +		right {
> +			label = "Right";
> +			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RIGHT>;
> +			debounce-interval = <20>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x4000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	reg_sd1_vmmc: regulator-sd1-vmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SD1-3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_enet_phy_3v3: regulator-phy {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_enet_3v3>;
> +		regulator-name = "ENET-3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_flexcan_3v3: regulator-can-3v3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan_3v3>;
> +		regulator-name = "CAN-EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	i2c_gpio: i2c-gpio {

Generic node name, so "i2c"

> +		compatible = "i2c-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2cgpio>;
> +		sda-gpios = <&gpio5 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpio5 4 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Why do you add status? Isn't this a new node?

> +
> +		mpu9250a: imu@68 {
> +			compatible = "invensense,mpu9250";
> +			reg = <0x68>;
> +			interrupt-parent = <&gpio3>;
> +			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
> +			i2c-gate {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				magnetometer@c {
> +					compatible = "asahi-kasei,ak8975";
> +					reg = <0xc>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&gpio1 {
> +	gpio-line-names = "", "USB-5V-EN", "", "", "", "", "", "",
> +		"MODEM-5V-EN", "XBEE-3V3-EN", "", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "RS232-XCEIVER-EN";
> +};
> +
> +&gpio2 {
> +	gpio-line-names = "", "", "", "", "", "", "", "",
> +		"XBEE-PIN-9", "XBEE-PIN-16", "", "", "", "",
> +		"XBEE-PIN-12";
> +
> +	/* XXX: Do more testing with with this. PFM mode normally enabled under
> +	 * 700 mA which is well below what the 7553v2 runs at. in PFM mode lower
> +	 * freq to minimize switching losses but less able to respond to fast
> +	 * transients */
> +	vreg-mode-hog {
> +		gpio-hog;
> +		gpios = <13 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "VREG-MODE";
> +	};
> +};
> +
> +&gpio3 {
> +	gpio-line-names = "USB-HUB-RESET#", "", "", "", "", "", "",
> +		"USB-MUX-CPU-OTG", "", "", "", "NO-CHRG-JMP#", "", "", "", "",
> +		"", "SD-BOOT-JMP#", "PUSH-SW#", "U-BOOT-JMP#", "XBEE-RESET#",
> +		"", "", "RES-STRAP-0", "RES-STRAP-1", "", "",
> +		"RES-STRAP-2", "RES-STRAP-3";
> +};
> +
> +&gpio5 {
> +	gpio-line-names = "POWER-FAIL#", "", "EMMC-PWR-EN", "", "", "", "",
> +		"XBEE-USB-EN#", "RELAY-EN";
> +
> +	vdd-soc-in-v-hog {
> +		gpio-hog;
> +		gpios = <3 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "VDD-SOC-IN-V";
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	m41t00s: rtc@68 {
> +		compatible = "st,m41t00";
> +		reg = <0x68>;
> +	};
> +};
> +
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&ecspi3 {
> +	num-cs = <3>;
> +	cs-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>, <&gpio2 15 GPIO_ACTIVE_LOW>, <&gpio5 6 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3>;
> +	status = "okay";
> +
> +	st7565p: lcd@0 {
> +		/* TODO: Add driver support for Sitronix ST7565p */
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +	};
> +
> +	spidevdc: spidev@1 {

No empty devices, especially for spidev in DTS.

> +		/*
> +		 * Open interface on pin-header. Add appropriate "compatible"
> +		 * and related properties here. The "reg" property should
> +		 * remain as-is.
> +		 */
> +		reg = <1>;
> +	};
> +
> +	fm25l16b: eeprom@2 {
> +		compatible = "atmel,at25";
> +		reg = <2>;
> +		spi-max-frequency = <20000000>;
> +		size = <0x800>;
> +		address-width = <16>;
> +		pagesize = <64>;
> +	};
> +};
> +
> +&ecspi4 {
> +	num-cs = <1>;
> +	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi4>;
> +	status = "okay";
> +
> +	/*
> +	 * In testing, the in-kernel wilc1000 driver was non-functional on SPI.
> +	 * However, it is possible to build the official Microchip driver
> +	 * outside of their kernel tree as an external module and it works
> +	 * just fine and allows for true WILC3000 compatibility with BLE support.
> +	 * The below compatible string is structured to prefer the external
> +	 * module and fallback to in-kernel if that ever becomes functional.
> +	 * Additionally, using both chip_en and enable gpios are in order to
> +	 * support both the external module and in-kernel driver.
> +	 */
> +	wilc: wifi@0 {
> +		compatible = "microchip,wilc3000", "microchip,wilc1000";
> +		reg = <0>;
> +		spi-max-frequency = <48000000>;
> +		reset-gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
> +		chip_en-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;

There is no such property and it fails to match guidelines (underscore)
.
> +		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <1 GPIO_ACTIVE_HIGH>;
> +		status = "okay";

Why status?

> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	phy-supply = <&reg_enet_phy_3v3>;
> +	status = "okay";
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <2>;
> +			micrel,led-mode = <1>;
> +			clocks = <&clks IMX6UL_CLK_ENET_REF>;
> +			clock-names = "rmii-ref";
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_flexcan_3v3>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_flexcan_3v3>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	/*
> +	 * Need to use GPIO for TXEN even though CTS is available on this port.
> +	 * All instances of the UART2 RTS signal have other uses therefore leaving
> +	 * the UART module RTS_B input unconnected which generates spurious IRQs.
> +	 * If the imx.c driver is ever adjusted to allow configuration of RTSDEN
> +	 * then it may be possible to use real CTS here if RTS IRQs are disabled.
> +	 */
> +	rts-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
> +	linux,rs485-enabled-at-boot-time;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	status = "okay";
> +};
> +
> +&uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	cts-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +	rts-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7>;
> +	status = "okay";
> +};
> +
> +&uart8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart8>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "peripheral";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	keep-power-in-suspend;
> +	disable-wp;
> +	broken-cd;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_sd1_vmmc>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	no-1-8-v;
> +	disable-wp;
> +	broken-cd;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog1>;
> +	fsl,ext-reset-output;
> +};
> +
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			/* Reserved signals */
> +			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x1b020
> +			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12	0x1a020
> +			MX6UL_PAD_LCD_DATA03__GPIO3_IO08	0x1a020
> +			MX6UL_PAD_LCD_DATA04__GPIO3_IO09	0x1a020
> +			MX6UL_PAD_LCD_DATA05__GPIO3_IO10	0x1a020
> +			MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x13020
> +			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x1b020
> +			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x1b020
> +			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x1b020
> +			MX6UL_PAD_JTAG_TMS__GPIO1_IO11		0x1b020
> +			MX6UL_PAD_JTAG_TRST_B__GPIO1_IO15	0x1b020
> +
> +
> +			/* Has hardware pull resistor */
> +			MX6UL_PAD_LCD_DATA14__GPIO3_IO19	0x1a020 /* U_BOOT_JMP#_ */
> +			MX6UL_PAD_LCD_DATA06__GPIO3_IO11	0x1a020 /* NO_CHRG_JMP# */
> +			MX6UL_PAD_LCD_DATA12__GPIO3_IO17	0x1a020 /* SD_BOOT_JMP# */
> +			MX6UL_PAD_LCD_DATA02__GPIO3_IO07	0x1a020 /* 6UL_TO_USB_DEV */
> +			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x1a020 /* MODEM 5 v */
> +			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x1a020 /* XBee 3.3 v */
> +			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1a020 /* eMMC En. */
> +			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0a0
> +
> +			/* Needs internal pull resistor */
> +			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x1b020 /* RES_STRAP_0 */
> +			MX6UL_PAD_LCD_DATA19__GPIO3_IO24	0x1b020 /* RES_STRAP_1 */
> +			MX6UL_PAD_LCD_DATA22__GPIO3_IO27	0x1b020 /* RES_STRAP_2 */
> +			MX6UL_PAD_LCD_DATA23__GPIO3_IO28	0x1b020 /* RES_STRAP_3 */
> +			MX6UL_PAD_LCD_DATA15__GPIO3_IO20	0x1b020 /* XBEE_RESET# */
> +			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b020 /* XBEE_USB_EN# */
> +			MX6UL_PAD_ENET2_TX_CLK__GPIO2_IO14	0x1b020 /* XBEE_DIO_8 */
> +			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x1b020 /* XBEE_DIO_7 */
> +			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x1b020 /* XBEE_DIO_6 */
> +			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x1a020 /* RELAY_EN */
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x1b020 /* USB 5v EN */
> +			MX6UL_PAD_LCD_CLK__GPIO3_IO00		0x1b020 /* USB_HUB_RESET# */
> +			MX6UL_PAD_ENET2_TX_DATA0__REF_CLK_24M	0x1b020 /* USB hub */
> +			MX6UL_PAD_LCD_DATA13__GPIO3_IO18	0x1a020 /* PUSH_SW_CPU# */
> +			MX6UL_PAD_UART2_RTS_B__GPIO1_IO23	0x1b020 /* 232_TRANS_EN */
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b020 /* POWER_FAIL */
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x1a020 /* Left */
> +			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x1a020 /* Up */
> +			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x1a020 /* Down */
> +			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1a020 /* Right */
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b020 /* Red LED */
> +			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b020 /* Grn LED */
> +		>;
> +	};
> +
> +	pinctrl_usb_otg1_id: usbotg1idgrp {
> +		/* Wired always high for device mode on TS-7553-V2 */
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x16059
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp{
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
> +			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp{
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA10__FLEXCAN2_TX	0x1b020
> +			MX6UL_PAD_LCD_DATA11__FLEXCAN2_RX	0x1b020
> +		>;
> +	};
> +
> +	pinctrl_flexcan_3v3: flexcan3v3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x1b020 /* CAN En. */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART2_CTS_B__GPIO1_IO22	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart6: uart6grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_PIXCLK__UART6_DCE_RX	0x1b0b1
> +			MX6UL_PAD_CSI_MCLK__UART6_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x1b0b1
> +			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart7: uart7grp {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA17__UART7_DCE_RX	0x1b0b1
> +			MX6UL_PAD_LCD_DATA16__UART7_DCE_TX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart8: uart8grp {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA21__UART8_DCE_RX	0x1b0b1
> +			MX6UL_PAD_LCD_DATA20__UART8_DCE_TX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +		>;
> +	};
> +
> +	pinctrl_enet_3v3: enet3v3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO02__I2C1_SCL		0x4001a8b0
> +			MX6UL_PAD_GPIO1_IO03__I2C1_SDA		0x4001a8b0
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA01__I2C3_SCL		0x4001a8b0
> +			MX6UL_PAD_LCD_DATA00__I2C3_SDA		0x4001a8b0
> +		>;
> +	};
> +
> +	pinctrl_i2cgpio: i2cgrpgpio {

Name not matching schema, as they must end with grp. Derive your board
from something new, not ancient...

> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x4001a8b0
> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x4001a8b0
> +			MX6UL_PAD_LCD_ENABLE__GPIO3_IO01	0x13020 /* IMU IRQ */
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			/* hysteresis, en 47k PU */
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10071
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +			MX6UL_PAD_LCD_DATA07__GPIO3_IO12	0x17059 /* EN_SD_POWER */
> +			MX6UL_PAD_GPIO1_IO05__USDHC1_VSELECT	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {

Same.

> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {

No really...

> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
> +		>;
> +	};
> +
> +	pinctrl_ecspi3: ecspi3grp {
> +		fsl,pins = <
> +			// XXX: These are not defined with GPIO names
> +			// See about porting LCD driver?
> +			MX6UL_PAD_CSI_DATA04__GPIO4_IO25	0x1b020 /* LCD_BKLT */
> +			MX6UL_PAD_NAND_WP_B__GPIO4_IO11		0x1b020 /* LCD_RESET# */
> +			MX6UL_PAD_NAND_DQS__GPIO4_IO16		0x1b020 /* LCD_CMD# */
> +			MX6UL_PAD_NAND_CE0_B__ECSPI3_SCLK	0x1b020 /* SPI_3_CLK */
> +			MX6UL_PAD_NAND_CE1_B__ECSPI3_MOSI	0x1b020 /* SPI_3_MOSI */
> +			MX6UL_PAD_NAND_CLE__ECSPI3_MISO		0x1b820 /* SPI_3_MISO */
> +			MX6UL_PAD_NAND_READY_B__GPIO4_IO12	0x1b020 /* LCD CS0# */
> +			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x1b020 /* HD1 CS1# */
> +			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b020 /* FRAM CS2# */
> +		>;
> +	};
> +
> +	pinctrl_ecspi4: ecspi4grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_DATA04__ECSPI4_SCLK	0x1b020
> +			MX6UL_PAD_NAND_DATA05__ECSPI4_MOSI	0x1b020
> +			MX6UL_PAD_NAND_DATA06__ECSPI4_MISO	0x1b020
> +			MX6UL_PAD_NAND_DATA07__GPIO4_IO09	0x1b020 /* WIFI CS# */
> +			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b020 /* WIFI IRQ# */
> +			MX6UL_PAD_NAND_ALE__GPIO4_IO10		0x1b020 /* WIFI RST# */
> +			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x1b020 /* WIFI EN */
> +		>;
> +	};
> +
> +	pinctrl_wdog1: wdog1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY	0xb8b0
> +		>;
> +	};
> +};
> diff --git a/arch/arm/configs/ts7970_defconfig b/arch/arm/configs/ts7970_defconfig
> new file mode 100644
> index 000000000000..a96831752449

Rest is not accepted as not explained/justified.


Best regards,
Krzysztof
