Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE051BADB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbiEEIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbiEEIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE844A3E0;
        Thu,  5 May 2022 01:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22D20B82C0D;
        Thu,  5 May 2022 08:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A16C385A4;
        Thu,  5 May 2022 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651740252;
        bh=H4Qi6SUCIpCqS/rh+vJQHsTKxqYfNDstlPd2rUSr3QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwZHVP1Sw0dEFqSm70LigWGZ8/9UCkEtQeZ3l+JhgRpqley2hpiMlJtLJjw5eeUIX
         Od9VkX4tAZNoqDcTpJRBjnCadk7I1XEbRfHyW5KijbQfy8l7xPvzUqiuGYLarN/w7J
         SijpiGRYlMbidXIOswG2YKwxn53+1CF4jVVNEEcmkr5IJFtHoEvUrkhzweR1frFYCi
         HF/Qc+nLhgVxQHsRL782vkuSLJbWnzEoQJnfwoyjX9UJGWKiHqT/nNlTg1kumI9TWj
         mNWqjAYwJyQR/azJTaBCLruOVAMBwfoRD+WSi343QwlPErYfrhlv/M/j//Eetj1XzP
         MyCcSX1EPYt5A==
Date:   Thu, 5 May 2022 16:44:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Message-ID: <20220505084404.GF14615@dragon>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220503122951.4147636-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503122951.4147636-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 08:29:49PM +0800, Peng Fan (OSS) wrote:
...
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> new file mode 100644
> index 000000000000..ae8daffe3492
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#include <dt-bindings/clock/imx93-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "imx93-pinfunc.h"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc2 = &usdhc3;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		serial7 = &lpuart8;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		A55_0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +		};
> +
> +		A55_1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			#cooling-cells = <2>;
> +		};
> +
> +	};
> +
> +	osc_32k: clock-osc-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc_32k";
> +	};
> +
> +	osc_24m: clock-osc-24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc_24m";
> +	};
> +
> +	clk_ext1: clock-ext1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <133000000>;
> +		clock-output-names = "clk_ext1";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <24000000>;
> +		arm,no-tick-in-suspend;
> +		interrupt-parent = <&gic>;
> +	};
> +
> +	gic: interrupt-controller@48000000 {
> +		compatible = "arm,gic-v3";
> +		reg = <0 0x48000000 0 0x10000>,
> +		      <0 0x48040000 0 0xc0000>;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +	};
> +
> +	soc@0 {

Why do we need unit-address '@0' here?

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x80000000>,
> +			 <0x28000000 0x0 0x28000000 0x10000000>;
> +
> +		aips1: bus@44000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x44000000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			mu1: mailbox@44230000 {
> +				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
> +				reg = <0x44230000 0x10000>;
> +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			system_counter: timer@44290000 {
> +				compatible = "nxp,sysctr-timer";
> +				reg = <0x44290000 0x30000>;
> +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&osc_24m>;
> +				clock-names = "per";
> +			};
> +
> +			lpuart1: serial@44380000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x44380000 0x1000>;
> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart2: serial@44390000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x44390000 0x1000>;
> +				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
> +				clock-names = "ipg";
> +				status = "okay";

We only use "okay" status to flip "disabled" device at board level.

> +			};
> +
> +			iomuxc: pinctrl@443c0000 {
> +				compatible = "fsl,imx93-iomuxc";
> +				reg = <0x443c0000 0x10000>;
> +			};
> +
> +			clk: clock-controller@44450000 {
> +				compatible = "fsl,imx93-ccm";
> +				reg = <0x44450000 0x10000>;
> +				#clock-cells = <1>;
> +				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
> +				clock-names = "osc_32k", "osc_24m", "clk_ext1";
> +				status = "okay";
> +			};
> +
> +			anatop: anatop@44480000 {
> +				compatible = "fsl,imx93-anatop", "syscon";
> +				reg = <0x44480000 0x10000>;
> +			};
> +		};
> +
> +		aips2: bus@42000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x42000000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			mu2: mailbox@42440000 {
> +				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
> +				reg = <0x42440000 0x10000>;
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
> +			lpuart3: serial@42570000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x42570000 0x1000>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart4: serial@42580000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x42580000 0x1000>;
> +				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
> +				clock-names = "ipg";
> +				status = "okay";
> +			};
> +
> +			lpuart5: serial@42590000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x42590000 0x1000>;
> +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart6: serial@425a0000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x425a0000 0x1000>;
> +				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart7: serial@42690000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x42690000 0x1000>;
> +				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +
> +			lpuart8: serial@426a0000 {
> +				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
> +				reg = <0x426a0000 0x1000>;
> +				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
> +				clock-names = "ipg";
> +				status = "disabled";
> +			};
> +		};
> +
> +		aips3: bus@42800000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			reg = <0x42800000 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			usdhc1: mmc@42850000 {
> +				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x42850000 0x10000>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_USDHC1_GATE>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <8>;
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +
> +			usdhc2: mmc@42860000 {
> +				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x42860000 0x10000>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_USDHC2_GATE>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <4>;
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +
> +			usdhc3: mmc@428b0000 {
> +				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> +				reg = <0x428b0000 0x10000>;
> +				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_DUMMY>,
> +					 <&clk IMX93_CLK_USDHC3_GATE>;
> +				clock-names = "ipg", "ahb", "per";
> +				bus-width = <4>;
> +				fsl,tuning-start-tap = <20>;
> +				fsl,tuning-step= <2>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gpio2: gpio@43810000 {
> +			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> +			reg = <0x43810080 0x1000>, <0x43810040 0x40>;

'make W=1 dtbs' gives the following warnings.

../arch/arm64/boot/dts/freescale/imx93.dtsi:289.24-299.5: Warning (simple_bus_reg): /soc@0/gpio@43810000: simple-bus unit address format error, expected "43810080"
../arch/arm64/boot/dts/freescale/imx93.dtsi:301.24-311.5: Warning (simple_bus_reg): /soc@0/gpio@43820000: simple-bus unit address format error, expected "43820080"
../arch/arm64/boot/dts/freescale/imx93.dtsi:313.24-323.5: Warning (simple_bus_reg): /soc@0/gpio@43830000: simple-bus unit address format error, expected "43830080"
../arch/arm64/boot/dts/freescale/imx93.dtsi:325.24-335.5: Warning (simple_bus_reg): /soc@0/gpio@47400000: simple-bus unit address format error, expected "47400080"

Shawn

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&iomuxc 0 32 32>;
> +		};
> +
> +		gpio3: gpio@43820000 {
> +			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> +			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&iomuxc 0 64 32>;
> +		};
> +
> +		gpio4: gpio@43830000 {
> +			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> +			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&iomuxc 0 96 32>;
> +		};
> +
> +		gpio1: gpio@47400000 {
> +			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> +			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&iomuxc 0 0 32>;
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
