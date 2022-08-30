Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217CD5A692E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiH3RDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiH3RCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:02:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEDF15A1F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:02:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m2so12625660lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MRhddpJA+lgXt6Sory277eBUBdu2WrBidojgTD73Yuo=;
        b=FldSeHKHZ1KDEukm8iKfWba8HUDHdk925SJkveqljZdC5w++3Y9TlaE/Y/kuEB/0zq
         Oj2LXbo88y9CqkhDmgMp22Oy6ZVeF/qcn+bXwKY1RiWD4Z4jpX/CR1qLiUr5o5V4s3AE
         YPfmnEIRGpipBzKnwaH7FZRFwAJEEewOuHVqByqTJ6ZcipxSFoOomiEHQuNisAxE5Zxz
         R0bv4HLBPTfp8rRIGNEdNdnp7eE88fqZhRiDd1GbF4dMz3HWZDaE9jL2+ES5ZCjAU/rK
         iR2+t902enedqvPvGXAx/HAUJY4N325tuLWVDjI3WcyfuPhDAtYXQXJbbhX9Fcs+YxrL
         iq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MRhddpJA+lgXt6Sory277eBUBdu2WrBidojgTD73Yuo=;
        b=y3L7TeUFT01sQgsRw/J3iTCTyF1nFG+Ay+ZxaHiOC+DrNWvGfC6ledsYIEBi4++XRE
         kXXNLVVV+9ovEm0kHdlP8VPv7/5vFbzaEKiEFyzrBO5v1GyEOUmhXmsh+hgQOvWWU0/D
         0o6YTMcL1/VIB3g9A/E3NTcdfP/4x/iP8IgJa92moxGqnNlmA7PP0MRUlBaJe6kDOkWA
         EaaoofyG/ubS3Trdl4DejX4A73Hg3nK0LDAWeiUtIOW0NjjJSraLGQUUxhPyps5ayiAl
         YbATefOW8wAiY6ZFfay3Mn6WcjkpLpoeF/4L1i+GTIQyWTZuls/6lk3lB4GVVlz4hfGH
         zKZg==
X-Gm-Message-State: ACgBeo0890zihtFZgcQBPS0BO6mHp5SbyH716w3vCmAeNj31ekNS/i8B
        5/XIv+6AKnz+QDbIqL4KjVJNYQ==
X-Google-Smtp-Source: AA6agR4YaR3zige40oqXHN14BkAjmJfCQwGjsKSNPK9sbXvmdLoS2CuaEYOPzLbVDDdMkgxSJMDd0w==
X-Received: by 2002:a05:6512:2353:b0:492:db5e:775b with SMTP id p19-20020a056512235300b00492db5e775bmr7462751lfu.656.1661878959375;
        Tue, 30 Aug 2022 10:02:39 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05651c23a500b00261ca006158sm557973ljb.54.2022.08.30.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:02:38 -0700 (PDT)
Message-ID: <92c213de-872c-bc0b-382c-c9940309f272@linaro.org>
Date:   Tue, 30 Aug 2022 20:02:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 2/2] dts: arm: at91: Add SAMA5D3-EDS board
Content-Language: en-US
To:     Jerry Ray <jerry.ray@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220830152428.12625-1-jerry.ray@microchip.com>
 <20220830152428.12625-2-jerry.ray@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830152428.12625-2-jerry.ray@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 18:24, Jerry Ray wrote:
> The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
> evaluating many Microchip ethernet switch and PHY products.  Various
> daughter cards can connect up via an RGMII connector or an RMII connector.
> 

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> The EDS board is not intended for stand-alone use and has no ethernet
> capabilities when no daughter board is connected.  As such, this device
> tree is intended to be used with a DT overlay defining the add-on board.
> To better ensure consistency, some items are defined here as a form of
> documentation so that all add-on overlays will use the same terms.
> 
> Google search keywords: "Microchip SAMA5D3-EDS"
> 
> Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
> ---
> v4->v5:
>  - patch now applies to v6.0-rc2

If this is rebased, why you did not CC me?

> v3->v4:
>  - Fixed regulators as necessary to get the board to boot from SD Card.
> v2->v3:
>  - Alphabetized pinctrl entries.
>  - cleaned up a warning in the regulators section.
>  - License tweaked to 'OR MIT'
>  - Included Makefile change
> v1->v2:
>  - Modified the compatible field in the device tree to reflect Microchip
>    Ethernet Development System Board.
> ---
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/at91-sama5d3_eds.dts | 309 +++++++++++++++++++++++++
>  2 files changed, 310 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..e92e639a2dc3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d2_icp.dtb \
>  	at91-sama5d2_ptc_ek.dtb \
>  	at91-sama5d2_xplained.dtb \
> +	at91-sama5d3_eds.dtb \
>  	at91-sama5d3_ksz9477_evb.dtb \
>  	at91-sama5d3_xplained.dtb \
>  	at91-dvk_som60.dtb \
> diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> new file mode 100644
> index 000000000000..2e6d94b30916
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
> + *    Development System board.
> + *
> + *  Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
> + *		  2022 Jerry Ray <jerry.ray@microchip.com>
> + */
> +/dts-v1/;
> +#include "sama5d36.dtsi"
> +
> +/ {
> +	model = "SAMA5D3 Ethernet Development System";
> +	compatible = "microchip,sama5d3-eds", "atmel,sama5d3",
> +		     "atmel,sama5";

This does not match your bindings.

> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		slow_xtal {

No underscores in node names. Generic node names, so at least add some
generic prefix or suffix, e.g.: "slow-xtal-clock"

> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {

Ditto, e.g. main-xtal-clock

> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
> +	gpio_keys {

No underscores...

> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio>;
> +
> +		button-3 {
> +			label = "PB_USER";
> +			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <0x104>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	memory@20000000 {
> +		reg = <0x20000000 0x10000000>;
> +	};
> +
> +	vcc_3v3_reg: BUCK_REG1 {

No, this coding style is very poor. No capital letters, no underscores.
Use generic node names, e.g. "regulator-0".


> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_2v5_reg: LDO_REG2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_2V5";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_3v3_reg>;
> +	};
> +
> +	vcc_1v8_reg: LDO_REG3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_3v3_reg>;
> +	};
> +
> +	vcc_1v2_reg: BUCK_REG4 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_1V2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_mmc0_reg: fixedregulator_mmc0 {

Another different pattern of naming..

> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc0-card-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_vcc_mmc0_reg_gpio>;
> +		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&can0 {
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&ebi {
> +	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	nand_controller: nand-controller {
> +		status = "okay";
> +> +		nand@3 {
> +			reg = <0x3 0x0 0x2>;
> +			atmel,rb = <0>;
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <4>;
> +			nand-ecc-step-size = <512>;
> +			nand-on-flash-bbt;
> +			label = "atmel_nand";
> +
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				at91bootstrap@0 {
> +					label = "at91bootstrap";
> +					reg = <0x0 0x40000>;
> +				};
> +
> +				bootloader@40000 {
> +					label = "bootloader";
> +					reg = <0x40000 0xc0000>;
> +				};
> +
> +				bootloaderenvred@100000 {
> +					label = "bootloader env redundant";
> +					reg = <0x100000 0x40000>;
> +				};
> +
> +				bootloaderenv@140000 {
> +					label = "bootloader env";
> +					reg = <0x140000 0x40000>;
> +				};
> +
> +				dtb@180000 {
> +					label = "device tree";
> +					reg = <0x180000 0x80000>;
> +				};
> +
> +				kernel@200000 {
> +					label = "kernel";
> +					reg = <0x200000 0x600000>;
> +				};
> +
> +				rootfs@800000 {
> +					label = "rootfs";
> +					reg = <0x800000 0x0f800000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-0 = <&pinctrl_i2c0_pu>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	dmas = <0>, <0>;	/* Do not use DMA for i2c2 */

Instead you need to remove the property.

> +	pinctrl-0 = <&pinctrl_i2c2_pu>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
> +		     &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
> +	vmmc-supply = <&vcc_mmc0_reg>;
> +	vqmmc-supply = <&vcc_3v3_reg>;
> +	status = "okay";
> +	slot@0 {
> +		reg = <0>;
> +		bus-width = <8>;
> +		cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	board {
> +		pinctrl_i2c0_pu: i2c0_pu {

No underscores in node names.

> +			atmel,pins =
> +				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
> +				<AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +		};
> +
> +		pinctrl_i2c2_pu: i2c2_pu {
> +			atmel,pins =
> +				<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>,
> +				<AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
> +		};
> +
> +		pinctrl_key_gpio: key_gpio_0 {
> +			atmel,pins =
> +				<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +		};
> +
> +		pinctrl_mmc0_cd: mmc0_cd {
> +			atmel,pins =
> +				<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +		};
> +
> +		/* Reserved for reset signal to the RGMII connector. */
> +		pinctrl_rgmii_rstn: rgmii_rstn {
> +			atmel,pins =
> +				<AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
> +		};
> +
> +		/* Reserved for an interrupt line from the RMII and RGMII connectors. */
> +		pinctrl_spi_irqn: spi_irqn {
> +			atmel,pins =
> +				<AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +		};
> +
> +		pinctrl_spi0_cs: spi0_cs_default {
> +			atmel,pins =
> +				<AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				 AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +
> +		pinctrl_spi1_cs: spi1_cs_default {
> +			atmel,pins = <AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOC 28 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +
> +		pinctrl_usba_vbus: usba_vbus {
> +			atmel,pins =
> +				<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +		};
> +
> +		pinctrl_usb_default: usb_default {
> +			atmel,pins =
> +				<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				 AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +
> +		/* Reserved for VBUS fault interrupt. */
> +		pinctrl_vbusfault_irqn: vbusfault_irqn {
> +			atmel,pins =
> +				<AT91_PIOE 5 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
> +		};
> +
> +		pinctrl_vcc_mmc0_reg_gpio: vcc_mmc0_reg_gpio_default {
> +			atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +		};
> +	};
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default", "cs";
> +	pinctrl-1 = <&pinctrl_spi0_cs>;
> +	cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default", "cs";
> +	pinctrl-1 = <&pinctrl_spi1_cs>;
> +	cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioC 28 0>;

Use proper flags. What is <0>???


> +	status = "okay";
> +};
> +
> +&tcb0 {
> +	timer0: timer@0 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <0>;
> +	};
> +
> +	timer1: timer@1 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <1>;
> +	};
> +};
> +
> +&usb0 {
> +	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usba_vbus>;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	atmel,vbus-gpio = <0

What is this 0?

> +			   &pioE 3 GPIO_ACTIVE_HIGH
> +			   &pioE 4 GPIO_ACTIVE_HIGH

Why two GPIOs?

> +			  >;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_default>;
> +	num-ports = <3>;
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};


Best regards,
Krzysztof
