Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D4573F75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiGMWNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:13:12 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A212A1FCF0;
        Wed, 13 Jul 2022 15:13:09 -0700 (PDT)
Received: from 1oBkbP-0004pP-U1 by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oBkbS-0004tC-TY; Wed, 13 Jul 2022 15:13:06 -0700
Received: by emcmailer; Wed, 13 Jul 2022 15:13:06 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oBkbP-0004pP-U1; Wed, 13 Jul 2022 15:13:03 -0700
Received: from tsdebian.ts-local.net (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 06AC4B08C;
        Wed, 13 Jul 2022 15:13:01 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
Date:   Wed, 13 Jul 2022 15:12:33 -0700
Message-Id: <20220713221233.8486-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=nmp1l7itmbX9ax0PXotnYysmdFDI9cM5LV1/CGzRVqA=;b=IQUWdPPXpaqvOSbEfUUKOvfM818gTb/N9dUeJnn43XlHj6KpJQLfElV22CSi3LHQbceemtUFxhDueKDreScbqitBzsG3Ol+6s6FGJVKZtA+G3GKR6X/MN2G8n1UaxPaPTzjvWLNRRDaBLpS0VRdirXJFxPRVg07SLF3QJhSqJfci1VhQ8CqwluejGTefz1CS0aq1niNoAP4g15BKpPW3gPuXxo5oBR3ON8EiqKFGS79N42LGkoQH82WVtoL2fDMEg4WJ1v1E+948k75GoFb1Xs3o1Mu9UNTV3Muv8HcPxgFNANZt4jA9K2cHqVjOJ0vYCLgUALWwSZNag+2M7jnJcw==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support of the i.MX6UL based TS-7553-V2 platform.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1->V2: Implement changes recommended by Rob Herring and dtbs_check

RFC only, not yet ready to merge, more testing needed and we're working on
SPI LCD support for this platform.

Specifically, I have a few questions on some paradigms and dtbs_check output:

imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ... \
'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], 'reg': [[12]]}}}} \
is not of type 'array'
  I'm not sure what this error is referring to as I've copied the example in
  invensense,mpu6050.yaml almost verbatim. Is this an issue with our patch
  or a false positive from dtbs_check?


imx6ul-ts7553v2.dtb: spi@2010000: spidev@1: 'compatible' is a required property
  Many of our devices have open-ended I2C and SPI ports that may or may not be
  used in customer applications. With "spidev" compatible string no longer
  supported, there is no easy way we know of to leave a placeholder or
  indication that the interface is present, usable, and either needs specific
  support enabled in kernel or userspace access via /dev/. We would love
  feedback on how to handle this situation when submitting platforms upstream.


imx6ul-ts7553v2.dtb: wifi@0: compatible:0: 'microchip,wilc1000' was expected
imx6ul-ts7553v2.dtb: wifi@0: compatible: ['microchip,wilc3000'...] is too long
imx6ul-ts7553v2.dtb: wifi@0: 'chip_en-gpios' does not match any of the \
regexes: pinctrl-[0-9]+'
  As noted in the comments in the dts, the WILC1000 in-kernel driver doesn't
  support the BLE features of the WILC3000. We maintain an external module
  tree that lets us build Microchip's official driver with WILC3000 support.
  Would the extraneous compatible string and property be accepted upstream
  in light of this?


 Documentation/devicetree/bindings/arm/fsl.yaml |    1 +
 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/imx6ul-ts7553v2.dts          |  693 ++++++++++
 arch/arm/configs/ts7970_defconfig              | 1627 ++++++++++++++++++++++++
 arch/arm/configs/tsimx6ul_defconfig            |  967 ++++++++++++++
 5 files changed, 3289 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ts7553v2.dts
 create mode 100644 arch/arm/configs/ts7970_defconfig
 create mode 100644 arch/arm/configs/tsimx6ul_defconfig

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..05a4e5b39835 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -559,6 +559,7 @@ properties:
               - technexion,imx6ul-pico-dwarf   # TechNexion i.MX6UL Pico-Dwarf
               - technexion,imx6ul-pico-hobbit  # TechNexion i.MX6UL Pico-Hobbit
               - technexion,imx6ul-pico-pi      # TechNexion i.MX6UL Pico-Pi
+              - technologic,ts7553v2      # embeddedTS TS-7553-V2
           - const: fsl,imx6ul
 
       - description: i.MX6UL Armadeus Systems OPOS6UL SoM Board
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5112f493f494..72a26abafaa9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -709,6 +709,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-phytec-segin-ff-rdk-emmc.dtb \
 	imx6ul-phytec-segin-ff-rdk-nand.dtb \
 	imx6ul-prti6g.dtb \
+	imx6ul-ts7553v2.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-ts7553v2.dts b/arch/arm/boot/dts/imx6ul-ts7553v2.dts
new file mode 100644
index 000000000000..8ed201f58137
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-ts7553v2.dts
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Technologic Systems, Inc. dba embeddedTS
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "imx6ul.dtsi"
+
+/ {
+	model = "embeddedTS i.MX6UL TS-7553-V2";
+	compatible = "technologic,ts7553v2", "fsl,imx6ul";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0>;
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+		compatible = "gpio-leds";
+
+		green-led {
+			label = "green-led";
+			gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		red-led {
+			label = "red-led";
+			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		left {
+			label = "Left";
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFT>;
+			debounce-interval = <20>;
+			gpio-key,wakeup;
+		};
+
+		up {
+			label = "Up";
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+			debounce-interval = <20>;
+			gpio-key,wakeup;
+		};
+		down {
+			label = "Down";
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+			debounce-interval = <20>;
+			gpio-key,wakeup;
+		};
+		right {
+			label = "Right";
+			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RIGHT>;
+			debounce-interval = <20>;
+			gpio-key,wakeup;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x4000000>;
+			linux,cma-default;
+		};
+	};
+
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1-3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_enet_phy_3v3: regulator-phy {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enet_3v3>;
+		regulator-name = "ENET-3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_flexcan_3v3: regulator-can-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_3v3>;
+		regulator-name = "CAN-EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	};
+
+	i2c_gpio: i2c-gpio {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2cgpio>;
+		sda-gpios = <&gpio5 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio5 4 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		mpu9250a: imu@68 {
+			compatible = "invensense,mpu9250";
+			reg = <0x68>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+			i2c-gate {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				magnetometer@c {
+					compatible = "asahi-kasei,ak8975";
+					reg = <0xc>;
+				};
+			};
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "", "USB-5V-EN", "", "", "", "", "", "",
+		"MODEM-5V-EN", "XBEE-3V3-EN", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "RS232-XCEIVER-EN";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"XBEE-PIN-9", "XBEE-PIN-16", "", "", "", "",
+		"XBEE-PIN-12";
+
+	/* XXX: Do more testing with with this. PFM mode normally enabled under
+	 * 700 mA which is well below what the 7553v2 runs at. in PFM mode lower
+	 * freq to minimize switching losses but less able to respond to fast
+	 * transients */
+	vreg-mode-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "VREG-MODE";
+	};
+};
+
+&gpio3 {
+	gpio-line-names = "USB-HUB-RESET#", "", "", "", "", "", "",
+		"USB-MUX-CPU-OTG", "", "", "", "NO-CHRG-JMP#", "", "", "", "",
+		"", "SD-BOOT-JMP#", "PUSH-SW#", "U-BOOT-JMP#", "XBEE-RESET#",
+		"", "", "RES-STRAP-0", "RES-STRAP-1", "", "",
+		"RES-STRAP-2", "RES-STRAP-3";
+};
+
+&gpio5 {
+	gpio-line-names = "POWER-FAIL#", "", "EMMC-PWR-EN", "", "", "", "",
+		"XBEE-USB-EN#", "RELAY-EN";
+
+	vdd-soc-in-v-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "VDD-SOC-IN-V";
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	m41t00s: rtc@68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
+};
+
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&ecspi3 {
+	num-cs = <3>;
+	cs-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>, <&gpio2 15 GPIO_ACTIVE_LOW>, <&gpio5 6 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	st7565p: lcd@0 {
+		/* TODO: Add driver support for Sitronix ST7565p */
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+	};
+
+	spidevdc: spidev@1 {
+		/*
+		 * Open interface on pin-header. Add appropriate "compatible"
+		 * and related properties here. The "reg" property should
+		 * remain as-is.
+		 */
+		reg = <1>;
+	};
+
+	fm25l16b: eeprom@2 {
+		compatible = "atmel,at25";
+		reg = <2>;
+		spi-max-frequency = <20000000>;
+		size = <0x800>;
+		address-width = <16>;
+		pagesize = <64>;
+	};
+};
+
+&ecspi4 {
+	num-cs = <1>;
+	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4>;
+	status = "okay";
+
+	/*
+	 * In testing, the in-kernel wilc1000 driver was non-functional on SPI.
+	 * However, it is possible to build the official Microchip driver
+	 * outside of their kernel tree as an external module and it works
+	 * just fine and allows for true WILC3000 compatibility with BLE support.
+	 * The below compatible string is structured to prefer the external
+	 * module and fallback to in-kernel if that ever becomes functional.
+	 * Additionally, using both chip_en and enable gpios are in order to
+	 * support both the external module and in-kernel driver.
+	 */
+	wilc: wifi@0 {
+		compatible = "microchip,wilc3000", "microchip,wilc1000";
+		reg = <0>;
+		spi-max-frequency = <48000000>;
+		reset-gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
+		chip_en-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	phy-supply = <&reg_enet_phy_3v3>;
+	status = "okay";
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <2>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_flexcan_3v3>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_flexcan_3v3>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	/*
+	 * Need to use GPIO for TXEN even though CTS is available on this port.
+	 * All instances of the UART2 RTS signal have other uses therefore leaving
+	 * the UART module RTS_B input unconnected which generates spurious IRQs.
+	 * If the imx.c driver is ever adjusted to allow configuration of RTSDEN
+	 * then it may be possible to use real CTS here if RTS IRQs are disabled.
+	 */
+	rts-gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	cts-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+	rts-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	status = "okay";
+};
+
+&uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "peripheral";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	keep-power-in-suspend;
+	disable-wp;
+	broken-cd;
+	bus-width = <4>;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	disable-wp;
+	broken-cd;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			/* Reserved signals */
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x1b020
+			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12	0x1a020
+			MX6UL_PAD_LCD_DATA03__GPIO3_IO08	0x1a020
+			MX6UL_PAD_LCD_DATA04__GPIO3_IO09	0x1a020
+			MX6UL_PAD_LCD_DATA05__GPIO3_IO10	0x1a020
+			MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x13020
+			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x1b020
+			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x1b020
+			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x1b020
+			MX6UL_PAD_JTAG_TMS__GPIO1_IO11		0x1b020
+			MX6UL_PAD_JTAG_TRST_B__GPIO1_IO15	0x1b020
+
+
+			/* Has hardware pull resistor */
+			MX6UL_PAD_LCD_DATA14__GPIO3_IO19	0x1a020 /* U_BOOT_JMP#_ */
+			MX6UL_PAD_LCD_DATA06__GPIO3_IO11	0x1a020 /* NO_CHRG_JMP# */
+			MX6UL_PAD_LCD_DATA12__GPIO3_IO17	0x1a020 /* SD_BOOT_JMP# */
+			MX6UL_PAD_LCD_DATA02__GPIO3_IO07	0x1a020 /* 6UL_TO_USB_DEV */
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x1a020 /* MODEM 5 v */
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09	0x1a020 /* XBee 3.3 v */
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1a020 /* eMMC En. */
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0a0
+
+			/* Needs internal pull resistor */
+			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x1b020 /* RES_STRAP_0 */
+			MX6UL_PAD_LCD_DATA19__GPIO3_IO24	0x1b020 /* RES_STRAP_1 */
+			MX6UL_PAD_LCD_DATA22__GPIO3_IO27	0x1b020 /* RES_STRAP_2 */
+			MX6UL_PAD_LCD_DATA23__GPIO3_IO28	0x1b020 /* RES_STRAP_3 */
+			MX6UL_PAD_LCD_DATA15__GPIO3_IO20	0x1b020 /* XBEE_RESET# */
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b020 /* XBEE_USB_EN# */
+			MX6UL_PAD_ENET2_TX_CLK__GPIO2_IO14	0x1b020 /* XBEE_DIO_8 */
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x1b020 /* XBEE_DIO_7 */
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x1b020 /* XBEE_DIO_6 */
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x1a020 /* RELAY_EN */
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x1b020 /* USB 5v EN */
+			MX6UL_PAD_LCD_CLK__GPIO3_IO00		0x1b020 /* USB_HUB_RESET# */
+			MX6UL_PAD_ENET2_TX_DATA0__REF_CLK_24M	0x1b020 /* USB hub */
+			MX6UL_PAD_LCD_DATA13__GPIO3_IO18	0x1a020 /* PUSH_SW_CPU# */
+			MX6UL_PAD_UART2_RTS_B__GPIO1_IO23	0x1b020 /* 232_TRANS_EN */
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b020 /* POWER_FAIL */
+		>;
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x1a020 /* Left */
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x1a020 /* Up */
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x1a020 /* Down */
+			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x1a020 /* Right */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b020 /* Red LED */
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b020 /* Grn LED */
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usbotg1idgrp {
+		/* Wired always high for device mode on TS-7553-V2 */
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x16059
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp{
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
+			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp{
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA10__FLEXCAN2_TX	0x1b020
+			MX6UL_PAD_LCD_DATA11__FLEXCAN2_RX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan_3v3: flexcan3v3grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x1b020 /* CAN En. */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__GPIO1_IO22	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__UART6_DCE_RX	0x1b0b1
+			MX6UL_PAD_CSI_MCLK__UART6_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x1b0b1
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA17__UART7_DCE_RX	0x1b0b1
+			MX6UL_PAD_LCD_DATA16__UART7_DCE_TX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA21__UART8_DCE_RX	0x1b0b1
+			MX6UL_PAD_LCD_DATA20__UART8_DCE_TX	0x1b0b1
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet_3v3: enet3v3grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__I2C1_SCL		0x4001a8b0
+			MX6UL_PAD_GPIO1_IO03__I2C1_SDA		0x4001a8b0
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA01__I2C3_SCL		0x4001a8b0
+			MX6UL_PAD_LCD_DATA00__I2C3_SDA		0x4001a8b0
+		>;
+	};
+
+	pinctrl_i2cgpio: i2cgrpgpio {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x4001a8b0
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x4001a8b0
+			MX6UL_PAD_LCD_ENABLE__GPIO3_IO01	0x13020 /* IMU IRQ */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			/* hysteresis, en 47k PU */
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10071
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_LCD_DATA07__GPIO3_IO12	0x17059 /* EN_SD_POWER */
+			MX6UL_PAD_GPIO1_IO05__USDHC1_VSELECT	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			// XXX: These are not defined with GPIO names
+			// See about porting LCD driver?
+			MX6UL_PAD_CSI_DATA04__GPIO4_IO25	0x1b020 /* LCD_BKLT */
+			MX6UL_PAD_NAND_WP_B__GPIO4_IO11		0x1b020 /* LCD_RESET# */
+			MX6UL_PAD_NAND_DQS__GPIO4_IO16		0x1b020 /* LCD_CMD# */
+			MX6UL_PAD_NAND_CE0_B__ECSPI3_SCLK	0x1b020 /* SPI_3_CLK */
+			MX6UL_PAD_NAND_CE1_B__ECSPI3_MOSI	0x1b020 /* SPI_3_MOSI */
+			MX6UL_PAD_NAND_CLE__ECSPI3_MISO		0x1b820 /* SPI_3_MISO */
+			MX6UL_PAD_NAND_READY_B__GPIO4_IO12	0x1b020 /* LCD CS0# */
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x1b020 /* HD1 CS1# */
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b020 /* FRAM CS2# */
+		>;
+	};
+
+	pinctrl_ecspi4: ecspi4grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_DATA04__ECSPI4_SCLK	0x1b020
+			MX6UL_PAD_NAND_DATA05__ECSPI4_MOSI	0x1b020
+			MX6UL_PAD_NAND_DATA06__ECSPI4_MISO	0x1b020
+			MX6UL_PAD_NAND_DATA07__GPIO4_IO09	0x1b020 /* WIFI CS# */
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b020 /* WIFI IRQ# */
+			MX6UL_PAD_NAND_ALE__GPIO4_IO10		0x1b020 /* WIFI RST# */
+			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x1b020 /* WIFI EN */
+		>;
+	};
+
+	pinctrl_wdog1: wdog1grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY	0xb8b0
+		>;
+	};
+};
diff --git a/arch/arm/configs/ts7970_defconfig b/arch/arm/configs/ts7970_defconfig
new file mode 100644
index 000000000000..a96831752449
--- /dev/null
+++ b/arch/arm/configs/ts7970_defconfig
@@ -0,0 +1,1627 @@
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_USELIB=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+# CONFIG_PROC_PID_CPUSET is not set
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_BPF=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMX6Q=y
+CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_IMX6SLL=y
+CONFIG_SOC_IMX6SX=y
+CONFIG_ARM_ERRATA_814220=y
+CONFIG_SMP=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_ARM_PSCI=y
+CONFIG_HZ_1000=y
+CONFIG_HIGHMEM=y
+CONFIG_FORCE_MAX_ZONEORDER=14
+CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_PSCI_CPUIDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_PM_DEBUG=y
+CONFIG_PM_TEST_SUSPEND=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLK_DEV_INTEGRITY=y
+CONFIG_BLK_CMDLINE_PARSER=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
+# CONFIG_COREDUMP is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=m
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=m
+CONFIG_XFRM_USER=m
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_NET_KEY=m
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_FIB_TRIE_STATS=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_NET_IPVTI=m
+CONFIG_NET_FOU_IP_TUNNELS=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_INET_UDP_DIAG=m
+CONFIG_INET_DIAG_DESTROY=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_HSTCP=m
+CONFIG_TCP_CONG_HYBLA=m
+CONFIG_TCP_CONG_NV=m
+CONFIG_TCP_CONG_SCALABLE=m
+CONFIG_TCP_CONG_LP=m
+CONFIG_TCP_CONG_VENO=m
+CONFIG_TCP_CONG_YEAH=m
+CONFIG_TCP_CONG_ILLINOIS=m
+CONFIG_TCP_CONG_DCTCP=m
+CONFIG_TCP_CONG_CDG=m
+CONFIG_TCP_CONG_BBR=m
+CONFIG_TCP_MD5SIG=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_IPV6_MIP6=m
+CONFIG_IPV6_ILA=m
+CONFIG_IPV6_VTI=m
+CONFIG_IPV6_SIT=m
+CONFIG_IPV6_SIT_6RD=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NETWORK_PHY_TIMESTAMPING=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_ZONES=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CONNTRACK_TIMEOUT=y
+CONFIG_NF_CONNTRACK_TIMESTAMP=y
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+CONFIG_NF_CONNTRACK_SNMP=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SANE=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_CT_NETLINK_TIMEOUT=m
+CONFIG_NETFILTER_NETLINK_GLUE_CT=y
+CONFIG_NF_TABLES=m
+CONFIG_NFT_NUMGEN=m
+CONFIG_NFT_CT=m
+CONFIG_NFT_COUNTER=m
+CONFIG_NFT_LOG=m
+CONFIG_NFT_LIMIT=m
+CONFIG_NFT_MASQ=m
+CONFIG_NFT_REDIR=m
+CONFIG_NFT_QUEUE=m
+CONFIG_NFT_QUOTA=m
+CONFIG_NFT_REJECT=m
+CONFIG_NFT_COMPAT=m
+CONFIG_NFT_HASH=m
+CONFIG_NETFILTER_XT_SET=m
+CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_DSCP=m
+CONFIG_NETFILTER_XT_TARGET_HMARK=m
+CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
+CONFIG_NETFILTER_XT_TARGET_LED=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
+CONFIG_NETFILTER_XT_TARGET_TEE=m
+CONFIG_NETFILTER_XT_TARGET_TPROXY=m
+CONFIG_NETFILTER_XT_TARGET_TRACE=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_BPF=m
+CONFIG_NETFILTER_XT_MATCH_CGROUP=m
+CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
+CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_CPU=m
+CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_HELPER=m
+CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
+CONFIG_NETFILTER_XT_MATCH_IPVS=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_NFACCT=m
+CONFIG_NETFILTER_XT_MATCH_OSF=m
+CONFIG_NETFILTER_XT_MATCH_OWNER=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_RATEEST=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_RECENT=m
+CONFIG_NETFILTER_XT_MATCH_SOCKET=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NETFILTER_XT_MATCH_U32=m
+CONFIG_IP_SET=m
+CONFIG_IP_SET_BITMAP_IP=m
+CONFIG_IP_SET_BITMAP_IPMAC=m
+CONFIG_IP_SET_BITMAP_PORT=m
+CONFIG_IP_SET_HASH_IP=m
+CONFIG_IP_SET_HASH_IPMARK=m
+CONFIG_IP_SET_HASH_IPPORT=m
+CONFIG_IP_SET_HASH_IPPORTIP=m
+CONFIG_IP_SET_HASH_IPPORTNET=m
+CONFIG_IP_SET_HASH_MAC=m
+CONFIG_IP_SET_HASH_NETPORTNET=m
+CONFIG_IP_SET_HASH_NET=m
+CONFIG_IP_SET_HASH_NETNET=m
+CONFIG_IP_SET_HASH_NETPORT=m
+CONFIG_IP_SET_HASH_NETIFACE=m
+CONFIG_IP_SET_LIST_SET=m
+CONFIG_IP_VS=m
+CONFIG_IP_VS_IPV6=y
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_IP_VS_PROTO_UDP=y
+CONFIG_IP_VS_PROTO_ESP=y
+CONFIG_IP_VS_PROTO_AH=y
+CONFIG_IP_VS_PROTO_SCTP=y
+CONFIG_IP_VS_RR=m
+CONFIG_IP_VS_WRR=m
+CONFIG_IP_VS_LC=m
+CONFIG_IP_VS_WLC=m
+CONFIG_IP_VS_FO=m
+CONFIG_IP_VS_OVF=m
+CONFIG_IP_VS_LBLC=m
+CONFIG_IP_VS_LBLCR=m
+CONFIG_IP_VS_DH=m
+CONFIG_IP_VS_SH=m
+CONFIG_IP_VS_SED=m
+CONFIG_IP_VS_NQ=m
+CONFIG_IP_VS_FTP=m
+CONFIG_IP_VS_PE_SIP=m
+CONFIG_NF_LOG_ARP=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_RPFILTER=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_SYNPROXY=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_NETMAP=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_CLUSTERIP=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_DECNET_NF_GRABULATOR=m
+CONFIG_NF_TABLES_BRIDGE=m
+CONFIG_NFT_BRIDGE_META=m
+CONFIG_NF_LOG_BRIDGE=m
+CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_EBT_BROUTE=m
+CONFIG_BRIDGE_EBT_T_FILTER=m
+CONFIG_BRIDGE_EBT_T_NAT=m
+CONFIG_BRIDGE_EBT_802_3=m
+CONFIG_BRIDGE_EBT_AMONG=m
+CONFIG_BRIDGE_EBT_ARP=m
+CONFIG_BRIDGE_EBT_IP=m
+CONFIG_BRIDGE_EBT_IP6=m
+CONFIG_BRIDGE_EBT_LIMIT=m
+CONFIG_BRIDGE_EBT_MARK=m
+CONFIG_BRIDGE_EBT_PKTTYPE=m
+CONFIG_BRIDGE_EBT_STP=m
+CONFIG_BRIDGE_EBT_VLAN=m
+CONFIG_BRIDGE_EBT_ARPREPLY=m
+CONFIG_BRIDGE_EBT_DNAT=m
+CONFIG_BRIDGE_EBT_MARK_T=m
+CONFIG_BRIDGE_EBT_REDIRECT=m
+CONFIG_BRIDGE_EBT_SNAT=m
+CONFIG_BRIDGE_EBT_LOG=m
+CONFIG_BRIDGE_EBT_NFLOG=m
+CONFIG_IP_DCCP=m
+CONFIG_IP_SCTP=m
+CONFIG_RDS=m
+CONFIG_RDS_TCP=m
+CONFIG_TIPC=m
+CONFIG_ATM=m
+CONFIG_ATM_CLIP=m
+CONFIG_ATM_LANE=m
+CONFIG_ATM_MPOA=m
+CONFIG_ATM_BR2684=m
+CONFIG_L2TP=m
+CONFIG_L2TP_V3=y
+CONFIG_L2TP_IP=m
+CONFIG_L2TP_ETH=m
+CONFIG_BRIDGE=m
+CONFIG_NET_DSA=m
+CONFIG_VLAN_8021Q=m
+CONFIG_VLAN_8021Q_GVRP=y
+CONFIG_VLAN_8021Q_MVRP=y
+CONFIG_DECNET=m
+CONFIG_DECNET_ROUTER=y
+CONFIG_LLC2=m
+CONFIG_ATALK=m
+CONFIG_DEV_APPLETALK=m
+CONFIG_IPDDP=m
+CONFIG_IPDDP_ENCAP=y
+CONFIG_X25=m
+CONFIG_LAPB=m
+CONFIG_PHONET=m
+CONFIG_6LOWPAN=m
+CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
+CONFIG_6LOWPAN_GHC_UDP=m
+CONFIG_6LOWPAN_GHC_ICMPV6=m
+CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
+CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
+CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
+CONFIG_IEEE802154=m
+CONFIG_IEEE802154_6LOWPAN=m
+CONFIG_MAC802154=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_ATM=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_MULTIQ=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFB=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+CONFIG_NET_SCH_NETEM=m
+CONFIG_NET_SCH_DRR=m
+CONFIG_NET_SCH_MQPRIO=m
+CONFIG_NET_SCH_CHOKE=m
+CONFIG_NET_SCH_QFQ=m
+CONFIG_NET_SCH_CODEL=m
+CONFIG_NET_SCH_FQ_CODEL=m
+CONFIG_NET_SCH_FQ=m
+CONFIG_NET_SCH_HHF=m
+CONFIG_NET_SCH_PIE=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_SCH_PLUG=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+CONFIG_CLS_U32_PERF=y
+CONFIG_CLS_U32_MARK=y
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+CONFIG_NET_CLS_FLOW=m
+CONFIG_NET_CLS_CGROUP=m
+CONFIG_NET_CLS_BPF=m
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NET_EMATCH=y
+CONFIG_NET_EMATCH_CMP=m
+CONFIG_NET_EMATCH_NBYTE=m
+CONFIG_NET_EMATCH_U32=m
+CONFIG_NET_EMATCH_META=m
+CONFIG_NET_EMATCH_TEXT=m
+CONFIG_NET_EMATCH_CANID=m
+CONFIG_NET_EMATCH_IPSET=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_POLICE=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_GACT_PROB=y
+CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_IPT=m
+CONFIG_NET_ACT_NAT=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_SIMP=m
+CONFIG_NET_ACT_SKBEDIT=m
+CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_VLAN=m
+CONFIG_NET_ACT_BPF=m
+CONFIG_NET_ACT_CONNMARK=m
+CONFIG_NET_ACT_SKBMOD=m
+CONFIG_NET_ACT_IFE=m
+CONFIG_NET_ACT_TUNNEL_KEY=m
+CONFIG_DCB=y
+CONFIG_BATMAN_ADV=m
+CONFIG_BATMAN_ADV_NC=y
+CONFIG_BATMAN_ADV_DEBUG=y
+CONFIG_OPENVSWITCH=m
+CONFIG_VSOCKETS=m
+CONFIG_NETLINK_DIAG=m
+CONFIG_MPLS_ROUTING=m
+CONFIG_MPLS_IPTUNNEL=m
+CONFIG_HSR=m
+CONFIG_NET_NCSI=y
+CONFIG_CGROUP_NET_PRIO=y
+CONFIG_BPF_JIT=y
+CONFIG_CAN=y
+CONFIG_CAN_VCAN=m
+CONFIG_CAN_SLCAN=m
+CONFIG_CAN_FLEXCAN=y
+CONFIG_CAN_8DEV_USB=m
+CONFIG_CAN_EMS_USB=m
+CONFIG_CAN_ESD_USB2=m
+CONFIG_CAN_GS_USB=m
+CONFIG_CAN_KVASER_USB=m
+CONFIG_CAN_PEAK_USB=m
+CONFIG_BT=m
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_CMTP=m
+CONFIG_BT_HIDP=y
+CONFIG_BT_6LOWPAN=m
+CONFIG_BT_LEDS=y
+CONFIG_BT_HCIBTUSB=m
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_INTEL=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_AG6XX=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_HCIBCM203X=m
+CONFIG_BT_HCIBPA10X=m
+CONFIG_BT_HCIBFUSB=m
+CONFIG_BT_HCIVHCI=m
+CONFIG_BT_MRVL=m
+CONFIG_BT_ATH3K=m
+CONFIG_CFG80211=m
+CONFIG_NL80211_TESTMODE=y
+CONFIG_CFG80211_CERTIFICATION_ONUS=y
+CONFIG_CFG80211_REG_CELLULAR_HINTS=y
+CONFIG_CFG80211_REG_RELAX_NO_IR=y
+CONFIG_MAC80211=m
+CONFIG_MAC80211_MESH=y
+CONFIG_MAC80211_MESSAGE_TRACING=y
+CONFIG_RFKILL=m
+CONFIG_RFKILL_INPUT=y
+CONFIG_RFKILL_GPIO=m
+CONFIG_CAIF=m
+CONFIG_CAIF_USB=m
+CONFIG_NFC=m
+CONFIG_NFC_DIGITAL=m
+CONFIG_NFC_NCI=m
+CONFIG_NFC_NCI_SPI=m
+CONFIG_NFC_NCI_UART=m
+CONFIG_NFC_HCI=m
+CONFIG_NFC_SHDLC=y
+CONFIG_NFC_PORT100=m
+CONFIG_NFC_PN533_USB=m
+CONFIG_NFC_MRVL_USB=m
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_IMX6=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_EXTRA_FIRMWARE="imx/sdma/sdma-imx6q.bin"
+CONFIG_EXTRA_FIRMWARE_DIR="firmware"
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
+CONFIG_IMX_WEIM=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=m
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_DATAFLASH=y
+CONFIG_MTD_SST25L=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_CDROM_PKTCDVD=m
+CONFIG_ATA_OVER_ETH=m
+CONFIG_BLK_DEV_NVME=m
+CONFIG_NVME_TARGET=m
+CONFIG_NVME_TARGET_LOOP=m
+CONFIG_C2PORT=m
+CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_AT25=y
+CONFIG_TI_ST=m
+CONFIG_RAID_ATTRS=m
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=m
+CONFIG_BLK_DEV_SR=m
+CONFIG_CHR_DEV_SG=m
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_FC_ATTRS=m
+CONFIG_SCSI_ISCSI_ATTRS=m
+CONFIG_SCSI_SAS_LIBSAS=m
+CONFIG_SCSI_SRP_ATTRS=m
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_IMX=y
+CONFIG_PATA_IMX=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_MD_LINEAR=y
+CONFIG_MD_RAID0=y
+CONFIG_MD_RAID1=y
+CONFIG_MD_RAID10=y
+CONFIG_MD_RAID456=y
+CONFIG_MD_MULTIPATH=y
+CONFIG_BCACHE=m
+CONFIG_BLK_DEV_DM=y
+CONFIG_DM_CRYPT=y
+CONFIG_DM_SNAPSHOT=y
+CONFIG_DM_THIN_PROVISIONING=m
+CONFIG_DM_CACHE=m
+CONFIG_DM_ERA=m
+CONFIG_DM_MIRROR=m
+CONFIG_DM_LOG_USERSPACE=m
+CONFIG_DM_RAID=m
+CONFIG_DM_ZERO=m
+CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_QL=m
+CONFIG_DM_MULTIPATH_ST=m
+CONFIG_DM_DELAY=m
+CONFIG_DM_FLAKEY=m
+CONFIG_DM_VERITY=m
+CONFIG_DM_SWITCH=m
+CONFIG_DM_LOG_WRITES=m
+CONFIG_NETDEVICES=y
+CONFIG_BONDING=m
+CONFIG_EQUALIZER=m
+CONFIG_IFB=m
+CONFIG_NET_TEAM=m
+CONFIG_MACVLAN=m
+CONFIG_MACVTAP=m
+CONFIG_IPVLAN=m
+CONFIG_VXLAN=m
+CONFIG_GENEVE=m
+CONFIG_GTP=m
+CONFIG_MACSEC=m
+CONFIG_NETCONSOLE=m
+CONFIG_NETCONSOLE_DYNAMIC=y
+CONFIG_TUN=m
+CONFIG_VETH=m
+CONFIG_NLMON=m
+CONFIG_NET_VRF=m
+CONFIG_ARCNET=m
+CONFIG_ARCNET_1201=m
+CONFIG_ARCNET_1051=m
+CONFIG_ARCNET_RAW=m
+CONFIG_ARCNET_CAP=m
+CONFIG_ARCNET_COM90xx=m
+CONFIG_ARCNET_COM90xxIO=m
+CONFIG_ARCNET_RIM_I=m
+CONFIG_ARCNET_COM20020=m
+CONFIG_ATM_TCP=m
+CONFIG_NET_DSA_MV88E6060=m
+CONFIG_NET_DSA_MV88E6XXX=m
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ARC is not set
+CONFIG_ATL2=m
+CONFIG_ATL1=m
+CONFIG_ATL1E=m
+CONFIG_ATL1C=m
+CONFIG_ALX=m
+# CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_CS89x0=y
+CONFIG_CS89x0_PLATFORM=y
+# CONFIG_NET_VENDOR_FARADAY is not set
+CONFIG_IGB=y
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_8139CP=m
+CONFIG_8139TOO=m
+CONFIG_R8169=m
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_SMC91X=m
+CONFIG_EPIC100=m
+CONFIG_SMC911X=m
+CONFIG_SMSC911X=m
+CONFIG_SMSC9420=m
+# CONFIG_NET_VENDOR_STMICRO is not set
+CONFIG_TLAN=m
+CONFIG_FDDI=m
+CONFIG_DEFXX=m
+CONFIG_SKFP=m
+CONFIG_MICREL_PHY=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_MPPE=m
+CONFIG_PPPOATM=m
+CONFIG_PPPOE=m
+CONFIG_PPTP=m
+CONFIG_PPPOL2TP=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_SLIP_MODE_SLIP6=y
+CONFIG_USB_CATC=m
+CONFIG_USB_KAWETH=m
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+CONFIG_USB_RTL8152=m
+CONFIG_USB_LAN78XX=m
+CONFIG_USB_NET_CDC_EEM=m
+CONFIG_USB_NET_HUAWEI_CDC_NCM=m
+CONFIG_USB_NET_CDC_MBIM=m
+CONFIG_USB_NET_DM9601=m
+CONFIG_USB_NET_SR9700=m
+CONFIG_USB_NET_SR9800=m
+CONFIG_USB_NET_SMSC75XX=m
+CONFIG_USB_NET_SMSC95XX=m
+CONFIG_USB_NET_GL620A=m
+CONFIG_USB_NET_PLUSB=m
+CONFIG_USB_NET_MCS7830=m
+CONFIG_USB_ALI_M5632=y
+CONFIG_USB_NET_CX82310_ETH=m
+CONFIG_USB_NET_KALMIA=m
+CONFIG_USB_NET_QMI_WWAN=m
+CONFIG_USB_HSO=m
+CONFIG_USB_NET_INT51X1=m
+CONFIG_USB_CDC_PHONET=m
+CONFIG_USB_IPHETH=m
+CONFIG_USB_SIERRA_NET=m
+CONFIG_USB_VL600=m
+CONFIG_USB_NET_CH9200=m
+CONFIG_ATH5K=m
+CONFIG_ATH9K=m
+CONFIG_ATH9K_HTC=m
+CONFIG_CARL9170=m
+CONFIG_ATH6KL=m
+CONFIG_ATH6KL_USB=m
+CONFIG_AR5523=m
+CONFIG_WIL6210=m
+CONFIG_ATH10K=m
+CONFIG_ATH10K_PCI=m
+CONFIG_ATH10K_SDIO=m
+CONFIG_WCN36XX=m
+CONFIG_ATMEL=m
+CONFIG_PCI_ATMEL=m
+CONFIG_AT76C50X_USB=m
+CONFIG_B43=m
+CONFIG_B43LEGACY=m
+CONFIG_BRCMSMAC=m
+CONFIG_BRCMFMAC=m
+CONFIG_BRCMFMAC_USB=y
+CONFIG_BRCMFMAC_PCIE=y
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
+CONFIG_IPW2200=m
+CONFIG_IPW2200_MONITOR=y
+CONFIG_IPW2200_PROMISCUOUS=y
+CONFIG_IPW2200_QOS=y
+CONFIG_IWL4965=m
+CONFIG_IWL3945=m
+CONFIG_IWLWIFI=m
+CONFIG_IWLDVM=m
+CONFIG_IWLMVM=m
+CONFIG_IWLWIFI_BCAST_FILTERING=y
+CONFIG_HOSTAP=m
+CONFIG_HOSTAP_FIRMWARE=y
+CONFIG_HOSTAP_PLX=m
+CONFIG_HOSTAP_PCI=m
+CONFIG_HERMES=m
+CONFIG_PLX_HERMES=m
+CONFIG_TMD_HERMES=m
+CONFIG_NORTEL_HERMES=m
+CONFIG_ORINOCO_USB=m
+CONFIG_P54_COMMON=m
+CONFIG_P54_USB=m
+CONFIG_P54_PCI=m
+CONFIG_PRISM54=m
+CONFIG_LIBERTAS=m
+CONFIG_LIBERTAS_USB=m
+CONFIG_LIBERTAS_SDIO=m
+CONFIG_LIBERTAS_SPI=m
+CONFIG_LIBERTAS_THINFIRM=m
+CONFIG_LIBERTAS_THINFIRM_USB=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_MWIFIEX_PCIE=m
+CONFIG_MWIFIEX_USB=m
+CONFIG_MWL8K=m
+CONFIG_MT7601U=m
+CONFIG_RT2X00=m
+CONFIG_RT2400PCI=m
+CONFIG_RT2500PCI=m
+CONFIG_RT61PCI=m
+CONFIG_RT2800PCI=m
+CONFIG_RT2500USB=m
+CONFIG_RT73USB=m
+CONFIG_RT2800USB=m
+CONFIG_RT2800USB_RT3573=y
+CONFIG_RT2800USB_RT53XX=y
+CONFIG_RT2800USB_RT55XX=y
+CONFIG_RT2800USB_UNKNOWN=y
+CONFIG_RTL8180=m
+CONFIG_RTL8187=m
+CONFIG_RTL8XXXU=m
+CONFIG_RTL8XXXU_UNTESTED=y
+CONFIG_WL12XX=m
+CONFIG_WLCORE_SDIO=m
+# CONFIG_WILINK_PLATFORM_DATA is not set
+CONFIG_USB_ZD1201=m
+CONFIG_ZD1211RW=m
+CONFIG_MAC80211_HWSIM=m
+CONFIG_USB_NET_RNDIS_WLAN=m
+CONFIG_WAN=y
+CONFIG_HDLC=m
+CONFIG_HDLC_RAW=m
+CONFIG_HDLC_RAW_ETH=m
+CONFIG_HDLC_CISCO=m
+CONFIG_HDLC_FR=m
+CONFIG_HDLC_PPP=m
+CONFIG_HDLC_X25=m
+CONFIG_PCI200SYN=m
+CONFIG_WANXL=m
+CONFIG_PC300TOO=m
+CONFIG_FARSYNC=m
+CONFIG_SLIC_DS26522=m
+CONFIG_DLCI=m
+CONFIG_LAPBETHER=m
+CONFIG_X25_ASY=m
+CONFIG_IEEE802154_FAKELB=m
+CONFIG_IEEE802154_AT86RF230=m
+CONFIG_IEEE802154_MRF24J40=m
+CONFIG_IEEE802154_CC2520=m
+CONFIG_IEEE802154_ATUSB=m
+CONFIG_IEEE802154_ADF7242=m
+CONFIG_ISDN=y
+CONFIG_MISDN=m
+CONFIG_MISDN_DSP=m
+CONFIG_MISDN_L1OIP=m
+CONFIG_MISDN_HFCPCI=m
+CONFIG_MISDN_HFCMULTI=m
+CONFIG_MISDN_HFCUSB=m
+CONFIG_MISDN_AVMFRITZ=m
+CONFIG_MISDN_SPEEDFAX=m
+CONFIG_MISDN_INFINEON=m
+CONFIG_MISDN_W6692=m
+CONFIG_MISDN_NETJET=m
+CONFIG_INPUT_SPARSEKMAP=m
+CONFIG_INPUT_MATRIXKMAP=y
+CONFIG_INPUT_MOUSEDEV=m
+CONFIG_INPUT_JOYDEV=m
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_GPIO_POLLED=m
+# CONFIG_MOUSE_PS2 is not set
+CONFIG_MOUSE_SERIAL=m
+CONFIG_MOUSE_APPLETOUCH=m
+CONFIG_MOUSE_BCM5974=m
+CONFIG_MOUSE_GPIO=m
+CONFIG_MOUSE_SYNAPTICS_USB=m
+CONFIG_INPUT_JOYSTICK=y
+CONFIG_JOYSTICK_ANALOG=m
+CONFIG_JOYSTICK_A3D=m
+CONFIG_JOYSTICK_ADI=m
+CONFIG_JOYSTICK_COBRA=m
+CONFIG_JOYSTICK_GF2K=m
+CONFIG_JOYSTICK_GRIP=m
+CONFIG_JOYSTICK_GRIP_MP=m
+CONFIG_JOYSTICK_GUILLEMOT=m
+CONFIG_JOYSTICK_INTERACT=m
+CONFIG_JOYSTICK_SIDEWINDER=m
+CONFIG_JOYSTICK_TMDC=m
+CONFIG_JOYSTICK_IFORCE=m
+CONFIG_JOYSTICK_IFORCE_USB=m
+CONFIG_JOYSTICK_IFORCE_232=m
+CONFIG_JOYSTICK_WARRIOR=m
+CONFIG_JOYSTICK_MAGELLAN=m
+CONFIG_JOYSTICK_SPACEORB=m
+CONFIG_JOYSTICK_SPACEBALL=m
+CONFIG_JOYSTICK_STINGER=m
+CONFIG_JOYSTICK_TWIDJOY=m
+CONFIG_JOYSTICK_ZHENHUA=m
+CONFIG_JOYSTICK_AS5011=m
+CONFIG_JOYSTICK_JOYDUMP=m
+CONFIG_JOYSTICK_XPAD=m
+CONFIG_JOYSTICK_XPAD_FF=y
+CONFIG_JOYSTICK_XPAD_LEDS=y
+CONFIG_INPUT_TABLET=y
+CONFIG_TABLET_USB_ACECAD=m
+CONFIG_TABLET_USB_AIPTEK=m
+CONFIG_TABLET_USB_GTCO=m
+CONFIG_TABLET_USB_HANWANG=m
+CONFIG_TABLET_USB_KBTAB=m
+CONFIG_TABLET_USB_PEGASUS=m
+CONFIG_TABLET_SERIAL_WACOM4=m
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_TOUCHSCREEN_TSC2004=y
+CONFIG_TOUCHSCREEN_TSC2005=y
+CONFIG_TOUCHSCREEN_TSC2007=y
+CONFIG_INPUT_MISC=y
+CONFIG_SERIO_SERPORT=m
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_MAX3100_TS=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_GPIO=y
+CONFIG_I2C_MUX_PINCTRL=y
+CONFIG_I2C_MUX_REG=y
+CONFIG_I2C_DEMUX_PINCTRL=y
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_I2C_ALGOPCF=m
+CONFIG_I2C_ALGOPCA=m
+CONFIG_I2C_GPIO=y
+CONFIG_I2C_IMX=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_QUADSPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_SPI_IMX=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_PPS_CLIENT_LDISC=m
+CONFIG_PPS_CLIENT_GPIO=m
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MXC=y
+CONFIG_GPIO_ADP5588=m
+CONFIG_GPIO_MAX7300=m
+CONFIG_GPIO_MAX732X=m
+CONFIG_GPIO_PCA953X=m
+CONFIG_GPIO_PCF857X=m
+CONFIG_GPIO_TS4900=y
+CONFIG_GPIO_PISOSR=m
+CONFIG_W1=m
+CONFIG_W1_MASTER_DS2490=m
+CONFIG_W1_MASTER_GPIO=m
+CONFIG_W1_SLAVE_THERM=m
+CONFIG_W1_SLAVE_SMEM=m
+CONFIG_W1_SLAVE_DS2408=m
+CONFIG_W1_SLAVE_DS2413=m
+CONFIG_W1_SLAVE_DS2406=m
+CONFIG_W1_SLAVE_DS2423=m
+CONFIG_W1_SLAVE_DS2431=m
+CONFIG_W1_SLAVE_DS2433=m
+CONFIG_W1_SLAVE_DS2780=m
+CONFIG_W1_SLAVE_DS2781=m
+CONFIG_W1_SLAVE_DS28E04=m
+# CONFIG_HWMON is not set
+CONFIG_THERMAL_STATISTICS=y
+CONFIG_THERMAL_WRITABLE_TRIPS=y
+CONFIG_CPU_THERMAL=y
+CONFIG_IMX_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_RN5T618_WATCHDOG=y
+CONFIG_IMX2_WDT=y
+CONFIG_MFD_DA9052_I2C=y
+CONFIG_MFD_DA9062=y
+CONFIG_MFD_DA9063=y
+CONFIG_MFD_MC13XXX_SPI=y
+CONFIG_MFD_MC13XXX_I2C=y
+CONFIG_MFD_RN5T618=y
+CONFIG_MFD_STMPE=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_ANATOP=y
+CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_DA9062=y
+CONFIG_REGULATOR_DA9063=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MC13783=y
+CONFIG_REGULATOR_MC13892=y
+CONFIG_REGULATOR_PFUZE100=y
+CONFIG_REGULATOR_RN5T618=y
+CONFIG_RC_CORE=y
+CONFIG_RC_MAP=m
+CONFIG_RC_DEVICES=y
+CONFIG_RC_ATI_REMOTE=m
+CONFIG_IR_HIX5HD2=m
+CONFIG_IR_IMON=m
+CONFIG_IR_MCEUSB=m
+CONFIG_IR_REDRAT3=m
+CONFIG_IR_STREAMZAP=m
+CONFIG_IR_IGORPLUGUSB=m
+CONFIG_IR_IGUANA=m
+CONFIG_IR_TTUSBIR=m
+CONFIG_RC_LOOPBACK=m
+CONFIG_IR_GPIO_CIR=m
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_VIDEO_ADV_DEBUG=y
+CONFIG_VIDEO_FIXED_MINOR_RANGES=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
+CONFIG_USB_M5602=m
+CONFIG_USB_STV06XX=m
+CONFIG_USB_GL860=m
+CONFIG_USB_GSPCA_BENQ=m
+CONFIG_USB_GSPCA_CONEX=m
+CONFIG_USB_GSPCA_CPIA1=m
+CONFIG_USB_GSPCA_DTCS033=m
+CONFIG_USB_GSPCA_ETOMS=m
+CONFIG_USB_GSPCA_FINEPIX=m
+CONFIG_USB_GSPCA_JEILINJ=m
+CONFIG_USB_GSPCA_JL2005BCD=m
+CONFIG_USB_GSPCA_KINECT=m
+CONFIG_USB_GSPCA_KONICA=m
+CONFIG_USB_GSPCA_MARS=m
+CONFIG_USB_GSPCA_MR97310A=m
+CONFIG_USB_GSPCA_NW80X=m
+CONFIG_USB_GSPCA_OV519=m
+CONFIG_USB_GSPCA_OV534=m
+CONFIG_USB_GSPCA_OV534_9=m
+CONFIG_USB_GSPCA_PAC207=m
+CONFIG_USB_GSPCA_PAC7302=m
+CONFIG_USB_GSPCA_PAC7311=m
+CONFIG_USB_GSPCA_SE401=m
+CONFIG_USB_GSPCA_SN9C2028=m
+CONFIG_USB_GSPCA_SN9C20X=m
+CONFIG_USB_GSPCA_SONIXB=m
+CONFIG_USB_GSPCA_SONIXJ=m
+CONFIG_USB_GSPCA_SPCA500=m
+CONFIG_USB_GSPCA_SPCA501=m
+CONFIG_USB_GSPCA_SPCA505=m
+CONFIG_USB_GSPCA_SPCA506=m
+CONFIG_USB_GSPCA_SPCA508=m
+CONFIG_USB_GSPCA_SPCA561=m
+CONFIG_USB_GSPCA_SPCA1528=m
+CONFIG_USB_GSPCA_SQ905=m
+CONFIG_USB_GSPCA_SQ905C=m
+CONFIG_USB_GSPCA_SQ930X=m
+CONFIG_USB_GSPCA_STK014=m
+CONFIG_USB_GSPCA_STK1135=m
+CONFIG_USB_GSPCA_STV0680=m
+CONFIG_USB_GSPCA_SUNPLUS=m
+CONFIG_USB_GSPCA_T613=m
+CONFIG_USB_GSPCA_TOPRO=m
+CONFIG_USB_GSPCA_TOUPTEK=m
+CONFIG_USB_GSPCA_TV8532=m
+CONFIG_USB_GSPCA_VC032X=m
+CONFIG_USB_GSPCA_VICAM=m
+CONFIG_USB_GSPCA_XIRLINK_CIT=m
+CONFIG_USB_GSPCA_ZC3XX=m
+CONFIG_USB_PWC=m
+CONFIG_VIDEO_CPIA2=m
+CONFIG_USB_ZR364XX=m
+CONFIG_USB_STKWEBCAM=m
+CONFIG_USB_S2255=m
+CONFIG_VIDEO_USBTV=m
+CONFIG_VIDEO_PVRUSB2=m
+CONFIG_VIDEO_HDPVR=m
+CONFIG_VIDEO_STK1160_COMMON=m
+CONFIG_VIDEO_GO7007=m
+CONFIG_VIDEO_GO7007_USB=m
+CONFIG_VIDEO_AU0828=m
+CONFIG_VIDEO_CX231XX=m
+CONFIG_VIDEO_CX231XX_ALSA=m
+CONFIG_VIDEO_CX231XX_DVB=m
+CONFIG_VIDEO_TM6000=m
+CONFIG_VIDEO_TM6000_ALSA=m
+CONFIG_VIDEO_TM6000_DVB=m
+CONFIG_DVB_USB=m
+CONFIG_DVB_USB_A800=m
+CONFIG_DVB_USB_DIBUSB_MB=m
+CONFIG_DVB_USB_DIBUSB_MC=m
+CONFIG_DVB_USB_DIB0700=m
+CONFIG_DVB_USB_UMT_010=m
+CONFIG_DVB_USB_CXUSB=m
+CONFIG_DVB_USB_M920X=m
+CONFIG_DVB_USB_DIGITV=m
+CONFIG_DVB_USB_VP7045=m
+CONFIG_DVB_USB_VP702X=m
+CONFIG_DVB_USB_GP8PSK=m
+CONFIG_DVB_USB_NOVA_T_USB2=m
+CONFIG_DVB_USB_TTUSB2=m
+CONFIG_DVB_USB_DTT200U=m
+CONFIG_DVB_USB_OPERA1=m
+CONFIG_DVB_USB_AF9005=m
+CONFIG_DVB_USB_AF9005_REMOTE=m
+CONFIG_DVB_USB_PCTV452E=m
+CONFIG_DVB_USB_DW2102=m
+CONFIG_DVB_USB_CINERGY_T2=m
+CONFIG_DVB_USB_DTV5100=m
+CONFIG_DVB_USB_AZ6027=m
+CONFIG_DVB_USB_TECHNISAT_USB2=m
+CONFIG_DVB_USB_V2=m
+CONFIG_DVB_USB_AF9015=m
+CONFIG_DVB_USB_AF9035=m
+CONFIG_DVB_USB_ANYSEE=m
+CONFIG_DVB_USB_AU6610=m
+CONFIG_DVB_USB_AZ6007=m
+CONFIG_DVB_USB_CE6230=m
+CONFIG_DVB_USB_EC168=m
+CONFIG_DVB_USB_GL861=m
+CONFIG_DVB_USB_MXL111SF=m
+CONFIG_DVB_USB_RTL28XXU=m
+CONFIG_DVB_USB_DVBSKY=m
+CONFIG_DVB_TTUSB_BUDGET=m
+CONFIG_DVB_TTUSB_DEC=m
+CONFIG_SMS_USB_DRV=m
+CONFIG_DVB_B2C2_FLEXCOP_USB=m
+CONFIG_DVB_AS102=m
+CONFIG_VIDEO_EM28XX=m
+CONFIG_VIDEO_EM28XX_V4L2=m
+CONFIG_VIDEO_EM28XX_ALSA=m
+CONFIG_VIDEO_EM28XX_DVB=m
+CONFIG_USB_AIRSPY=m
+CONFIG_USB_HACKRF=m
+CONFIG_USB_MSI2500=m
+CONFIG_MEDIA_PCI_SUPPORT=y
+CONFIG_VIDEO_SOLO6X10=m
+CONFIG_VIDEO_TW5864=m
+CONFIG_VIDEO_TW68=m
+CONFIG_VIDEO_TW686X=m
+CONFIG_VIDEO_HEXIUM_GEMINI=m
+CONFIG_VIDEO_HEXIUM_ORION=m
+CONFIG_VIDEO_MXB=m
+CONFIG_VIDEO_DT3155=m
+CONFIG_VIDEO_CX25821=m
+CONFIG_VIDEO_CX25821_ALSA=m
+CONFIG_VIDEO_SAA7134=m
+CONFIG_VIDEO_SAA7134_ALSA=m
+CONFIG_VIDEO_SAA7134_DVB=m
+CONFIG_VIDEO_SAA7134_GO7007=m
+CONFIG_VIDEO_SAA7164=m
+CONFIG_DVB_AV7110=m
+CONFIG_DVB_BUDGET_CORE=m
+CONFIG_DVB_BUDGET=m
+CONFIG_DVB_BUDGET_AV=m
+CONFIG_DVB_BUDGET_PATCH=m
+CONFIG_DVB_B2C2_FLEXCOP_PCI=m
+CONFIG_DVB_PLUTO2=m
+CONFIG_DVB_PT1=m
+CONFIG_DVB_PT3=m
+CONFIG_DVB_NGENE=m
+CONFIG_DVB_DDBRIDGE=m
+CONFIG_DVB_NETUP_UNIDVB=m
+CONFIG_RADIO_SI4713=m
+CONFIG_USB_SI4713=m
+CONFIG_PLATFORM_SI4713=m
+CONFIG_USB_MR800=m
+CONFIG_USB_DSBR=m
+CONFIG_RADIO_MAXIRADIO=m
+CONFIG_RADIO_SHARK=m
+CONFIG_RADIO_SHARK2=m
+CONFIG_USB_KEENE=m
+CONFIG_USB_RAREMONO=m
+CONFIG_USB_MA901=m
+CONFIG_RADIO_TEA5764=m
+CONFIG_RADIO_SAA7706H=m
+CONFIG_RADIO_TEF6862=m
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_MUX=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=m
+CONFIG_VIDEO_ADV7180=m
+CONFIG_VIDEO_OV2680=m
+CONFIG_VIDEO_OV5640=m
+CONFIG_VIDEO_OV5645=m
+CONFIG_IMX_IPUV3_CORE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_LVDS=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
+CONFIG_DRM_TI_TFP410=y
+CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
+CONFIG_DRM_DW_HDMI_CEC=y
+CONFIG_DRM_IMX=y
+CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
+CONFIG_DRM_IMX_TVE=y
+CONFIG_DRM_IMX_LDB=y
+CONFIG_DRM_IMX_HDMI=y
+CONFIG_DRM_ETNAVIV=y
+CONFIG_DRM_MXSFB=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_L4F00242T03=y
+CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_GPIO=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_HRTIMER=y
+CONFIG_SND_USB_AUDIO=m
+CONFIG_SND_USB_UA101=m
+CONFIG_SND_USB_CAIAQ=m
+CONFIG_SND_USB_6FIRE=m
+CONFIG_SND_USB_HIFACE=m
+CONFIG_SND_BCD2000=m
+CONFIG_SND_USB_POD=m
+CONFIG_SND_USB_PODHD=m
+CONFIG_SND_USB_TONEPORT=m
+CONFIG_SND_USB_VARIAX=m
+CONFIG_SND_SOC=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_SOC_IMX_SGTL5000=y
+CONFIG_SND_SOC_FSL_ASOC_CARD=y
+CONFIG_SND_SOC_AC97_CODEC=y
+CONFIG_SND_SOC_CS42XX8_I2C=y
+CONFIG_SND_SOC_ES8328_I2C=y
+CONFIG_SND_SOC_ES8328_SPI=y
+CONFIG_SND_SOC_TLV320AIC23_I2C=y
+CONFIG_SND_SOC_TLV320AIC3X=y
+CONFIG_SND_SOC_WM8960=y
+CONFIG_SND_SOC_WM8962=y
+CONFIG_SND_SIMPLE_CARD=y
+CONFIG_UHID=m
+CONFIG_HID_A4TECH=m
+CONFIG_HID_ACRUX=m
+CONFIG_HID_APPLE=m
+CONFIG_HID_APPLEIR=m
+CONFIG_HID_AUREAL=m
+CONFIG_HID_BELKIN=m
+CONFIG_HID_BETOP_FF=m
+CONFIG_HID_CHERRY=m
+CONFIG_HID_CHICONY=m
+CONFIG_HID_CORSAIR=m
+CONFIG_HID_PRODIKEYS=m
+CONFIG_HID_CMEDIA=m
+CONFIG_HID_CYPRESS=m
+CONFIG_HID_DRAGONRISE=m
+CONFIG_HID_EMS_FF=m
+CONFIG_HID_ELECOM=m
+CONFIG_HID_ELO=m
+CONFIG_HID_EZKEY=m
+CONFIG_HID_GEMBIRD=m
+CONFIG_HID_GFRM=m
+CONFIG_HID_HOLTEK=m
+CONFIG_HID_GT683R=m
+CONFIG_HID_KEYTOUCH=m
+CONFIG_HID_KYE=m
+CONFIG_HID_UCLOGIC=m
+CONFIG_HID_WALTOP=m
+CONFIG_HID_GYRATION=m
+CONFIG_HID_ICADE=m
+CONFIG_HID_TWINHAN=m
+CONFIG_HID_KENSINGTON=m
+CONFIG_HID_LCPOWER=m
+CONFIG_HID_LENOVO=m
+CONFIG_HID_LOGITECH=m
+CONFIG_HID_LOGITECH_HIDPP=m
+CONFIG_HID_MAGICMOUSE=m
+CONFIG_HID_MICROSOFT=m
+CONFIG_HID_MONTEREY=m
+CONFIG_HID_MULTITOUCH=m
+CONFIG_HID_NTRIG=m
+CONFIG_HID_ORTEK=m
+CONFIG_HID_PANTHERLORD=m
+CONFIG_HID_PENMOUNT=m
+CONFIG_HID_PETALYNX=m
+CONFIG_HID_PICOLCD=m
+CONFIG_HID_PLANTRONICS=m
+CONFIG_HID_PRIMAX=m
+CONFIG_HID_ROCCAT=m
+CONFIG_HID_SAITEK=m
+CONFIG_HID_SAMSUNG=m
+CONFIG_HID_SONY=m
+CONFIG_HID_SPEEDLINK=m
+CONFIG_HID_STEELSERIES=m
+CONFIG_HID_SUNPLUS=m
+CONFIG_HID_RMI=m
+CONFIG_HID_GREENASIA=m
+CONFIG_HID_SMARTJOYPLUS=m
+CONFIG_HID_TIVO=m
+CONFIG_HID_TOPSEED=m
+CONFIG_HID_THINGM=m
+CONFIG_HID_THRUSTMASTER=m
+CONFIG_HID_WACOM=m
+CONFIG_HID_WIIMOTE=m
+CONFIG_HID_XINMO=m
+CONFIG_HID_ZEROPLUS=m
+CONFIG_HID_ZYDACRON=m
+CONFIG_HID_ALPS=m
+CONFIG_USB_LED_TRIG=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_OTG=y
+CONFIG_USB_OTG_FSM=y
+CONFIG_USB_LEDS_TRIGGER_USBPORT=y
+CONFIG_USB_MON=m
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_HCD_TEST_MODE=y
+CONFIG_USB_PRINTER=m
+CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE_REALTEK=m
+CONFIG_USB_STORAGE_DATAFAB=m
+CONFIG_USB_STORAGE_FREECOM=m
+CONFIG_USB_STORAGE_ISD200=m
+CONFIG_USB_STORAGE_USBAT=m
+CONFIG_USB_STORAGE_SDDR09=m
+CONFIG_USB_STORAGE_SDDR55=m
+CONFIG_USB_STORAGE_JUMPSHOT=m
+CONFIG_USB_STORAGE_ALAUDA=m
+CONFIG_USB_STORAGE_ONETOUCH=m
+CONFIG_USB_STORAGE_KARMA=m
+CONFIG_USB_STORAGE_CYPRESS_ATACB=m
+CONFIG_USB_STORAGE_ENE_UB6250=m
+CONFIG_USB_UAS=m
+CONFIG_USB_MDC800=m
+CONFIG_USB_MICROTEK=m
+CONFIG_USBIP_CORE=m
+CONFIG_USBIP_VHCI_HCD=m
+CONFIG_USBIP_HOST=m
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_SIMPLE=m
+CONFIG_USB_SERIAL_AIRCABLE=m
+CONFIG_USB_SERIAL_ARK3116=m
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_CH341=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
+CONFIG_USB_SERIAL_CP210X=m
+CONFIG_USB_SERIAL_CYPRESS_M8=m
+CONFIG_USB_SERIAL_EMPEG=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_VISOR=m
+CONFIG_USB_SERIAL_IPAQ=m
+CONFIG_USB_SERIAL_IR=m
+CONFIG_USB_SERIAL_EDGEPORT=m
+CONFIG_USB_SERIAL_EDGEPORT_TI=m
+CONFIG_USB_SERIAL_F81232=m
+CONFIG_USB_SERIAL_GARMIN=m
+CONFIG_USB_SERIAL_IPW=m
+CONFIG_USB_SERIAL_IUU=m
+CONFIG_USB_SERIAL_KEYSPAN_PDA=m
+CONFIG_USB_SERIAL_KEYSPAN=m
+CONFIG_USB_SERIAL_KLSI=m
+CONFIG_USB_SERIAL_KOBIL_SCT=m
+CONFIG_USB_SERIAL_MCT_U232=m
+CONFIG_USB_SERIAL_METRO=m
+CONFIG_USB_SERIAL_MOS7720=m
+CONFIG_USB_SERIAL_MOS7840=m
+CONFIG_USB_SERIAL_MXUPORT=m
+CONFIG_USB_SERIAL_NAVMAN=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_USB_SERIAL_OTI6858=m
+CONFIG_USB_SERIAL_QCAUX=m
+CONFIG_USB_SERIAL_QUALCOMM=m
+CONFIG_USB_SERIAL_SPCP8X5=m
+CONFIG_USB_SERIAL_SAFE=m
+CONFIG_USB_SERIAL_SAFE_PADDED=y
+CONFIG_USB_SERIAL_SIERRAWIRELESS=m
+CONFIG_USB_SERIAL_SYMBOL=m
+CONFIG_USB_SERIAL_TI=m
+CONFIG_USB_SERIAL_CYBERJACK=m
+CONFIG_USB_SERIAL_XIRCOM=m
+CONFIG_USB_SERIAL_OPTION=m
+CONFIG_USB_SERIAL_OMNINET=m
+CONFIG_USB_SERIAL_OPTICON=m
+CONFIG_USB_SERIAL_XSENS_MT=m
+CONFIG_USB_SERIAL_WISHBONE=m
+CONFIG_USB_SERIAL_SSU100=m
+CONFIG_USB_SERIAL_QT2=m
+CONFIG_USB_SERIAL_DEBUG=m
+CONFIG_USB_EMI62=m
+CONFIG_USB_EMI26=m
+CONFIG_USB_ADUTUX=m
+CONFIG_USB_SEVSEG=m
+CONFIG_USB_LEGOTOWER=m
+CONFIG_USB_LCD=m
+CONFIG_USB_CYPRESS_CY7C63=m
+CONFIG_USB_CYTHERM=m
+CONFIG_USB_IDMOUSE=m
+CONFIG_USB_FTDI_ELAN=m
+CONFIG_USB_APPLEDISPLAY=m
+CONFIG_USB_SISUSBVGA=m
+CONFIG_USB_LD=m
+CONFIG_USB_TRANCEVIBRATOR=m
+CONFIG_USB_IOWARRIOR=m
+CONFIG_USB_TEST=m
+CONFIG_USB_EHSET_TEST_FIXTURE=m
+CONFIG_USB_ISIGHTFW=m
+CONFIG_USB_YUREX=m
+CONFIG_USB_HSIC_USB3503=m
+CONFIG_USB_HSIC_USB4604=m
+CONFIG_USB_LINK_LAYER_TEST=m
+CONFIG_USB_CHAOSKEY=m
+CONFIG_USB_ATM=m
+CONFIG_USB_SPEEDTOUCH=m
+CONFIG_USB_CXACRU=m
+CONFIG_USB_UEAGLEATM=m
+CONFIG_USB_XUSBATM=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_FSL_USB2=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_UAC1=y
+CONFIG_USB_CONFIGFS_F_UAC2=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_CONFIGFS_F_UVC=y
+CONFIG_USB_CONFIGFS_F_PRINTER=y
+CONFIG_USB_ZERO=m
+CONFIG_USB_AUDIO=m
+CONFIG_USB_ETH=m
+CONFIG_USB_G_NCM=m
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FUNCTIONFS=m
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_USB_G_SERIAL=m
+CONFIG_USB_MIDI_GADGET=m
+CONFIG_USB_G_PRINTER=m
+CONFIG_USB_CDC_COMPOSITE=m
+CONFIG_USB_G_NOKIA=m
+CONFIG_USB_G_ACM_MS=m
+CONFIG_USB_G_MULTI=m
+CONFIG_USB_G_MULTI_CDC=y
+CONFIG_USB_G_HID=m
+CONFIG_USB_G_DBGP=m
+CONFIG_USB_G_WEBCAM=m
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PWM=y
+CONFIG_LEDS_SYSCON=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_DISK=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=y
+CONFIG_LEDS_TRIGGER_CAMERA=y
+CONFIG_LEDS_TRIGGER_PANIC=y
+CONFIG_INFINIBAND=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_ISL1208=y
+CONFIG_RTC_DRV_ISL12022=y
+CONFIG_RTC_DRV_PCF8523=y
+CONFIG_RTC_DRV_PCF8563=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_RTC_DRV_RC5T619=y
+CONFIG_RTC_DRV_DA9063=y
+CONFIG_RTC_DRV_MC13XXX=y
+CONFIG_RTC_DRV_MXC=y
+CONFIG_RTC_DRV_MXC_V2=y
+CONFIG_RTC_DRV_SNVS=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_EDMA=y
+CONFIG_IMX_SDMA=y
+CONFIG_MXS_DMA=y
+CONFIG_DMATEST=m
+CONFIG_UIO=m
+CONFIG_UIO_PDRV_GENIRQ=m
+CONFIG_UIO_DMEM_GENIRQ=m
+CONFIG_UIO_PCI_GENERIC=m
+CONFIG_STAGING=y
+CONFIG_PRISM2_USB=m
+CONFIG_RTL8192U=m
+CONFIG_RTLLIB=m
+CONFIG_RTL8192E=m
+CONFIG_R8712U=m
+CONFIG_R8188EU=m
+CONFIG_RTS5208=m
+CONFIG_VT6655=m
+CONFIG_STAGING_MEDIA=y
+CONFIG_VIDEO_IMX_MEDIA=y
+CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MN=y
+CONFIG_CLK_IMX8MP=y
+CONFIG_CLK_IMX8MQ=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IMX_GPCV2_PM_DOMAINS=y
+CONFIG_SOC_IMX8M=y
+CONFIG_EXTCON_ADC_JACK=m
+CONFIG_EXTCON_GPIO=m
+CONFIG_EXTCON_USB_GPIO=m
+CONFIG_IIO=y
+CONFIG_IIO_BUFFER_CB=m
+CONFIG_IIO_SW_DEVICE=m
+CONFIG_IIO_SW_TRIGGER=m
+CONFIG_MMA8452=y
+CONFIG_IMX7D_ADC=y
+CONFIG_RN5T618_ADC=y
+CONFIG_VF610_ADC=y
+CONFIG_SENSORS_ISL29018=y
+CONFIG_MAG3110=y
+CONFIG_MPL3115=y
+CONFIG_PWM=y
+CONFIG_PWM_FSL_FTM=y
+CONFIG_PWM_IMX27=y
+CONFIG_PWM_IMX_TPM=y
+CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_NVMEM_SNVS_LPGPR=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_MUX_MMIO=y
+CONFIG_SIOX=m
+CONFIG_SIOX_BUS_GPIO=m
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_REISERFS_FS=y
+CONFIG_REISERFS_FS_XATTR=y
+CONFIG_REISERFS_FS_POSIX_ACL=y
+CONFIG_REISERFS_FS_SECURITY=y
+CONFIG_JFS_FS=y
+CONFIG_JFS_POSIX_ACL=y
+CONFIG_JFS_SECURITY=y
+CONFIG_XFS_FS=y
+CONFIG_XFS_QUOTA=y
+CONFIG_XFS_POSIX_ACL=y
+CONFIG_XFS_RT=y
+CONFIG_GFS2_FS=m
+CONFIG_OCFS2_FS=m
+CONFIG_BTRFS_FS=y
+CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_NILFS2_FS=y
+CONFIG_F2FS_FS=y
+CONFIG_F2FS_FS_SECURITY=y
+CONFIG_F2FS_CHECK_FS=y
+CONFIG_QUOTA_NETLINK_INTERFACE=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_QFMT_V2=m
+CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=m
+CONFIG_CUSE=m
+CONFIG_OVERLAY_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=m
+CONFIG_NTFS_RW=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_ORANGEFS_FS=m
+CONFIG_ADFS_FS=m
+CONFIG_AFFS_FS=m
+CONFIG_ECRYPT_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
+CONFIG_JFFS2_FS=m
+CONFIG_CRAMFS=m
+CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_VXFS_FS=m
+CONFIG_MINIX_FS=m
+CONFIG_OMFS_FS=m
+CONFIG_HPFS_FS=m
+CONFIG_QNX4FS_FS=m
+CONFIG_QNX6FS_FS=m
+CONFIG_ROMFS_FS=m
+CONFIG_PSTORE=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_NFS_V4_1_MIGRATION=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
+CONFIG_NFSD_BLOCKLAYOUT=y
+CONFIG_NFSD_SCSILAYOUT=y
+CONFIG_NFSD_FLEXFILELAYOUT=y
+CONFIG_CEPH_FS=m
+CONFIG_CIFS=m
+CONFIG_CODA_FS=m
+CONFIG_AFS_FS=m
+CONFIG_NLS_DEFAULT="cp437"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_737=m
+CONFIG_NLS_CODEPAGE_775=m
+CONFIG_NLS_CODEPAGE_850=m
+CONFIG_NLS_CODEPAGE_852=m
+CONFIG_NLS_CODEPAGE_855=m
+CONFIG_NLS_CODEPAGE_857=m
+CONFIG_NLS_CODEPAGE_860=m
+CONFIG_NLS_CODEPAGE_861=m
+CONFIG_NLS_CODEPAGE_862=m
+CONFIG_NLS_CODEPAGE_863=m
+CONFIG_NLS_CODEPAGE_864=m
+CONFIG_NLS_CODEPAGE_865=m
+CONFIG_NLS_CODEPAGE_866=m
+CONFIG_NLS_CODEPAGE_869=m
+CONFIG_NLS_CODEPAGE_936=m
+CONFIG_NLS_CODEPAGE_950=m
+CONFIG_NLS_CODEPAGE_932=m
+CONFIG_NLS_CODEPAGE_949=m
+CONFIG_NLS_CODEPAGE_874=m
+CONFIG_NLS_ISO8859_8=m
+CONFIG_NLS_CODEPAGE_1250=m
+CONFIG_NLS_CODEPAGE_1251=m
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=m
+CONFIG_NLS_ISO8859_3=m
+CONFIG_NLS_ISO8859_4=m
+CONFIG_NLS_ISO8859_5=m
+CONFIG_NLS_ISO8859_6=m
+CONFIG_NLS_ISO8859_7=m
+CONFIG_NLS_ISO8859_9=m
+CONFIG_NLS_ISO8859_13=m
+CONFIG_NLS_ISO8859_14=m
+CONFIG_NLS_ISO8859_15=m
+CONFIG_NLS_KOI8_R=m
+CONFIG_NLS_KOI8_U=m
+CONFIG_NLS_MAC_ROMAN=m
+CONFIG_NLS_MAC_CELTIC=m
+CONFIG_NLS_MAC_CENTEURO=m
+CONFIG_NLS_MAC_CROATIAN=m
+CONFIG_NLS_MAC_CYRILLIC=m
+CONFIG_NLS_MAC_GAELIC=m
+CONFIG_NLS_MAC_GREEK=m
+CONFIG_NLS_MAC_ICELAND=m
+CONFIG_NLS_MAC_INUIT=m
+CONFIG_NLS_MAC_ROMANIAN=m
+CONFIG_NLS_MAC_TURKISH=m
+CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_USER=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
+CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_ECHAINIV=y
+CONFIG_CRYPTO_LRW=y
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+CONFIG_CRYPTO_RMD128=y
+CONFIG_CRYPTO_RMD160=y
+CONFIG_CRYPTO_RMD256=y
+CONFIG_CRYPTO_RMD320=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_SHA3=y
+CONFIG_CRYPTO_TGR192=y
+CONFIG_CRYPTO_WP512=y
+CONFIG_CRYPTO_BLOWFISH=y
+CONFIG_CRYPTO_CAMELLIA=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
+CONFIG_CRYPTO_DEV_SAHARA=y
+CONFIG_CRYPTO_DEV_MXS_DCP=y
+CONFIG_CRC7=m
+CONFIG_CMA_SIZE_MBYTES=320
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_PROVE_LOCKING=y
+# CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/tsimx6ul_defconfig b/arch/arm/configs/tsimx6ul_defconfig
new file mode 100644
index 000000000000..b4e869fb1ed9
--- /dev/null
+++ b/arch/arm/configs/tsimx6ul_defconfig
@@ -0,0 +1,967 @@
+CONFIG_KERNEL_LZO=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CGROUPS=y
+CONFIG_MEMCG=y
+CONFIG_MEMCG_SWAP=y
+# CONFIG_MEMCG_SWAP_ENABLED is not set
+CONFIG_BLK_CGROUP=y
+CONFIG_DEBUG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+# CONFIG_PROC_PID_CPUSET is not set
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_BPF_SYSCALL=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=m
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_LDM_PARTITION=y
+CONFIG_CMDLINE_PARTITION=y
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMX6Q=y
+CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_IMX6SX=y
+CONFIG_SOC_IMX6UL=y
+CONFIG_SOC_IMX7D=y
+CONFIG_SOC_VF610=y
+CONFIG_SMP=y
+CONFIG_VMSPLIT_2G=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
+CONFIG_SECCOMP=y
+CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_BINFMT_MISC=m
+CONFIG_PM_DEBUG=y
+CONFIG_PM_TEST_SUSPEND=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=m
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=m
+CONFIG_XFRM_USER=m
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_FIB_TRIE_STATS=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_NET_IPVTI=m
+CONFIG_NET_FOU_IP_TUNNELS=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_INET_XFRM_MODE_TUNNEL=m
+CONFIG_INET_XFRM_MODE_BEET=m
+CONFIG_INET_UDP_DIAG=m
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_MD5SIG=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_IPV6_MIP6=m
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_XFRM_MODE_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_BEET=m
+CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
+CONFIG_IPV6_VTI=m
+CONFIG_IPV6_SIT=m
+CONFIG_IPV6_SIT_6RD=y
+CONFIG_IPV6_GRE=m
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NETWORK_PHY_TIMESTAMPING=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CONNTRACK_TIMEOUT=y
+CONFIG_NF_CONNTRACK_TIMESTAMP=y
+CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+CONFIG_NF_CONNTRACK_SNMP=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SANE=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_CT_NETLINK_TIMEOUT=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=m
+CONFIG_NFT_EXTHDR=m
+CONFIG_NFT_META=m
+CONFIG_NFT_CT=m
+CONFIG_NFT_COUNTER=m
+CONFIG_NFT_LOG=m
+CONFIG_NFT_LIMIT=m
+CONFIG_NFT_MASQ=m
+CONFIG_NFT_REDIR=m
+CONFIG_NFT_NAT=m
+CONFIG_NFT_QUEUE=m
+CONFIG_NFT_REJECT=m
+CONFIG_NFT_COMPAT=m
+CONFIG_NFT_HASH=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
+CONFIG_NETFILTER_XT_TARGET_HMARK=m
+CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
+CONFIG_NETFILTER_XT_TARGET_LED=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_TEE=m
+CONFIG_NETFILTER_XT_TARGET_SECMARK=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_BPF=m
+CONFIG_NETFILTER_XT_MATCH_CGROUP=m
+CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
+CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_CPU=m
+CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_HELPER=m
+CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_NFACCT=m
+CONFIG_NETFILTER_XT_MATCH_OSF=m
+CONFIG_NETFILTER_XT_MATCH_OWNER=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_RATEEST=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_RECENT=m
+CONFIG_NETFILTER_XT_MATCH_SOCKET=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NETFILTER_XT_MATCH_U32=m
+CONFIG_IP_SET=m
+CONFIG_IP_SET_BITMAP_IP=m
+CONFIG_IP_SET_BITMAP_IPMAC=m
+CONFIG_IP_SET_BITMAP_PORT=m
+CONFIG_IP_SET_HASH_IP=m
+CONFIG_IP_SET_HASH_IPMARK=m
+CONFIG_IP_SET_HASH_IPPORT=m
+CONFIG_IP_SET_HASH_IPPORTIP=m
+CONFIG_IP_SET_HASH_IPPORTNET=m
+CONFIG_IP_SET_HASH_MAC=m
+CONFIG_IP_SET_HASH_NETPORTNET=m
+CONFIG_IP_SET_HASH_NET=m
+CONFIG_IP_SET_HASH_NETNET=m
+CONFIG_IP_SET_HASH_NETPORT=m
+CONFIG_IP_SET_HASH_NETIFACE=m
+CONFIG_IP_SET_LIST_SET=m
+CONFIG_IP_VS=m
+CONFIG_IP_VS_IPV6=y
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_IP_VS_PROTO_UDP=y
+CONFIG_IP_VS_PROTO_ESP=y
+CONFIG_IP_VS_PROTO_AH=y
+CONFIG_IP_VS_PROTO_SCTP=y
+CONFIG_IP_VS_RR=m
+CONFIG_IP_VS_WRR=m
+CONFIG_IP_VS_LC=m
+CONFIG_IP_VS_WLC=m
+CONFIG_IP_VS_FO=m
+CONFIG_IP_VS_LBLC=m
+CONFIG_IP_VS_LBLCR=m
+CONFIG_IP_VS_DH=m
+CONFIG_IP_VS_SH=m
+CONFIG_IP_VS_SED=m
+CONFIG_IP_VS_NQ=m
+CONFIG_IP_VS_FTP=m
+CONFIG_IP_VS_PE_SIP=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_NFT_CHAIN_ROUTE_IPV4=m
+CONFIG_NF_TABLES_ARP=m
+CONFIG_NF_LOG_ARP=m
+CONFIG_NFT_CHAIN_NAT_IPV4=m
+CONFIG_NFT_MASQ_IPV4=m
+CONFIG_NFT_REDIR_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_RPFILTER=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_SYNPROXY=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_NETMAP=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_CLUSTERIP=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_NF_CONNTRACK_IPV6=m
+CONFIG_NFT_CHAIN_ROUTE_IPV6=m
+CONFIG_NFT_CHAIN_NAT_IPV6=m
+CONFIG_NFT_MASQ_IPV6=m
+CONFIG_NFT_REDIR_IPV6=m
+CONFIG_IP6_NF_MATCH_AH=m
+CONFIG_IP6_NF_MATCH_EUI64=m
+CONFIG_IP6_NF_MATCH_FRAG=m
+CONFIG_IP6_NF_MATCH_OPTS=m
+CONFIG_IP6_NF_MATCH_HL=m
+CONFIG_IP6_NF_MATCH_IPV6HEADER=m
+CONFIG_IP6_NF_MATCH_MH=m
+CONFIG_IP6_NF_MATCH_RPFILTER=m
+CONFIG_IP6_NF_MATCH_RT=m
+CONFIG_IP6_NF_TARGET_HL=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_TARGET_SYNPROXY=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_IP6_NF_RAW=m
+CONFIG_IP6_NF_NAT=m
+CONFIG_IP6_NF_TARGET_MASQUERADE=m
+CONFIG_IP6_NF_TARGET_NPT=m
+CONFIG_NF_TABLES_BRIDGE=m
+CONFIG_NFT_BRIDGE_META=m
+CONFIG_NFT_BRIDGE_REJECT=m
+CONFIG_NF_LOG_BRIDGE=m
+CONFIG_BRIDGE_NF_EBTABLES=m
+CONFIG_BRIDGE_EBT_BROUTE=m
+CONFIG_BRIDGE_EBT_T_FILTER=m
+CONFIG_BRIDGE_EBT_T_NAT=m
+CONFIG_BRIDGE_EBT_802_3=m
+CONFIG_BRIDGE_EBT_AMONG=m
+CONFIG_BRIDGE_EBT_ARP=m
+CONFIG_BRIDGE_EBT_IP=m
+CONFIG_BRIDGE_EBT_IP6=m
+CONFIG_BRIDGE_EBT_LIMIT=m
+CONFIG_BRIDGE_EBT_MARK=m
+CONFIG_BRIDGE_EBT_PKTTYPE=m
+CONFIG_BRIDGE_EBT_STP=m
+CONFIG_BRIDGE_EBT_VLAN=m
+CONFIG_BRIDGE_EBT_ARPREPLY=m
+CONFIG_BRIDGE_EBT_DNAT=m
+CONFIG_BRIDGE_EBT_MARK_T=m
+CONFIG_BRIDGE_EBT_REDIRECT=m
+CONFIG_BRIDGE_EBT_SNAT=m
+CONFIG_BRIDGE_EBT_LOG=m
+CONFIG_BRIDGE_EBT_NFLOG=m
+CONFIG_IP_DCCP=m
+CONFIG_IP_SCTP=m
+CONFIG_SCTP_COOKIE_HMAC_SHA1=y
+CONFIG_RDS=m
+CONFIG_RDS_TCP=m
+CONFIG_TIPC=m
+CONFIG_L2TP=m
+CONFIG_L2TP_V3=y
+CONFIG_L2TP_IP=m
+CONFIG_L2TP_ETH=m
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_VLAN_8021Q=m
+CONFIG_LLC2=y
+CONFIG_6LOWPAN=m
+CONFIG_BATMAN_ADV=m
+CONFIG_BATMAN_ADV_MCAST=y
+CONFIG_BATMAN_ADV_DEBUG=y
+CONFIG_OPENVSWITCH=m
+CONFIG_VSOCKETS=m
+CONFIG_NETLINK_DIAG=m
+CONFIG_MPLS_ROUTING=m
+CONFIG_CGROUP_NET_PRIO=y
+CONFIG_BPF_JIT=y
+CONFIG_CAN=y
+CONFIG_CAN_VCAN=m
+CONFIG_CAN_SLCAN=m
+CONFIG_CAN_LEDS=y
+CONFIG_CAN_FLEXCAN=y
+CONFIG_CAN_EMS_USB=m
+CONFIG_CAN_ESD_USB2=m
+CONFIG_CAN_GS_USB=m
+CONFIG_CAN_KVASER_USB=m
+CONFIG_CAN_PEAK_USB=m
+CONFIG_CAN_8DEV_USB=m
+CONFIG_BT=m
+CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=y
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=y
+CONFIG_BT_6LOWPAN=m
+CONFIG_BT_LEDS=y
+CONFIG_BT_HCIBTUSB=m
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_INTEL=y
+CONFIG_BT_HCIUART_BCM=y
+CONFIG_BT_HCIBCM203X=m
+CONFIG_BT_HCIBPA10X=m
+CONFIG_BT_HCIBFUSB=m
+CONFIG_BT_HCIVHCI=m
+CONFIG_BT_MRVL=m
+CONFIG_BT_ATH3K=m
+CONFIG_CFG80211=y
+CONFIG_NL80211_TESTMODE=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=m
+CONFIG_MAC80211_MESH=y
+CONFIG_RFKILL=y
+CONFIG_RFKILL_INPUT=y
+CONFIG_RFKILL_REGULATOR=y
+CONFIG_RFKILL_GPIO=y
+CONFIG_NFC=m
+CONFIG_NFC_DIGITAL=m
+CONFIG_NFC_NCI=m
+CONFIG_NFC_HCI=m
+CONFIG_NFC_TRF7970A=m
+CONFIG_NFC_SIM=m
+CONFIG_NFC_PORT100=m
+CONFIG_NFC_MRVL_USB=m
+CONFIG_NFC_NXP_NCI=m
+CONFIG_NFC_NXP_NCI_I2C=m
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+CONFIG_EXTRA_FIRMWARE="imx/sdma/sdma-imx6q.bin"
+CONFIG_DMA_CMA=y
+CONFIG_IMX_WEIM=y
+CONFIG_TSPC104=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+# CONFIG_MTD_OF_PARTS is not set
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=m
+CONFIG_MTD_CFI_INTELEXT=m
+CONFIG_MTD_CFI_AMDSTD=m
+CONFIG_MTD_CFI_STAA=m
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_OF_OVERLAY=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_AT25=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=m
+CONFIG_CHR_DEV_SG=m
+CONFIG_CHR_DEV_SCH=m
+CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_IMX=y
+CONFIG_PATA_IMX=y
+CONFIG_NETDEVICES=y
+CONFIG_BONDING=m
+CONFIG_NET_TEAM=m
+CONFIG_NET_TEAM_MODE_BROADCAST=m
+CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
+CONFIG_NET_TEAM_MODE_RANDOM=m
+CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
+CONFIG_NET_TEAM_MODE_LOADBALANCE=m
+CONFIG_MACVLAN=m
+CONFIG_MACVTAP=m
+CONFIG_VXLAN=m
+CONFIG_GENEVE=m
+CONFIG_NETCONSOLE=m
+CONFIG_TUN=m
+CONFIG_VETH=m
+CONFIG_NLMON=m
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_MICREL_PHY=y
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPPOE=m
+CONFIG_PPTP=m
+CONFIG_PPPOL2TP=m
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_SLIP=m
+CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLIP_SMART=y
+CONFIG_USB_CATC=m
+CONFIG_USB_KAWETH=m
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+CONFIG_USB_RTL8152=m
+CONFIG_USB_NET_CDC_EEM=m
+CONFIG_USB_NET_HUAWEI_CDC_NCM=m
+CONFIG_USB_NET_CDC_MBIM=m
+CONFIG_USB_NET_DM9601=m
+CONFIG_USB_NET_SR9700=m
+CONFIG_USB_NET_SR9800=m
+CONFIG_USB_NET_SMSC75XX=m
+CONFIG_USB_NET_SMSC95XX=m
+CONFIG_USB_NET_GL620A=m
+CONFIG_USB_NET_PLUSB=m
+CONFIG_USB_NET_MCS7830=m
+CONFIG_USB_NET_CX82310_ETH=m
+CONFIG_USB_NET_KALMIA=m
+CONFIG_USB_NET_QMI_WWAN=m
+CONFIG_USB_HSO=m
+CONFIG_USB_NET_INT51X1=m
+CONFIG_USB_IPHETH=m
+CONFIG_USB_SIERRA_NET=m
+CONFIG_USB_VL600=m
+CONFIG_ATH9K=m
+CONFIG_ATH9K_HTC=m
+CONFIG_CARL9170=m
+CONFIG_CARL9170_HWRNG=y
+CONFIG_ATH6KL=m
+CONFIG_ATH6KL_USB=m
+CONFIG_AR5523=m
+CONFIG_ATH10K=m
+CONFIG_WCN36XX=m
+CONFIG_AT76C50X_USB=m
+CONFIG_P54_COMMON=m
+CONFIG_P54_USB=m
+CONFIG_WILC_SPI=m
+CONFIG_RT2X00=m
+CONFIG_RT2500USB=m
+CONFIG_RT73USB=m
+CONFIG_RT2800USB=m
+CONFIG_RT2800USB_RT3573=y
+CONFIG_RT2800USB_RT53XX=y
+CONFIG_RT2800USB_RT55XX=y
+CONFIG_RT2800USB_UNKNOWN=y
+CONFIG_RTL8187=m
+CONFIG_RTL8192CU=m
+# CONFIG_RTLWIFI_DEBUG is not set
+CONFIG_RSI_91X=m
+# CONFIG_RSI_DEBUGFS is not set
+# CONFIG_RSI_SDIO is not set
+CONFIG_USB_ZD1201=m
+CONFIG_ZD1211RW=m
+CONFIG_USB_NET_RNDIS_WLAN=m
+CONFIG_INPUT_POLLDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_JOYDEV=m
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=m
+CONFIG_KEYBOARD_MATRIX=m
+CONFIG_KEYBOARD_SNVS_PWRKEY=y
+CONFIG_MOUSE_PS2=m
+CONFIG_MOUSE_PS2_ELANTECH=y
+CONFIG_MOUSE_APPLETOUCH=m
+CONFIG_MOUSE_BCM5974=m
+CONFIG_MOUSE_SYNAPTICS_USB=m
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MMA8450=m
+CONFIG_SERIO_SERPORT=m
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_N_GSM=m
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_NR_UARTS=24
+CONFIG_SERIAL_8250_RUNTIME_UARTS=24
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_FSL_OTP=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+CONFIG_I2C_ALGOPCF=m
+CONFIG_I2C_ALGOPCA=m
+CONFIG_I2C_GPIO=y
+CONFIG_I2C_IMX=y
+CONFIG_I2C_OCORES=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_SPI_IMX=y
+CONFIG_SPI_OCORES=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_HSI=m
+CONFIG_HSI_CHAR=m
+CONFIG_PPS_CLIENT_LDISC=m
+CONFIG_PPS_CLIENT_GPIO=m
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_TS71XXWEIM=y
+CONFIG_GPIO_MAX732X=m
+CONFIG_GPIO_PCA953X=m
+CONFIG_GPIO_PCF857X=m
+CONFIG_GPIO_TS4900=y
+CONFIG_GPIO_74X164=y
+CONFIG_W1=m
+CONFIG_W1_MASTER_MXC=m
+CONFIG_W1_MASTER_GPIO=m
+CONFIG_W1_SLAVE_THERM=m
+CONFIG_W1_SLAVE_SMEM=m
+CONFIG_W1_SLAVE_DS2408=m
+CONFIG_W1_SLAVE_DS2413=m
+CONFIG_W1_SLAVE_DS2406=m
+CONFIG_W1_SLAVE_DS2423=m
+CONFIG_W1_SLAVE_DS2431=m
+CONFIG_W1_SLAVE_DS2433=m
+CONFIG_W1_SLAVE_DS2760=m
+CONFIG_W1_SLAVE_DS2780=m
+CONFIG_W1_SLAVE_DS2781=m
+CONFIG_W1_SLAVE_DS28E04=m
+CONFIG_W1_SLAVE_BQ27000=m
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
+CONFIG_IMX_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_TS_WDT_MICRO=y
+CONFIG_TS7100_WATCHDOG=y
+CONFIG_IMX2_WDT=y
+CONFIG_MFD_DA9052_I2C=y
+CONFIG_MFD_MC13XXX_SPI=y
+CONFIG_MFD_MC13XXX_I2C=y
+CONFIG_MFD_SI476X_CORE=y
+CONFIG_MFD_STMPE=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_ANATOP=y
+CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MC13783=y
+CONFIG_REGULATOR_MC13892=y
+CONFIG_REGULATOR_PFUZE100=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_RADIO_SUPPORT=y
+CONFIG_MEDIA_RC_SUPPORT=y
+CONFIG_RC_DEVICES=y
+CONFIG_IR_GPIO_CIR=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
+CONFIG_USB_M5602=m
+CONFIG_USB_STV06XX=m
+CONFIG_USB_GL860=m
+CONFIG_USB_GSPCA_BENQ=m
+CONFIG_USB_GSPCA_CONEX=m
+CONFIG_USB_GSPCA_CPIA1=m
+CONFIG_USB_GSPCA_DTCS033=m
+CONFIG_USB_GSPCA_ETOMS=m
+CONFIG_USB_GSPCA_FINEPIX=m
+CONFIG_USB_GSPCA_JEILINJ=m
+CONFIG_USB_GSPCA_JL2005BCD=m
+CONFIG_USB_GSPCA_KINECT=m
+CONFIG_USB_GSPCA_KONICA=m
+CONFIG_USB_GSPCA_MARS=m
+CONFIG_USB_GSPCA_MR97310A=m
+CONFIG_USB_GSPCA_NW80X=m
+CONFIG_USB_GSPCA_OV519=m
+CONFIG_USB_GSPCA_OV534=m
+CONFIG_USB_GSPCA_OV534_9=m
+CONFIG_USB_GSPCA_PAC207=m
+CONFIG_USB_GSPCA_PAC7302=m
+CONFIG_USB_GSPCA_PAC7311=m
+CONFIG_USB_GSPCA_SE401=m
+CONFIG_USB_GSPCA_SN9C2028=m
+CONFIG_USB_GSPCA_SN9C20X=m
+CONFIG_USB_GSPCA_SONIXB=m
+CONFIG_USB_GSPCA_SONIXJ=m
+CONFIG_USB_GSPCA_SPCA500=m
+CONFIG_USB_GSPCA_SPCA501=m
+CONFIG_USB_GSPCA_SPCA505=m
+CONFIG_USB_GSPCA_SPCA506=m
+CONFIG_USB_GSPCA_SPCA508=m
+CONFIG_USB_GSPCA_SPCA561=m
+CONFIG_USB_GSPCA_SPCA1528=m
+CONFIG_USB_GSPCA_SQ905=m
+CONFIG_USB_GSPCA_SQ905C=m
+CONFIG_USB_GSPCA_SQ930X=m
+CONFIG_USB_GSPCA_STK014=m
+CONFIG_USB_GSPCA_STK1135=m
+CONFIG_USB_GSPCA_STV0680=m
+CONFIG_USB_GSPCA_SUNPLUS=m
+CONFIG_USB_GSPCA_T613=m
+CONFIG_USB_GSPCA_TOPRO=m
+CONFIG_USB_GSPCA_TOUPTEK=m
+CONFIG_USB_GSPCA_TV8532=m
+CONFIG_USB_GSPCA_VC032X=m
+CONFIG_USB_GSPCA_VICAM=m
+CONFIG_USB_GSPCA_XIRLINK_CIT=m
+CONFIG_USB_GSPCA_ZC3XX=m
+CONFIG_USB_PWC=m
+CONFIG_VIDEO_CPIA2=m
+CONFIG_USB_ZR364XX=m
+CONFIG_USB_STKWEBCAM=m
+CONFIG_USB_S2255=m
+CONFIG_VIDEO_USBTV=m
+CONFIG_VIDEO_EM28XX=m
+CONFIG_VIDEO_EM28XX_V4L2=m
+CONFIG_VIDEO_EM28XX_ALSA=m
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=y
+CONFIG_RADIO_SI476X=y
+CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_DRM=y
+CONFIG_FB_MXS=y
+CONFIG_FB_ST7565P=m
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_L4F00242T03=y
+CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_FRAMEBUFFER_CONSOLE=m
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_USB_AUDIO=m
+CONFIG_SND_SOC=y
+CONFIG_SND_IMX_SOC=y
+CONFIG_SND_SOC_EUKREA_TLV320=y
+CONFIG_SND_SOC_IMX_WM8962=y
+CONFIG_SND_SOC_IMX_SGTL5000=y
+CONFIG_SND_SOC_IMX_SPDIF=y
+CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_USB=y
+CONFIG_USB_OTG_WHITELIST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_HCD_TEST_MODE=y
+CONFIG_USB_PRINTER=m
+CONFIG_USB_TMC=m
+CONFIG_USB_STORAGE=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_GENERIC=y
+CONFIG_USB_SERIAL_SIMPLE=m
+CONFIG_USB_SERIAL_AIRCABLE=m
+CONFIG_USB_SERIAL_ARK3116=m
+CONFIG_USB_SERIAL_BELKIN=m
+CONFIG_USB_SERIAL_CH341=m
+CONFIG_USB_SERIAL_WHITEHEAT=m
+CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
+CONFIG_USB_SERIAL_CP210X=m
+CONFIG_USB_SERIAL_CYPRESS_M8=m
+CONFIG_USB_SERIAL_EMPEG=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_VISOR=m
+CONFIG_USB_SERIAL_IPAQ=m
+CONFIG_USB_SERIAL_IR=m
+CONFIG_USB_SERIAL_EDGEPORT=m
+CONFIG_USB_SERIAL_EDGEPORT_TI=m
+CONFIG_USB_SERIAL_F81232=m
+CONFIG_USB_SERIAL_GARMIN=m
+CONFIG_USB_SERIAL_IPW=m
+CONFIG_USB_SERIAL_IUU=m
+CONFIG_USB_SERIAL_KEYSPAN_PDA=m
+CONFIG_USB_SERIAL_KEYSPAN=m
+CONFIG_USB_SERIAL_KLSI=m
+CONFIG_USB_SERIAL_KOBIL_SCT=m
+CONFIG_USB_SERIAL_MCT_U232=m
+CONFIG_USB_SERIAL_METRO=m
+CONFIG_USB_SERIAL_MOS7720=m
+CONFIG_USB_SERIAL_MOS7840=m
+CONFIG_USB_SERIAL_MXUPORT=m
+CONFIG_USB_SERIAL_NAVMAN=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_USB_SERIAL_OTI6858=m
+CONFIG_USB_SERIAL_QCAUX=m
+CONFIG_USB_SERIAL_QUALCOMM=m
+CONFIG_USB_SERIAL_SPCP8X5=m
+CONFIG_USB_SERIAL_SAFE=m
+CONFIG_USB_SERIAL_SIERRAWIRELESS=m
+CONFIG_USB_SERIAL_SYMBOL=m
+CONFIG_USB_SERIAL_TI=m
+CONFIG_USB_SERIAL_CYBERJACK=m
+CONFIG_USB_SERIAL_XIRCOM=m
+CONFIG_USB_SERIAL_OPTION=m
+CONFIG_USB_SERIAL_OMNINET=m
+CONFIG_USB_SERIAL_OPTICON=m
+CONFIG_USB_SERIAL_XSENS_MT=m
+CONFIG_USB_SERIAL_WISHBONE=m
+CONFIG_USB_SERIAL_SSU100=m
+CONFIG_USB_SERIAL_QT2=m
+CONFIG_USB_SERIAL_DEBUG=m
+CONFIG_USB_EMI62=m
+CONFIG_USB_EMI26=m
+CONFIG_USB_ADUTUX=m
+CONFIG_USB_SEVSEG=m
+CONFIG_USB_LEGOTOWER=m
+CONFIG_USB_LCD=m
+CONFIG_USB_CYPRESS_CY7C63=m
+CONFIG_USB_CYTHERM=m
+CONFIG_USB_IDMOUSE=m
+CONFIG_USB_FTDI_ELAN=m
+CONFIG_USB_LD=m
+CONFIG_USB_EHSET_TEST_FIXTURE=y
+CONFIG_USB_YUREX=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_MXS_PHY=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_UAC1=y
+CONFIG_USB_CONFIGFS_F_UAC2=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_CONFIGFS_F_UVC=y
+CONFIG_USB_CONFIGFS_F_PRINTER=y
+CONFIG_USB_ZERO=m
+CONFIG_USB_AUDIO=m
+CONFIG_USB_ETH=m
+CONFIG_USB_G_NCM=m
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FUNCTIONFS=m
+CONFIG_USB_FUNCTIONFS_ETH=y
+CONFIG_USB_FUNCTIONFS_RNDIS=y
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_USB_G_SERIAL=m
+CONFIG_USB_MIDI_GADGET=m
+CONFIG_USB_G_PRINTER=m
+CONFIG_USB_CDC_COMPOSITE=m
+CONFIG_USB_G_ACM_MS=m
+CONFIG_USB_G_HID=m
+CONFIG_USB_G_WEBCAM=m
+CONFIG_USB_LED_TRIG=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
+CONFIG_LEDS_TRIGGER_TRANSIENT=m
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_MC13XXX=y
+CONFIG_RTC_DRV_MXC=y
+CONFIG_RTC_DRV_SNVS=y
+CONFIG_DMADEVICES=y
+CONFIG_IMX_SDMA=y
+CONFIG_MXS_DMA=y
+CONFIG_DMATEST=m
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_IIO_BUFFER_CB=y
+CONFIG_IIO_SW_DEVICE=y
+CONFIG_IIO_SW_TRIGGER=y
+CONFIG_MMA8452=m
+CONFIG_IMX7D_ADC=m
+CONFIG_TS_SIMPLEADC=y
+CONFIG_VF610_ADC=y
+CONFIG_INV_MPU6050_I2C=m
+CONFIG_ST_ISM330DLC_IIO=m
+CONFIG_ST_ISM330DLC_XL_DATA_INJECTION=y
+CONFIG_AK8975=m
+CONFIG_IIO_ST_MAGN_3AXIS=m
+CONFIG_ST_MAG40_IIO=m
+CONFIG_IIO_HRTIMER_TRIGGER=y
+CONFIG_IIO_INTERRUPT_TRIGGER=y
+CONFIG_IIO_TIGHTLOOP_TRIGGER=y
+CONFIG_IIO_SYSFS_TRIGGER=y
+CONFIG_PWM=y
+CONFIG_PWM_IMX=y
+CONFIG_TSWEIM_FPGA_INTC=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_XFS_FS=m
+CONFIG_F2FS_FS=m
+CONFIG_FANOTIFY=y
+CONFIG_QUOTA=y
+CONFIG_QUOTA_NETLINK_INTERFACE=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=m
+CONFIG_OVERLAY_FS=y
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_NTFS_FS=m
+CONFIG_NTFS_RW=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V4=y
+CONFIG_CIFS=m
+# CONFIG_CIFS_DEBUG is not set
+CONFIG_CIFS_SMB2=y
+CONFIG_NLS_DEFAULT="cp437"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=m
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+CONFIG_SECURITYFS=y
+CONFIG_CRYPTO_USER=y
+CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_CTS=y
+CONFIG_CRYPTO_LRW=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MICHAEL_MIC=y
+CONFIG_CRYPTO_RMD128=y
+CONFIG_CRYPTO_RMD160=y
+CONFIG_CRYPTO_RMD256=y
+CONFIG_CRYPTO_RMD320=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_TGR192=y
+CONFIG_CRYPTO_WP512=y
+CONFIG_CRYPTO_ARC4=y
+CONFIG_CRYPTO_BLOWFISH=y
+CONFIG_CRYPTO_CAMELLIA=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_TWOFISH=y
+CONFIG_CRYPTO_DEFLATE=y
+CONFIG_CRYPTO_LZO=y
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
+CONFIG_CRYPTO_DEV_MXS_DCP=y
+CONFIG_CRC_T10DIF=y
+CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
-- 
2.11.0

