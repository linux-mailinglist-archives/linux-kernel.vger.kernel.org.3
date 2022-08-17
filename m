Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F75597263
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiHQO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiHQO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:56:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366399C2D7;
        Wed, 17 Aug 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660748208; x=1692284208;
  h=from:to:subject:date:message-id:mime-version;
  bh=VTwBsNwj6Dbt5KB9ZiGqeiw6UCqNzCKZGsj4aNmBrhk=;
  b=Ia9Ng3IGc+qJDrY2R58xwU7yJPyhB0stVDLiIp74VfrXkyv+xrG84RaK
   YiWPq5Rk7Yk0m4VdVTOhohEoBxqSdh9vxsIY7/QSNlQ1yBTr087EaNj4I
   LjJaL+vsrLjj44SDygHaiqzWB2RHkUPdjKKO0SXCQ/UQqIFylTSPkkmSI
   wgn9snZTIoBn0aJ2+OR7+GvVCQIzV9K9JJ17qq56FtJS2oU3fitSum99i
   228jhtagJ56bi/2+rSiayHeh27Z69rpfm2sJrMLiHo6ofVEN4bVfu8uSU
   S83eTRMJ95f5cd8M8m1OyLkjWdWu41sig9cw28QSfMPbCITwrUY8QW3lF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="169711797"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 07:56:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 07:56:46 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 07:56:45 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Ray" <jerry.ray@microchip.com>
Subject: [linux][PATCH] dts: arm: at91: Add SAMA5D3-EDS Board
Date:   Wed, 17 Aug 2022 09:56:45 -0500
Message-ID: <20220817145645.32327-1-jerry.ray@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 1 file - base device tree for SAMA5D3-EDS board.

The SAMA5D3-EDS board is an Ethernet Development Platform allowing for
evaluating many Microchip ethernet switch and PHY products.  Various
daughter cards can connect up via an RGMII connector or an RMII connector.

The EDS board is not intended for stand-alone use and has no ethernet
capabilities when no daughter board is connected.  As such, this device
tree is intended to be used with a DT overlay defining the add-on board.
To better ensure consistency, some items are defined here as a form of
documentation so that all add-on overlays will use the same terms.

Google search keywords: "Microchip SAMA5D3-EDS"

Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d3_eds.dts | 314 +++++++++++++++++++++++++
 1 file changed, 314 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d3_eds.dts

diff --git a/arch/arm/boot/dts/at91-sama5d3_eds.dts b/arch/arm/boot/dts/at91-sama5d3_eds.dts
new file mode 100644
index 000000000000..b7f0e200f7cb
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d3_eds.dts
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * at91-sama5d3_eds.dts - Device Tree file for the SAMA5D3 Ethernet
+ *    Development System board.
+ *
+ *  Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+ *		  2022 Jerry Ray <jerry.ray@microchip.com>
+ */
+/dts-v1/;
+#include "sama5d36.dtsi"
+
+/ {
+	model = "SAMA5D3 Ethernet Development System";
+	compatible = "atmel,sama5d3-xplained", "atmel,sama5d3", "atmel,sama5";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio>;
+
+		button-3 {
+			label = "PB_USER";
+			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
+			linux,code = <0x104>;
+			wakeup-source;
+		};
+	};
+
+	memory@20000000 {
+		reg = <0x20000000 0x10000000>;
+	};
+
+	regulators: regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vcc_3v3_reg: BUCK_REG1 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		vcc_2v5_reg: LDO_REG2 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC_2V5";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+			vin-supply = <&vcc_3v3_reg>;
+		};
+
+		vcc_1v8_reg: LDO_REG3 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			vin-supply = <&vcc_3v3_reg>;
+		};
+
+		vcc_1v2_reg: BUCK_REG4 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on;
+		};
+
+		vcc_mmc0_reg: fixedregulator_mmc0 {
+			compatible = "regulator-fixed";
+			regulator-name = "mmc0-card-supply";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_vcc_mmc0_reg_gpio>;
+			gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+&ebi {
+	pinctrl-0 = <&pinctrl_ebi_nand_addr>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	nand_controller: nand-controller {
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x2>;
+			atmel,rb = <0>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <4>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				at91bootstrap@0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x40000>;
+				};
+
+				bootloader@40000 {
+					label = "bootloader";
+					reg = <0x40000 0xc0000>;
+				};
+
+				bootloaderenvred@100000 {
+					label = "bootloader env redundant";
+					reg = <0x100000 0x40000>;
+				};
+
+				bootloaderenv@140000 {
+					label = "bootloader env";
+					reg = <0x140000 0x40000>;
+				};
+
+				dtb@180000 {
+					label = "device tree";
+					reg = <0x180000 0x80000>;
+				};
+
+				kernel@200000 {
+					label = "kernel";
+					reg = <0x200000 0x600000>;
+				};
+
+				rootfs@800000 {
+					label = "rootfs";
+					reg = <0x800000 0x0f800000>;
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-0 = <&pinctrl_i2c0_pu>;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	dmas = <0>, <0>;	/* Do not use DMA for i2c2 */
+	pinctrl-0 = <&pinctrl_i2c2_pu>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3
+			&pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
+	vmmc-supply = <&vcc_mmc0_reg>;
+	vqmmc-supply = <&vcc_3v3_reg>;
+	status = "okay";
+	slot@0 {
+		reg = <0>;
+		bus-width = <8>;
+		cd-gpios = <&pioE 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	board {
+		pinctrl_i2c0_pu: i2c0_pu {
+			atmel,pins =
+				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_i2c2_pu: i2c2_pu {
+			atmel,pins =
+				<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>,
+				<AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_key_gpio: key_gpio_0 {
+			atmel,pins =
+				<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		pinctrl_mmc0_cd: mmc0_cd {
+			atmel,pins =
+				<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		pinctrl_spi0_cs: spi0_cs_default {
+			atmel,pins =
+				<AT91_PIOD 13 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				 AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_spi1_cs: spi1_cs_default {
+			atmel,pins = <AT91_PIOC 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOC 28 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_usba_vbus: usba_vbus {
+			atmel,pins =
+				<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+
+		pinctrl_usb_default: usb_default {
+			atmel,pins =
+				<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				 AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_vcc_mmc0_reg_gpio: vcc_mmc0_reg_gpio_default {
+			atmel,pins = <AT91_PIOE 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+
+		/* Reserved for reset signal to the RGMII connector. */
+		pinctrl_rgmii_rstn: rgmii_rstn {
+			atmel,pins =
+				<AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		/* Reserved for an interrupt line from the RMII and RGMII connectors. */
+		pinctrl_spi_irqn: spi_irqn {
+			atmel,pins =
+				<AT91_PIOB 28 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+
+		/* Reserved for VBUS fault interrupt. */
+		pinctrl_vbusfault_irqn: vbusfault_irqn {
+			atmel,pins =
+				<AT91_PIOE 5 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default", "cs";
+	pinctrl-1 = <&pinctrl_spi0_cs>;
+	cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default", "cs";
+	pinctrl-1 = <&pinctrl_spi1_cs>;
+	cs-gpios = <&pioC 25 0>, <0>, <0>, <&pioC 28 0>;
+	status = "okay";
+};
+
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	atmel,vbus-gpio = <0
+			   &pioE 3 GPIO_ACTIVE_HIGH
+			   &pioE 4 GPIO_ACTIVE_HIGH
+			  >;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	num-ports = <3>;
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.17.1

