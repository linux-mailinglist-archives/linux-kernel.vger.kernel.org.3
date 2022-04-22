Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5750BEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiDVRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiDVRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:32:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76865F3A72;
        Fri, 22 Apr 2022 10:29:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1B70A1F45B93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647691;
        bh=mFcL/1JB0bpULDjPhR/pGffl1kiDtxIA7ZLnxgFeEPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGaYhOjgR+8cDjthNqexwZsfYvC1kjlw8Qdt2mTVd/pRntr0mry2C68LiLyLU0XHm
         XA1ogeJDtcXqqUcJefTh1Beus7/7I9fhOAboaiTOrnQFP56rRPY5ewHTMSLY35wYsK
         09ypu1qAkeA3ffKQVT6ZRzTO630OBO2yUQblMD3fXFdUJ+lD8WvMu+uVDS4QqQzr0U
         fbo0mFzl8U04EZWzLEO9iqUu9z7tSLbwE89qvb1FpeO1qc8JbUmevbkCwmS45vvKmZ
         h/cZHUHJjTM3X6v19THCgYPOsxsfqTdPtC8DUnMAUWwcHMkHMWqe19QVh1tpT7BfjP
         x/fLCXtNTYUtA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id ED9C1480C2B; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 18/19] arm64: dts: rockchip: Add base DT for rk3588 SoC
Date:   Fri, 22 Apr 2022 19:09:19 +0200
Message-Id: <20220422170920.401914-19-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kever Yang <kever.yang@rock-chips.com>

This initial version supports (single core) CPU, dma, interrupts, timers,
UART and SDHCI. In short - everything necessary to boot Linux on this
system on chip.

The DT is split into rk3588 and rk3588s, which is a reduced version
(i.e. with less peripherals) of the former.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
[rebase, squash and reword commit message]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588.dtsi  |   6 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 501 ++++++++++++++++++++++
 include/dt-bindings/clock/rk3588-cru.h    |   1 +
 3 files changed, 508 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
new file mode 100644
index 000000000000..ddb3ccff1299
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+#include "rk3588s.dtsi"
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
new file mode 100644
index 000000000000..f7d3ad4384b3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/clock/rk3588-cru.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "rockchip,rk3588";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		spll: spll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <702000000>;
+			clock-output-names = "spll";
+		};
+
+		xin24m: xin24m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "xin24m";
+		};
+
+		xin32k: xin32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "xin32k";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_l0>;
+				};
+			};
+		};
+
+		cpu_l0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l0>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <228>;
+		};
+
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <3145728>;
+			cache-line-size = <64>;
+			cache-sets = <4096>;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu_l0>;
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			shmem = <&scmi_shmem>;
+			arm,smc-id = <0x82000010>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+
+				assigned-clocks = <&scmi_clk SCMI_SPLL>;
+				assigned-clock-rates = <700000000>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+
+		sdei: sdei {
+			compatible = "arm,sdei-1.0";
+			method = "smc";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	sram@10f000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x0010f000 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x0010f000 0x100>;
+
+		scmi_shmem: sram@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x100>;
+		};
+	};
+
+	php_grf: syscon@fd5b0000 {
+		compatible = "rockchip,rk3588-php-grf", "syscon";
+		reg = <0x0 0xfd5b0000 0x0 0x1000>;
+	};
+
+	ioc: syscon@fd5f0000 {
+		compatible = "rockchip,rk3588-ioc", "syscon";
+		reg = <0x0 0xfd5f0000 0x0 0x10000>;
+	};
+
+	syssram: sram@fd600000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0xfd600000 0x0 0x100000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xfd600000 0x100000>;
+	};
+
+	cru: clock-controller@fd7c0000 {
+		compatible = "rockchip,rk3588-cru";
+		rockchip,grf = <&php_grf>;
+		reg = <0x0 0xfd7c0000 0x0 0x5c000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		assigned-clocks =
+			<&cru PLL_PPLL>, <&cru PLL_AUPLL>,
+			<&cru PLL_NPLL>, <&cru PLL_GPLL>,
+			<&cru ACLK_CENTER_ROOT>,
+			<&cru HCLK_CENTER_ROOT>, <&cru ACLK_CENTER_LOW_ROOT>,
+			<&cru ACLK_TOP_ROOT>, <&cru PCLK_TOP_ROOT>,
+			<&cru ACLK_LOW_TOP_ROOT>, <&cru PCLK_PMU0_ROOT>,
+			<&cru HCLK_PMU_CM0_ROOT>, <&cru ACLK_VOP>,
+			<&cru ACLK_BUS_ROOT>, <&cru CLK_150M_SRC>,
+			<&cru CLK_GPU>;
+		assigned-clock-rates =
+			<100000000>, <786432000>,
+			<850000000>, <1188000000>,
+			<702000000>,
+			<400000000>, <500000000>,
+			<800000000>, <100000000>,
+			<400000000>, <100000000>,
+			<200000000>, <500000000>,
+			<375000000>, <150000000>,
+			<200000000>;
+	};
+
+	sdhci: mmc@fe2e0000 {
+		compatible = "rockchip,rk3588-dwcmshc", "snps,dwcmshc-sdhci";
+		reg = <0x0 0xfe2e0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru BCLK_EMMC>, <&cru TMCLK_EMMC>, <&cru CCLK_EMMC>;
+		assigned-clock-rates = <200000000>, <24000000>, <200000000>;
+		clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
+			 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
+			 <&cru TMCLK_EMMC>;
+		clock-names = "core", "bus", "axi", "block", "timer";
+		resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
+			 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
+			 <&cru SRST_T_EMMC>;
+		reset-names = "core", "bus", "axi", "block", "timer";
+		max-frequency = <200000000>;
+		status = "disabled";
+	};
+
+	gic: interrupt-controller@fe600000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0xfe600000 0 0x10000>, /* GICD */
+		      <0x0 0xfe680000 0 0x100000>; /* GICR */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		its: interrupt-controller@fe640000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe640000 0x0 0x20000>;
+		};
+	};
+
+	dmac0: dma-controller@fea10000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x0 0xfea10000 0x0 0x4000>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_DMAC0>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+		arm,pl330-periph-burst;
+	};
+
+	dmac1: dma-controller@fea30000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x0 0xfea30000 0x0 0x4000>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_DMAC1>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+		arm,pl330-periph-burst;
+	};
+
+	dmac2: dma-controller@fed10000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x0 0xfed10000 0x0 0x4000>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_DMAC2>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+		arm,pl330-periph-burst;
+	};
+
+	uart0: serial@fd890000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfd890000 0x0 0x100>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac0 6>, <&dmac0 7>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart0m1_xfer>;
+		status = "disabled";
+	};
+
+	uart1: serial@feb40000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb40000 0x0 0x100>;
+		interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac0 8>, <&dmac0 9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart1m1_xfer>;
+		status = "disabled";
+	};
+
+	uart2: serial@feb50000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb50000 0x0 0x100>;
+		interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac0 10>, <&dmac0 11>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2m1_xfer>;
+		status = "disabled";
+	};
+
+	uart3: serial@feb60000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb60000 0x0 0x100>;
+		interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac0 12>, <&dmac0 13>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart3m1_xfer>;
+		status = "disabled";
+	};
+
+	uart4: serial@feb70000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb70000 0x0 0x100>;
+		interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac1 9>, <&dmac1 10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart4m1_xfer>;
+		status = "disabled";
+	};
+
+	uart5: serial@feb80000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb80000 0x0 0x100>;
+		interrupts = <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac1 11>, <&dmac1 12>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart5m1_xfer>;
+		status = "disabled";
+	};
+
+	uart6: serial@feb90000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeb90000 0x0 0x100>;
+		interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac1 13>, <&dmac1 14>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart6m1_xfer>;
+		status = "disabled";
+	};
+
+	uart7: serial@feba0000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfeba0000 0x0 0x100>;
+		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac2 7>, <&dmac2 8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart7m1_xfer>;
+		status = "disabled";
+	};
+
+	uart8: serial@febb0000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfebb0000 0x0 0x100>;
+		interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac2 9>, <&dmac2 10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart8m1_xfer>;
+		status = "disabled";
+	};
+
+	uart9: serial@febc0000 {
+		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xfebc0000 0x0 0x100>;
+		interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		dmas = <&dmac2 11>, <&dmac2 12>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart9m1_xfer>;
+		status = "disabled";
+	};
+
+	pinctrl: pinctrl {
+		compatible = "rockchip,rk3588-pinctrl";
+		rockchip,grf = <&ioc>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpio0: gpio@fd8a0000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xfd8a0000 0x0 0x100>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO0>, <&cru DBCLK_GPIO0>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@fec20000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xfec20000 0x0 0x100>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@fec30000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xfec30000 0x0 0x100>;
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@fec40000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xfec40000 0x0 0x100>;
+			interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 96 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio4: gpio@fec50000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xfec50000 0x0 0x100>;
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 128 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+#include "rk3588s-pinctrl.dtsi"
diff --git a/include/dt-bindings/clock/rk3588-cru.h b/include/dt-bindings/clock/rk3588-cru.h
index d51e6ed939b3..2f046f048a83 100644
--- a/include/dt-bindings/clock/rk3588-cru.h
+++ b/include/dt-bindings/clock/rk3588-cru.h
@@ -1451,6 +1451,7 @@
 #define SCMI_CRYPTO_CORE		20
 #define SCMI_CRYPTO_PKA			21
 #define SCMI_SPLL			22
+#define SCMI_HCLK_SD			23
 
 /********Name=SECURE_SOFTRST_CON00,Offset=0xA00********/
 #define SRST_A_SECURE_NS_BIU		10
-- 
2.35.1

