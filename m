Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF895A99DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiIAOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiIAOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:14:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C269F51;
        Thu,  1 Sep 2022 07:14:12 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EE4Kf008843;
        Thu, 1 Sep 2022 09:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662041644;
        bh=8UjajpritgD78ChbIvnDpHKm1+KIEen36K54Fli3fbg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yiP1jf5HksAxvPRKU7pzy6Q2uZopmE/o6+9G4MX3N17JC0Ia5ynHK5UWzZNnFLfRv
         7UEhAqmtiozSlPmekoAZ2V2HvjPPpC+J3Emsn/14fvX9vhKSkurPjGRKnpZ8XAQp0c
         pCpZEDiY+SUkFVdQpsGg+Iw25BrlJGEKS/z67KQU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EE4Vx016303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:14:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:14:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:14:04 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281EDhdW015476;
        Thu, 1 Sep 2022 09:14:01 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 5/5] arm64: dts: ti: Add support for AM62A7-SK
Date:   Thu, 1 Sep 2022 19:43:28 +0530
Message-ID: <20220901141328.899100-6-vigneshr@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901141328.899100-1-vigneshr@ti.com>
References: <20220901141328.899100-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62A StarterKit (SK) board is a low cost, small form factor board
designed for TI’s AM62A7 SoC. It supports the following interfaces:
* 2 GB LPDDR4 RAM
* x1 Gigabit Ethernet interface
* x1 HDMI Port with audio
* x1 Headphone Jack
* x1 USB2.0 Hub with two Type A host and x1 USB Type-C DRP Port
* x1 UHS-1 capable µSD card slot
* M.2 SDIO Wifi + UART slot
* 1Gb OSPI NAND flash
* x4 UART through UART-USB bridge
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs
* 40-pin User Expansion Connector
* 24-pin header for peripherals in MCU island (I2C, UART, SPI, IO)
* 20-pin header for Programmable Realtime Unit (PRU) IO pins
* 40-pin CSI header

Add basic support for AM62A7-SK.

Schematics: https://www.ti.com/lit/zip/sprr459

Co-developed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/Makefile         |   2 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 223 ++++++++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 02e5d80344d0..4555a5be2257 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -23,3 +23,5 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
+
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
new file mode 100644
index 000000000000..576dbce80ad8
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62A SK: https://www.ti.com/lit/zip/sprr459
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-am62a7.dtsi"
+
+/ {
+	compatible =  "ti,am62a7-sk", "ti,am62a7";
+	model = "Texas Instruments AM62A7 SK";
+
+	aliases {
+		serial2 = &main_uart0;
+		mmc1 = &sdhci1;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
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
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			no-map;
+		};
+	};
+
+	vmain_pd: regulator-0 {
+		/* TPS25750 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_5v0: regulator-1 {
+		/* Output of TPS63070 */
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
+		/* output of LM5141-Q1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-3 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usr_led_pins_default>;
+
+		led-0 {
+			label = "am62a-sk:green:heartbeat";
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
+			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
+			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
+			AM62AX_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
+			AM62AX_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
+	main_i2c2_pins_default: main-i2c2-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x0b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */
+			AM62AX_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
+			AM62AX_IOPAD(0x234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
+			AM62AX_IOPAD(0x230, PIN_INPUT, 0) /* (A22) MMC1_DAT0 */
+			AM62AX_IOPAD(0x22c, PIN_INPUT, 0) /* (B21) MMC1_DAT1 */
+			AM62AX_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
+			AM62AX_IOPAD(0x224, PIN_INPUT, 0) /* (D22) MMC1_DAT3 */
+			AM62AX_IOPAD(0x240, PIN_INPUT, 0) /* (D17) MMC1_SDCD */
+		>;
+	};
+
+	usr_led_pins_default: usr-led-pins-default {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x244, PIN_OUTPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
+		>;
+	};
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+
+	exp1: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+				   "BT_EN_SOC", "MMC1_SD_EN",
+				   "VPP_EN", "EXP_PS_3V3_En",
+				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
+				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
+				   "UART1_FET_BUF_EN", "BT_UART_WAKE_SOC",
+				   "GPIO_HDMI_RSTn", "CSI_GPIO0",
+				   "CSI_GPIO1", "WLAN_ALERTn",
+				   "HDMI_INTn", "TEST_GPIO2",
+				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
+				   "MCASP1_FET_SEL", "UART1_FET_SEL",
+				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
+	};
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	status = "okay";
+	vmmc-supply = <&vdd_mmc1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&main_gpio_intr {
+	status = "okay";
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
-- 
2.37.2

