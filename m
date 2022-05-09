Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7B51FAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiEILNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiEILNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:13:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FC19CEFE;
        Mon,  9 May 2022 04:09:34 -0700 (PDT)
X-UUID: 666e350eeaa842e48b7e5682603f0216-20220509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c0d3425c-5d41-4ab0-aa20-50e53e047106,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:dd68bf16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 666e350eeaa842e48b7e5682603f0216-20220509
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1132979491; Mon, 09 May 2022 19:09:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 9 May 2022 19:09:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 9 May 2022 19:09:25 +0800
Message-ID: <0cc640e5246ed73bf7d333bd7f605da5fd4be179.camel@mediatek.com>
Subject: Re: [PATCH v9 4/4] arm64: dts: Add MediaTek SoC MT8186 dts and
 evaluation board and Makefile
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, <hsinyi@chromium.org>
Date:   Mon, 9 May 2022 19:09:25 +0800
In-Reply-To: <20220506093843.29030-5-allen-kh.cheng@mediatek.com>
References: <20220506093843.29030-1-allen-kh.cheng@mediatek.com>
         <20220506093843.29030-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-06 at 17:38 +0800, Allen-KH Cheng wrote:
> Add basic chip support for MediaTek MT8186.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 232 +++++
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 975
> ++++++++++++++++++++
>  3 files changed, 1208 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
> b/arch/arm64/boot/dts/mediatek/Makefile
> index c7d4636a2cb7..50a2c58c5f56 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -37,6 +37,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-
> sku32.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> new file mode 100644
> index 000000000000..7fbd932a763e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8186.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8186 evaluation board";
> +	compatible = "mediatek,mt8186-evb", "mediatek,mt8186";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <8000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <10000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pins>;
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c7_pins>;
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8_pins>;
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c9_pins>;
> +	status = "okay";
> +};
> +
> +&pio {
> +	i2c0_pins: i2c0{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO128__FUNC_SDA0>,
> +				 <PINMUX_GPIO127__FUNC_SCL0>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;

Hello Allen,

one space before <0> and the same below.

> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO130__FUNC_SDA1>,
> +				 <PINMUX_GPIO129__FUNC_SCL1>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO132__FUNC_SDA2>,
> +				 <PINMUX_GPIO131__FUNC_SCL2>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c3_pins: i2c3{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO134__FUNC_SDA3>,
> +				 <PINMUX_GPIO133__FUNC_SCL3>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO136__FUNC_SDA4>,
> +				 <PINMUX_GPIO135__FUNC_SCL4>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c5_pins: i2c5{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO138__FUNC_SDA5>,
> +				 <PINMUX_GPIO137__FUNC_SCL5>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c6_pins: i2c6{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO140__FUNC_SDA6>,
> +				 <PINMUX_GPIO139__FUNC_SCL6>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c7_pins: i2c7{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO142__FUNC_SDA7>,
> +				 <PINMUX_GPIO141__FUNC_SCL7>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c8_pins: i2c8{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO144__FUNC_SDA8>,
> +				 <PINMUX_GPIO143__FUNC_SCL8>;
> +			bias-disable;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c9_pins: i2c9{
> +		pins-sda-scl {
> +			pinmux = <PINMUX_GPIO146__FUNC_SDA9>,
> +				 <PINMUX_GPIO145__FUNC_SCL9>;
> +			bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +			mediatek,drive-strength-adv =<0>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +&u3phy0 {
> +	status="okay";
> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&xhci0 {
> +	status = "okay";
> +};
> +
> +&xhci1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..fdb40542b22a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,975 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> + */
> +/dts-v1/;
> +#include <dt-bindings/clock/mt8186-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> +#include <dt-bindings/power/mt8186-power.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/reset/mt8186-resets.h>
> +
> +/ {
> +	compatible = "mediatek,mt8186";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2000000000>;
> +			capacity-dmips-mhz = <382>;
> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
> +			next-level-cache = <&l2_0>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a75";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a75";

I think we are using ca76..
If there is any mistake, please correct me.

> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <2050000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
> +			next-level-cache = <&l2_1>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			cpu_off_l: cpu-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1600>;
> +			};
> +
> +			cpu_off_b: cpu-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <1400>;
> +			};
> +
> +			cluster_off_l: cluster-off-l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <2100>;
> +			};
> +
> +			cluster_off_b: cluster-off-b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010001>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <1900>;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l3_0: l3-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	clk13m: oscillator-13m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <13000000>;
> +		clock-output-names = "clk13m";
> +	};
> +
> +	clk26m: oscillator-26m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: oscillator-32k {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2
> &cpu3 &cpu4 &cpu5>;
> +				};
> +
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +
> +		mcusys: syscon@c53a000 {
> +			compatible = "mediatek,mt8186-mcusys",
> "syscon";
> +			reg = <0 0xc53a000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8186-topckgen",
> "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg_ao: syscon@10001000 {
> +			compatible = "mediatek,mt8186-infracfg_ao",
> "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8186-pericfg",
> "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +		};
> +
> +		pio: pinctrl@10005000 {
> +			compatible = "mediatek,mt8186-pinctrl";
> +			reg = <0 0x10005000 0 0x1000>,
> +			      <0 0x10002000 0 0x0200>,
> +			      <0 0x10002200 0 0x0200>,
> +			      <0 0x10002400 0 0x0200>,
> +			      <0 0x10002600 0 0x0200>,
> +			      <0 0x10002A00 0 0x0200>,
> +			      <0 0x10002c00 0 0x0200>,
> +			      <0 0x1000b000 0 0x1000>;

Use upper case for 0x10002c00 and 0x1000b000?

> +			reg-names = "iocfg0", "iocfg_lt", "iocfg_lm",
> "iocfg_lb",
> +				    "iocfg_bl", "iocfg_rb", "iocfg_rt",
> "eint";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pio 0 0 185>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;
> +
> +			/* System Power Manager */
> +			spm: power-controller {
> +				compatible = "mediatek,mt8186-power-
> controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domain of the SoC */
> +				mfg0: power-domain@MT8186_POWER_DOMAIN_
> MFG0 {
> +					reg =
> <MT8186_POWER_DOMAIN_MFG0>;
> +					clocks = <&topckgen
> CLK_TOP_MFG>;
> +					clock-names= "mfg00";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_MFG1 {
> +						reg =
> <MT8186_POWER_DOMAIN_MFG1>;
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells =
> <1>;
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_MFG2 {
> +							reg =
> <MT8186_POWER_DOMAIN_MFG2>;
> +							#power-domain-
> cells = <0>;
> +						};
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_MFG3 {
> +							reg =
> <MT8186_POWER_DOMAIN_MFG3>;
> +							#power-domain-
> cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_CSIRX_
> TOP {
> +					reg =
> <MT8186_POWER_DOMAIN_CSIRX_TOP>;
> +					clocks = <&topckgen
> CLK_TOP_SENINF>,
> +						 <&topckgen
> CLK_TOP_SENINF1>;
> +					clock-names= "csirx_top0",
> "csirx_top1";
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB
> {
> +					reg =
> <MT8186_POWER_DOMAIN_SSUSB>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB_
> P1 {
> +					reg =
> <MT8186_POWER_DOMAIN_SSUSB_P1>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_ADSP_A
> O {
> +					reg =
> <MT8186_POWER_DOMAIN_ADSP_AO>;
> +					clocks = <&topckgen
> CLK_TOP_AUDIODSP>,
> +						 <&topckgen
> CLK_TOP_ADSP_BUS>;
> +					clock-names= "adsp_ao0",
> "adsp_ao1";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_ADSP_INFRA {
> +						reg =
> <MT8186_POWER_DOMAIN_ADSP_INFRA>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells =
> <1>;
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_ADSP_TOP {
> +							reg =
> <MT8186_POWER_DOMAIN_ADSP_TOP>;
> +							mediatek,infrac
> fg = <&infracfg_ao>;
> +							#power-domain-
> cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_CONN_O
> N {
> +					reg =
> <MT8186_POWER_DOMAIN_CONN_ON>;
> +					mediatek,infracfg =
> <&infracfg_ao>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_DIS {
> +					reg =
> <MT8186_POWER_DOMAIN_DIS>;
> +					clocks = <&topckgen
> CLK_TOP_DISP>,
> +						 <&topckgen
> CLK_TOP_MDP>,
> +						 <&mmsys
> CLK_MM_SMI_INFRA>,
> +						 <&mmsys
> CLK_MM_SMI_COMMON>,
> +						 <&mmsys
> CLK_MM_SMI_GALS>,
> +						 <&mmsys
> CLK_MM_SMI_IOMMU>;
> +					clock-names= "dis0", "dis1",
> "dis-0", "dis-1",
> +						     "dis-2", "dis-3";
> +					mediatek,infracfg =
> <&infracfg_ao>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_VDEC {
> +						reg =
> <MT8186_POWER_DOMAIN_VDEC>;
> +						clocks = <&topckgen
> CLK_TOP_VDEC>,
> +							 <&vdecsys
> CLK_VDEC_LARB1_CKEN>;
> +						clock-names= "vdec0",
> "vdec-0";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#power-domain-cells =
> <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_CAM {
> +						reg =
> <MT8186_POWER_DOMAIN_CAM>;
> +						clocks = <&topckgen
> CLK_TOP_CAM>,
> +							 <&topckgen
> CLK_TOP_SENINF>,
> +							 <&topckgen
> CLK_TOP_SENINF1>,
> +							 <&topckgen
> CLK_TOP_SENINF2>,
> +							 <&topckgen
> CLK_TOP_SENINF3>,
> +							 <&topckgen
> CLK_TOP_CAMTM>,
> +							 <&camsys
> CLK_CAM2MM_GALS>;
> +						clock-names= "cam0",
> "cam1", "cam2", "cam3",
> +							     "cam4",
> "cam5", "cam-0";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells =
> <1>;
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_CAM_RAWB {
> +							reg =
> <MT8186_POWER_DOMAIN_CAM_RAWB>;
> +							#power-domain-
> cells = <0>;
> +						};
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_CAM_RAWA {
> +							reg =
> <MT8186_POWER_DOMAIN_CAM_RAWA>;
> +							#power-domain-
> cells = <0>;
> +						};
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_IMG {
> +						reg =
> <MT8186_POWER_DOMAIN_IMG>;
> +						clocks = <&topckgen
> CLK_TOP_IMG1>,
> +							 <&imgsys1
> CLK_IMG1_GALS_IMG1>;
> +						clock-names = "img0",
> "img-0";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells =
> <1>;
> +
> +						power-domain@MT8186_POW
> ER_DOMAIN_IMG2 {
> +							reg =
> <MT8186_POWER_DOMAIN_IMG2>;
> +							#power-domain-
> cells = <0>;
> +						};
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_IPE {
> +						reg =
> <MT8186_POWER_DOMAIN_IPE>;
> +						clocks = <&topckgen
> CLK_TOP_IPE>,
> +							 <&ipesys
> CLK_IPE_LARB19>,
> +							 <&ipesys
> CLK_IPE_LARB20>,
> +							 <&ipesys
> CLK_IPE_SMI_SUBCOM>,
> +							 <&ipesys
> CLK_IPE_GALS_IPE>;
> +						clock-names= "ipe0",
> "ipe-0", "ipe-1", "ipe-2",
> +							     "ipe-3";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#power-domain-cells =
> <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_VENC {
> +						reg =
> <MT8186_POWER_DOMAIN_VENC>;
> +						clocks = <&topckgen
> CLK_TOP_VENC>,
> +							 <&vencsys
> CLK_VENC_CKE1_VENC>;
> +						clock-names= "venc0",
> "venc-0";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#power-domain-cells =
> <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAI
> N_WPE {
> +						reg =
> <MT8186_POWER_DOMAIN_WPE>;
> +						clocks = <&topckgen
> CLK_TOP_WPE>,
> +							 <&wpesys
> CLK_WPE_SMI_LARB8_CK_EN>,
> +							 <&wpesys
> CLK_WPE_SMI_LARB8_PCLK_EN>;
> +						clock-names= "wpe0",
> "wpe-0", "wpe-1";
> +						mediatek,infracfg =
> <&infracfg_ao>;
> +						#power-domain-cells =
> <0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8186-wdt",
> +				     "mediatek,mt6589-wdt";
> +			mediatek,disable-extrst;
> +			reg = <0 0x10007000 0 0x1000>;
> +			#reset-cells = <1>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8186-apmixedsys",
> "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};

pwrap is upstream done, I think we also can add pwrap: pwrap@1000d000?

> +
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8186-timer",
> +				     "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk13m>;
> +		};
> +
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8186-scp";
> +			reg = <0 0x10500000 0 0x40000>,
> +			      <0 0x105c0000 0 0x19080>;
> +			reg-names = "sram", "cfg";
> +			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		nor_flash: spi@11000000 {
> +			compatible = "mediatek,mt8186-nor",
> "mediatek,mt8173-nor";
> +			reg = <0 0x11000000 0 0x1000>;
> +			clocks = <&topckgen CLK_TOP_SPINOR>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPINOR>,
> +				 <&infracfg_ao
> CLK_INFRA_AO_FLASHIF_133M>,
> +				 <&infracfg_ao
> CLK_INFRA_AO_FLASHIF_66M>;
> +			clock-names = "spi", "sf", "axi", "axi_s";
> +			assigned-clocks = <&topckgen CLK_TOP_SPINOR>;
> +			assigned-clock-parents = <&topckgen
> CLK_TOP_UNIVPLL_D3_D8>;
> +			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		auxadc: adc@11001000 {
> +			compatible = "mediatek,mt8186-auxadc",
> "mediatek,mt8173-auxadc";
> +			reg = <0 0x11001000 0 0x1000>;
> +			#io-channel-cells = <1>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_AUXADC>;
> +			clock-names = "main";
> +			status = "okay";
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&infracfg_ao
> CLK_INFRA_AO_UART0>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8186-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&infracfg_ao
> CLK_INFRA_AO_UART1>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c0@11007000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11007000 0 0x1000>,
> +			      <0 0x10200100 0 0x100>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C0>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c1@11008000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11008000 0 0x1000>,
> +			      <0 0x10200200 0 0x100>;
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C1>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c2@11009000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11009000 0 0x1000>,
> +			      <0 0x10200300 0 0x180>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C2>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c3@1100f000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x1100f000 0 0x1000>,
> +			      <0 0x10200480 0 0x100>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C3>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c4@11011000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11011000 0 0x1000>,
> +			      <0 0x10200580 0 0x180>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C4>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c5: i2c5@11016000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11016000 0 0x1000>,
> +			      <0 0x10200700 0 0x100>;
> +			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c6: i2c6@1100d000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x1100d000 0 0x1000>,
> +			      <0 0x10200800 0 0x100>;
> +			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C6>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c7: i2c7@11004000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11004000 0 0x1000>,
> +			      <0 0x10200900 0 0x180>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C7>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		i2c8: i2c8@11005000 {
> +			compatible = "mediatek,mt8186-i2c";
> +			reg = <0 0x11005000 0 0x1000>,
> +			      <0 0x10200A80 0 0x180>;
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&imp_iic_wrap
> CLK_IMP_IIC_WRAP_AP_CLOCK_I2C8>,
> +				 <&infracfg_ao CLK_INFRA_AO_AP_DMA>;
> +			clock-names = "main", "dma";
> +			clock-div = <1>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@11010000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11010000 0 0x1000>;
> +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI1>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +
> +		spi2: spi@11012000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11012000 0 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI2>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +
> +		spi3: spi@11013000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11013000 0 0x1000>;
> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI3>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +
> +		spi4: spi@11014000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11014000 0 0x1000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI4>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +
> +		spi5: spi@11015000 {
> +			compatible = "mediatek,mt8186-spi",
> "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11015000 0 0x1000>;
> +			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI5>;
> +			clock-names = "parent-clk", "sel-clk", "spi-
> clk";
> +			status = "disabled";
> +		};
> +

disp_pwm is also upstreamed done and it's in linux-next next-20220506:
disp_pwm: disp_pwm0@1100e000

BRs,
Rex
> +		imp_iic_wrap: clock-controller@11017000 {
> +			compatible = "mediatek,mt8186-imp_iic_wrap";
> +			reg = <0 0x11017000 0 0x1000>;


