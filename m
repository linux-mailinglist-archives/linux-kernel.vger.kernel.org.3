Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D905A44F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiH2IWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiH2IWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:22:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC9B564D9;
        Mon, 29 Aug 2022 01:22:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27T8MLPC031532;
        Mon, 29 Aug 2022 03:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661761341;
        bh=NkjECwXgdLtQc0y6OYA4oFQOGO5+u6jddR9DRSjd5Xo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pTr1xzAROlq4Y1ANgw9DQgNG0MTMR0u5EgvuxlyltAfxrJPJKTabySkFY7wankWns
         7ho1/yxETTDP579IjZjLfoIi6FK28nDFTIKkLcsJcnsbzxXVwq7741mszFVYSJ9XRc
         QjGE17ijpHSElI+jf/+7LaRw6D80cvm8s4Z5oN4E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27T8ML5j021466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 03:22:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 29
 Aug 2022 03:22:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 29 Aug 2022 03:22:21 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27T8M7Yc059309;
        Mon, 29 Aug 2022 03:22:18 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: Introduce AM62A7 family of SoCs
Date:   Mon, 29 Aug 2022 13:51:59 +0530
Message-ID: <20220829082200.241653-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829082200.241653-1-vigneshr@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM62A SoC belongs to the K3 Multicore SoC architecture platform that
can run edge AI applications with Video/Vision processing. This provides
advanced system integration with high security support to enable a broad
set of applications in industrial/automotive markets such as, driver
monitoring, machine vision, smart camera, eMirror, front camera,
robotics, and building automation.

Some highlights of AM62A SoC are:
* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster. Dual/Single
  core variants are provided in the same package to allow HW compatible
  designs.
* One Device manager Cortex-R5F for system power and resource management, and
  one Cortex-R5F for Functional Safety or general-purpose usage.
* One AI accelerator (up to 2 TOPS), using one C7x256V DSP w/Matrix Multiplier
  accelerator (MMA) for Deep Learning usage.
* VPAC3L(Vision Pre-processing Accelerator), providing 12-bit ISP up to
  315MPixel/s RGB+IR support, and Noise Filter for improved integrated imaging
  and vision image processing.
* H.264/H.265 Video Encode/Decode. + Motion JPEG encode
* Display support, providing 24-bit RBG parallel interface up to 200MHz pixel
  clock support for 2K display resolution.
* Integrated Giga-bit Ethernet switch supporting up to a total of two external
  ports (TSN capable).
* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for NAND/FPGA
  connection, OSPI memory controller, 3x McASP for audio, 1x CSI-RX-4L for
  Camera, eCAP/eQEP, ePWM, among other peripherals.
* Dedicated Centralized Hardware Security Module with support for secure boot,
  debug security and crypto acceleration and trusted execution environment
* One 32 bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
* Multiple low power modes support, ex: Deep sleep, Standby, MCU-only, enabling
  battery powered system design.

More details about the SoCs can be found in the Technical Reference Manual:
https://www.ti.com/lit/zip/spruj16

Co-developed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 298 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    |  39 +++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  54 ++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi        | 122 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 103 +++++++
 5 files changed, 616 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
new file mode 100644
index 000000000000..8e45a56ba466
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62A SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	oc_sram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x70000000 0x00 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x70000000 0x10000>;
+	};
+
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
+		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
+		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
+		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
+		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
+		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
+		/*
+		 * vcpumntirq:
+		 * virtual CPU interface maintenance interrupt
+		 */
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
+	main_conf: syscon@100000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x00 0x00100000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00100000 0x20000>;
+	};
+
+	dmss: bus@48000000 {
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06000000>;
+
+		ti,sci-dev-id = <25>;
+
+		secure_proxy_main: mailbox@4d000000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x4d000000 0x00 0x80000>,
+			      <0x00 0x4a600000 0x00 0x80000>,
+			      <0x00 0x4a400000 0x00 0x80000>;
+			interrupt-names = "rx_012";
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	dmsc: system-controller@44043000 {
+		compatible = "ti,k2g-sci";
+		ti,host-id = <12>;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 12>,
+			<&secure_proxy_main 13>;
+		reg-names = "debug_messages";
+		reg = <0x00 0x44043000 0x00 0xfe0>;
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
+	main_pmx0: pinctrl@f4000 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0xf4000 0x00 0x2ac>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x100>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 146 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x100>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 152 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x100>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 153 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart3: serial@2830000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02830000 0x00 0x100>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 154 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart4: serial@2840000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02840000 0x00 0x100>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 155 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart5: serial@2850000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02850000 0x00 0x100>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 156 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart6: serial@2860000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02860000 0x00 0x100>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 158 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_i2c0: i2c@20000000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x20000000 0x00 0x100>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 102 2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
+	main_i2c1: i2c@20010000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x20010000 0x00 0x100>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 103 2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
+	main_i2c2: i2c@20020000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x20020000 0x00 0x100>;
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 104 2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
+	main_i2c3: i2c@20030000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x20030000 0x00 0x100>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 105 2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
+	main_gpio_intr: interrupt-controller@a00000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x00a00000 0x00 0x800>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <3>;
+		ti,interrupt-ranges = <0 32 16>;
+		status = "disabled";
+	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x0 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <190>, <191>, <192>,
+			     <193>, <194>, <195>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <87>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 77 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	main_gpio1: gpio@601000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00601000 0x0 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <180>, <181>, <182>,
+			     <183>, <184>, <185>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <88>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 78 0>;
+		clock-names = "gpio";
+		status = "disabled";
+	};
+
+	sdhci1: mmc@fa00000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		ti,trm-icp = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,clkbuf-sel = <0x7>;
+		bus-width = <4>;
+		no-1-8-v;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
new file mode 100644
index 000000000000..6d1e501b94ab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM625 SoC Family MCU Domain peripherals
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_mcu {
+	mcu_pmx0: pinctrl@4084000 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x04084000 0x00 0x88>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+		status = "disabled";
+	};
+
+	mcu_uart0: serial@4a00000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x04a00000 0x00 0x100>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 149 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	mcu_i2c0: i2c@4900000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x04900000 0x00 0x100>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 106 2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
new file mode 100644
index 000000000000..fe6d682a0f33
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62A SoC Family Wakeup Domain peripherals
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_wakeup {
+	wkup_conf: syscon@43000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x00 0x43000000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x43000000 0x20000>;
+
+		chipid: chipid@14 {
+			compatible = "ti,am654-chipid";
+			reg = <0x14 0x4>;
+		};
+	};
+
+	wkup_uart0: serial@2b300000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x2b300000 0x00 0x100>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	wkup_i2c0: i2c@2b200000 {
+		compatible = "ti,am64-i2c", "ti,omap4-i2c";
+		reg = <0x00 0x02b200000 0x00 0x100>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 107 4>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+
+	wkup_rtc0: rtc@2b1f0000 {
+		compatible = "ti,am62-rtc";
+		reg = <0x00 0x2b1f0000 0x00 0x100>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 117 6> , <&k3_clks 117 0>;
+		clock-names = "vbus", "osc32k";
+		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
+		wakeup-source;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
new file mode 100644
index 000000000000..6eb87c3f9f3c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62A SoC Family
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/k3.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+/ {
+	model = "Texas Instruments K3 AM62A SoC";
+	compatible = "ti,am62a7";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
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
+	a53_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@f0000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
+			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
+			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
+			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
+			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
+			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
+			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
+			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
+			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
+			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
+			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
+			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
+			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
+			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
+			 <0x00 0x7e000000 0x00 0x7e000000 0x00 0x00100000>, /* C7x_0 */
+			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
+
+			 /* MCU Domain Range */
+			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
+			 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>, /* MCU R5 ATCM */
+			 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>, /* MCU R5 BTCM */
+			 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>, /* MCU R5 IRAM0 */
+			 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>, /* MCU R5 IRAM1 */
+
+			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>,
+			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
+			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
+			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM */
+			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM */
+
+		cbass_mcu: bus@4000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>, /* Peripheral window */
+				 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>, /* MCU R5 ATCM */
+				 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>, /* MCU R5 BTCM */
+				 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>, /* MCU IRAM0 */
+				 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>; /* MCU IRAM1 */
+		};
+
+		cbass_wakeup: bus@b00000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
+				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* WKUP CTRL MMR */
+				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM*/
+				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
+		};
+	};
+};
+
+/* Now include the peripherals for each bus segments */
+#include "k3-am62a-main.dtsi"
+#include "k3-am62a-mcu.dtsi"
+#include "k3-am62a-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
new file mode 100644
index 000000000000..331d89fda29d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62A7 SoC family in Quad core configuration
+ *
+ * TRM: https://www.ti.com/lit/zip/spruj16
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am62a.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x40000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+	};
+};
-- 
2.25.1

