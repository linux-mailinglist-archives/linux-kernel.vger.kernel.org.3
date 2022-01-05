Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A49484C94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiAECtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:49:23 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137]:38241 "EHLO
        out162-62-57-137.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbiAECtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641350958;
        bh=DiR89cuqK5nwQkdSsy0jlBGAmICzO/O7TboVT/RXNfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WNQgs5EjmwYwucBwitqK70t212J7FHHaQYuvnZZwfBtpksN+GfD6F/p1kPff1pW1x
         h1h2Ay5EUub9nqjpFPKZeWQJgNEc0ed6E+tL4UoSS9Um3ljtL4JFl2JzfQo2N6cWHt
         9uCjEK7LEhXPK86wa2XEDhNVFgn28RSspW5Nd/X8=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id B750F492; Wed, 05 Jan 2022 10:45:53 +0800
X-QQ-mid: xmsmtpt1641350753tsskxxku7
Message-ID: <tencent_13C536D91764B05D794CBCF3156C963E6C0A@qq.com>
X-QQ-XMAILINFO: MOCbvwhB0vcJQ+8wG9wgzxHzXmU1fLT1HaqIWxKnj4pm3oI3OBNt8u4XEl0vXW
         ELpnpGu9jC2DCoPI9WNN6hiKSv6QiO4/djV2pBLEsl+K7SJXllIZxyVMTGoMKBzB957bK+5ehHHu
         pL9vhvSs1v0NgWSCEvImhpGhXCTEMwr19rry2T6IikwGBoTLmGNNV31x+loxV0IDfCFotKfd3/iT
         9vphfoUyYQbV4nLysh1+4E/izet8X6iN7oKxx3KFCKD73kXMkw3CfTsxmfKzSvBUu/XNZupbSZ26
         5Fl/yfK/05Lyb874nd8evjLtkfUP2VIFbuurBf3FzWh8MzvF5Geqzc7kO0eM4T+7qftNGHLrzjBf
         19bHaKxV6DXRotSwfGsuaYdsB+gM+cp5Vd0EZnIHhjEWWghBILURvN/E6vueLpQfg4dt7xa8Lufj
         Ng2hU82BrhqEPDMZeHKHathhYp2uxcHsBJcc9P+DZs/3BDIBJECZ+3sO0F1h4Y1PZe0ZVyzlwnyL
         6QLyafY3bKRWGETYe1FPvVtejzdOIU9J8ttdbSq2/wbancdPW3LZvb8Voho5q6HY6ROj0T+GTPe5
         nrpPxim9hF6mQLPVqi195fusbqz0TqiqQ04jgPrHudbYpvcyt/SkyeNNgdpVyneNPD28yqMQmdqX
         wRhLebWC8ylpmMM8usYMJr3qO46hmGB1ZlsW8CBKbFhT1KL9gPBRmQvEiBWp8f9c8KqpgfDy7Mb6
         0uSp5TDEMmD02HdWcpdt5c28jcrl6HcrZJCoOWusD3rf/lKlimOCGx5XmOTTC3HQId7wfyVLOE6c
         IpUTvoXZLMD9J8OLxIeD9RuZZJmj6hLUOuBFrLsfLkFVGg4TCjnpyJ/WYZNWysUvdNjdnl+2NiDT
         7a5fAhJAN3IdX2nki/CqZX+7iqWL2Oe0uiDJQmQTO5
From:   conleylee@foxmail.com
To:     robh@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, conley <conleylee@foxmail.com>
Subject: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20 support
Date:   Wed,  5 Jan 2022 10:45:50 +0800
X-OQ-MSGID: <20220105024551.807713-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: conley <conleylee@foxmail.com>

ARM dts: sun7i: Add Marsboard A20 board

This patch add support for Marsboard A20 board.

The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.

Change since v1.
  - Spearate biddings and dts as two patches.
  - use SPDX tag

Signed-off-by: conley <conleylee@foxmail.com>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/sun7i-a20-marsboard.dts | 183 ++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..4628a2617313 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-lamobo-r1.dtb \
 	sun7i-a20-linutronix-testbox-v2.dtb \
+	sun7i-a20-marsboard.dtb \
 	sun7i-a20-m3.dtb \
 	sun7i-a20-mk808c.dtb \
 	sun7i-a20-olimex-som-evb.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-marsboard.dts b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
new file mode 100644
index 000000000000..7ab6aa30fee6
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/*
+ * Copyright 2021 Conley Lee
+ * Conley Lee <conleylee@foxmail.com>
+ */
+
+/dts-v1/;
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "HAOYU Electronics Marsboard A20";
+	compatible = "haoyu,a20-marsboard", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&gmac_mii_pins {
+	pins = "PA0", "PA1", "PA2",
+	"PA3", "PA4", "PA5", "PA6",
+	"PA7", "PA8", "PA9", "PA10",
+	"PA11", "PA12", "PA13", "PA14",
+	"PA15", "PA16", "PA17";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>;
+	phy-handle = <&phy0>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
+	status = "okay";
+};
+
+&gmac_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.31.1

