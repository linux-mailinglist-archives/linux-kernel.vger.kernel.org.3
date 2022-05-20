Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1052EE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350280AbiETObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiETObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:31:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7551589
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:31:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m6so9901507ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nkSW2oaaDKiMdbKfgXW7BQe6QXekh/YBIPFTwRJSJIk=;
        b=mKiG96Pm61qDOC9vnwjJVN6GHxfwdC4TfxhqHHOrtND0CcXN1kEreVLEb7SrVBY0Z+
         +fHy5cuo7DNnAM+vjVpb+b6RMu9Rmwp/6JrQyW4cDN1l5zFJAWw1ZLb1c4IMVeLufahd
         iaQOXVBOWkos34pSOWiif37lU7mqQ3SBE/I0A7DyH3ZjTWG6eSsofxFU9OWkJdRyfxQF
         IrtQUt5qq+JqSSZyli3Gw7zZTJthmHXRlomqru2HgMC8igAyioSXryUbmflp2R4HC143
         Alm5Qx3UuqlA6QzD5cF6uC8sxI222kkwC4p6VnyAC2Rwr/I6c5fkVKvzmxqAWQ7z9OKL
         +C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nkSW2oaaDKiMdbKfgXW7BQe6QXekh/YBIPFTwRJSJIk=;
        b=2Hftio1Tsr8ucacJMDMdEUIRoTnZyfwkiQQ2Tagfe3Sjnjt2P6gf/L4uVNlaLEZssI
         vwWkvK92HkLJCBGL2Dag3gN7OCpZ7/MewQ1KGHw7j1YrABw7V5sSrKIyAGUAr8JXMjhF
         Aghck9C9SDU8JOy/IYmiapZTxvEQ7MJ6S0WosZVYW4Fz+3vRdnsUwhukPrp4xyNttXEI
         AB/mVBkawb+D9fmEu3a6mVulwxmsj3zCG1T66XsrRLC9nr0XnR6zu2iY6WrZHnUiSNGK
         ECRR534X+Zu7NzWXTxFBgVpgO/p/wJHXd/BS4ja28zG6SsItStGMvcJPCPXCEuGB9Dg9
         1dNg==
X-Gm-Message-State: AOAM533gRYj9ghL1Eo+UT/dkVtztTh9WTsWkP7yqrqCd3g0PCW32xQVW
        JB/lV7gKZByc1yPWZP3r6B1UDye/uaIE/hdt
X-Google-Smtp-Source: ABdhPJw1vIGajKIAguRW4MI/QH6zomI0ebNNSq+36VZ0WJFMba2FY4A7X7wfcRqA+6ZRN+E6iDfRtg==
X-Received: by 2002:a2e:854c:0:b0:24f:2aaa:12a1 with SMTP id u12-20020a2e854c000000b0024f2aaa12a1mr5662994ljj.60.1653057070747;
        Fri, 20 May 2022 07:31:10 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020ac2596d000000b004779f2f2bd0sm684259lfp.44.2022.05.20.07.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:31:09 -0700 (PDT)
Message-ID: <6ee28892-b3a3-588b-e6d6-edada4a89632@linaro.org>
Date:   Fri, 20 May 2022 16:31:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     edward_chen@jabil.com
References: <20220520120212.3589911-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520120212.3589911-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 14:02, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 479 ++++++++++++++++++
>  2 files changed, 481 insertions(+), 1 deletion(-)
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
> diff --git a/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> new file mode 100644
> index 000000000000..5e46af30c9e9
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> @@ -0,0 +1,479 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Jabil rbp";
> +	compatible = "jabil,rbp", "aspeed,ast2600";

You need to document the new compatible. checkpatch should warn about
this, didn't it?

> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";

Please use stdout-path instead.


> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
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
> +				compatible = "gpio-leds";

Wrong indentation.

> +
> +				identify {

Generic node names, so "led-0"

> +						default-state = "off";
> +						gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;

Missing several LED properties.

> +				};
> +
> +				status_amber {

Generic node names, no underscores in node names, so "led-1" etc.

> +						default-state = "off";
> +						gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> +				};
> +
> +				status_green {
> +						default-state = "keep";
> +						gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> +				};
> +
> +				status_susack {
> +						default-state = "off";
> +						gpios = <&gpio0 ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
> +				};
> +
> +				fan1_fault{
> +						default-state = "off";
> +						gpios = <&gpio3_71 0 GPIO_ACTIVE_HIGH>;
> +				};

Missing blank line.

> +				fan2_fault{
> +						default-state = "off";
> +				};

Ditto......

> +				fan3_fault{
> +						default-state = "off";
> +						gpios = <&gpio3_71 2 GPIO_ACTIVE_HIGH>;
> +				};
> +				fan4_fault{
> +						default-state = "off";
> +						gpios = <&gpio3_71 3 GPIO_ACTIVE_HIGH>;
> +				};
> +				fan5_fault{
> +						default-state = "off";
> +						gpios = <&gpio3_71 4 GPIO_ACTIVE_HIGH>;
> +				};
> +				fan6_fault{
> +						default-state = "off";
> +						gpios = <&gpio3_71 5 GPIO_ACTIVE_HIGH>;
> +				};
> +
> +				power_amber {
> +						default-state = "off";
> +						gpios = <&gpio0 ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
> +				};
> +		};
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
> +

Too many blank lines.

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
> +		status = "okay";

What's with this indentation?

> +		pinctrl-0 = <&pinctrl_txd1_default
> +					&pinctrl_rxd1_default
> +					&pinctrl_nrts1_default
> +					&pinctrl_ndtr1_default
> +					&pinctrl_ndsr1_default
> +					&pinctrl_ncts1_default
> +					&pinctrl_ndcd1_default
> +					&pinctrl_nri1_default>;
> +};
> +
> +&uart2 {
> +		status = "okay";
> +		pinctrl-0 = <&pinctrl_txd2_default
> +					&pinctrl_rxd2_default
> +					&pinctrl_nrts2_default
> +					&pinctrl_ndtr2_default
> +					&pinctrl_ndsr2_default
> +					&pinctrl_ncts2_default
> +					&pinctrl_ndcd2_default
> +					&pinctrl_nri2_default>;
> +};
> +
> +&uart3 {
> +		status = "okay";
> +};
> +
> +&uart4 {
> +		status = "okay";
> +};
> +
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	temp@2e {

generic node names, so "temperature-sensor" or just "sensor"


> +		compatible = "adi,adt7490";
> +		reg = <0x2e>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
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
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +};
> +
> +&i2c13 {
> +	status = "okay";
> +};
> +
> +&i2c14 {
> +	status = "okay";

You enable quite a lot of empty busses. Why?


Best regards,
Krzysztof
