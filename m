Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD548EE26
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiANQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:33:10 -0500
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202]:59084 "EHLO
        out203-205-221-202.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbiANQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642177988;
        bh=bLy2QEgkt0p3V8bap4bKp9o2urCKFEbv7K1Eu4iH0AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VFm+StM03jig2F9onMND9lwosoJFKUa/I6Uu9ddXyCEcN/jALaX1zxDepa1WrPETG
         U6juj1wXbDLtrLsghqjdE16xik9SQqKFrrvUQNC/RCtZFhHEPEO8V9KFZ6qX6waz82
         IEal7we/jfGaIw5VcqmB23owBvv04BWrVcnqHAGQ=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 7F1958D8; Sat, 15 Jan 2022 00:31:49 +0800
X-QQ-mid: xmsmtpt1642177909tu68gz60g
Message-ID: <tencent_C2E26D0935C9157CB3597BA4BD3316E8940A@qq.com>
X-QQ-XMAILINFO: OLJT8zSTI41RbFnZZ/zp4LtNjEnirvFiCNomzyTEwUAH/RaYQwDAf98TAJ0PKz
         kNgGVF0A9h4YOXL1wM+zunpPoyb5RxaLxE2h1B1TpZ0iAHLjMA+THc97dCc/frYio3DCuE1SXWS7
         a8cP7pRthLeGrM00P/ym1k3tJlZPafRH8uoDAJHsyC6dMGMfEOBBbcKK7npyeWhWM0XX1+/awwHO
         Oi7a0I/tVpuVPIyyNWoKn576hwmjgldCz2dPfCCaOfjW5bF61eHukXdnmnc7/Ww0LneJ/Ld3vDGo
         UKMBnHYDpWnG3jDRhbQYMjlJk3GIbTNtqd5CS69S//Ckfq2LWAoKzKauguZwS29vtsNyrQgkeOKv
         c8y/yPRGe2+ncEMvJqIthozEmt7lcjxo6KKcdTE255R4o2s1l3dquHoxAv38RO9zUcbyKi1tI6jQ
         BzrfaVurqTzvFWqdyklRFaSsZTpHD4gySOvyBm3BX/mskxB9W9aEBjb7t5wU1KxX6pQkXbMMuisg
         w9Bjb2kPxFu52+/yFposkCLwVSdOVyewuzmJCFfh0RyECyrKtshnAo0f4tj8W5WjD85GCLnp6ThK
         YArsbCtQ0OnIUpxk4InlOOBlU5DWU+yp+6H4MET6owMCW5GS4klbu5L5rUVBIogSU5OWAjB06AEy
         /L21ftX+wN8TWp56R+8RuGtDTbIgJgJ/ytpYPrmssZTbqUE0uQn+Uuj39h75jjBh/Vy4nHBurU3W
         CG5qjK/26XdOFNkweFjpAWkLjbsegjVFzlkRKZo2MYJ3dSkw+ED0mzS03X/6ytGc6gfjztuTN43a
         heH+2WNCR2Dob22mlG13C+ryLkvFcpjZI3uiyOrZYggymi8gdsBKQr9AFm8iunAAb7EL8hxPf67r
         4JSlSkAXBC5w7bp3VeKqEqYEIBs6pvECunwyc1c/nR
From:   Conley Lee <conleylee@foxmail.com>
To:     maxime@cerno.tech, mripard@kernel.org, wens@csie.org,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conley Lee <conleylee@foxmail.com>
Subject: [PATCH v4 1/2] arm: dts: sun7i: Add A20-Marsboard
Date:   Sat, 15 Jan 2022 00:31:47 +0800
X-OQ-MSGID: <20220114163148.2854265-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
Change since v1.
  - Spearate biddings and dts as two patches.
  - use SPDX tag

Change since v2.
  - reformat patch
  - dual-license with GPL and MIT
  - rename dts filename to sun7i-a20-haoyu-marsboard.dts
Change since v3.
  - reformat patch
  - order dtb alphabetically
  - add gmac_txerr node and remove gmac_mii_pins node in
    sun7i-a20-marsboard.dts
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-haoyu-marsboard.dts    | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..1850ff7c9006 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1213,6 +1213,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-bananapro.dtb \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
+	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-i12-tvbox.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts b/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
new file mode 100644
index 000000000000..056dbc415de7
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>, <&gmac_txerr>;
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
+&pio {
+	gmac_txerr: gmac-txerr-pin {
+		pins = "PA17";
+		function = "gmac";
+	};
+};
+
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

