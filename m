Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4B47F035
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbhLXQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:47:17 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:43031 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236414AbhLXQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1640364433;
        bh=qsrEJxqRUFWS/DX0h7FNYqOcPEzoji39Lm5z8DMHrWE=;
        h=From:To:Cc:Subject:Date;
        b=BkgDe1+sWQ+z3VD8/sDEi0OX0A7L2D2pTenlNhS2TW1Vns7Ef8XdHjmsQemO3kbLS
         mQT4bV/8yenHZVWhVrak92RxFH+7k4gxKteSq919kuVvqEH0XPEN9MWLPXAGsV1OKl
         v5ERqgrUywN+K9KAJeQ2e0xIdB4Xq9Orhbsp1niU=
Received: from localhost.localdomain ([116.199.80.130])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id AEF0E25A; Sat, 25 Dec 2021 00:43:47 +0800
X-QQ-mid: xmsmtpt1640364227twemsygy4
Message-ID: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
X-QQ-XMAILINFO: NDi8vvHAEgriQ2sDiVntGiXMzq38xJtB0o/wLs+NnaTIBRVOyB5Wn/j31JLfSS
         NqEKtzEIAX2m4cuacevvmID7XcICvqA4+3Hc/y56fProRWLmU9PdYOFlGmpMxeYMBQ3pw/1e0MpW
         x8Yy6D/974mbxZqABTEuO1Mcez+ywXy1SJb9pl7yh69Sgn6P7aVz1XwoeHtR1+A5sfBhAHmZrgw5
         BXvv8E8vsUK8fsbeReGyVfvtvCeggxWmQS0DLS7UX8rbnHWw2CZCr7u0SYr5txldnoTK9lBIun7E
         fk8SrjIzPzfTBnSulXlc8chBmVorMiVOySlqKCeRiR6Diz3XN48RR3p82t7xIFXJ5ejKBFaTTM28
         JBSPKpikvTUQYUgN+dbQP9voWPteUl2lqW6lcmEFGnvyPFODh90TwuUTd9DCL2a3s9eb21QOsbWO
         Ir8BsQE68kl9rWpm3CTaW55kz+HhNm1LPGg6JQIzOXLFZjWJ41pcrND9N6+8XxHAPpaiVbfZ+nTW
         +nyaOH5BQLNPo92ZLHzWuwU8Qysp/5kBrplzmueek0oEwqSqg8+7Cmk81uFkSa49alFG9Kfu1Xno
         On4yddDAlzLMxzhiW3hnfALV7u26wFcPCshsKFwNnGYygILShiQawVoSZF0QGcG9dxTA/4LJ56h4
         EvDFR59Ziie3WvNjQ7RZz/cvj1j/oeKnuDUm/OZQcap6ZLMT81lHtYiHs4q3d6Mg+8PialpnBqf9
         lVKmWipUhiFfzXpq8E7+6zutdQ4nl0/AZ9OPLSNcZhpZJVKqJKuffwybY54Eik5+qEOVkodhwmLV
         QAuA5smIQx/bwU3XiX2XROMcehBRQGVHH51XCo/S6JMWZ+xW1CUUptzjt8wyi10eI=
From:   conleylee@foxmail.com
To:     mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conley Lee <conleylee@foxmail.com>
Subject: [PATCH] sun7i-a20-marsboard.dts: add marsboard-a20 support
Date:   Sat, 25 Dec 2021 00:43:41 +0800
X-OQ-MSGID: <20211224164341.17321-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conley Lee <conleylee@foxmail.com>

ARM dts: sun7i: Add Marsboard A20 board

This patch add support for Marsboard A20 board.

The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun7i-a20-marsboard.dts     | 220 ++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 889128acf49a..4bd93ae26bd1 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -444,6 +444,11 @@ properties:
           - const: haoyu,a10-marsboard
           - const: allwinner,sun4i-a10
 
+      - description: HAOYU Electronics Marsboard A20
+        items:
+          - const: haoyu,a20-marsboard
+          - const: allwinner,sun7i-a20
+
       - description: MapleBoard MP130
         items:
           - const: mapleboard,mp130
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
index 000000000000..159e69e148e7
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
@@ -0,0 +1,220 @@
+/*
+ * Copyright 2021 Conley Lee
+ * Conley Lee <conleylee@foxmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
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
2.34.1

