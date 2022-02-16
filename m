Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0A4B8F04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiBPRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:19:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiBPRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:19:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52583BECF8;
        Wed, 16 Feb 2022 09:18:55 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21GHImU6113011;
        Wed, 16 Feb 2022 11:18:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645031929;
        bh=6h/BmeCwifdB1Fl6vVR4D0GfK73l/fTnscSAeSLDycU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f6jb96TbcASANZc2lvuWUwbQTXzxkU934xwrHoBJBFctHvmSZf7uWR2+HMV1ki/Qt
         fhs1A1iNGY344zUBYQHIDZgKtFPmBoVJphbyjN92AvnMaoNZnNDpcMjfD4hz8fVHke
         NiuqXMPa1S8tJprm778tLPcySznNPy/fhnw+b5go=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21GHImba096661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 11:18:48 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 11:18:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 11:18:48 -0600
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21GHIJjT056750;
        Wed, 16 Feb 2022 11:18:45 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] arm64: dts: ti: Add support for AM62-SK
Date:   Wed, 16 Feb 2022 22:48:15 +0530
Message-ID: <20220216171815.384377-6-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216171815.384377-1-vigneshr@ti.com>
References: <20220216171815.384377-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

AM62 StarterKit (SK) board is a low cost, small form factor board
designed for TI’s AM625 SoC. It supports the following interfaces:
* 2 GB DDR4 RAM
* x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
* x1 HDMI Port with audio + x1 OLDI/LVDS Display interface for Dual Display
* x1 Headphone Jack
* x1 USB2.0 Hub with two Type A host and x1 USB Type-C DRP Port
* x1 UHS-1 capable µSD card slot
* 2.4/5 GHz WLAN + Bluetooth 4.2 through WL1837
* 512 Mbit OSPI flash
* x4 UART through UART-USB bridge
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs
* 40-pin User Expansion Connector
* 24-pin header for peripherals in MCU island (I2C, UART, SPI, IO)
* 20-pin header for Programmable Realtime Unit (PRU) IO pins
* 15-pin CSI header

Add basic support for AM62-SK.

Schematics: https://www.ti.com/lit/zip/sprr448

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile        |   2 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 206 +++++++++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 90be511bc4d09..02e5d80344d00 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -21,3 +21,5 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
+
+dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
new file mode 100644
index 0000000000000..a80e5f7a9cfd7
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM625 SK: https://www.ti.com/lit/zip/sprr448
+ *
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-am625.dtsi"
+
+/ {
+	compatible =  "ti,am625-sk", "ti,am625";
+	model = "Texas Instruments AM625 SK";
+
+	aliases {
+		serial2 = &main_uart0;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x200000>;
+			no-map;
+		};
+	};
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_5v0: regulator-1 {
+		/* Output of LM34936 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_3v3_sys: regulator-2 {
+		/* output of LM61460-Q1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usr_led_pins_default>;
+
+		led-0 {
+			label = "am62-sk:green:heartbeat";
+			gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			default-state = "off";
+		};
+	};
+};
+
+&main_pmx0 {
+	main_uart0_pins_default: main-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
+			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
+			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
+	usr_led_pins_default: usr-led-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x244, PIN_OUTPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
+		>;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
+
+&mcu_uart0 {
+	status = "disabled";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+&main_uart1 {
+	/* Main UART1 is used by TIFS firmware */
+	status = "reserved";
+};
+
+&main_uart2 {
+	status = "disabled";
+};
+
+&main_uart3 {
+	status = "disabled";
+};
+
+&main_uart4 {
+	status = "disabled";
+};
+
+&main_uart5 {
+	status = "disabled";
+};
+
+&main_uart6 {
+	status = "disabled";
+};
+
+&mcu_i2c0 {
+	status = "disabled";
+};
+
+&wkup_i2c0 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c2 {
+	status = "disabled";
+};
+
+&main_i2c3 {
+	status = "disabled";
+};
+
+&mailbox0_cluster0 {
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
-- 
2.35.1

