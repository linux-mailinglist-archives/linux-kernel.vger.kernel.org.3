Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB3579728
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiGSKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiGSKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:01:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26860B4AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:01:38 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m9so14118616ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fFUuk8HgRnJ4YQbE85K9Ae0DVyZK37b4z8ITPDVOlYY=;
        b=yURxxKzdSfyczhaZmwLDtoNRMPIaXCqq8DVJVMq1bNhPdZ5fx2wCDvkPOBp9IXeszR
         kcGD5+qjYKchdkG0qV3e5UGs2PuovhB+JiMovpCuwxssMArbbL3rTiSn7OT5R90Gk8hg
         l3BYMmYnokzsf5ly7l/3C3sMZoZmtNKqncDA53IY50erCymCTUAURjFLj4i/f/HjOhze
         kme0ClOZq41KpAvOhpuvKPy930cVvf84qbDE91CkcQEwN6LZuPCI8B3G/bKsPxpTgKOY
         1T6g/vwYrZsTgD+czJGYSLteZg6WiTpivPO0deWyyC8ecbKHaGCIVNgGft0npAE8b4iC
         pw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fFUuk8HgRnJ4YQbE85K9Ae0DVyZK37b4z8ITPDVOlYY=;
        b=ckg7+1NtOblWKtvPd0aCshFV1zbT+7pb4wZSVkziIg7Phqs5emi61KPGKTICZP+bpY
         R2p77qoJ2EreeJC5KFi1EpsLQSZUCtiXrRz3ylQOHC9a2tyhrsTc1Q9YwS71obcPwSCE
         LdQvaPrPH4QQlkP4Hu2siesyKpMt0KJYjxCWlehv/TN0GtrSw83S/qJJ0tUcwwOHlZej
         UJj5HRlea0ITJ/3PWQJZ8+0qvgtN315V+8FC4pHPVJI654O6teR+H1lnhgHkbiBMmjbc
         SzckjDIch3PO6DdQrBc239kKuAuntC3h9D/kSrm82yY8DqEW2qpXrxkEnsFv7Jejvnug
         qtqg==
X-Gm-Message-State: AJIora/GFT07QaKGk7pQ7nKACcMFaNtkSlbZeNPXJDpbMG9LCLummVWJ
        PaEJ63SJQU4rjyzWEvDM8cPqyg==
X-Google-Smtp-Source: AGRyM1t/CDM6CjpnLCQbw0jM/PD/XrEN21J0q/SyuUsLQpmoJfS2mG5bthGACxQE32I3x6j6ZLap+w==
X-Received: by 2002:a05:651c:12c6:b0:25b:cab8:cc2a with SMTP id 6-20020a05651c12c600b0025bcab8cc2amr15631773lje.110.1658224896335;
        Tue, 19 Jul 2022 03:01:36 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651c118100b002554dce4048sm2601496ljo.53.2022.07.19.03.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:01:35 -0700 (PDT)
Message-ID: <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
Date:   Tue, 19 Jul 2022 12:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: Add device trees for MSC SM2S-IMX8PLUS SoM
 and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220718152310.1937899-1-martyn.welch@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718152310.1937899-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 17:23, Martyn Welch wrote:
> Add device trees for one of a number of MSCs variants of the SM2S-IMX8PLUS
> system on module along with the compatible SM2S-SK-AL-EP1 carrier board.
> As the name suggests, this family of SoMs use the NXP i.MX8MP SoC and
> provide the SMARC module interface.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Use subject prefix matching subsystem. I expect other folks in Collabora
help you in that, so you do not need our advices for such trivial stuff. :)

> 
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-msc-sm2s-14N0600E.dts    |  69 ++
>  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     |  65 ++
>  .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 869 ++++++++++++++++++
>  4 files changed, 1004 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 238a83e5b8c6..2484d646c6da 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
> new file mode 100644
> index 000000000000..fb19f2da5087
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Avnet Embedded GmbH
> + */
> +
> +#include "imx8mp-msc-sm2s.dtsi"
> +
> +/ {
> +	model = "MSC SM2S-IMX8PLUS-QC6-14N0600E SoM";

Missing compatibles, missing bindings.

> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0x80000000>; /* bank0, 2GiB */
> +	};
> +};
> +
> +&cpu_alert0 {
> +	temperature = <95000>;
> +};
> +
> +&cpu_crit0 {
> +	temperature = <105000>;
> +};
> +
> +&soc_alert0 {
> +	temperature = <95000>;
> +};
> +
> +&soc_crit0 {
> +	temperature = <105000>;
> +};
> +
> +&tca6424 {
> +	gbe0_int {
> +		gpio-hog;
> +		input;
> +		gpios = <3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	gbe1_int {
> +		gpio-hog;
> +		input;
> +		gpios = <4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	cam2_rst {
> +		gpio-hog;
> +		output-high;
> +		gpios = <9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	cam2_pwr {
> +		gpio-hog;
> +		output-high;
> +		gpios = <10 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	tpm_int {
> +		gpio-hog;
> +		input;
> +		gpios = <13 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	wifi_int {
> +		gpio-hog;
> +		input;
> +		gpios = <14 GPIO_ACTIVE_LOW>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> new file mode 100644
> index 000000000000..c915e2370733
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Avnet Embedded GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-msc-sm2s-14N0600E.dts"
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "MSC SM2-MB-EP1 Carrier Board with SM2S-IMX8PLUS-QC6-14N0600E SoM";

Missing compatibles and bindings.

> +};
> +
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	no-1-8-v;
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_smarc_gpio>;
> +
> +	pinctrl_smarc_gpio: smarcgpiosgrp {
> +		fsl,pins = <
> +			/* GPIO0 */
> +			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x19
> +			/* GPIO1 */
> +			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01		0x19
> +			/* GPIO2 */
> +			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x19
> +			/* GPIO3 */
> +			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x19
> +			/* GPIO4 */
> +			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29		0x19
> +			/* GPIO5 */
> +			MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02		0x19
> +			/* GPIO6 */
> +			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x19
> +			/* GPIO7 */
> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x19
> +			/* GPIO8 */
> +			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20		0x19
> +			/* GPIO9 */
> +			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x19
> +			/* GPIO10 */
> +			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x19
> +			/* GPIO11 */
> +			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x19
> +			/* GPIO12 */
> +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x19
> +			/* GPIO13 */
> +			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00		0x19
> +		>;
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
> new file mode 100644
> index 000000000000..7d958cfb4d55
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
> @@ -0,0 +1,869 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Avnet Embedded GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "MSC SM2S-IMX8MPLUS";

Ditto


> +
> +	aliases {
> +		rtc0 = &sys_rtc;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	reg_usb0_host_vbus: regulator-usb0-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb0_host_vbus";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb0_vbus>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb1_host_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1_host_vbus";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb1_vbus>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		off-on-delay-us = <12000>;
> +	};
> +
> +	reg_flexcan1_xceiver: regulator-flexcan1-xceiver {
> +		compatible = "regulator-fixed";
> +		regulator-name = "flexcan1-xceiver";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +	};
> +
> +	reg_flexcan2_xceiver: regulator-flexcan2-xceiver {
> +		compatible = "regulator-fixed";
> +		regulator-name = "flexcan2-xceiver";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +	};
> +
> +	lcd0_backlight: lcd0_backlight {

No underscores in node names. Generic node names so backlight-0.


> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd0_backlight>;
> +		pwms = <&pwm1 0 100000 0>;
> +		brightness-levels = <0 255>;
> +		num-interpolated-steps = <255>;
> +		default-brightness-level = <255>;
> +		enable-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	lcd1_backlight: lcd1_backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd1_backlight>;
> +		pwms = <&pwm2 0 100000 0>;
> +		brightness-levels = <0 255>;
> +		num-interpolated-steps = <255>;
> +		default-brightness-level = <255>;
> +		enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +		status = "okay";
> +
> +		sw-led {
> +			label = "sw-led";
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	extcon_usb0: extcon_usb0 {

No underscores, extcon is Linux term, so use node name describing device.

> +		compatible = "linux,extcon-usb-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb0_extcon>;
> +		id-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&vcc_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&vcc_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&vcc_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&vcc_arm>;
> +};
> +
> +&dsp {
> +	status = "okay";
> +};
> +
> +&ecspi1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <0>, <&gpio2 8 GPIO_ACTIVE_LOW>;
> +};
> +
> +&ecspi2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <0>, <&gpio2 9 GPIO_ACTIVE_LOW>;
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <1>;
> +	phy-reset-post-delay = <1>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			eee-broken-1000t;
> +			phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
> +
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <1>;
> +	phy-reset-post-delay = <1>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			eee-broken-1000t;
> +			phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
> +
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	id_eeprom: eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c5>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c6>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	tca6424: gpio@22 {
> +		compatible = "ti,tca6424";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tca6424>;
> +		reg = <0x22>;

compatible, then reg, then all other properties. This applies everywhere.

> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "BOOT_SEL0#", "BOOT_SEL1#", "BOOT_SEL2#",
> +			"gbe0_int", "gbe1_int", "pmic_int", "rtc_int", "lvds_int",
> +			"PCIE_WAKE#", "cam2_rst", "cam2_pwr", "SLEEP#",
> +			"wifi_pd", "tpm_int", "wifi_int", "PCIE_A_RST#",
> +			"gbe0_rst", "gbe1_rst", "LID#", "BATLOW#", "CHARGING#",
> +			"CHARGER_PRSNT#";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	dsi_lvds_bridge: sn65dsi84@2d {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,sn65dsi83";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lvds_bridge>;
> +		reg = <0x2d>;
> +		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
> +
> +	pmic: pmic@30 {
> +		compatible = "ricoh,rn5t567";
> +		interrupt-parent = <&tca6424>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +		reg = <0x30>;

compatible, reg then the rest.
> +
> +		regulators {
> +			DCDC1 {
> +				regulator-name = "VCC_SOC";
> +				regulator-always-on;
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <950000>;
> +			};
> +			DCDC2 {
> +				regulator-name = "VCC_DRAM";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +			};
> +			vcc_arm: DCDC3 {
> +				regulator-name = "VCC_ARM";
> +				regulator-always-on;
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <950000>;
> +			};
> +			DCDC4 {
> +				regulator-name = "VCC_1V8";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +			LDO1 {
> +				regulator-name = "VCC_LDO1_2V5";
> +				regulator-always-on;
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +			};
> +			LDO2 {
> +				regulator-name = "VCC_LDO2_1V8";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +			LDO3 {
> +				regulator-name = "VCC_ETH_2V5";
> +				regulator-always-on;
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +			};
> +			LDO4 {
> +				regulator-name = "VCC_DDR4_2V5";
> +				regulator-always-on;
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +			};
> +			LDO5 {
> +				regulator-name = "VCC_LDO5_1V8";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +			LDORTC1 {
> +				regulator-name = "VCC_SNVS_1V8";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +			LDORTC2 {
> +				regulator-name = "VCC_SNVS_3V3";
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +
> +	sys_rtc: rtc@32 {
> +		compatible = "ricoh,r2221tl";
> +		reg = <0x32>;
> +		interrupt-parent = <&tca6424>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	tmp_sensor: tmp103@71 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp103";
> +		reg = <0x71>;
> +		label = "BOARD_TEMP";
> +	};
> +};
> +
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_flexcan1_xceiver>;
> +	status = "disabled";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_flexcan2_xceiver>;
> +	status = "disabled";
> +};
> +
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	status = "okay";
> +
> +	qspi_flash: qspi_flash@0 {

You didn't test the bindings (dtbs_check), did you? There is no way this
passess...

> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";

Eh? Now compatible in the middle? Sorry, this are trivial code quality
comments. Please use internal review or base your work on some
upstreamed existing board.

Best regards,
Krzysztof
