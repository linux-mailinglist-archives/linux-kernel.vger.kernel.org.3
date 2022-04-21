Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04D509F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384458AbiDUMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384650AbiDUMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:30:01 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F6931538;
        Thu, 21 Apr 2022 05:27:06 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1B70483E76;
        Thu, 21 Apr 2022 14:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650544024;
        bh=589PV1+C6Yh8f7aL5yto1oHOerd79i7wZvqV7zk0llk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pa7PiLlOJqPu4itHyDFc8IorKm1FpISERkSYiLav3BaoKIZ7JuWBVc2gcA9MqRyfj
         1101Oqv0PyQ2men+AmzXqfAThEYCgFJ5AUcOI+WDp/vfUMiD91NRReSVANEc7Y3m31
         OcSS7qwO98DCmESQ2r0U3iWvgA6B2FNd90EVTzA2GPPPvmCSeZGiCHIhSh66BagTbk
         Dqv19LjbFM1yj6/BFJwAnGaj1PV0+nAthKKdtzHTEycgZVFuYKLfJwjQCBfhkAEkvR
         4oDRDIT74loUQvihpd5HAPuOtOd+0SK+7yfOnxVk0ci9bIo7iv/l6iW4w0PLaPFHTb
         fy+Esk7hWJVnA==
Received: by janitor.denx.de (Postfix, from userid 108)
        id A8920A020E; Thu, 21 Apr 2022 14:27:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id EFD31A01C7;
        Thu, 21 Apr 2022 14:26:48 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id DC1333E098D; Thu, 21 Apr 2022 14:26:48 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>,
        Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v2 2/2] ARM: dts: Add bosch acc board
Date:   Thu, 21 Apr 2022 14:26:19 +0200
Message-Id: <20220421122619.1913496-2-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421122619.1913496-1-pro@denx.de>
References: <20220421122619.1913496-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>

---

Changes in v2:
- fix style errors in node naming
- place regulators under root node
- remove superfluous status properties
- remove undocumented nodes and properties
- use color instead of label for leds
- fix other minor style issues
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/imx6q-bosch-acc.dts | 978 ++++++++++++++++++++++++++
 2 files changed, 979 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-bosch-acc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..a6eff45bfee3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -547,6 +547,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-b450v3.dtb \
 	imx6q-b650v3.dtb \
 	imx6q-b850v3.dtb \
+	imx6q-bosch-acc.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
 	imx6q-cubox-i-emmc-som-v15.dtb \
diff --git a/arch/arm/boot/dts/imx6q-bosch-acc.dts b/arch/arm/boot/dts/imx6q-bosch-acc.dts
new file mode 100644
index 000000000000..cce615fff653
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-bosch-acc.dts
@@ -0,0 +1,978 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for the i.MX6-based Bosch ACC board.
+ *
+ * Copyright (C) 2016 Garz & Fricke GmbH
+ * Copyright (C) 2018 DENX Software Engineering GmbH, Heiko Schocher <hs@denx.de>
+ * Copyright (C) 2018 DENX Software Engineering GmbH, Niel Fourie <lusus@denx.de>
+ * Copyright (C) 2019-2021 Bosch Thermotechnik GmbH, Matthias Winker <matthias.winker@bosch.com>
+ * Copyright (C) 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "imx6q.dtsi"
+
+/ {
+	model = "Bosch ACC";
+	compatible = "bosch,imx6q-acc", "fsl,imx6q";
+
+	aliases {
+		serial0 = &uart2;
+		serial1 = &uart1;
+
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		i2c2 = &i2c3;
+		/* eMMC is connected to USDHC interface 4, but shall get the name 0 */
+		mmc0 = &usdhc4;
+		/* SC-Cards is connected to USDHC interface 2, but shall get the name 1 */
+		mmc1 = &usdhc2;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		/* The last value is the PWM period in nano-seconds!
+		 * -> 5 kHz = 200 µS = 200.000 ns
+		 */
+		pwms = <&pwm1 0 200000>;
+		brightness-levels = <0 61 499 1706 4079 8022 13938 22237 33328 47623 65535>;
+		num-interpolated-steps = <10>;
+		default-brightness-level = <60>;
+		power-supply = <&reg_lcd0_pwr>;
+	};
+
+	refclk: refclk {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "12mhz_refclk";
+
+		assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
+				  <&clks IMX6QDL_CLK_CKO2>,
+				  <&clks IMX6QDL_CLK_CKO2_SEL>;
+		assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
+					 <&clks IMX6QDL_CLK_CKO2_PODF>,
+					 <&clks IMX6QDL_CLK_OSC>;
+		assigned-clock-rates = <0>, <12000000>, <0>;
+	};
+
+	cpus {
+		/* Override operating points with board-specific values */
+		cpu0: cpu@0 {
+			operating-points = <
+				/* kHz    uV */
+				1200000 1275000
+				996000  1225000
+				852000  1225000
+				792000  1150000
+				396000  950000
+			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				1200000 1225000
+				996000	1175000
+				852000	1175000
+				792000	1150000
+				396000	1150000
+			>;
+		};
+
+		cpu1: cpu@1 {
+			operating-points = <
+				/* kHz    uV */
+				1200000 1275000
+				996000  1225000
+				852000  1225000
+				792000  1150000
+				396000  950000
+			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				1200000 1225000
+				996000	1175000
+				852000	1175000
+				792000	1150000
+				396000	1150000
+			>;
+		};
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led_red: led-0 {
+			color = <LED_COLOR_ID_RED>;
+			max-brightness = <248>;
+			default-state = "off";
+			pwms = <&pwm2 0 500000>;
+		};
+
+		led_white: led-1 {
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <248>;
+			default-state = "off";
+			pwms = <&pwm3 0 500000>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reset_gpio_led>;
+
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 18 0>;
+			default-state = "off";
+		};
+	};
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x40000000>;
+	};
+
+	supply_5P0: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0";
+	};
+
+	supply_VIN: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VIN";
+		regulator-min-microvolt = <4500000>;
+		regulator-max-microvolt = <4500000>;
+		regulator-always-on;
+		vin-supply = <&supply_5P0>;
+	};
+
+	reg_usb_otg_vbus: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb_h1_vbus: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&supply_5P0>;
+	};
+
+	supply_VSNVS_3V0: regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSNVS_3V0";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-always-on;
+		vin-supply = <&supply_5P0>;
+	};
+
+	reg_lcd0_pwr: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD0 POWER";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd_enable>;
+		gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	reg_usb_h2_vbus: regulator-6 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&supply_5P0> ;
+		regulator-always-on;
+	};
+
+	supply_vref_dac: regulator-7 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_dac";
+		regulator-min-microvolt = <20000>;
+		regulator-max-microvolt = <20000>;
+		vin-supply = <&supply_5P0> ;
+		regulator-boot-on;
+	};
+
+	supply_sw4_3V3: regulator-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "SW4_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&supply_5P0>;
+	};
+
+	supply_SYS_4V2: regulator-9 {
+		compatible = "regulator-fixed";
+		regulator-name = "SYS_4V2";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+		vin-supply = <&supply_5P0>;
+	};
+
+	soc {
+		aips1: bus@2000000 {};
+	};
+};
+
+&reg_arm {
+	vin-supply = <&pmic_sw2>;
+};
+
+&reg_soc {
+	vin-supply = <&pmic_sw1abc>;
+};
+
+&reg_vdd1p1 {
+	vin-supply = <&supply_VSNVS_3V0>;
+};
+
+&reg_vdd2p5 {
+	vin-supply = <&supply_VSNVS_3V0>;
+};
+
+&reg_vdd3p0 {
+	vin-supply = <&supply_VSNVS_3V0>;
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	status = "okay";
+
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		<&clks IMX6QDL_CLK_ENET>,
+		<&clks IMX6QDL_CLK_ENET>,
+		<&clks IMX6QDL_CLK_ENET_REF>;
+	clock-names = "ipg", "ahb", "ptp", "enet_out";
+	phy-mode = "rmii";
+	phy-supply = <&supply_sw4_3V3>;
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&gpu_vg {
+	status = "disabled";
+};
+
+&gpu_2d {
+	status = "disabled";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+
+	lm75: sensor@49 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lm75>;
+
+		compatible = "national,lm75b";
+		reg = <0x49>;
+	};
+
+	pmic: pmic@8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			/*
+			 * VDD_CORE is connected to SW1 ABC
+			 * We need to define sw1ab and sw1c, but later it is controlled solely with
+			 * sw1c and therefore only this is named "VDD_SOC".
+			 * See PMIC datasheet Rev. 18, chapter 6.4.4.3.1: "The feedback and all
+			 * other controls are accomplished by use of pin SW1CFB and SW1C control
+			 * registers, respectively."
+			 * Setting min and max according to SOC datasheet
+			 */
+			pmic_sw1abc: sw1c {
+				regulator-name = "VDD_SOC (sw1abc)";
+				regulator-min-microvolt = <1275000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+
+				default-voltage = <1300000>;
+			};
+
+			pmic_sw2: sw2 {
+				regulator-name = "VDD_ARM (sw2)";
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+
+				default-voltage = <1300000>;
+			};
+
+			pmic_sw3a: sw3a {
+				/* U-Boot sets correct voltage, shall not be touched by the OS */
+				compatible = "regulator-fixed";
+				regulator-name = "DDR_1V5a";
+				regulator-boot-on;
+				regulator-always-on;
+
+			};
+
+			supply_DDR_1V5: sw3b {
+				/* U-Boot sets correct voltage, shall not be touched by the OS */
+				compatible = "regulator-fixed";
+				regulator-name = "DDR_1V5b";
+				regulator-boot-on;
+				regulator-always-on;
+
+			};
+
+			supply_AUX_3V15: sw4 {
+				regulator-name = "AUX 3V15 (sw4)";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+
+				default-voltage = <3150000>;
+
+			};
+
+			swbst_reg: swbst {
+				status = "disabled";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+				regulator-boot-on;
+				regulator-always-on;
+
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+
+				default-voltage = <3000000>;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+
+				default-voltage = <675000>;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+
+				default-voltage = <1500000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+
+				default-voltage = <1200000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+
+				default-voltage = <2500000>;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				default-voltage = <1800000>;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				default-voltage = <2800000>;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+
+				default-voltage = <2800000>;
+			};
+
+		};
+	};
+
+	rtc: rtc@51 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	eeprom_ext: eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exc3000: touchscreen@2a {
+		compatible = "eeti,exc3000";
+		reg = <0x2a>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctouch>;
+
+		interrupt-parent = <&gpio4>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
+	};
+
+	usb3503: usb@8 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb3503>;
+
+		compatible = "smsc,usb3503";
+		reg = <0x08>;
+		connect-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>; /* Old: 0, SS: HIGH */
+		intn-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>; /* Old: 1, SS: HIGH */
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>; /* Old: 0, SS: HIGH */
+		initial-mode = <1>;
+
+		clocks = <&refclk>;
+		clock-names = "refclk";
+		refclk-frequency = <12000000>;
+	};
+
+	vcnl4035: light-sensor@60 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_proximity>;
+		compatible = "vishay,vcnl4035";
+		reg = <0x60>;
+	};
+};
+
+&iomuxc {
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC    0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD    0x130b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS   0x110b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD    0x130b0
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23	0x1b0b0	/* FEC INT */
+			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x0001B098
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x0001B098
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x0001B098
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+		>;
+	};
+
+	pinctrl_gpio_export_gpio_fixed_in: pinctrl-gpio-export-gpio-fixed-in-grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x80000000	/* CLEAR ALL */
+			MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22	0x80000000	/* DIG_IN_1 */
+			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23	0x80000000	/* DIG_IN_2 */
+			MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x80000000	/* PoE */
+			MX6QDL_PAD_SD3_CLK__GPIO7_IO03		0x80000000	/* PoE T2P */
+		>;
+	};
+
+	pinctrl_reset_gpio_led: pinctrl-reset-gpio-led-pin {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18		0x80000000
+		>;
+	};
+
+	pinctrl_gpio_export_gpio_fixed_out: pinctrl-gpio-export-gpio-fixed-out-grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT6__GPIO5_IO24	0x0001B0B0	/*  DIG_OUT_1 */
+			MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25	0x0001B0B0	/*  DIG_OUT_2 */
+			MX6QDL_PAD_DI0_DISP_CLK__GPIO4_IO16	0x0001B0B0	/*  nUART_RESET */
+			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x0001B0B0	/*  nETH1_RESET */
+			MX6QDL_PAD_DI0_PIN3__GPIO4_IO19		0x0001B0B0	/*  nETH2_RESET */
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x0001B0B0	/*  RS485#1_PWR */
+			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x0001B0B0	/*  RS485#2_PWR */
+			MX6QDL_PAD_DISP0_DAT0__GPIO4_IO21	0x0001B0B0	/*  RS485#3_PWR */
+			MX6QDL_PAD_DISP0_DAT1__GPIO4_IO22	0x0001B0B0	/*  RS485#4_PWR */
+			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27	0x0001B0B0	/*  FEC_RESET_B */
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x0001B0B0	/*  AN_IN_PWR */
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001B0B0	/*  AN_OUT_PWR */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x0001B0B0	/*  nUSBH1_PWR */
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			/* not used SD2 and SD3 pins */
+			/* [HYS 1] [100K PU] [PU] [PU EN] [CMOS] [Med. Speed] [40R] [Slow SR] */
+			MX6QDL_PAD_SD3_CLK__GPIO7_IO03   0x0001B0B0
+			MX6QDL_PAD_SD3_CMD__GPIO7_IO02   0x0001B0B0
+			MX6QDL_PAD_EIM_CS0__GPIO2_IO23   0x0000B0B1
+			MX6QDL_PAD_EIM_D17__GPIO3_IO17   0x0001B0B0
+			MX6QDL_PAD_EIM_D18__GPIO3_IO18   0x0001B0B0
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20   0x0001B0B0
+			MX6QDL_PAD_EIM_OE__GPIO2_IO25    0x0000B0B1
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x0001B0B0
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00  0x0001B8B1
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01  0x0001B8B1
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02  0x000138B1
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26 0x80000000
+			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27 0x80000000
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b810
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b810
+			/* NO SRE | 130 Ohm | SPEED LOW | Open Drain | PKE | PUE | 100k PU | HYS  */
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x80000000
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x80000000
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
+		>;
+	};
+	pinctrl_i2c3_gpio: i2c3-gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05 0x80000000
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x80000000
+		>;
+	};
+
+	pinctrl_lcd_enable: lcdenablerp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23  0x80000000 /* lcd enable */
+			MX6QDL_PAD_EIM_D16__GPIO3_IO16  0x80000000 /* sel6_8 */
+		>;
+	};
+
+	pinctrl_lm75: lm75grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x80000000
+		>;
+	};
+
+	pinctrl_pfid_0_2: pfid-0-2-grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00  0x0001B0B0
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01  0x0001B0B0
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02  0x0001B0B0
+		>;
+	};
+
+	pinctrl_pfid_3_4: pfid-3-4-grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03  0x0001B0B0
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04  0x0001B0B0
+		>;
+	};
+
+	pinctrl_pfid_5_7: pfid-5-7-grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05  0x0001B0B0
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06  0x0001B0B0
+			MX6QDL_PAD_NANDF_D7__GPIO2_IO07  0x0001B0B0
+		>;
+	};
+
+	pinctrl_pfid_8_9: pfid-8-9-grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16  0x0001B0B0
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14  0x0001B0B0
+		>;
+	};
+
+	pinctrl_proximity: proximitygrp {
+		fsl,pins = <
+			/* PROXIMITY_INT */
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11         0x80000000
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT3__PWM1_OUT 0x0001B0B0
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT 0x0001B0B0
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_DAT1__PWM3_OUT 0x0001B0B0
+		>;
+	};
+
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__PWM4_OUT 0x0001B0B0
+		>;
+	};
+
+	pinctrl_rtc: rtc-grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x80000000 /* RTC INT */
+		>;
+	};
+
+	pinctrl_ctouch: ctouch-grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06 0x80000000 /* CTOUCH_INT */
+			MX6QDL_PAD_SD1_CLK__GPIO1_IO20 0x0001B0B0 /* CTOUCH_RESET */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA 0x1b0b1
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA 0x1b0b1
+			MX6QDL_PAD_SD3_RST__GPIO7_IO08 0x0001B0B0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_DAT4__UART2_RX_DATA 0x1b0b1
+			MX6QDL_PAD_SD3_DAT5__UART2_TX_DATA 0x1b0b1
+			MX6QDL_PAD_EIM_D28__UART2_CTS_B 0x1b0b1
+			MX6QDL_PAD_EIM_D29__UART2_RTS_B 0x1b0b1
+		>;
+	};
+
+	pinctrl_usbh2_idle: usbh2-idle-grp {
+		fsl,pins = <
+			/* 100K Pull-Down, 76_OHM drive strength */
+			MX6QDL_PAD_RGMII_TXC__USB_H2_DATA      0x00013018
+			/* 100K Pull-Down, 76_OHM drive strength */
+			MX6QDL_PAD_RGMII_TX_CTL__USB_H2_STROBE 0x00013018
+		>;
+	};
+
+	pinctrl_usbh2_active: usbh2-active-grp {
+		fsl,pins = <
+			/* 100K Pull-Down, 76_OHM drive strength */
+			MX6QDL_PAD_RGMII_TXC__USB_H2_DATA      0x00013018
+			/* 47K Pull-Up, 76_OHM drive strength */
+			MX6QDL_PAD_RGMII_TX_CTL__USB_H2_STROBE 0x00017018
+		>;
+	};
+
+	pinctrl_usb3503: pinctrl_usb3503-grp {
+		fsl,pins = <
+			/* USB Hub REFCLK - No pull-up/pull-down, CMOS output, low speed, 90 Ohm */
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1    0x00000018
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12     0x80000000 /* USB INT */
+			MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05 0x0001B0B0 /* USB Reset */
+			MX6QDL_PAD_SD1_DAT0__GPIO1_IO16    0x80000000 /* USB Connect */
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		/* CMD and DATA0..3 have external pull-up, CLK does not need a pull-up.
+		 * CLK signal is half the speed than the others (52 MHz compared to 104 MHz)
+		 */
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x00017069
+			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x00010038
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x00017069
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x00017069
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x00017069
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x00017069
+			MX6QDL_PAD_GPIO_4__SD2_CD_B    0x0001B0B0
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		/* CMD has external pull-up, DATA0..7 within eMMC, CLK does not need a pull-up.
+		 * CLK signal is half the speed than the others (52 MHz compared to 104 MHz)
+		 */
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x00017059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x00010059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x00017059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x00017059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x00017059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x00017059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x00017059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x00017059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x00017059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x00017059
+		>;
+	};
+
+	pinctrl_wdog1: wdoggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__WDOG1_B 0x1b0b0
+		>;
+	};
+};
+
+&ldb {
+	status = "okay";
+
+	lvds0: lvds-channel@0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+
+		display-timings {
+			native-mode = <&lvds0_timing0>;
+			lvds0_timing0: timing0 {
+				clock-frequency = <79479000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <100>;
+				hfront-porch = <100>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <24>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>,
+			     <&{/cpus/cpu@1}>;
+};
+
+&pwm1 {
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm3 {
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	#pwm-cells = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&sdma {
+	fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
+	iram = <&ocram>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+
+	rts-gpios = <&gpio7 8 0>;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rx-during-tx;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usbh2 {
+	pinctrl-names = "idle", "active";
+	pinctrl-0 = <&pinctrl_usbh2_idle>;
+	pinctrl-1 = <&pinctrl_usbh2_active>;
+	status = "okay";
+
+	vbus-supply = <&reg_usb_h2_vbus>;
+	osc-clkgate-delay = <0x3>;
+	pad-supply = <&vgen2_reg>;
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	status = "okay";
+
+	vbus-supply = <&reg_usb_otg_vbus>;
+	disable-over-current;
+	dr_mode = "otg";
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+};
+
+&usbphynop1 {
+	clocks = <&clks IMX6QDL_CLK_USBPHY1>;
+	clock-names = "main_clk";
+	vcc-supply = <&reg_usb_h1_vbus>;
+};
+
+&usbphynop2 {
+	vcc-supply = <&reg_usb_h2_vbus>;
+};
+
+/* sdcard */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	status = "okay";
+
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	voltage-ranges = <3300 3300>;
+	vmmc-supply = <&supply_sw4_3V3>;
+	fsl,wp-controller;
+};
+
+/* emmc */
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	status = "okay";
+
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	voltage-ranges = <3300 3300>;
+	vmmc-supply = <&supply_sw4_3V3>;
+	fsl,wp-controller;
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
+	status = "okay";
+	timeout-sec=<10>;
+};
-- 
2.34.1

