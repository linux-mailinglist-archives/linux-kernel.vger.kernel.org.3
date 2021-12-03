Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A04467735
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380793AbhLCMZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:25:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50562 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380789AbhLCMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:24:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLNCa019359;
        Fri, 3 Dec 2021 06:21:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638534083;
        bh=EZgvT6GYbfv7MwaIYWocC113kjA7XdcHwiTS4QLPVr8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RhT69WSv/aqjsaE5R3x4McMk554buAbKWiczee8C378y/zmuX02Obur0ZNIz1+y2G
         P9AicV3vSdeL/Z18WBOKmeW38YwJUMHeLXBSF4JX06dkHPZF3pVdgVzyPUwl2erLl7
         QuuwxTffwEpwNgrGETv87vmaU41Iee994kJK3BCs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3CLNsU109267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 06:21:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 06:21:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 06:21:23 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLBWO011119;
        Fri, 3 Dec 2021 06:21:20 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 3/5] arm64: dts: ti: Add initial support for J721S2 SoC
Date:   Fri, 3 Dec 2021 17:51:08 +0530
Message-ID: <20211203122110.16736-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203122110.16736-1-a-govindraju@ti.com>
References: <20211203122110.16736-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive ADAS applications and
industrial applications requiring AI at the network edge. This SoC extends
the Jacinto 7 family of SoCs with focus on lowering system costs and power
while providing interfaces, memory architecture and compute performance for
single and multi-sensor applications.

Some highlights of this SoC are:

* Dual Cortex-A72s in a single cluster, three clusters of lockstep capable
dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA), C7x
floating point Vector DSP.
* 3D GPU: Automotive grade IMG BXS-4-64
* Vision Processing Accelerator (VPAC) with image signal processor and
Depth and Motion Processing Accelerator (DMPAC)
* Two CSI2.0 4L RX plus one eDP/DP, two DSI Tx, and one DPI interface.
* Two Ethernet ports with RGMII support.
* Single 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role device subsystems,
* Up to 20 MCANs, 5 McASP, eMMC and SD, OSPI/HyperBus memory controller,
QSPI, I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
* Hardware accelerator blocks containing AES/DES/SHA/MD5 called SA2UL
management.
* Chips and Media Wave521CL H.264/H.265 encode/decode engine

See J721S2 Technical Reference Manual (SPRUJ28 – NOVEMBER 2021)
for further details: http://www.ti.com/lit/pdf/spruj28

Introduce basic support for the J721S2 SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 940 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 302 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 189 ++++
 3 files changed, 1431 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
new file mode 100644
index 000000000000..45e92d535190
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -0,0 +1,940 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J721S2 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>
+
+&cbass_main {
+	msmc_ram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x70000000 0x0 0x400000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x70000000 0x400000>;
+
+		atf-sram@0 {
+			reg = <0x0 0x20000>;
+		};
+
+		tifs-sram@1f0000 {
+			reg = <0x1f0000 0x10000>;
+		};
+
+		l3cache-sram@200000 {
+			reg = <0x200000 0x200000>;
+		};
+	};
+
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		      <0x00 0x01900000 0x00 0x100000>; /* GICR */
+
+		/* vcpumntirq: virtual CPU interface maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: msi-controller@1820000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x00 0x01820000 0x00 0x10000>;
+			socionext,synquacer-pre-its = <0x1000000 0x400000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+
+	main_gpio_intr: interrupt-controller@a00000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <148>;
+		ti,interrupt-ranges = <8 360 56>;
+	};
+
+	main_pmx0: pinctrl@11c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x0 0x11c000 0x0 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x200>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 146 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x200>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 350 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x200>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 351 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart3: serial@2830000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02830000 0x00 0x200>;
+		interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 352 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart4: serial@2840000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02840000 0x00 0x200>;
+		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 353 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart5: serial@2850000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02850000 0x00 0x200>;
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 354 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart6: serial@2860000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02860000 0x00 0x200>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 355 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart7: serial@2870000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02870000 0x00 0x200>;
+		interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 356 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart8: serial@2880000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02880000 0x00 0x200>;
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 357 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_uart9: serial@2890000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x02890000 0x00 0x200>;
+		interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 358 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <145>, <146>, <147>, <148>, <149>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 111 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio2: gpio@610000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00610000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <154>, <155>, <156>, <157>, <158>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 112 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio4: gpio@620000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00620000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <163>, <164>, <165>, <166>, <167>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 113 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio6: gpio@630000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00630000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <172>, <173>, <174>, <175>, <176>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <66>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "gpio";
+	};
+
+	main_i2c0: i2c@2000000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02000000 0x00 0x100>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 214 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 214 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c1: i2c@2010000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02010000 0x00 0x100>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 215 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 215 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c2: i2c@2020000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02020000 0x00 0x100>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 216 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 216 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c3: i2c@2030000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02030000 0x00 0x100>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 217 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c4: i2c@2040000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02040000 0x00 0x100>;
+		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 218 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c5: i2c@2050000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02050000 0x00 0x100>;
+		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 219 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_i2c6: i2c@2060000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02060000 0x00 0x100>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 220 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	main_sdhci0: mmc@4f80000 {
+		compatible = "ti,j721e-sdhci-8bit";
+		reg = <0x00 0x04f80000 0x00 0x1000>,
+		      <0x00 0x04f88000 0x00 0x400>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 98 7>, <&k3_clks 98 1>;
+		clock-names =  "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 98 1>;
+		assigned-clock-parents = <&k3_clks 98 2>;
+		bus-width = <8>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x5>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,strobe-sel = <0x77>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		dma-coherent;
+	};
+
+	main_sdhci1: mmc@4fb0000 {
+		compatible = "ti,j721e-sdhci-4bit";
+		reg = <0x00 0x04fb0000 0x00 0x1000>,
+		      <0x00 0x04fb8000 0x00 0x400>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 99 8>, <&k3_clks 99 1>;
+		clock-names =  "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 99 1>;
+		assigned-clock-parents = <&k3_clks 99 2>;
+		bus-width = <4>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		dma-coherent;
+		/* Masking support for SDR104 capability */
+		sdhci-caps-mask = <0x00000003 0x00000000>;
+	};
+
+	main_navss: bus@30000000 {
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
+		ti,sci-dev-id = <224>;
+		dma-coherent;
+		dma-ranges;
+
+		main_navss_intr: interrupt-controller@310e0000 {
+			compatible = "ti,sci-intr";
+			reg = <0x00 0x310e0000 0x00 0x4000>;
+			ti,intr-trigger-type = <4>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			#interrupt-cells = <1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <227>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>,
+					      <128 672 64>;
+		};
+
+		main_udmass_inta: msi-controller@33d00000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x33d00000 0x00 0x100000>;
+			interrupt-controller;
+			#interrupt-cells = <0>;
+			interrupt-parent = <&main_navss_intr>;
+			msi-controller;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <265>;
+			ti,interrupt-ranges = <0 0 256>;
+		};
+
+		secure_proxy_main: mailbox@32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		hwspinlock: spinlock@30e00000 {
+			compatible = "ti,am654-hwspinlock";
+			reg = <0x00 0x30e00000 0x00 0x1000>;
+			#hwlock-cells = <1>;
+		};
+
+		mailbox0_cluster0: mailbox@31f80000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f80000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster1: mailbox@31f81000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f81000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster2: mailbox@31f82000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f82000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster3: mailbox@31f83000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f83000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster4: mailbox@31f84000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f84000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster5: mailbox@31f85000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f85000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster6: mailbox@31f86000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f86000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster7: mailbox@31f87000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f87000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster8: mailbox@31f88000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f88000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster9: mailbox@31f89000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f89000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster10: mailbox@31f8a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox0_cluster11: mailbox@31f8b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f8b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster0: mailbox@31f90000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f90000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster1: mailbox@31f91000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f91000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster2: mailbox@31f92000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f92000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster3: mailbox@31f93000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f93000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster4: mailbox@31f94000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f94000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster5: mailbox@31f95000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f95000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster6: mailbox@31f96000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f96000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster7: mailbox@31f97000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f97000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster8: mailbox@31f98000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f98000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster9: mailbox@31f99000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f99000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster10: mailbox@31f9a000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9a000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		mailbox1_cluster11: mailbox@31f9b000 {
+			compatible = "ti,am654-mailbox";
+			reg = <0x00 0x31f9b000 0x00 0x200>;
+			#mbox-cells = <1>;
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <16>;
+			interrupt-parent = <&main_navss_intr>;
+		};
+
+		main_ringacc: ringacc@3c000000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x0 0x3c000000 0x0 0x400000>,
+			      <0x0 0x38000000 0x0 0x400000>,
+			      <0x0 0x31120000 0x0 0x100>,
+			      <0x0 0x33000000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <1024>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <259>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		main_udmap: dma-controller@31150000 {
+			compatible = "ti,j721e-navss-main-udmap";
+			reg = <0x0 0x31150000 0x0 0x100>,
+			      <0x0 0x34000000 0x0 0x80000>,
+			      <0x0 0x35000000 0x0 0x200000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <263>;
+			ti,ringacc = <&main_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>, /* TX_HCHAN */
+						<0x10>; /* TX_UHCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>, /* RX_HCHAN */
+						<0x0c>; /* RX_UHCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+
+		cpts@310d0000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x0 0x310d0000 0x0 0x400>;
+			reg-names = "cpts";
+			clocks = <&k3_clks 226 5>;
+			clock-names = "cpts";
+			interrupts-extended = <&main_navss_intr 391>;
+			interrupt-names = "cpts";
+			ti,cpts-periodic-outputs = <6>;
+			ti,cpts-ext-ts-inputs = <8>;
+		};
+	};
+
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 182 0>, <&k3_clks 182 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 183 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 183 0>, <&k3_clks 183 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 184 0>, <&k3_clks 184 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 185 0>, <&k3_clks 185 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 186 0>, <&k3_clks 186 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 187 0>, <&k3_clks 187 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 188 0>, <&k3_clks 188 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 189 0>, <&k3_clks 189 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 190 0>, <&k3_clks 190 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 191 0>, <&k3_clks 191 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 192 0>, <&k3_clks 192 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 193 0>, <&k3_clks 193 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 194 0>, <&k3_clks 194 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 195 0>, <&k3_clks 195 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan14: can@2681000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02681000 0x00 0x200>,
+		      <0x00 0x02688000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 197 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 197 0>, <&k3_clks 197 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan15: can@2691000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02691000 0x00 0x200>,
+		      <0x00 0x02698000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 199 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 199 0>, <&k3_clks 199 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan16: can@26a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026a1000 0x00 0x200>,
+		      <0x00 0x026a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 201 0>, <&k3_clks 201 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	main_mcan17: can@26b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x026b1000 0x00 0x200>,
+		      <0x00 0x026b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 206 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 206 0>, <&k3_clks 206 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
new file mode 100644
index 000000000000..7521963719ff
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J721S2 SoC Family MCU/WAKEUP Domain peripherals
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_mcu_wakeup {
+	sms: system-controller@44083000 {
+		compatible = "ti,k2g-sci";
+		ti,host-id = <12>;
+
+		mbox-names = "rx", "tx";
+
+		mboxes= <&secure_proxy_main 11>,
+			<&secure_proxy_main 13>;
+
+		reg-names = "debug_messages";
+		reg = <0x00 0x44083000 0x00 0x1000>;
+
+		k3_pds: power-controller {
+			compatible = "ti,sci-pm-domain";
+			#power-domain-cells = <2>;
+		};
+
+		k3_clks: clock-controller {
+			compatible = "ti,k2g-sci-clk";
+			#clock-cells = <2>;
+		};
+
+		k3_reset: reset-controller {
+			compatible = "ti,sci-reset";
+			#reset-cells = <2>;
+		};
+	};
+
+	chipid@43000014 {
+		compatible = "ti,am654-chipid";
+		reg = <0x00 0x43000014 0x00 0x4>;
+	};
+
+	mcu_ram: sram@41c00000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x41c00000 0x00 0x100000>;
+		ranges = <0x00 0x00 0x41c00000 0x100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	wkup_pmx0: pinctrl@4301c000 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c000 0x00 0x178>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_gpio_intr: interrupt-controller@42200000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x42200000 0x00 0x400>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <125>;
+		ti,interrupt-ranges = <16 928 16>;
+	};
+
+	mcu_conf: syscon@40f00000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x40f00000 0x0 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x40f00000 0x20000>;
+
+		phy_gmii_sel: phy@4040 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4040 0x4>;
+			#phy-cells = <1>;
+		};
+
+	};
+
+	wkup_uart0: serial@42300000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x42300000 0x00 0x200>;
+		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 359 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcu_uart0: serial@40a00000 {
+		compatible = "ti,j721e-uart", "ti,am654-uart";
+		reg = <0x00 0x40a00000 0x00 0x200>;
+		interrupts = <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>;
+		current-speed = <115200>;
+		clocks = <&k3_clks 149 3>;
+		clock-names = "fclk";
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	wkup_gpio0: gpio@42110000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42110000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 115 0>;
+		clock-names = "gpio";
+	};
+
+	wkup_gpio1: gpio@42100000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42100000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <89>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 116 0>;
+		clock-names = "gpio";
+	};
+
+	wkup_i2c0: i2c@42120000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x42120000 0x00 0x100>;
+		interrupts = <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 223 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcu_i2c0: i2c@40b00000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b00000 0x00 0x100>;
+		interrupts = <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 221 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcu_i2c1: i2c@40b10000 {
+		compatible = "ti,j721e-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x40b10000 0x00 0x100>;
+		interrupts = <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&k3_clks 222 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
+	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 207 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 207 0>, <&k3_clks 207 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 208 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 208 0>, <&k3_clks 208 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+	};
+
+	mcu_navss: bus@28380000{
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
+		dma-coherent;
+		dma-ranges;
+
+		ti,sci-dev-id = <267>;
+
+		mcu_ringacc: ringacc@2b800000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg = <0x0 0x2b800000 0x0 0x400000>,
+			      <0x0 0x2b000000 0x0 0x400000>,
+			      <0x0 0x28590000 0x0 0x100>,
+			      <0x0 0x2a500000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <286>;
+			ti,sci-rm-range-gp-rings = <0x1>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <272>;
+			msi-parent = <&main_udmass_inta>;
+		};
+
+		mcu_udmap: dma-controller@285c0000 {
+			compatible = "ti,j721e-navss-mcu-udmap";
+			reg = <0x0 0x285c0000 0x0 0x100>,
+			      <0x0 0x2a800000 0x0 0x40000>,
+			      <0x0 0x2aa00000 0x0 0x40000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <1>;
+
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <273>;
+			ti,ringacc = <&mcu_ringacc>;
+			ti,sci-rm-range-tchan = <0x0d>, /* TX_CHAN */
+						<0x0f>; /* TX_HCHAN */
+			ti,sci-rm-range-rchan = <0x0a>, /* RX_CHAN */
+						<0x0b>; /* RX_HCHAN */
+			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
+		};
+	};
+
+	mcu_cpsw: ethernet@46000000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0x46000000 0x0 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0x46000000 0x0 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 29 28>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 29 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&mcu_udmap 0xf000>,
+		       <&mcu_udmap 0xf001>,
+		       <&mcu_udmap 0xf002>,
+		       <&mcu_udmap 0xf003>,
+		       <&mcu_udmap 0xf004>,
+		       <&mcu_udmap 0xf005>,
+		       <&mcu_udmap 0xf006>,
+		       <&mcu_udmap 0xf007>,
+		       <&mcu_udmap 0x7000>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				ti,syscon-efuse = <&mcu_conf 0x200>;
+				phys = <&phy_gmii_sel 1>;
+			};
+		};
+
+		davinci_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x0 0xf00 0x0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 29 28>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x0 0x3d000 0x0 0x400>;
+			clocks = <&k3_clks 29 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
new file mode 100644
index 000000000000..80d3cae03e88
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for J721S2 SoC Family
+ *
+ * TRM (SPRUJ28 – NOVEMBER 2021) : http://www.ti.com/lit/pdf/spruj28
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/k3.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+/ {
+
+	model = "Texas Instruments K3 J721S2 SoC";
+	compatible = "ti,j721s2";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart3;
+		serial6 = &main_uart4;
+		serial7 = &main_uart5;
+		serial8 = &main_uart6;
+		serial9 = &main_uart7;
+		serial10 = &main_uart8;
+		serial11 = &main_uart9;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		can0 = &main_mcan16;
+		can1 = &mcu_mcan0;
+		can2 = &mcu_mcan1;
+		can3 = &main_mcan3;
+		can4 = &main_mcan5;
+	};
+
+	chosen { };
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a72";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a72";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x100000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a72_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a72-pmu";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@100000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
+			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe Core*/
+			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
+			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
+			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
+			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
+			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
+
+			 /* MCUSS_WKUP Range */
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
+			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
+			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
+			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
+			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+
+		cbass_mcu_wakeup: bus@28380000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
+				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
+				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
+				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
+				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
+				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
+				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+
+		};
+
+	};
+};
+
+/* Now include peripherals from each bus segment */
+#include "k3-j721s2-main.dtsi"
+#include "k3-j721s2-mcu-wakeup.dtsi"
-- 
2.17.1

