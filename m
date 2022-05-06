Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0407A51DC23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443031AbiEFPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442897AbiEFPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:56 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F06D38C;
        Fri,  6 May 2022 08:29:11 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Md62J-1oMbc60tF5-00aBhj;
 Fri, 06 May 2022 17:28:29 +0200
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
Subject: [PATCH v1 01/24] ARM: dts: imx7-colibri: overhaul display/touch functionality
Date:   Fri,  6 May 2022 17:27:46 +0200
Message-Id: <20220506152809.295409-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:77h+1xeLkAt53wPfBbFh9kkuLoma1S0AcIWUDi4rl7DsdSNusTp
 zg+aOQBxj4C6nY6hg/K34dj02JEwAX5krxqRLZCzPxGj5NWk6zISsof5YLyM4nFhIL+Y36j
 qho/Nx/mbxwXFrnYlXiW9csu90DsIM0C7mGCbhuXk7Vdd3kpvr+X5iXnEemjYd9S9cuIBPU
 /KH6aaVWK2OuHlBH0mhIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmx6wwkPXok=:9MaAlJzW4RESRUnv+VEx8M
 D7B8A9y73Kq+U94vR+v4Sr6CmWNlHEy7JFvxqPLVPnQc8cp69C7yJs4m6od/U2QZADVzHssJ/
 qbyqmgGdvJiC0PNhLpOwe87EAX77dNSgDLNA0nbx8qQw70yw6XDbyXu1sbx0OSTFKkjdtzknZ
 Fr7O8q8qzEoydQWpfpXwDz7JfLU5G3POucpQmxx+1VC+RNAVROsh4yy2TnRoFqVayZxlcBUMc
 1P69rYYfWSPKOy1nrJ8JGkfLS99Y8PEybGC/GVlHDGu2VVVD6Pg+wa1I64MnNWMPKk1+NJd8s
 BoPRpq8KJKeKKlSJ1UPL+8CejHitUg4BplTjwep1GkFBWTcANz7mFUPnsHutMs4pZf40s4PCZ
 FdTQdq+MAU7E39uezY3FePp4FnA3EdGqzuwbIf4+NevbtAHmCxIqLyWz6S2Eaouz9ck8TZhcq
 fSArGO2kmx+ovTSnQ0Iqd+Z2s2NvV9kjI01XjMLWvPvU8UrpxL/PRsc7AnKRxHJbREBo81Jiz
 zeiByYDK2X39gNIqYlq9hia2yl/fK8lTYQ/t/3RrhKjDkjQNrg2+VYwyjYnjq3H60ye2vVxCJ
 UyyNLIYNdid3v7GWt2PKgji3McG2LTT2Y+QSf+zrlp92uqENp6n6tgnATLa/vGvuC8ZPQWIK5
 SvWhn9beMfqKNSG8fOgI/co/9OGF3VksfC1jWys7hGV5NM73SB8UUZz6qeGN/qxZJryiITMnX
 1F7trBJZW38xF6nv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename display interface to match other modules to make it easier to
use device tree overlays.

The parallel RGB interface (lcdif) and all related stuff turn on in a
device tree overlay. Keep them disabled in the main devicetree.
As these subsystems are provided by module and not a part of boards,
move their definitions into the module-level devicetree.

Disable ad7879 touchscreen which turns on in a devic tree overlay.
Remains it disabled in the main devicetree.

Move Atmel MXT capacitive touch controller device tree nodes from
carrier board to module level and add iomux pinctl groups for both the
Capacitive Touch Adapter (using SODIMM 28/30) and the capacitive touch
connector as found on later carrier boards (using SODIMM 106/107).

Keep touchscreen and display nodes enabled for NAND based i.MX 7
modules, since device tree overlays are not yet supported. For the
Colibri Evaluation Board keep the Capacitive Touch Adapter node
disabled and PWM2, PWM3 enabled instead.

For eMMC based modules keep nodes disabled to work in conjunction with
device tree overlays.

Add the iomuxc pinctrl group for the LVDS transceiver related signals to
use it in a device tree overlay.

While at it also alphabetically re=order them properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 53 ------------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 66 +++-----------
 arch/arm/boot/dts/imx7-colibri.dtsi         | 95 ++++++++++++++++++---
 arch/arm/boot/dts/imx7d-colibri-aster.dts   | 20 +++++
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts | 32 +++++++
 arch/arm/boot/dts/imx7s-colibri-aster.dts   | 20 +++++
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts | 32 +++++++
 7 files changed, 197 insertions(+), 121 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index b770fc937970..950b4e5f6cf4 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -4,10 +4,6 @@
  *
  */
 
-
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pwm/pwm.h>
-
 / {
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -27,18 +23,6 @@ power {
 		};
 	};
 
-	panel: panel {
-		compatible = "edt,et057090dhu";
-		backlight = <&bl>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lcdif_out>;
-			};
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
@@ -77,13 +61,6 @@ &adc2 {
 	status = "disabled";
 };
 
-&bl {
-	brightness-levels = <0 4 8 16 32 64 128 255>;
-	default-brightness-level = <6>;
-	power-supply = <&reg_3v3>;
-	status = "okay";
-};
-
 &fec1 {
 	status = "okay";
 };
@@ -91,17 +68,6 @@ &fec1 {
 &i2c4 {
 	status = "okay";
 
-	/* Microchip/Atmel maxtouch controller */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiotouch>;
-		reg = <0x4a>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
-		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;	/* SODIMM 106 */
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc: rtc@68 {
 		compatible = "st,m41t0";
@@ -109,25 +75,6 @@ rtc: rtc@68 {
 	};
 };
 
-&iomuxc {
-	pinctrl_gpiotouch: touchgpios {
-		fsl,pins = <
-			MX7D_PAD_EPDC_DATA15__GPIO2_IO15        0x74
-			MX7D_PAD_EPDC_BDR0__GPIO2_IO28          0x14
-		>;
-	};
-};
-
-&lcdif {
-	status = "okay";
-
-	port {
-		lcdif_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
-
 &pwm1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 3b9df8c82ae3..d6fa74222960 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -34,18 +34,6 @@ power {
 		};
 	};
 
-	panel: panel {
-		compatible = "edt,et057090dhu";
-		backlight = <&bl>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lcdif_out>;
-			};
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
@@ -72,14 +60,6 @@ reg_usbh_vbus: regulator-usbh-vbus {
 	};
 };
 
-&bl {
-	brightness-levels = <0 4 8 16 32 64 128 255>;
-	default-brightness-level = <6>;
-	power-supply = <&reg_3v3>;
-
-	status = "okay";
-};
-
 &adc1 {
 	status = "okay";
 };
@@ -88,6 +68,18 @@ &adc2 {
 	status = "okay";
 };
 
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	interrupt-parent = <&gpio1>;
+	interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 / INT */
+	pinctrl-0 = <&pinctrl_atmel_adapter>;
+	reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;	/* SODIMM 30 / RST */
+	status = "disabled";
+};
+
 &ecspi3 {
 	status = "okay";
 
@@ -113,21 +105,6 @@ &fec1 {
 &i2c4 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiotouch>;
-		reg = <0x4a>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
-		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;	/* SODIMM 30 */
-		status = "disabled";
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc: rtc@68 {
 		compatible = "st,m41t0";
@@ -135,16 +112,6 @@ rtc: rtc@68 {
 	};
 };
 
-&lcdif {
-	status = "okay";
-
-	port {
-		lcdif_out: endpoint {
-			remote-endpoint = <&panel_in>;
-		};
-	};
-};
-
 &pwm1 {
 	status = "okay";
 };
@@ -183,12 +150,3 @@ &usdhc1 {
 	vmmc-supply = <&reg_3v3>;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_gpiotouch: touchgpios {
-		fsl,pins = <
-			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74
-			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index f1c60b0cb143..e20b0977f38f 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -3,13 +3,32 @@
  * Copyright 2016-2020 Toradex
  */
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
-	bl: backlight {
+	backlight: backlight {
+		brightness-levels = <0 45 63 88 119 158 203 255>;
 		compatible = "pwm-backlight";
+		default-brightness-level = <4>;
+		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm1 0 5000000 0>;
-		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_module_3v3>;
+		pwms = <&pwm1 0 6666667 PWM_POLARITY_INVERTED>;
+		status = "disabled";
+	};
+
+	panel_dpi: panel-dpi {
+		backlight = <&backlight>;
+		compatible = "edt,et057090dhu";
+		power-supply = <&reg_3v3>;
+		status = "disabled";
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
 	};
 
 	reg_module_3v3: regulator-module-3v3 {
@@ -301,18 +320,19 @@ codec: sgtl5000@a {
 		VDDD-supply = <&reg_DCDC3>;
 	};
 
-	ad7879@2c {
+	ad7879_ts: touchscreen@2c {
+		adi,acquisition-time = /bits/ 8 <1>;
+		adi,averaging = /bits/ 8 <1>;
+		adi,conversion-interval = /bits/ 8 <255>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,resistance-plate-x = <120>;
 		compatible = "adi,ad7879-1";
-		reg = <0x2c>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		reg = <0x2c>;
 		touchscreen-max-pressure = <4096>;
-		adi,resistance-plate-x = <120>;
-		adi,first-conversion-delay = /bits/ 8 <3>;
-		adi,acquisition-time = /bits/ 8 <1>;
-		adi,median-filter-size = /bits/ 8 <2>;
-		adi,averaging = /bits/ 8 <1>;
-		adi,conversion-interval = /bits/ 8 <255>;
+		status = "disabled";
 	};
 
 	pmic@33 {
@@ -392,12 +412,32 @@ &i2c4 {
 	pinctrl-1 = <&pinctrl_i2c4_recovery>;
 	scl-gpios = <&gpio7 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio7 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "disabled";
+
+	/* Atmel maxtouch controller */
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		interrupt-parent = <&gpio2>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;        /* SODIMM 107 / INT */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_atmel_connector>;
+		reg = <0x4a>;
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;      /* SODIMM 106 / RST */
+		status = "disabled";
+	};
 };
 
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
+	status = "disabled";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&lcd_panel_in>;
+		};
+	};
 };
 
 &pwm1 {
@@ -486,7 +526,27 @@ &usdhc3 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
-		     &pinctrl_gpio7 &pinctrl_usbc_det>;
+		     &pinctrl_usbc_det>;
+
+	/*
+	 * Atmel MXT touchsceen + Capacitive Touch Adapter
+	 * NOTE: This pin group conflicts with pin groups pinctrl_pwm2/pinctrl_pwm3.
+	 * Don't use them simultaneously.
+	 */
+	pinctrl_atmel_adapter: atmelconnectorgrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74 /* SODIMM 28 / INT */
+			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14 /* SODIMM 30 / RST */
+		>;
+	};
+
+	/* Atmel MXT touchsceen + boards with built-in Capacitive Touch Connector */
+	pinctrl_atmel_connector: atmeladaptergrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x14 /* SODIMM 106 / RST */
+			MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 / INT */
+		>;
+	};
 
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins = <
@@ -494,8 +554,6 @@ MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x14 /* SODIMM 77 */
 			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
 			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x74 /* SODIMM 91 */
 			MX7D_PAD_LCD_RESET__GPIO3_IO4		0x14 /* SODIMM 93 */
-			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14 /* SODIMM 95 */
-			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11	0x14 /* SODIMM 99 */
 			MX7D_PAD_EPDC_DATA10__GPIO2_IO10	0x74 /* SODIMM 105 */
 			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
 			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14 /* SODIMM 113 */
@@ -729,6 +787,15 @@ MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
 		>;
 	};
 
+	pinctrl_lvds_transceiver: lvdstx {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2     0x14 /* SODIMM 63 */
+			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3     0x74 /* SODIMM 55 */
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11    0x14 /* SODIMM 99 */
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13        0x14 /* SODIMM 95 */
+		>;
+	};
+
 	pinctrl_pwm1: pwm1-grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
index f3f0537d5a37..ce0e6bb7db37 100644
--- a/arch/arm/boot/dts/imx7d-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -14,6 +14,26 @@ / {
 		     "fsl,imx7d";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
 &usbotg2 {
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index 87b132bcd272..c610c50c003a 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -13,6 +13,38 @@ / {
 		     "fsl,imx7d";
 };
 
+&ad7879_ts {
+	status = "okay";
+};
+
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	status = "disabled";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
 &usbotg2 {
 	vbus-supply = <&reg_usbh_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx7s-colibri-aster.dts b/arch/arm/boot/dts/imx7s-colibri-aster.dts
index fca4e0a95c1b..87f9e0e079a8 100644
--- a/arch/arm/boot/dts/imx7s-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-aster.dts
@@ -13,3 +13,23 @@ / {
 	compatible = "toradex,colibri-imx7s-aster", "toradex,colibri-imx7s",
 		     "fsl,imx7s";
 };
+
+&ad7879_ts {
+	status = "okay";
+};
+
+&atmel_mxt_ts {
+	status = "okay";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
index aa70d3f2e2e2..81956c16b95b 100644
--- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -12,3 +12,35 @@ / {
 	compatible = "toradex,colibri-imx7s-eval-v3", "toradex,colibri-imx7s",
 		     "fsl,imx7s";
 };
+
+&ad7879_ts {
+	status = "okay";
+};
+
+/*
+ * The Atmel maxtouch controller uses SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm2, pwm3.
+ * So if you enable following capacitive touch controller, disable pwm2/pwm3 first.
+ */
+&atmel_mxt_ts {
+	status = "disabled";
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&panel_dpi {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
-- 
2.35.1

