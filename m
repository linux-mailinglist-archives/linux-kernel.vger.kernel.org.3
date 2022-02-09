Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9E4AF0DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiBIMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiBIMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61244C002B6B;
        Wed,  9 Feb 2022 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644405213; x=1675941213;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cDeQgr2ogo8tqM5eSkBYC7/5rkWjSBPNwqdv0MknXp4=;
  b=ME+wKUDWvkhmNEQLcGy0q2X0D/AJJBPk2Upnz0OvcgpL5d1F56frvqAm
   w1A6e+/6j0/7rYfpWKG8SsXL2ZESiZupXpCnoTIgtwanmDx43pe6tqpAy
   FGtPkhynHkv5QjQxOU+kA3TzuvG9Z5GnkJFjGsS/cHAalNisYOA2WlAz5
   GFZVgskXLR6dRuKYUGzPpgrrdv+9h9bU7ePy8FyCqzD52lhEKMw9wjFJ2
   CSa16f9oKlcQp1cWyf+dUIhQl5qJqjhWcDSir5Mx1jA4uOMHqz1y8MjW2
   JST7G/ZzE+RrRPAlf0SSguCQMDAfvlIpxHl7eauppdAX3cznoJgcJfg+M
   g==;
IronPort-SDR: XSsehNH7tQ7xcooHmgVw3Pz/yZb/J8/C5Rfr9+nEE6W6uXwjzaeoyG14NR3Hffsdv9fOJ2FUF4
 6J8+Z+VFuDlrI0sHuifS6KuQbOOVQXkgTl/D5A4yCvM1C7ReQkkmc6gQu3/oFSyF/b/JE7CJrs
 vHCjbR5vKnd+5MaUMxVxp8568WPx8OJHLyHCAAGBuymwgRiKcTg4XsJEmzz1z8NixKMwVOVT2E
 Oec/NT8OHG86NmuX6O/GpHZ+RNPDjBYLSoht1kPv6/9om+cUgGeKqHbjHzt35ueJjZyQSnM5mI
 OOuae8XfaX2CM8TU1Ax9OLmU
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152974488"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 04:13:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 04:13:31 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 04:13:26 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <alexandre.belloni@bootlin.com>, <olof@lixom.net>,
        <soc@kernel.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board pcb8291
Date:   Wed, 9 Feb 2022 16:43:18 +0530
Message-ID: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic DT for Microchip lan966x SoC and associated board
pcb8291(2-port EVB). Adds peripherals required to allow booting: Interrupt
Controller, Clock, Generic ARMv7 Timers, Synopsys Timer, Flexcoms, GPIOs.
Also adds other peripherals like crypto(AES/SHA), DMA, Watchdog Timer, TRNG
and MCAN0.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v3 -> v4:
- Removed character 'x' from compatible string.
- Removed memory node as handled by bootloader.
- Renamed flexcom3 usart0 to usart3
- Added /chosen and /aliases nodes in dts file.

v2 -> v3:
- Enabling trng in dtsi itself.
- Removed "status=okay" dma0.
- Add gpio pin settings for can0(missed adding this in previous version)

v1 -> v2:
- Moved flx3 usart0 node to dtsi file.
- Removed status="okay" for dma0 to maintain consistency across nodes
  (which means enabling dma0 by default)

 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
 arch/arm/boot/dts/lan966x_pcb8291.dts |  61 +++++++
 3 files changed, 300 insertions(+)
 create mode 100644 arch/arm/boot/dts/lan966x.dtsi
 create mode 100644 arch/arm/boot/dts/lan966x_pcb8291.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 235ad559acb2..2040a990f08c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -735,6 +735,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 dtb-$(CONFIG_SOC_IMX7ULP) += \
 	imx7ulp-com.dtb \
 	imx7ulp-evk.dtb
+dtb-$(CONFIG_SOC_LAN966) += \
+	lan966x_pcb8291.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
new file mode 100644
index 000000000000..91ee9e0684f4
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x.dtsi - Device Tree Include file for Microchip LAN966 family SoC
+ *
+ * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/microchip,lan966x.h>
+
+/ {
+	model = "Microchip LAN966 family SoC";
+	compatible = "microchip,lan966";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			clock-frequency = <600000000>;
+			reg = <0x0>;
+		};
+	};
+
+	clocks {
+		sys_clk: sys_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <162500000>;
+		};
+
+		cpu_clk: cpu_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+		};
+
+		ddr_clk: ddr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <300000000>;
+		};
+
+		nic_clk: nic_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+	};
+
+	clks: clock-controller@e00c00a8 {
+		compatible = "microchip,lan966x-gck";
+		#clock-cells = <1>;
+		clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+		clock-names = "cpu", "ddr", "sys";
+		reg = <0xe00c00a8 0x38>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <37500000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flx0: flexcom@e0040000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0040000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0040000 0x800>;
+			status = "disabled";
+		};
+
+		flx1: flexcom@e0044000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0044000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0044000 0x800>;
+			status = "disabled";
+		};
+
+		trng: trng@e0048000 {
+			compatible = "atmel,at91sam9g45-trng";
+			reg = <0xe0048000 0x100>;
+			clocks = <&nic_clk>;
+		};
+
+		aes: aes@e004c000 {
+			compatible = "atmel,at91sam9g46-aes";
+			reg = <0xe004c000 0x100>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
+			dma-names = "rx", "tx";
+			clocks = <&nic_clk>;
+			clock-names = "aes_clk";
+		};
+
+		flx2: flexcom@e0060000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0060000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0060000 0x800>;
+			status = "disabled";
+		};
+
+		flx3: flexcom@e0064000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0064000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0064000 0x800>;
+			status = "disabled";
+
+			usart3: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+		};
+
+		dma0: dma-controller@e0068000 {
+			compatible = "microchip,sama7g5-dma";
+			reg = <0xe0068000 0x1000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&nic_clk>;
+			clock-names = "dma_clk";
+		};
+
+		sha: sha@e006c000 {
+			compatible = "atmel,at91sam9g46-sha";
+			reg = <0xe006c000 0xec>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(14)>;
+			dma-names = "tx";
+			clocks = <&nic_clk>;
+			clock-names = "sha_clk";
+		};
+
+		flx4: flexcom@e0070000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0070000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0070000 0x800>;
+			status = "disabled";
+		};
+
+		timer0: timer@e008c000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xe008c000 0x400>;
+			clocks = <&nic_clk>;
+			clock-names = "timer";
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		watchdog: watchdog@e0090000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xe0090000 0x1000>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&nic_clk>;
+		};
+
+		can0: can@e081c000 {
+			compatible = "bosch,m_can";
+			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MCAN0>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&clks GCK_ID_MCAN0>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		gpio: pinctrl@e2004064 {
+			compatible = "microchip,lan966x-pinctrl";
+			reg = <0xe2004064 0xb4>,
+			    <0xe2010024 0x138>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&gpio 0 0 78>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+		};
+
+		gic: interrupt-controller@e8c11000 {
+			compatible = "arm,gic-400", "arm,cortex-a7-gic";
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			reg = <0xe8c11000 0x1000>,
+			      <0xe8c12000 0x2000>,
+			      <0xe8c14000 0x2000>,
+			      <0xe8c16000 0x2000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/lan966x_pcb8291.dts b/arch/arm/boot/dts/lan966x_pcb8291.dts
new file mode 100644
index 000000000000..ccec4177990b
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x_pcb8291.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x_pcb8291.dts - Device Tree file for PCB8291
+ */
+/dts-v1/;
+#include "lan966x.dtsi"
+
+/ {
+	model = "Microchip EVB - LAN9662";
+	compatible = "microchip,lan9662-pcb8291", "microchip,lan9662", "microchip,lan966";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &usart3;
+	};
+};
+
+&gpio {
+	fc_shrd7_pins: fc_shrd7-pins {
+		pins = "GPIO_49";
+		function = "fc_shrd7";
+	};
+
+	fc_shrd8_pins: fc_shrd8-pins {
+		pins = "GPIO_54";
+		function = "fc_shrd8";
+	};
+
+	fc3_b_pins: fcb3-spi-pins {
+		/* SCK, RXD, TXD */
+		pins = "GPIO_51", "GPIO_52", "GPIO_53";
+		function = "fc3_b";
+	};
+
+	can0_b_pins:  can0_b_pins {
+		/* RX, TX */
+		pins = "GPIO_35", "GPIO_36";
+		function = "can0_b";
+	};
+};
+
+&can0 {
+	pinctrl-0 = <&can0_b_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	usart3: serial@200 {
+		pinctrl-0 = <&fc3_b_pins>, <&fc_shrd7_pins>, <&fc_shrd8_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
-- 
2.17.1

