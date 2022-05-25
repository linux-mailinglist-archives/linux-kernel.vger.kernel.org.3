Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193D5336B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiEYGQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiEYGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:16:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E96373
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:16:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h11so24550776eda.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ReZJCEJTDXCb5jCpkN5l0PGrXQJfL73jVMkfYBLDRbU=;
        b=zDTcYIJO2iFJAA71366d9AcJCUx78ZBxxjF7E/iPMtOa7Zotd44jd0A2KddsXtYgpd
         t4bxymsQQTXSoabox6YKKJ9gCzasqH+80w0jhMdgVHnQiVG1JVlwSOY1P9q7Jcje2fMG
         rUPMCdkFtmifWwPXNOlFmRY0dRSZR0EM/rB05VPq+SUF1pqKXKhc/SGvN+7K0pINCGfO
         MP7/RfaOWeSis/LjMsiUA69EbzRDhFHnD3BZfDDHa4mPcPDTTg7opRnZKQG/3zxQaFxH
         FoNz47U4If8+MykimZVeZKhuvLNrC81nBbPCsfjc5SemVA+WeXcs9IRXDrPmNxPvRBlG
         hrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ReZJCEJTDXCb5jCpkN5l0PGrXQJfL73jVMkfYBLDRbU=;
        b=1/9e5Q/InJSgXHRa4LsEoQl3aTlzOXdJvEbfSHEfYeslWxvN+JNbOE6Ie6FHC2/CI8
         7eAwJyAFGLzYXd8sIIYGD8JyOLfg3fCJZhs8NbzvAtauWV5vhqRAF6llsuQAFuV/7ChH
         01hnlRpam5Ku4pkQHhiriYVI5r/KC9xGZ6wnnjp6GggYsYw17F0k5+UGrZMF3hWZOjts
         hSbrW+lnUzP4fLlGxDz2UubDMLQhCWZldHtBEMqqBo+P+6QTURGSZJzsUYIis5RVGQD/
         dM3ohfYCRLATOMsfSDSSRcGpx81sTsPWVkqJ7aW8cQU7geXIO8TAopDoRdIHjKs1I5p4
         nWyQ==
X-Gm-Message-State: AOAM532qVtPI3n0SzA4dAt4hmfseHI6g6Yp7MAAa/Hh+NPi3W6I5XpG3
        6N21yY+Ve5TuNi3VjpXiQJ/haQ==
X-Google-Smtp-Source: ABdhPJyuzIUcI5fub4u7iPx5A49Tp+rqum58QDIHwMYhQ5uiKjtqBao70eM1enlTu0lkwtDfzDUXFQ==
X-Received: by 2002:a05:6402:26ce:b0:42b:6bc4:ce16 with SMTP id x14-20020a05640226ce00b0042b6bc4ce16mr13803104edd.61.1653459372052;
        Tue, 24 May 2022 23:16:12 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ej23-20020a056402369700b0042a2d9af0f8sm10471355edb.79.2022.05.24.23.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 23:16:11 -0700 (PDT)
Message-ID: <b41cd12f-b803-f291-cfe5-24c952a2196e@linaro.org>
Date:   Wed, 25 May 2022 08:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220525034211.1402577-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525034211.1402577-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 05:42, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> ---
> 
> v2
> - Disable empty i2c bus.
> - Remove gfx node because aspeed-g6.dtsi isn't supported.
> - Modify the led format and add some properties.
> - Fix wrong indentation.
> - Add stdout property in chosen node.
> - Rename temp to temperature-sensor in i2c bus 0.
> 
> ---
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 449 ++++++++++++++++++
>  2 files changed, 451 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7c16f8a2b738..9c395178fc89 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1566,4 +1566,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-tyan-s8036.dtb \
>  	aspeed-bmc-vegman-n110.dtb \
>  	aspeed-bmc-vegman-rx20.dtb \
> -	aspeed-bmc-vegman-sx20.dtb
> +	aspeed-bmc-vegman-sx20.dtb \
> +	aspeed-bmc-jabil-rubypass.dtb

The entries are ordered by name and your new name looks out of order...

> diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> new file mode 100644
> index 000000000000..0e1450f66372
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Jabil rbp";
> +	compatible = "aspeed,ast2600";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

You do not need bootargs. Use stdout-path.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	vcc_sdhci0: regulator-vcc-sdhci0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDHCI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +
> +	vccq_sdhci0: regulator-vccq-sdhci0 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "SDHCI0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	vcc_sdhci1: regulator-vcc-sdhci1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDHCI1 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci1: regulator-vccq-sdhci1 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "SDHCI1 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			label = "identify";
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			retain-state-shutdown;
> +			gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			label = "status_amber";
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			label = "status_green";
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "keep";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			label = "status_susack";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4{
> +			label = "power-amber";
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	fan_fault {

No underscores in node names, generic node names, so leds-1 (and
previous leds-0). Although main question - why do you need two instances
of drivers?

> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			label = "fan1-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			label = "fan2-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "fan3-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-3 {
> +			label = "fan4-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-4 {
> +			label = "fan5-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-5 {
> +			label = "fan6-fault";
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function = LED_FUNCTION_FAULT;
> +			retain-state-shutdown;
> +			gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mdio2 {
> +	status = "okay";
> +
> +	ethphy2: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mdio3 {
> +	status = "okay";
> +
> +	ethphy3: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&ethphy0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
> +&mac1 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&ethphy1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default>;
> +};
> +
> +&mac2 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy2>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy3>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};
> +
> +&emmc_controller {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	non-removable;
> +	bus-width = <4>;
> +	max-frequency = <100000000>;
> +	clk-phase-mmc-hs200 = <9>, <225>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-max-frequency = <100000000>;
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +			&pinctrl_rxd1_default
> +			&pinctrl_nrts1_default
> +			&pinctrl_ndtr1_default
> +			&pinctrl_ndsr1_default
> +			&pinctrl_ncts1_default
> +			&pinctrl_ndcd1_default
> +			&pinctrl_nri1_default>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_txd2_default
> +			&pinctrl_rxd2_default
> +			&pinctrl_nrts2_default
> +			&pinctrl_ndtr2_default
> +			&pinctrl_ndsr2_default
> +			&pinctrl_ncts2_default
> +			&pinctrl_ndcd2_default
> +			&pinctrl_nri2_default>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	temperature-sensor@2e {
> +		compatible = "adi,adt7490";
> +		reg = <0x2e>;
> +	};
> +};
> +
> +&i2c3 {
> +	multi-master;
> +	status = "okay";
> +
> +	gpio@70 {
> +		compatible = "nxp,pca9538";
> +		reg = <0x70>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <ASPEED_GPIO(O, 7) IRQ_TYPE_EDGE_FALLING>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names =
> +			"presence-fan1-n", "presence-fan2-n", "presence-fan3-n", "presence-fan4-n",
> +			"presence-fan5-n", "presence-fan6-n", "", "";
> +	};
> +
> +	gpio3_71:gpio@71 {

Missing space after :.

> +		compatible = "nxp,pca9538";
> +		reg = <0x71>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names =
> +			"led-fan1-fault", "led-fan2-fault", "led-fan3-fault", "led-fan4-fault",
> +			"led-fan5-fault", "led-fan6-fault", "", "";
> +	};
> +};
> +
> +&fsim0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};
> +
> +&sdc {
> +	status = "okay";
> +};
> +
> +/*
> + * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
> + * toggled by GPIO pins.
> + * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
> + * power load switch that provides 3.3v to sdhci0 vdd, GPIOV1 is connected to
> + * a 1.8v and a 3.3v power load switch that provides signal voltage to
> + * sdhci0 bus.
> + * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
> + * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
> + * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
> + * sdhci0 signal voltage becomes 1.8v.
> + * AST2600-A2 EVB also supports toggling signal voltage for sdhci1.
> + * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
> + * as power-switch-gpio.
> + */
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	max-frequency = <100000000>;
> +	sdhci-drive-type = /bits/ 8 <3>;
> +	sdhci-caps-mask = <0x7 0x0>;
> +	sdhci,wp-inverted;
> +	vmmc-supply = <&vcc_sdhci0>;
> +	vqmmc-supply = <&vccq_sdhci0>;
> +	clk-phase-sd-hs = <7>, <200>;
> +};
> +
> +&sdhci1 {
> +	status = "okay";
> +	bus-width = <4>;
> +	max-frequency = <100000000>;
> +	sdhci-drive-type = /bits/ 8 <3>;
> +	sdhci-caps-mask = <0x7 0x0>;
> +	sdhci,wp-inverted;
> +	vmmc-supply = <&vcc_sdhci1>;
> +	vqmmc-supply = <&vccq_sdhci1>;
> +	clk-phase-sd-hs = <7>, <200>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +	gpio-line-names =
> +	/*A0-A7*/       "","","","","","","","",
> +	/*B0-B7*/       "presence-ncsi-i210-n","","","","","","","led-identify-n",
> +	/*C0-C7*/       "","","","","","","","",
> +	/*D0-D7*/       "","","","","","","","",
> +	/*E0-E7*/       "","","","","","","","",
> +	/*F0-F7*/       "","","","","","","id-button","",
> +	/*G0-G7*/       "","","led-status-green-n","led-status-amber-n","","","","",
> +	/*H0-H7*/       "","","","","","cpu-caterr","","cpu1-caterr-n",
> +	/*I0-I7*/       "","","","","","","","",
> +	/*J0-J7*/       "","","","","","","","",
> +	/*K0-K7*/       "","","","","","","","",
> +	/*L0-L7*/       "","","","","","","","",
> +	/*M0-M7*/       "","","","","","","","",
> +	/*N0-N7*/       "","","","","","","","",
> +	/*O0-O7*/       "","","","","","","nmi-button","",
> +	/*P0-P7*/       "reset-button","reset-out","power-button","power-out","","","",
> +					"led-hartbeat-n",
> +	/*Q0-Q7*/       "","","","","","","","",
> +	/*R0-R7*/       "","","","","","","","",
> +	/*S0-S7*/       "","","","","","","","",
> +	/*T0-T7*/       "","","","","","","","",
> +	/*U0-U7*/       "","","","","","","","",
> +	/*V0-V7*/       "regulator-vcc-sdhci0","regulator-vccq-sdhci0","regulator-vcc-sdhci1",
> +					"regulator-vccq-sdhci1","sio-power-good",
> +					"led-bmc-fw-config-done-n","","",
> +	/*W0-W7*/       "","","","","","","","",
> +	/*X0-X7*/       "cpu-err2","","","","","","","",
> +	/*Y0-Y7*/       "led-power-amber","","","","","","","",
> +	/*Z0-Z7*/       "cpu-err0","cpu-err1","","","","","","";
> +	};
> +
> +&gpio1 {
> +	status = "okay";
> +};
> +
> +&kcs3 {
> +	aspeed,lpc-io-reg = <0xCA2>;
> +	status = "okay";
> +};
> +
> +&kcs4 {
> +	aspeed,lpc-io-reg = <0xCA4>;
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +

Unneeded blank line at the end.

Best regards,
Krzysztof
