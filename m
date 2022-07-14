Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A87574694
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiGNIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiGNITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:19:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5331F2EC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:19:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y11so1569969lfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PyjJ9iaD+R45xRMrKoBPH7udoL94L8lvKfIJcfq2+n4=;
        b=T4X2pBqEjLbJ1lpgSYifX1LogGkC01J0RiA7pSPd6mXyhmvGkjLze2BgHQev30prat
         Ax25onzHsQvvn9vF6rLcnbZEuRo/5D3nyNSNDYXQQPipoIkSClwV0mSvLGG8SE/mE/1Q
         VFDAXHvAr7J41CXyQBiXhFV1fybpKrqL2gqGWIi+pBOjesKOjyeyu+3wRC4atkDOn5eD
         3ArhjPjTDatfj+YX7lIZIUJrBUVhaPu9UpmEHj+NPkFfAAVD4VWuWtKRHl5eSG7Q9WU5
         1ecfH5IuRDb7dH6cQY9eeeSsMGRWukKo1vhR3C4A0swCZp8jWFaB5yUJbvKC3MmrfQHq
         L1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PyjJ9iaD+R45xRMrKoBPH7udoL94L8lvKfIJcfq2+n4=;
        b=0Wdw4YDwdHyPjJJycB6BdGG0oA6qNshVa/Iaw53G2wpcy3UNbZsbdh7h7ZCbXpUzZz
         rnyEZ+3dwWYfMXE9qukWct+F+w+S/LAYgR0XMlYoX+rKtgKbatN3FykJ+tViE8TpYBbX
         l8jlJqxtnB8ewIaJ/dMrlu1L+nG4GygkZNGRL1wv/gkgfEmae7XYJz2S7fIejUPhqDNt
         PJEmO8qdYon7G11vHMaP1j0n7OuPjKXrAG+wZW3ZnxNR8VrWXIQnj9vfU0S1dik49AmP
         PHBPb2U+IuW4i/L03UGJEuavqQ3fSx49kcrGJpsN4i3f43dgEB9JLkq1ZwbFAPeYF93s
         1kIg==
X-Gm-Message-State: AJIora+ka9CpcVNcH1iPMzGRTFE4Rr6s5YQF+cnUjXiSgpfFkYMp8ci9
        4/BYhqe56LLGVA2cRjl5yfDyCg==
X-Google-Smtp-Source: AGRyM1vck8pP/rwICuxGudIDR0f79SjXxnNFqO0RqCf7dfPQMzGY00vl3bGCvCSUcVC9fVWEZh5caQ==
X-Received: by 2002:a05:6512:22d2:b0:489:dac8:3422 with SMTP id g18-20020a05651222d200b00489dac83422mr4526970lfu.317.1657786755880;
        Thu, 14 Jul 2022 01:19:15 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512314400b00489db767c89sm228873lfi.271.2022.07.14.01.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:19:14 -0700 (PDT)
Message-ID: <4d7c0636-b5fb-fbdb-bea6-fa16fe18b219@linaro.org>
Date:   Thu, 14 Jul 2022 10:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] ARM: dts: imx7d: add dts for UC-8210/8220 hardware
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714030636.3000-1-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714030636.3000-1-jimmy.chen@moxa.com>
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

On 14/07/2022 05:06, Jimmy Chen wrote:
> Add 2 models hardware dts provided by MOXA company
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
> Changes in v3:
>   - Fix compatible string reference to fsl.yaml
>   - Change regulator node name
>   - Replace underscore to dash
>   - Replace node name
>   - Remove 'status' attribute from node
>   - Add board compatible and model to ixm7d-moxa-uc-8210.dts
>   - Rearrange 82XX alphabet order in Makefile
>   - Rearrange 82XX alphabet order in fsl
> 
>  arch/arm/boot/dts/Makefile               |   2 +
>  arch/arm/boot/dts/imx7d-moxa-uc-8210.dts | 862 +++++++++++++++++++++++
>  arch/arm/boot/dts/imx7d-moxa-uc-8220.dts |  22 +
>  3 files changed, 886 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
>  create mode 100644 arch/arm/boot/dts/imx7d-moxa-uc-8220.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..c9c57626876c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -747,6 +747,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-flex-concentrator-mfg.dtb \
>  	imx7d-mba7.dtb \
>  	imx7d-meerkat96.dtb \
> +	imx7d-moxa-uc-8210.dtb \
> +	imx7d-moxa-uc-8220.dtb \
>  	imx7d-nitrogen7.dtb \
>  	imx7d-pico-dwarf.dtb \
>  	imx7d-pico-hobbit.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
> new file mode 100644
> index 000000000000..fc5a0c7ff295
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-moxa-uc-8210.dts
> @@ -0,0 +1,862 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/* Copyright (C) MOXA Inc. All rights reserved.
> + * Authors: TungYu TY Yang <TungyuTY.Yang@moxa.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d.dtsi"
> +
> +/ {
> +	model = "Moxa UC-8210";
> +	compatible = "moxa,uc-8210", "fsl,imx7d";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg2_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reg_wl: regulator-wl {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio4 20 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-name = "wl_reg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <100>;
> +	};
> +
> +	reg_sd1_vmmc: regulator-sd1-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_SD1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <200000>;
> +		off-on-delay = <20000>;
> +		enable-active-high;
> +	};
> +
> +	reg_can2_3v3: regulator-can2-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can2-3v3";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan2_reg>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		signal-led-1-1 {
> +			label = "UC8200:YELLOW:SGN1-1";
> +			gpios = <&i2cgpio2 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		signal-led-1-2 {
> +			label = "UC8200:YELLOW:SGN1-2";
> +			gpios = <&i2cgpio2 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		signal-led-1-3 {
> +			label = "UC8200:YELLOW:SGN1-3";
> +			gpios = <&i2cgpio2 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		signal-led-2-1 {
> +			label = "UC8200:YELLOW:SGN2-1";
> +			gpios = <&i2cgpio2 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		signal-led-2-2 {
> +			label = "UC8200:YELLOW:SGN2-2";
> +			gpios = <&i2cgpio2 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		signal-led-2-3 {
> +			label = "UC8200:YELLOW:SGN2-3";
> +			gpios = <&i2cgpio2 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		user-led-1-1 {
> +			label = "UC8200:YELLOW:USR";
> +			gpios = <&i2cgpio1 9 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user-led-1-2 {
> +			label = "UC8200:GREEN:USR";
> +			gpios = <&i2cgpio1 10 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	buttons: gpio-keys {

Why do you need the label here?

> +		compatible = "gpio-keys";
> +
> +		button {
> +			label = "Reset key";
> +			gpios = <&gpio5 11 1>;
> +			linux,code = <0x100>;
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&adc2 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&ecspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	tpm-spi-tis@0 {

Node name stll not correct. This is tpm, isn't it?
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

(...)

> +
> +&qspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi1_1>;
> +	status = "okay";
> +
> +	flash0: mx25l12805d@0 {

Still wrong node name.

This does not pass `make dtbs_check`, so NAK.


> +		compatible = "mxicy,mx25l12805d", "jedec,spi-nor";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* reg : The partition's offset and size within the mtd bank. */
> +			partitions@0 {
> +				label = "mlo";
> +				reg = <0x0 0x100000>;
> +			};
> +
> +			partitions@1 {
> +				label = "u-boot 1";
> +				reg = <0x100000 0x100000>;
> +			};
> +
> +			partitions@2 {
> +				label = "u-boot 2";
> +				reg = <0x200000 0x100000>;
> +			};
> +
> +			partitions@3 {
> +				label = "u-boot env 1";
> +				reg = <0x300000 0x20000>;
> +			};
> +
> +			partitions@4 {
> +				label = "u-boot env 2";
> +				reg = <0x320000 0x20000>;
> +			};
> +
> +			partitions@5 {
> +				label = "syslog";
> +				reg = <0x500000 0x100000>;
> +			};
> +
> +			partitions@6 {
> +				label = "storage";
> +				reg = <0x600000 0x200000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx7d-sdb {
> +		pinctrl_ecspi1: ecspi1grp {
> +			fsl,pins = <
> +				MX7D_PAD_ECSPI1_MISO__ECSPI1_MISO	0x2
> +				MX7D_PAD_ECSPI1_MOSI__ECSPI1_MOSI	0x2
> +				MX7D_PAD_ECSPI1_SCLK__ECSPI1_SCLK	0x2
> +				MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x2
> +			>;
> +		};
> +
> +		pinctrl_ecspi3: ecspi3grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
> +				MX7D_PAD_SAI2_TX_BCLK__ECSPI3_MOSI	0x2
> +				MX7D_PAD_SAI2_RX_DATA__ECSPI3_SCLK	0x2
> +				MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x80000000
> +			>;
> +		};
> +
> +		pinctrl_enet1: enet1grp {
> +			fsl,pins = <
> +				MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
> +				MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x3
> +				MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
> +				MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
> +				MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
> +				MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
> +				MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
> +				MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
> +				MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
> +				MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
> +				MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
> +				MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
> +				MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
> +				MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
> +			>;
> +		};
> +
> +		pinctrl_enet2: enet2grp {
> +			fsl,pins = <
> +				MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
> +				MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
> +				MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
> +				MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
> +				MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
> +				MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
> +				MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
> +				MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
> +				MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
> +				MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
> +				MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
> +				MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
> +				MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
> +			>;
> +		};
> +
> +		pinctrl_flexcan2_reg: flexcan2reggrp {
> +			fsl,pins = <
> +				MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59	/* CAN_STBY */
> +			>;
> +		};
> +
> +		pinctrl_gpio_keys: gpio-keysgrp {
> +			fsl,pins = <
> +				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
> +				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
> +			>;
> +		};
> +
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x15	/*LTE_PWR_EN*/
> +				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34	/* bt reg on */
> +				MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x59	/* WL_REG_ON */
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> +				MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
> +				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
> +				MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c4: i2c4grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
> +				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_lcdif: lcdifgrp {
> +			fsl,pins = <
> +				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> +				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
> +				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
> +				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
> +				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
> +				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
> +				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
> +				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
> +				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
> +				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
> +				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
> +				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
> +				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
> +				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
> +				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
> +				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
> +				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
> +				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
> +				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
> +				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
> +				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
> +				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
> +				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
> +				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
> +				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
> +				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
> +				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
> +				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
> +				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
> +			>;
> +		};
> +
> +		pinctrl_sai1: sai1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
> +				MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
> +				MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
> +				MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
> +				MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
> +			>;
> +		};
> +
> +		pinctrl_sai2: sai2grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
> +				MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
> +				MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
> +				MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
> +			>;
> +		};
> +
> +		pinctrl_sai3: sai3grp {
> +			fsl,pins = <
> +				MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
> +				MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
> +				MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
> +			>;
> +		};
> +
> +		pinctrl_spi4: spi4grp {
> +			fsl,pins = <
> +				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
> +				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
> +				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
> +			>;
> +		};
> +
> +		pinctrl_tsc2046_pendown: tsc2046_pendown {

No improvements here.


> +			fsl,pins = <
> +				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> +				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
> +			>;
> +		};
> +
> +		pinctrl_uart5: uart5grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_TX_BCLK__UART5_DCE_TX	0x79
> +				MX7D_PAD_SAI1_RX_DATA__UART5_DCE_RX	0x79
> +				MX7D_PAD_SAI1_TX_SYNC__UART5_DCE_CTS	0x79
> +				MX7D_PAD_SAI1_TX_DATA__UART5_DCE_RTS	0x79
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {


Really? So you fixed a node before, but this one left ignored? You
received comments, so please apply them EVERYWHERE.

Best regards,
Krzysztof
