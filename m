Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2757B915
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiGTPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiGTPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:00:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93B17E28;
        Wed, 20 Jul 2022 08:00:23 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c30a:1501:bcb3:2103:84e3:6894])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E34FE6601A8F;
        Wed, 20 Jul 2022 16:00:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658329222;
        bh=ZT4cFyqcVdFLVjorT28dEn6ptSg7SyL2a7gJdPqUrzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6h5gb0C6j2gt/LMVIaamv8aJpuThEA7NfICYWpjfFd6WeDtMfEoSD1/3yrbia62x
         QoytQhDO5z5Vy29K3yG2mhwnUnBjepHgAypXXN/6MR4UyH974BysI8AZ8UnltM6bud
         SfSJb+SfVC/yluKA+tRDFf6kxGypKobsx03Sm7cQPY4YRwGf5CNwUXYbu/u9GzGiaB
         MFhojdsmOi8LxEhw/hgw8NvQGZxJhObc4ozfXyUenIpK3hzo8jt+QnWjjLNCevsyTH
         wqT2yvTkmvypICNj6Cmelj6RuQTiW5SJ1cyurZgy841E/s6zAm9JWRQLX8rQPDWeBb
         3P/zIsLZvHLeA==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] arm64: dts: sm2s-imx8mp: Add device trees for MSC SM2S-IMX8PLUS SoM and carrier board
Date:   Wed, 20 Jul 2022 16:00:05 +0100
Message-Id: <20220720150007.2168051-3-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720150007.2168051-1-martyn.welch@collabora.com>
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device trees for one of a number of MSCs variants of the SM2S-IMX8PLUS
system on module along with the compatible SM2S-SK-AL-EP1 carrier board.
As the name suggests, this family of SoMs use the NXP i.MX8MP SoC and
provide the SMARC module interface.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes in v2
  - Added compatibles
  - Removed underscores from node names
  - Make node names more generic
  - Reorder properties
  - Fix issues found by dtbs_check in these files

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-msc-sm2s-14N0600E.dts    |  72 ++
 .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     |  52 ++
 .../boot/dts/freescale/imx8mp-msc-sm2s.dtsi   | 820 ++++++++++++++++++
 4 files changed, 945 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 238a83e5b8c6..2484d646c6da 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
new file mode 100644
index 000000000000..d5617cd233d5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Avnet Embedded GmbH
+ */
+/dts-v1/;
+
+#include "imx8mp-msc-sm2s.dtsi"
+
+/ {
+	model = "MSC SM2S-IMX8PLUS-QC6-14N0600E SoM";
+	compatible = "msc,sm2s-imx8mp-14N0600E", "msc,sm2s-imx8mp",
+		     "fsl,imx8mp";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>; /* bank0, 2GiB */
+	};
+};
+
+&cpu_alert0 {
+	temperature = <95000>;
+};
+
+&cpu_crit0 {
+	temperature = <105000>;
+};
+
+&soc_alert0 {
+	temperature = <95000>;
+};
+
+&soc_crit0 {
+	temperature = <105000>;
+};
+
+&tca6424 {
+	gbe0-int-hog {
+		gpio-hog;
+		input;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+	};
+
+	gbe1-int-hog {
+		gpio-hog;
+		input;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+	};
+
+	cam2-rst-hog {
+		gpio-hog;
+		output-high;
+		gpios = <9 GPIO_ACTIVE_LOW>;
+	};
+
+	cam2-pwr-hog {
+		gpio-hog;
+		output-high;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+	};
+
+	tpm-int-hog {
+		gpio-hog;
+		input;
+		gpios = <13 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi-int-hog {
+		gpio-hog;
+		input;
+		gpios = <14 GPIO_ACTIVE_LOW>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
new file mode 100644
index 000000000000..de83c0e3b35c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Avnet Embedded GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mp-msc-sm2s-14N0600E.dts"
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "MSC SM2-MB-EP1 Carrier Board with SM2S-IMX8PLUS-QC6-14N0600E SoM";
+	compatible = "msc,sm2s-imx8mp-14N0600E-ep1", "msc,sm2s-imx8mp-14N0600E",
+		     "msc,sm2s-imx8mp", "fsl,imx8mp";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&flexcan2 {
+	status = "okay";
+};
+
+&usdhc2 {
+	no-1-8-v;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_smarc_gpio>;
+
+	pinctrl_smarc_gpio: smarcgpiosgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x19>, /* GPIO0 */
+			<MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01	0x19>, /* GPIO1 */
+			<MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x19>, /* GPIO2 */
+			<MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x19>, /* GPIO3 */
+			<MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x19>, /* GPIO4 */
+			<MX8MP_IOMUXC_SAI3_MCLK__GPIO5_IO02	0x19>, /* GPIO5 */
+			<MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x19>, /* GPIO6 */
+			<MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x19>, /* GPIO7 */
+			<MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x19>, /* GPIO8 */
+			<MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x19>, /* GPIO9 */
+			<MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x19>, /* GPIO10 */
+			<MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x19>, /* GPIO11 */
+			<MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x19>, /* GPIO12 */
+			<MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19>; /* GPIO13 */
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
new file mode 100644
index 000000000000..0c45921b5c58
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s.dtsi
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Avnet Embedded GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	aliases {
+		rtc0 = &sys_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	reg_usb0_host_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0_host_vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_vbus>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb1_host_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_host_vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_vbus>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100>;
+		off-on-delay-us = <12000>;
+	};
+
+	reg_flexcan1_xceiver: regulator-flexcan1 {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan1-xceiver";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+	};
+
+	reg_flexcan2_xceiver: regulator-flexcan2 {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan2-xceiver";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+	};
+
+	lcd0_backlight: backlight-0 {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_backlight>;
+		pwms = <&pwm1 0 100000 0>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <255>;
+		enable-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	lcd1_backlight: backlight-1 {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd1_backlight>;
+		pwms = <&pwm2 0 100000 0>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <255>;
+		enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+		status = "okay";
+
+		led-sw {
+			label = "sw-led";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	extcon_usb0: extcon-usb0 {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_extcon>;
+		id-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&vcc_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&vcc_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&vcc_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&vcc_arm>;
+};
+
+&ecspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <0>, <&gpio2 8 GPIO_ACTIVE_LOW>;
+};
+
+&ecspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <0>, <&gpio2 9 GPIO_ACTIVE_LOW>;
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
+	phy-reset-post-delay = <1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			phy-reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
+
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
+	phy-reset-post-delay = <1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			phy-reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
+
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	id_eeprom: eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <400000>;
+	status = "disabled";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "disabled";
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <400000>;
+	status = "disabled";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5>;
+	clock-frequency = <400000>;
+	status = "disabled";
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c6>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tca6424: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tca6424>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "BOOT_SEL0#", "BOOT_SEL1#", "BOOT_SEL2#",
+			"gbe0_int", "gbe1_int", "pmic_int", "rtc_int", "lvds_int",
+			"PCIE_WAKE#", "cam2_rst", "cam2_pwr", "SLEEP#",
+			"wifi_pd", "tpm_int", "wifi_int", "PCIE_A_RST#",
+			"gbe0_rst", "gbe1_rst", "LID#", "BATLOW#", "CHARGING#",
+			"CHARGER_PRSNT#";
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	dsi_lvds_bridge: bridge@2d {
+		compatible = "ti,sn65dsi83";
+		reg = <0x2d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvds_bridge>;
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	pmic: pmic@30 {
+		compatible = "ricoh,rn5t567";
+		reg = <0x30>;
+		interrupt-parent = <&tca6424>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			DCDC1 {
+				regulator-name = "VCC_SOC";
+				regulator-always-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <950000>;
+			};
+			DCDC2 {
+				regulator-name = "VCC_DRAM";
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+			};
+			vcc_arm: DCDC3 {
+				regulator-name = "VCC_ARM";
+				regulator-always-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <950000>;
+			};
+			DCDC4 {
+				regulator-name = "VCC_1V8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			LDO1 {
+				regulator-name = "VCC_LDO1_2V5";
+				regulator-always-on;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+			};
+			LDO2 {
+				regulator-name = "VCC_LDO2_1V8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			LDO3 {
+				regulator-name = "VCC_ETH_2V5";
+				regulator-always-on;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+			};
+			LDO4 {
+				regulator-name = "VCC_DDR4_2V5";
+				regulator-always-on;
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+			};
+			LDO5 {
+				regulator-name = "VCC_LDO5_1V8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			LDORTC1 {
+				regulator-name = "VCC_SNVS_1V8";
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			LDORTC2 {
+				regulator-name = "VCC_SNVS_3V3";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+
+	sys_rtc: rtc@32 {
+		compatible = "ricoh,r2221tl";
+		reg = <0x32>;
+		interrupt-parent = <&tca6424>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	tmp_sensor: temperature-sensor@71 {
+		compatible = "ti,tmp103";
+		reg = <0x71>;
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_flexcan1_xceiver>;
+	status = "disabled";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_flexcan2_xceiver>;
+	status = "disabled";
+};
+
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	qspi_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "disabled";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "disabled";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "disabled";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "disabled";
+};
+
+&sdma1 {
+	status = "okay";
+};
+
+&snvs_pwrkey {
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
+	uart-has-rtscts;
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
+	status = "disabled";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb0_host_vbus>;
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&reg_usb1_host_vbus>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	extcon = <&extcon_usb0>;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <400000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&usdhc3 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x82>,
+			<MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x82>,
+			<MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x82>,
+			<MX8MP_IOMUXC_ECSPI1_SS0__ECSPI1_SS0		0x40000>,
+			<MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x40000>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82>,
+			<MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82>,
+			<MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82>,
+			<MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000>,
+			<MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x40000>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3>,
+			<MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3>,
+			<MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91>,
+			<MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91>,
+			<MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91>,
+			<MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91>,
+			<MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91>,
+			<MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91>,
+			<MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f>,
+			<MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f>,
+			<MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f>,
+			<MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f>,
+			<MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f>,
+			<MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3>,
+			<MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3>,
+			<MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0	0x91>,
+			<MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1	0x91>,
+			<MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2	0x91>,
+			<MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3	0x91>,
+			<MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91>,
+			<MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91>,
+			<MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0	0x1f>,
+			<MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1	0x1f>,
+			<MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2	0x1f>,
+			<MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3	0x1f>,
+			<MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f>,
+			<MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC	0x1f>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154>,
+			<MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154>,
+			<MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154>;
+	};
+
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2>,
+			<MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82>,
+			<MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82>,
+			<MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82>,
+			<MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82>,
+			<MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82>,
+			<MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x19>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3>;
+	};
+
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c3>;
+	};
+
+	pinctrl_i2c6: i2c6grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001c3>,
+			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3>;
+	};
+
+	pinctrl_lcd0_backlight: lcd0-backlightgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x41>;
+	};
+
+	pinctrl_lcd1_backlight: lcd1-backlightgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x41>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x19>;
+	};
+
+	pinctrl_lvds_bridge: lvds-bridgegrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x41>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT		0x116>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT		0x116>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO10__PWM3_OUT		0x116>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT		0x116>;
+	};
+
+	pinctrl_tca6424: tca6424grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x41>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x49>,
+			<MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x49>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06		0x1c4>,
+			<MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07		0x1c4>,
+			<MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49>,
+			<MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x1c4>,
+			<MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x1c4>,
+			<MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX		0x49>,
+			<MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX		0x49>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x49>,
+			<MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x49>;
+	};
+
+	pinctrl_usb0_extcon: usb0-extcongrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x19>;
+	};
+
+	pinctrl_usb0_vbus: usb0-vbusgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x19>;
+	};
+
+	pinctrl_usb1_vbus: usb1-vbusgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x19>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x1c4>,
+			<MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x1c4>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190>,
+			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0>,
+			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0>,
+			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0>,
+			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0>,
+			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0>,
+			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc2_vmmc: usdhc2-vmmcgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194>,
+			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4>,
+			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4>,
+			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4>,
+			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4>,
+			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4>,
+			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196>,
+			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6>,
+			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6>,
+			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6>,
+			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6>,
+			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6>,
+			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins =
+			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190>,
+			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0>,
+			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0>,
+			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0>,
+			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0>,
+			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0>,
+			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0>,
+			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0>,
+			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0>,
+			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0>,
+			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194>,
+			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4>,
+			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4>,
+			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4>,
+			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4>,
+			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4>,
+			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4>,
+			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4>,
+			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4>,
+			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4>,
+			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196>,
+			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6>,
+			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6>,
+			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6>,
+			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6>,
+			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6>,
+			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6>,
+			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6>,
+			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6>,
+			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6>,
+			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins =
+			<MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6>;
+	};
+};
-- 
2.35.1

