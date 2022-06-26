Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7B55B38E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFZSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiFZScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:32:54 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878EE002
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:32:51 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 43B8C3F35F;
        Sun, 26 Jun 2022 20:32:48 +0200 (CEST)
Message-ID: <f8aa5f81-e77c-db28-519d-7d9ee119dcf3@somainline.org>
Date:   Sun, 26 Jun 2022 20:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 7/8] arm64: dts: Add ipq5018 SoC and MP03 board support
Content-Language: en-US
To:     Sricharan R <quic_srichara@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-8-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220621161126.15883-8-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2022 18:11, Sricharan R wrote:
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> MP03.1-C2 board.
> 
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts |  29 +++
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 221 ++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f9e6343acd03..c44e701f093c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
> new file mode 100644
> index 000000000000..d1cd080ec3db
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.1-c2.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 CP01 board device tree source
> + *
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03-C2";
> +	compatible = "qcom,ipq5018-mp03", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&serial_1_pins>;
> +	pinctrl-names = "default";
> +	status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> new file mode 100644
> index 000000000000..084fb7b30dfd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * Copyright (c) 2017-2021, The Linux Foundation. All rights reserved.
> + */
> +/*
> + * IPQ5018 SoC device tree source
> + *
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&intc>;
Hi!

interrupt-parent could go first.

> +
> +	sleep_clk: sleep-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	xo: xo {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	gen2clk0: gen2clk0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "pcie20_phy0_pipe_clk";
> +	};
> +
> +	gen2clk1: gen2clk1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "pcie20_phy1_pipe_clk";
> +	};
I am not sure what's the current stance on this, but previously clock nodes
used to be wrapped in a clocks {} node, as currently they are not sorted
properly.


> +
> +	cpus: cpus {
Is this label going to be used?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			enable-method = "psci";
> +			reg = <0x1>;
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <0x2>;
This should probably be dec, as it's not a register.

> +		};
> +	};
> +
> +	pmuv8: pmu {
Are there any other PMUs? And is this label going to be used?

> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
> +					 IRQ_TYPE_LEVEL_HIGH)>;
I think this can fit in a single 100-char line.


> +	};
> +
> +	psci: psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	memory@40000000 {
This node is not sorted properly.

> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x40000000 0x0 0x0>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz: tz@4ac00000 {
Please rename it to tz_memory or tz_region or something more
descriptive. Also, memory@
> +			reg = <0x0 0x4ac00000 0x0 0x00400000>;
I don't think we tend to pad size to 8 hex digits.

> +			no-map;
> +		};
> +	};
> +
> +	timer {
This is not sorted properly.

> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
Isn't that the default value?

> +		compatible = "simple-bus";
Please sort the properties.

> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq5018-pinctrl";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 80>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			serial_1_pins: serial1-pinmux {
Other DTs call it uart pins, also this is the default/poweron
state but the hardware provides support for sleep/poweroff.
Please rename this accordingly.

> +				pins = "gpio31", "gpio32", "gpio33", "gpio34";
> +				function = "blsp1_uart1";
> +				drive-strength = <8>;
> +				bias-pull-down;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-ipq5018";
> +			reg = <0x01800000 0x80000>;
> +			clocks = <&xo>, <&sleep_clk>;
> +			clock-names = "xo", "sleep_clk";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		blsp1_uart1: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				<&gcc GCC_BLSP1_AHB_CLK>;
Not sure whether thunderbird is dumb again, or the indentation
is off by 1 space.

> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
Please sort the properties (compatible and reg gotta go first, etc.).

> +			interrupt-controller;
> +			#interrupt-cells = <0x3>;
*-cells should be decimal.


> +			reg =   <0x0b000000 0x1000>,  /*GICD*/
/* GICD */, please (and the next ones too)
> +				<0x0b002000 0x1000>,  /*GICC*/
> +				<0x0b001000 0x1000>,  /*GICH*/
> +				<0x0b004000 0x1000>;  /*GICV*/
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		timer@b120000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			clock-frequency = <19200000>;
Please sort the properties, also in subnodes.

Konrad
> +
> +			frame@b120000 {
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
> +			};
> +
> +			frame@b123000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0xb123000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b124000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b125000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b126000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b127000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b128000 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
> 
