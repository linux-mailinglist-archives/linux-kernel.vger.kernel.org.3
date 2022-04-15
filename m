Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0C502ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353850AbiDONWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353606AbiDONWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:22:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E327CEE;
        Fri, 15 Apr 2022 06:19:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJVHq019635;
        Fri, 15 Apr 2022 08:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650028771;
        bh=ymIg58exA+OTnbhtNf4ShBPNkFeIT4HSqOnVXQqtd30=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wt6f+lLO8j4m1KpakSiHVZvf3DNiYN3O/HpIrfWe8nAt5KkKGrEIl5y5tjwzLaC2U
         RFEzUhSl7UyqwapJVDJ6E25n9D4G3pUNkZxiicy0/SwFnyOmD5HFNsG/Ed6mVYuqx6
         kMAh4ReKw3hqkuBYa0UjSD47tLPfW/pX3wQjji/Y=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FDJUKx012070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 08:19:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 08:19:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 08:19:30 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJIkA104572;
        Fri, 15 Apr 2022 08:19:27 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am625-sk: Enable on board peripherals
Date:   Fri, 15 Apr 2022 18:49:17 +0530
Message-ID: <20220415131917.431137-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220415131917.431137-1-vigneshr@ti.com>
References: <20220415131917.431137-1-vigneshr@ti.com>
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

Add nodes for I2C IO expander, OSPI Flash, Eth PHYs, SD and eMMC that
are present on AM625 SK board.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 271 +++++++++++++++++++++++++
 1 file changed, 271 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 0de4113ccd5d..a0ea2cc66b31 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am625.dtsi"
 
 / {
@@ -17,6 +18,10 @@ / {
 
 	aliases {
 		serial2 = &main_uart0;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		spi0 = &ospi0;
 	};
 
 	chosen {
@@ -87,6 +92,33 @@ vcc_3v3_sys: regulator-2 {
 		regulator-boot-on;
 	};
 
+	vdd_mmc1: fixed-regulator-sd {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vcc_3v3_sys>;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: gpio-regulator-TLV71033 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vcc_5v0>;
+		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -124,11 +156,114 @@ AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
 		>;
 	};
 
+	main_i2c2_pins_default: main-i2c2-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */
+			AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_mmc0_pins_default: main-mmc0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
+			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
+			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22) MMC1_DAT0 */
+			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21) MMC1_DAT1 */
+			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
+			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22) MMC1_DAT3 */
+			AM62X_IOPAD(0x240, PIN_INPUT, 0) /* (D17) MMC1_SDCD */
+		>;
+	};
+
 	usr_led_pins_default: usr-led-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x244, PIN_OUTPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
+
+	main_mdio1_pins_default: main-mdio1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
+			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17) RGMII1_RD0 */
+			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17) RGMII1_RD1 */
+			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16) RGMII1_RD2 */
+			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15) RGMII1_RD3 */
+			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17) RGMII1_RXC */
+			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17) RGMII1_RX_CTL */
+			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0 */
+			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1 */
+			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2 */
+			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
+			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
+			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
+		>;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
+			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
+			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
+			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
+			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
+			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
+			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
+			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
+			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
+			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
+			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
+			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
+			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
+			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
+			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
+			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
+			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
+			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
+			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
+			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
+			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -188,6 +323,33 @@ &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
+
+	exp1: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+				   "PRU_DETECT", "MMC1_SD_EN",
+				   "VPP_LDO_EN", "EXP_PS_3V3_En",
+				   "EXP_PS_5V0_En", "EXP_HAT_DETECT",
+				   "GPIO_AUD_RSTn", "GPIO_eMMC_RSTn",
+				   "UART1_FET_BUF_EN", "WL_LT_EN",
+				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
+				   "CSI_GPIO2", "PRU_3V3_EN",
+				   "HDMI_INTn", "TEST_GPIO2",
+				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
+				   "MCASP1_FET_SEL", "UART1_FET_SEL",
+				   "TSINT#", "IO_EXP_TEST_LED";
+
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+	};
 };
 
 &main_i2c2 {
@@ -198,9 +360,118 @@ &main_i2c3 {
 	status = "disabled";
 };
 
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default
+		     &main_rgmii1_pins_default
+		     &main_rgmii2_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
 &mailbox0_cluster0 {
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
 };
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
-- 
2.35.3

