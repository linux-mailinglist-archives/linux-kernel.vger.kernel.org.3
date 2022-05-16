Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271F5285F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiEPNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbiEPNuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:16 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8D3A18D;
        Mon, 16 May 2022 06:49:18 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M7IS8-1ndzez1WYY-00wzGX;
 Mon, 16 May 2022 15:49:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/24] ARM: dts: imx7-colibri: alphabetical re-order
Date:   Mon, 16 May 2022 15:47:28 +0200
Message-Id: <20220516134734.493065-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:epwPzq8L5S+/wuSoXiph1gPkkbfQuhNK/AXvIrhr8ap/waZSheh
 iMSRY7NIDkLopA1Qto4bR+Yl/ge204yBB60qBDmewYhhhGqmv6/qq1Aryw7Wf0vDrEWOctp
 gCE+46SXg7XpYaZRYfGE08XRGTKtnFUVpUoSwyYBpL/HcJFxyTbRQGAzw/1GEymwYaORu3/
 l/uvC6JHDsXr6SrpswQlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sXL2l1pXvtE=:2PP7KeCTP4mQfUlFjDQUrR
 /fWs+yvPmLh2fc2wm4Q7FyjkH3LLQWiW3BHvLyEDGBHTxsvzhOzUe1VynqjMLqYnEFVKCj33N
 ZDPzmjlN9L32kTZ+0tUYSF7UWB6SJrR6mgCyvLvbGHESTE2JnnZOnZWJZx8zcUxC5Di/vAzjm
 89s6k2X6abhQ+nINbG39/XZ9Hb+L5bcXm1OsU6IKvi8KyZu6Ev4Yb7qbfrpo+daKMAC5OSFt+
 nECmYFBP6ejlFpZRSYhXn5G5i3KxMlhYcGt2IjaeoAQ2rF0Gc6dW45prU0I21DNbcEavuxszD
 3jQ7moRmEnZkNWWtEGELPtuD6hWS9dVoB5ciKQFAg7qVyxjEse9RiszwiLCQMpd3J2IgWLq5C
 DZSqgIfNH1LgBcwIf35PMs4CY9HZJFzMT8vH72fDy0tmONxVvTHESQ5nA4RA8dxJ0+JyejrZ8
 +zfyYEiY8jXbaYllA7UeeXqOnVBbDMgzSiJDaQxAJMTCBQxiUwVd7DFFa8MA3mLE0kSy9BRYM
 +i2if0cOOZU6FhQuJ9cQVsDydeMYmc83gF081lDHcDjayKkm0kW4tAxkU110WxytSLQ3hexzo
 oRQ1i3J+FwDehpdjIWZ444hh1p14GTaFoqOHbFTwMVPVD8/5Cr0xyLTkBP0/mDyRX6Io0GqX8
 +5YatjzMECcCzSROwc+Uaam1zn0xaJG6RCCFdlH+KaIcclBmul1A3X1kQalU09ip36g6w9LqP
 PY6S5Cd8ldFx52gR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Alphabetically re-order device tree iomuxc pinctrl pads, nodes and
properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi |   6 +-
 arch/arm/boot/dts/imx7-colibri.dtsi         | 368 ++++++++++----------
 2 files changed, 186 insertions(+), 188 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 441331b09fb4..fea6e4c0d4d6 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -34,13 +34,13 @@ &ecspi3 {
 	status = "okay";
 
 	mcp2515: can@0 {
+		clocks = <&clk16m>;
 		compatible = "microchip,mcp2515";
+		interrupt-parent = <&gpio5>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can_int>;
 		reg = <0>;
-		clocks = <&clk16m>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		spi-max-frequency = <10000000>;
 		vdd-supply = <&reg_3v3>;
 		xceiver-supply = <&reg_5v0>;
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 4416b7befbfe..f29096fca54d 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -118,18 +118,18 @@ reg_usbh_vbus: regulator-usbh-vbus {
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "imx7-sgtl5000";
-		simple-audio-card,format = "i2s";
 		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,name = "imx7-sgtl5000";
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai1>;
 		};
 
 		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
 			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
+			sound-dai = <&codec>;
 		};
 	};
 };
@@ -150,9 +150,9 @@ &cpu0 {
 
 /* Colibri SSP */
 &ecspi3 {
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>; /* SODIMM 86 / SSPFRM */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
-	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>; /* SODIMM 86 / SSPFRM */
 };
 
 /* Colibri Fast Ethernet */
@@ -380,11 +380,11 @@ &gpio7 {
 
 /* NAND on such SKUs */
 &gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
 	fsl,use-minimum-ecc;
-	nand-on-flash-bbt;
 	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
 };
 
 /* On-module Power I2C */
@@ -398,15 +398,15 @@ &i2c1 {
 	status = "okay";
 
 	codec: sgtl5000@a {
-		compatible = "fsl,sgtl5000";
 		#sound-dai-cells = <0>;
-		reg = <0x0a>;
 		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_DIV>;
+		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1_mclk>;
+		reg = <0x0a>;
 		VDDA-supply = <&reg_module_3v3_avdd>;
-		VDDIO-supply = <&reg_module_3v3>;
 		VDDD-supply = <&reg_DCDC3>;
+		VDDIO-supply = <&reg_module_3v3>;
 	};
 
 	ad7879_ts: touchscreen@2c {
@@ -430,65 +430,65 @@ pmic@33 {
 
 		regulators {
 			reg_DCDC1: DCDC1 {  /* V1.0_SOC */
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1000000>;
 			};
 
 			reg_DCDC2: DCDC2 { /* V1.1_ARM */
-				regulator-min-microvolt = <975000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <975000>;
 			};
 
 			reg_DCDC3: DCDC3 { /* V1.8 */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			reg_DCDC4: DCDC4 { /* V1.35_DRAM */
-				regulator-min-microvolt = <1350000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <1350000>;
 			};
 
 			reg_LDO1: LDO1 { /* PWR_EN_+V3.3_ETH */
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
 			};
 
 			reg_LDO2: LDO2 { /* +V1.8_SD */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			reg_LDO3: LDO3 { /* PWR_EN_+V3.3_LPSR */
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
 			};
 
 			reg_LDO4: LDO4 { /* V1.8_LPSR */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
 			};
 
 			reg_LDO5: LDO5 { /* PWR_EN_+V3.3 */
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
 				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
 			};
 		};
 	};
@@ -575,31 +575,31 @@ &sai1 {
 
 /* Colibri UART_A */
 &uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
 	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
 	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
-	uart-has-rtscts;
 	fsl,dte-mode;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
+	uart-has-rtscts;
 };
 
 /* Colibri UART_B */
 &uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
 	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
 	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
-	uart-has-rtscts;
 	fsl,dte-mode;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
 };
 
 /* Colibri UART_C */
 &uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
 	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
 	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
 	fsl,dte-mode;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
 };
 
 /* Colibri USBC */
@@ -625,18 +625,18 @@ &usdhc1 {
 
 /* eMMC on 1GB (eMMC) SKUs */
 &usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
 	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	fsl,tuning-step = <2>;
-	vmmc-supply = <&reg_module_3v3>;
-	vqmmc-supply = <&reg_DCDC3>;
 	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	sdhci-caps-mask = <0x80000000 0x0>;
+	vmmc-supply = <&reg_module_3v3>;
+	vqmmc-supply = <&reg_DCDC3>;
 };
 
 &iomuxc {
@@ -663,13 +663,73 @@ MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 / INT */
 		>;
 	};
 
+	pinctrl_can_int: can-int-grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3-grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2 /* SODIMM 90 */
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2 /* SODIMM 92 */
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2 /* SODIMM 88 */
+		>;
+	};
+
+	pinctrl_ecspi3_cs: ecspi3-cs-grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14 /* SODIMM 86 */
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x73
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x73
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RX_ER		0x73
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x73
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x73
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x73
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x73
+			MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1		0x73
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+		>;
+	};
+
+	pinctrl_enet1_sleep: enet1sleepgrp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD0__GPIO7_IO0		0x0
+			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1		0x0
+			MX7D_PAD_ENET1_RGMII_RXC__GPIO7_IO5		0x0
+			MX7D_PAD_ENET1_RGMII_RX_CTL__GPIO7_IO4		0x0
+			MX7D_PAD_ENET1_RGMII_TD0__GPIO7_IO6		0x0
+			MX7D_PAD_ENET1_RGMII_TD1__GPIO7_IO7		0x0
+			MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10		0x0
+			MX7D_PAD_GPIO1_IO12__GPIO1_IO12			0x0
+			MX7D_PAD_SD2_CD_B__GPIO5_IO9			0x0
+			MX7D_PAD_SD2_WP__GPIO5_IO10			0x0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD2__FLEXCAN1_RX	0x79 /* SODIMM 63 */
+			MX7D_PAD_ENET1_RGMII_RD3__FLEXCAN1_TX	0x79 /* SODIMM 55 */
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2-grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x79 /* SODIMM 188 */
+			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x79 /* SODIMM 178 */
+		>;
+	};
+
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins = <
-			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x14 /* SODIMM 77 */
-			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
-			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x74 /* SODIMM 91 */
-			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
-			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
+			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
 			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
 			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
 			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14 /* SODIMM 115 */
@@ -678,47 +738,51 @@ MX7D_PAD_EPDC_DATA04__GPIO2_IO4		0x14 /* SODIMM 119 */
 			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x14 /* SODIMM 121 */
 			MX7D_PAD_EPDC_DATA06__GPIO2_IO6		0x14 /* SODIMM 123 */
 			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x14 /* SODIMM 125 */
-			MX7D_PAD_EPDC_SDCE2__GPIO2_IO22		0x14 /* SODIMM 127 */
-			MX7D_PAD_UART3_RTS_B__GPIO4_IO6		0x14 /* SODIMM 131 */
+			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x74 /* SODIMM 91 */
+			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
+			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
+			MX7D_PAD_EPDC_DATA11__GPIO2_IO11	0x14 /* SODIMM 152 */
+			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14 /* SODIMM 150 */
+			MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x14 /* SODIMM 126 */
+			MX7D_PAD_EPDC_GDCLK__GPIO2_IO24		0x14 /* SODIMM 132 */
+			MX7D_PAD_EPDC_GDOE__GPIO2_IO25		0x14 /* SODIMM 134 */
 			MX7D_PAD_EPDC_GDRL__GPIO2_IO26		0x14 /* SODIMM 133 */
-			MX7D_PAD_SAI1_RX_DATA__GPIO6_IO12	0x14 /* SODIMM 169 */
-			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
-			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
-			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
 			MX7D_PAD_EPDC_GDSP__GPIO2_IO27		0x14 /* SODIMM 104 */
-			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
 			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30	0x14 /* SODIMM 112 */
+			MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31	0x14 /* SODIMM 128 */
+			MX7D_PAD_EPDC_SDCE0__GPIO2_IO20		0x14 /* SODIMM 122 */
+			MX7D_PAD_EPDC_SDCE1__GPIO2_IO21		0x14 /* SODIMM 124 */
+			MX7D_PAD_EPDC_SDCE2__GPIO2_IO22		0x14 /* SODIMM 127 */
+			MX7D_PAD_EPDC_SDCE3__GPIO2_IO23		0x14 /* SODIMM 130 */
 			MX7D_PAD_EPDC_SDCLK__GPIO2_IO16		0x14 /* SODIMM 114 */
 			MX7D_PAD_EPDC_SDLE__GPIO2_IO17		0x14 /* SODIMM 116 */
 			MX7D_PAD_EPDC_SDOE__GPIO2_IO18		0x14 /* SODIMM 118 */
 			MX7D_PAD_EPDC_SDSHR__GPIO2_IO19		0x14 /* SODIMM 120 */
-			MX7D_PAD_EPDC_SDCE0__GPIO2_IO20		0x14 /* SODIMM 122 */
-			MX7D_PAD_EPDC_SDCE1__GPIO2_IO21		0x14 /* SODIMM 124 */
-			MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x14 /* SODIMM 126 */
-			MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31	0x14 /* SODIMM 128 */
-			MX7D_PAD_EPDC_SDCE3__GPIO2_IO23		0x14 /* SODIMM 130 */
-			MX7D_PAD_EPDC_GDCLK__GPIO2_IO24		0x14 /* SODIMM 132 */
-			MX7D_PAD_EPDC_GDOE__GPIO2_IO25		0x14 /* SODIMM 134 */
-			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14 /* SODIMM 150 */
-			MX7D_PAD_EPDC_DATA11__GPIO2_IO11	0x14 /* SODIMM 152 */
+			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
+			MX7D_PAD_SAI1_RX_BCLK__GPIO6_IO17	0x14 /* SODIMM 24 */
+			MX7D_PAD_SAI1_RX_DATA__GPIO6_IO12	0x14 /* SODIMM 169 */
+			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x14 /* SODIMM 77 */
 			MX7D_PAD_SD2_CLK__GPIO5_IO12		0x14 /* SODIMM 184 */
 			MX7D_PAD_SD2_CMD__GPIO5_IO13		0x14 /* SODIMM 186 */
+			MX7D_PAD_SD2_DATA2__GPIO5_IO16		0x14 /* SODIMM 100 */
+			MX7D_PAD_SD2_DATA3__GPIO5_IO17		0x14 /* SODIMM 102 */
+			MX7D_PAD_UART3_RTS_B__GPIO4_IO6		0x14 /* SODIMM 131 */
 		>;
 	};
 
 	pinctrl_gpio2: gpio2-grp { /* On X22 Camera interface */
 		fsl,pins = <
-			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
-			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x74 /* SODIMM 69 */
-			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
 			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
-			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
-			MX7D_PAD_ECSPI2_MISO__GPIO4_IO22	0x14 /* SODIMM 85 */
-			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x14 /* SODIMM 97 */
-			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x14 /* SODIMM 101 */
 			MX7D_PAD_ECSPI1_MOSI__GPIO4_IO17	0x14 /* SODIMM 103 */
+			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x14 /* SODIMM 101 */
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x14 /* SODIMM 97 */
+			MX7D_PAD_ECSPI2_MISO__GPIO4_IO22	0x14 /* SODIMM 85 */
+			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x14 /* SODIMM 65 */
+			MX7D_PAD_I2C3_SCL__GPIO4_IO12		0x14 /* SODIMM 81 */
 			MX7D_PAD_I2C3_SDA__GPIO4_IO13		0x14 /* SODIMM 94 */
 			MX7D_PAD_I2C4_SCL__GPIO4_IO14		0x14 /* SODIMM 96 */
+			MX7D_PAD_I2C4_SDA__GPIO4_IO15		0x14 /* SODIMM 75 */
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x74 /* SODIMM 69 */
 			MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x14 /* SODIMM 98 */
 		>;
 	};
@@ -736,87 +800,15 @@ MX7D_PAD_LCD_DATA23__GPIO3_IO28		0x74 /* SODIMM 146 */
 
 	pinctrl_gpio4: gpio4-grp { /* Alternatively CAN2 */
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x14 /* SODIMM 178 */
 			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x14 /* SODIMM 188 */
+			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x14 /* SODIMM 178 */
 		>;
 	};
 
 	pinctrl_gpio7: gpio7-grp { /* Alternatively CAN1 */
 		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x14 /* SODIMM 55 */
 			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x14 /* SODIMM 63 */
-		>;
-	};
-
-	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
-		fsl,pins = <
-			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
-		>;
-	};
-
-	pinctrl_can_int: can-int-grp {
-		fsl,pins = <
-			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
-		>;
-	};
-
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x73
-			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x73
-			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x73
-			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RX_ER		0x73
-
-			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x73
-			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x73
-			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x73
-			MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1		0x73
-			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
-			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
-		>;
-	};
-
-	pinctrl_enet1_sleep: enet1sleepgrp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_RX_CTL__GPIO7_IO4		0x0
-			MX7D_PAD_ENET1_RGMII_RD0__GPIO7_IO0		0x0
-			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1		0x0
-			MX7D_PAD_ENET1_RGMII_RXC__GPIO7_IO5		0x0
-
-			MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10		0x0
-			MX7D_PAD_ENET1_RGMII_TD0__GPIO7_IO6		0x0
-			MX7D_PAD_ENET1_RGMII_TD1__GPIO7_IO7		0x0
-			MX7D_PAD_GPIO1_IO12__GPIO1_IO12			0x0
-			MX7D_PAD_SD2_CD_B__GPIO5_IO9			0x0
-			MX7D_PAD_SD2_WP__GPIO5_IO10			0x0
-		>;
-	};
-
-	pinctrl_ecspi3_cs: ecspi3-cs-grp {
-		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14 /* SODIMM 86 */
-		>;
-	};
-
-	pinctrl_ecspi3: ecspi3-grp {
-		fsl,pins = <
-			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2 /* SODIMM 90 */
-			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2 /* SODIMM 92 */
-			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2 /* SODIMM 88 */
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1-grp {
-		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_RD3__FLEXCAN1_TX	0x79 /* SODIMM 55 */
-			MX7D_PAD_ENET1_RGMII_RD2__FLEXCAN1_RX	0x79 /* SODIMM 63 */
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2-grp {
-		fsl,pins = <
-			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x79 /* SODIMM 188 */
-			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x79 /* SODIMM 178 */
+			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x14 /* SODIMM 55 */
 		>;
 	};
 
@@ -828,12 +820,10 @@ MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
 
 	pinctrl_gpmi_nand: gpmi-nand-grp {
 		fsl,pins = <
-			MX7D_PAD_SD3_CLK__NAND_CLE		0x71
-			MX7D_PAD_SD3_CMD__NAND_ALE		0x71
 			MX7D_PAD_SAI1_TX_BCLK__NAND_CE0_B	0x71
 			MX7D_PAD_SAI1_TX_DATA__NAND_READY_B	0x74
-			MX7D_PAD_SD3_STROBE__NAND_RE_B		0x71
-			MX7D_PAD_SD3_RESET_B__NAND_WE_B		0x71
+			MX7D_PAD_SD3_CLK__NAND_CLE		0x71
+			MX7D_PAD_SD3_CMD__NAND_ALE		0x71
 			MX7D_PAD_SD3_DATA0__NAND_DATA00		0x71
 			MX7D_PAD_SD3_DATA1__NAND_DATA01		0x71
 			MX7D_PAD_SD3_DATA2__NAND_DATA02		0x71
@@ -842,13 +832,21 @@ MX7D_PAD_SD3_DATA4__NAND_DATA04		0x71
 			MX7D_PAD_SD3_DATA5__NAND_DATA05		0x71
 			MX7D_PAD_SD3_DATA6__NAND_DATA06		0x71
 			MX7D_PAD_SD3_DATA7__NAND_DATA07		0x71
+			MX7D_PAD_SD3_RESET_B__NAND_WE_B		0x71
+			MX7D_PAD_SD3_STROBE__NAND_RE_B		0x71
+		>;
+	};
+
+	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
 		>;
 	};
 
 	pinctrl_i2c4: i2c4-grp {
 		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f /* SODIMM 194 */
 			MX7D_PAD_ENET1_RGMII_TD2__I2C4_SCL	0x4000007f /* SODIMM 196 */
+			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f /* SODIMM 194 */
 		>;
 	};
 
@@ -897,8 +895,8 @@ pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
 		fsl,pins = <
 			MX7D_PAD_LCD_CLK__LCD_CLK		0x79 /* SODIMM 56 */
 			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79 /* SODIMM 44 */
-			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79 /* SODIMM 82 */
 			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79 /* SODIMM 68 */
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79 /* SODIMM 82 */
 		>;
 	};
 
@@ -913,8 +911,8 @@ MX7D_PAD_EPDC_DATA13__GPIO2_IO13        0x14 /* SODIMM 95 */
 
 	pinctrl_pwm1: pwm1-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79 /* SODIMM 59 */
 			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x4  /* SODIMM 59 */
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79 /* SODIMM 59 */
 		>;
 	};
 
@@ -932,39 +930,39 @@ MX7D_PAD_GPIO1_IO10__PWM3_OUT		0x79 /* SODIMM 30 */
 
 	pinctrl_pwm4: pwm4-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79 /* SODIMM 67 */
 			MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x4  /* SODIMM 67 */
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79 /* SODIMM 67 */
 		>;
 	};
 
 	pinctrl_uart1: uart1-grp {
 		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79 /* SODIMM 33 */
-			MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX	0x79 /* SODIMM 35 */
 			MX7D_PAD_SAI2_TX_BCLK__UART1_DTE_CTS	0x79 /* SODIMM 25 */
 			MX7D_PAD_SAI2_TX_SYNC__UART1_DTE_RTS	0x79 /* SODIMM 27 */
+			MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX	0x79 /* SODIMM 35 */
+			MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79 /* SODIMM 33 */
 		>;
 	};
 
 	pinctrl_uart1_ctrl1: uart1-ctrl1-grp {
 		fsl,pins = <
-			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* SODIMM 31 / DCD */
 			MX7D_PAD_SD2_DATA0__GPIO5_IO14		0x14 /* SODIMM 23 / DTR */
+			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* SODIMM 31 / DCD */
 		>;
 	};
 
 	pinctrl_uart2: uart2-grp {
 		fsl,pins = <
-			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX	0x79 /* SODIMM 36 */
-			MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX	0x79 /* SODIMM 38 */
 			MX7D_PAD_SAI2_RX_DATA__UART2_DTE_RTS	0x79 /* SODIMM 32 / CTS */
 			MX7D_PAD_SAI2_TX_DATA__UART2_DTE_CTS	0x79 /* SODIMM 34 / RTS */
+			MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX	0x79 /* SODIMM 38 */
+			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX	0x79 /* SODIMM 36 */
 		>;
 	};
 	pinctrl_uart3: uart3-grp {
 		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX	0x79 /* SODIMM 19 */
 			MX7D_PAD_UART3_RX_DATA__UART3_DTE_TX	0x79 /* SODIMM 21 */
+			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX	0x79 /* SODIMM 19 */
 		>;
 	};
 
@@ -1027,8 +1025,8 @@ MX7D_PAD_SD1_DATA3__SD1_DATA3		0x10
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
 			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
 			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
 			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
@@ -1043,8 +1041,8 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x19
 
 	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
 		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
 			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
 			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
 			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
@@ -1059,8 +1057,8 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1a
 
 	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
 		fsl,pins = <
-			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
 			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
 			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
 			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
@@ -1075,10 +1073,10 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1b
 
 	pinctrl_sai1: sai1-grp {
 		fsl,pins = <
-			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
-			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
 			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
+			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
 			MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
+			MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
 		>;
 	};
 
@@ -1093,6 +1091,18 @@ &iomuxc_lpsr {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio_lpsr>;
 
+	pinctrl_cd_usdhc1: cdusdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* SODIMM 43 / MMC_CD */
+		>;
+	};
+
+	pinctrl_cd_usdhc1_sleep: cdusdhc1-slpgrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x0
+		>;
+	};
+
 	pinctrl_gpio_lpsr: gpio1-grp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59 /* SODIMM 135 */
@@ -1108,8 +1118,8 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19 /* SODIMM 45 / WAKE_UP */
 
 	pinctrl_i2c1: i2c1-grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
 			MX7D_PAD_LPSR_GPIO1_IO04__I2C1_SCL	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
 		>;
 	};
 
@@ -1120,22 +1130,10 @@ MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
 		>;
 	};
 
-	pinctrl_cd_usdhc1: cdusdhc1grp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* SODIMM 43 / MMC_CD */
-		>;
-	};
-
-	pinctrl_cd_usdhc1_sleep: cdusdhc1-slpgrp {
-		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x0
-		>;
-	};
-
 	pinctrl_uart1_ctrl2: uart1-ctrl2-grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* SODIMM 29 / DSR */
 			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14 /* SODIMM 37 / RI */
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* SODIMM 29 / DSR */
 		>;
 	};
 };
-- 
2.35.1

