Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E65B004C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiIGJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIGJV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083AB24B4;
        Wed,  7 Sep 2022 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662542511; x=1694078511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7wmw36a8KugfV7YznzGR5A5/hDGBeGb1Rx1sONhZU7w=;
  b=H2j/WtFkw48yRgvj7XB69JOy7ILUKnnuO0ywxGQKehsWNOBmixig7ek9
   c7NILopjmHWeSegcNojtQFPBMepeXGddgogSZDwexj8AV3A+4szDmjaXS
   KolgH22MTqkMEdZ0SREcN8Yk7dP/feSWEYmiChpK378EXKmvvKGUecpIs
   m5a3aGp0d/QgZLLaSlZrLKA4bvddsskAFcAtQ6WdQfUN1JFDUPjDT1LPJ
   RzPaswVv/CuGpIzzgPL58obQTm/3Fe4F0xgFCYWIG3G1/5CqRMlxo4M85
   Z8FswgVe9LjGgOy/Y/Hi7ELqk2Xnoqa/x1V+Oe3o1p65GGj9/Ro5MbGxs
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="172733042"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:21:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:21:47 -0700
Received: from che-lt-i63539lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:21:41 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <manikandan.m@microchip.com>, <michael@walle.cc>,
        <horatiu.vultur@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <durai.manickamkr@microchip.com>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [linux][PATCH 6/6] ARM: dts: at91: sam9x60_curiosity: Add device tree for sam9x60_curiosity board
Date:   Wed, 7 Sep 2022 14:50:54 +0530
Message-ID: <20220907092054.29915-7-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
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

From: Manikandan M <manikandan.m@microchip.com>

Add device tree file for sam9x60_curiosity board.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Signed-off-by: Manikandan M <manikandan.m@microchip.com>
Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
---
 .../devicetree/bindings/arm/atmel-at91.yaml   |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-sam9x60_curiosity.dts  | 532 ++++++++++++++++++
 3 files changed, 539 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60_curiosity.dts

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 2b7848bb7769..fae3a3090fbd 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -97,6 +97,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: SAM9X60 Curiosity board
+        items:
+          - const: microchip,sam9x60-curiosity
+          - const: microchip,sam9x60
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 595e870750cd..cd60cda5d187 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM9X60) += \
+	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
diff --git a/arch/arm/boot/dts/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
new file mode 100644
index 000000000000..75e6727b5e3a
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sam9x60_curiosity.dts - Device Tree file for Microchip SAM9X60 CURIOSITY board
+ *
+ * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Manikandan M <manikandan.m@microchip.com>
+ */
+/dts-v1/;
+#include "sam9x60.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Microchip SAM9X60 CURIOSITY";
+	compatible = "microchip,sam9x60-curiosity", "microchip,sam9x60", "atmel,at91sam9";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c6;
+		serial2 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@20000000 {
+		reg = <0x20000000 0x8000000>;
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+		status = "okay";
+
+		button-user {
+			label = "PB_USER";
+			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+		status = "okay";
+
+		red {
+			label = "red";
+			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		green {
+			label = "green";
+			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		blue {
+			label = "blue";
+			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	regulators: regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_1v8: fixed-regulator-vdd_1v8@0 {
+			compatible = "regulator-fixed";
+			regulator-name = "VDD_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			status = "okay";
+		};
+
+		vdd_1v15: fixed-regulator-vdd_1v15@1 {
+			compatible = "regulator-fixed";
+			regulator-name = "VDD_1V15";
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+			regulator-always-on;
+			status = "okay";
+		};
+
+		vdd1_3v3: fixed-regulator-vdd1_3v3@2 {
+			compatible = "regulator-fixed";
+			regulator-name = "VDD1_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			status = "okay";
+		};
+	};
+};
+
+&adc {
+	vddana-supply = <&vdd1_3v3>;
+	vref-supply = <&vdd1_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
+	status = "okay";
+};
+
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_rx_tx>;
+	status = "disabled"; /* Conflict with dbgu. */
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_rx_tx>;
+	status = "okay";
+};
+
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu>;
+	status = "okay"; /* Conflict with can0. */
+};
+
+&ebi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_0_7>;
+	status = "okay";
+
+	nand_controller: nand-controller {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nand_oe_we &pinctrl_nand_cs &pinctrl_nand_rb>;
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
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
+				uboot@40000 {
+					label = "u-boot";
+					reg = <0x40000 0xc0000>;
+				};
+
+				ubootenvred@100000 {
+					label = "U-Boot Env Redundant";
+					reg = <0x100000 0x40000>;
+				};
+
+				ubootenv@140000 {
+					label = "U-Boot Env";
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
+					reg = <0x800000 0x1f800000>;
+				};
+			};
+		};
+	};
+};
+
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c0: i2c@600 {
+		dmas = <0>, <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx0_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "okay";
+
+		eeprom@53 {
+			compatible = "atmel,24c02";
+			reg = <0x53>;
+			pagesize = <16>;
+			status = "okay";
+		};
+	};
+};
+
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c6: i2c@600 {
+		dmas = <0>, <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx6_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "disabled";
+	};
+};
+
+&flx7 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	uart7: serial@200 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx7_default>;
+		status = "okay";
+	};
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_rmii>;
+	status = "okay";
+
+	ethernet-phy@0 {
+		reg = <0x0>;
+	};
+};
+
+&pinctrl {
+	adc {
+		pinctrl_adc_default: adc_default {
+			atmel,pins = <AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_adtrg_default: adtrg_default {
+			atmel,pins = <AT91_PIOB 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	can0 {
+		pinctrl_can0_rx_tx: can0_rx_tx {
+			atmel,pins =
+				<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX0 */
+				 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANTX0 */
+				 AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_DOWN>;	/* Enable CAN Transceivers */
+		};
+	};
+
+	can1 {
+		pinctrl_can1_rx_tx: can1_rx_tx {
+			atmel,pins =
+				<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX1 */
+				 AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANTX1 */
+				 AT91_PIOB 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_DOWN>;	/* Enable CAN Transceivers */
+		};
+	};
+
+	dbgu {
+		pinctrl_dbgu: dbgu-0 {
+			atmel,pins = <AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				      AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
+	ebi {
+		pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
+			atmel,pins =
+				<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_ebi_data_0_15: ebi-data-msb-0 {
+			atmel,pins =
+				<AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 14 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 15 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+				 AT91_PIOD 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_ebi_addr_nand: ebi-addr-0 {
+			atmel,pins =
+				<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+	};
+
+	flexcom {
+		pinctrl_flx0_default: flx0_twi {
+			atmel,pins =
+				<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_flx6_default: flx6_twi {
+			atmel,pins =
+				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_flx7_default: flx7_usart {
+			atmel,pins =
+				<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_NONE
+				 AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_NONE>;
+		};
+	};
+
+	gpio_keys {
+		pinctrl_key_gpio_default: pinctrl_key_gpio {
+			atmel,pins = <AT91_PIOA 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	leds {
+		pinctrl_gpio_leds: gpio_leds {
+			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	macb0 {
+		pinctrl_macb0_rmii: macb0_rmii-0 {
+			atmel,pins =
+				<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB0 periph A */
+				 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
+				 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
+				 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
+				 AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
+				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
+				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
+				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
+				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
+		};
+	};
+
+	nand {
+		pinctrl_nand_oe_we: nand-oe-we-0 {
+			atmel,pins =
+				<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_nand_rb: nand-rb-0 {
+			atmel,pins =
+				<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_nand_cs: nand-cs-0 {
+			atmel,pins =
+				<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	pwm0 {
+		pinctrl_pwm0_0: pwm0_0 {
+			atmel,pins = <AT91_PIOB 12 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_pwm0_1: pwm0_1 {
+			atmel,pins = <AT91_PIOB 13 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_pwm0_2: pwm0_2 {
+			atmel,pins = <AT91_PIOD 16 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc0 {
+		pinctrl_sdmmc0_default: sdmmc0 {
+			atmel,pins =
+				<AT91_PIOA 17 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA17 CK  periph A with pullup */
+				 AT91_PIOA 16 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA16 CMD periph A with pullup */
+				 AT91_PIOA 15 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA15 DAT0 periph A */
+				 AT91_PIOA 18 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA18 DAT1 periph A with pullup */
+				 AT91_PIOA 19 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA19 DAT2 periph A with pullup */
+				 AT91_PIOA 20 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA20 DAT3 periph A with pullup */
+		};
+		pinctrl_sdmmc0_cd: sdmmc0_cd {
+			atmel,pins =
+				<AT91_PIOA 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc1 {
+		pinctrl_sdmmc1_default: sdmmc1 {
+			atmel,pins =
+				<AT91_PIOA 13 AT91_PERIPH_B (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA13 CK periph B */
+				 AT91_PIOA 12 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA12 CMD periph B with pullup */
+				 AT91_PIOA 11 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA11 DAT0 periph B with pullup */
+				 AT91_PIOA  2 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA2 DAT1 periph B with pullup */
+				 AT91_PIOA  3 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA3 DAT2 periph B with pullup */
+				 AT91_PIOA  4 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA4 DAT3 periph B with pullup */
+		};
+	};
+
+	usb0 {
+		pinctrl_usba_vbus: usba_vbus {
+			atmel,pins = <AT91_PIOA 27 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	usb1 {
+		pinctrl_usb_default: usb_default {
+			atmel,pins = <AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+}; /* pinctrl */
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_0 &pinctrl_pwm0_1 &pinctrl_pwm0_2>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
+	cd-gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	status = "disabled";
+};
+
+&shutdown_controller {
+	debounce-delay-us = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
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
+	atmel,vbus-gpio = <&pioA 27 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	num-ports = <3>;
+	atmel,vbus-gpio = <0
+			   &pioD 18 GPIO_ACTIVE_HIGH
+			   &pioD 15 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.17.1

