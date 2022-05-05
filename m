Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010651BBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352505AbiEEJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiEEJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:23:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93C4D63D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:19:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4696575wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KgRaJ8ykKT+8ctH+xg/woDycauZTpvt8qBaNt1BDsik=;
        b=zFaRA9FsIQ5cWCpW+efMthh4t8iYmCIOPjekvtOqifYbqpOqetPTPkwZ/vBXe3Gkgv
         MnzShgni4lgkOzW7hgWkHqHbCbGvRRxHYGMkm739MGp3dafxPAl5UKVECJOkcvjS0W/6
         En3HiuOj37XOu5Jy3+QOLkDjgtkvX2cxFSU8RyohdYvLfJ9JtyCbFMnogkk7xEkh1ZJC
         g7TBhOalzkSNQmIAp+Y0Vs+/Ac9QrcKpvCTUFqH3AkdBig2grIwZiYZ0HWfZH8y5nukH
         ItVOcBLbv+INlkoHbosudCS9CtS66to4xc5YUvu9WrnotNhE+yDc7p73dbWIK+v4QSwQ
         4BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KgRaJ8ykKT+8ctH+xg/woDycauZTpvt8qBaNt1BDsik=;
        b=E/e611I0q8V2CaGfz3uwKUyLKtzq5Ez1q7aWviunsyl9j6zrqr5wlS5+zjaDLEXYWc
         8rhntMK2xV7/yBbc+sg67to669C6MMvY5lFdNY9glkhNcyEJXNkFmubn4H9absveb0y7
         MLDQVG13AUJcEumGRgHQnuu2OPt0si8lmu4BrHFOt1TQi66XNVm/a/M97OW32JTRfgX4
         3VTCGNP7diE5+BIlmAgmHL5MBMewVeZrcJHrp6vF41vCEFEm815H1uBQQMpZycKiwuL7
         UsrH11RPTiJ+JESDFwupzBRQXj/NAyvutNVZA9TZDwK0hS0cMrzNGMtoj7cq32PV8rkn
         CwCg==
X-Gm-Message-State: AOAM531BiIF9CBf9SajgdCrcLFNMVH4E8Y7bZX66Ll32martBCRpA5Sg
        2Im1ihprA34e6MGYrcBrbBLllQ==
X-Google-Smtp-Source: ABdhPJyChk2xKo7kDV4Gj9YKZXL9vZPre7lqq4veWlUymAeVA/4Xspb327aHqbnjjDgKzlDToHtnlw==
X-Received: by 2002:a05:600c:3545:b0:394:39b6:b848 with SMTP id i5-20020a05600c354500b0039439b6b848mr3521309wmq.181.1651742393460;
        Thu, 05 May 2022 02:19:53 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b12-20020adfc74c000000b0020c5253d8e8sm794901wrh.52.2022.05.05.02.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 02:19:53 -0700 (PDT)
Message-ID: <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
Date:   Thu, 5 May 2022 11:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 06:46, Chris Packham wrote:
> The 98DX2530 SoC is the Control and Management CPU integrated into
> the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
> referred to as AlleyCat5 and AlleyCat5X).

Thank you for your patch. There is something to discuss/improve.

>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/armada-98dx2530.dtsi     | 310 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
>  3 files changed, 401 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/rd-ac5x.dts
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 1c794cdcb8e6..3905dee558b4 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -24,3 +24,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += rd-ac5x.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> new file mode 100644
> index 000000000000..ec4cfb17a260
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree For AC5.
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Marvell AC5 SoC";
> +	compatible = "marvell,ac5";

Missing board bindings patch.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		spiflash0 = &spiflash0;
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				 <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				 <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				 <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		dma-ranges;
> +
> +		internal-regs@7f000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "simple-bus";
> +			/* 16M internal register @ 0x7f00_0000 */
> +			ranges = <0x0 0x0 0x7f000000 0x1000000>;
> +			dma-coherent;
> +
> +			uart0: serial@12000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x12000 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-io-width = <1>;
> +				clock-frequency = <328000000>;
> +				status = "okay";
> +			};
> +
> +			mdio: mdio@22004 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "marvell,orion-mdio";
> +				reg = <0x22004 0x4>;
> +				clocks = <&core_clock>;
> +			};
> +
> +			i2c0: i2c@11000{
> +				compatible = "marvell,mv78230-i2c";
> +				reg = <0x11000 0x20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				clocks = <&core_clock>;
> +				clock-names = "core";
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency=<100000>;
> +				status="disabled";
> +
> +				pinctrl-names = "default", "gpio";
> +				pinctrl-0 = <&i2c0_pins>;
> +				pinctrl-1 = <&i2c0_gpio>;
> +				scl_gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +				sda_gpio = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +			};
> +
> +			i2c1: i2c@11100{
> +				compatible = "marvell,mv78230-i2c";
> +				reg = <0x11100 0x20>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				clocks = <&core_clock>;
> +				clock-names = "core";
> +				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency=<100000>;
> +				status="disabled";

Spaces around '='. Also, put status as the last property. Here and in
every other node.

> +
> +				pinctrl-names = "default", "gpio";
> +				pinctrl-0 = <&i2c1_pins>;
> +				pinctrl-1 = <&i2c1_gpio>;
> +				scl_gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> +				sda_gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +			};
> +
> +			gpio0: gpio@18100 {
> +				compatible = "marvell,orion-gpio";
> +				reg = <0x18100 0x40>;
> +				ngpios = <32>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				gpio-ranges = <&pinctrl0 0 0 32>;
> +				marvell,pwm-offset = <0x1f0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpio1: gpio@18140 {
> +				reg = <0x18140 0x40>;
> +				compatible = "marvell,orion-gpio";
> +				ngpios = <14>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				gpio-ranges = <&pinctrl0 0 32 14>;
> +				marvell,pwm-offset = <0x1f0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +		};
> +
> +		/*
> +		 * Dedicated section for devices behind 32bit controllers so we
> +		 * can configure specific DMA mapping for them
> +		 */
> +		behind-32bit-controller@7f000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <0x2>;
> +			#size-cells = <0x2>;
> +			ranges = <0x0 0x0 0x0 0x7f000000 0x0 0x1000000>;
> +			/* Host phy ram starts at 0x200M */
> +			dma-ranges = <0x0 0x0 0x2 0x0 0x1 0x0>;
> +			dma-coherent;
> +
> +			eth0: ethernet@20000 {
> +				compatible = "marvell,armada-ac5-neta";
> +				reg = <0x0 0x20000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&core_clock>;
> +				status = "disabled";
> +				phy-mode = "sgmii";
> +			};
> +
> +			eth1: ethernet@24000 {
> +				compatible = "marvell,armada-ac5-neta";
> +				reg = <0x0 0x24000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&core_clock>;
> +				status = "disabled";
> +				phy-mode = "sgmii";
> +			};
> +
> +			/* A dummy entry used for chipidea phy init */
> +			usb1phy: usbphy {

Node name: usb-phy or phy

> +				compatible = "usb-nop-xceiv";
> +				#phy-cells = <0>;
> +			};
> +
> +			/* USB0 is a host USB */
> +			usb0: usb@80000 {
> +				compatible = "marvell,orion-ehci";
> +				reg = <0x0 0x80000 0x0 0x500>;
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			/* USB1 is a peripheral USB */
> +			usb1: usb@a0000 {
> +				reg = <0x0 0xa0000 0x0 0x500>;
> +				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		pinctrl0: pinctrl@80020100 {
> +			compatible = "marvell,ac5-pinctrl";
> +			reg = <0 0x80020100 0 0x20>;
> +
> +			i2c0_pins: i2c0-pins {
> +				marvell,pins = "mpp26", "mpp27";
> +				marvell,function = "i2c0";
> +			};
> +
> +			i2c0_gpio: i2c0-gpio-pins {
> +				marvell,pins = "mpp26", "mpp27";
> +				marvell,function = "gpio";
> +			};
> +
> +			i2c1_pins: i2c1-pins {
> +				marvell,pins = "mpp20", "mpp21";
> +				marvell,function = "i2c1";
> +			};
> +
> +			i2c1_gpio: i2c1-gpio-pins {
> +				marvell,pins = "mpp20", "mpp21";
> +				marvell,function = "i2c1";
> +			};
> +		};
> +
> +		spi0: spi@805a0000 {
> +			compatible = "marvell,armada-3700-spi";
> +			reg = <0x0 0x805a0000 0x0 0x50>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +			clocks = <&spi_clock>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			num-cs = <1>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@805a8000 {
> +			compatible = "marvell,armada-3700-spi";
> +			reg = <0x0 0x805a8000 0x0 0x50>;
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +			clocks = <&spi_clock>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +			num-cs = <1>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	core_clock: core_clock {

No underscores in node names.

All these clocks do not look like real clocks. Where are they if outside
of SoC? These should be fed from clock controllers, shouldn't they? If
they are provided by boards, don't put them into SoC...

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <400000000>;
> +	};
> +
> +	axi_clock: axi_clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <325000000>;
> +	};
> +
> +	spi_clock: spi_clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <200000000>;
> +	};
> +
> +	gic: interrupt-controller@80600000 {

Outside of SoC?

> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		/*#redistributor-regions = <1>;*/
> +		redistributor-stride = <0x0 0x20000>;	// 128kB stride
> +		reg = <0x0 0x80600000 0x0 0x10000>, /* GICD */
> +		      <0x0 0x80660000 0x0 0x40000>; /* GICR */
> +		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	cpus {

cpus go before soc.

> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +			};
> +		};
> +
> +		CPU0:cpu@0 {

space after :

> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU1:cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache0 {

l2-cache? or you expect more of l2 caches... ?

> +			compatible = "cache";
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/rd-ac5x.dts b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
> new file mode 100644
> index 000000000000..2655e1658750
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree For AC5X.
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + */
> +/*
> + * Device Tree file for Marvell Alleycat 5X development board
> + * This board file supports the B configuration of the board
> + */
> +
> +/dts-v1/;
> +
> +#include "armada-98dx2530.dtsi"
> +
> +/ {
> +	model = "Marvell RD-AC5X Board";
> +	compatible = "marvell,ac5x", "marvell,ac5";

Not documented.

> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x2 0x00000000 0x0 0x40000000>;
> +	};
> +};
> +
> +&mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	phy-handle = <&phy0>;
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	spiflash0: spi-flash@0 {

flash

Please run `make dtbs_check`, to use automated tools instead of
reviewers time.



Best regards,
Krzysztof
