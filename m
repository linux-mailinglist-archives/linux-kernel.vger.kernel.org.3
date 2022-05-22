Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA1530650
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbiEVVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbiEVVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:44:43 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61B237BF4;
        Sun, 22 May 2022 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z+IZlfxm6Z4pKRYtUkljgvsWeSYZmMMarZhzlPp+u5A=; b=edFqmEz3FMxJheY8YJIz6FZggd
        54haiIbuNjcSXVrCmg88O5TTWa8SGlfvTSJ6f5HN99ca/my6AlqXc1dK4FxudkvCDKuWgWbb2PFrZ
        x1rINSDqzv6O2432WW6IEPIRMv1ycvyM6gUsPfhb/yMqwxbJK4RkyifEH4knWmyFq6P0=;
Received: from p200300ccff4f2e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff4f:2e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nstNB-0007GH-8p; Sun, 22 May 2022 23:44:25 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nstNA-0014LB-MZ; Sun, 22 May 2022 23:44:24 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, andreas@kemnade.info,
        matthias.schiffer@ew.tq-group.com, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolecrivain@gmail.com
Subject: [PATCH 2/2] ARM: dts: imx: Add devicetree for Kobo Aura 2
Date:   Sun, 22 May 2022 23:44:15 +0200
Message-Id: <20220522214415.254959-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522214415.254959-1-andreas@kemnade.info>
References: <20220522214415.254959-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a devicetree for the Kobo Aura 2 Ebook reader. It is based
on boards marked with "37NB-E60QL0+4B1". It is equipped with an i.MX6SL
SoC.

Expected to work:
  - Buttons
  - Wifi (with external module)
  - LED
  - uSD
  - USB
  - RTC
  - Fuel Gauge
  - Backlight (if the required regulator is probed before the backlight,
    specifying a supply is not supported by backlightdriver)

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx6sl-kobo-aura2.dts | 595 ++++++++++++++++++++++++
 2 files changed, 596 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-kobo-aura2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..549a457bb0de 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -661,6 +661,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6s-dhcom-drc02.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
+	imx6sl-kobo-aura2.dtb \
 	imx6sl-tolino-shine2hd.dtb \
 	imx6sl-tolino-shine3.dtb \
 	imx6sl-tolino-vision5.dtb \
diff --git a/arch/arm/boot/dts/imx6sl-kobo-aura2.dts b/arch/arm/boot/dts/imx6sl-kobo-aura2.dts
new file mode 100644
index 000000000000..3dc794c04abe
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-kobo-aura2.dts
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device tree for the Kobo Aura 2 ebook reader
+ *
+ * Name on mainboard is: 37NB-E60QL0+4B1
+ * Serials start with: E60QL2
+ *
+ * Copyright 2022 Andreas Kemnade
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6sl.dtsi"
+
+/ {
+	model = "Kobo Aura 2";
+	compatible = "kobo,aura2", "fsl,imx6sl";
+
+	aliases {
+		mmc0 = &usdhc2;
+		mmc1 = &usdhc3;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		cover {
+			label = "Cover";
+			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+
+		power {
+			label = "Power";
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		on {
+			label = "koboaura2:white:on";
+			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	reg_wifi: regulator-wifi {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_power>;
+		regulator-name = "SD3_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_reset>;
+		post-power-on-delay-ms = <20>;
+		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_sleep>;
+	status = "okay";
+
+	lm3630a: backlight@36 {
+		compatible = "ti,lm3630a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
+		reg = <0x36>;
+		enable-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0>;
+			label = "backlight";
+			default-brightness = <0>;
+			max-brightness = <255>;
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_sleep>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	/* eKTF2232 at 0x15 */
+	/* FP9928 at 0x48 */
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	ricoh619: pmic@32 {
+		compatible = "ricoh,rc5t619";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ricoh_gpio>;
+		reg = <0x32>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		system-power-controller;
+
+		regulators {
+			dcdc1_reg: DCDC1 {
+				regulator-name = "DCDC1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <900000>;
+					regulator-suspend-min-microvolt = <900000>;
+				};
+			};
+
+			/* Core3_3V3 */
+			dcdc2_reg: DCDC2 {
+				regulator-name = "DCDC2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3100000>;
+					regulator-suspend-min-microvolt = <3100000>;
+				};
+			};
+
+			dcdc3_reg: DCDC3 {
+				regulator-name = "DCDC3";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V2 */
+			dcdc4_reg: DCDC4 {
+				regulator-name = "DCDC4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V8 */
+			dcdc5_reg: DCDC5 {
+				regulator-name = "DCDC5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1700000>;
+					regulator-suspend-min-microvolt = <1700000>;
+				};
+			};
+
+			/* IR_3V3 */
+			ldo1_reg: LDO1  {
+				regulator-name = "LDO1";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* Core1_3V3 */
+			ldo2_reg: LDO2  {
+				regulator-name = "LDO2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3000000>;
+					regulator-suspend-min-microvolt = <3000000>;
+				};
+			};
+
+			/* Core5_1V2 */
+			ldo3_reg: LDO3  {
+				regulator-name = "LDO3";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "LDO4";
+				regulator-boot-on;
+			};
+
+			/* SPD_3V3 */
+			ldo5_reg: LDO5 {
+				regulator-name = "LDO5";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* DDR_0V6 */
+			ldo6_reg: LDO6 {
+				regulator-name = "LDO6";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* VDD_PWM */
+			ldo7_reg: LDO7 {
+				regulator-name = "LDO7";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* ldo_1v8 */
+			ldo8_reg: LDO8 {
+				regulator-name = "LDO8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "LDO9";
+				regulator-boot-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "LDO10";
+				regulator-boot-on;
+			};
+
+			ldortc1_reg: LDORTC1  {
+				regulator-name = "LDORTC1";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_gpio_keys: gpio-keysgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT1__GPIO5_IO08  0x17059
+			MX6SL_PAD_SD1_DAT4__GPIO5_IO12  0x17059
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
+			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
+			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
+			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
+			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
+			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
+			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
+			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
+			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
+			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
+			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
+			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
+			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
+			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
+			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
+			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
+			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
+			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
+			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
+			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
+			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
+			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
+			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
+			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
+			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
+			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
+			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
+			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
+			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
+			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
+			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
+			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
+			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c1_sleep: i2c1grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c2_sleep: i2c2grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
+			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT6__GPIO5_IO07 0x17059
+		>;
+	};
+
+	pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10 0x10059 /* HWEN */
+		>;
+	};
+
+	pinctrl_ricoh_gpio: ricoh_gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CLK__GPIO5_IO15	0x1b8b1 /* ricoh619 chg */
+			MX6SL_PAD_SD1_DAT0__GPIO5_IO11	0x1b8b1 /* ricoh619 irq */
+			MX6SL_PAD_KEY_COL2__GPIO3_IO28	0x1b8b1 /* ricoh619 bat_low_int */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6SL_PAD_KEY_ROW6__UART4_TX_DATA 0x1b0b1
+			MX6SL_PAD_KEY_COL6__UART4_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp-200mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
+			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
+			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
+			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
+			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
+			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
+			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
+			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
+			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
+			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
+			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
+		>;
+	};
+
+	pinctrl_wifi_power: wifi-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* WIFI_3V3_ON */
+		>;
+	};
+
+	pinctrl_wifi_reset: wifi-resetgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
+		>;
+	};
+};
+
+&reg_vdd1p1 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_arm {
+	vin-supply = <&dcdc3_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&dcdc1_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&dcdc1_reg>;
+};
+
+&snvs_rtc {
+	/*
+	 * We are using the RTC in the PMIC, but this one is not disabled
+	 * in imx6sl.dtsi.
+	 */
+	status = "disabled";
+};
+
+&uart1 {
+	/* J4, through-holes */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart4 {
+	/* TP198, next to J4, SMD pads */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
+	non-removable;
+	status = "okay";
+
+	/* internal uSD card */
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
+	vmmc-supply = <&reg_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	cap-power-off-card;
+	non-removable;
+	status = "okay";
+
+	/*
+	 * RTL8189F SDIO WiFi
+	 */
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
-- 
2.30.2

