Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB100559DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiFXPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiFXPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:51:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A44E3B4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:51:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so3666869wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1CrnY/L8UABvLIJiMmcMINNSOrobx/14XP39GlCqEpM=;
        b=qbsP+Yas83OsXg6dxt20eN6kIlOkUUXPABbETCOuWL4gVGH2b6AuvYu5lY6rvN6pri
         jcqUq3lEDC+8y3wrnEgXGfv22m0O+IelPxroHbQakVYvAc1FHzrQcQSO3Cj13afNLKGQ
         WpOLj9oPWXjaUzHnUp4wMdodCYDHeQolSOTFB8E1ca0NPc5SYpHNQ8N0L3Es1tZFGGJl
         EeTiVuHVcEeOzhECpGuOZhNDcRtBAudDj8/oaOnIC8bg6oZTXMK47KhCn4DfnJ6Al2Mj
         eG4AyTGy31hMLmT3Fgg+CYk4swfTZLgFQUECwSdfhE3QoBa9uWdS9TcN8kpPo3IwxnbE
         1Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1CrnY/L8UABvLIJiMmcMINNSOrobx/14XP39GlCqEpM=;
        b=nSx1ACLonwiHeuMgRaQQNrZPF4hx7GSTShLGlHq1fCZFYfP8/ZCzl0d1esQUPyaWWg
         L4Dxc7PZEbxJwxVpqyXvfn5NugX3BFGoF4ki15SJHpY3Pz2yKVOL3zRqrdGxCklR9NEk
         xhhigfSH853YpXHQ5bP6mUfmyNuPMS4ezOvF/lsJJgHNxyetaodhGI+7M3ncCJpgOLJh
         KKJP1xW50f+OAR2fOn5+zCRS2WnDxNNEL2QdTndvialWTQTsOIdHGb46KIXl+CsYtugs
         kSnBQAuVYzX4+TwW+rCgJwriOzr5U9KN4cPE6VoU1hugiG6LdpElVSkNgby0Sy81OeMU
         DRsw==
X-Gm-Message-State: AJIora/3EaKZzpvpAO9Hg4o0InH5v8smj15AZB22OIJEXI6kCr6s34aJ
        cBiCJCNgmVdafoYNqqtUtHkddA==
X-Google-Smtp-Source: AGRyM1v2gqFyndN5Tm5xbKAMlQo9PYqSGLNBtIIxdkvmg9BQ3lqnAs0VGTWOqxiGJOv+8VRFDa2ZoQ==
X-Received: by 2002:a05:6000:141:b0:21b:90e1:2207 with SMTP id r1-20020a056000014100b0021b90e12207mr13937817wrx.704.1656085866993;
        Fri, 24 Jun 2022 08:51:06 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p2-20020a056000018200b002103cfd2fbasm2691509wrx.65.2022.06.24.08.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:51:06 -0700 (PDT)
Message-ID: <97934f38-4da5-ab9e-7089-d6e48edd5e6a@linaro.org>
Date:   Fri, 24 Jun 2022 17:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20220621092120.2427152-1-quan@os.amperecomputing.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220621092120.2427152-1-quan@os.amperecomputing.com>
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

On 21/06/2022 11:21, Quan Nguyen wrote:
> The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
> hardware reference platform with AmpereOne(TM) processor.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 579 ++++++++++++++++++
>  2 files changed, 580 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..93c236c14fa0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1558,6 +1558,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-amd-ethanolx.dtb \
>  	aspeed-bmc-ampere-mtjade.dtb \
> +	aspeed-bmc-ampere-mtmitchell.dtb \
>  	aspeed-bmc-arm-centriq2400-rep.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> new file mode 100644
> index 000000000000..42425e13030a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Ampere Computing LTC.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Ampere Mt.Mitchell BMC";
> +	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";

The compatible has to be documented. Please rebase on top of:
https://lore.kernel.org/all/20220529104928.79636-3-krzysztof.kozlowski@linaro.org/

> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

console is not needed, earlycon is debugging tool so definitely should
not go to mainline widely distributed DTS. Remove entire bootargs.

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
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		/* 1GB memory */
> +		vga_memory: region@bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +

No need for blank line.

> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		S0_overtemp {

Only lower-case letters, no underscore but hyphen. Missing prefix (e.g.
key/event/switch/button)

See:
https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/


> +			label = "S0_OVERTEMP";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 7)>;
> +		};
> +
> +		S0_hightemp {
> +			label = "S0_HIGHTEMP";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 0)>;
> +		};
> +
> +		S1_overtemp {
> +			label = "S1_OVERTEMP";
> +			gpios = <&gpio0 ASPEED_GPIO(X, 6) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(X, 6)>;
> +		};
> +
> +		S1_hightemp {
> +			label = "S1_HIGHTEMP";
> +			gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(X, 3)>;
> +		};
> +	};
> +
> +	ltc2497_reg: ltc2497_regulator {

No underscores in node name, no specific names (Devicetree spec requires
generic), so ltc2497 has to go. You could add some more specific
prefix/suffix to describe the function.

> +		compatible = "regulator-fixed";
> +		regulator-name = "ltc2497_reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	gpioI5mux: mux-controller {
> +		compatible = "gpio-mux";
> +		#mux-control-cells = <0>;
> +		mux-gpios = <&gpio0 ASPEED_GPIO(I, 5) GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	adc0mux: adc0mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 0>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc1mux: adc1mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 1>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc2mux: adc2mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 2>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc3mux: adc3mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 3>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc4mux: adc4mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 4>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc5mux: adc5mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 5>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc6mux: adc6mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 6>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc7mux: adc7mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc0 7>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc8mux: adc8mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 0>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc9mux: adc9mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 1>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc10mux: adc10mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 2>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc11mux: adc11mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 3>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc12mux: adc12mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 4>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc13mux: adc13mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 5>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc14mux: adc14mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 6>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	adc15mux: adc15mux {
> +		compatible = "io-channel-mux";
> +		io-channels = <&adc1 7>;
> +		#io-channel-cells = <1>;
> +		io-channel-names = "parent";
> +		mux-controls = <&gpioI5mux>;
> +		channels = "s0", "s1";
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0mux 0>, <&adc0mux 1>,
> +			<&adc1mux 0>, <&adc1mux 1>,
> +			<&adc2mux 0>, <&adc2mux 1>,
> +			<&adc3mux 0>, <&adc3mux 1>,
> +			<&adc4mux 0>, <&adc4mux 1>,
> +			<&adc5mux 0>, <&adc5mux 1>,
> +			<&adc6mux 0>, <&adc6mux 1>,
> +			<&adc7mux 0>, <&adc7mux 1>,
> +			<&adc8mux 0>, <&adc8mux 1>,
> +			<&adc9mux 0>, <&adc9mux 1>,
> +			<&adc10mux 0>, <&adc10mux 1>,
> +			<&adc11mux 0>, <&adc11mux 1>,
> +			<&adc12mux 0>, <&adc12mux 1>,
> +			<&adc13mux 0>, <&adc13mux 1>,
> +			<&adc14mux 0>, <&adc14mux 1>,
> +			<&adc15mux 0>, <&adc15mux 1>,
> +			<&ltc2497 0>, <&ltc2497 1>,
> +			<&ltc2497 2>, <&ltc2497 3>,
> +			<&ltc2497 4>, <&ltc2497 5>,
> +			<&ltc2497 6>, <&ltc2497 7>,
> +			<&ltc2497 8>, <&ltc2497 9>,
> +			<&ltc2497 10>, <&ltc2497 11>,
> +			<&ltc2497 12>, <&ltc2497 13>,
> +			<&ltc2497 14>, <&ltc2497 15>;
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
> +&mac0 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +
> +	flash@1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
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
> +		spi-max-frequency = <20000000>;
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
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
> +	temp@2e {

Generic node name, so usually it is "temperature-sensor"

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
> +
> +	psu@58 {
> +		compatible = "pmbus";
> +		reg = <0x58>;
> +	};
> +
> +	psu@59 {
> +		compatible = "pmbus";
> +		reg = <0x59>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	ltc2497: ltc2497@16 {

Generic node name.

> +		compatible = "lltc,ltc2497";
> +		reg = <0x16>;
> +		vref-supply = <&ltc2497_reg>;
> +		#io-channel-cells = <1>;
> +		status = "okay";
> +	 };
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9545";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c4_bus70_chn0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			outlet_temp1: tmp75@48 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x48>;
> +			};
> +			psu1_inlet_temp2: tmp75@49 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x49>;
> +			};
> +		};
> +
> +		i2c4_bus70_chn1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x1>;
> +
> +			pcie_zone_temp1: tmp75@48 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x48>;
> +			};
> +			psu0_inlet_temp2: tmp75@49 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x49>;
> +			};
> +		};
> +
> +		i2c4_bus70_chn2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			pcie_zone_temp2: tmp75@48 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x48>;
> +			};
> +			outlet_temp2: tmp75@49 {

Generic node name.

> +				compatible = "ti,tmp75";
> +				reg = <0x49>;
> +			};
> +		};
> +
> +		i2c4_bus70_chn3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			mb_inlet_temp1: tmp75@7c {

Generic node name.

> +				compatible = "microchip,emc1413";
> +				reg = <0x7c>;
> +			};
> +			mb_inlet_temp2: tmp75@4c {

Generic node name.

> +				compatible = "microchip,emc1413";
> +				reg = <0x4c>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +	rtc@51 {
> +		compatible = "nxp,pcf85063a";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +};
> +
> +&i2c14 {
> +	status = "okay";
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	bmc_ast2600_cpu: tmp175@35 {

Generic node name.

Best regards,
Krzysztof
