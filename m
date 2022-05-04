Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03B51B110
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378764AbiEDVhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378705AbiEDVgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FD517EB;
        Wed,  4 May 2022 14:33:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BE2F81F44D2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651699980;
        bh=DzFqth0GOLPYKYoLgRJZNeDQbNY4Pd7djnOZo0tjuTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4xDXXAiqpiauqeQioGQicuL93Y0qS54KZZ01pLA8MEqXFU2zUrLZyd97Ng7tX0XW
         9E5LEKiUxt51/eQPVsC1mAGSMXaMcmPY9F4rk/83y4or7KZMQiXwJdnlK8QBdSPVY3
         jpherygmFLu8vFsRvSSl8u/NF7dpTrA+ovjWKhipbFFU9rIvJY1Df+r3dqXkGdMd3P
         t0Pfr8eVoNmvBAaldADGDFaJhpO5bP6R3wuFFjEjVdo9xkU+1ZgpDo2/uysf7iL6Ab
         h6wIntWqNqMTYG72FfDi+FDd85nkalNJpXGouBNovlvTWa3173boUhChO3K3lm+eld
         ig4gigc4lITYw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6056D4819D9; Wed,  4 May 2022 23:32:53 +0200 (CEST)
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
Subject: [PATCHv2 20/21] arm64: dts: rockchip: Add base DT for rk3588 SoC
Date:   Wed,  4 May 2022 23:32:50 +0200
Message-Id: <20220504213251.264819-21-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504213251.264819-1-sebastian.reichel@collabora.com>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 719 ++++++++++++++++++++++
 2 files changed, 725 insertions(+)
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
index 000000000000..618cee445e02
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -0,0 +1,719 @@
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
+	spll: clock-0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <702000000>;
+		clock-output-names = "spll";
+	};
+
+	xin24m: clock-1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
+	xin32k: clock-2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
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
+				core1 {
+					cpu = <&cpu_l1>;
+				};
+				core2 {
+					cpu = <&cpu_l2>;
+				};
+				core3 {
+					cpu = <&cpu_l3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&cpu_b0>;
+				};
+				core1 {
+					cpu = <&cpu_b1>;
+				};
+			};
+			cluster2 {
+				core0 {
+					cpu = <&cpu_b2>;
+				};
+				core1 {
+					cpu = <&cpu_b3>;
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
+			cpu-idle-states = <&CPU_SLEEP>;
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
+		cpu_l1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l1>;
+		};
+
+		cpu_l2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l2>;
+		};
+
+		cpu_l3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache_l3>;
+		};
+
+		cpu_b0: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache_b0>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <416>;
+		};
+
+		cpu_b1: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache_b1>;
+		};
+
+		cpu_b2: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache_b2>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <416>;
+		};
+
+		cpu_b3: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_cache_b3>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <100>;
+				exit-latency-us = <120>;
+				min-residency-us = <1000>;
+			};
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
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l2: l2-cache-l2 {
+			compatible = "cache";
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l3: l2-cache-l3 {
+			compatible = "cache";
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_b0: l2-cache-b0 {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_b1: l2-cache-b1 {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_b2: l2-cache-b2 {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_b3: l2-cache-b3 {
+			compatible = "cache";
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
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
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-a76 {
+		compatible = "arm,cortex-a76-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
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
+				assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>,
+						  <&scmi_clk SCMI_CLK_CPUB23>;
+				assigned-clock-rates = <1200000000>,
+						       <1200000000>;
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
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
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
+		compatible = "rockchip,rk3588-dwcmshc";
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
+		mbi-alias = <0x0 0xfe610000>;
+		mbi-ranges = <424 56>;
+		msi-controller;
+
+		ppi-partitions {
+			interrupt-partition-0 {
+				affinity = <
+					&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3
+					&cpu_b0 &cpu_b1 &cpu_b2 &cpu_b3
+				>;
+			};
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
-- 
2.35.1

