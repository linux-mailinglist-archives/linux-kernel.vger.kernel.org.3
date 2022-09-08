Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA45B1AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIHLFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIHLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:04:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202E19C12
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:04:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i26so11363566lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=U4E7tvJ0cK6VylVw75NAe0M7sqnMkBPhRkEg5cBpB4Y=;
        b=DohWmCgRefLemL54TzZRKIj5xLPKl6IPiXNAa9OuNmmdark+xppfaPLU7NpuAFy1nq
         oyc1MC3uT3O7ddArgCfluyiPhnzDzABpncwD3xJJcQKlM4LhQ2S3txnmp2zVoBFyLVTj
         4LReIBy79oXTx0hVeS7pnNIAsXVJdtKJRRK7mg7O6ffTIJKCA5CWS8QL4apCqncFKbip
         AjkIBXUCjQZ6RhrOw5hZplfy4jQ0IDulTHLUy5pZlLk4mKRh8XZ8azBcwrWei7Ntpsbw
         d3qsEyBux9BNpyKgfabLcAmYJcPCN1jd/s1E/9WlSej4aBHcsfhx33Smzi3jzYALRwBu
         VAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=U4E7tvJ0cK6VylVw75NAe0M7sqnMkBPhRkEg5cBpB4Y=;
        b=slcOfs6JMCxmlu5th2GYmfo2boYU5ImARsKkcjlJXCZ5VDpNUFjXZjYwy4pbFCGy38
         QT2da3xQozpQacRDdL73BS+x09ZK/lM1F3AT+mgbypG9wNmtfSoTcxnQrfwHwJoZ3tL0
         Mv/yzVJdZeqcUxvpbJjNUwdUccur/CdJtZ8xgTJomk/Mef3HdoqmgxcqqO3+JMhQIQTn
         +Vjtb9z7158uQYsMNTHa1hw75lMBJpuQOzN5rvwtchOknToc1zqIsF07ek08Y+ApuVSK
         ekNwqJ5csE++VU5fmTXjTytWD1NFIVuL7PerJ1eay1kktn4XkhKa7P8v43TazRerba33
         aKoQ==
X-Gm-Message-State: ACgBeo0P9xD1FiKTyDioTY2rQTKNVv8L4yWYtdxf3iUDP4x0P87peE+0
        rXQvt68sOcD2W80DYf/uLAn9Aw==
X-Google-Smtp-Source: AA6agR5SGVF6aJThZOB+TPEqq+DmSy6UlYhXoGhAsv7SukTqjP2ylbQ97Rru1D8uRX1+WNfrnAOJXQ==
X-Received: by 2002:a05:6512:555:b0:497:9dda:6e91 with SMTP id h21-20020a056512055500b004979dda6e91mr2875046lfl.78.1662635086049;
        Thu, 08 Sep 2022 04:04:46 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a12-20020a05651c210c00b0026ac7cd51afsm1225181ljq.57.2022.09.08.04.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:04:45 -0700 (PDT)
Message-ID: <6fb37c95-1bb3-aef0-eca8-3f6e3b868e3e@linaro.org>
Date:   Thu, 8 Sep 2022 13:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [linux][PATCH 6/6] ARM: dts: at91: sam9x60_curiosity: Add device
 tree for sam9x60_curiosity board
Content-Language: en-US
To:     Hari Prasath <Hari.PrasathGE@microchip.com>,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        alexandre.belloni@bootlin.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, manikandan.m@microchip.com, michael@walle.cc,
        horatiu.vultur@microchip.com, kavyasree.kotagiri@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, durai.manickamkr@microchip.com
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
 <20220907092054.29915-7-Hari.PrasathGE@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907092054.29915-7-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 11:20, Hari Prasath wrote:
> From: Manikandan M <manikandan.m@microchip.com>
> 
> Add device tree file for sam9x60_curiosity board.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Manikandan M <manikandan.m@microchip.com>
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +

Bindings are separate patches.

>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/at91-sam9x60_curiosity.dts  | 532 ++++++++++++++++++
>  3 files changed, 539 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sam9x60_curiosity.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 2b7848bb7769..fae3a3090fbd 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -97,6 +97,12 @@ properties:
>            - const: microchip,sam9x60
>            - const: atmel,at91sam9
>  
> +      - description: SAM9X60 Curiosity board
> +        items:
> +          - const: microchip,sam9x60-curiosity
> +          - const: microchip,sam9x60
> +          - const: atmel,at91sam9

This should be rather together with previous entry as an enum.

> +
>        - description: Nattis v2 board with Natte v2 power board
>          items:
>            - const: axentia,nattis-2
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 595e870750cd..cd60cda5d187 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  	at91sam9x25ek.dtb \
>  	at91sam9x35ek.dtb
>  dtb-$(CONFIG_SOC_SAM9X60) += \
> +	at91-sam9x60_curiosity.dtb \
>  	at91-sam9x60ek.dtb
>  dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-kizbox2-2.dtb \
> diff --git a/arch/arm/boot/dts/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
> new file mode 100644
> index 000000000000..75e6727b5e3a
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
> @@ -0,0 +1,532 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x60_curiosity.dts - Device Tree file for Microchip SAM9X60 CURIOSITY board
> + *
> + * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Manikandan M <manikandan.m@microchip.com>
> + */
> +/dts-v1/;
> +#include "sam9x60.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Microchip SAM9X60 CURIOSITY";
> +	compatible = "microchip,sam9x60-curiosity", "microchip,sam9x60", "atmel,at91sam9";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c6;
> +		serial2 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@20000000 {
> +		reg = <0x20000000 0x8000000>;
> +	};
> +
> +	clocks {
> +		slow_xtal {

No underscores in node names... If you override nodes, do it via label.

> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +		status = "okay";

Okay is by default.

> +
> +		button-user {
> +			label = "PB_USER";
> +			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +		status = "okay";

Ditto

> +
> +		red {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

You need to fix all warnings in your DTS.
> +			label = "red";
> +			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		green {
> +			label = "green";
> +			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		blue {
> +			label = "blue";
> +			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	regulators: regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vdd_1v8: fixed-regulator-vdd_1v8@0 {


No underscores in node names. No prefix "fixed-". This is just a  regulator.

> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			status = "okay";

Really?

> +		};
> +
> +		vdd_1v15: fixed-regulator-vdd_1v15@1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD_1V15";
> +			regulator-min-microvolt = <1150000>;
> +			regulator-max-microvolt = <1150000>;
> +			regulator-always-on;
> +			status = "okay";
> +		};
> +
> +		vdd1_3v3: fixed-regulator-vdd1_3v3@2 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD1_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +			status = "okay";
> +		};
> +	};
> +};
> +
> +&adc {
> +	vddana-supply = <&vdd1_3v3>;
> +	vref-supply = <&vdd1_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
> +	status = "okay";
> +};
> +
> +&can0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can0_rx_tx>;
> +	status = "disabled"; /* Conflict with dbgu. */
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1_rx_tx>;
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dbgu>;
> +	status = "okay"; /* Conflict with can0. */
> +};
> +
> +&ebi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_0_7>;
> +	status = "okay";
> +
> +	nand_controller: nand-controller {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_nand_oe_we &pinctrl_nand_cs &pinctrl_nand_rb>;
> +		status = "okay";
> +
> +		nand@3 {
> +			reg = <0x3 0x0 0x800000>;
> +			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
> +			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <8>;
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
> +				uboot@40000 {
> +					label = "u-boot";
> +					reg = <0x40000 0xc0000>;
> +				};
> +
> +				ubootenvred@100000 {
> +					label = "U-Boot Env Redundant";
> +					reg = <0x100000 0x40000>;
> +				};
> +
> +				ubootenv@140000 {
> +					label = "U-Boot Env";
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
> +					reg = <0x800000 0x1f800000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&flx0 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c0: i2c@600 {
> +		dmas = <0>, <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx0_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";

??

> +
> +		eeprom@53 {
> +			compatible = "atmel,24c02";
> +			reg = <0x53>;
> +			pagesize = <16>;
> +			status = "okay";
> +		};
> +	};
> +};
> +
> +&flx6 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c6: i2c@600 {
> +		dmas = <0>, <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx6_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "disabled";
> +	};
> +};
> +
> +&flx7 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
> +	status = "okay";
> +
> +	uart7: serial@200 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx7_default>;
> +		status = "okay";
> +	};
> +};
> +
> +&macb0 {
> +	phy-mode = "rmii";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_macb0_rmii>;
> +	status = "okay";
> +
> +	ethernet-phy@0 {
> +		reg = <0x0>;
> +	};
> +};
> +
> +&pinctrl {
> +	adc {
> +		pinctrl_adc_default: adc_default {

No underscores in node names.



Best regards,
Krzysztof
