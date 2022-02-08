Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA954ADACF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377795AbiBHOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiBHOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:07:26 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EDBC03FECE;
        Tue,  8 Feb 2022 06:07:23 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 218DImMC073828;
        Tue, 8 Feb 2022 07:18:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644326328;
        bh=WjzeYYq507Zk5HWwVy2OJS6eoRL8He44WskqXrkpki4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bPaSUW4sLapOeKJWvpwHK0QBq9O0vKPfJlYYD01+bNAMF96Lb2vTlneO7ZP3Pkl1m
         d11LfYLkiQmNkk1bHE0PGZJfrho6HkU7Q3Hib7w4DePk4Gek9FyBeuUVKRed8gSr/S
         temeh6RyzNaJp39++g3n6KWuxqNLMc2DNrNXckDo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 218DImUj101846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Feb 2022 07:18:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 8
 Feb 2022 07:18:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 8 Feb 2022 07:18:47 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 218DIUCj117228;
        Tue, 8 Feb 2022 07:18:44 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] arm64: dts: ti: Introduce base support for AM62x SoC
Date:   Tue, 8 Feb 2022 18:48:26 +0530
Message-ID: <20220208131827.1430086-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208131827.1430086-1-vigneshr@ti.com>
References: <20220208131827.1430086-1-vigneshr@ti.com>
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

The AM62 SoC family is the follow on AM335x built on K3 Multicore SoC
architecture platform, providing ultra-low-power modes, dual display,
multi-sensor edge compute, security and other BOM-saving integration.
The AM62 SoC targets broad market to enable applications such as
Industrial HMI, PLC/CNC/Robot control, Medical Equipment, Building
Automation, Appliances and more.

Some highlights of this SoC are:

* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
  Pin-to-pin compatible options for single and quad core are available.
* Cortex-M4F for general-purpose or safety usage.
* Dual display support, providing 24-bit RBG parallel interface and
  OLDI/LVDS-4 Lane x2, up to 200MHz pixel clock support for 2K display
  resolution.
* Selectable GPUsupport, up to 8GFLOPS, providing better user experience
  in 3D graphic display case and Android.
* PRU(Programmable Realtime Unit) support for customized programmable
  interfaces/IOs.
* Integrated Giga-bit Ethernet switch supporting up to a total of two
  external ports (TSN capable).
* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
  1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
* Dedicated Centralized System Controller for Security, Power, and
  Resource Management.
* Multiple low power modes support, ex: Deep sleep,Standby, MCU-only,
  enabling battery powered system design.

This add bare minimum DT describing ARM compute clusters, Main, MCU and
Wakeup domain and interconnects, UARTs and I2Cs to enable booting using
ramdisk.

More details can be found in the Technical Reference Manual:
https://www.ti.com/lit/pdf/spruiv7

Co-developed-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 263 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  36 +++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  41 ++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi        | 104 ++++++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi       | 103 ++++++++
 5 files changed, 547 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
new file mode 100644
index 000000000000..81d6d99ca180
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM625 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
+		      <0x00 0x01880000 0x00 0xC0000>;	/* GICR */
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
+		ranges = <0x0 0x00 0x00100000 0x20000>;
+	};
+
+	dmss: bus@48000000 {
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
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
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x100>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 152 0>;
+		clock-names = "fclk";
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x100>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 153 0>;
+		clock-names = "fclk";
+	};
+
+	main_uart3: serial@2830000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02830000 0x00 0x100>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 154 0>;
+		clock-names = "fclk";
+	};
+
+	main_uart4: serial@2840000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02840000 0x00 0x100>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 155 0>;
+		clock-names = "fclk";
+	};
+
+	main_uart5: serial@2850000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02850000 0x00 0x100>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 156 0>;
+		clock-names = "fclk";
+	};
+
+	main_uart6: serial@2860000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02860000 0x00 0x100>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 158 0>;
+		clock-names = "fclk";
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
+	};
+
+	main_gpio0: gpio@600000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x0 0x00600000 0x0 0x100>;
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
+	};
+
+	main_gpio1: gpio@601000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x0 0x00601000 0x0 0x100>;
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
+	};
+
+	hwspinlock: spinlock@2a000000 {
+		compatible = "ti,am64-hwspinlock";
+		reg = <0x00 0x2a000000 0x00 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
+	mailbox0_cluster0: mailbox@29000000 {
+		compatible = "ti,am64-mailbox";
+		reg = <0x00 0x29000000 0x00 0x200>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <1>;
+		ti,mbox-num-users = <4>;
+		ti,mbox-num-fifos = <16>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
new file mode 100644
index 000000000000..9d210d55fc71
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -0,0 +1,36 @@
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
+	};
+
+	mcu_uart0: serial@4a00000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x04a00000 0x00 0x100>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 149 0>;
+		clock-names = "fclk";
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
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
new file mode 100644
index 000000000000..4090134676cf
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM625 SoC Family Wakeup Domain peripherals
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_wakeup {
+	wkup_conf: syscon@43000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x00 0x43000000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x43000000 0x20000>;
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
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
new file mode 100644
index 000000000000..f1a46be27c37
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62 SoC Family
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/k3.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+/ {
+	model = "Texas Instruments K3 AM625 SoC";
+	compatible = "ti,am625";
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
+			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
+			 <0x00 0x0070C000 0x00 0x0070C000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
+			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
+			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
+			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
+			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* sa3 sproxy data */
+			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
+			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* sa3 sproxy config */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
+			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
+			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
+			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
+
+			 /* MCU Domain Range */
+			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
+
+			 /* Wakeup Domain Range */
+			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
+			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
+
+		cbass_mcu: bus@4000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
+		};
+
+		cbass_wakeup: bus@2b000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
+		};
+	};
+};
+
+/* Now include the peripherals for each bus segments */
+#include "k3-am62-main.dtsi"
+#include "k3-am62-mcu.dtsi"
+#include "k3-am62-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
new file mode 100644
index 000000000000..887f31c23fef
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM625 SoC family in Quad core configuration
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruiv7
+ *
+ * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am62.dtsi"
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
2.35.1

